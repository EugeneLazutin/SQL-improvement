use [Blogging]
go

create procedure [CreateUser]
@Login varchar(30),
@Password varchar(30),
@Name varchar(20),
@Email varchar(60)
as
begin
    begin tran
        insert [Users]([Login], [Password], [Name], [Email])
        values (@Login, @Password, @Name, @Email)
    commit
end
go

use [master]
go