use [Blogging]
go

create view [ArticlesInfo] as
select a.ArticleId as Id, a.Title as Title, a.Created as Created, b.Name as Blog, u.Name as Author, count(c.CommentId) as 'Comments'
from [Articles] a
left join [Comments] c on a.ArticleId = c.ArticleId
join [Blogs] b on a.BlogId = b.BlogId
join [Users] u on u.UserId = b.UserId
group by a.ArticleId, a.Title, a.BlogId, a.Created, b.Name, u.Name
go

create procedure [FindArticles] @date datetime as
begin
    set transaction isolation level read uncommitted
    select * from [ArticlesInfo] where [Created] > @date
end
go

use [master]
go