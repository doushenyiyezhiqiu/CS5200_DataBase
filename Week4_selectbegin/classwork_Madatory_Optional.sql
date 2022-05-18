	CREATE DATABASE IF NOT EXISTS songList;
    
    CREATE TABLE song_type (
    song_type VARCHAR(64) PRIMARY KEY
    );
    
    CREATE TABLE song (
    song_id int primary key,
    temp INT,
    meter INT,
    song_type VARCHAR(64),
    FOREIGN KEY (song_type) references song_type(song_type)    
    );
    
    CREATE TABLE song_to_song(
    song_id int primary key,
    foreign key (song_id) references song(song_id) on update cascade on delete cascade
    );