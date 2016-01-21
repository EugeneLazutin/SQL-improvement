use [Blogging]
go

create function IsBlocked (@blogId int, @userId int)
returns bit as
begin
    declare @articlesInBlogCount int = (select COUNT(*) from [Articles] a where a.BlogId = @blogId)
    declare @articlesAtUserCount int = (select COUNT(*) from [Articles] a where a.BlogId in (select b.[BlogId] from [Blogs] b where b.[Paid] = 0 and b.[UserId] = @userId))
        
    return case when (@articlesInBlogCount >= 100 or @articlesAtUserCount >= 1000) then 1 else 0 end
end
go

create procedure [CreateArticle]
@BlogId int,
@Title varchar(60),
@Content varchar(max)
as
begin

    set transaction isolation level read committed

    declare @blocked bit = 0
    if (select top(1) [Paid] from [Blogs] where [BlogId] = @BlogId) = 0
    begin
        declare @userId int = (select top(1) [UserId] from [Blogs] where [BlogId] = @blogId)
        exec @blocked = dbo.IsBlocked @BlogId, @userId
    end
    
    begin tran
    insert into [Articles](BlogId, Title, Content, Blocked) values (@BlogId, @Title, @Content, @blocked)
    commit tran
end
go

use [master]
go

