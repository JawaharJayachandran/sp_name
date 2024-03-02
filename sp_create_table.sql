USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[sp_create_table]    Script Date: 02-03-2024 9.52.26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_create_table]
@l_table_name varchar(30),
@l_column_name1 varchar(50),
@l_column_name2 varchar(50),
@l_column_name3 varchar(50),
@l_column_name4 varchar(50),
@l_error_number int=0 output,
@l_error_desc varchar(200)=null output
as
begin try 
declare
@l_mysql varchar(2000)

print"this dummy1"

select @l_mysql='drop table if exists trans..'+@l_table_name
select @l_mysql
exec (@l_mysql)

select @l_mysql='create table trans..'+@l_table_name+'('+@l_column_name1+' varchar(50),'+@l_column_name2+ ' varchar(50),'+@l_column_name3 + ' varchar(50),'+@l_column_name4 + ' varchar(50))'

select @l_mysql
exec (@l_mysql)

end try
begin catch
select @l_error_number =ERROR_NUMBER(),@l_error_desc=ERROR_MESSAGE()
select @l_error_number,@l_error_desc
end catch


