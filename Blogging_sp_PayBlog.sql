use [Blogging]
go

create procedure [PayBlog] @BlogId int as
begin
	update [Blogs] set [Paid] = 1 where BlogId = @BlogId
end
go

use [master]
go