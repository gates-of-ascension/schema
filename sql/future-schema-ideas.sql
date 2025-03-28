-- reference data for future implementation

CREATE TYPE card_location AS ENUM ('hand', 'deck', 'field', 'discard');
CREATE TYPE target_type AS ENUM ('self', 'own_monster', 'opponent', 'opponent_monster');
CREATE TYPE session_status AS ENUM ('waiting', 'ready', 'in_progress', 'completed');
CREATE TYPE keyword AS ENUM ('damage', 'healing');

CREATE TABLE game_boards (
    id UUID PRIMARY KEY,
    session_id UUID NOT NULL,
    turn INTEGER NOT NULL DEFAULT 0,
    current_player_id UUID NOT NULL,
    FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (current_player_id) REFERENCES players(id)
);

CREATE TABLE player_boards (
    id UUID PRIMARY KEY,
    player_id UUID NOT NULL,
    health INTEGER NOT NULL DEFAULT 30,
    mana INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE game_board_players (
    game_board_id UUID NOT NULL,
    player_board_id UUID NOT NULL,
    PRIMARY KEY (game_board_id, player_board_id),
    FOREIGN KEY (game_board_id) REFERENCES game_boards(session_id) ON DELETE CASCADE,
    FOREIGN KEY (player_board_id) REFERENCES player_boards(id) ON DELETE CASCADE
);

CREATE TABLE sessions (
    id UUID PRIMARY KEY,
    host_player_id UUID NOT NULL,
    status session_status NOT NULL DEFAULT 'waiting',
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (host_player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE session_players (
    session_id UUID NOT NULL,
    player_id UUID NOT NULL,
    joined_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (session_id, player_id),
    FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE effect_meta (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    card_id UUID NOT NULL,
    FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE
);

CREATE TABLE effects (
    id UUID PRIMARY KEY,
    effect_meta_id UUID NOT NULL,
    FOREIGN KEY (effect_meta_id) REFERENCES effect_meta(id) ON DELETE CASCADE
);

CREATE TABLE stats (
    id UUID PRIMARY KEY,
    value INTEGER NOT NULL,
    keyword keyword NOT NULL,
    target_type target_type NOT NULL,
    effect_id UUID NOT NULL,
    FOREIGN KEY (effect_id) REFERENCES effects(id) ON DELETE CASCADE
);

CREATE TABLE players (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
);