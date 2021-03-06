--Points at correct database with write permissions
USE SomeResearchDBname 
--Drops view if it exists
if object_id('CTR_TX', 'v') is not null drop view CTR_TX;
go 
/*Creates the view as the result of the below queries. Pulling multiple columns from the main Transplant table and then select columns from
the individual organ datasets*/
CREATE VIEW [CTR_TX] AS 

select
--All fields from main transplant table.
   tx.transplant_id,
   tx.transplantdate,
   tx.abo,
   tx.gender,
   tx.region,
   tx.transplant_center as center,
   tx.organ,
   tx.donor_ty,
   tx.final_stat,
   tx.dcd,
   
   left(ns.zipcode,5) as tx_zip,
   left(l.zipcode,5) as opo_zip,
--Liver specific
   li.meld_peld_lab,
--Kidney/Pancreas specific
   kp.END_EPTS,
   st.descrip as share_ty,
   kp.STOP_CPRA,
   kp.creatinine,
   y.glomerularfr as adlt_glomerularfr,
   z.glomerularfr as ped_glomerularfr,
   
--Demographic descriptors from lookup tables   
   e.descrip as ethnicity,
   cd.descrip as status,
--Include foreign donors in deceased   
   case when tx.donor_ty in ('Dec','For') 
		then 'Dec'
		else 'Liv'
	end as donorty,
   
--Roll up specific diagnostic codes into committee approved higher level categories.   
   
   CASE WHEN tx.diag IN (3XXX,30XX,3XXX,3XXX,3XXX,XXX4,XXX5,XXXXX6,XXXXX6,XXXX8,XXXXXX4,XXXXXX1,XXX2,
            X3,XXX5,XXXX2,XXXX,XXX9,XXXX4,XXXXX5,XX4,X7,XX8,XXXX)         
      THEN 'Glomerular Disease' 
         
      WHEN tx.diag IN (XXX4, XXX5, XXXXX6, XXXXX6, XXXX8, XXXXXX4, XXXXXX1, XXX2, X3, XXX5, XXXX2, XXXX, XXX9, XXXX4)
      THEN 'Tubular/Interstitial Disease' 
         
      WHEN  tx.diag IN (XX)
      THEN 'Polycystic Kidney Disease (PKD)"' 
         
      WHEN tx.diag IN (XXXXXX4, XXXXXX1, XXX2, X3, XXX5, XXXX2)    
      THEN 'Diabetes' 
         
      WHEN  tx.diag IN ( 3XXXX)
      THEN 'Retransplant/Graft Failure' 
         
      WHEN tx.diag IN (3X, 3XX)
      THEN 'Hypertension' 
        
      WHEN tx.diag BETWEEN XX00 AND XX10 OR tx.diag BETWEEN XX92 AND XX94 
      THEN 'Acute Hepatic Necrosis'
          
      WHEN tx.diag BETWEEN XX00 AND XX17         
      THEN 'Non-Cholestatic Cirrhosis'
          
      WHEN tx.diag BETWEEN XX20 AND XX45 OR tx.diag = 4260           
      THEN 'Cholestatic Liver Disease/Cirrhosis'
          
      WHEN tx.diag BETWEEN XX70 AND XX75          
      THEN 'Biliary Atresia' 
         
      WHEN tx.diag BETWEEN XX00 AND XX15          
      THEN 'Metabolic Disease' 
         
      WHEN tx.diag BETWEEN XX00 AND XX30          
      THEN 'Malignant Neoplasms' 
         
      WHEN  tx.diag BETWEEN XX50 AND XX55         
      THEN 'Benign Neoplasms'
          
      WHEN TH.[GROUPING] = 'A'          
      THEN 'Obstructive Lung Disease' 
         
      WHEN TH.[GROUPING] = 'B'          
      THEN 'Pulmonary Vascular Disease' 
         
      WHEN TH.[GROUPING] = 'C'          
      THEN 'Cystic Fibrosis and Immunodeficiency Disorder'
          
      WHEN TH.[GROUPING] = 'D'          
      THEN 'Restrictive Lung Disease'
          
      WHEN TH.[GROUPING] = 'H'          
      THEN 'Heart Diease' 
      
      WHEN TX.diag between XX00 and XX07 or TX.diag=1049 
      THEN 'Dilated Myopathy'
	   
      WHEN TX.diag between XX50 and XX54 or TX.diag=1099 
      THEN 'Restrictive Myopathy'
	   
      WHEN TX.diag between XX00 and XX06 or TX.diag=1199 or TX.diag=1700  
      THEN 'Heart Re-Transplant'
	   
      WHEN TX.diag between XX05 and XX07 or TX.diag=1203 
      THEN  'Congenital Heart Disease'
	   
      WHEN TX.diag=X20X 
      THEN 'Coronary Artery Disease'
	   
      WHEN TX.diag=X20X 
      THEN 'Valvular Heart Disease'
	   
      WHEN TX.diag between XX97 and XX98 
      THEN 'Cardiac Disease'
         
      ELSE 'Other/Not Reported' 
         
   End as Diagnosis, 
--Group foreign donors into deceased
  case when tx.don_ty in ('C','F') 
	then 'C'
	else 'L'
	end as donorty,
   
--Set categorical bins on LAS scores   
   CASE WHEN TH.match_las_stop between 0 and 19 
      then '<20'  
       
      WHEN TH.match_las_stop between 20 and 29          
      then '20-<30' 
         
      WHEN TH.match_las_stop between 30 and 34
      then '30-<35' 
         
      WHEN TH.match_las_stop between 35 and 39       
      then '35-<40'
          
      WHEN TH.match_las_stop between 40 and 49   
      then '40-<50'
          
      WHEN TH.match_las_stop between 50 and 59         
      then '50-<60'
          
      WHEN TH.match_las_stop between 60 and 69 
      then '60-<70' 
         
      WHEN TH.match_las_stop between 70 and 1000    
      then '70+'
          
   End as LAS_tx,
--Set categorical bins on Ages    
   CASE WHEN tx.AGE <1 
      then '<1'
	   
      WHEN tx.AGE between 1 and 5 
      then '1-5'
	   
      WHEN tx.AGE between 6 and 10 
      then '6-10'
	   
      WHEN tx.AGE between 11 and 17 
      then '11-17'
	   
      WHEN tx.AGE between 18 and 26 
      then '18-26'
	   
      WHEN tx.AGE between 26 and 34 
      then '26-34'
	   
      WHEN tx.AGE between 35 and 49 
      then '35-49'
	   
      WHEN tx.AGE between 50 and 64 
      then '50-64'
	   
      WHEN tx.AGE between 65 and 1000 
      then '65+'
	
	End as Age_at_TX,
--Donor Ages
	CASE WHEN tx.AGE_donor <1
		then '<1'
		
		WHEN tx.AGE_donor between 1 and 5 
		then '1-5'
		
		WHEN tx.AGE_donor between 6 and 10 
		then '6-10'
		
		WHEN tx.AGE_donor between 11 and 17 
		then '11-17'
		
		WHEN tx.AGE_donor between 18 and 26 
		then '18-26'
		
		WHEN tx.AGE_donor between 26 and 34 
		then '26-34'
		
		WHEN tx.AGE_donor between 35 and 49 
		then '35-49'
		
		WHEN tx.AGE_donor between 50 and 64 
		then '50-64'
		
		WHEN tx.AGE_donor between 65 and 1000 
		then '65+'
	
        End as Donor_Age,
--Roll up Blood subgroups   
   CASE WHEN tx.ABO in ('A','A1',,'A1B','A2','A2B') 
      then 'A'
	   else tx.ABO
	end as blood_type,
--Set categorical bins on CPRA at transplant   
   CASE WHEN kp.STOP_CPRA=0 then '0%'
	
      WHEN kp.STOP_CPRA between 1 and 20 
      then '1-20%' 
	
      WHEN kp.STOP_CPRA between 21 and 79 
      then '21-79%' 
	
      WHEN kp.STOP_CPRA between 80 and 97 
      then '80-97%' 
	
      WHEN kp.STOP_CPRA between 98 and 100 
      then '98-100%' 

	End as CPRA_tx, 
--Set categorical bins on MELD/PELD at Transplant   
   CASE WHEN tx.organ='LI' and li.meld_peld_lab between 0 and 14 
      then 'MELD/PELD <15'
	   
      WHEN tx.organ='LI' and li.meld_peld_lab between 15 and 22 
      then 'MELD/PELD 15-22'
	   
      WHEN tx.organ='LI' and li.meld_peld_lab between 23 and 34 
      then 'MELD/PELD 23-34'
	   
      WHEN tx.organ='LI' and li.meld_peld_lab between 35 and 1000 
      then 'MELD/PELD 35+'
	   
      WHEN tx.organ='LI' and li.meld_peld_lab=NULL 
      then 'Not Reported'

	End as LabMeldPeld,
	
--Handling Liver Status
CASE WHEN tx.organ='LI' and tx.Final_stat=6XXX then 'Status 1'
	WHEN tx.organ='LI' and tx.Final_stat=6XXX then 'Status 1B'
    WHEN tx.organ='LI' and tx.Final_stat=6XXX	then 'Old status 4'
	WHEN tx.organ='LI' and tx.Final_stat=6XXX	then 'Status 3'
	WHEN tx.organ='LI' and tx.Final_stat=XXXX	then 'Status 2B'
	WHEN tx.organ='LI' and tx.Final_stat=XX9	then 'Temporarily Inactive'
	WHEN tx.organ='LI' and tx.Final_stat=XX2	then 'Old status 2'
	WHEN tx.organ='LI' and tx.Final_stat=XX1	then 'Status 1A'
	WHEN tx.organ='LI' and tx.Final_stat=XX0	then 'Status 2A'
	WHEN tx.organ='LI' and tx.Final_stat between 6XXX and 6XXX then 'MELD/PELD <15'
    WHEN tx.organ='LI' and tx.Final_stat  between XXXX and XXXX then 'MELD/PELD 15-22'
    WHEN tx.organ='LI' and tx.Final_stat between  XXXX and XXXX then 'MELD/PELD 23-34'
    WHEN tx.organ='LI' and tx.Final_stat between  XXXX and XXXX then 'MELD/PELD 35+'
    WHEN tx.organ='LI' and tx.Final_stat is NULL or tx.end_stat=XXXX then 'Not Reported'
	else cd.descrip
	End as TXStat,
--Set categorical bins on EPTS 
    CASE WHEN tx.organ in ('KI','KP') and kp.stop_epts between X and XXX then '0-20%'
    WHEN tx.organ in ('KI','KP') and kp.stop_epts  >XXX then '>20%'
    WHEN tx.organ in ('KI','KP') and kp.stop_epts  is NULL then 'Not Reported'
    
    End as EPTS_tx,

--Set categorical bins on Donor KDPI
   CASE WHEN tx.organ in ('KI','KP') and kp.KDPI between 0 and .35 
      then '0-35'
	   
      WHEN tx.organ in ('KI','KP') and kp.KDPI between .36 and .49 
      then '36-49'
	   
      WHEN tx.organ in ('KI','KP') and kp.KDPI between .50 and .85 
      then '50-85'
	   
      WHEN tx.organ in ('KI','KP') and kp.KDPI between .86 and 1 
      then '86+'
	   
      WHEN tx.organ in ('KI','KP') and kp.KDPI is NULL 
      then 'Not Reported'

	End as KDPI_tx,
--Set categorical bins on Kidney GFR
   CASE WHEN y.glomerularfr >= 0 and y.glomerularfr < 15    
      then '<15' 
         
      WHEN y.glomerularfr >= 15 and y.glomerularfr < 30
      then '15-29'
          
      WHEN y.glomerularfr >= 30 and y.glomerularfr < 45     
      then '30-44'
          
      WHEN y.glomerularfr >= 45 and y.glomerularfr < 60
      then '45-59'
      
      WHEN y.glomerularfr >= 60 and y.glomerularfr < 90 
      then '60-89'
          
      WHEN y.glomerularfr >= 90
      then '90+'
          
      WHEN z.glomerularfr >= 0 and z.glomerularfr < 15 
      then '<15' 
         
      WHEN z.glomerularfr >= 15 and z.glomerularfr < 30
      then '15-29' 
         
      WHEN z.glomerularfr >= 30 and z.glomerularfr < 45
      then '30-44' 
         
      WHEN z.glomerularfr >= 45 and z.glomerularfr < 60 
      then '45-59' 
         
      WHEN z.glomerularfr >= 60 and z.glomerularfr < 90  
      then '60-89'
          
      WHEN z.glomerularfr >= 90
      then '90+' 
         
   End
   as glomerularfr_final 

case when datepart(quarter,tx.transplant_dt)=1 then concat('March 31,',DATEPART(year,tx.transplant_dt)) 
	when datepart(quarter,tx.transplant_dt)=2 then concat('June 30,',DATEPART(year,tx.transplant_dt)) 
	when datepart(quarter,tx.transplant_dt)=3 then concat('September 30,',DATEPART(year,tx.transplant_dt)) 
	when datepart(quarter,tx.transplant_dt)=4 then concat('December 31,',DATEPART(year,tx.transplant_dt)) 
	end as caldate,	
										      
case when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) <8 then '0-7 days'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 8 and 31 then '8-31 days'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 32 and 90 then '1-3 months'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 91 and 186 then '3-6 months'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 187 and 365 then '6-12 months'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 366 and 730 then '1 to 2 years'
when coalesce(kp.lenofstay,th.lenofstay,li.lenofstay) between 731 and 6000 then '2+ years'
end as los,

coalesce(th.grfdate,kp.grfdate_ki,kp.grfdate_pa,li.grfdate) as grffaildate,

coalesce(th.grfstatus,kp.GrfSTATUS_KI,kp.GrfSTATUS_PA,li.grfstatus) as gstatus,
										    
										      
from
   SomeResearchDB.DSV.TX tx 
   left join
      OrgAdminDB..Institutes ns on tx.ctr=ns.ctr4+'-'+ns.ctrty	
   left join
      OrgAdminDB...ServiceOpo d on tx.ctr=d.txctr4+'-'+txctrty									      
   left join	
      OrgAdminDB..Institutes l on tx.ctr=ns.ctr4+'-'+l.ctrty									      
   left join									      
      SomeResearchDB.DSV.donor on fd.donorid=tx.donorid										      
   left join
      SomeResearchDB.DSV.kidpan kp 
      on coalesce(kp.transplant_id_ki, kp.transplant_id_pa) = tx.transplant_id 
   left join
      SomeResearchDB.DSV.liver li 
      on li.transplant_id = tx.transplant_id 
   left join
      SomeResearchDB.DSV.thoracic th 
      on th.transplant_id = tx.transplant_id 
   left join
      OrgAdminDatabase.dbo.share_ty st 
      on st.id = kp.share_ty 
   left join
      OrgAdminDatabase.dbo.status cd 
      on cd.id = tx.END_STAT 
   left join
      OrgAdminDatabase.dbo.Ethnicity_Race e 
      on e.Cd = tx.ethcat 
   left join
      OrgAdminDatabase.dbo.txinstitution ins 
      on ins.ctr_cd = substring(tx.ctr, 1, 4) 

--Set up weights and transformations for GFR for pediatric vs adult and male vs female
      CROSS APPLY ( SELECT
         CASE WHEN tx.gender = 'F' 
         THEN 0.742
         ELSE 1
         END
         AS gender_mult) w 
         
       CROSS APPLY ( SELECT
            CASE WHEN tx.ethcat = 2
            THEN 1.21
            ELSE 1       
            END
            AS ethcat_mult) x
          
        CROSS APPLY ( SELECT
             CASE WHEN tx.age >= 18 and kp.creatinine != 0 
             THEN (186*power(kp.creatinine, - 1.154))*power(tx.age, - .203)*(w.gender_mult*x.ethcat_mult)      
             END AS gfr) y       
      
        CROSS APPLY ( SELECT
             CASE WHEN tx.age < 18 and kp.creatinine != 0
             then .413*(kp.HGT_CM_TRR / kp.creatinine)       
             END as gfr ) z            
                         
         where tx.transplantdate between DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0) and  iif(datepart(dd,getdate())<15,DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-2, -1),DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1))

                  
