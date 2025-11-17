-- Assignment 4 – Online Movie Store DB

-- drop tables if they exist
DROP TABLE transaction CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE movie CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE appuser CASCADE CONSTRAINTS;

-- admin first
CREATE TABLE admin (
   adminid INT PRIMARY KEY,
   name    VARCHAR(100),
   email   VARCHAR(100),
   role    VARCHAR(50)
);

-- users
CREATE TABLE appuser (
   userid        INT PRIMARY KEY,
   name          VARCHAR(100),
   email         VARCHAR(100) UNIQUE NOT NULL,
   password      VARCHAR(100) NOT NULL,
   dateofbirth   DATE,
   accountstatus VARCHAR(20)
);

-- movie categories
CREATE TABLE genre (
   genreid   INT PRIMARY KEY,
   genrename VARCHAR(50) NOT NULL
);

-- movie list
CREATE TABLE movie (
   movieid        INT PRIMARY KEY,
   title          VARCHAR(200) NOT NULL,
   releaseyear    INT,
   description    VARCHAR(500),
   pricepurchase  DECIMAL(5,2),
   pricerent      DECIMAL(5,2),
   inventorycount INT
);

-- reviews
CREATE TABLE review (
   reviewid   INT PRIMARY KEY,
   rating     INT CHECK (rating BETWEEN 1 AND 5),
   reviewtext VARCHAR(1000),
   reviewdate DATE,
   userid     INT,
   movieid    INT,
   FOREIGN KEY (userid) REFERENCES appuser(userid),
   FOREIGN KEY (movieid) REFERENCES movie(movieid)
);

-- transactions
CREATE TABLE transaction (
   transactionid     INT PRIMARY KEY,
   transactionamount DECIMAL(6,2),
   paymenttype       VARCHAR(20),
   transactiondate   DATE,
   transactiontype   VARCHAR(30),
   userid            INT,
   movieid           INT,
   FOREIGN KEY (userid) REFERENCES appuser(userid),
   FOREIGN KEY (movieid) REFERENCES movie(movieid)
);

-- insert sample data
INSERT INTO appuser (userid, name, email, password)
VALUES (1, 'Alice', 'alice@email.com', 'pass123');

INSERT INTO admin (adminid, name, email, role)
VALUES (1, 'AdminUser', 'admin@email.com', 'SuperAdmin');

INSERT INTO genre VALUES (1, 'Action');
INSERT INTO movie (movieid, title, releaseyear) VALUES (101, 'Inception', 2010);

INSERT INTO review VALUES (1, 5, 'Great movie!', TO_DATE('2024-09-23','YYYY-MM-DD'), 1, 101);

INSERT INTO transaction VALUES (
  201, 9.99, 'Credit', TO_DATE('2024-09-22','YYYY-MM-DD'), 'Purchase', 1, 101
);

-- basic selects
SELECT userid, name, email FROM appuser ORDER BY name;
SELECT adminid, name, role FROM admin ORDER BY name;
SELECT genreid, genrename FROM genre ORDER BY genreid;
SELECT title, releaseyear FROM movie ORDER BY releaseyear DESC;
SELECT reviewid, rating, reviewtext FROM review ORDER BY rating DESC;
SELECT transactionid, transactionamount, transactiondate FROM transaction ORDER BY transactiondate DESC;

-- views
CREATE OR REPLACE VIEW customer_purchase_summary AS
SELECT u.userid, u.name AS customer_name, u.email,
       m.movieid, m.title AS movie_title,
       t.transactionid, t.transactionamount, t.transactiontype, t.transactiondate
FROM appuser u
JOIN transaction t ON u.userid = t.userid
JOIN movie m ON m.movieid = t.movieid;

CREATE OR REPLACE VIEW movie_review_summary AS
SELECT m.movieid, m.title AS movie_title, m.releaseyear,
       r.reviewid, r.rating, r.reviewtext, r.reviewdate,
       u.name AS reviewer_name, u.email AS reviewer_email
FROM movie m
JOIN review r ON m.movieid = r.movieid
JOIN appuser u ON u.userid = r.userid;

-- queries from views
SELECT customer_name, email, movie_title, transactionamount, transactiontype, transactiondate
FROM customer_purchase_summary ORDER BY transactiondate DESC;

SELECT movie_title, rating, reviewtext, reviewer_name, reviewdate
FROM movie_review_summary ORDER BY rating DESC, reviewdate DESC;

-- joins
SELECT m.title, r.rating, r.reviewtext, u.name
FROM movie m JOIN review r ON m.movieid = r.movieid
JOIN appuser u ON u.userid = r.userid;

SELECT t.transactionid, u.name, m.title, t.transactionamount, t.paymenttype
FROM transaction t JOIN appuser u ON t.userid = u.userid
JOIN movie m ON m.movieid = t.movieid;
