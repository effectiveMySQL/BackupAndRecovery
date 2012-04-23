CREATE TABLE album (
  album_id INT UNSIGNED NOT NULL,
  artist_id INT UNSIGNED NOT NULL,
  album_type_id INT UNSIGNED NOT NULL,
  name varchar(255) NOT NULL,
  first_released YEAR NULL,
  country_id SMALLINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (album_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE album_type (
  album_type_id INT UNSIGNED NOT NULL,
  name varchar(20) NOT NULL,
  PRIMARY KEY (album_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE artist (
  artist_id INT UNSIGNED NOT NULL,
  type enum('Band','Person','Unknown','Combination') NOT NULL,
  name varchar(255) NOT NULL,
  gender enum('Male','Female') DEFAULT NULL,
  founded YEAR DEFAULT NULL,
  country_id SMALLINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (artist_id),
  KEY name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE country (
  country_id int(11) NOT NULL,
  isocode varchar(2) NOT NULL,
  name varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE track (
  track_id INT UNSIGNED NOT NULL,
  album_id INT UNSIGNED NOT NULL,
  name varchar(255) NOT NULL,
  position   SMALLINT NOT NULL,
  length    INT UNSIGNED NULL,
  PRIMARY KEY (track_id),
  INDEX (album_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
