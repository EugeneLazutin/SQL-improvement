use [Blogging]
go

create procedure [CreateArticle]
@BlogId int,
@Title varchar(60),
@Content varchar(max)
as
begin
    insert into [Articles](BlogId, Title, Content)
    values (@BlogId, @Title, @Content)
end
go

use [master]
go