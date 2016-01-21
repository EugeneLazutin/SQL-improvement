use [Blogging]
go

create procedure [PayBlog] @BlogId int as
begin
    if (select top(1) Paid from [Blogs] where [BlogId] = @BlogId) = 0
    begin
        begin transaction
        begin try
            update [Blogs] set [Paid] = 1 where [BlogId] = @BlogId
            update [Articles] set [Blocked] = 0 where [BlogId] = @blogId
            commit
        end try
        begin catch
            rollback
        end catch
    end
end
go

use [master]
go