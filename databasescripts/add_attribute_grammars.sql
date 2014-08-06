-- ----------------------------
-- Table structure for `attribute_grammar`
-- ----------------------------
CREATE TABLE `attribute_grammar` (
  `grammar_id` int(11) NOT NULL,
  `code_init` varchar(1000) character set latin1 default NULL,
  `code_end` varchar(1000) character set latin1 default NULL,
  PRIMARY KEY  (`grammar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

- ----------------------------
-- Table structure for `attributes_to_pass`
-- ----------------------------
CREATE TABLE `attributes_to_pass` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
   PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

- ----------------------------
-- Table structure for attribute_types
- ----------------------------
CREATE TABLE `attribute_types` (
  `id` int(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Insert the attribute_types values
-- ----------------------------

INSERT INTO attribute_types VALUES (0, 'Numeric value');

INSERT INTO attribute_types VALUES (1, 'List of parts');


-- ----------------------------
-- Table structure for `category_attribute`
-- ----------------------------
CREATE TABLE `category_attribute` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `description` varchar(120) default NULL,
  `display_order` integer default NULL,
  `attribute_type_id` int(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for `code_tbgenerated`
-- ----------------------------
CREATE TABLE `code_tbgenerated` (
  `id` int(11) NOT NULL auto_increment,
  `grammar_id` int(11) NOT NULL,
  `code` varchar(65000) NOT NULL,
  `type` char(100) default NULL,
   PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
-- Table structure for `parts_category_attribute_assign`
-- ----------------------------
CREATE TABLE `parts_category_attribute_assign` (
  `id` int(11) NOT NULL auto_increment,
  `part_id` int(11) NOT NULL,
  `category_attribute_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for 'category_attribute_list_assign'
-- ----------------------------
CREATE TABLE `category_attribute_list_assign` (
  `id` int(11) NOT NULL auto_increment,
  `category_attribute_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for `rule_semantic_action`
-- ----------------------------
CREATE TABLE `rule_semantic_action` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `rule_id` int(11) NOT NULL,
  `action` varchar(10000) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

alter table parts
modify segment mediumtext;

alter table rules
modify change_to varchar(200);

