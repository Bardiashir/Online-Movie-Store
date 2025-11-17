-- Assignment 4 Part 1 - Online Movie Store Database


-- Drop existing tables to ensure clean setup
drop table review cascade constraints;
drop table transaction cascade constraints;
drop table movie cascade constraints;
drop table genre cascade constraints;
drop table appuser cascade constraints;
drop table admin cascade constraints;

create table appuser (
   userid        int primary key,
   name          varchar(100),
   email         varchar(100) unique not null,
   password      varchar(100) not null,
   dateofbirth   date,
   accountstatus varchar(20)
);

create table genre (
   genreid   int primary key,
   genrename varchar(50) not null
);

create table movie (
   movieid        int primary key,
   title          varchar(200) not null,
   releaseyear    int,
   description    varchar(500),
   pricepurchase  decimal(5,2),
   pricerent      decimal(5,2),
   inventorycount int
);

create table review (
   reviewid   int primary key,
   rating     int check ( rating between 1 and 5 ),
   reviewtext varchar(1000),
   reviewdate date,
   userid     int,
   movieid    int,
   foreign key ( userid )
      references appuser ( userid ),
   foreign key ( movieid )
      references movie ( movieid )
);

create table transaction (
   transactionid     int primary key,
   transactionamount decimal(6,2),
   paymenttype       varchar(20),
   transactiondate   date,
   transactiontype   varchar(30),
   userid            int,
   movieid           int,
   foreign key ( userid )
      references appuser ( userid ),
   foreign key ( movieid )
      references movie ( movieid )
);

create table admin (
   adminid int primary key,
   name    varchar(100),
   email   varchar(100),
   role    varchar(50)
);

insert into genre (
   genreid,
   genrename
) values ( 1,
           'Action' );
insert into movie (
   movieid,
   title,
   releaseyear
) values ( 101,
           'Inception',
           2010 );
insert into appuser (
   userid,
   name,
   email,
   password
) values ( 1,
           'Alice',
           'alice@email.com',
           'pass123' );
insert into transaction (
   transactionid,
   transactionamount,
   paymenttype,
   transactiondate,
   transactiontype,
   userid,
   movieid
) values ( 201,
           9.99,
           'Credit',
           to_date('2024-09-22','YYYY-MM-DD'),
           'Purchase',
           1,
           101 );

insert into review (
   reviewid,
   rating,
   reviewtext,
   reviewdate,
   userid,
   movieid
) values ( 1,
           5,
           'Great movie!',
           to_date('2024-09-23','YYYY-MM-DD'),
           1,
           101 );

insert into admin (
   adminid,
   name,
   email,
   role
) values ( 1,
           'AdminUser',
           'admin@email.com',
           'SuperAdmin' );

-- Query 1 -> List all movies with release information
-- Purpose: Display movie titles and their release years
-- Ordered by most recent releases first
select title,
       releaseyear
  from movie
 order by releaseyear desc;

-- query two -> List all users with their information
-- Purpose -> Display user ID, name, and email for all registered users
-- Ordered alphabetically by name for easy readability
select userid,
       name,
       email
  from appuser
 order by name;

-- query three Display all available genres
-- Purpose: Show all genre categories available in the movie store
-- Includes both genre ID and name for reference
select genreid,
       genrename
  from genre
 order by genreid;




-- Query 4 -> List all transaction records
-- Purpose: Display transaction history with amounts and dates
-- Ordered by most recent transactions first for audit purposes
select transactionid,
       transactionamount,
       transactiondate
  from transaction
 order by transactiondate desc;

-- Query 5 -> Show all customer reviews
-- Purpose: Display review details including ratings and comments
-- Ordered by highest ratings first to highlight best reviews
select reviewid,
       rating,
       reviewtext
  from review
 order by rating desc;



-- query 6 -> Display administrator information
-- Purpose: Show all admin users with their roles
-- Ordered alphabetically by name for easy lookup
select adminid,
       name,
       role
  from admin
 order by name;

-- Query 7 -> List movies with detailed information
-- Purpose: Display comprehensive movie information including descriptions
-- Ordered by movie ID for systematic catalog viewing
select movieid,
       title,
       releaseyear,
       description
  from movie
 order by movieid;

-- Query 8 -> Show users with birth date information
-- Purpose: Display user details including date of birth for demographics
-- Ordered by user ID for systematic viewing
select userid,
       name,
       email,
       dateofbirth
  from appuser
 order by userid;

