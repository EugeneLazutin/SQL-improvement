use [Blogging]
go

create procedure [CreateBlog]
@Name varchar(60),
@UserId int
as
begin
	insert [Blogs]([Name], [UserId])
	values (@Name, @UserId)
end
go

use [master]
go