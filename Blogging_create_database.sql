use [master]
go

if exists(select * from sys.databases where name = 'Blogging')
    drop database [Blogging]
    go

create database [Blogging]
go

use [Blogging]
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
    foreign key ([ArticleId]) references [Articles]([ArticleId])
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

use [master]
go