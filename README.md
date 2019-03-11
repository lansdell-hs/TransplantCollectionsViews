# TransplantCollectionsViews

Several sql files to create views. The purpose of these views is to isolate the fields of interest across various data sets and schemas.
The data regards demographics and clinical information at the time of Registration, Transplant, Removal from the Organ Transplant Waiting List. Each time point is a seperate sql file. The creation of the aggregate views are in one sql file. Script was written in Microsoft SQL Server Management Studio. 

The flow of the process is as follows:

View creation to isolate fields,view creation from previous table to show aggregate sums, export to Tableau as data source.

The first view queries across multiple datasets and databases, including formatting look ups to convert raw quantitative values into qualitative bins. i.e: 

case when age between 1-3 then '1-3 Years' end as Age

A second sql file is then used to create another view creating aggregate level sums according to certain categories such as Organ, Age at Registration, Ethnicity, Diagnosis, and more. 

That table is used as the data source for a Tableau Packaged Workbook. I chart the change in the aggregate sums over time according to each categorical factor as a distribution. 

**Note: All table names, database names, and variable names were changed to protect systems information. 
