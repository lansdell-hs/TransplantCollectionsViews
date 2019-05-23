


IF OBJECT_ID('WL_SUMS','V') IS NOT NULL DROP VIEW WL_SUMS
IF OBJECT_ID('WLREM_SUMS','V') IS NOT NULL DROP VIEW WLREM_SUMS
IF OBJECT_ID('TX_SUMS','V') IS NOT NULL DROP VIEW TX_SUMS
if object_id('RATE_SUMS','v') is not null drop view TXC_RATE_SUMS;

if object_id('POSTTX_SUMS','v') is not null drop view TXC_POSTTX_SUMS;

if object_id('LOS_SUMS','v') is not null drop view TXC_LOS_SUMS;

if object_id('DGF_SUMS','v') is not null drop view TXC_DGF_SUMS;

if object_id('DON_SUMS','v') is not null drop view TXC_DON_SUMS;
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
                                                    
CREATE VIEW RATE_SUMS as
	select center,organ,metric,count(reg_id) as consd_rec,
	concat('December',datepart(year, regremovaldate)) as caldate,
	cast(sum(deathcomp) as Float)/count(reg_id) as rate
	from RemComp
	where removalCD in (X,XX,XX9) 
	group by
	center,
	organ,
	metric,
	concat('December',datepart(year, regremovaldate))
	
	union all
	--All organs
	select center,'All' as reg_org,metric,count(reg_id) as consd_rec,
	concat('December',datepart(year, regremovaldate)) as caldate,
	cast(sum(deathcomp) as Float)/count(reg_id) as rate
	from RemComp
	where removalCD=XX
	group by
	center,
	metric,
	concat('December',datepart(year, regremovaldate))
	
 	union all 
	
	select center,organ,metric,count(reg_id) as consd_rec,
	concat('December',datepart(year, regremovaldate)) as caldate,
	cast(sum(livcompliant) as Float)/count(reg_id) as rate
	from RemComp
	where removalCD=XX
	group by
	center,
	organ,
	metric,
	concat('December',datepart(year, regremovaldate))

	union all 
	--All organs
	select center,'All' as organ,metric,count(reg_id) as consd_rec,
	concat('December',datepart(year, regremovaldate)) as caldate,
	cast(sum(livcompliant) as Float)/count(reg_id) as rate
	from RemComp
	where removalCD=XX
	group by
	center,
	metric,
	concat('December',datepart(year, regremovaldate))

	
 	union all
--TRANSPLANT/DEATH RATES
	select
	center,
	organ, 
	metric,
	count(reg_id) as consd_rec,
	concat('December',datepart(year, end_date))  as caldate,
	cast(sum(Transplant)*365.25 as Float)/sum(dayswait) as rate
	from RemRATES
	where metric='TX'
	group by
	center,
	organ,
	metric,
	concat('December',datepart(year, end_date)) 

	union all
	--All organs
	select
	center,
	'All' as organ,
	metric,
	count(reg_id) as consd_rec,
	concat('December',datepart(year, end_date))  as caldate,
	cast(sum(Transplant)*365.25 as Float)/sum(dayswait) as rate
	from RemRATES
	where metric='TX'
	group by
	center,
	metric,
	concat('December',datepart(year, end_date)) 
	
	
 	union all
	
	select
	center,
	organ, 
	metric,
	count(reg_id) as consd_rec,
	concat('December',datepart(year, end_date))  as caldate,
	cast(sum(Death)*365.25 as Float)/sum(dayswait) as rate
	from RemRATES
	where metric='Death'
	group by
	center,
	organ,
	metric,
	concat('December',datepart(year, end_date)) 

	union all

	--All Organs
	select
	center,
	'All' as organ,
	metric,
	count(reg_id) as consd_rec,
	concat('December',datepart(year, end_date))  as caldate,
	cast(sum(Death)*365.25 as Float)/sum(dayswait) as rate
	from RemRATES
	where metric='Death'
	group by
	center,
	metric,
	concat('December',datepart(year, end_date)) 

	
go
--Looks at patient outcomes after Transplant     
create view POSTTX_SUMS as 	

--GRFFail6mo
	SELECT center,
		concat('December',datepart(year, transplate_dt)) AS caldate,
		organ,
		donorty,
		Age_at_TX,
		'GRF 6 mo' as metric,
		count(regPTid) AS consd_rec,
		sum(GfrFail6mo) AS n_obs
	FROM CTR_TX
	GROUP BY center,
			concat('December',datepart(year, transplate_dt)),
			organ,
			donorty,
			Age_at_TX

	union all
--GRF Fail 1yr
	SELECT center,
		concat('December',datepart(year, transplate_dt)) AS caldate,
		organ,
		donorty,
		Age_at_TX,
		'GRF 1 yr' as metric,
		count(regPTid) AS consd_rec,
		sum(GfrFail1yr) AS n_obs
	FROM CTR_TX
	GROUP BY center,
			concat('December',datepart(year, transplate_dt)),
			organ,
			donorty,
			Age_at_TX
	
	union all
--Patient Death within 6 months of tx
		SELECT center,
		concat('December',datepart(year, transplate_dt)) AS caldate,
		organ,
		donorty,
		Age_at_TX,
		'Patient Death within 6 months' as metric,
		count(regPTid) AS consd_rec,
		sum(PtDeath6mo) AS n_obs
	FROM CTR_TX
	GROUP BY center,
			concat('December',datepart(year, transplate_dt)),
			organ,
			donorty,
			Age_at_TX

	union all
--Patient Death within 1 year of TX
	SELECT center,
		concat('December',datepart(year, transplate_dt)) AS caldate,
		organ,
		donorty,
		Age_at_TX,
		'Patient Death within 1 year' as metric,
		count(regPTid) AS consd_rec,
		sum(PtDeath1yr) AS n_obs
	FROM CTR_TX
	GROUP BY center,
			concat('December',datepart(year, transplate_dt)),
			organ,
			donorty,
			Age_at_TX

go                              
--Puts length of stay post transplant into categorical bins
create view LOS_SUMS as 
	
	SELECT center,
		caldate,
		organ,
		donorty,
		Age_at_TX,
		'Post-TX Length of Stay' as strv,
		lenofstay as strv_cat,
		count(*) as n_obs
		from
	    CTR_TX 
	    group by
	    center,
		caldate,
		organ,
		donorty,
		Age_at_TX,
		lenofstay
go
                                    
--Looks at Kidney and Kidney-Pancreas to group instances of Delayed Graft Function into time bins                                                    
create view DGF_SUMS as
	SELECT center,
		caldate,
		organ,
		donorty,
		Age_at_TX,
		'Delayed Graft Function' as strv,
		dialysis_7 as strv_cat,
		count(*) as n_obs
		from
	    CTR_TX 
		where organ in ('KI','KP')
	    group by
	    center,
		caldate,
		organ,
		donorty,
		Age_at_TX,
		dialysis_7
go

--Pulls Donor information into summary bins
create view DON_SUMS as 
	select 
	center,
	caldate,
	'KI' as organ,
	'TX' as metric,
	sum(ki_txed) as n_obs
	from CTR_DON
	where ki_txed between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'KI' as organ,
	'REC' as metric,
	sum(ki_recov) as n_obs
	from CTR_DON
	where ki_recov between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'KI' as organ,
	'DISC' as metric,
	sum(ki_disc) as n_obs
	from CTR_DON
	where ki_disc between 1 and 3
	group by 
	center,
	caldate

	union all
	--OTPD KI
	select 
	center,
	caldate,
	'KI' as organ,
	'OTPD' as metric,
	(cast(sum(ki_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where ki_recov between 1 and 3
	group by 
	center,
	caldate

	union all
	--Create a donors recovered under each organ type
	select 
	center,
	caldate,
	'KI' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'KI' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate


	--Pancreas

	union all

	select 
	center,
	caldate,
	'PA' as organ,
	'TX' as metric,
	sum(pa_txed) as n_obs
	from CTR_DON
	where pa_txed between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'PA' as organ,
	'REC' as metric,
	sum(pa_recov) as n_obs
	from CTR_DON
	where pa_recov between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'PA' as organ,
	'DISC' as metric,
	sum(pa_disc) as n_obs
	from CTR_DON
	where pa_disc between 1 and 3
	group by 
	center,
	caldate
	
	union all
	
	--OTPD PA
	select 
	center,
	caldate,
	'PA' as organ,
	'OTPD' as metric,
	(cast(sum(pa_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where pa_recov between 1 and 3
	group by 
	center,
	caldate

	union all
	
	select 
	center,
	caldate,
	'PA' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'PA' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate

	union all

	--Heart
	select 
	center,
	caldate,
	'HR' as organ,
	'TX' as metric,
	sum(hr_txed) as n_obs
	from CTR_DON
	where hr_txed=1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'HR' as organ,
	'REC' as metric,
	sum(hr_recov) as n_obs
	from CTR_DON
	where hr_recov=1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'HR' as organ,
	'DISC' as metric,
	sum(hr_disc) as n_obs
	from CTR_DON
	where hr_disc=1
	group by 
	center,
	caldate

	union all

	--OTPD HR
	select 
	center,
	caldate,
	'HR' as organ,
	'OTPD' as metric,
	(cast(sum(hr_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where hr_recov=1
	group by 
	center,
	caldate
	
	union all

	select 
	center,
	caldate,
	'HR' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'HR' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate

	union all

	--Lung
	select 
	center,
	caldate,
	'LU' as organ,
	'TX' as metric,
	sum(lu_txed) as n_obs
	from CTR_DON
	where lu_txed between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'LU' as organ,
	'REC' as metric,
	sum(lu_recov) as n_obs
	from CTR_DON
	where lu_recov between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'LU' as organ,
	'DISC' as metric,
	sum(lu_disc) as n_obs
	from CTR_DON
	where lu_disc between 1 and 3
	group by 
	center,
	caldate
	
	union all

	--OTPD Lung

	select 
	center,
	caldate,
	'LU' as organ,
	'OTPD' as metric,
	(cast(sum(lu_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where lu_recov between 1 and 3
	group by 
	center,
	caldate

    union all 

	select 
	center,
	caldate,
	'LU' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3)
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'LU' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate
	
	union all

	--Liver
	select 
	center,
	caldate,
	'LI' as organ,
	'TX' as metric,
	sum(li_txed) as n_obs
	from CTR_DON
	where li_txed between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'LI' as organ,
	'REC' as metric,
	sum(li_recov) as n_obs
	from CTR_DON
	where li_recov between 1 and 3
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'LI' as organ,
	'DISC' as metric,
	sum(li_disc) as n_obs
	from CTR_DON
	where li_disc between 1 and 3
	group by 
	center,
	caldate
	
	union all
	select 
	center,
	caldate,
	'LI' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all
	select 
	center,
	caldate,
	'LI' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate
	
	union all

	--OTPD LI
	select 
	center,
	caldate,
	'LI' as organ,
	'OTPD' as metric,
	(cast(sum(li_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where li_recov between 1 and 3
	group by 
	center,
	caldate

	union all
	
	--Intestine
	select 
	center,
	caldate,
	'IN' as organ,
	'TX' as metric,
	sum(in_txed) as n_obs
	from CTR_DON
	where in_txed=1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'IN' as organ,
	'REC' as metric,
	sum(in_recov) as n_obs
	from CTR_DON
	where in_recov=1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'IN' as organ,
	'DISC' as metric,
	sum(in_disc) as n_obs
	from CTR_DON
	where in_disc=1
	group by 
	center,
	caldate

	union all
	--OTPD IN
	select 
	center,
	caldate,
	'IN' as organ,
	'OTPD' as metric,
	(cast(sum(in_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where in_recov=1
	group by 
	center,
	caldate
	
	union all

	select 
	center,
	caldate,
	'IN' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'IN' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate

	union all 

	--All Organs
	select 
	center,
	caldate,
	'All Organs' as organ,
	'TX' as metric,
	sum(org_txed) as n_obs
	from CTR_DON
	where org_txed>1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'All Organs' as organ,
	'REC' as metric,
	sum(org_recov) as n_obs
	from CTR_DON
	where org_recov>1
	group by 
	center,
	caldate

	union all 

	select 
	center,
	caldate,
	'All Organs' as organ,
	'DISC' as metric,
	sum(org_disc) as n_obs
	from CTR_DON
	where org_disc>1
	group by 
	center,
	caldate

	union all
	--OTPD IN
	select 
	center,
	caldate,
	'All Organs' as organ,
	'OTPD' as metric,
	(cast(sum(org_txed) as float)/count(donorid)) as n_obs
	from CTR_DON
	where org_recov>1
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'All Organs' as organ,
	'DONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) 
	group by 
	center,
	caldate

	union all

	select 
	center,
	caldate,
	'All Organs' as organ,
	'DCDDONREC' as metric,
	count(donorid) as n_obs
	from CTR_DON
	where tot_disposition in (1,3) and dcd='Y'
	group by 
	center,
	caldate



	

                                   
                                    
