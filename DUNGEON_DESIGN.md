# LifeOS — Fase 6: Masmorras Procedurais (Aba Raids)

Substitui a aba **Raids** por um modo roguelike por turnos estilo **Pixel Dungeon**, utilizando o próprio personagem evoluído na vida real + **Inventário do Personagem**.

---

## 1. Masmorras Disponíveis (5 Biomas)

| Masmorra | Bioma / Tiles principais | Andares | Boss Final |
| :--- | :--- | :---: | :--- |
| **Bosque Sussurrante** | Grama, terra, água, muros de troncos/pedra | `5` | **Ent Ancião** |
| **Catacumbas de Pedra** | Chão de pedra, muros/colunas intransponíveis | `7` | **Lich da Cripta** |
| **Pântano Envenenado** | Pântano (veneno/lentidão), terra úmida, água, ruínas | `8` | **Hidra do Lodo** |
| **Deserto das Dunas** | Areia, pilares de arenito, oásis de água | `8` | **Faraó Escorpião** |
| **Fornalha Vulcânica** | Chão de basalto, lava (dano térmico), muros de obsidiana | `10` | **Dragão de Magma** |

---

## 2. Geração Procedural Determinística (com Seed)

Cada expedição nasce com uma `seed` inteira (gerada aleatoriamente ou digitada pelo jogador para repetir/compartilhar uma masmorra):
- Seed por andar: `floorSeed = seed ^ (floorIndex * 0x9E3779B9)`
- Grid de cada andar: `17 × 21` tiles (câmera centralizada no herói com zoom pixel-perfect + **Fog of War**).
- Algoritmo por andar:
  1. **Salas:** gera `5` a `8` salas retangulares sem sobreposição (tamanho mínimo `3×3`, máximo `6×6`).
  2. **Corredores:** conecta cada sala à próxima com corredores em "L" garantindo 100% de acessibilidade.
  3. **Terreno do Bioma:** aplica variações de piso (grama/terra/areia/pedra), obstáculos intransponíveis (muros/colunas) e hazards (água profunda, pântano que reduz esquiva/aplica veneno leve, lava que queima ao pisar).
  4. **Pontos-chave:**
     - Sala 0: posição inicial do Herói.
     - Sala mais distante: **Escada para o próximo andar** (no andar final, é a **Arena do Boss** — escada/portal só abre ao derrotar o Boss Final!).
     - Salas intermediárias: `3` a `6` monstros do bioma, `1` a `2` baús de equipamentos/consumíveis e armadilhas ocultas.

---

## 3. Cálculos de Combate por Turnos (5 Atributos do LifeOS)

### Status Derivados do Herói e dos Monstros
Tanto o **Herói** quanto os **Monstros** compartilham exatamente os mesmos 5 atributos (`VIG`, `INT`, `DES`, `SAB`, `CAR`):

- **HP Máximo:** `50 + (VIG * 12) + (Nível * 5) + bonusHpEquip`
- **Mana Máxima:** `20 + (INT * 6) + bonusManaEquip`
- **Ataque Físico:** `6 + (VIG * 1.6) + (DES * 0.8) + danoArma`
- **Poder Mágico / Habilidade:** `8 + (INT * 2.2) + poderMagicoEquip`
- **Defesa:** `2 + (VIG * 0.9) + defesaArmadura`
- **Chance de Esquiva:** `clamp(0.05 + DES * 0.011, 0.05, 0.35)`
- **Chance de Crítico:** `clamp(0.08 + DES * 0.012 + bonusClasse + bonusArma, 0.08, 0.55)` *(multiplicador `1.75x`)*
- **Raio de Visão (Névoa) & Poções (`SAB`):** visão = `3 + (SAB ~/ 5)` tiles; poções curam `+(SAB * 4)%` a mais; maior chance de revelar armadilhas.
- **Sorte de Loot (`CAR`):** `+(CAR * 2)%` chance de drop de raridade superior (Comum → Incomum → Raro → Épico → Lendário).

### Fórmula de Dano por Turno
```text
danoBruto = (ataqueBase * multiplicadorDoAtaque)
reducao   = defesaAlvo * 0.65
variacao  = random(0.90 .. 1.10)
danoFinal = max(1, round((danoBruto - reducao) * variacao * (critico ? 1.75 : 1.0)))
```

### Escalonamento dos Monstros (pelo Nível do Herói + Andar)
Cada monstro do bestiário possui **atributos base (potência relativa)** no nível 1. Ao entrar na masmorra, seus atributos são escalados dinamicamente:
```text
fatorNivel = 1.0 + (nivelHeroi - 1) * 0.14
fatorAndar = 1.0 + (andarAtual - 1) * 0.18
fatorBoss  = isBoss ? 1.45 : 1.0
atributoReal = max(1, round(atributoBase * fatorNivel * fatorAndar * fatorBoss))
```
Assim, uma masmorra de 5 andares continua equilibrada tanto para um herói Nv. 2 quanto para um herói Nv. 25, e cada andar mais fundo fica visivelmente mais tenso!

### Fluxo de Turno (Estilo Pixel Dungeon)
1. O jogador toca num tile adjacente (para andar ou atacar corpo-a-corpo) ou usa uma **Habilidade de Classe** / **Item do Inventário**.
2. Cada ação do jogador consome `1 turno`.
3. Em seguida, todos os monstros despertos no andar agem (`1 turno`: se aproximam pelo menor caminho ou usam um de seus ataques se estiverem no alcance).
4. **Regra anti-procrastinação:** concluir tarefas/compromissos/sidequests no **LifeOS** recarrega **Chaves de Expedição** (além de 1 chave gratuita por dia) para iniciar novas masmorras.

