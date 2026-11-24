import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';

/// Guia rápido de utilização do LifeOS, escrito em linguagem natural e direta.
class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GUIA DO AVENTUREIRO')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          // Abertura narrativa
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BEM-VINDO AO LIFE OS',
                  style: LifeOsTheme.pixelTitle(
                    size: 11,
                    color: LifeOsColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'A vida pode ser uma sequência de batalhas travadas no silêncio de um dia comum. Levantar no horário, responder aquela mensagem adiada, sentar para estudar, cuidar do corpo ou apenas não se perder no tempo. Tudo isso consome energia de verdade.\n\n'
                  'O LifeOS existe para dar forma e recompensa a essas vitórias. Aqui não tem punição por errar nem conta online obrigatória: seu progresso fica salvo no seu celular, e cada passo real faz o seu personagem crescer com você.',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: LifeOsColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Tarefas, Agenda e Passos
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TAREFAS, AGENDA E PASSOS',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.xpBar,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Na aba Hoje fica o centro da sua rotina:\n\n'
                  '• Atividades: cadastre o que você precisa fazer, escolha o atributo e a dificuldade (Micro, Fácil, Média ou Difícil). Se quiser mudar depois, basta tocar na tag do atributo ou na dificuldade direto no card.\n\n'
                  '• Mapa do Dia: mostra seus compromissos do Google Agenda (ou marcos manuais) e o tempo livre entre eles. O cumprimento é sempre manual: marque quando fizer para ganhar XP e Ouro.\n\n'
                  '• Modo Energia (1x por semana): para dias pesados. Quando ativado, dobra o Ouro das micro-vitórias sem cobrar ritmo pesado.\n\n'
                  '• Missão Relâmpago: dá 15 minutos para você matar qualquer tarefa por Ouro extra. Depois de usar, o botão recarrega ao longo de 1 hora.\n\n'
                  '• Passos e Sidequests: ative o contador de passos para transformar sua caminhada em encontros aleatórios. A cada 1.000 passos surge uma missão curtinha com recompensa rápida.',
                  style: TextStyle(
                    fontSize: 13.2,
                    color: LifeOsColors.textSecondary,
                    height: 1.48,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Os 5 Atributos
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OS 5 ATRIBUTOS',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.gold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Seus atributos sobem conforme você conclui atividades ligadas a cada área:',
                  style: TextStyle(
                    fontSize: 13,
                    color: LifeOsColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                ...RpgAttribute.values.map(
                  (attr) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(attr.icon, color: attr.color, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 13,
                                color: LifeOsColors.textSecondary,
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: '${attr.name} (${attr.shortName}): ',
                                  style: TextStyle(
                                    color: attr.color,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(text: '${attr.description} '),
                                TextSpan(
                                  text: '(${attr.mechanicalBonus}).',
                                  style: const TextStyle(
                                    color: LifeOsColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Seu Personagem
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SEU PERSONAGEM',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Na aba Herói você acompanha seu Nível Geral, o nível individual de cada um dos 5 atributos e o seu Ouro.\n\n'
                  'Cada classe tem uma passiva e uma habilidade própria ligada ao seu atributo paralelo, mas você nunca fica preso à escolha inicial: dá para trocar a cor da armadura ou do manto quando quiser ali mesmo na ficha, e também mudar de classe usando o Pergaminho de Reclasse na Loja.\n\n'
                  'Quando você dá sorte em uma tarefa, sobe de marco de nível ou vence um encontro raro, pode ganhar Baús Misteriosos — eles ficam esperando na aba Herói para você abrir.',
                  style: TextStyle(
                    fontSize: 13.2,
                    color: LifeOsColors.textSecondary,
                    height: 1.48,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // A Loja
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A LOJA',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Todo o Ouro conquistado no dia a dia pode ser gasto na Loja, dividida em três partes:\n\n'
                  '• Móveis: vão direto para a sua Casa e dão bônus permanentes de XP, Ouro ou Crítico.\n'
                  '• Equipamentos: armas, visuais, pets companheiros e novos cenários para o interior da Casa.\n'
                  '• Consumíveis: Poção de Foco (+25% XP por 1 hora), Baús Misteriosos e o Pergaminho de Reclasse.\n\n'
                  'Quanto maior o seu Carisma (ou se você jogar de Bardo), maior o desconto automático em toda a Loja.',
                  style: TextStyle(
                    fontSize: 13.2,
                    color: LifeOsColors.textSecondary,
                    height: 1.48,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // A Casa
          PixelPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A CASA',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'A Casa é o refúgio do seu personagem. Você começa na Cabana Inicial e ela evolui de título conforme você sobe de nível (Casa de Madeira no Nv. 5, Mansão do Aventureiro no Nv. 10 e Santuário Lendário no Nv. 20).\n\n'
                  'Você pode trocar o visual do cenário comprando ambientes novos na Loja (como a Taverna, a Torre Arcana ou a Estufa) e acompanhar ali todos os móveis comprados e os bônus passivos que estão ativos na sua conta.',
                  style: TextStyle(
                    fontSize: 13.2,
                    color: LifeOsColors.textSecondary,
                    height: 1.48,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

