export const keywords = ["damage", "healing"] as const;
export type Keyword = (typeof keywords)[number];

export const cardTypes = ["monster", "magic"] as const;
export type CardTypes = (typeof cardTypes)[number];

export interface Stat {
  id: string;
  value: number;
  keyword: Keyword;
}

export interface Effect {
  id: string;
  stats: Stat[];
}

export interface EffectMeta {
  id: string;
  name: string;
  description: string;
  effects: Effect[];
}
export interface Card {
  id: string;
  name: string;
  description: string;
  effectMeta: EffectMeta[];
  type: CardTypes;
}

export interface Player {
  id: string;
  name: string;
  health: number;
}

export interface PlayerBoard {
  hand: Card[];
  deck: Card[];
  discard: Card[];
  field: Card[];
  playerId: number;
  mana: number;
}

export interface GameBoard {
  sessionId: string;
  playerBoards: PlayerBoard[];
  currentPlayer: Player;
  turn: number;
}
