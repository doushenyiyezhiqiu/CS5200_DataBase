drop database if exists Nature_researchTopic;
create database Nature_researchTopic;
use Nature_researchTopic;

create table publication_issue(
issueId int primary key,
publication_date date,
quantity_sold int
);

create table author(
authorId int primary key,
author_name varchar(100),
affiliation varchar(100),
email_address varchar(100)
);

create table article(
articleId int primary key,
title varchar(200),
issueId int,
foreign key (issueId) references publication_issue(issueId) on update restrict on delete restrict
);

create table article_to_author(
authorId int,
articleId int,
primary key(authorId, articleId),
foreign key (authorId) references author(authorId) on update restrict on delete restrict,
foreign key (articleId) references article(articleId) on update restrict on delete restrict
);

create table keyword(
keywordId int primary key,
phrase_string varchar(100)
);

create table keyword_to_article(
keywordId int,
articleId int,
position int not null,
primary key (keywordId, articleId),
foreign key (articleId) references article(articleId) on update restrict on delete restrict,
foreign key (keywordId) references keyword(keywordId) on update restrict on delete restrict
);

create table research_topic(
topicId int primary key,
topic_name varchar(100)
);

create table keyword_to_topic(
keywordId int,
topicId int,
primary key (keywordId, topicId),
foreign key (keywordId) references keyword(keywordId) on update restrict on delete restrict,
foreign key (topicId) references research_topic(topicId) on update restrict on delete restrict
);

create table test(
id int primary key,
names int NULL NOT NULL
);

insert into test values(1);
