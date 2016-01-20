use [Blogging]
go

create procedure [CreateBlog]
@UserId int,
@Name varchar(60)
as
begin
	insert [Blogs]([Name], [UserId])
	values (@Name, @UserId)
end
go

use [master]
go