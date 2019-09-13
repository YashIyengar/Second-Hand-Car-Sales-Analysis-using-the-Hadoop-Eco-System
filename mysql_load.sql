
USE cars;
TRUNCATE TABLE cars;
DROP TABLE cars;

create table cars(
	id int
	,city varchar(255)
	,price double
	,year int
	,manufacturer varchar(255)
	,conditon varchar(255)
	,cylinders varchar(255)
	,fuel varchar(255)
	,odometer int
	,trans varchar(255)
	,drive varchar(255)
	,carsize varchar(255)
	,cartype varchar(255)
	,paintColor varchar(255)
	,latitude varchar(255)
	,longitude varchar(255)
	,countyName varchar(255)
	,stateName varchar(255)
	,weather int
);

LOAD DATA LOCAL INFILE '/home/hduser/project/cars.csv'
INTO TABLE cars
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;