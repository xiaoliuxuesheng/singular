
drop table if exists historical_figures;
create table if not exists historical_figures
(
    id          bigint unsigned primary key auto_increment comment 'ID',
    name        varchar(50) comment '姓名',
    birthday    char(8) comment '生日',
    gender      char(1) comment '性别:M F',
    nationality varchar(50) comment '国籍'
) char set utf8
  engine innoDB comment '历史名人';
insert into historical_figures(id, name, birthday, gender, nationality)
VALUES (1, '', '', '', '');

drop table if exists historical_figures_record;
create table if not exists historical_figures_record
(
    id           bigint unsigned primary key comment 'ID',
    figures_id   bigint comment '人物ID',
    figures_name varchar(50) comment '姓名',
    event_date   char(8) comment '事件时间',
    event_addr   varchar(100) comment '事件地点',
    longitude    double(10, 6) comment '地点经度',
    latitude     double(10, 6) comment '地点纬度',
    event_desc   varchar(255) comment '事件描述'
) char set utf8
  engine innoDB comment '历史名人履历表';

drop table if exists group_company_into;
create table if not exists group_company_into
(
    id           bigint auto_increment primary key comment 'ID',
    name         varchar(50) not null comment '名称',
    founder_id   bigint comment '创始人ID',
    founder_name varchar(100) comment '创始人姓名',
    ceo_id       bigint comment 'CEO人物ID',
    status       char(1) comment '公司状态:O运营中,B破产',
    build_date   char(8) comment '成立时间',
    break_date   char(8) comment '破产时间'
) char set utf8
  engine innoDB comment '大集团公司';

insert into group_company_into(id, name, founder_id, founder_name, ceo_id, status, build_date, break_date)
VALUES ();

drop table if exists group_company_share;
create table if not exists group_company_share
(
    id            bigint auto_increment primary key comment 'ID',
    company_id    bigint comment '公司ID',
    share_company bigint comment '持股公司ID',
    share_ratio   decimal(5, 2) comment '持股比利,百分比'
) char set utf8
  engine innoDB comment '公司股份比例';