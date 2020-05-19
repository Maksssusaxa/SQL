USE vk;

DROP TABLE IF EXISTS reposts;
CREATE TABLE reposts (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
);
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
	`commebt` TEXT DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
);
