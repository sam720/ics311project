CREATE TABLE `genre` (
  `genre_id` int,
  `genre_name` varchar(20),
  `genre_description` varchar(140),
  `createDate` date,
  `lastUpdated` date,
  PRIMARY KEY (`genre_id`)
);

CREATE TABLE `console` (
  `console_id` int,
  `console_name` varchar(20),
  `createDate` date,
  `lastUpdated` date,
  PRIMARY KEY (`console_id`)
);

CREATE TABLE `is_part_of` (
  `game_id` int,
  `genre_id` int,
  `createDate` date,
  `lastUpdated` date,
  PRIMARY key(`game_id`, `genre_id`),
  FOREIGN key (game_id) references game (game_id),
  FOREIGN key (genre_id) references genre (genre_id)
);

CREATE TABLE `loan` (
  `loan_id` int,
  `start_date` date,
  `end_date` date,
  `positive_rate` tinyint,
  `game_id` int,
  `member_id` int,
  `createDate` date,
  `lastUpdated` date,
  PRIMARY KEY (`loan_id`),
  KEY `FK` (`game_id`, `member_id`)
);

CREATE TABLE `member` (
  `member_id` int,
  `first_name` varchar(20),
  `last_name` varchar(20),
  `phone` bigint,
  `email` varchar(20),
  `createDate` date,
  `lastUpdated` date,
  PRIMARY KEY (`member_id`)
);

CREATE TABLE `game` (
  `game_id` int,
  `title` varchar(20),
  `member_id` int,
  `console_id` int,
  `createDate` date,
  `lastUpdated` date,
  PRIMARY KEY (`game_id`),
  KEY `FK` (`member_id`, `console_id`)
);

INSERT into member values 
(001,'Sam','Schug',6517553652,'sam@gmail.com',20190729,20190729),
(002,'Logan','Schug',7154411951,'logan@gmail.com',20190729,20190729),
(003, 'Brandi','Burke',6514176106,'brandi@msn.com',20190729,20190729),
(004, 'Eric','Jochum', 7632811356,'eric@msn.com',20190729,20190729),
(005, 'Jon','Rudquist',7635281939,'jon@outlook.com',20190729,20190729),
(006, 'Aaron','Newell',6123005072,'aaron@outlook.com',20190729,20190729),
(007, 'Dan','Jones',7636894780,'dan@yahoo.com',20190729,20190729),
(008, 'McKenzie','Larson',7634820299,'mckenzie@yahoo.com',20190729,20190729),
(009, 'Dustin','Johnson',6128128280,'dustin@aol.com',20190729,20190729),
(010, 'Sean','Jones',7636894780,'sean@aol.com',20190729,20190729);

INSERT into console values
(01,'PC',20190729,20190729),
(02,'Xbox360',20190729,20190729),
(03,'XboxOne',20190729,20190729),
(04,'PS3',20190729,20190729),
(05,'PS4',20190729,20190729),
(06,'Wii',20190729,20190729),
(07,'Switch',20190729,20190729),
(08,'WiiU',20190729,20190729),
(09,'Nintendo Classic',20190729,20190729),
(10,'Sega Genesis',20190729,20190729);

INSERT into game values
(0201,'Doom',006,01,20190729,20190729),
(0202,'Skyrim',001,05,20190729,20190729),
(0203,'Monster Hunter',003,05,20190729,20190729),
(0204,'Stardew Valley',002,07,20190729,20190729),
(0205,'Diable 3',005,01,20190729,20190729),
(0206,'Fallout 4',004,05,20190729,20190729),
(0207,'NHL2019',009,03,20190729,20190729),
(0208,'Anthem',008,05,20190729,20190729),
(0209,'Minecraft',010,02,20190729,20190729),
(0210,'The Witcher 3',001,05,20190729,20190729);

INSERT into genre values
(101,'MMO','Massively Multiplayer Online',20190729,20190729),
(102,'SIM','Simulation',20190729,20190729),
(103,'Adventure','single player fantasy/adventure',20190729,20190729),
(104,'RTS', 'Real time strategy',20190729,20190729),
(105,'Puzzle','Brain teasers',20190729,20190729),
(106,'Action','Fast paced enemy challenges',20190729,20190729),
(107,'Stealth Shooter','War/spy based',20190729,20190729),
(108,'Combat','Fight with opponents',20190729,20190729),
(109,'FPS','First person shooter',20190729,20190729),
(110,'Sports','Modelled after real world athletics',20190729,20190729),
(111,'RPG','Role playing games',20190729,20190729),
(112,'Educational','Helps with the learning process',20190729,20190729);

INSERT into is_part_of values
(0201,106,20190729,20190729),
(0201,109,20190729,20190729),
(0202,103,20190729,20190729),
(0203,101,20190729,20190729),
(0204,102,20190729,20190729),
(0205,109,20190729,20190729),
(0206,103,20190729,20190729),
(0207,110,20190729,20190729),
(0208,101,20190729,20190729),
(0208,109,20190729,20190729),
(0209,105,20190729,20190729),
(0210,103,20190729,20190729);

INSERT into loan values
(10001,20190101,20190108,1,0206,001,20190729,20190729),
(10002,20190202,20190209,1,0202,002,20190729,20190729),
(10003,20190303,20190331,0,0207,006,20190729,20190729),
(10004,20190404,20190411,1,0208,004,20190729,20190729),
(10005,20190505,20190512,1,0203,007,20190729,20190729),
(10006,20190606,20190613,1,0204,003,20190729,20190729),
(10007,20190707,20190714,1,0206,008,20190729,20190729),
(10008,20190712,null,null,0205,005,20190729,20190729),
(10009,20190720,null,null,0210,009,20190729,20190729),
(10010,20190724,null,null,0201,010,20190729,20190729);

create view OwnedBy as
select game_id, title, first_name, last_name
from game as g join member as m
where g.member_id = m.member_id;

/*1. Which games are available to borrow?*/
select title
from game join loan
where game.game_id = loan.game_id and end_date is not null
group by title;

/*2. Which member owns each game?*/
select title, concat(first_name,' ', last_name) as Owner
from game join member
where game.member_id = member.member_id;

/*3. Which member has what game on loan?*/
select title, first_name, last_name
from member join loan join game
where member.member_id = loan.member_id and loan.game_id = game.game_id;

/*4. How many total members are in the system*/
select count (*) 
from members;

/*5. What is the oldest current loan?*/
select loan_id, start_date
from loan
where end_date is null
having min(start_date);

/*6. Who has borrowed a game from Eric?*/
select loan_id, concat(member.first_name,' ', member.last_name) as Borrower, phone
from loan join member join OwnedBy
where loan.member_id = member.member_id and loan.game_id = OwnedBy.game_id and OwnedBy.first_name = 'Eric';

/*7. Which games are MMO? */
select title
from game join is_part_of join genre
where game.game_id = is_part_of.game_id and is_part_of.genre_id = genre.genre_id and genre.genre_name = 'MMO';

/*8. Which games are played on PS4 and who owns them?*/
select game.title, concat(first_name,' ', last_name) as Owner
from OwnedBy join game join console
where OwnedBy.game_id = game.game_id and game.console_id = console.console_id and console.console_name = 'PS4';

/*9. What is the average loan length*/
select avg(end_date - start_date) as 'average loan days'
from loan;

/*10. How many games does each member own?*/
select concat(first_name,' ', last_name) as Owner, count(distinct game_id)
from OwnedBy
group by Owner;