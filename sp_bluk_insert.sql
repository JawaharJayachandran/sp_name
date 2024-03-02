USE [trans]
GO
/****** Object:  StoredProcedure [dbo].[sp_bluk_insert]    Script Date: 02-03-2024 9.57.04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_bluk_insert]
@l_student_name varchar(50),
@l_student_id varchar(50),
@l_param1 varchar(2000)=NULL,
@l_param2 varchar(2000)=NULL,
@l_error_number int=0 output,
@l_error_desc varchar(200) =null output
As

--exec trans..sp_bluk_insert 'Svedha','2', '<BOS>''Scenice'',''90''<EOS>
											-- <BOS>''Social'',''80''<EOS>
											-- <BOS>''Tamil'',''70''<EOS>
											-- <BOS>''ENGLISH'',''60''<EOS>'
											
											

Begin try

declare
@l_row_count int,
@l_param varchar(2000)

create table #bluk_insert
(
Subjects varchar(50),
marks varchar(50)
)
select @l_param1

if ISNULL(ltrim(rtrim(@l_param1)),'')<>''
begin
	select @l_param=REPLACE(@l_param1,'<BOS>','insert into #bluk_insert values (')
	select @l_param
	select @l_param=REPLACE(@l_param,'<EOS>',')')
	select @l_param
	exec (@l_param)
end
if ISNULL(LTRIM(RTRIM(@l_param2)),'')<>''
begin
	select @l_param=REPLACE(@l_param2,'<BOS>','insert into #bluk_insert values (')
	select @l_param=REPLACE(@l_param,'<EOS>',')')
	select (@l_param)
end


if exists(select 1 from trans..student S inner join #bluk_insert BK on s.subjects=bk.Subjects where S.student_name=@l_student_name and S.student_id=@l_student_id)
begin
	Throw 5001,'Record alredy exists',1;
end
else
begin
	insert into trans..student(student_name,Student_ID,Subjects,Marks)
	select @l_student_name ,@l_student_id ,subjects,marks from #bluk_insert
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



