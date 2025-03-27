BEGIN;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS user_deck_cards;
DROP TABLE IF EXISTS user_decks;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS users;

-- ####### USERS
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4()
    , display_name VARCHAR(255) NOT NULL
    , username VARCHAR(255) NOT NULL -- plain text for now, hash/security later
    , password VARCHAR(255) NOT NULL -- plain text for now, hash/security later
    , created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
    , updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);
-- #######

-- ####### CARDS/DECKS 
CREATE TABLE cards (
    id SERIAL PRIMARY KEY
    , name VARCHAR(255) NOT NULL
    , description TEXT
    , type VARCHAR(255) NOT NULL
    , created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE user_decks (
    id UUID PRIMARY KEY DEFAULT UUID_GENERATE_V4()
    , user_id UUID NOT NULL
    , name VARCHAR(255) NOT NULL
    , description TEXT
    , created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
    , updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
    , FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE user_deck_cards (
    card_id SERIAL NOT NULL
    , user_deck_id UUID NOT NULL
    , quantity INT NOT NULL DEFAULT 1
    , PRIMARY KEY (card_id, user_deck_id)
	, FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE
	, FOREIGN KEY (user_deck_id) REFERENCES user_decks(id) ON DELETE CASCADE
);
-- #######

COMMIT;
