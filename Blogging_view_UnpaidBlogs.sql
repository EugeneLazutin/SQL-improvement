use [Blogging]
go

create view [BlogRating] as
select b.BlogId, b.Name, b.Paid, b.UserId, AVG(a.Rating) as rating
from [Blogs] b
left join [Articles] a on a.BlogId = b.BlogId and a.VotedCount > 0
group by b.BlogId, b.Created, b.Name, b.Paid, b.UserId
go 

create view [UnpaidBlogs] as
select
    b.BlogId as Id,
    b.Name as Blog,
    u.Name as Author,
    u.Email as Email,
    COUNT(a.ArticleId) as Articles,
    SUM(CASE WHEN a.Blocked = 1 THEN 1 ELSE 0 END) as Blocked,
    SUM(CASE WHEN a.Blocked = 0 THEN 1 ELSE 0 END) as Unblocked,
    b.Rating
from [BlogRating] b
join [Users] u on b.UserId = u.UserId and b.Paid = 0
join [Articles] a on b.BlogId = a.BlogId
group by b.BlogId, b.Name, u.Name, u.Email, b.rating
go

use [master]
go