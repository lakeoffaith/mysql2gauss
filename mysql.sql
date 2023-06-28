
DROP TABLE IF EXISTS `sys_app`;

CREATE TABLE `sys_app` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '',
  `owner_name` varchar(200) NOT NULL DEFAULT '',
  `owner_id` varchar(200) DEFAULT '0',
  `project_name` varchar(200) NOT NULL DEFAULT '',
  `project_key` varchar(200) NOT NULL DEFAULT '0',
  `description` varchar(1000) DEFAULT '',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) DEFAULT '0',
  `take_over` tinyint(4) DEFAULT '0',
  `ops_owner_name` varchar(200) DEFAULT NULL,
  `ops_owner_id` varchar(200) DEFAULT NULL,
  `repo_url` varchar(1000) DEFAULT NULL,
  `bu_name` varchar(255) DEFAULT NULL,
  `spring_application_name` varchar(255) DEFAULT NULL,
  `spring_boot_version` int(2) DEFAULT '0',
  `spring_cloud_version` int(2) DEFAULT '0',
  `tenant_id` bigint(20) DEFAULT '-1' COMMENT '租户ID',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `sys_app` VALUES (1,'halo-moss','halo-moss','许进','xujin','halo','Halo','',0,2,1,'韩令三','lingshan.han','https://github.com/SoftwareKing/Moss.git','XX','halo-moss',2,2,-1,'',NULL,'',NULL),(2,'moss-sample-1.5.x','moss-sample-1.5.x','杜为极','weiji.du','BKCASHIER','MOSS','',0,2,1,'叶张','dingf.ye001','https://github.com/SoftwareKing/Moss.git','金融XX','moss-sample-1.5.x',1,1,-1,'',NULL,'',NULL),(3,'moss-sample-2.1.x','moss-sample-2.1.x','许进','guojian.li','MOSS','MOSS','',0,2,1,'齐思宇','daiying.qi','https://github.com/SoftwareKing/Moss.git','房XX','moss-sample-2.1.x',2,2,-1,'',NULL,'',NULL);

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) unique DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(3000) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='参数配置表';


--
-- Dumping data for table `sys_config`
--



INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2023-01-10 14:44:33','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2023-01-10 14:44:33','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2023-01-10 14:44:33','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2023-01-10 14:44:33','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2023-01-10 14:44:33','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'账号错误次数','sys.loginfailedlocking.frequency','10','Y','',NULL,'',NULL,NULL),(7,'登录重试次数','sys.login.maxRetries','6','Y','admin','2023-05-24 08:56:18','',NULL,'用户登录失败多少次后锁定账号'),(8,'密码过期时长(天)-过期后建议更换','sys.password.expireDays','30','Y','admin','2023-05-24 08:56:18','',NULL,'建议用户更换密码时间间隔(单位天)');



--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='字典数据表';


--

--



INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2023-01-10 14:44:33','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2023-01-10 14:44:33','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2023-01-10 14:44:33','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2023-01-10 14:44:33','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2023-01-10 14:44:33','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2023-01-10 14:44:33','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2023-01-10 14:44:33','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2023-01-10 14:44:33','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2023-01-10 14:44:33','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2023-01-10 14:44:33','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2023-01-10 14:44:33','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2023-01-10 14:44:33','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2023-01-10 14:44:33','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2023-01-10 14:44:33','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2023-01-10 14:44:33','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2023-01-10 14:44:33','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2023-01-10 14:44:33','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2023-01-10 14:44:33','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2023-01-10 14:44:33','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2023-01-10 14:44:33','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2023-01-10 14:44:33','',NULL,'停用状态'),(45,1,'正常','0','sys_user_login_locked','','info','N','0','admin','2023-05-24 08:56:19','',NULL,'正常状态'),(46,2,'锁定','1','sys_user_login_locked','','danger','N','0','admin','2023-05-24 08:56:19','',NULL,'锁定状态');


--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) unique DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='字典类型表';


--
-- Dumping data for table `sys_dict_type`
--



INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2023-01-10 14:44:33','admin','2023-03-22 16:55:32','用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2023-01-10 14:44:33','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2023-01-10 14:44:33','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2023-01-10 14:44:33','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2023-01-10 14:44:33','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2023-01-10 14:44:33','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2023-01-10 14:44:33','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2023-01-10 14:44:33','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2023-01-10 14:44:33','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2023-01-10 14:44:33','',NULL,'登录状态列表'),(23,'登录锁定','sys_user_login_locked','0','admin','2023-05-24 08:56:19','',NULL,'登录锁定状态列表');


