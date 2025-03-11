CREATE DATABASE logs_database;

\c logs_database;

CREATE TABLE space_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE event_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    space_type_id INT NOT NULL,
    FOREIGN KEY (space_type_id) REFERENCES space_type(id),
    event_type_id INT NOT NULL,
    FOREIGN KEY (event_type_id) REFERENCES event_type(id)
);

INSERT INTO space_type (name) VALUES
('global'),
('blog'),
('post');

INSERT INTO event_type (name) VALUES
('login'),
('comment'),
('create_post'),
('delete_post'),
('logout');

INSERT INTO logs (datetime, user_id, space_type_id, event_type_id) VALUES
('2023-10-01 08:00:00', 1, 1, 1),  
('2023-10-01 08:05:00', 1, 2, 3),   
('2023-10-01 09:00:00', 2, 1, 1),  
('2023-10-01 09:15:00', 2, 3, 2),  
('2023-10-01 10:00:00', 3, 1, 1), 
('2023-10-02 10:30:00', 1, 3, 2),  
('2023-10-02 11:00:00', 4, 1, 1), 
('2023-10-02 12:00:00', 4, 2, 4),  
('2023-10-02 13:00:00', 5, 1, 1),  
('2023-10-02 14:00:00', 5, 3, 2),  
('2023-10-03 09:00:00', 2, 1, 5), 
('2023-10-03 10:00:00', 3, 2, 3),  
('2023-10-03 11:00:00', 3, 3, 2),  
('2023-10-03 12:00:00', 4, 2, 4),  
('2023-10-03 15:00:00', 5, 1, 5);  