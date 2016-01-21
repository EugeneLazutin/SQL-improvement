use [master]
go

if exists(select * from sys.databases where name = 'Blogging')
    drop database [Blogging]
    go

create database [Blogging]
go

use [Blogging]
go

set implicit_transactions off
go

create table [Users]
(
    [UserId] int identity(1,1) primary key,
    [Login] varchar(30) not null unique,
    [Password] varchar(30) not null,
    [Name] nvarchar(450) not null,
    [Email] varchar(60) not null unique
)
go

create table [Blogs]
(
    [BlogId] int identity(1,1) primary key,
    [UserId] int not null,
    [Name] varchar(60) not null,
    [Created] datetime not null default getdate(),
    [Paid] bit default 0,
    foreign key ([UserId]) references [Users]([UserId]),
    foreign key ([UserId]) references [Users]([UserId])
)
go

create table [Articles]
(
    [ArticleId] int identity(1,1) primary key,
    [BlogId] int not null,
    [Title] varchar(60) not null,
    [Content] varchar(max),
    [Created] datetime not null default getdate(),
    [Blocked] bit not null default 0,
    [Rating] decimal(2,1) not null default 0,
    [VotedCount] int not null default 0,
    foreign key ([BlogId]) references [Blogs]([BlogId])
)
go

create table [Comments]
(
    [CommentId] int identity(1,1) primary key,
    [UserId] int not null,
    [ArticleId] int not null,
    [Content] varchar(120),
    [Created] datetime not null default getdate(),
    foreign key ([UserId])  references [Users]([UserId]),
    foreign key ([ArticleId]) references [Articles]([ArticleId]),
)
go

create table [Votes]
(
    [UserId] int not null,
    [ArticleId] int not null,
    [Value] int check([Value] >= 1 and [Value] <= 5),
    foreign key ([UserId])  references [Users]([UserId]),
    foreign key ([ArticleId]) references [Articles]([ArticleId]),
    primary key (UserId, ArticleId),
    constraint [VoteUniqueKey] unique (UserId, ArticleId)
)
go

create trigger [SetArticleBlocked] on [Articles] after insert as
begin
    set transaction isolation level read committed
    declare @blogId int = (select top(1) [BlogId] from [inserted])
    declare @blogPaid bit = (select top(1) b.[Paid] from [Blogs] b where b.BlogId = @blogId)

    if @blogPaid = 0
    begin
        declare @articleId int = (select top(1) [ArticleId] from [inserted])
        declare @userId bit = (select top(1) [UserId] from [Blogs] where [BlogId] = @blogId)
        declare @articlesInBlogCount int = (select COUNT(*) from [Articles] a where a.BlogId = @blogId)
        declare @articlesAtUserCount int = (select COUNT(*) from [Articles] a where a.BlogId in (select b.[BlogId] from [Blogs] b where b.[Paid] = 0 and b.[UserId] = @userId))
 
        if (@articlesInBlogCount >= 100 or @articlesAtUserCount >= 1000)
            update [Articles] set Blocked = 1 where ArticleId = @articleId
    end

end
go

use [master]
go