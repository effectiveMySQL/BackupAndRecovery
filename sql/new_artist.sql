DELIMITER $$
DROP PROCEDURE IF EXISTS new_artist$$
CREATE PROCEDURE new_artist(p_artist_id INT)
BEGIN

  START TRANSACTION;
  INSERT INTO artist(artist_id,type,name,gender,founded,country_id) 
  SELECT a.id,IFNULL(at.name,'Unknown'),an.name,g.name,IF(begin_date_year>1900,begin_date_year,NULL),country 
  FROM musicbrainz.artist a
    LEFT JOIN musicbrainz.artist_name an ON a.name = an.id
    LEFT JOIN musicbrainz.artist_type at ON a.type = an.id
    LEFT JOIN musicbrainz.gender g ON a.gender = an.id
  WHERE a.id = p.artist_id;

  INSERT INTO album(album_id,artist_id,album_type_id,name,first_released,country_id)
  SELECT  r.id, MIN(a.id), IFNULL(rg.type,11), rn.name, IF(r.date_year>1900,r.date_year,NULL), r.country
  FROM musicbrainz.`release` r
      LEFT JOIN musicbrainz.release_group rg ON r.release_group = rg.id
      LEFT JOIN musicbrainz.release_name rn ON r.name = rn.id
      INNER JOIN musicbrainz.artist_name an ON r.artist_credit = an.id
      INNER JOIN musicbrainz.artist a ON a.name = an.id
  WHERE a.id = p.artist_id
  GROUP BY r.id, rg.type, rn.name, r.date_year, r.country;

  INSERT INTO track(track_id, album_id, name, position,length)
  SELECT t.id, MIN(m.release), tn.name, t.position, t.length
  FROM musicbrainz.track t
     INNER JOIN musicbrainz.track_name tn ON t.name = tn.id
     INNER JOIN musicbrainz.tracklist tl ON t.tracklist = tl.id
     INNER JOIN musicbrainz.medium m ON m.tracklist = t.tracklist
     INNER JOIN album a ON m.release = a.album_id
  WHERE a.artist_id = p_artist_id
  GROUP BY t.id, tn.name, t.position, t.length;

  COMMIT;

  SELECT 'artist ' AS t,COUNT(*) as cnt FROM artist WHERE artist_id = p_artist_id
  UNION
  SELECT 'album  ' AS t,COUNT(*) as cnt FROM album WHERE artist_id = p_artist_id
  UNION
  SELECT 'track  ' AS t,COUNT(*) as cnt FROM track t INNER JOIN album a  USING (album_id) WHERE a.artist_id = p_artist_id;

END$$
