DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube;
USE youtube;

/* 

1) Составить общее текстовое описание БД и решаемых ею задач;

2) минимальное количество таблиц - 10;

3) скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);

4) создать ERDiagram для БД;

5) скрипты наполнения БД данными;

6) скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

7) представления (минимум 2);

8) хранимые процедуры / триггеры;

*/

DROP TABLE IF EXISTS users; -- пользователи \ каналы
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(120) UNIQUE, 
    INDEX users_name_idx(name),
    INDEX users_email_idx(email)
);

DROP TABLE IF EXISTS `profiles`; -- профили
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON UPDATE CASCADE
    	ON DELETE restrict
);

DROP TABLE IF EXISTS media; -- видео
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS likes; -- лайки
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    
    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS dislikes; -- дизлайки
CREATE TABLE dislikes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    
    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS users_communities; -- подписчики
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS comments; -- комментарии 
CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_media_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    INDEX comments_from_user_id (from_user_id),
    INDEX comments_to_media_id (to_media_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_media_id) REFERENCES users(id) -- -------------------------------проверить
);

DROP TABLE IF EXISTS reposts; -- репосты
CREATE TABLE reposts (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body int,
    created_at DATETIME DEFAULT NOW(), 
    INDEX reposts_from_user_id (from_user_id),
    INDEX reposts_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists (
	id SERIAL,
	name varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS smallmedia; -- сюжеты
CREATE TABLE smallmedia(
	id SERIAL PRIMARY KEY,
    smallmedia_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);





