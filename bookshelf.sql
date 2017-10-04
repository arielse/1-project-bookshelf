CREATE DATABASE bookshelf;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(25) NOT NULL,
  email VARCHAR(200) NOT NULL,
  password_digest VARCHAR(400) NOT NULL,
  image VARCHAR(200)
);

CREATE TABLE books (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(500) NOT NULL,
  author VARCHAR(400) NOT NULL,
  isbn VARCHAR(200) NOT NULL,
  cover_img VARCHAR(400)
);

CREATE TABLE shelves (
  id SERIAL4 PRIMARY KEY,
  book_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (book_id) REFERENCES books (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE reviews (
  id SERIAL4 PRIMARY KEY,
  review_body VARCHAR(4000) NOT NULL,
  book_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (book_id) REFERENCES books (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);

ALTER TABLE users ADD COLUMN about_user VARCHAR(1000);
