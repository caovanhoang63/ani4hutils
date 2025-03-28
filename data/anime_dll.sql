DROP TABLE IF EXISTS `series`;
CREATE TABLE `series`
(
    `id`         int         NOT NULL AUTO_INCREMENT,
    `name`       varchar(50) NOT NULL,
    `images`     JSON,
    `status`     int      DEFAULT 1,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `producers`;
CREATE TABLE `producers`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `name`        varchar(50),
    `image`       JSON,
    `status`      int      DEFAULT 1,
    `description` TEXT     DEFAULT NULL,
    `created_at`  datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `films`;
CREATE TABLE `films`
(
    `id`                       int               NOT NULL AUTO_INCREMENT,
    `title`                    varchar(255)      NOT NULL,
    `start_date`               datetime                   DEFAULT CURRENT_TIMESTAMP,
    `end_date`                 datetime                   DEFAULT NULL,
    `synopsis`                 TEXT,
    `images`                   JSON,
    `rank`                     int,
    `avg_star`                 float,
    `total_star`               int unsigned,
    `state`                    enum ('upcoming','on_air','now_streaming', 'finished'),
    `max_episodes`             int,
    `num_episodes`             int,
    `year`                     SMALLINT UNSIGNED,
    `season`                   enum ('spring', 'summer', 'fall', 'winter') DEFAULT NULL,
    `average_episode_duration` float,
    `age_rating_id`            int,
    `status`                   int                        DEFAULT 1,
    `created_at`               datetime                   DEFAULT CURRENT_TIMESTAMP,
    `updated_at`               datetime                   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `series_id`                int,
    PRIMARY KEY (`id`),
    KEY `state` (`state`) USING BTREE,
    KEY `status` (`status`) USING BTREE,
    KEY `series_id` (`series_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `age_ratings`;
CREATE TABLE `age_ratings`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `long_name`   varchar(50),
    `short_name`  varchar(15),
    `image`       json,
    `description` TEXT     DEFAULT NULL,
    `status`      int      DEFAULT 1,
    `created_at`  datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
ALTER TABLE `age_ratings` ADD COLUMN min_age_to_watch tinyint DEFAULT 0 AFTER `description`;

DROP TABLE IF EXISTS `alternative_titles`;
CREATE TABLE `alternative_titles`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `synonyms`   varchar(255),
    `en_name`    varchar(255),
    `ja_name`    varchar(255),
    `status`     int      DEFAULT 1,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `film_id`    int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `genres`;
CREATE TABLE `genres`
(
    `id`          int         NOT NULL AUTO_INCREMENT,
    `name`        varchar(50) NOT NULL,
    `description` TEXT,
    `image`       JSON,
    `status`      int      DEFAULT 1,
    `created_at`  datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `film_genres`;
CREATE TABLE `film_genres`
(
    `film_id`  int NOT NULL,
    `genre_id` int NOT NULL,
    PRIMARY KEY (`film_id`,`genre_id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `genre_id` (`genre_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `broadcasts`;
CREATE TABLE `broadcasts`
(
    `id`           int NOT NULL AUTO_INCREMENT,
    `start_time`   time,
    `day_of_week` enum ('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'),
    `status`       int      DEFAULT 1,
    `time_zone` NVARCHAR(10),
    `created_at`   datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`   datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `film_id`      int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `day_of_week` (`day_of_week`) USING BTREE,
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `studios`;
CREATE TABLE `studios`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `name`        varchar(50),
    `image`       JSON,
    `description` TEXT,
    `status`      int      DEFAULT 1,
    `created_at`  datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `film_studios`;
CREATE TABLE `film_studios`
(
    `id`        int NOT NULL AUTO_INCREMENT,
    `film_id`   int NOT NULL,
    `studio_id` int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `studio_id` (`studio_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `film_producers`;
CREATE TABLE `film_producers`
(
    `id`        int NOT NULL AUTO_INCREMENT,
    `film_id`   int NOT NULL,
    `producer_id` int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `studio_id` (`producer_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `statistics`;
CREATE TABLE `statistics`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `state`       enum ('watching', 'completed', 'rating'),
    `count_value` int      DEFAULT 0,
    `status`      int      DEFAULT 1,
    `created_at`  datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    `film_id`     int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `state` (`state`) USING BTREE,
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `film_characters`;
CREATE TABLE `film_characters`
(
    `id`         int         NOT NULL AUTO_INCREMENT,
    `image`      JSON,
    `name`       varchar(50) NOT NULL,
    `role`       enum ('main', 'supporting'),
    `status`     int      DEFAULT 1,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    `film_id`    int         NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `role` (`role`) USING BTREE,
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
ALTER TABLE `film_characters` DROP COLUMN film_id;




DROP TABLE IF EXISTS `actors`;
CREATE TABLE `actors`
(
    `id`         int         NOT NULL AUTO_INCREMENT,
    `image`      JSON,
    `name`       varchar(50) NOT NULL,
    `language`   varchar(50),
    `status`     int      DEFAULT 1,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `film_character_actors`;
CREATE TABLE `film_character_actors`
(
    `id`                int NOT NULL AUTO_INCREMENT,
    `film_character_id` int NOT NULL,
    `actor_id`          int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_character_id` (`film_character_id`) USING BTREE,
    KEY `actor_id` (`actor_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `film_film_characters`;
CREATE TABLE `film_film_characters`
(
    `id`                int NOT NULL AUTO_INCREMENT,
    `film_character_id` int NOT NULL,
    `film_id`          int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_character_id` (`film_character_id`) USING BTREE,
    KEY `film_id` (`film_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `episodes`;
CREATE TABLE `episodes`
(
    `id`             int         NOT NULL AUTO_INCREMENT,
    `title`          varchar(50) NOT NULL,
    `episode_number` int         NOT NULL,
    `synopsis`       TEXT,
    `duration`       int,
    `thumbnail`      JSON,
    `video_url`      TEXT,
    `view_count`     int      DEFAULT 0,
    `air_date`       datetime,
    `state`          enum ('released', 'upcoming'),
    `status`         int      DEFAULT 1,
    `created_at`     datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `film_id`        int         NOT NULL,
    PRIMARY KEY (`id`),
    KEY `film_id` (`film_id`) USING BTREE,
    KEY `state` (`state`) USING BTREE,
    KEY `status` (`status`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
