-- Song(song_id, tempo, meter, song_type) --
-- subclass: Reggae(staccato), Rock(guitar), Jazz(impoved scat) --

-- 1. Mandatory OR --
create table reggae(
song_id int primary key,
tempo int,
meter int,
staccato int 
);

create table rock(
song_id int primary key,
tempo int,
meter int,
guitar bool
);

create table jazz(
song_id int primary key,
tempo int,
meter int,
improved bool,
scat bool
);

-- 2. Optional OR --
create table song_type(
song_type varchar(64)
);

create table song(
song_id int primary key,
tempo int,
meter int,
song_type varchar(64),
foreign key (song_type) references song_type(song_type) on update cascade on delete cascade
);

create table reggae(
song_id int primary key,
staccato int,
foreign key (song_id) references song(song_id) on update cascade on delete cascade
);

create table rock(
song_id int primary key,
guitar bool,
foreign key (song_id) references song(song_id) on update cascade on delete cascade
);

create table jazz(
song_id int primary key,
improved bool,
scat bool,
foreign key (song_id) references song(song_id) on update cascade on delete cascade
);

-- 3. Madatory AND --
create table song(
song_id int primary key,
tempo int,
meter int,
is_reggae bool,
is_rock bool,
is_jazz bool,
staccato int,
guitar bool,
improved bool,
scat bool
);

-- 4. Optional AND --
create table song_type(
song_type varchar(64)
);

create table song(
song_id int primary key,
tempo int,
meter int,
song_type varchar(64),
foreign key (song_type) references song_type(song_type) on update cascade on delete cascade
);

create table song_to_song_type(
song_type varchar(64),
song_id int,
primary key(song_type, song_id),
foreign key (song_type) references song_type(song_type) on update cascade on delete cascade,
foreign key (song_id) references song(song_id) on update cascade on delete cascade
);

create table song_details(
song_id int primary key,
staccato int,
guitar bool,
improved bool,
scat bool,
foreign key (song_id) references song(song_id) on update cascade on delete cascade
);