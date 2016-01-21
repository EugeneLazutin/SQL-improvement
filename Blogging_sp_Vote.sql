use [Blogging]
go

create procedure [Vote]
@UserId int,
@ArticleId int,
@Value int
as
begin
    declare @num int = 0

    if (select count(*) from [Votes] where [UserId] = @UserId and [ArticleId] = @ArticleId) = 1
        update [Votes] set [Value] = @Value where [UserId] = @UserId and [ArticleId] = @ArticleId
    else
    begin
        insert into [Votes](UserId, ArticleId, Value) values (@UserId, @ArticleId, @Value)
        set @num = 1
    end

    declare @rating decimal(2,1) = (select AVG(convert(decimal(2,1),[Value])) from [Votes] where [ArticleId] = @ArticleId)
    /*declare @count int = (select COUNT(*) from [Votes] where [ArticleId] = @ArticleId)*/
    update [Articles] set [Rating] = @rating, [VotedCount] += @num/*@count*/ where ArticleId = @ArticleId
end
go

use [master]
go