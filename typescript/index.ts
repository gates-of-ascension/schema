// Enums

export const keywords = ["damage", "healing"] as const;
export type Keyword = (typeof keywords)[number];

export const cardTypes = ["monster", "magic"] as const;
export type CardType = (typeof cardTypes)[number];

export const cardLocations = ["hand", "deck", "discard", "field"] as const;
export type CardLocation = (typeof cardTypes)[number];

export const targetTypes = [
  "self",
  "own_monster",
  "opponent",
  "opponent_monster",
] as const;
export type TargetType = (typeof targetTypes)[number];

export const sessionStatus = [
  "waiting",
  "ready",
  "in_progress",
  "completed",
] as const;
export type SessionStatus = (typeof sessionStatus)[number];

// Card interfaces
export interface Card {
  id: string;
  name: string;
  description: string;
  effectMeta: EffectMeta[];
  type: CardType;
}

export interface EffectMeta {
  id: string;
  name: string;
  description: string;
  effects: Effect[];
}

export interface Effect {
  id: string;
  stats: Stat[];
}

export interface Stat {
  id: string;
  value: number;
  keyword: Keyword;
  targetType: TargetType;
}

// Player interfaces

export interface Player {
  id: string;
  name: string;
}

// Board / Game interfaces

type Board = {
  [K in (typeof cardLocations)[number]]: Card[];
};

export interface PlayerBoard extends Board {
  playerId: number;
  mana: number;
  health: number;
}

export interface GameBoard {
  sessionId: string;
  playerBoards: PlayerBoard[];
  currentPlayerId: number;
  turn: number;
}
