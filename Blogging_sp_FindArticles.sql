use [Blogging]
go

create view [ArticlesComments] as 
select a.ArticleId as id, a.Title as title, a.Created as created, a.BlogId as blogId, count(c.CommentId) as 'count'
from [Articles] a
left join [Comments] c on a.ArticleId = c.ArticleId
group by a.ArticleId, a.Title, a.BlogId, a.Created
go

create view [ArticlesInfo] as
select a.id, a.title as 'article title', a.created as created, b.Name as 'blog name', u.Name as 'author', a.count as 'comment count'
from [ArticlesComments] a
join [Blogs] b on a.blogId = b.BlogId
join [Users] u on u.UserId = b.UserId
go

create procedure [FindArticles] @date datetime as
begin
    select * from [ArticlesInfo] where created > @date
end
go

use [master]
go