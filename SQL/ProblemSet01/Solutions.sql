<PROBLEMSET 01> JULY 31,2018
SUBMITTED BY nivetha.seenivasan


Hotel              (Hotel_No, Name, City)

create table Hotel(Hotel_No text PRIMARY KEY,Name text,City text);

Insert into Hotel values('H111','Empire Hotel','New York');
Insert into Hotel values ('H235','Park Place','New York');
Insert into Hotel values('H432','Brownstone Hotel','Toronto');
Insert into Hotel values('H498','James Plaza','Totonto');
Insert into Hotel values('H193','Devon Hotel','Boston');
Insert into Hotel values('H437','Clairmont Hotel','Boston');


Room               (Room_No, @Hotel_No, Type, Price)

create table Room(Room_No text,Hotel_No text references Hotel(Hotel_No),Type text,Price text,Constraint pk_key PRIMARY KEY(Room_No,Hotel_No));

Insert into Room values('313','H111','S',145.00);
Insert into Room values('412','H111','N',145.00);
Insert into Room values('1267','H235','N',175.00);
Insert into Room values('1289','H235','N',195.00);
Insert into Room values('876','H432','S','124.00);
                        
                        
Booking            (@Hotel_No, @Guest_No, Date_From, Date_To, @Room_No)

create table Booking(Hotel_No text references Room(Hotel_No),Guest_No text references Guest(Guest_No),Date_From text,Date_To text,Room_No text references Room(Room_No),Constraint pk_key PRIMARY KEY(Hotel_No,Guest_no,Room_No));

INSERT INTO BOOKING VALUES('H111','G256','10-AUG-99','15-AUG-99',412);
INSERT INTO BOOKING VALUES('H111','G367','18-AUG-99','21-AUG-99',412);
INSERT INTO BOOKING VALUES('H235','G879','05-SEP-99','12-SEP-99',1267);
INSERT INTO BOOKING VALUES('H498','G230','15-SEP-99','18-SEP-99',467);
INSERT INTO BOOKING VALUES('H498','G256','30-NOV-99','02-DEC-99',345);
INSERT INTO BOOKING VALUES('H498','G467','03-NOV-99','05-NOV-99',345);
INSERT INTO BOOKING VALUES('H193','G190','15-NOV-99','19-NOV-99',1001);
INSERT INTO BOOKING VALUES('H193','G367','12-SEP-99','14-SEP-99',1001);
INSERT INTO BOOKING VALUES('H193','G367','01-OCT-99','06-OCT-99',1201);
INSERT INTO BOOKING VALUES('H437','G190','04-OCT-99','06-OCT-99',223);
INSERT INTO BOOKING VALUES('H437','G879','14-SEP-99','17-SEP-99',223);
                        
                        
Guest              (Guest­_No, Name, City)

create table Guest(Guest_No text PRIMARY KEY,Name text,City text);

INSERT INTO GUEST VALUES('G256','ADAM WAYNE','PITTSBURGH');
INSERT INTO GUEST VALUES('G367','TARA CUMMINGS','BALTIMORE');
INSERT INTO GUEST VALUES('G879','VANESSA PARRY','PITTSBURGH');
INSERT INTO GUEST VALUES('G230','TOM HANCOCK','PHILADELPHIA');
INSERT INTO GUEST VALUES('G467','ROBERT SWIFT','ATLANTA');
INSERT INTO GUEST VALUES('G190','EDWARD CANE','BALTIMORE');



1.List full details of all hotels.

select a.Hotel_No,a.Name,a.City,b.Room_No,b.Type,b.Price from Hotel a inner join Room b ON a.Hotel_No=b.Hotel_No;

H111|Empire Hotel|New York|313|S|145
H111|Empire Hotel|New York|412|N|145
H235|Park Place|New York|1267|N|175
H235|Park Place|New York|1289|N|195
H432|Brownstone Hotel|Toronto|876|S|124
H432|Brownstone Hotel|Toronto|898|S|124
H498|James Plaza|Totonto|345|N|160
H498|James Plaza|Totonto|467|N|180
H193|Devon Hotel|Boston|1001|S|150
H193|Devon Hotel|Boston|1201|N|175
H437|Clairmont Hotel|Boston|257|N|140
H437|Clairmont Hotel|Boston|223|N|155

2.List full details of all hotels in New York.

select a.Hotel_No,a.Name,a.City,b.Room_No,b.Type,b.Price from Hotel a inner join Room b where a.Hotel_No=b.Hotel_No and a.City='New York';

H111|Empire Hotel|New York|313|S|145
H111|Empire Hotel|New York|412|N|145
H235|Park Place|New York|1267|N|175
H235|Park Place|New York|1289|N|195

3.List the names and cities of all guests, ordered according to their cities.

select * from GUEST order by City;

G467|ROBERT SWIFT|ATLANTA
G367|TARA CUMMINGS|BALTIMORE
G190|EDWARD CANE|BALTIMORE
G230|TOM HANCOCK|PHILADELPHIA
G256|ADAM WAYNE|PITTSBURGH
G879|VANESSA PARRY|PITTSBURGH


4.List all details for non-smoking rooms in ascending order of price.

select * from Room where Type='N' order by Price;

257|H437|N|140
412|H111|N|145
223|H437|N|155
345|H498|N|160
1267|H235|N|175
1201|H193|N|175
467|H498|N|180
1289|H235|N|195

5.List the number of hotels there are.

select count(Hotel_No) as COUNT from Hotel;

6


6.List the cities in which guests live. Each city should be listed only once.

select distinct City from Guest;


PITTSBURGH
BALTIMORE
PHILADELPHIA
ATLANTA

7.List the average price of a room.

select Type,avg(PRICE) as AVERAGE_PRICE from Room Group By Type;

 select Type,avg(PRICE) as AVERAGE_PRICE from Room Group By Type;
N|165.625
S|135.75

8.List hotel names, their room numbers, and the type of that room.

select a.Hotel_No,a.Name,b.Room_No,b.Type from Hotel a inner join Room b ON a.Hotel_No=b.Hotel_No;

H111|Empire Hotel|313|S
H111|Empire Hotel|412|N
H235|Park Place|1267|N
H235|Park Place|1289|N
H432|Brownstone Hotel|876|S
H432|Brownstone Hotel|898|S
H498|James Plaza|345|N
H498|James Plaza|467|N
H193|Devon Hotel|1001|S
H193|Devon Hotel|1201|N
H437|Clairmont Hotel|257|N
H437|Clairmont Hotel|223|N

9.List the hotel names, booking dates, and room numbers for all hotels in New York.

Select b.Name,a.Date_From,a.Date_To,a.Room_No,b.City from Booking a inner join Hotel b where a.Hotel_No=b.Hotel_No and b.City='New York';

Empire Hotel|10-AUG-99|15-AUG-99|412|New York
Empire Hotel|18-AUG-99|21-AUG-99|412|New York
Park Place|05-SEP-99|12-SEP-99|1267|New York

10.What is the number of bookings that started in the month of September?

Select * from Booking where Date_from Like '%SEP%';

H235|G879|05-SEP-99|12-SEP-99|1267
H498|G230|15-SEP-99|18-SEP-99|467
H193|G367|12-SEP-99|14-SEP-99|1001

11.List the names and cities of guests who began a stay in New York in August.


select b.Hotel_No,h.Name,b.Room_No,b.Guest_No,g.Name,g.City,b.Date_From,b.Date_To from Booking b inner join Hotel h inner join Guest g where b.Hotel_No=h.Hotel_No and h.City='New York' and b.Guest_No=g.Guest_No and b.Date_From Like '%AUG%';

H111|Empire Hotel|412|G256|ADAM WAYNE|PITTSBURGH|10-AUG-99|15-AUG-99
H111|Empire Hotel|412|G367|TARA CUMMINGS|BALTIMORE|18-AUG-99|21-AUG-99

12.List the hotel names and room numbers of any hotel rooms that have not been booked.

select h.Hotel_No,h.Name,r.Room_No from Hotel  h inner join Room r on h.Hotel_No=r.Hotel_No where r.Room_No not in (select distinct Room_No from Booking);

H235|Park Place|1289
H437|Clairmont Hotel|257
H111|Empire Hotel|313
H432|Brownstone Hotel|876
H432|Brownstone Hotel|898

13.List the hotel name and city of the hotel with the highest priced room.

select h.Hotel_No,h.Name,max(r.Price) from Hotel h inner Join Room r on h.Hotel_No=r.Hotel_No;

H235|Park Place|195


14.List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston hotel.

select h.Hotel_No,h.Name,r.Room_No,min(Price) from Room r inner join Hotel h on r.Hotel_No=h.Hotel_No where h.City='Boston';

H437|Clairmont Hotel|257|140



15.List the average price of a room grouped by city.


 select h.Hotel_No,h.Name,r.Room_No,avg(Price) from Room r inner join Hotel h on r.Hotel_No=h.Hotel_No group by City;


H437|Clairmont Hotel|223|155.0
H235|Park Place|1289|165.0
H432|Brownstone Hotel|898|124.0
H498|James Plaza|467|170.0


