CREATE DATABASE if NOT EXISTS `tesseract` default character set utf8 collate utf8_general_ci;
use `tesseract`;

create table tesseract_job_detail
(
    id          int unsigned primary key auto_increment,
    trigger_id  int unsigned not null,
    class_name  varchar(255) not null,
    create_time bigint       not null,
    creator     varchar(255) not null,
    unique (trigger_id, class_name)
) engine = InnoDB
  default charset = utf8;

create table tesseract_trigger
(
    id                int unsigned primary key auto_increment,
    name              varchar(30)  not null,
    next_trigger_time bigint       not null,
    prev_trigger_time bigint       not null,
    cron              varchar(30)  not null,
    strategy          tinyint      not null,
    sharding_num      tinyint      not null,
    retry_count       tinyint      not null,
    status            tinyint      not null,
    creator           varchar(255) not null,
    description       text         not null,
    create_time       bigint       not null,
    update_time       bigint       not null,
    index (status),
    unique (name)
) engine = InnoDB
  default charset = utf8;

create table tesseract_fired_trigger
(
    id          int unsigned primary key auto_increment,
    triggerId   int unsigned not null,
    name        varchar(30)  not null,
    create_time bigint       not null
) engine = InnoDB
  default charset = utf8;

create table tesseract_executor
(
    id          int unsigned primary key auto_increment,
    name        varchar(30)  not null,
    socket      varchar(255) not null,
    create_time bigint       not null,
    update_time bigint       not null,
    unique (socket)
) engine = InnoDB
  default charset = utf8;

create table tesseract_executor_trigger_link
(
    id          int unsigned primary key auto_increment,
    trigger_id  int unsigned not null,
    executor_id int unsigned not null,
    unique (trigger_id, executor_id)
) engine = InnoDB
  default charset = utf8;


create table tesseract_lock
(
    id   int unsigned primary key auto_increment,
    name varchar(30) not null
) engine = InnoDB
  default charset = utf8;

create table tesseract_user
(
    id          int unsigned primary key auto_increment,
    name        varchar(30) not null,
    password    varchar(32) not null,
    status      tinyint     not null,
    create_time bigint      not null,
    update_time bigint      not null
) engine = InnoDB
  default charset = utf8;

create table tesseract_token
(
    id          int unsigned primary key auto_increment,
    userId      int unsigned not null,
    userName    varchar(30)  not null,
    token       varchar(255) not null default '',
    create_time bigint       not null,
    expire_time bigint       not null,
    update_time bigint       not null,
    unique (userId)
) engine = InnoDB
  default charset = utf8;

create table tesseract_log
(
    id           bigint unsigned primary key auto_increment,
    trigger_name varchar(30)  not null,
    class_name   varchar(255) not null,
    socket       varchar(255) not null,
    status       tinyint      not null,
    msg          text         not null,
    creator      varchar(255) not null,
    create_time  bigint       not null,
    end_time     bigint       not null
) engine = InnoDB
  default charset = utf8;

insert into tesseract_user(name, password, status, create_time, update_time)
values ('admin', '21232F297A57A5A743894A0E4A801FC3', 0, 1562336661000, 1562336661000);
insert into tesseract_trigger( name, next_trigger_time, prev_trigger_time, cron, strategy, sharding_num, retry_count
                             , status, creator, description, create_time, update_time)
values ('testTrigger', 0, 0, '* * * * * ?', 0, 0, 0, 0, 'admin', 'test', 1562336661000, 1562336661000);