/*IF OBJECT_ID('NationalWL_SUMS','V') IS NOT NULL DROP VIEW NationalWL_SUMS
IF OBJECT_ID('RegionWL_SUMS','V') IS NOT NULL DROP VIEW RegionWL_SUMS

IF OBJECT_ID('NationalWLREM_SUMS','V') IS NOT NULL DROP VIEW NationalWLREM_SUMS
IF OBJECT_ID('RegionWLREM_SUMS','V') IS NOT NULL DROP VIEW RegionWLREM_SUMS

IF OBJECT_ID('NationalTX_SUMS','V') IS NOT NULL DROP VIEW NationalTX_SUMS
IF OBJECT_ID('RegionTX_SUMS','V') IS NOT NULL DROP VIEW RegionTX_SUMS


*/


create view NationalWL_SUMS as 
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by

   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   gender 
union all
--Ethnicity
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Ethnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   ethnicity 
union all
--Blood Type (bloodty)
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'bloodty' as strv,
   bloodty as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   bloodty 
union all
--Age at Listing
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Age at Listing' as strv,
   Age_at_Listing as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Age_at_Listing 
union all
--Diagnosis at Listing
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by

   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Diagnosis 
union all
--Reason for Removal
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Removal' as strv,
   removal as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by

   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   removal 
union all
--Status at Listing
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Status at Listing' as strv,
   status as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   status 
union all
--LAS at Listing
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAS Score at Listing' as strv,
   LAS_list as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ = 'LU' 
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LAS_list 
union all
--Lab MELD/PELD
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAB MELD/PELD at Listing' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ = 'LI' 
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LabMeldPeld 
union all
--CPRA at Listing 
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'CPRA at Listing' as strv,
   CPRA_init as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   CPRA_init 
union all
--EPTS at Listing
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'EPTS at listing' as strv,
   EPTS_init as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   EPTS_init 
union all
--Time on Dialysis
select
   'National' as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Time on Dialysis' as strv,
   Time_Dial as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Time_Dial
go

create view RegionWL_SUMS as 
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   gender 
union all
--Ethnicity
select
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Ethnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   CTR_WL
group by
   convert(varchar(3),region),
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   ethnicity 
union all
--Blood Type (bloodty)
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'bloodty' as strv,
   bloodty as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region),
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   bloodty 
union all
--Age at Listing
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Age at Listing' as strv,
   Age_at_Listing as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Age_at_Listing 
union all
--Diagnosis at Listing
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Diagnosis 
union all
--Reason for Removal
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Removal' as strv,
   removal as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   removal 
union all
--Status at Listing
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Status at Listing' as strv,
   status as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   status 
union all
--LAS at Listing
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAS Score at Listing' as strv,
   LAS_list as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ = 'LU' 
group by
   
   convert(varchar(3),region),
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LAS_list 
union all
--Lab MELD/PELD
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAB MELD/PELD at Listing' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ = 'LI' 
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LabMeldPeld 
union all
--CPRA at Listing 
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'CPRA at Listing' as strv,
   CPRA_init as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   CPRA_init 
union all
--EPTS at Listing
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'EPTS at listing' as strv,
   EPTS_init as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   
   convert(varchar(3),region) ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   EPTS_init 
union all
--Time on Dialysis
select
   
   convert(varchar(3),region) as center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Time on Dialysis' as strv,
   Time_Dial as strv_cat,
   count(*) as n_obs 
from
   CTR_WL 
where
   organ in 
   ('KI','KP')
group by
   
   convert(varchar(3),region)  ,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Time_Dial
go

create view NationalWLREM_SUMS as 
select
   'National' as center,
   concat(DATENAME(month, rem_date), datepart(year, rem_date)) as caldate,
   organ,
   Age_at_Removal,
   'Removal' as strv,
   Removal as strv_cat,
   count(*) as n_obs 
from
   CTR_WLREM 
group by
   concat(DATENAME(month, rem_date), datepart(year, rem_date)),
   organ,
   Age_at_Removal,
   Removal
go

create view RegionWLREM_SUMS as 
select
   convert(varchar(3),region) as center,
   concat(DATENAME(month, rem_date), datepart(year, rem_date)) as caldate,
   organ,
   Age_at_Removal,
   'Removal' as strv,
   Removal as strv_cat,
   count(*) as n_obs 
from
   CTR_WLREM 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, rem_date), datepart(year, rem_date)),
   organ,
   Age_at_Removal,
   Removal
go

create view NationalTX_SUMS as
--Age at Transplant
select
   'National' as center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Age at TX' as strv,
   Age_at_TX as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Age_at_TX 
union all
--Status at Transplant
select
   'National' as center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Status at TX' as strv,
   status as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by

   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   status 
union all
--Gender
select
   'National' as center,

   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   gender 
union all
--Blood Type (bloodty)
select
   'National' as center,

   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'bloodty' as strv,
   blood_type as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   blood_type 
union all
--Ethnicity
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Etnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   ethnicity 
union all
--Diagnosis
select
   'National' as center,
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Diagnosis 
union all
--LAS at Transplant
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'LAS at Transplant' as strv,
   LAS_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ='LU'
group by
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LAS_tx 
union all
--CPRA at Transplant
select
   'National' as center,
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'CPRA at transplant' as strv,
   CPRA_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   CPRA_tx 
union all
--Lab MELD/PELD at Transplant
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Lab MELD/PELD Score at transplant' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ='LI'
group by
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LabMeldPeld 
union all
--KDPI at Transplant
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'KDPI at transplant' as strv,
   KDPI_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
 
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   KDPI_tx 
union all
--GFR 
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'GFR' as strv,
   gfr_final as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   gfr_final 
union all
--Share Type
select
   'National' as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Share Type' as strv,
   share_ty as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   share_ty
go

create view RegionTX_SUMS as
--Age at Transplant
select
   convert(varchar(3),region) as center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Age at TX' as strv,
   Age_at_TX as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Age_at_TX 
union all
--Status at Transplant
select
   convert(varchar(3),region) as center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Status at TX' as strv,
   status as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   status 
union all
--Gender
select
   convert(varchar(3),region) as center,

   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   gender 
union all
--Blood Type (bloodty)
select
   convert(varchar(3),region) as center,

   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'bloodty' as strv,
   blood_type as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   blood_type 
union all
--Ethnicity
select
   convert(varchar(3),region) as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Ethnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   ethnicity 
union all
--Diagnosis
select
   convert(varchar(3),region) as center,
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Diagnosis 
union all
--LAS at Transplant
select
   convert(varchar(3),region) as center,
   
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'LAS at Transplant' as strv,
   LAS_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ='LU'
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LAS_tx 
union all
--CPRA at Transplant
select
   convert(varchar(3),region) as center,
  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'CPRA at transplant' as strv,
   CPRA_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   CPRA_tx 
union all
--Lab MELD/PELD at Transplant
select
   convert(varchar(3),region) as center,  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Lab MELD/PELD Score at transplant' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ='LI'
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LabMeldPeld 
union all
--KDPI at Transplant
select
   convert(varchar(3),region) as center,  
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'KDPI at transplant' as strv,
   KDPI_tx as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   KDPI_tx 
union all
--GFR 
select
   convert(varchar(3),region) as center, 
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'GFR' as strv,
   gfr_final as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   gfr_final 
union all
--Share Type
select
   convert(varchar(3),region) as center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Share Type' as strv,
   share_ty as strv_cat,
   count(*) as n_obs 
from
   CTR_TX 
where organ in ('KI','KP')
group by
   convert(varchar(3),region),
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   share_ty
go


