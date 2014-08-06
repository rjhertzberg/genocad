ALTER TABLE rules RENAME TO rules_old;

CREATE TABLE rules (
  rule_id int(11) NOT NULL auto_increment,
  code varchar(255) default NULL,
  category_id int(11) NOT NULL,
  grammar_id int(11) NOT NULL,
  PRIMARY KEY  (rule_id),
  KEY FK_rules_categories (category_id),
  KEY FK_rules_grammars (grammar_id),
  CONSTRAINT FK_rules_categories FOREIGN KEY (category_id) REFERENCES categories (category_id),
  CONSTRAINT FK_rules_grammars FOREIGN KEY (grammar_id) REFERENCES grammars (grammar_id)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=latin1;

CREATE TABLE rule_transform (
  id int(11) NOT NULL auto_increment,
  rule_id int(11) NOT NULL,
  category_id int(11) NOT NULL,
  transform_order int(11) default NULL,
  PRIMARY KEY  (id),
  KEY FK_rule_transform_categories (category_id),
  KEY FK_rule_transform_rules (rule_id),
  CONSTRAINT FK_rule_transform_rules FOREIGN KEY (rule_id) REFERENCES rules (rule_id) ON DELETE CASCADE,
  CONSTRAINT FK_rule_transform_categories FOREIGN KEY (category_id) REFERENCES categories (category_id)
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=latin1;

##ALTER TABLE grammars ADD COLUMN icon_set varchar2(100) default NULL, user_id INTEGER NOT NULL default 0 AFTER is_compilable;

ALTER TABLE grammars 
ADD COLUMN (icon_set varchar(100) default NULL, 
user_id INTEGER NOT NULL default 0);

ALTER TABLE categories DROP COLUMN display;

DROP VIEW IF EXISTS v_parts_browser;

CREATE VIEW v_parts_browser AS
    select p.id AS id,
           p.part_id AS part_id,
           p.description AS part_name,
           p.segment AS part_segment,
           p.user_id AS part_user_id,
           p.description_text AS part_description_text,
           date_format(p.date_created,_utf8'%m/%d/%Y') AS part_date_created,
           date_format(p.last_modified,_utf8'%m/%d/%Y') AS part_last_modified,
           c.letter AS category_letter,
           c.description AS category_description,
           c.category_id AS category_id,
           c.grammar_id AS grammar_id,
           c.icon_name AS icon_name
    from ((parts p join categories_parts cp) join categories c) where ((p.id = cp.part_id) and (cp.category_id = c.category_id));
