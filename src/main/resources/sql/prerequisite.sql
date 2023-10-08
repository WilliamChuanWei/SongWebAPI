use SongDB;

drop table IF EXISTS [dbo].[song];

use SongDB;

create table song(
	id int not null primary key identity,
	name nvarchar(max) not null,
	aitist nvarchar(max) null,
	url nvarchar(max) not null,
);

SET IDENTITY_INSERT [dbo].[song] ON;
 
insert into [songModel] (
		[name]
      ,[aitist]
      ,[url])
values (1, 0987654321, '', '');

insert into [songModel] (
		[name]
      ,[aitist]
      ,[url])
values (1, 0987654321, '', '');

