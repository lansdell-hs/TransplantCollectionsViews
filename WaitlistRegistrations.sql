--Points at correct database with write permissions
USE SomeResearchDBname 
--Drops view if it exists
if object_id('TransplantCTR_WL', 'v') is not null drop view TransplantCTR_WL;
go 

/*Creates the view as the result of the below queries. Pulling multiple columns from the main Waitlist table and then select 
columns from the individual organ datasets*/
CREATE VIEW [TransplantCTR_WL] AS --general columns from time of registration on Waitlist, common to all organs
--All fields from main waitlist table.	
select
   wl.reg_id,
   wl.bloodty,
   wl.start_age,
   wl.org_reg as organ,
   wl.reg_date,
   wl.reg_ctr as center,
   wl.gender,
   wl.start_cpra,
   wl.timewaiting,
   wl.END_AGE,
   wl.stop_date,
   wl.regremovaldate,
   wl.verifdeathdate,
   wl.transplanted,
   wl.res_state_reg,
   wl.res_zip_reg,
   wl.transplantdate,
   wl.res_region_reg as region,
   wl.causedeath,
 --Description columns from lookup table, audit id to link tables   
   a.audit_id,
   remcd.descrip as removal,
   cd.descrip as status,
   ir.descrip as Inact_reason,
   e.descrip as ethnicity,
  
  --Kidney only
   wlKP.DIALYSIS_DATE,
   wlKP.start_epts,
   wlKP.alloc_days,
   wlKP.ISO_KP,
   
   --Liver only
   wlLI.meld_peld_lab,
  
  --Thoracic only
   wlTH.match_las_reg,
   wlTH.calc_las_reg,
--Roll up Blood subgroups   
   CASE WHEN wl.bloodty in ('A','A1','A2','A2B')
       then 'A' 
	   else wl.bloodty
          
   end as blood_type, 
  --Roll up specific diagnostic codes into committee approved higher level categories.     
   CASE WHEN wlKP.diag_reg IN (3XXX, 30XX, 3XXX, 3XXX, 3XXX, XXX4, XXX5, XXXXX6, XXXXX6, XXXX8, XXXXXX4, XXXXXX1, XXX2, X3, XXX5, XXXX2, XXXX, XXX9, XXXX4, XXXXX5, XX4, X7, XX8, XXXX)
      THEN 'Glomerular Disease'
          
      WHEN  wlKP.diag_reg IN (3XXX, 30XX, 3XXX, 3XXX, 3XXX, XXX4, XXX5, XXXXX6, XXXXX6, XXXX8, XXXXXX4, XXXXXX1, XXX2, X3, XXX5)
      THEN 'Tubular/Interstitial Disease'
          
      WHEN wlKP.diag_reg IN (XXXXXX)
      THEN 'Polycystic Kidney Disease (PKD)'
          
      WHEN wlKP.diag_reg IN (3XXX, 30XX, 3XXX, 3XXX, 3XXX, XXX4, XXX5)  
      THEN 'Diabetes' 
         
      WHEN wlKP.diag_reg IN (XX)
      THEN 'Retransplant/Graft Failure' 
         
      WHEN wlKP.diag_reg IN (XXXX, 3XXX)
      THEN 'Hypertension' 
         
      WHEN wlLI.diag_reg BETWEEN XXXX AND XXXX OR wlLI.diag_reg BETWEEN XX92 AND XX94
      THEN 'Acute Hepatic Necrosis' 
         
      WHEN wlLI.diag_reg BETWEEN XX00 AND XX17 
      THEN 'Non-Cholestatic Cirrhosis' 
         
      WHEN wlLI.diag_reg BETWEEN XX20 AND XX45 OR wlLI.diag_reg = 4260                   
      THEN 'Cholestatic Liver Disease/Cirrhosis'
          
      WHEN wlLI.diag_reg BETWEEN XX70 AND XX75
      THEN 'Biliary Atresia' 
         
      WHEN wlLI.diag_reg BETWEEN XX00 AND 4315 
      THEN 'Metabolic Disease'
          
      WHEN wlLI.diag_reg BETWEEN XX00 AND XX30       
      THEN 'Malignant Neoplasms' 
         
      WHEN wlLI.diag_reg BETWEEN XX50 AND XX55
      THEN 'Benign Neoplasms'
           
      WHEN wlTH.[GROUPING] = 'A'    
      THEN 'Obstructive Lung Disease'
          
      WHEN wlTH.[GROUPING] = 'B'
      THEN 'Pulmonary Vascular Disease'
          
      WHEN wlTH.[GROUPING] = 'C'          
      THEN 'Cystic Fibrosis and Immunodeficiency Disorder'
          
      WHEN wlTH.[GROUPING] = 'D'         
      THEN 'Restrictive Lung Disease'
          
      WHEN wlTH.[GROUPING] = 'H'
      THEN 'Heart Diease' 
          
      ELSE 'Other/Not Reported'
          
   END as Diagnosis, 
 --Set categorical bins on Ages   
   CASE WHEN wl.START_AGE between 0 and 1 
      then '<1'
      
	  WHEN wl.START_AGE between 1 and 5 
	  then '1-5'
      
	  WHEN wl.START_AGE between 6 and 10 
	  then '6-10'
      
	  WHEN wl.START_AGE between 11 and 17 
	  then '11-17'
      
	  WHEN wl.START_AGE between 18 and 26 
	  then '18-26'
      
	  WHEN wl.START_AGE between 26 and 34 
	  then '26-34'
      
	  WHEN wl.START_AGE between 35 and 49 
	  then '35-49'
      
	  WHEN wl.START_AGE between 50 and 64 
	  then '50-64'
      
	  WHEN wl.START_AGE between 65 and 1000 
	  then '65+'
    
    End as Age_at_Listing,
--Set categorical bins on LAS scores 	
   CASE
      WHEN wlTH.match_las_reg between 0 and 20         
      then '<20' 
         
      WHEN wlTH.match_las_reg between 20 and 30         
      then '20-<30' 
         
      WHEN wlTH.match_las_reg between 30 and 35         
      then '30-<35' 
          
      WHEN wlTH.match_las_reg between 35 and 40          
      then '35-<40' 
         
      WHEN wlTH.match_las_reg between 40 and 50          
      then '40-<50' 
         
      WHEN wlTH.match_las_reg between 50 and 60          
      then '50-<60'
          
      WHEN wlTH.match_las_reg between 60 and 70          
      then '60-<70' 
         
      WHEN wlTH.match_las_reg between 70 and 1000          
      then '70+'
          
   End as LAS_list,
 --Set categorical bins on CPRA at Listing     
   CASE WHEN wl.start_cpra = 0          
      then '0%'
           
      WHEN wl.start_cpra between 1 and 20          
      then '1-20%' 
          
      WHEN wl.start_cpra between 21 and 79          
      then '21-79%'
          
      WHEN wl.start_cpra between 80 and 97          
      then '80-97%'
          
      WHEN wl.start_cpra between 98 and 100          
      then '98-100%'
          
   End as CPRA_init,
 --Set categorical bins on EPTS at listing 	
   --only applies to Kidney/Pancreas:
   CASE WHEN wl.org_reg in ('KI', 'KP') and wlKP.start_epts between 0 and 20 
      then '0-20%' 
         
      WHEN wl.org_reg in ('KI', 'KP') and wlKP.start_epts between 0 and 20 
      then '>20%' 
        
      WHEN wl.org_reg in ('KI', 'KP') and wlKP.start_epts is NULL       
      then 'Not Reported' 
         
   End as EPTS_init, 
 --Set categorical bins on Time at Dialysis at listing     
   CASE WHEN wl.org_reg in ('KI', 'KP') and wl.reg_date >= wlKp.DIALYSIS_DATE and DATEDIFF(d, wlKP.dialysis_date, wl.reg_date) between 0 and 364 
      then '<1 Year' 
         
      WHEN wl.org_reg in ('KI', 'KP') and wl.reg_date >= wlKp.DIALYSIS_DATE  and DATEDIFF(d, wlKP.dialysis_date, wl.reg_date) between 365 and 1094 
      then '1-3 Years' 
         
      WHEN wl.org_reg in 'KI', 'KP') and wl.reg_date >= wlKp.DIALYSIS_DATE and DATEDIFF(d, wlKP.dialysis_date, wl.reg_date) between 1095 and 1825 
      then '3-5 Years' 
         
      WHEN wl.org_reg in ('KI', 'KP') and wl.reg_date >= wlKp.DIALYSIS_DATE and DATEDIFF(d, wlKP.dialysis_date, wl.reg_date) between 1826 and 6000000     
      then '5+ Year' 
         
      WHEN wl.org_reg in ('KI', 'KP') and wlKP.DIALYSIS_DATE is NULL or wlKp.DIALYSIS_DATE >= wl.reg_date  
      then 'Not on Dialysis' 
         
   End as Time_Dial, 	
   --Set categorical bins on MELD/PELD at Listing   
   --only applies to liver
   CASE WHEN wl.org_reg = 'LI' and wlLI.meld_peld_lab between 0 and 15
      then 'MELD/PELD <15' 
         
      WHEN wl.org_reg = 'LI' and wlLI.meld_peld_lab between 15 and 22
      then 'MELD/PELD 15-22'
          
      WHEN wl.org_reg = 'LI' and wlLI.meld_peld_lab between 23 and 34
      then 'MELD/PELD 23-34' 
         
      WHEN wl.org_reg = 'LI' and wlLI.meld_peld_lab between 35 and 1000
      then 'MELD/PELD 35+'
          
      WHEN wl.org_reg = 'LI' and wlLI.meld_peld_lab = NULL         
      then 'Not Reported'
          
   End as LabMeldPeld 
   
from
   SomeResearchDataSet.DSV.Waitlist wl 
   left join
      SomeResearchDataSet.DSV.WaitlistKP wlKP 
      on wlKP.reg_id = wl.reg_id 
   left join
      SomeResearchDataSet.DSV.WaitlistLiver wlLI 
      on wlLI.reg_id = wl.reg_id 
   left join
      SomeResearchDataSet.DSV.WaitlistThoracic wlTH 
      on wlTH.reg_id = wl.reg_id 
   left join
      SomeResearchDataSet.DSV.WaitlistIntestine wlIN 
      on wlIN.reg_id = wl.reg_id 
   left join
      OrgAdminDatabase.dbo.audit a 
      on a.reg_id = wl.reg_id 
      and change_ty = 'Active' 
   left join
      OrgAdminDatabase.dbo.status cd 
      on cd.id = wl.start_STAT 
   left join
      OrgAdminDatabase.dbo.inact_reason ir 
      on ir.inact_reason_cd = a.inact_reason_cd 
   left join
      OrgAdminDatabase.dbo.audit_kipa akp 
      on akp.audit_id = wl.audit_id 
   left join
      OrgAdminDatabase.dbo.Ethnicity_Race e 
      on e.Cd = wl.ethcat 
   left join
      OrgAdminDatabase.dbo.thoracic_dgn thdx 
      on thdx.cd = wlTH.THORACIC_DGN 
   left join
      [OrgAdminDatabase].[dbo].[rem_cd] remcd 
      on remcd.cd = wl.REM_CD 
   left join
      OrgAdminDatabase.dbo.txinstitutions ins 
      on ins.ctr_cd = substring(wl.reg_ctr, 1, 4) 
where
   wl.reg_date between DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0) and iif(datepart(dd,getdate())<15,DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-2, -1),DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) ;
