--Points at correct database with write permissions
USE SomeResearchDBName
--Drops view if it exists
if object_id('RemRATES','v') is not null
drop view RemRATES;
go

CREATE VIEW [RemRATES] AS

select
   wl.reg_id,
   wl.reg_org as organ,
   wl.reg_ctr as center,
   wl.reg_date,
   wl.stop_date,
   wl.regremovaldate,
   wl.transplanted,
   wl.removalCD,
   wl.end_region,
   
   DATEDIFF(day, wl.reg_date, wl.stop_date ) as dayswait,

   case when wl.transplanted=1 or wl.removalCD in (X,XX8,X9X,1XX,XX) then 1
   else 0
   end as Transplant,
   
   case when wl.removalCD in (X,XX) then 1
   else 0
   end as Death, 

   case when wl.removalCD in (X,XX) then 'Death'
   else 'TX'
   end as metric

from
   SomeResearchDB.DSV.Waitlist
where
   wl.reg_date < DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0)
   and wl.stop_date between DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0) and DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)
   and removalCD in (X,XX8,X9X,1XX,XX,X,XXX)

go
