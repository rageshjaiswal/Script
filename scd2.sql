drop table Dimperson
drop table StgPerson


CREATE TABLE DimPerson (
	Id int identity(1,1),
	PersonID int,
	[Name] varchar(100),
	Surname varchar(100),
	IsActive int,
	StartDate date,
	EndDate date
	) 

	CREATE TABLE StgPerson (
	Id int,
	[Naam] varchar(100),
	LastName varchar(100)
	) 


	--INsert into DimPerson values('Rajesh', 'Jaiswal')
	--INsert into DimPerson values('Richss', 'Jaiswall')

	INsert into StgPerson values(1,'Akanshaaaa', 'Jaiswall')
	INsert into StgPerson values(2,'Richss', 'Jaiswall')

	UPDATE StgPerson
	set Naam = 'Akanshaaaa', LastName = 'Jaiswall'
	where id = 3

	select * from DimPerson
	select * from StgPerson

	delete from StgPerson
	where id = 3


drop table #TargetTable 

CREATE TABLE #TargetTable (
	Id int,
	PersonID int,
	[Name] varchar(100),
	Surname varchar(100),
	IsActive int,
	StartDate date,
	EndDate date
	) 
insert into #TargetTable
select * from DimPerson where isactive = 1 

INSERT INTO DimPerson 
select Id,Naam, LastName, 1, getdate(), '2099-12-31' from (

Merge DimPerson Target
using (select * from StgPerson where id = 1) as Source
on target.PersonID = source.id

-- update
WHEN MATCHed and  target.isactive = 1 and  ( target.name <> source.naam or target.surname <> source.lastname )
THEN UPDATE
set --target.Name = source.naam, target.surname = source.lastname, 
target.isactive = 0,  target.enddate = getdate() -1  

-- insert
WHEN NOT MATCHED  by target  THEN INSERT (PersonID,name, surname, isactive, startdate, enddate)
VALUEs (source.id,source.naam, source.lastname, 1, getdate()-2, '2099-12-31')

-- to deactive
when NOT MATCHED by source THEN UPDATE
SET target.isactive = 0 , target.enddate = getdate()

OUTPUT source.*,

   $Action AS MergeAction

)mrg
where mrg.MergeAction = 'Update' and mrg.Id is not null
;
























-- For insert
WHEN NOT MATCHED BY TARGET THEN  INSERT
 values (source.[Naam], Source.lastname, 1 , getdate(), '2099-12-31')  

-- for update
when matched then update
SET 
target.name = source.naam,
target.surname = source.lastname,
target.Isactive =  1,
target.startdate = getdate(),
target.enddate = '2099-12-31'

;
--
when not matched THEN update


;


	


















