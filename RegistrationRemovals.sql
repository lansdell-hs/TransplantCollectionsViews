/*Points at correct database with write permissions
USE SomeResearchDBName
--Drops view if it exists

if object_id('TransplantCTR_WLREM','v') is not null
drop view TransplantCTR_WLREM;*/

/*Creates the view as the result of the below queries. Pulling multiple columns from the main Waitlist table and then select columns from
the individual organ datasets. Seperate from the registration dataset to focus purely on Removal on the Waitlist */

CREATE VIEW [TransplantCTR_WLREM] AS 
select
--All fields from main waitlist table.
   wl.reg_id,
   wl.org_reg as organ,
   wl.listing_ctr as center,
   wl.gender,
   wl.END_AGE,
   wl.stop_date,
   wl.regremovaldate,
   wl.verifdeathdate,
   wl.transplanted,
   wl.transplant_date,
   wl.res_region_end as region,
   wl.causedeath,

--Create quarters of the year for analysis groups testing
   case when DATENAME(quarter, wl.regremovaldate)=1 
    then '1Q'
    
    when DATENAME(quarter, wl.regremovaldate)=2 
    then '2Q'
    
    when DATENAME(quarter, wl.regremovaldate)=3 
    then '3Q'
   else '4Q'
   end as quart,					

--Set categorical bins on Ages					
    CASE WHEN wl.END_AGE between 0 and 1 
    then '<1'
      
      WHEN wl.END_AGE between 1 and 5 
      then '1-5'
      
      WHEN wl.END_AGE between 6 and 10 
      then '6-10'
      
      WHEN wl.END_AGE between 11 and 17 
      then '11-17'
      
      WHEN wl.END_AGE between 18 and 26 
      then '18-26'
      
      WHEN wl.END_AGE between 26 and 34 
      then '26-34'
      
      WHEN wl.END_AGE between 35 and 49 
      then '35-49'
      
      WHEN wl.END_AGE between 50 and 64 
      then '50-64'
      
      WHEN wl.END_AGE between 65 and 1000 
      then '65+'   
    End as Age_at_Removal,   
  	

--Set categorical bins on Reasons for Removal      
  CASE WHEN wl.REM_CD in (4,18,19) 
  then 'Deceased Donor Transplant'
	  
    when wl.REM_CD in (8,13) 
    then 'Death'
	  
    when wl.REM_CD in (7,14) 
    then 'Transferred/Transplanted at another Center'
	  
    when wl.REM_CD=15 
    then 'Living Donor Transplant'
	  
    when wl.REM_CD=12 
    then 'Condition Improved, TX unecessary'
	  
    when wl.REM_CD in (10,16,20,24) 
    then 'Removal due to Error/Patient or Center Inactivity'
	else 'Other Removal'  
    End as Removal  
 


from
   SomeResearchDataSet.DSV.Waitlist wl 
   left join
      OrgAdminDatabase.dbo.audit_kipa akp 
      on akp.audit_id = wl.audit_id OrgAdminDatabase.dbo.Ethnicity_Race e 
      on e.Cd = wl.ethcat [OrgAdminDatabase].[dbo].[rem_cd] remcd 
      on remcd.cd = wl.REM_CD 
where
   wl.regremovaldate between '2016-01-01' and GETDATE() 
   and wl.org_reg in ('HR', 'LU', 'KP', 'KI', 'LI', 'PA');
