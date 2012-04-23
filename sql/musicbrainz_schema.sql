DROP TABLE IF EXISTS artist;
CREATE TABLE artist (
  id INT NOT NULL,
  gid VARCHAR(40) NOT NULL,
  name INT NOT NULL,
  sort_name INT NOT NULL,
  begin_date_year SMALLINT DEFAULT NULL,
  begin_date_month SMALLINT DEFAULT NULL,
  begin_date_day SMALLINT DEFAULT NULL,
  end_date_year SMALLINT DEFAULT NULL,
  end_date_month SMALLINT DEFAULT NULL,
  end_date_day SMALLINT DEFAULT NULL,
  type INT DEFAULT NULL,
  country INT DEFAULT NULL,
  gender INT DEFAULT NULL,
  comment VARCHAR(255) DEFAULT NULL,
  ipi_code VARCHAR(11) DEFAULT NULL,
  edits_pending INT DEFAULT NULL,
  last_updated VARCHAR(30) DEFAULT NULL,
PRIMARY KEY (id),
INDEX (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE artist_name (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE artist_type (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE gender (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE country (
    id INT NOT NULL,
    iso_code VARCHAR(2) NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `release` (
    id INT NOT NULL,
    gid VARCHAR(40) NOT NULL,
    name INTEGER NOT NULL,
    artist_credit INTEGER NOT NULL,
    release_group INTEGER NOT NULL,
    status INTEGER,
    packaging INTEGER,
    country INTEGER,
    language INTEGER,
    script INTEGER,
    date_year SMALLINT,
    date_month SMALLINT,
    date_day SMALLINT,
    barcode VARCHAR(255),
    comment VARCHAR(255),
    edits_pending INTEGER NOT NULL,
    quality SMALLINT NOT NULL DEFAULT '-1',
    last_updated VARCHAR(30) NULL,
PRIMARY KEY (id),
index (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE release_name (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE release_group_type (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE release_group (
    id INT NOT NULL,
    gid VARCHAR(40) NOT NULL,
    name INTEGER NOT NULL,
    artist_credit INTEGER NOT NULL,
    type INTEGER, 
    comment VARCHAR(255),
    edits_pending INTEGER NOT NULL,
    last_updated VARCHAR(30) NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE track (
    id INT NOT NULL,
    recording INTEGER NOT NULL,
    tracklist INTEGER NOT NULL,
    position INTEGER NOT NULL,
    name INTEGER NOT NULL,
    artist_credit INTEGER NOT NULL,
    length INTEGER,
    edits_pending INTEGER NOT NULL,
    last_updated VARCHAR(30) NULL,
PRIMARY KEY (id),
INDEX (tracklist)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE track_name (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tracklist (
    id INT NOT NULL,
    track_count INTEGER NOT NULL DEFAULT 0,
    last_updated VARCHAR(30) NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE medium (
    id INT NOT NULL,
    tracklist INTEGER NOT NULL,
    `release` INTEGER NOT NULL,
    position INTEGER NOT NULL,
    format INTEGER,
    name VARCHAR(255),
    edits_pending INTEGER NOT NULL DEFAULT 0,
    last_updated VARCHAR(30) NULL,
PRIMARY KEY (id),
INDEX (tracklist,`release`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE recording (
    id                  INT NOT NULL,
    gid                 VARCHAR(40) NOT NULL,
    name                INTEGER NOT NULL,
    artist_credit       INTEGER NOT NULL,
    length              INTEGER NULL DEFAULT NULL,
    comment             VARCHAR(255),
    edits_pending       INTEGER NOT NULL,
    last_updated        VARCHAR(30) NULL,
PRIMARY KEY (id),
INDEX (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE artist_credit (
    id                  INT NOT NULL,
    name                INTEGER NOT NULL,
    artist_count        SMALLINT NOT NULL,
    ref_count           INTEGER DEFAULT 0,
    created             VARCHAR(30) NULL,
PRIMARY KEY (id),
INDEX (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE artist_credit_name (
    artist_credit       INTEGER NOT NULL,
    position            SMALLINT NOT NULL,
    artist              INTEGER NOT NULL,
    name                INTEGER NOT NULL,
    join_phrase         TEXT NULL,
PRIMARY KEY (artist_credit,position),
INDEX (artist),
INDEX (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE url (
    id                  INT NOT NULL,
    gid                 VARCHAR(40) NOT NULL,
    url                 TEXT NOT NULL,
    description         TEXT,
    ref_count           INTEGER NOT NULL DEFAULT 0,
    edits_pending       INTEGER NOT NULL DEFAULT 0,
    last_updated        VARCHAR(30) NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

