CREATE TABLE "sessions" (
  "id" UUID PRIMARY KEY,
  "host_player_id" UUID NOT NULL,
  "status" session_status NOT NULL DEFAULT 'waiting',
  "created_at" TIMESTAMP DEFAULT 'NOW()'
);

CREATE TABLE "session_players" (
  "session_id" UUID NOT NULL,
  "player_id" UUID NOT NULL,
  "joined_at" TIMESTAMP DEFAULT 'NOW()'
);

CREATE TABLE "decks" (
  "id" UUID PRIMARY KEY,
  "player_id" UUID NOT NULL,
  "session_id" UUID NOT NULL,
  "card_ids" INTEGER[] NOT NULL
);

CREATE TABLE "game_boards" (
  "id" UUID PRIMARY KEY,
  "session_id" UUID NOT NULL,
  "turn" INTEGER NOT NULL DEFAULT 1,
  "current_player_id" UUID NOT NULL
);

CREATE TABLE "players" (
  "id" UUID PRIMARY KEY,
  "name" TEXT NOT NULL,
  "health" INTEGER NOT NULL
);

CREATE TABLE "player_boards" (
  "id" UUID PRIMARY KEY,
  "player_id" UUID NOT NULL,
  "mana" INTEGER NOT NULL
);

CREATE TABLE "player_board_cards" (
  "id" UUID PRIMARY KEY,
  "player_board_id" UUID NOT NULL,
  "card_id" UUID NOT NULL,
  "location" card_location NOT NULL
);

CREATE TABLE "cards" (
  "id" UUID PRIMARY KEY,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "type" card_type NOT NULL
);

CREATE TABLE "effect_meta" (
  "id" UUID PRIMARY KEY,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "card_id" UUID NOT NULL
);

CREATE TABLE "effects" (
  "id" UUID PRIMARY KEY,
  "effect_meta_id" UUID NOT NULL
);

CREATE TABLE "stats" (
  "id" UUID PRIMARY KEY,
  "value" INTEGER NOT NULL,
  "keyword" keyword NOT NULL,
  "target_type" target_type NOT NULL,
  "effect_id" UUID NOT NULL
);

CREATE TABLE "game_board_players" (
  "game_board_id" UUID NOT NULL,
  "player_board_id" UUID NOT NULL
);

CREATE UNIQUE INDEX ON "session_players" ("session_id", "player_id");

CREATE UNIQUE INDEX ON "game_board_players" ("game_board_id", "player_board_id");

ALTER TABLE "sessions" ADD FOREIGN KEY ("host_player_id") REFERENCES "players" ("id");

ALTER TABLE "session_players" ADD FOREIGN KEY ("session_id") REFERENCES "sessions" ("id");

ALTER TABLE "session_players" ADD FOREIGN KEY ("player_id") REFERENCES "players" ("id");

ALTER TABLE "decks" ADD FOREIGN KEY ("player_id") REFERENCES "players" ("id");

ALTER TABLE "decks" ADD FOREIGN KEY ("session_id") REFERENCES "sessions" ("id");

ALTER TABLE "game_boards" ADD FOREIGN KEY ("session_id") REFERENCES "sessions" ("id");

ALTER TABLE "game_boards" ADD FOREIGN KEY ("current_player_id") REFERENCES "players" ("id");

ALTER TABLE "player_boards" ADD FOREIGN KEY ("player_id") REFERENCES "players" ("id");

ALTER TABLE "player_board_cards" ADD FOREIGN KEY ("player_board_id") REFERENCES "player_boards" ("id");

ALTER TABLE "player_board_cards" ADD FOREIGN KEY ("card_id") REFERENCES "cards" ("id");

ALTER TABLE "effect_meta" ADD FOREIGN KEY ("card_id") REFERENCES "cards" ("id");

ALTER TABLE "effects" ADD FOREIGN KEY ("effect_meta_id") REFERENCES "effect_meta" ("id");

ALTER TABLE "stats" ADD FOREIGN KEY ("effect_id") REFERENCES "effects" ("id");

ALTER TABLE "game_board_players" ADD FOREIGN KEY ("game_board_id") REFERENCES "game_boards" ("id");

ALTER TABLE "game_board_players" ADD FOREIGN KEY ("player_board_id") REFERENCES "player_boards" ("id");
