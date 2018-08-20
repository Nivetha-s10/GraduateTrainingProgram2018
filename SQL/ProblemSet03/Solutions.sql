
Submitted By Nivetha.Seenivasan

Movie ( mID, title, year, director ) 
create table Movie(mId Number Constraint pk_key PRIMARY KEY,title text,year Number(4),director text);

Reviewer ( rID, name )

create table Reviewer(rId Number Constraint pk_key PRIMARY KEY,name text);


Rating ( rID, mID, stars, ratingDate ) 

create table Rating(rId Number references from Reviewer(rId),mId Number references from Movie(mId),stars int,ratingDate Date);

1.Find the titles of all movies directed by Steven Spielberg. (1 point possible)

select title,year from Movie where director='Steven Spielberg';

E.T.|1982
Raiders of the Lost Ark|1981

2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)

select distinct year from Movie m inner join Rating r on m.mId=r.mId where stars=4 or stars=5 order by year;
1937
1939
1981
2009

3.Find the titles of all movies that have no ratings. (1 point possible)

select title from Movie where mId not in (select distinct mId  Rating r);
Star Wars
Titanic

4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

select rev.rId,name from Reviewer as rev inner join Rating as rate on rev.rId=rate.rId and ratingDate is NULL;

202|Daniel Lewis
205|Chris Jackson

5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate.
 Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

select name,title,stars,ratingDate from Reviewer as rev inner join Rating  as rate on rev.rId=rate.rId inner join Movie as mov on rate.mId=mov.mId order by name,title,stars;

Ashley White|E.T.|3|2011-01-02
Brittany Harris|Raiders of the Lost Ark|2|2011-01-30
Brittany Harris|Raiders of the Lost Ark|4|2011-01-12
Brittany Harris|The Sound of Music|2|2011-01-20
Chris Jackson|E.T.|2|2011-01-22
Chris Jackson|Raiders of the Lost Ark|4|
Chris Jackson|The Sound of Music|3|2011-01-27
Daniel Lewis|Snow White|4|
Elizabeth Thomas|Avatar|3|2011-01-15
Elizabeth Thomas|Snow White|5|2011-01-19
James Cameron|Avatar|5|2011-01-20
Mike Anderson|Gone with the Wind|3|2011-01-09
Sarah Martinez|Gone with the Wind|2|2011-01-22
Sarah Martinez|Gone with the Wind|4|2011-01-27

6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. 

7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.

select title,stars from Movie as mov inner join Rating as rate on mov.mId=rate.mId group by rate.mId having max(stars) order by title;

Avatar|5
E.T.|3
Gone with the Wind|4
Raiders of the Lost Ark|4
Snow White|5
The Sound of Music|3


8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. 
Sort by rating spread from highest to lowest, then by movie title. 

select title,max(stars)-min(stars) as ratingSpread from Movie as mov inner join Rating as rate on mov.mId=rate.mId group by rate.mId order by ratingSpread desc;

select title,max(stars)-min(stars) as ratingSpread from Movie as mov inner join Rating as rate on mov.mId=rate.mId group by rate.mId order by ratingSpread desc;
Gone with the Wind|2
Avatar|2
Raiders of the Lost Ark|2
The Sound of Music|1
E.T.|1
Snow White|1


9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after.
 Don't just calculate the overall average rating before and after 1980.) 

10.Find the names of all reviewers who rated Gone with the Wind. 

select distinct name from Reviewer as rev inner join Rating as rate on rev.rId=rate.rId inner join Movie as mov on rate.mId=mov.mId and title='Gone with the Wind';

Sarah Martinez
Mike Anderson

11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

select name,title,stars from Reviewer as rev inner join Rating as rate on rev.rId=rate.rId inner join Movie as mov on rate.mId=mov.mId and director=name;

James Cameron|Avatar|5

12.Return all reviewer names and movie names together in a single list, alphabetized. 
(Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) 

select distinct name,title from Reviewer as rev inner join Rating as rate on rev.rId=rate.rId inner join Movie as mov on rate.mId=mov.mId order by name,title; 

Ashley White|E.T.
Brittany Harris|Raiders of the Lost Ark
Brittany Harris|The Sound of Music
Chris Jackson|E.T.
Chris Jackson|Raiders of the Lost Ark
Chris Jackson|The Sound of Music
Daniel Lewis|Snow White
Elizabeth Thomas|Avatar
Elizabeth Thomas|Snow White
James Cameron|Avatar
Mike Anderson|Gone with the Wind
Sarah Martinez|Gone with the Wind

13.Find the titles of all movies not reviewed by Chris Jackson.

select title from Movie as mov where mov.mId not in ( select mId from Rating as rate inner join Reviewer as rev on name='Chris Jackson')

Star Wars
Titanic

14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once.For each pair, return the names in the pair in alphabetical order.


15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. 

select name,title,stars from Reviewer as rev inner join Rating as rate on rev.rId=rate.rId inner join Movie as mov on mov.mId=rate.mId where stars=(select min(stars) from Rating);

Sarah Martinez|Gone with the Wind|2
Brittany Harris|The Sound of Music|2
Brittany Harris|Raiders of the Lost Ark|2
Chris Jackson|E.T.|2

16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. 
select title,avg(stars) as star from Movie as mov inner join Rating as rate on mov.mId=rate.mId group by mov.mId order by star desc,title;

Snow White|4.5
Avatar|4.0
Raiders of the Lost Ark|3.33333333333333
Gone with the Wind|3.0
E.T.|2.5
The Sound of Music|2.5

17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) 

select rate.rId,name,count(rate.rId) as count from Rating as rate inner join Reviewer as rev on rate.rId=rev.rId group by rate.rId having count>=3;

203|Brittany Harris|3
205|Chris Jackson|3


18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. 
Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 


select title,director from Movie where director is not null and director in (select director from Movie group by director having count(director)>1) order by director,title;

Avatar|James Cameron
Titanic|James Cameron
E.T.|Steven Spielberg
Raiders of the Lost Ark|Steven Spielberg

19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating.
 (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 

select MID,title,max(star) from(select title,rate.mId as MID,avg(stars) as star from Movie mov inner join Rating rate on mov.mId=rate.mId group by rate.mId);

106|Snow White|4.5


20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
(Hint: This query may be more difficult to write in SQLite than other systems;
 you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) 

select MID,title,min(star) from(select title,rate.mId as MID,avg(stars) as star from Movie mov inner join Rating rate on mov.mId=rate.mId group by rate.mId);

103|The Sound of Music|2.5


21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating.
Ignore movies whose director is NULL. (1 point possible)

select director,title,max(stars) from Movie m inner join Rating r on m.mId=r.mId and director is NOT NULL group by r.mId;

Victor Fleming|Gone with the Wind|4
Robert Wise|The Sound of Music|3
Steven Spielberg|E.T.|3
James Cameron|Avatar|5
Steven Spielberg|Raiders of the Lost Ark|4
