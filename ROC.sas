/*IMPORT DATA*/
proc import datafile="/home/u62868661/Datasets/ROC/AS.csv"
dbms=csv
out=df
replace;
run;

/*DESCRIPTIVE TABLES*/
proc freq data=df;
	tables AS / plots=(freqplot);
run;

proc means data=df chartype min max median n vardef=df q1 q3 qrange 
		qmethod=os;
	var 'ASDAS-CRP'n 'ASDAS-ESR'n;
run;

/*ROC ANALYSIS*/
proc logistic data=df;
	model AS(event='1') = 'ASDAS-CRP'n 'ASDAS-ESR'n;
	roc"'ASDAS-CRP'n" 'ASDAS-CRP'n;
	roc"'ASDAS-ESR'n" 'ASDAS-ESR'n;
	roccontrast reference("'ASDAS-CRP'n")/estimate;
run;