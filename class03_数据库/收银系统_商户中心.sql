create database if not exists singularity;
use singularity;

create table if not exists merchant_dict
(
    id          bigint primary key comment 'ID',
    pid         bigint comment '上级ID',
    data_type   varchar(50)     not null comment '数据列表:全大写',
    data_code   varchar(50)     not null comment '数据编码',
    data_value  varchar(100)    not null comment '数据名称',
    sort_no     int unsigned    not null comment '顺序',
    status      tinyint      default 0 comment '有效状态:0删除,1正常',
    is_fixed    tinyint(2)   default 1 COMMENT '0默认为不固定,1固定',
    data_desc   varchar(400) DEFAULT NULL COMMENT '数据描述',
    update_time bigint unsigned not null,
    primary key (`id`),
    KEY idx_dc_dt (data_type, data_code)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='商户系统字典表';

/*

企业/组织	组织机构代码证	ORG
工商营业执照	YYZZ
统一社会信用代码证书	XYDM
部队代号	BUDUIDAIHAO
军队单位对外有偿服务许可证	JUNDUIFUWU
事业单位法人证书	SHIYEDANWEI
外国企业常驻代表机构登记证	WAIGUOQIYE
社会团体法人登记证书	SHEHUITUANTI
宗教活动场所登记证	ZONGJIAOCHANGSUO
民办非企业单位登记证书	MINBANFEIQIYE
基金会法人登记证书	JIJINHUI
律师事务所执业许可证	LVSHISHIWUSUO
外国在华文化中心登记证	WAIGUOWENHUA
外国政府旅游部门常驻代表机构批准登记证	WAIGUOLVYOU
司法鉴定许可证	SIFAJIANDING
境外机构证件	WAIGUOJIGOU
社会服务机构登记证书	SHEHUIFUWUJIGOU
民办学校办学许可证	MINBANXUEXIAO
医疗机构执业许可证	YILIAOJIGOU
公证机构执业证	GONGZHENGJIGOU
北京市外国驻华使馆人员子女学校办学许可证	ZHUHUAZINVXUEXIAO
其他	QT
*/
create table if not exists merchant_type
(
    id        bigint unsigned primary key comment 'ID',
    type_code varchar(10) unique not null comment '类型编号',
    type_name varchar(50)        not null comment '类型名称',
    enabled   tinyint default 1 comment '是否可用'
);
create table if not exists merchant_info
(
    id               bigint unsigned primary key comment 'ID',
    xxdm             varchar(18)  not null comment '统一社会信用代码证书',
    merchant_name    varchar(100) not null comment '门店名称',
    merchant_type_id integer unsigned comment '门店类型ID',
    merchant_referee varchar(50)  not null comment '法定代表人',
    register_date    date comment '成立日期',
    operating_period bigint unique comment '营业期限:保存终止时间,0表示长期',
    pop_up_online    tinyint default 0 comment '是否上线状态',
    xxdm_url         varchar(255) not null comment '信用代码证书图片地址',
    account_lock     tinyint default 0 comment '商户是否锁定',
    enabled          tinyint default 1 comment '使用可用'
);

/*
身份证	SFZ
护照	HZ
港澳居民来往内地通行证	TXZ
台湾居民来往大陆通行证	TW
外国人永久居留身份证	WAIGUOREN
港澳台居民居住证	HKMOJUMIN
*/
create table if not exists merchant_manager
(
    id           bigint unsigned primary key comment 'ID',
    real_name    varchar(50) comment '认证实名',
    user_name    varchar(50) unique not null comment '登陆用户名',
    mobile_phone varchar(11) unique not null comment '手机号码',
    merchant_pwd varchar(200)       not null comment '商户登录密码',
    emp_no       varchar(20) comment '工号:用于登陆收银端',
    emp_pwd      varchar(8) comment '员工密码:明文'

);

CREATE TABLE product_info
(
    product_id        INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '商品ID',
    product_core      CHAR(16)                    NOT NULL COMMENT '商品编码',
    product_name      VARCHAR(20)                 NOT NULL COMMENT '商品名称',
    bar_code          VARCHAR(50)                 NOT NULL COMMENT '国条码',
    brand_id          INT UNSIGNED                NOT NULL COMMENT '品牌表的ID',
    one_category_id   SMALLINT UNSIGNED           NOT NULL COMMENT '一级分类ID',
    two_category_id   SMALLINT UNSIGNED           NOT NULL COMMENT '二级分类ID',
    three_category_id SMALLINT UNSIGNED           NOT NULL COMMENT '三级分类ID',
    supplier_id       INT UNSIGNED                NOT NULL COMMENT '商品的供应商ID',
    price             DECIMAL(8, 2)               NOT NULL COMMENT '商品销售价格',
    average_cost      DECIMAL(18, 2)              NOT NULL COMMENT '商品加权平均成本',
    publish_status    TINYINT                     NOT NULL DEFAULT 0 COMMENT '上下架状态：0下架1上架',
    audit_status      TINYINT                     NOT NULL DEFAULT 0 COMMENT '审核状态：0未审核，1已审核',
    weight            FLOAT COMMENT '商品重量',
    length            FLOAT COMMENT '商品长度',
    height            FLOAT COMMENT '商品高度',
    width             FLOAT COMMENT '商品宽度',
    color_type        ENUM ('红','黄','蓝','黑'),
    production_date   DATETIME                    NOT NULL COMMENT '生产日期',
    shelf_life        INT                         NOT NULL COMMENT '商品有效期',
    descript          TEXT                        NOT NULL COMMENT '商品描述',
    indate            TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品录入时间',
    modified_time     TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_productid (product_id)
) ENGINE = innodb COMMENT '商品信息表';
CREATE TABLE product_pic_info
(
    product_pic_id INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '商品图片ID',
    product_id     INT UNSIGNED                NOT NULL COMMENT '商品ID',
    pic_desc       VARCHAR(50) COMMENT '图片描述',
    pic_url        VARCHAR(200)                NOT NULL COMMENT '图片URL',
    is_master      TINYINT                     NOT NULL DEFAULT 0 COMMENT '是否主图：0.非主图1.主图',
    pic_order      TINYINT                     NOT NULL DEFAULT 0 COMMENT '图片排序',
    pic_status     TINYINT                     NOT NULL DEFAULT 1 COMMENT '图片是否有效：0无效 1有效',
    modified_time  TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_picid (product_pic_id)
) ENGINE = innodb COMMENT '商品图片信息表';
CREATE TABLE product_comment
(
    comment_id    INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '评论ID',
    product_id    INT UNSIGNED                NOT NULL COMMENT '商品ID',
    order_id      BIGINT UNSIGNED             NOT NULL COMMENT '订单ID',
    customer_id   INT UNSIGNED                NOT NULL COMMENT '用户ID',
    title         VARCHAR(50)                 NOT NULL COMMENT '评论标题',
    content       VARCHAR(300)                NOT NULL COMMENT '评论内容',
    audit_status  TINYINT                     NOT NULL COMMENT '审核状态：0未审核，1已审核',
    audit_time    TIMESTAMP                   NOT NULL COMMENT '评论时间',
    modified_time TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_commentid (comment_id)
) ENGINE = innodb COMMENT '商品评论表';

CREATE TABLE order_master
(
    order_id           INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT '订单ID',
    order_sn           BIGINT UNSIGNED NOT NULL COMMENT '订单编号 yyyymmddnnnnnnnn',
    customer_id        INT UNSIGNED    NOT NULL COMMENT '下单人ID',
    shipping_user      VARCHAR(10)     NOT NULL COMMENT '收货人姓名',
    province           SMALLINT        NOT NULL COMMENT '省',
    city               SMALLINT        NOT NULL COMMENT '市',
    district           SMALLINT        NOT NULL COMMENT '区',
    address            VARCHAR(100)    NOT NULL COMMENT '地址',
    payment_method     TINYINT         NOT NULL COMMENT '支付方式：1现金，2余额，3网银，4支付宝，5微信',
    order_money        DECIMAL(8, 2)   NOT NULL COMMENT '订单金额',
    district_money     DECIMAL(8, 2)   NOT NULL DEFAULT 0.00 COMMENT '优惠金额',
    shipping_money     DECIMAL(8, 2)   NOT NULL DEFAULT 0.00 COMMENT '运费金额',
    payment_money      DECIMAL(8, 2)   NOT NULL DEFAULT 0.00 COMMENT '支付金额',
    shipping_comp_name VARCHAR(10) COMMENT '快递公司名称',
    shipping_sn        VARCHAR(50) COMMENT '快递单号',
    create_time        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    shipping_time      DATETIME COMMENT '发货时间',
    pay_time           DATETIME COMMENT '支付时间',
    receive_time       DATETIME COMMENT '收货时间',
    order_status       TINYINT         NOT NULL DEFAULT 0 COMMENT '订单状态',
    order_point        INT UNSIGNED    NOT NULL DEFAULT 0 COMMENT '订单积分',
    invoice_time       VARCHAR(100) COMMENT '发票抬头',
    modified_time      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_orderid (order_id)
) ENGINE = innodb COMMENT '订单主表';
CREATE TABLE order_detail
(
    order_detail_id INT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '订单详情表ID',
    order_id        INT UNSIGNED  NOT NULL COMMENT '订单表ID',
    product_id      INT UNSIGNED  NOT NULL COMMENT '订单商品ID',
    product_name    VARCHAR(50)   NOT NULL COMMENT '商品名称',
    product_cnt     INT           NOT NULL DEFAULT 1 COMMENT '购买商品数量',
    product_price   DECIMAL(8, 2) NOT NULL COMMENT '购买商品单价',
    average_cost    DECIMAL(8, 2) NOT NULL COMMENT '平均成本价格',
    weight          FLOAT COMMENT '商品重量',
    fee_money       DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠分摊金额',
    w_id            INT UNSIGNED  NOT NULL COMMENT '仓库ID',
    modified_time   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_orderdetailid (order_detail_id)
) ENGINE = innodb COMMENT '订单详情表';
CREATE TABLE order_cart
(
    cart_id        INT UNSIGNED  NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
    customer_id    INT UNSIGNED  NOT NULL COMMENT '用户ID',
    product_id     INT UNSIGNED  NOT NULL COMMENT '商品ID',
    product_amount INT           NOT NULL COMMENT '加入购物车商品数量',
    price          DECIMAL(8, 2) NOT NULL COMMENT '商品价格',
    add_time       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入购物车时间',
    modified_time  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_cartid (cart_id)
) ENGINE = innodb COMMENT '购物车表';
CREATE TABLE warehouse_info
(
    w_id             SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '仓库ID',
    warehouse_sn     CHAR(5)           NOT NULL COMMENT '仓库编码',
    warehoust_name   VARCHAR(10)       NOT NULL COMMENT '仓库名称',
    warehouse_phone  VARCHAR(20)       NOT NULL COMMENT '仓库电话',
    contact          VARCHAR(10)       NOT NULL COMMENT '仓库联系人',
    province         SMALLINT          NOT NULL COMMENT '省',
    city             SMALLINT          NOT NULL COMMENT '市',
    distrct          SMALLINT          NOT NULL COMMENT '区',
    address          VARCHAR(100)      NOT NULL COMMENT '仓库地址',
    warehouse_status TINYINT           NOT NULL DEFAULT 1 COMMENT '仓库状态：0禁用，1启用',
    modified_time    TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_wid (w_id)
) ENGINE = innodb COMMENT '仓库信息表';
CREATE TABLE warehouse_product
(
    wp_id          INT UNSIGNED      NOT NULL AUTO_INCREMENT COMMENT '商品库存ID',
    product_id     INT UNSIGNED      NOT NULL COMMENT '商品ID',
    w_id           SMALLINT UNSIGNED NOT NULL COMMENT '仓库ID',
    current_cnt    INT UNSIGNED      NOT NULL DEFAULT 0 COMMENT '当前商品数量',
    lock_cnt       INT UNSIGNED      NOT NULL DEFAULT 0 COMMENT '当前占用数据',
    in_transit_cnt INT UNSIGNED      NOT NULL DEFAULT 0 COMMENT '在途数据',
    average_cost   DECIMAL(8, 2)     NOT NULL DEFAULT 0.00 COMMENT '移动加权成本',
    modified_time  TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_wpid (wp_id)
) ENGINE = innodb COMMENT '商品库存表';
CREATE TABLE shipping_info
(
    ship_id       TINYINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    ship_name     VARCHAR(20)      NOT NULL COMMENT '物流公司名称',
    ship_contact  VARCHAR(20)      NOT NULL COMMENT '物流公司联系人',
    telephone     VARCHAR(20)      NOT NULL COMMENT '物流公司联系电话',
    price         DECIMAL(8, 2)    NOT NULL DEFAULT 0.00 COMMENT '配送价格',
    modified_time TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_shipid (ship_id)
) ENGINE = innodb COMMENT '物流公司信息表';

CREATE TABLE customer_login
(
    customer_id   INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '用户ID',
    login_name    VARCHAR(20)                 NOT NULL COMMENT '用户登录名',
    password      CHAR(32)                    NOT NULL COMMENT 'md5加密的密码',
    user_stats    TINYINT                     NOT NULL DEFAULT 1 COMMENT '用户状态',
    modified_time TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_customerid (customer_id)
) ENGINE = innodb COMMENT '用户登录表';
CREATE TABLE customer_inf
(
    customer_inf_id    INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '自增主键ID',
    customer_id        INT UNSIGNED                NOT NULL COMMENT 'customer_login表的自增ID',
    customer_name      VARCHAR(20)                 NOT NULL COMMENT '用户真实姓名',
    identity_card_type TINYINT                     NOT NULL DEFAULT 1 COMMENT '证件类型：1 身份证，2 军官证，3 护照',
    identity_card_no   VARCHAR(20) COMMENT '证件号码',
    mobile_phone       INT UNSIGNED COMMENT '手机号',
    customer_email     VARCHAR(50) COMMENT '邮箱',
    gender             CHAR(1) COMMENT '性别',
    user_point         INT                         NOT NULL DEFAULT 0 COMMENT '用户积分',
    register_time      TIMESTAMP                   NOT NULL COMMENT '注册时间',
    birthday           DATETIME COMMENT '会员生日',
    customer_level     TINYINT                     NOT NULL DEFAULT 1 COMMENT '会员级别：1 普通会员，2 青铜，3白银，4黄金，5钻石',
    user_money         DECIMAL(8, 2)               NOT NULL DEFAULT 0.00 COMMENT '用户余额',
    modified_time      TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_customerinfid (customer_inf_id)
) ENGINE = innodb COMMENT '用户信息表';
CREATE TABLE customer_level_inf
(
    customer_level TINYINT      NOT NULL AUTO_INCREMENT COMMENT '会员级别ID',
    level_name     VARCHAR(10)  NOT NULL COMMENT '会员级别名称',
    min_point      INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '该级别最低积分',
    max_point      INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '该级别最高积分',
    modified_time  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_levelid (customer_level)
) ENGINE = innodb COMMENT '用户级别信息表';
CREATE TABLE customer_addr
(
    customer_addr_id INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '自增主键ID',
    customer_id      INT UNSIGNED                NOT NULL COMMENT 'customer_login表的自增ID',
    zip              SMALLINT                    NOT NULL COMMENT '邮编',
    province         SMALLINT                    NOT NULL COMMENT '地区表中省份的ID',
    city             SMALLINT                    NOT NULL COMMENT '地区表中城市的ID',
    district         SMALLINT                    NOT NULL COMMENT '地区表中的区ID',
    address          VARCHAR(200)                NOT NULL COMMENT '具体的地址门牌号',
    is_default       TINYINT                     NOT NULL COMMENT '是否默认',
    modified_time    TIMESTAMP                   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY pk_customeraddid (customer_addr_id)
) ENGINE = innodb COMMENT '用户地址表';
CREATE TABLE customer_point_log
(
    point_id     INT UNSIGNED     NOT NULL AUTO_INCREMENT COMMENT '积分日志ID',
    customer_id  INT UNSIGNED     NOT NULL COMMENT '用户ID',
    source       TINYINT UNSIGNED NOT NULL COMMENT '积分来源：0订单，1登陆，2活动',
    refer_number INT UNSIGNED     NOT NULL DEFAULT 0 COMMENT '积分来源相关编号',
    change_point SMALLINT         NOT NULL DEFAULT 0 COMMENT '变更积分数',
    create_time  TIMESTAMP        NOT NULL COMMENT '积分日志生成时间',
    PRIMARY KEY pk_pointid (point_id)
) ENGINE = innodb COMMENT '用户积分日志表';
CREATE TABLE customer_balance_log
(
    balance_id  INT UNSIGNED     NOT NULL AUTO_INCREMENT COMMENT '余额日志ID',
    customer_id INT UNSIGNED     NOT NULL COMMENT '用户ID',
    source      TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '记录来源：1订单，2退货单',
    source_sn   INT UNSIGNED     NOT NULL COMMENT '相关单据ID',
    create_time TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录生成时间',
    amount      DECIMAL(8, 2)    NOT NULL DEFAULT 0.00 COMMENT '变动金额',
    PRIMARY KEY pk_balanceid (balance_id)
) ENGINE = innodb COMMENT '用户余额变动表';
CREATE TABLE customer_login_log
(
    login_id    INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '登陆日志ID',
    customer_id INT UNSIGNED NOT NULL COMMENT '登陆用户ID',
    login_time  TIMESTAMP    NOT NULL COMMENT '用户登陆时间',
    login_ip    INT UNSIGNED NOT NULL COMMENT '登陆IP',
    login_type  TINYINT      NOT NULL COMMENT '登陆类型：0未成功，1成功',
    PRIMARY KEY pk_loginid (login_id)
) ENGINE = innodb COMMENT '用户登陆日志表';