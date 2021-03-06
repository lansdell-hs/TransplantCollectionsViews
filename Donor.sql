--Points at correct database with write permissions
USE SomeResearchDBName
--Drops view if it exists

if object_id('CTR_DON','v') is not null
drop view CTR_DON;
go


CREATE VIEW [CTR_DON] AS
	
	select d.donor_id,d.OPOcenter as center,d.donation_dt,D.orgs_recov,d.orgs_txed,d.orgs_disc,d.NUM_HR_RECOV,d.NUM_HR_TX,d.NUM_HR_DISC,
	d.ki_recov,d.ki_txed,d.ki_disc,
	d.li_recov,d.LI_TXED,d.LI_DISC,
	d.LU_RECOV,d.LU_TXED,d.LU_DISC,
	d.PA_RECOV,d.PA_TXED,d.PA_DISC,
	d.IN_RECOV,d.IN_TXED,d.IN_DISC,
	d.nondcd,d.tot_disposition,
          
	case when datepart(month,d.donation_dt)=1 then concat('March 31,',DATEPART(year,d.donation_dt)) 
	when datepart(month,d.donation_dt)=2 then concat('June 30,',DATEPART(year,d.donation_dt)) 
	when datepart(month,d.donation_dt)=3 then concat('September 30,',DATEPART(year,d.donation_dt)) 
	when datepart(month,d.donation_dt)=4 then concat('December 31,',DATEPART(year,d.donation_dt)) 
	end as caldate

	

	from SomeResearchDB.DSV.Donors d
	
	
	WHERE d.donation_dt between DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0) and  iif(datepart(dd,getdate())<15,DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-2, -1),DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1));
go

	
