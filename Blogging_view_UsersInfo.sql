use [Blogging]
go

create view [UsersInfo] as 
select u.UserId as Id, u.Name, u.Email, AVG(a.Rating) as Rating
from [Users] u
left join [Blogs] b on u.UserId = b.UserId
left join [Articles] a on b.BlogId = a.BlogId and a.VotedCount > 0
group by u.UserId, u.Name, u.Email
go

use [master]
go