use [Blogging]
go

exec CreateUser 'login', 'pass', 'name', 'email'
exec CreateBlog 1, 'blog'

declare @i int = 0

while @i < 120
begin
    set @i += 1
    exec CreateArticle 1, 'title', 'Some stuff'
end

use [master]
go