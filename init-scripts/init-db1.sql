\c authors_database;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    login VARCHAR(255) NOT NULL
);

CREATE TABLE blog (
    id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    header VARCHAR(255) NOT NULL,
    text VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id),
    blog_id INT NOT NULL,
    FOREIGN KEY (blog_id) REFERENCES blog(id)
 );

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (email, login) VALUES
('user1@example.com', 'login1'),
('user2@example.com', 'login2'),
('user3@example.com', 'login3'),
('user4@example.com', 'login4'),
('user5@example.com', 'login5');

INSERT INTO blog (owner_id, name, description) VALUES
(1, 'Blog 1', 'Description for Blog 1'),
(2, 'Blog 2', 'Description for Blog 2'),
(3, 'Blog 3', 'Description for Blog 3'),
(4, 'Blog 4', 'Description for Blog 4'),
(5, 'Blog 5', 'Description for Blog 5');

INSERT INTO post (header, text, author_id, blog_id) VALUES
('Post Header 1', 'Post Text for Post 1', 1, 1),
('Post Header 2', 'Post Text for Post 2', 2, 2),
('Post Header 3', 'Post Text for Post 3', 3, 3),
('Post Header 4', 'Post Text for Post 4', 4, 4),
('Post Header 5', 'Post Text for Post 5', 5, 5),
('Post Header 6', 'Post Text for Post 6', 1, 2),
('Post Header 7', 'Post Text for Post 7', 2, 3),
('Post Header 8', 'Post Text for Post 8', 3, 4),
('Post Header 9', 'Post Text for Post 9', 4, 5),
('Post Header 10', 'Post Text for Post 10', 5, 1);

INSERT INTO comments (post_id, user_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 5),
(4, 2),
(5, 3),
(6, 4),  
(7, 5),  
(8, 1),  
(9, 2),  
(10, 3); 