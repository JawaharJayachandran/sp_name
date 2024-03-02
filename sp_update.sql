USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[sp_update]    Script Date: 02-03-2024 9.52.42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_update]
@i_student_name varchar(50),
@i_student_id varchar(50),
@i_subjects varchar(50)=null,
@i_marks Varchar(50)=null,
@i_student_id_old varchar(50),
@i_subjects_old varchar(50)=null,
@i_marks_old Varchar(50)=null,
@l_error_num int=0 output,
@l_error_desc varchar(200)=null
as
Begin try 
declare
@l_rowcount int
print"this dummy1"
if not exists ( select 1 from trans..student where student_name=@i_student_name)
begin
	throw 5001,'No record found',1;
end
--else if exists ( select 1 from trans..student where student_name=@i_student_name and student_id=@i_student_id_old)
--begin
--	update trans..student with(rowlock) set student_id=@i_student_id where student_name=@i_student_name and student_id=@i_student_id_old
--end
--else

--if exists ( select 1 from trans..student where student_name=@i_student_name and student_id=@i_student_id_old and )
--begin
--	update trans..student with(rowlock) set student_id=@i_student_id where student_name=@i_student_name and student_id=@i_student_id_old
--end
update trans..student with( rowlock) set student_id=isnull(@i_student_id,student_id),subjects=ISNULL(@i_subjects,subjects),marks=ISNULL(@i_marks,marks) from
trans..student where student_name=@i_student_name and isnull(student_id,'')=coalesce(@i_student_id_old,isnull(student_id,'')) and ISNULL(subjects,'')=coalesce(@i_subjects_old,ISNULL(subjects,'')) 
and ISNULL(marks,'')=coalesce(@i_marks_old,ISNULL(marks,''))

end try 
begin catch
	select @l_error_num=ERROR_NUMBER(),@l_error_desc=ERROR_MESSAGE()
	select @l_error_num,@l_error_desc
end catch
