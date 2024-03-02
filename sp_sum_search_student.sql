USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[sp_sum_search_student]    Script Date: 02-03-2024 9.52.38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_sum_search_student]
@l_error_num int=0 output,
@l_error_desc varchar(200)=NULL OUTPUT
AS
BEGIN TRY 
print"this dummy1"
select Student_name,sum_mark,DENSE_RANK() over (order by sum_mark desc) from (

select student_name as Student_name,sum(convert(int,marks)) as sum_mark from trans..student group by student_name ) a

end try 
begin catch 
select @l_error_num=ERROR_NUMBER(),@l_error_desc=ERROR_MESSAGE()
select @l_error_num,@l_error_desc
end catch
