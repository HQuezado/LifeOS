package com.lifeos.lifeos

import android.content.Intent
import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioTrack
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.concurrent.thread
import kotlin.math.PI
import kotlin.math.sin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Canal 1: Compartilhamento nativo (Selos de Gratidão — Fase 7)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.lifeos.lifeos/share"
        ).setMethodCallHandler { call, result ->
            if (call.method == "shareText") {
                val text = call.argument<String>("text") ?: ""
                val subject = call.argument<String>("subject") ?: "LifeOS — Selo de Gratidão"
                val intent = Intent(Intent.ACTION_SEND).apply {
                    type = "text/plain"
                    putExtra(Intent.EXTRA_SUBJECT, subject)
                    putExtra(Intent.EXTRA_TEXT, text)
                }
                startActivity(Intent.createChooser(intent, "Enviar Selo de Gratidão"))
                result.success(true)
            } else {
                result.notImplemented()
            }
        }

        // Canal 2: Sintetizador 16-bit Chiptune leve (zero arquivos pesados, 100% offline)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.lifeos.lifeos/sfx"
        ).setMethodCallHandler { call, result ->
            if (call.method == "play") {
                val effect = call.argument<String>("effect") ?: "hit"
                playChiptuneEffect(effect)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun playChiptuneEffect(effect: String) {
        thread(isDaemon = true) {
            try {
                val notes: List<Triple<Double, Double, Int>> = when (effect) {
                    "step" -> listOf(Triple(150.0, 120.0, 28))
                    "hit" -> listOf(Triple(260.0, 110.0, 65))
                    "crit" -> listOf(
                        Triple(523.25, 587.33, 55),
                        Triple(783.99, 1046.50, 95)
                    )
                    "hurt" -> listOf(
                        Triple(190.0, 95.0, 90),
                        Triple(110.0, 65.0, 70)
                    )
                    "dodge" -> listOf(Triple(420.0, 720.0, 60))
                    "skill" -> listOf(
                        Triple(392.0, 493.88, 55),
                        Triple(587.33, 783.99, 75),
                        Triple(987.77, 1174.66, 95)
                    )
                    "potion" -> listOf(
                        Triple(330.0, 440.0, 55),
                        Triple(440.0, 660.0, 75)
                    )
                    "chest", "victory" -> listOf(
                        Triple(523.25, 523.25, 70),
                        Triple(659.25, 659.25, 70),
                        Triple(783.99, 783.99, 80),
                        Triple(1046.50, 1046.50, 160)
                    )
                    "stairs" -> listOf(
                        Triple(440.0, 392.0, 65),
                        Triple(330.0, 262.0, 95)
                    )
                    else -> listOf(Triple(320.0, 240.0, 55))
                }

                val sampleRate = 22050
                val totalSamples = notes.sumOf { (sampleRate * it.third) / 1000 }
                val pcm = ShortArray(totalSamples)
                var cursor = 0
                val volume = 0.22 // volume confortável 16-bit

                for ((startFreq, endFreq, durMs) in notes) {
                    val count = (sampleRate * durMs) / 1000
                    var phase = 0.0
                    for (i in 0 until count) {
                        if (cursor >= totalSamples) break
                        val t = i.toDouble() / count.coerceAtLeast(1)
                        val freq = startFreq + (endFreq - startFreq) * t
                        phase += 2.0 * PI * freq / sampleRate
                        // Onda quadrada suavizada (som clássico 16-bit sem estalo)
                        val env = (1.0 - t * 0.82) * (if (i < 40) i / 40.0 else 1.0)
                        val rawSquare = if (sin(phase) >= 0.0) 1.0 else -1.0
                        val blended = rawSquare * 0.65 + sin(phase) * 0.35
                        pcm[cursor++] = (blended * env * volume * Short.MAX_VALUE).toInt().toShort()
                    }
                }

                val track = AudioTrack.Builder()
                    .setAudioAttributes(
                        AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_GAME)
                            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            .build()
                    )
                    .setAudioFormat(
                        AudioFormat.Builder()
                            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                            .setSampleRate(sampleRate)
                            .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                            .build()
                    )
                    .setBufferSizeInBytes(pcm.size * 2)
                    .setTransferMode(AudioTrack.MODE_STATIC)
                    .build()

                track.write(pcm, 0, pcm.size)
                track.play()
                val sleepMs = (totalSamples * 1000L / sampleRate) + 40L
                Thread.sleep(sleepMs)
                track.stop()
                track.release()
            } catch (_: Throwable) {
                // Ignora silenciosamente se o emulador/dispositivo não tiver áudio disponível
            }
        }
    }
}
