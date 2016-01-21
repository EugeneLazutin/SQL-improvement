use [Blogging]
go

create procedure [CreateBlog]
@UserId int,
@Name varchar(60)
as
begin
    begin tran
        insert [Blogs]([Name], [UserId])
        values (@Name, @UserId)
    commit
end
go

use [master]
go