CREATE TABLE Directors (
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL,
	Surname nvarchar(50) NOT NULL
	
)

CREATE TABLE Movies (
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL UNIQUE,
	Decription nvarchar(250) NOT NULL,
	CoverPhoto nvarchar ,
	DirectorId int FOREIGN KEY REFERENCES Directors(Id),
	LanguageId int FOREIGN KEY REFERENCES Languages(Id)
	
)


CREATE TABLE Actors (
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL,
	Surname nvarchar(50) NOT NULL,
	MovieId int FOREIGN KEY REFERENCES Movies(Id)
)

CREATE TABLE Genres (
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL,
	MovieId int FOREIGN KEY REFERENCES Movies(Id)
)

CREATE TABLE Languages (
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL,
)


INSERT INTO Directors VALUES
('Sam', 'Raimi'),
('Won-Tae', 'Lee'),
('Sophie', 'Holland'),
('Matt', 'Duffer')

INSERT INTO Movies VALUES
('Drag Me to Hell', 
'When loan officer Christine Brown refuses an old lady an extension on her loan, the lady places a curse of the Lamia upon Christine. Once cursed, Christines life is turned into a living nightmare.',
NULL,
1,
2
),
('The Gangster, the Cop, the Devil', 
'A vengeful crime boss forms an unlikely partnership with a detective to catch the elusive serial killer who viciously attacked him.',
NULL,
2,
3
),
('Witcher', 
'The witcher Geralt, a mutated monster hunter, struggles to find his place in a world in which people often prove more wicked than beasts.',
NULL,
3,
1
),
('Stranger Things', 
'In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries.',
NULL,
4,
1
)


SELECT * FROM Actors

INSERT INTO Actors VALUES
('Alison','Lohman',1),
('Bonnies','Aarons',1),
('Ma','Dong-Seok',2),
('Lee','Eun-Saem',2),
('Henry','Cavill',3),
('Freya','Allan',3),
('Millie Bobby','Brown',4),
('Noah','Schnapp',4)

INSERT INTO Genres VALUES
(' Horror/Supernatural',1),
('Action/Crime',2),
('Fantasy',3),
('Drama',4)

INSERT INTO Languages VALUES
('English'),
('Russian'),
('Korean')


----1

CREATE OR ALTER PROCEDURE usp_GetMoviesAndLanguagesWithDirectorId @directorId int
AS
BEGIN
	SELECT m.Name , l.Name FROM Directors AS d
	inner Join Movies as m
	ON d.Id = m.DirectorId
	inner join Languages as l
	ON l.Id = m.LanguageId
	WHERE  d.Id = @directorId
END


EXEC usp_GetMoviesAndLanguagesWithDirectorId 4


----2

CREATE OR ALTER FUNCTION GetCountOfMoviesWithSameLanguage(@languageId int)
RETURNS int
AS
BEGIN
	DECLARE @COUNT int

	SELECT @COUNT = Count(*) FROM Movies AS m
	WHERE m.LanguageId = @languageId

	RETURN @COUNT
END

SELECT dbo.GetCountOfMoviesWithSameLanguage (1)



CREATE OR ALTER PROCEDURE usp_GETMoviesAndDirectorsByGenre @genreId int
AS
BEGIN
    SELECT M.Id, M.Name AS MovieName, D.Name AS DirectorName, D.Surname AS DirectorSurname
    FROM Movies M
    INNER JOIN Directors D ON M.DirectorId = D.Id
    INNER JOIN Genres G ON M.Id = G.MovieId
    WHERE G.Id = @genreId;
END


EXEC usp_GETMoviesAndDirectorsByGenre 4