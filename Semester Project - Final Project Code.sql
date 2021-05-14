--This script will create the database Sports_Achievements and all eight tables
CREATE DATABASE Sports_Achievements;
go

USE Sports_Achievements;

CREATE TABLE Sports
(SportID	INT NOT NULL IDENTITY PRIMARY KEY,
SportName	VARCHAR(50) NOT NULL);

CREATE TABLE Teams
(TeamID	INT NOT NULL IDENTITY PRIMARY KEY,
TeamName	VARCHAR(50) NOT NULL,
SportID	INT	NOT NULL REFERENCES Sports(SportID));

CREATE TABLE Greatest_Athletes
(AthleteID	INT NOT NULL IDENTITY PRIMARY KEY,
LastName	VARCHAR(50) NULL,
FirstName	VARCHAR(50) NULL,
SportID		INT	NOT NULL REFERENCES Sports(SportID),
SportName	VARCHAR(50) NULL,
Position	VARCHAR(50) NULL);

CREATE TABLE Other_Achievements
(AchievementID	INT NOT NULL IDENTITY PRIMARY KEY,
AchievementName VARCHAR(50) NOT NULL,
SportID	INT NOT NULL REFERENCES Sports(SportID),
SportName	VARCHAR(50) NULL);

CREATE TABLE Sports_Records
(AthleteID	INT NOT NULL REFERENCES Greatest_Athletes(AthleteID),
LastName	VARCHAR(50) NULL,
FirstName	VARCHAR(50) NULL,
SportName	VARCHAR(50) NULL,
SportID	INT	NOT NULL REFERENCES Sports(SportID),
RecordID INT NOT NULL IDENTITY PRIMARY KEY,
RecordName	VARCHAR(50) NOT NULL);

go

CREATE TABLE BestAthletesoftheYear
(BestID	INT NOT NULL IDENTITY PRIMARY KEY,
Year	INT NOT NULL,
TeamID	INT	NOT NULL REFERENCES Teams(TeamID),
AthleteID	INT NOT NULL REFERENCES Greatest_Athletes(AthleteID),
AchievementID INT NULL REFERENCES Other_Achievements(AchievementID),
RecordID INT NULL REFERENCES Sports_Records(RecordID),
LastName	VARCHAR(50) NULL,
FirstName	VARCHAR(50) NULL);

CREATE TABLE Championships
(ChampionshipID	INT	NOT NULL IDENTITY PRIMARY KEY,
Year	INT NOT NULL,
SportID	INT NOT NULL REFERENCES Sports(SportID),
SportName	VARCHAR(50)	NULL, 
TeamName	VARCHAR(50) NULL,
TeamID	INT	NOT NULL REFERENCES Teams(TeamID));

CREATE TABLE MVP_Winners
(AthleteID	INT NOT NULL REFERENCES Greatest_Athletes(AthleteID),
LastName	VARCHAR(50) NULL,
FirstName	VARCHAR(50) NULL,
MVPID	INT	NOT NULL IDENTITY PRIMARY KEY,
Year	INT	NOT NULL,
SportName	VARCHAR(50) NULL,
SportID	INT	NOT NULL REFERENCES Sports(SportID),
TeamName	VARCHAR(50) NULL,
TeamID	INT NOT NULL REFERENCES Teams(TeamID));

--This script adds data to four tables in the Sports_Achievements database
USE Sports_Achievements;
go

INSERT INTO Sports (SportName)
VALUES 
	('Basketball'),
	('Baseball'),
	('Soccer'),
	('Football')

INSERT INTO Teams (TeamName, SportID)
VALUES
	('FC Barcelona', 03),
	('Golden State Warriors', 01),
	('Cleveland Browns', 04),
	('Atlanta Braves', 02),
	('Los Angeles Lakers', 01),
	('PSG', 03)

INSERT INTO Greatest_Athletes (LastName, FirstName, SportID, SportName, Position)
VALUES
	('Messi', 'Leo', 03, 'Soccer', 'Forward'),
	('Curry', 'Stephen', 01, 'Basketball', 'Point Guard'),
	('MayField', 'Baker', 04, 'Football', 'Quarterback'),
	('James', 'LeBron', 01, 'Basketball', 'Small Forward'),
	('Jones', 'Chipper', 02, 'Baseball', '3rd Baseman'),
	('Neymar', 'Junior', 03, 'Soccer', 'Forward'),
	('Jordan', 'Michael', 01, 'Basketball', 'Shooting Guard'),
	('Oneal', 'Shaq', 01, 'Basketball', 'Center'),
	('Johnson', 'Magic', 01, 'Basketball', 'Point Guard'),
	('Mantle', 'Mickey', 02, 'Baseball', null),
	('Mays', 'Willie', 02, 'Baseball', null),
	('Aaron', 'Hank', 02, 'Baseball', null),
	('Dimaggio', 'Joe', 02, 'Baseball', null),
	('Bonds', 'Barry', 02, 'Baseball', null),
	('McGwire', 'Mark', 02, 'Baseball', null),
	('Sosa', 'Sammy', 02, 'Baseball', null),
	('Johnson', 'Randy', 02, 'Baseball', null),
	('Biggio', 'Craig', 02, 'Baseball', null),
	('Sandberg', 'Ryan', 02, 'Baseball', null)


go

INSERT INTO Other_Achievements (AchievementName, SportID, SportName)
VALUES
	('Golden Glove Award', 02, 'Baseball'),
	('All-Star', 02, 'Baseball'),
	('All-NBA Team', 01, 'Basketball'),
	('Golden Boot', 03, 'Soccer'),
	('All-Pro', 04, 'Football')

--This script adds data to four tables in the Sports_Achievements database
go

INSERT INTO Sports_Records (AthleteID, LastName, FirstName, SportName, SportID, RecordName)
VALUES
	(1, 'Messi', 'Leo', 'Soccer', 3, 'Most Goals in La Liga'),
	(1, 'Messi', 'Leo', 'Soccer', 3, 'Most Goals in One Calendar Year'),
	(1, 'Messi', 'Leo', 'Soccer', 3, 'Most Assists in Soccer History'),
	(2, 'Curry', 'Stephen', 'Basketball', 1, 'Fewest Games Played to Reach 1,000 three-pointers'),
	(2, 'Curry', 'Stephen', 'Basketball', 1, 'Eight three-pointers in three consecutive games'),
	(2, 'Curry', 'Stephen', 'Basketball', 1, 'Most three-pointers in an NBA playoffs'),
	(2, 'Curry', 'Stephen', 'Basketball', 1, 'Only unanimous MVP in NBA history'),
	(2, 'Curry', 'Stephen', 'Basketball', 1, 'Most three-pointers in an NBA season, 402')
	

INSERT INTO BestAthletesoftheYear (Year, TeamID, AthleteID, AchievementID, RecordID, LastName, FirstName)
VALUES
	(2019, 1, 1, 4, 1, 'Messi', 'Leo'),
	(2018, 2, 2, 1, 5, 'Curry', 'Stephen')

INSERT INTO Championships (Year, SportID, SportName, TeamName, TeamID)
VALUES
	(1998, 2, 'Basketball', 'Golden State Warriors', 2)

INSERT INTO MVP_Winners (AthleteID, LastName, FirstName, Year, SportName, SportID, TeamName, TeamID)
VALUES
	(2, 'Curry', 'Stephen', 2016, 'Basketball', 1, 'Golden State Warriors', 2),
	(4, 'James', 'LeBron', 2013, 'Basketball', 1, 'Los Angeles', 5),
	(5, 'Jones', 'Chipper', 1999, 'Baseball', 2, 'Atlanta Braves', 4),
	(3, 'Curry', 'Stephen', 2015, 'Basketball', 1, 'Golden State Warriors', 2)

--This statement creates a view of the athletes in this database
go

create view AthletesInDatabase
as
select FirstName, LastName, Position
from Greatest_Athletes

--This statement creates a list of the sports achievements listed in this database
go

create view AchievementsInDatabase
as
select SportName, AchievementName
from Other_Achievements

--This statement creates a view of athletes along with their teams
go

create view TeamandPlayer
as
select FirstName, LastName, Position, TeamName
from Teams join Greatest_Athletes on Teams.SportID = Greatest_Athletes.SportID

--This statement is a query that lists the MVP Winners in this database
go

select FirstName, LastName, Year, SportName, TeamName 
from MVP_Winners
order by AthleteID;

--This statement returns the number of players from each sport in this database
go

select count(AthleteID) as Players, SportName
from Greatest_Athletes
group by SportName
Having Count(AthleteID) >= 0;

--A statement with an ISNULL function
go

select Position,
	isnull(Position, 'Player') as NewPosition
from Greatest_Athletes;




