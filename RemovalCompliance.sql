--Points at correct database with write permissions
USE SomeResearchDBName
--Drops view if it exists
if object_id('CTRremComp','v') is not null
drop view CTRremComp;
go

create view CTRremComp as

select 
wl.reg_id,
wl.regremovaldate, 
wl.removalCD, 
wl.stop_date,
wl.reg_ctr as center,
wl.reg_org as organ,
wl.end_region,



case when wl.removalCD in (X,XX,X1X) and wl.stop_date=wl.regremovaldate or wl.removalCD in (4,18,19) and dateadd(dd,1,wl.stop_date)=regremovaldate then 1
when wl.removalCD in (X4,XX8,XX) and wl.stop_date!=wl.regremovaldate or wl.removalCD in (4,18,19) and dateadd(dd,1,wl.stop_date)!=regremovaldate then 0
end as ddrcompliant,

case when wl.removalCD=XXX and wl.stop_date=wl.regremovaldate or wl.removalCD=1XXX and dateadd(dd,1,wl.stop_date)=regremovaldate then 1
when wl.removalCD=XXX and wl.stop_date!=wl.regremovaldate or wl.removalCD=XX and dateadd(dd,1,wl.stop_date)!=regremovaldate then 0
end as livcompliant,

case when removalCD in (X,XX8,XX) then 'DDRrem'
when removalCD=1XX then 'LDrem'
end as metric


from SomeDB.DSV.waitlist wl
where regremovaldate between DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 3, 0) and DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1) and wl.removalCD in (XX,1X,XX9,XX5)
go


