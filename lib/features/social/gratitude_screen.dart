import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/dungeon/dungeon_models.dart';
import '../../core/social/gratitude_seal.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';

/// Tela da Fase 7 — Gratidão entre Aventureiros (Enviar Selo, Resgatar Selo e Mural).
class GratitudeScreen extends ConsumerStatefulWidget {
  const GratitudeScreen({super.key});

  @override
  ConsumerState<GratitudeScreen> createState() => _GratitudeScreenState();
}

class _GratitudeScreenState extends ConsumerState<GratitudeScreen> {
  static const _shareChannel = MethodChannel('com.lifeos.lifeos/share');

  int _tab = 0; // 0: Enviar, 1: Resgatar, 2: Mural
  final _noteController = TextEditingController();
  final _redeemController = TextEditingController();
  int _goldGift = 0;
  String? _selectedItemId;
  bool _busy = false;

  @override
  void dispose() {
    _noteController.dispose();
    _redeemController.dispose();
    super.dispose();
  }

  Future<void> _shareText(String text) async {
    try {
      await _shareChannel.invokeMethod<bool>('shareText', {
        'text': text,
        'subject': 'LifeOS — Selo de Gratidão',
      });
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: text));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mensagem copiada para a área de transferência!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hero = ref.watch(heroProfileProvider).value;
    final logs = ref.watch(gratitudeLogsProvider).value ?? const [];
    final inventoryRows = ref.watch(dungeonInventoryProvider).value ?? const [];
    final catalog = ref.watch(dungeonCatalogProvider).value;

    if (hero == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('GRATIDÃO')),
        body: const Center(child: CircularProgressIndicator(color: LifeOsColors.gold)),
      );
    }

    final sendCheck = GratitudeSealCodec.canSend(
      heroLevel: hero.level,
      sentCount: hero.gratitudeSentCount,
      lastSentLevel: hero.lastGratitudeSentLevel,
    );
    final receiveCheck = GratitudeSealCodec.canReceive(
      heroLevel: hero.level,
      receivedCount: hero.gratitudeReceivedCount,
      lastReceivedLevel: hero.lastGratitudeReceivedLevel,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('GRATIDÃO')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: _buildLimitsHeader(hero, sendCheck.allowed, receiveCheck.allowed),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildTabStrip(logs.length),
          ),
          Expanded(
            child: IndexedStack(
              index: _tab,
              children: [
                _buildSendTab(
                  hero: hero,
                  sendCheck: sendCheck,
                  inventoryRows: inventoryRows,
                  catalog: catalog,
                ),
                _buildRedeemTab(hero: hero, receiveCheck: receiveCheck),
                _buildWallTab(logs),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitsHeader(
    HeroProfile hero,
    bool canSendNow,
    bool canReceiveNow,
  ) {
    return PixelPanel(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BOAS AÇÕES NA VIDA REAL',
            style: LifeOsTheme.pixelTitle(size: 9.5, color: LifeOsColors.gold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Agradeça quem te ajudou com XP (sem descontar do seu personagem), Ouro ou 1 item. Limite: 1x por nível, até 5 vezes.',
            style: TextStyle(
              fontSize: 12,
              color: LifeOsColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _SealQuotaRow(
                  label: 'ENVIADOS',
                  used: hero.gratitudeSentCount,
                  readyNow: canSendNow,
                  nextLevel: hero.level + 1,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SealQuotaRow(
                  label: 'RECEBIDOS',
                  used: hero.gratitudeReceivedCount,
                  readyNow: canReceiveNow,
                  nextLevel: hero.level + 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabStrip(int logCount) {
    final labels = ['ENVIAR', 'RESGATAR', 'MURAL ($logCount)'];
    return Row(
      children: List.generate(labels.length, (i) {
        final active = _tab == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _tab = i),
            child: Container(
              margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: active ? LifeOsColors.surfaceHighlight : LifeOsColors.surface,
                border: Border.all(
                  color: active ? LifeOsColors.gold : LifeOsColors.border,
                  width: active ? 2 : 1.5,
                ),
              ),
              child: Text(
                labels[i],
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(
                  size: 8.5,
                  color: active ? LifeOsColors.gold : LifeOsColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSendTab({
    required HeroProfile hero,
    required ({bool allowed, String reason}) sendCheck,
    required List<DungeonInventoryData> inventoryRows,
    required dynamic catalog,
  }) {
    final xpBlessing = GratitudeSealCodec.systemBlessingXpForLevel(hero.level);
    final maxGold = min(hero.gold, GratitudeSealCodec.maxGoldGift);
    if (_goldGift > maxGold) _goldGift = maxGold;

    // Itens elegíveis para presentear (consumíveis ou equipamentos não equipados / excedentes)
    final giftableItems = <DungeonItem>[];
    if (catalog != null) {
      for (final row in inventoryRows) {
        if (row.quantity <= 0) continue;
        if (row.isEquipped && row.quantity <= 1) continue;
        final item = catalog.itemById(row.itemId) as DungeonItem?;
        if (item != null) giftableItems.add(item);
      }
    }

    DungeonItem? chosenItem;
    if (_selectedItemId != null) {
      for (final item in giftableItems) {
        if (item.id == _selectedItemId) {
          chosenItem = item;
          break;
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      children: [
        if (!sendCheck.allowed) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: LifeOsColors.surfaceHighlight,
              border: Border.all(color: LifeOsColors.goldDark, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_clock_rounded, color: LifeOsColors.gold),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    sendCheck.reason,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: LifeOsColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        PixelPanel(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bênção de XP gratuita
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: LifeOsColors.bgDark,
                  border: Border.all(color: LifeOsColors.xpBar),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded, color: LifeOsColors.xpBar),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BÊNÇÃO INCLUSA: +$xpBlessing XP (CAR)',
                            style: LifeOsTheme.pixelTitle(
                              size: 8.5,
                              color: LifeOsColors.xpBar,
                            ),
                          ),
                          const Text(
                            'Gerada pelo sistema — não sai do seu personagem!',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: LifeOsColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _noteController,
                maxLength: 90,
                decoration: const InputDecoration(
                  labelText: 'Qual boa ação você quer agradecer?',
                  hintText: 'Ex.: Obrigado por me ajudar na mudança!',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const PixelIcon('assets/images/ui/icon_coin.png', size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Ouro opcional (sai do seu saldo): $_goldGift / ${hero.gold}g',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: LifeOsColors.gold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: [0, 25, 50, 100, 200]
                    .where((v) => v <= maxGold)
                    .map(
                      (amount) => ChoiceChip(
                        label: Text(amount == 0 ? 'Sem ouro' : '+${amount}g'),
                        selected: _goldGift == amount,
                        onSelected: sendCheck.allowed
                            ? (_) => setState(() => _goldGift = amount)
                            : null,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              const Text(
                'Item opcional da mochila (sai da sua mochila):',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: LifeOsColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              if (giftableItems.isEmpty)
                const Text(
                  'Nenhum item extra na mochila (itens equipados não podem ser enviados).',
                  style: TextStyle(fontSize: 11.5, color: LifeOsColors.textMuted),
                )
              else
                SizedBox(
                  height: 54,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: giftableItems.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(width: 6),
                    itemBuilder: (_, i) {
                      if (i == 0) {
                        final noneSelected = _selectedItemId == null;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedItemId = null),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: LifeOsColors.bgDark,
                              border: Border.all(
                                color: noneSelected
                                    ? LifeOsColors.gold
                                    : LifeOsColors.border,
                                width: noneSelected ? 2 : 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Nenhum',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      final item = giftableItems[i - 1];
                      final selected = _selectedItemId == item.id;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedItemId = item.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: LifeOsColors.bgDark,
                            border: Border.all(
                              color: selected ? LifeOsColors.gold : item.rarity.color,
                              width: selected ? 2 : 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PixelIcon(item.iconAsset, size: 30),
                              const SizedBox(width: 6),
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: item.rarity.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              PixelButton(
                label: 'GERAR SELO DE GRATIDÃO',
                isLoading: _busy,
                onPressed: sendCheck.allowed && !_busy
                    ? () => _onCreateSeal(chosenItem)
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onCreateSeal(DungeonItem? chosenItem) async {
    setState(() => _busy = true);
    final res = await ref.read(gratitudeRepositoryProvider).createGratitudeSeal(
          note: _noteController.text,
          goldGift: _goldGift,
          itemGift: chosenItem,
        );
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (res.ok) {
        _noteController.clear();
        _goldGift = 0;
        _selectedItemId = null;
      }
    });

    if (!res.ok) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message)));
      return;
    }

    await _showSealShareDialog(
      sealCode: res.sealCode!,
      shareMessage: res.shareMessage!,
    );
  }

  Future<void> _showSealShareDialog({
    required String sealCode,
    required String shareMessage,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite_rounded, color: LifeOsColors.gold, size: 38),
              const SizedBox(height: 8),
              Text(
                'SELO PRONTO!',
                style: LifeOsTheme.pixelTitle(size: 11, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Envie a mensagem pelo WhatsApp ou copie o código para o amigo resgatar no LifeOS:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: LifeOsColors.textSecondary),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: LifeOsColors.bgDark,
                  border: Border.all(color: LifeOsColors.border),
                ),
                child: SelectableText(
                  sealCode,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: LifeOsColors.xpBar,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PixelButton(
                label: 'COMPARTILHAR (WHATSAPP)',
                onPressed: () => _shareText(shareMessage),
              ),
              const SizedBox(height: 8),
              PixelButton(
                label: 'COPIAR MENSAGEM',
                backgroundColor: LifeOsColors.surfaceHighlight,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: shareMessage));
                  if (ctx.mounted) {
                    Navigator.of(ctx).pop();
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Selo copiado! Pode colar no WhatsApp.'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedeemTab({
    required HeroProfile hero,
    required ({bool allowed, String reason}) receiveCheck,
  }) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      children: [
        if (!receiveCheck.allowed) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: LifeOsColors.surfaceHighlight,
              border: Border.all(color: LifeOsColors.goldDark, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_clock_rounded, color: LifeOsColors.gold),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    receiveCheck.reason,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: LifeOsColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        PixelPanel(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESGATAR SELO RECEBIDO',
                style: LifeOsTheme.pixelTitle(size: 9.5, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Cole o código (ou a mensagem inteira do WhatsApp) que seu amigo enviou:',
                style: TextStyle(fontSize: 12.5, color: LifeOsColors.textSecondary),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _redeemController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'LIFEOS-GRAT-...',
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    final clip = await Clipboard.getData('text/plain');
                    if (clip?.text != null && mounted) {
                      setState(() => _redeemController.text = clip!.text!);
                    }
                  },
                  icon: const Icon(Icons.content_paste_rounded, size: 16),
                  label: const Text('Colar da área de transferência'),
                ),
              ),
              const SizedBox(height: 8),
              PixelButton(
                label: 'RESGATAR PRESENTE',
                isLoading: _busy,
                onPressed: receiveCheck.allowed && !_busy ? _onRedeemSeal : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onRedeemSeal() async {
    final text = _redeemController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cole o código do Selo primeiro.')),
      );
      return;
    }

    setState(() => _busy = true);
    final res =
        await ref.read(gratitudeRepositoryProvider).redeemGratitudeSeal(text);
    if (!mounted) return;
    setState(() => _busy = false);

    if (!res.ok) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message)));
      return;
    }

    _redeemController.clear();
    await showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome_rounded, color: LifeOsColors.gold, size: 42),
              const SizedBox(height: 8),
              Text(
                'GRATIDÃO RECEBIDA!',
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(size: 11, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 8),
              Text(
                '${res.senderName} agradeceu sua boa ação!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: LifeOsColors.textPrimary,
                ),
              ),
              if (res.note != null && res.note!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: LifeOsColors.bgDark,
                    border: Border.all(color: LifeOsColors.border),
                  ),
                  child: Text(
                    '"${res.note}"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: LifeOsColors.textSecondary,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                '+${res.xpGained} XP (CAR)${res.goldGained > 0 ? '  •  +${res.goldGained} Ouro' : ''}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: LifeOsColors.xpBar,
                ),
              ),
              if (res.itemReceived != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PixelIcon(res.itemReceived!.iconAsset, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      res.itemReceived!.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: res.itemReceived!.rarity.color,
                      ),
                    ),
                  ],
                ),
              ],
              if (res.heroLeveledUp) ...[
                const SizedBox(height: 8),
                const Text(
                  '★ LEVEL UP! +50 Ouro extra!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: LifeOsColors.gold,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              PixelButton(
                label: 'ACEITAR COM ORGULHO',
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWallTab(List<GratitudeLog> logs) {
    if (logs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Nenhuma boa ação registrada ainda.\nEnvie ou resgate um Selo de Gratidão para iniciar seu mural!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: LifeOsColors.textMuted, height: 1.45),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
      itemCount: logs.length,
      itemBuilder: (_, i) {
        final log = logs[i];
        final isSent = log.direction == 'sent';
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: LifeOsColors.surface,
            border: Border.all(
              color: isSent ? LifeOsColors.goldDark : LifeOsColors.success,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isSent ? Icons.send_rounded : Icons.favorite_rounded,
                    size: 16,
                    color: isSent ? LifeOsColors.gold : LifeOsColors.success,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      isSent
                          ? 'Selo enviado'
                          : 'Recebido de ${log.peerName}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: isSent ? LifeOsColors.gold : LifeOsColors.success,
                      ),
                    ),
                  ),
                  if (isSent)
                    TextButton(
                      onPressed: () => _shareText(log.sealCode),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        minimumSize: Size.zero,
                      ),
                      child: const Text('Reenviar', style: TextStyle(fontSize: 11.5)),
                    ),
                ],
              ),
              if (log.note.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '"${log.note}"',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    color: LifeOsColors.textPrimary,
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                '+${log.xpAmount} XP'
                '${log.goldAmount > 0 ? ' • +${log.goldAmount}g' : ''}'
                '${log.itemName != null ? ' • ${log.itemName}' : ''}',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: LifeOsColors.xpBar,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SealQuotaRow extends StatelessWidget {
  const _SealQuotaRow({
    required this.label,
    required this.used,
    required this.readyNow,
    required this.nextLevel,
  });

  final String label;
  final int used;
  final bool readyNow;
  final int nextLevel;

  @override
  Widget build(BuildContext context) {
    final maxUses = GratitudeSealCodec.maxUsesPerHero;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(
          color: readyNow ? LifeOsColors.gold : LifeOsColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ($used/$maxUses)',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: LifeOsColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              maxUses,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Icon(
                  i < used ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 14,
                  color: i < used ? LifeOsColors.gold : LifeOsColors.textMuted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            used >= maxUses
                ? 'Limite concluído'
                : (readyNow ? 'Liberado agora!' : 'Libera no Nv. $nextLevel'),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: readyNow ? LifeOsColors.success : LifeOsColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
