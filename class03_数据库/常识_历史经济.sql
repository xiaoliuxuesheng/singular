drop table if exists history_time_tag;
create table if not exists history_time_tag(
    code varchar(10) primary key comment '年代标签简称',
    name varchar(20) not null comment '年代名称',
    start_year int comment '起始年份',
    end_year int comment '终止年份'
)char set utf8 engine innoDB comment '朝代年代标签';

insert into history_time_tag(code, name,end_year) values ('SHWD','三皇五帝时期',0);
insert into history_time_tag(code, name,start_year,end_year) values ('XIA','夏朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('SHANG','商朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('CQZG','春秋战国时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('ZHOU','周朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('QIN','秦朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('HAN','汉朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('XC','新潮时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('SG','三国时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('JIN','晋朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('WHSLG','五胡十六国时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('BEI','北朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('NAN','南朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('SUI','隋朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('TANG','唐朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('WZ','武周时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('LIAO','辽朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('WDSG','五代十国时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('DLC','大理朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('SONG','宋朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('XX','西夏朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('JC','金朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('YUAN','元朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('MING','明朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('QING','清朝时期',0,0);
insert into history_time_tag(code, name,start_year,end_year) values ('JD','近代时期',0,0);


drop table if exists history_state;
CREATE TABLE IF NOT EXISTS history_state(
    id int unique primary key auto_increment comment 'ID',
    civilization char(3) comment '所属文明:GZG-古代中国;GYD-古代印度;GXL-古代希腊;GAJ-古代埃及',
    name varchar(30) not null comment '国家名称',
    founder varchar(50) comment '创建者',
    capital varchar(20) comment '首都',
    city_code varchar(20) comment '现代城市编码',
    tag_code char(10) comment '国家标签',
    start_year int comment '起始年份',
    end_year int comment '终止年份',
    synopsis text comment '简介'
)char set utf8 engine innoDB comment '历史中的朝代';
insert into history_state (civilization, name, founder, capital, tag_code, start_year)
values ('GZG','上古','皇帝','','SHWD',-2146);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','夏朝','禹','斟鄩','XIA',-2146,-1675);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','商朝','商汤','豪','SHANG',-1675,-1046);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','吴国','姑苏','','CQZG',-1100,-473);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','齐国','','临淄','CQZG',-1000,-221);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西周','姬昌','镐京','ZHOU',-1046,-771);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','楚国','熊绎','郢','CQZG',-1042,-403);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','晋国','','翼','CQZG',-1040,-403);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','东周','姬宜臼','洛邑','ZHOU',-770,-256);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','秦国','雍','','CQZG',-768,-207);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西汉','刘邦','长安','HAN',-202,8);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','越国','','会稽','CQZG',-2032,-110);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','新朝','王莽','常安','XC',8,23);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','东汉','刘秀','洛阳','HAN',25,220);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','魏国','曹丕','洛阳','SG',220,265);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','蜀国','刘备','成都','SG',221,263);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','吴国','孙权','建业','SG',222,280);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西晋','司马炎','洛阳','JIN',265,316);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','前赵','刘渊','离石','WHSLG',304,329);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','成汉','李雄','成都','WHSLG',304,347);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','东晋','司马睿','建康','JIN',317,420);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后赵','石勒','襄国','WHSLG',319,352);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','前凉','张茂','姑臧','WHSLG',320,376);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','前燕','慕容皝','大棘城','WHSLG',337,370);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','前秦','苻键','枋头','WHSLG',350,394);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后燕','慕容垂','中山','WHSLG',384,407);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后秦','姚苌','常安','WHSLG',384,417);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西秦','乞伏国仁','勇士城','WHSLG',385,413);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北魏','拓跋珪','平成','WHSLG',386,534);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后凉','吕光','姑臧','WHSLG',386,403);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','南凉','秃发乌孤','姑臧','WHSLG',397,414);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北凉','沮渠蒙逊','骆驼城','WHSLG',397,439);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','南燕','慕容德','广固','WHSLG',398,410);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西凉','李暠','武威','WHSLG',400,421);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北燕','冯跋','龙城','WHSLG',704,436);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','夏国','赫连勃勃','统万城','WHSLG',407,431);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','宋国','刘裕','建康','NAN',420,479);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','齐国','建康','','NAN',479,502);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','梁国','萧衍','建康','NAN',502,557);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','东魏','元善见','邺','BEI',534,550);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西魏','元宝炬','长安','BEI',535,556);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北齐','高洋','邺','BEI',550,557);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北周','宇文觉','长安','BEI',557,581);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','陈国','陈霸先','建康','NAN',557,589);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','隋朝','杨坚','大兴','SUI',581,618);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','唐朝','李渊','长安','TANG',618,907);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','武周','武则天','洛阳','WZ',690,705);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','辽国','耶律阿保机','皇都','LIAO',907,1125);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后梁','朱温','开封','WDSG',907,923);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后唐','李存勖','洛阳','WDSG',923,936);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后晋','石敬瑭','开封','WDSG',936,947);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','大理','段思平','太和城','DLC',937,1254);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后汉','刘知远','开封','WDSG',947,950);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','后周','郭威','开封','WDSG',951,960);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','北宋','赵匡胤','开封','SONG',960,1127);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','西夏','李元昊','兴庆府','XX',1032,1227);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','金国','完颜阿骨打','会宁','JC',1115,1234);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','南宋','赵构','临安','SONG',1127,1279);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','元朝','忽必烈','大都','YUAN',1271,1368);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','明朝','朱元璋','北京','MING',1368,1644);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','清朝','爱新觉罗·皇太极','北京','QING',1644,1912);
insert into history_state (civilization, name, founder, capital, tag_code, start_year, end_year)
values ('GZG','中华民国','孙中山','南京','JD',1912,1949);
insert into history_state (civilization, name, founder, capital, tag_code, start_year)
values ('GZG','中华人民共和国','毛泽东','北京','JD',1949);