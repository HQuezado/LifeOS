import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../repositories/hero_repository.dart';

class StepSidequest {
  const StepSidequest({
    required this.enemyName,
    required this.questTitle,
    required this.attribute,
    this.rewardXp = 40,
    this.rewardGold = 30,
  });

  final String enemyName;
  final String questTitle;
  final RpgAttribute attribute;
  final int rewardXp;
  final int rewardGold;
}

/// Serviço de Pedômetro + Encontros Aleatórios (Sidequests via Notificação).
/// A cada 1.000 passos caminhados, dispara uma notificação estilo RPG e gera uma Sidequest!
class StepEncounterService {
  StepEncounterService(this._heroRepository);

  final HeroRepository _heroRepository;
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const int stepsPerEncounter = 1000;

  static const List<StepSidequest> _sidequestPool = [
    StepSidequest(
      enemyName: 'Slime da Sede',
      questTitle: 'Beba 1 copo cheio de água agora',
      attribute: RpgAttribute.vigor,
    ),
    StepSidequest(
      enemyName: 'Goblin da Postura',
      questTitle: 'Alongue ombros e pescoço por 2 minutos',
      attribute: RpgAttribute.vigor,
    ),
    StepSidequest(
      enemyName: 'Bardo Viajante',
      questTitle: 'Envie uma mensagem curta para alguém querido',
      attribute: RpgAttribute.charisma,
    ),
    StepSidequest(
      enemyName: 'Mago da Calma',
      questTitle: 'Faça 5 respirações profundas longe da tela',
      attribute: RpgAttribute.wisdom,
    ),
    StepSidequest(
      enemyName: 'Ladino da Bagunça',
      questTitle: 'Guarde 3 objetos fora do lugar ao seu redor',
      attribute: RpgAttribute.dexterity,
    ),
    StepSidequest(
      enemyName: 'Coruja Sábia',
      questTitle: 'Anote 1 ideia ou revisão rápida do seu dia',
      attribute: RpgAttribute.intellect,
    ),
  ];

  bool _notificationsReady = false;
  StreamSubscription<StepCount>? _stepSub;
  int? _sessionBaseSensorSteps;
  int _persistedBaseSteps = 0;

  final _activeEncounterController =
      StreamController<StepSidequest?>.broadcast();
  StepSidequest? _activeEncounter;

  Stream<StepSidequest?> get activeEncounterStream =>
      _activeEncounterController.stream;
  StepSidequest? get activeEncounter => _activeEncounter;
  bool get isListening => _stepSub != null;

  Future<void> _initNotifications() async {
    if (_notificationsReady) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);
    await _notifications.initialize(settings: settings);
    _notificationsReady = true;
  }

  /// Solicita permissões (Atividade Física + Notificações) e inicia o pedômetro.
  Future<({bool ok, String message})> startPedometer() async {
    try {
      await _initNotifications();
      final activityStatus = await Permission.activityRecognition.request();
      await Permission.notification.request();

      if (!activityStatus.isGranted) {
        return (
          ok: false,
          message: 'Permita "Atividade Física" para contar seus passos.',
        );
      }

      final hero = await _heroRepository.getHero();
      _persistedBaseSteps = hero?.stepsToday ?? 0;
      _sessionBaseSensorSteps = null;

      await _stepSub?.cancel();
      _stepSub = Pedometer.stepCountStream.listen(
        (event) => _onSensorSteps(event.steps),
        onError: (_) {},
      );

      return (ok: true, message: 'Pedômetro ativo! Caminhe para achar encontros.');
    } catch (e) {
      return (
        ok: false,
        message: 'Sensor de passos indisponível neste aparelho.',
      );
    }
  }

  Future<void> _onSensorSteps(int sensorTotal) async {
    _sessionBaseSensorSteps ??= sensorTotal;
    final delta = (sensorTotal - _sessionBaseSensorSteps!).clamp(0, 100000);
    final totalToday = _persistedBaseSteps + delta;
    await _applySteps(totalToday);
  }

  /// Adiciona passos manualmente (útil para testar encontros ou registrar caminhada).
  Future<void> addDemoSteps(int amount) async {
    await _initNotifications();
    final hero = await _heroRepository.getHero();
    final current = hero?.stepsToday ?? 0;
    await _applySteps(current + amount);
  }

  Future<void> _applySteps(int totalToday) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) return;

    final currentMilestone = totalToday ~/ stepsPerEncounter;
    if (currentMilestone > hero.lastEncounterStepMilestone) {
      await _heroRepository.updateSteps(
        stepsToday: totalToday,
        lastMilestone: currentMilestone,
      );
      await _triggerRandomEncounter(totalToday);
    } else {
      await _heroRepository.updateSteps(stepsToday: totalToday);
    }
  }

  Future<void> _triggerRandomEncounter(int totalSteps) async {
    final quest = _sidequestPool[Random().nextInt(_sidequestPool.length)];
    _activeEncounter = quest;
    _activeEncounterController.add(quest);

    try {
      await _initNotifications();
      const androidDetails = AndroidNotificationDetails(
        'lifeos_encounters',
        'Encontros na Trilha',
        channelDescription:
            'Sidequests aleatórias disparadas pelos seus passos no LifeOS.',
        importance: Importance.high,
        priority: Priority.high,
      );
      await _notifications.show(
        id: 1001,
        title: '⚔️ ${quest.enemyName} apareceu! ($totalSteps passos)',
        body: 'Sidequest: ${quest.questTitle} (+${quest.rewardXp} XP / +${quest.rewardGold}g)',
        notificationDetails: const NotificationDetails(android: androidDetails),
      );
    } catch (_) {}
  }

  /// Conclui a Sidequest ativa e concede XP, Ouro e chance de Baú!
  Future<RewardOutcome?> completeActiveEncounter() async {
    final quest = _activeEncounter;
    if (quest == null) return null;

    _activeEncounter = null;
    _activeEncounterController.add(null);

    final dropChest = Random().nextDouble() < 0.25 ? ChestRarity.common : null;
    final progress = await _heroRepository.awardProgress(
      attribute: quest.attribute,
      xpGained: quest.rewardXp,
      goldGained: quest.rewardGold,
      droppedChest: dropChest,
      chestSource: 'Encontro: ${quest.enemyName}',
    );

    return RewardOutcome(
      xpGained: quest.rewardXp,
      goldGained: quest.rewardGold,
      isCritical: false,
      criticalMultiplier: 1.0,
      droppedChest: dropChest,
      showMicroTaskGentleReminder: false,
      classBonusNotes: ['Sidequest concluída: ${quest.enemyName}'],
      heroLeveledUp: progress.heroLeveledUp,
      attributeLeveledUp: progress.attributeLeveledUp,
    );
  }

  void dispose() {
    _stepSub?.cancel();
    _activeEncounterController.close();
  }
}

