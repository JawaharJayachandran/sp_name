USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[sp_search_student]    Script Date: 02-03-2024 9.52.35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_search_student]
@i_student_name varchar(50),
@i_student_id varchar(50),
@l_error_num int=0 output,
@l_error_desc varchar(200)=null output
As
begin try
declare
@l_row_count int
print"this dummy1"
select student_name,student_id,subjects,Marks,DENSE_RANK() over (partition by subjects order by marks desc) from trans..student
where ISNULL(student_name,'')=coalesce(@i_student_name,ISNULL(student_name,''))
and   ISNULL(student_id,'')=coalesce(@i_student_id,ISNULL(student_id,''))
select @l_row_count=@@ROWCOUNT
if @l_row_count=0
begin
	throw 5002,'no records found',1;
end
end try 

begin catch
select @l_error_num=ERROR_NUMBER(),@l_error_desc=ERROR_MESSAGE()
select @l_error_num,@l_error_desc
end catch

