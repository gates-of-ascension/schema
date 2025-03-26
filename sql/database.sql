CREATE TABLE keywords (
    keyword VARCHAR(20) PRIMARY KEY
);

INSERT INTO keywords (keyword) VALUES ('damage'), ('healing');

CREATE TABLE card_types (
    type VARCHAR(20) PRIMARY KEY
);

INSERT INTO card_types (type) VALUES ('monster'), ('magic');

CREATE TABLE cards (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    type VARCHAR(20) NOT NULL,
    FOREIGN KEY (type) REFERENCES card_types(type)
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
    keyword VARCHAR(20) NOT NULL,
    effect_id UUID NOT NULL,
    FOREIGN KEY (keyword) REFERENCES keywords(keyword),
    FOREIGN KEY (effect_id) REFERENCES effects(id) ON DELETE CASCADE
);
