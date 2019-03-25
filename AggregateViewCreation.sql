


IF OBJECT_ID('WL_SUMS','V') IS NOT NULL DROP VIEW WL_SUMS
IF OBJECT_ID('WLREM_SUMS','V') IS NOT NULL DROP VIEW WLREM_SUMS
IF OBJECT_ID('TX_SUMS','V') IS NOT NULL DROP VIEW TX_SUMS

go

---VIEW FOR WAITLIST ADDITIONS
--Gender
create view WL_SUMS as 
select * from NationalWL_SUMS

union all

select * from RegionWL_SUMS

union all

select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   gender 
union all
--Blood Type (ABO)
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'ABO' as strv,
   abo as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   abo 
union all
--Age at Listing
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Age at Listing' as strv,
   Age_at_Listing as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Age_at_Listing 
union all
--Ethnicity
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Ethnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   ethnicity 
union all
--Diagnosis at Listing
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Diagnosis 
union all
--Reason for Removal
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Removal' as strv,
   removal as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   removal 
union all
--Status at Listing
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Status at Listing' as strv,
   Cand_Stat as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Cand_Stat 
union all
--LAS at Listing
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAS Score at Listing' as strv,
   LAS_list as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
where
   organ = 'LU' 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LAS_list 
union all
--Lab MELD/PELD
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'LAB MELD/PELD at Listing' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
where
   organ = 'LI' 
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   LabMeldPeld 
union all
--CPRA at Listing 
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'CPRA at Listing' as strv,
   CPRA_init as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
where
   organ in 
   ('KI','KP')
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   CPRA_init 
union all
--EPTS at Listing
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'EPTS at listing' as strv,
   EPTS_init as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
where
   organ in 
   ('KI','KP')
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   EPTS_init 
union all
--Time on Dialysis
select
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)) as caldate,
   organ,
   Age_at_Listing,
   'Time on Dialysis' as strv,
   Time_Dial as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WL 
where
   organ in 
   ('KI','KP')
group by
   center,
   concat(DATENAME(month, reg_date), datepart(year, reg_date)),
   organ,
   Age_at_Listing,
   Time_Dial
go
---VIEW FOR WAITLIST REMOVALS

create view WLREM_SUMS as 
select * from NationalWLREM_SUMS

union all

select * from RegionWLREM_SUMS

union all

select
   center,
   concat(DATENAME(month, rem_date), datepart(year, rem_date)) as caldate,
   organ,
   Age_at_Removal,
   'Removal' as strv,
   Removal as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_WLREM 
group by
   center,
   concat(DATENAME(month, rem_date), datepart(year, rem_date)),
   organ,
   Age_at_Removal,
   Removal

go
---VIEW FOR TRANSPLANTS 
create view TX_SUMS as
select * from NationalTX_SUMS

union all

select * from RegionTX_SUMS

union all

--Age at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Age at TX' as strv,
   Age_at_TX as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Age_at_TX 
union all
--Status at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Status at TX' as strv,
   Cand_Stat as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Cand_Stat 
union all
--Gender
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Gender' as strv,
   gender as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   gender 
union all
--Blood Type (ABO)
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'ABO' as strv,
   blood_type as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   blood_type 
union all
--Ethnicity
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Etnicity' as strv,
   ethnicity as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   ethnicity 
union all
--Diagnosis
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Diagnosis' as strv,
   Diagnosis as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   Diagnosis 
union all
--LAS at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'LAS at Transplant' as strv,
   LAS_tx as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ='LU'
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LAS_tx 
union all
--CPRA at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'CPRA at transplant' as strv,
   CPRA_tx as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ in ('KI','KP')
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   CPRA_tx 
union all
--Lab MELD/PELD at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Lab MELD/PELD Score at transplant' as strv,
   LabMeldPeld as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ='LI'
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   LabMeldPeld 
union all
--KDPI at Transplant
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'KDPI at transplant' as strv,
   KDPI_tx as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ in ('KI','KP')
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   KDPI_tx 
union all
--GFR 
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'GFR' as strv,
   glomerularfr_final as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ in ('KI','KP')
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   glomerularfr_final 
union all
--Share Type
select
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)) as caldate,
   organ,
   donorty,
   Age_at_TX,
   'Share Type' as strv,
   share_ty as strv_cat,
   count(*) as n_obs 
from
   TransplantCTR_TX 
where organ in ('KI','KP')
group by
   center,
   concat(DATENAME(month, transplantdate), datepart(year, transplantdate)),
   organ,
   donorty,
   Age_at_TX,
   share_ty

go

