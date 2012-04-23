#!/bin/sh

cd ..
mkdir -p musicbrainz
cd musicbrainz
# Details of current downloads available at http://musicbrainz.org/doc/Database_Download
echo "Getting MusicBrainz data dump. This may take some time, file is 1GB"
wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/20120331-001538/mbdump.tar.bz2
[ $? -ne 0 ] && echo "ERROR: The filename may be no longer available. Check documented link" && exit 1
tar xvfj mbdump.tar.bz2 mbdump/artist mbdump/artist_name mbdump/artist_type mbdump/country mbdump/gender
tar xvfj mbdump.tar.bz2 mbdump/release mbdump/release_name mbdump/release_group mbdump/release_group_type
tar xvfj mbdump.tar.bz2 mbdump/track mbdump/track_name mbdump/tracklist mbdump/medium
tar xvfj mbdump.tar.bz2 mbdump/recording mbdump/artist_credit mbdump/artist_credit_name mbdump/url

# Schema is derived from Postgresql version at https://github.com/metabrainz/musicbrainz-server/blob/master/admin/sql/CreateTables.sql
mysqladmin create musicbrainz
mysql musicbrainz < ../sql/musicbrainz_schema.sql
mysql musicbrainz < ../sql/musicbrainz_load.sql
mysql musicbrainz < ../sql/perschema.sql

