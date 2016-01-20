use [Blogging]
go

create view [UsersInfo] as 
select u.UserId as id, u.Name as name, u.Email as email, AVG(a.Rating) as 'avg'
from [Users] u
left join [Blogs] b on u.UserId = b.UserId
left join [Articles] a on b.BlogId = a.BlogId and a.VotedCount > 0
group by u.UserId, u.Name, u.Email
go

use [master]
go