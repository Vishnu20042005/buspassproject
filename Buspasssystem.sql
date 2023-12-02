drop database buspasssystem;

Create database buspasssystem;

use buspasssystem;

create table user(
	userid varchar(30) primary key,
    password varchar(40),
    name varchar(60),
    address varchar(100),
    dob date,
    phone bigint,
    gender varchar(10),
    email varchar(30)
);

Insert into user values("Sid","9876","Siddartha","Hyderabad","2002:03:12",9876543210,"Male","chsiddu@gmail.com");

create table city(
	cityid varchar(10) primary key,
    cityname varchar(50),
    state varchar(30)
);

insert into city values("HYD","Hyderabad","Telangana");
insert into city values("CHE","Chennai","Tamil Nadu");
insert into city values("DEL","Delhi","Delhi");



create table citybuspass(
	buspassid int primary key auto_increment,
    name varchar(60),
    fathername varchar(60),
	userid varchar(30),
    cityid varchar(10),
    issuedate date,
    expirydate date,
    student bool,
    handicapped bool,
    seniorcitizen bool,
    aadharno bigint,
    aadharpath varchar(200),
    documentpath varchar(200),
    status varchar(30),
    buspasssoftcopy varchar(200),
    foreign key(userid) references user(userid),
    foreign key(cityid) references city(cityid)
);

select documentpath from citybuspass;

create table BSP(
	BSPid int primary key,
    Name varchar(40),
    phone bigint,
    address varchar(100),
    noofbuses int,
    rating float,
    totalratings int
);

insert into BSP values (1,"Sri Travels","9876543210","Hyderabad",2,5,1);
insert into BSP values (2,"Ram Travels","9876543211","Delhi",1,5,1);

create table bus(
	busid int primary key,
    BSPid int,
	registrationno varchar(20),
    model varchar(30),
    ac bool,
    sleeper bool,
    capacity int,
    rating float,
    totalratings int,
    insurance bool,
    foreign key(BSPid) references BSP(BSPid)
);

insert into bus values (1,1,"AP28Z1234","luxury",1,1,30,5,1,1);
insert into bus values (2,1,"TN28Z1534","luxury",1,0,30,5,1,1);
insert into bus values (3,2,"TS28Z7834","luxury",1,0,30,5,1,1);

create table route(
	routeid int primary key,
	startcity varchar(10),
    endcity varchar(10),
    acprice int,
    nonacprice int,
    sleeperprice int,
    foreign key(startcity) references city(cityid),
    foreign key(endcity) references city(cityid)
);

insert into route values(1,"DEL","CHE",1000,800,1200);
insert into route values(2,"HYD","CHE",500,300,600);
insert into route values(3,"DEL","HYD",800,500,900);

create table runningpath(
	busid int,
    routeid int,
    starttime time,
    startstopnumber int,
    startdayno int,
    endtime time,
    endstopnumber int, 
    enddayno int,
    primary key(busid, routeid),
	foreign key(busid) references bus(busid),
    foreign key(routeid) references route(routeid)
);

insert into runningpath values(1,1,"14:00:00",1,1,"16:00:00",3,1);
insert into runningpath values(1,2,"15:00:00",2,1,"16:00:00",3,1);
insert into runningpath values(1,3,"14:00:00",1,1,"15:00:00",2,1);
insert into runningpath values(2,2,"20:00:00",1,1,"21:00:00",2,1);
insert into runningpath values(3,2,"11:00:00",1,1,"12:00:00",2,1);

create table amenities(
	busid int primary key,
    flexiticket bool,
    flexiticketprice int,
    bedsheet bool,
    waterbottle bool,
    blankets bool,
    wifi bool,
    chargingpoint bool,
    movie bool,
    washroom bool,
    readinglight bool,
    pillow bool,
    firstaid bool,
    cctv bool,
    vaccinationstatusofstaff bool,
    foreign key(busid) references bus(busid)
);

insert into amenities values(1,1,100,1,1,1,1,1,1,1,1,1,1,1,1);
insert into amenities values(2,1,100,1,1,1,1,1,1,1,1,1,1,1,1);
insert into amenities values(3,0,0,1,1,1,1,1,1,1,0,1,1,0,1);

create table carddetails(
	userid varchar(30),
	creditcardno int,
    expirydate varchar(6),
    name varchar(50),
    Bankname varchar(100),
    primary key(userid,creditcardno),
    foreign key(userid) references user(userid)
);

create table ticket(
	bookingid int primary key,
	userid varchar(30),
    busid int,
    routeid int,
    dateofjourney date,
    seats varchar(30),
    price int,
    transactionid varchar(30),
    dateofbooking date,
    ticketsoftcopy varchar(200),
    status varchar(10),
    foreign key(userid) references user(userid),
    foreign key(busid) references bus(busid),
    foreign key(routeid) references route (routeid)
);

insert into ticket values(1,"Sid",1,1,"2022:03:20","L-1,L-2",1900,"AS98","2022:03:17","dsd","CNF");
insert into ticket values(2,"Sid",1,2,"2022:03:24","L-15",1400,"AS46668","2022:03:18","dsd","CXL");
insert into ticket values(3,"Sid",1,3,"2022:03:28","L-1,L-22",2900,"AS322498","2022:03:19","dsd","CNF");
insert into ticket values(4,"Sid",1,3,"2022:03:28","L-12,L-13",1900,"AS32992498","2022:03:19","dsd","CNF");
insert into ticket values(5,"Sid",1,3,"2022:04:28","L-24,L-25,L-26",4900,"AS498","2022:03:30","dsd","CNF");
insert into ticket values(6,"Sid",2,3,"2022:04:30","L-25,L-26",400,"AS498","2022:03:30","dsd","CNF");
insert into ticket values(7,"Sid",3,3,"2022:04:30","L-4,L-5,L-6",2900,"AS498","2022:03:30","dsd","CNF");

create table passengerdetails(
	passengerid int primary key,
	bookingid int,
    userid varchar(30),
    name varchar(50),
    mobile bigint,
    gender varchar(10),
    age int,
    foreign key(bookingid) references ticket(bookingid),
    foreign key(userid) references user(userid)
);

create table seatavailability(
	busid int,
    routeid int,
    dateofjourney date,
    seatsavailable int,
    seatsbooked int,
    bookedseats varchar(200),
    primary key(busid,routeid,dateofjourney),
	foreign key(busid) references bus(busid),
    foreign key(routeid) references route(routeid)
);

insert into seatavailability values(1,1,"2022:03:20",30,0,"");
insert into seatavailability values(1,2,"2022:03:20",30,0,"");
insert into seatavailability values(1,3,"2022:03:20",30,0,"");
insert into seatavailability values(1,1,"2022:04:04",30,0,"");
insert into seatavailability values(1,2,"2022:04:04",30,0,"");
insert into seatavailability values(1,3,"2022:04:04",30,0,"");
insert into seatavailability values(2,2,"2022:03:20",30,0,"");
insert into seatavailability values(2,2,"2022:03:31",30,0,"");
insert into seatavailability values(2,2,"2022:03:30",30,0,"");
insert into seatavailability values(2,2,"2022:04:04",30,0,"");
insert into seatavailability values(3,2,"2022:03:20",30,0,"");

create table admin(
	adminid int primary key,
    name varchar(50),
    password varchar(50)
);

create table driverdetails(
	driverid int primary key,
    name varchar(50),
    license varchar(30),
    phone bigint
);

create table drivingdetails(
	driverid int,
	busid int,
    dateoftravel date,
    primary key(driverid, busid, dateoftravel),
    foreign key(driverid) references driverdetails(driverid),
    foreign key(busid) references bus(busid)
);



create table feedback(
	busid int,
    ticketid int,
    userid varchar(30),
    feedback varchar(1000),
    primary key(busid,userid,ticketid),
    foreign key(userid) references user(userid),
    foreign key(ticketid) references ticket(bookingid),
    foreign key(busid) references bus(busid)
);