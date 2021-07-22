CREATE DATABASE IF NOT EXISTS vk_2021;

USE vk_2021;

CREATE TABLE IF NOT EXISTS users (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(11) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS profiles (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    user_id INT NOT NULL,
    birth_date DATE,
    country VARCHAR(100),
    city VARCHAR(100),
    profile_status ENUM('ONLINE', 'OFFLINE', 'INACTIVE')
);

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,
	message_header VARCHAR(255),
    message_body TEXT NOT NULL,
    sent_flag TINYINT NOT NULL,
	received_flag TINYINT NOT NULL,
    edited_flag TINYINT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE messages ADD CONSTRAINT fk_messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT fk_messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id); 

CREATE TABLE IF NOT EXISTS friendship (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id INT NOT NULL,
	friend_id INT NOT NULL,
    friendship_status ENUM('FRIENDSHIP','FOLLOWING', 'BLOCKED'),
    requested_at DATETIME NOT NULL,
    accepted_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT fk_friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); 
    
CREATE TABLE IF NOT EXISTS communities (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	name VARCHAR (255) UNIQUE NOT NULL,
    community_header TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	community_status ENUM('ACTIVE', 'INACTIVE')
);

CREATE TABLE IF NOT EXISTS members (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
community_id INT NOT NULL,
user_id INT NOT NULL
);

ALTER TABLE members ADD CONSTRAINT fk_members_community_id FOREIGN KEY (community_id) REFERENCES communities(id); 
ALTER TABLE members ADD CONSTRAINT fk_members_user_id FOREIGN KEY (user_id) REFERENCES users(id);

CREATE TABLE IF NOT EXISTS mediafile_database (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
mediafile_type ENUM ("AUDIO", "VIDEO", "PICTURE", "GIF"),
mediafile_itself BLOB
);


CREATE TABLE IF NOT EXISTS users_mediafiles_posted (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
user_id INT NOT NULL,
mediafile_database_id INT NOT NULL, 
posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
deleted_at DATETIME
);

ALTER TABLE users_mediafiles_posted ADD CONSTRAINT fk_mediafiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE users_mediafiles_posted ADD CONSTRAINT fk_user_mediafile_database_id FOREIGN KEY (mediafile_database_id) REFERENCES mediafile_database(id);

CREATE TABLE IF NOT EXISTS community_mediafiles_posted (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
community_id INT NOT NULL,
mediafile_database_id INT NOT NULL, 
posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
deleted_at DATETIME
);

ALTER TABLE community_mediafiles_posted ADD CONSTRAINT fk_mediafiles_community_id FOREIGN KEY (community_id) REFERENCES communities(id); 
ALTER TABLE community_mediafiles_posted ADD CONSTRAINT fk_community_mediafile_database_id FOREIGN KEY (mediafile_database_id) REFERENCES mediafile_database(id);

CREATE TABLE IF NOT EXISTS user_likes_to_mediafiles (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
user_likes_id INT NOT NULL, 
mediafile_liked_id INT NOT NULL, 
marked_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
canceled TINYINT NOT NULL
); 

ALTER TABLE user_likes_to_mediafiles ADD CONSTRAINT fk_user_likes_id FOREIGN KEY (user_likes_id) REFERENCES users(id);
ALTER TABLE user_likes_to_mediafiles ADD CONSTRAINT fk_user_mediafile_liked_id FOREIGN KEY (medifile_liked_id) REFERENCES mediafile_database(id);
 
CREATE TABLE IF NOT EXISTS community_likes_to_mediafiles (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
community_likes_id INT NOT NULL, 
mediafile_liked_id INT NOT NULL, 
marked_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
canceled TINYINT NOT NULL
); 

ALTER TABLE community_likes_to_mediafiles ADD CONSTRAINT fk_community_likes_id FOREIGN KEY (community_likes_id) REFERENCES communities(id);
ALTER TABLE community_likes_to_mediafiles ADD CONSTRAINT fk_community_mediafile_liked_id FOREIGN KEY (medifile_liked_id) REFERENCES mediafile_database(id);




