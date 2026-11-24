# LifeOS — Game Design & Arquitetura Técnica

**Plataforma:** Android  
**Stack:** Flutter (Dart) — 100% Local-First (sem conta própria, sem servidor/banco remoto)  
**Integrações:** Google Agenda (Calendar API v3) e Google Tasks (Tasks API v1) via OAuth direto no dispositivo  
**Estilo Visual:** Pixel Art 16-bit (`FilterQuality.none` para renderização pixel-perfect)

---

## 1. Visão do Produto

O **LifeOS** é um life tracker com temática de RPG projetado especificamente para o funcionamento do cérebro com **TDAH**. Em vez de punir o usuário por falhas ou oferecer recompensas previsíveis que perdem a graça em duas semanas, o LifeOS transforma a rotina real em uma jornada adaptativa com foco em **vencer a paralisia executiva**, **combater a cegueira temporal** e **sustentar dopamina saudável**.

---

## 2. Sistema de RPG

### Classes Iniciais (1:1 com os Atributos)
Cada classe começa com afinidade no seu atributo principal, **1 Passiva** e **1 Habilidade Especial**. O usuário pode trocar de classe depois na loja (*Pergaminho de Reclasse*) sem perder nível nem progresso.

1. **Guerreiro** *(Atributo: Vigor — VIG)*
   - **Passiva:** `+15%` Ouro/XP em hábitos diários e tarefas físicas/de saúde.
   - **Habilidade (*Golpe Constante*):** Concluir 3 tarefas no mesmo dia concede um bônus extra de Ouro.
2. **Mago** *(Atributo: Intelecto — INT)*
   - **Passiva:** `+15%` XP em inimigos de **Raid** e blocos de foco do Mapa do Dia.
   - **Habilidade (*Explosão Arcana*):** Ao derrotar o último inimigo de uma Raid, aumenta a chance do Baú de Raid subir de raridade.
3. **Ladino** *(Atributo: Destreza — DES)*
   - **Passiva:** `+8%` de chance base de **Acerto Crítico** em qualquer tarefa e `+20%` Ouro em Missões Relâmpago.
   - **Habilidade (*Saque Rápido*):** Concluir uma tarefa atrasada do Google Tasks dá bônus extra de Ouro.
4. **Alquimista** *(Atributo: Sabedoria — SAB)*
   - **Passiva:** Móveis da **Casa Viva** têm `+20%` de eficácia nas passivas e `+15%` XP em autocuidado/sono/finanças.
   - **Habilidade (*Elixir da Calma*):** No **Modo Energia (1x/semana)**, concluir 3 micro-vitórias garante 1 Baú Comum extra.
5. **Bardo** *(Atributo: Carisma — CAR)*
   - **Passiva:** `+15%` Ouro/XP em tarefas sociais e `10%` de desconto permanente na Loja.
   - **Habilidade (*Inspiração do Bardo*):** Concluir uma tarefa de Carisma dá `+25%` de XP na próxima tarefa de qualquer outro atributo.

### Atributos (5 pilares — evoluem por atividade)
O usuário cadastra suas atividades/tarefas vinculadas a um atributo (ou escolhe o atributo ao sincronizar do Google Tasks). Cada tarefa concluída aprimora diretamente o atributo correspondente:

- **Vigor (VIG):** Saúde, exercícios, água, rotina física. *Efeito:* bônus em hábitos diários e resistência em dias cheios.
- **Intelecto (INT):** Estudo, trabalho focado, leitura, projetos. *Efeito:* bônus de XP em Raids e sessões de foco.
- **Destreza (DES):** Tarefas práticas, organização, burocracias rápidas. *Efeito:* aumenta a chance de Acerto Crítico e ganhos em Missões Relâmpago.
- **Sabedoria (SAB):** Sono, autocuidado, lazer consciente, finanças. *Efeito:* aumenta a sorte de Baús e potencializa as passivas da Casa Viva.
- **Carisma (CAR):** Tarefas sociais (conversar com um desconhecido, apresentar um trabalho, conseguir uma venda, responder uma mensagem, networking). *Efeito:* aumenta o Ouro ganho e concede descontos progressivos na Loja.

### Progressão de XP e Recompensas (Nível Geral + Nível por Atributo)
O personagem evolui em duas frentes paralelas: **Nível Geral** (sobe com qualquer tarefa) e **Nível de Atributo** (sobe com tarefas daquele atributo específico).

#### Tabela Base de Recompensas
| Tipo / Dificuldade | Exemplos | XP Base (Geral + Atributo) | Ouro Base |
| :--- | :--- | :---: | :---: |
| **Micro** | Beber água, responder 1 msg, arrumar a cama | `15 XP` | `10` |
| **Fácil** | Ler 10 págs, organizar mesa, caminhar 15 min | `30 XP` | `20` |
| **Média** | Treino completo, estudar 1h, apresentar trabalho | `60 XP` | `40` |
| **Difícil** | Entregar projeto, fechar uma venda, tarefa travada | `100 XP` | `70` |
| **Inimigo de Raid** | Cada micro-passo (2–15 min) dentro de uma Raid | `25 XP` | `18` |
| **Vitória da Raid** | Bônus ao derrotar o último inimigo da Raid | `+80 XP` | `+60` + **Baú** |

#### Curva Linear Constante (Anti-Frustração)
- **Nível do Personagem:** `XP necessário = 100 + (Nível - 1) * 50` *(Nv 1→2: 100 XP; Nv 10→11: 550 XP)*
- **Nível de Atributo:** `XP necessário = 60 + (Nível do Atributo - 1) * 30` *(Nv 1→2: 60 XP; Nv 10→11: 330 XP)*

#### Recompensas de Level Up & Regra das Micro-Tarefas
- **Level Up Geral:** `+50 Ouro` e, a cada 5 níveis (5, 10, 15...), **1 Baú Raro/Épico** + desbloqueio de novos itens/expansões da Casa.
- **Level Up de Atributo:** aumenta progressivamente o bônus passivo daquele atributo (ex.: `+0.5%` Crítico por nível de DES, `+1%` desconto na Loja por nível de CAR com teto de equilíbrio, `+2%` XP em Raids por nível de INT, etc.).
- **Micro-Tarefas Livres (com incentivo gentil):** Sem bloqueio rígido. A partir da **11ª micro-tarefa no mesmo dia**, o app exibe uma recomendação amigável incentivando tarefas maiores ou Raids e reduz o XP das micro-tarefas extras (ex.: `50%` do XP), *exceto quando o Modo Energia estiver ativo*.

---

## 3. Mecânicas Diferenciais (Foco em TDAH)

### 3.1. Sistema de Raids (Tarefas Complexas)
Em vez de encarar uma tarefa grande e assustadora, o usuário converte qualquer tarefa complexa em uma **Raid** com vários inimigos:
- Cada micro-passo (2 a 15 minutos) vira um **inimigo / onda** dentro da masmorra.
- Derrotar cada inimigo gera feedback visual imediato, XP e Ouro na hora (quebrando a paralisia de início).
- Limpar todos os inimigos da Raid concede um **Baú de Raid** com recompensas raras.

### 3.2. Modo Energia / Dia Sem Culpa (Limite: 1x por semana)
Para dias de baixa bateria mental/executivo travado:
- Pode ser ativado **até 1 vez a cada 7 dias** (cooldown semanal visível).
- Reduz a pressão do dia sem punir o progresso.
- Dobra o Ouro de micro-vitórias básicas (beber água, higiene, responder 1 mensagem, 1 tarefa mínima) para manter o hábito vivo sem culpa.

### 3.3. Mapa do Dia (Google Agenda + Google Tasks)
Combate a cegueira temporal transformando o dia em uma **trilha de expedição visual**:
- Eventos do **Google Agenda** aparecem como marcos na linha do tempo com contagem regressiva clara até o próximo compromisso.
- Intervalos livres entre eventos viram **Zonas de Exploração**, onde o usuário pode encaixar tarefas do **Google Tasks** ou sessões de foco.

### 3.4. Loja & Casa Viva em Pixel Art
O Ouro ganho nas vitórias é gasto na loja interna (3 categorias):
- **Móveis da Casa (com passivas reais — `150` a `1.200 Ouro`):** 1 linha por atributo/mecânica (*Horta* para VIG, *Escrivaninha Arcana* para INT, *Bancada de Ferramentas* para DES, *Lareira* para SAB/Modo Energia, *Mesa de Taverna* para CAR).
- **Equipamentos & Pets (`100` a `800 Ouro`):** Armas, armaduras, capas/chapéus e pets visíveis no personagem.
- **Consumíveis & Utilidades (`80` a `500 Ouro`):** *Poção de Foco* (`+25%` XP por 1h), *Pergaminho de Reclasse* (trocar de classe sem perder progresso) e *Baús Misteriosos*.
- **Evolução Visual da Casa (4 estágios):**
  1. *Cabana Inicial* (Nv. 1) → 2. *Casa de Madeira* (Nv. 5) → 3. *Mansão do Aventureiro* (Nv. 10) → 4. *Santuário Lendário* (Nv. 20).

### 3.5. Dopamina Variável
- **Acertos Críticos:** Chance aleatória de ganhar 1.5x a 2x Ouro/XP ao concluir tarefas.
- **Baús Misteriosos:** Comum, Raro e Épico com cosméticos, móveis ou consumíveis (ex.: *Poção de Foco*).
- **Missões Relâmpago:** Desafios opcionais e curtos (ex.: *"Conclua 1 tarefa pendente nos próximos 15 min"*).

### 3.6. Navegação & Direção Visual
- **5 Abas Principais (Bottom Navigation):**
  1. **Hoje (Mapa do Dia):** Linha do tempo (Google Agenda + Tasks/atividades locais) e botão do *Modo Energia (1x/sem)*.
  2. **Raids:** Lista de tarefas complexas e batalha em Pixel Art contra inimigos/ondas.
  3. **Casa:** Casa Viva em Pixel Art com os móveis comprados e o personagem no cenário.
  4. **Loja:** Equipamentos, móveis, pets e consumíveis.
  5. **Herói:** Ficha RPG (Classe, Nível Geral, os 5 Atributos, inventário, Baús, sync Google e exportar/importar save JSON).
- **Direção Visual:** RPG 16-bit aconchegante (*Stardew Valley / Chrono Trigger*), interface escura confortável aos olhos, bordas pixeladas limpas (`FilterQuality.none`) e alto contraste para leitura rápida.

---

## 4. Arquitetura Técnica (Android / Flutter)

- **Framework:** Flutter (Dart)
- **Estado & Navegação:** Riverpod + GoRouter
- **Armazenamento Local (100% offline-first):** `drift` (SQLite tipado no dispositivo)
  - Zero criação de conta e zero banco de dados remoto.
  - Função de **Exportar / Importar Save (.json)** para backup manual no aparelho.
- **Sincronização Google:** `google_sign_in` + `googleapis` (Calendar v3 & Tasks v1) rodando direto do Android, com cache local no SQLite para funcionar offline.
- **Renderização Pixel Art:** Sprites em PNG pixel-perfect (`FilterQuality.none`), com opção de usar `flame` apenas nas cenas animadas (Raid e Casa Viva) se desejado.

---

## 5. Roadmap de Desenvolvimento

1. **Fase 1 — Fundação:** Setup Flutter Android, banco local (`drift`), tema visual Pixel Art e fluxo de criação do personagem (Classe + Atributos).
2. **Fase 2 — Loop Core TDAH:** Tarefas locais, **Sistema de Raids**, **Dopamina Variável** (Críticos, Baús, Missões Relâmpago) e **Modo Energia (1x/semana)**.
3. **Fase 3 — Progressão & Casa Viva:** Loja interna, equipamentos/visuais do personagem e **Casa/Santuário em Pixel Art** com bônus passivos.
4. **Fase 4 — Google Sync & Mapa do Dia:** Login Google OAuth no Android, sincronização com Google Agenda + Google Tasks e tela do **Mapa do Dia**.
5. **Fase 5 — Polimento & UI Pixel Art:** Estilização completa dos menus/painéis com assets Pixel Art (molduras 9-slice, ícones das abas, botões), sons 8-bit/16-bit opcionais e geração de APK release.
6. **Fase 6 (Visão Futura) — Masmorra Procedural (Estilo *Pixel Dungeon*):**
   - **Roguelike por turnos em grid** com o seu próprio herói, andares e salas/corredores gerados proceduralmente, inimigos escalando por andar e chefes a cada 5 andares.
   - **Conexão direta com a vida real (anti-procrastinação):** concluir tarefas e Raids gera *Chaves/Energia de Expedição* para descer na masmorra (evitando jogar sem cumprir o dia), e seus **5 atributos reais** viram status reais de combate:
     - **VIG** → Vida máxima (HP) e defesa física
     - **INT** → Mana e poder das habilidades mágicas/classe
     - **DES** → Esquiva, precisão e chance de Acerto Crítico
     - **SAB** → Detecção de armadilhas, eficácia de poções e visão no mapa
     - **CAR** → Sorte de baús/itens raros e preços do Mercador da Masmorra
   - **Recompensa de volta para o LifeOS:** projetos exclusivos de móveis e cosméticos raros para a **Casa Viva** e o personagem.

