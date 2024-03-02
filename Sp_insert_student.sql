USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[Sp_insert_student]    Script Date: 02-03-2024 9.52.32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Sp_insert_student]
@l_student_name varchar(50),
@l_student_id varchar(50),
@l_subject varchar(50),
@l_marks varchar(50),
@l_error_number int=0 output,
@l_error_desc varchar(200)=null output
AS
Begin Try
print"this dummy1"
	declare
	@l_row_count int

	If exists(select 1 from trans..Student where Student_id=@l_student_id and student_name=@l_student_name)
	Begin
		throw 5001,'Record already present in table',1;
	end
	else
	begin
		insert into trans..student(Student_name,student_id,Subjects,Marks)
		values (@l_student_name,@l_student_id,@l_subject,@l_marks)
		select @l_row_count=@@ROWCOUNT
		if @l_row_count=0
		begin
			throw 5002,'No Record found',1;
		end
	end
end try
begin catch
	select @l_error_number=ERROR_NUMBER(),@l_error_desc=ERROR_MESSAGE()
	select @l_error_number,@l_error_desc
end catch

