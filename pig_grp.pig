cars = LOAD 
'hdfs://localhost:54310/PDA/cars/' USING
PigStorage(',')
AS (
	 id:int
	,city:chararray
	,price:double
	,year:int
	,manufacturer:chararray
	,conditon:chararray
	,cylinders:chararray
	,fuel:chararray
	,odometer:int
	,trans:chararray
	,drive:chararray
	,carsize:chararray
	,cartype:chararray
	,paintColor:chararray
	,latitude:chararray
	,longitude:chararray
	,countyName:chararray
	,stateName:chararray
	,weather:int
);

pigq1 = group cars by cartype;
pigq1_grp = FOREACH pigq1 GENERATE group, COUNT(cars.cartype);
STORE pigq1_grp INTO 'hdfs://localhost:54310/PDA/pig/pigq1_grp';

pigq2 = group cars by paintColor;
pigq2_grp = FOREACH pigq2 GENERATE group, COUNT(cars.paintColor); 
STORE pigq2_grp INTO 'hdfs://localhost:54310/PDA/pig/pigq2_grp';
