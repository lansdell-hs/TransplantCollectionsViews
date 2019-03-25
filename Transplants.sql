USE SomeResearchDBname if object_id('TransplantCTR_TX', 'v') is not null drop view TransplantCTR_TX;
go 

CREATE VIEW [TransplantCTR_TX] AS 

select
   tx.transplant_id,
   tx.transplantdate,
   tx.abo,
   tx.gender,
   tx.region,
   tx.transplant_center as center,
   tx.organ,
   li.meld_peld_lab,
   kp.END_EPTS,
   st.descrip as share_ty,
   kp.STOP_CPRA,
   kp.creatinine,
   y.glomerularfr as adlt_glomerularfr,
   z.glomerularfr as ped_glomerularfr,
   e.descrip as ethnicity,
   cd.descrip as status,
   
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
         
      ELSE 'Other/Not Reported' 
         
   End as Diagnosis, 
   
   CASE WHEN
         TH.match_las_stop between 0 and 20 
      then '<20' 
      WHEN
         TH.match_las_stop between 20 and 30 
      then
         '20-<30' 
      WHEN
         TH.match_las_stop between 30 and 35 
      then
         '30-<35' 
      WHEN
         TH.match_las_stop between 35 and 40 
      then
         '35-<40' 
      WHEN
         TH.match_las_stop between 40 and 50 
      then
         '40-<50' 
      WHEN
         TH.match_las_stop between 50 and 60 
      then
         '50-<60' 
      WHEN
         TH.match_las_stop between 60 and 70 
      then
         '60-<70' 
      WHEN
         TH.match_las_stop between 70 and 1000 
      then
         '70+' 
   End
   as LAS_tx, 
   CASE
      WHEN
         ins.Pediatric_Only_Hospital = 'Y' 
         AND tx.AGE between 0 and 1 
      then
         '<1' 
      WHEN
         ins.Pediatric_Only_Hospital = 'Y' 
         AND tx.AGE between 1 and 5 
      then
         '1-5' 
      WHEN
         ins.Pediatric_Only_Hospital = 'Y' 
         AND tx.AGE between 6 and 10 
      then
         '6-10' 
      WHEN
         ins.Pediatric_Only_Hospital = 'Y' 
         AND tx.AGE between 11 and 17 
      then
         '11-17' 
      WHEN
         ins.Pediatric_Only_Hospital = 'Y' 
         AND tx.AGE between 18 and 1000 
      then
         '18+' 
      WHEN
         ins.Pediatric_Only_Hospital = 'N' 
         AND tx.AGE between 0 and 18 
      then
         '<18' 
      WHEN
         ins.Pediatric_Only_Hospital = 'N' 
         AND tx.AGE between 19 and 34 
      then
         '19-34' 
      WHEN
         ins.Pediatric_Only_Hospital = 'N' 
         AND tx.AGE between 35 and 49 
      then
         '35-49' 
      WHEN
         ins.Pediatric_Only_Hospital = 'N' 
         AND tx.AGE between 50 and 64 
      then
         '50-64' 
      WHEN
         ins.Pediatric_Only_Hospital = 'N' 
         AND tx.AGE between 65 and 1000 
      then
         '65+' 
   End
   as Age_at_TX, 
   CASE
      WHEN
         tx.bloodty in 
         (
            'A', 'A1', 'A2', 'A2B'
         )
      then
         'A' 
      else
         tx.bloodty 
   end
   as blood_type, 
   CASE
      WHEN
         kp.STOP_CPRA = 0 
      then
         '0%' 
      WHEN
         kp.STOP_CPRA between 1 and 20 
      then
         '1-20%' 
      WHEN
         kp.STOP_CPRA between 21 and 79 
      then
         '21-79%' 
      WHEN
         kp.STOP_CPRA between 80 and 97 
      then
         '80-97%' 
      WHEN
         kp.STOP_CPRA between 98 and 100 
      then
         '98-100%' 
   End
   as CPRA_tx, 
   CASE
      WHEN
         tx.organ = 'LI' 
         and LI.meld_peld_lab between 0 and 15 
      then
         'MELD/PELD <15' 
      WHEN
         tx.organ = 'LI' 
         and LI.meld_peld_lab between 15 and 22 
      then
         'MELD/PELD 15-22' 
      WHEN
         tx.organ = 'LI' 
         and LI.meld_peld_lab between 23 and 34 
      then
         'MELD/PELD 23-34' 
      WHEN
         tx.organ = 'LI' 
         and LI.meld_peld_lab between 35 and 1000 
      then
         'MELD/PELD 35+' 
      WHEN
         tx.organ = 'LI' 
         and LI.meld_peld_lab = NULL 
      then
         'Not Reported' 
   End
   as LabMeldPeld, 
   CASE
      WHEN
         tx.organ in 
         (
            'KI', 'KP'
         )
         and kp.KDPI between 0 and .35 
      then
         '0-35' 
      WHEN
         tx.organ in 
         (
            'KI', 'KP'
         )
         and kp.KDPI between .36 and .49 
      then
         '36-49' 
      WHEN
         tx.organ in 
         (
            'KI', 'KP'
         )
         and kp.KDPI between .50 and .85 
      then
         '50-85' 
      WHEN
         tx.organ in 
         (
            'KI', 'KP'
         )
         and kp.KDPI between .86 and 1 
      then
         '86+' 
      WHEN
         tx.organ in 
         (
            'KI', 'KP'
         )
         and kp.KDPI is NULL 
      then
         'Not Reported' 
   End
   as KDPI_tx, 
   CASE
      WHEN
         y.glomerularfr >= 0 
         and y.glomerularfr < 15 
      then
         '<15' 
      WHEN
         y.glomerularfr >= 15 
         and y.glomerularfr < 30 
      then
         '15-29' 
      WHEN
         y.glomerularfr >= 30 
         and y.glomerularfr < 45 
      then
         '30-44' 
      WHEN
         y.glomerularfr >= 45 
         and y.glomerularfr < 60 
      then
         '45-59' 
      WHEN
         y.glomerularfr >= 60 
         and y.glomerularfr < 90 
      then
         '60-89' 
      WHEN
         y.glomerularfr >= 90 
      then
         '90+' 
      WHEN
         z.glomerularfr >= 0 
         and z.glomerularfr < 15 
      then
         '<15' 
      WHEN
         z.glomerularfr >= 15 
         and z.glomerularfr < 30 
      then
         '15-29' 
      WHEN
         z.glomerularfr >= 30 
         and z.glomerularfr < 45 
      then
         '30-44' 
      WHEN
         z.glomerularfr >= 45 
         and z.glomerularfr < 60 
      then
         '45-59' 
      WHEN
         z.glomerularfr >= 60 
         and z.glomerularfr < 90 
      then
         '60-89' 
      WHEN
         z.glomerularfr >= 90 
      then
         '90+' 
   End
   as glomerularfr_final 
from
   SomeResearchDataSet.DSV.TX tx 
   left join
      SomeResearchDataSet.DSV.kidpan kp 
      on coalesce(kp.transplant_id_ki, kp.transplant_id_pa) = tx.transplant_id 
   left join
      SomeResearchDataSet.DSV.liver li 
      on li.transplant_id = tx.transplant_id 
   left join
      SomeResearchDataSet.DSV.thoracic th 
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
      on ins.ctr_cd = substring(tx.ctr, 1, 4) CROSS APPLY ( 
      SELECT
         CASE
            WHEN
               tx.gender = 'F' 
            THEN
               0.742 
            ELSE
               1 
         END
         AS gender_mult) w CROSS APPLY ( 
         SELECT
            CASE
               WHEN
                  tx.ethcat = 2 
               THEN
                  1.21 
               ELSE
                  1 
            END
            AS ethcat_mult) x CROSS APPLY ( 
            SELECT
               CASE
                  WHEN
                     tx.age >= 18 
                     and kp.creatinine != 0 
                  THEN
(186*power(kp.creatinine, - 1.154))*power(tx.age, - .203)*(w.gender_mult*x.ethcat_mult) 
               END
               AS gfr) y CROSS APPLY ( 
               SELECT
                  CASE
                     WHEN
                        tx.age < 18 
                        and kp.creatinine != 0 
                     then
                        .413*(kp.HGT_CM_TRR / kp.creatinine) 
                  END
                  as gfr ) z 
               where
                  tx.transplantdate between '2016-01-01' and GETDATE()
