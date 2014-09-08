/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50153
Source Host           : localhost:3306
Source Database       : genocad_test_distribution

Target Server Type    : MYSQL
Target Server Version : 50153
File Encoding         : 65001

Date: 2013-11-07 15:35:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `attributes_to_pass`
-- ----------------------------
DROP TABLE IF EXISTS `attributes_to_pass`;
CREATE TABLE `attributes_to_pass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attributes_to_pass
-- ----------------------------

-- ----------------------------
-- Table structure for `attribute_grammar`
-- ----------------------------
DROP TABLE IF EXISTS `attribute_grammar`;
CREATE TABLE `attribute_grammar` (
  `grammar_id` int(11) NOT NULL,
  `code_init` varchar(1000) CHARACTER SET latin1 DEFAULT NULL,
  `code_end` varchar(1000) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`grammar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attribute_grammar
-- ----------------------------

-- ----------------------------
-- Table structure for `attribute_types`
-- ----------------------------
DROP TABLE IF EXISTS `attribute_types`;
CREATE TABLE `attribute_types` (
  `id` int(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attribute_types
-- ----------------------------
INSERT INTO `attribute_types` VALUES ('0', 'Numeric value');
INSERT INTO `attribute_types` VALUES ('1', 'List of parts');
INSERT INTO `attribute_types` VALUES ('2', 'Mapping (ie part, value)');
INSERT INTO `attribute_types` VALUES ('3', 'Declarations (Text)');

-- ----------------------------
-- Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `letter` char(255) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `grammar_id` int(11) DEFAULT NULL,
  `icon_name` varchar(255) DEFAULT NULL,
  `genbank_qualifier_id` int(11) DEFAULT NULL,
  `description_text` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3274 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES ('2316', 'S', 'Start / Transcription unit', '1183', 'start.png', null, null);
INSERT INTO `categories` VALUES ('2317', '[', 'Opening reverse complement delimiter', '1183', 'icon_[.png', null, null);
INSERT INTO `categories` VALUES ('2318', ']', 'Closing reverse complement delimiter', '1183', 'icon_].png', null, null);
INSERT INTO `categories` VALUES ('2319', '(', 'Opening plasmid delimiter', '1183', 'icon_(.png', null, null);
INSERT INTO `categories` VALUES ('2320', ')', 'Closing plasmid delimiter', '1183', 'icon_).png', null, null);
INSERT INTO `categories` VALUES ('2321', '{', 'Opening chromosome delimiter', '1183', 'icon_{.png', null, null);
INSERT INTO `categories` VALUES ('2322', '}', 'Closing chromosome delimiter', '1183', 'icon_}.png', null, null);
INSERT INTO `categories` VALUES ('2323', 'CAS', 'Expression cassette', '1183', 'cds.png', null, null);
INSERT INTO `categories` VALUES ('2324', 'TER', 'Terminator', '1183', 'terminator.png', '52', null);
INSERT INTO `categories` VALUES ('2325', 'PRO', 'Promoter', '1183', 'promoter.png', '36', null);
INSERT INTO `categories` VALUES ('2326', 'RBS', 'Ribosome', '1183', 'translational-start-site.png', '38', null);
INSERT INTO `categories` VALUES ('2327', 'CDS', 'Coding sequence', '1183', 'cds.png', '5', null);
INSERT INTO `categories` VALUES ('3262', 'S', 'Start / Transcription unit', '1237', 'start.png', null, null);
INSERT INTO `categories` VALUES ('3263', '[', 'Opening reverse complement delimiter', '1237', 'icon_[.png', null, null);
INSERT INTO `categories` VALUES ('3264', ']', 'Closing reverse complement delimiter', '1237', 'icon_].png', null, null);
INSERT INTO `categories` VALUES ('3265', '(', 'Opening plasmid delimiter', '1237', 'icon_(.png', null, null);
INSERT INTO `categories` VALUES ('3266', ')', 'Closing plasmid delimiter', '1237', 'icon_).png', null, null);
INSERT INTO `categories` VALUES ('3267', '{', 'Opening chromosome delimiter', '1237', 'icon_{.png', null, null);
INSERT INTO `categories` VALUES ('3268', '}', 'Closing chromosome delimiter', '1237', 'icon_}.png', null, null);
INSERT INTO `categories` VALUES ('3269', 'TP', 'Transcription Unit', '1237', 'cds.png', null, null);
INSERT INTO `categories` VALUES ('3270', 'TER', 'Terminator', '1237', 'terminator.png', null, null);
INSERT INTO `categories` VALUES ('3271', 'PRO', 'Promoter', '1237', 'promoter.png', null, null);
INSERT INTO `categories` VALUES ('3272', 'RBS', 'Ribosome', '1237', 'translational-start-site.png', null, null);
INSERT INTO `categories` VALUES ('3273', 'CDS', 'Coding sequence', '1237', 'cds.png', null, null);

-- ----------------------------
-- Table structure for `categories_parts`
-- ----------------------------
DROP TABLE IF EXISTS `categories_parts`;
CREATE TABLE `categories_parts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `part_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cat_part_idx` (`part_id`,`category_id`,`user_id`),
  KEY `part_idx` (`part_id`),
  KEY `user_idx` (`user_id`),
  KEY `category_idx` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52892 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of categories_parts
-- ----------------------------
INSERT INTO `categories_parts` VALUES ('41586', '21364', '3270', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41585', '21363', '3272', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41584', '21362', '3273', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41583', '21361', '3273', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41582', '21360', '3273', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41581', '21359', '3271', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41580', '21358', '3271', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41579', '21357', '3271', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41578', '21356', '3268', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41577', '21355', '3267', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41576', '21354', '3266', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41575', '21353', '3265', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41574', '21352', '3264', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('41573', '21351', '3263', '0', '2012-10-03 14:31:07');
INSERT INTO `categories_parts` VALUES ('18520', '16017', '2317', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18521', '16018', '2318', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18522', '16019', '2319', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18523', '16020', '2320', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18524', '16021', '2321', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18525', '16022', '2322', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18532', '16029', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18533', '16030', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18534', '16031', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18535', '16032', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18536', '16033', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18537', '16034', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18538', '16035', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18539', '16036', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18540', '16037', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18541', '16038', '2325', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18542', '16039', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18543', '16040', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18544', '16041', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18545', '16042', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18546', '16043', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18547', '16044', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18548', '16045', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18549', '16046', '2326', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18550', '16047', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18551', '16048', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18552', '16049', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18553', '16050', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18554', '16051', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18555', '16052', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18556', '16053', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18557', '16054', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18558', '16055', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18559', '16056', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18560', '16057', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18561', '16058', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18562', '16059', '2327', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18563', '16060', '2324', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18564', '16061', '2324', '0', '2012-04-29 19:41:18');
INSERT INTO `categories_parts` VALUES ('18565', '16062', '2324', '0', '2012-04-29 19:41:18');

-- ----------------------------
-- Table structure for `category_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `category_attribute`;
CREATE TABLE `category_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `description` varchar(120) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  `attribute_type_id` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of category_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for `category_attribute_list_assign`
-- ----------------------------
DROP TABLE IF EXISTS `category_attribute_list_assign`;
CREATE TABLE `category_attribute_list_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_attribute_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of category_attribute_list_assign
-- ----------------------------

-- ----------------------------
-- Table structure for `code_tbgenerated`
-- ----------------------------
DROP TABLE IF EXISTS `code_tbgenerated`;
CREATE TABLE `code_tbgenerated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grammar_id` int(11) NOT NULL,
  `code` varchar(65000) NOT NULL,
  `type` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of code_tbgenerated
-- ----------------------------
INSERT INTO `code_tbgenerated` VALUES ('3', '1183', '%=====PRODUCE SBML====\r\n\r\nproduce_sbml :- tell(\'sbml.java\'),\r\n		init_sbml,\r\n		compute,\r\n		end_sbml,\r\n		told.\r\n\r\n%=====COMPUTE SBML====\r\ncompute :- b_getval(equations, Equations),\r\n	b_getval(proteins, Proteins),compute_equations_sbml(Equations,Proteins).\r\n\r\n%=====INTERACTIONS SBML====\r\n%\r\n%[NameProtein,Timescale,Sigma,Omega0,Interactions]\r\n\r\n\r\n%% base case\r\ncompute_equations_sbml([], Proteins).\r\n\r\n%% recursive case\r\ncompute_equations_sbml([[NameProtein,Timescale,Sigma,Omega0,Interactions] | Rest],Proteins) :-\r\n\r\n	%compute Wi as a libsbmls text-string form of mathematical formulas\r\n	nb_setval(w,Omega0),\r\n        repressor_sbml(Interactions,Proteins),\r\n	b_getval(w,W),\r\n\r\n	%write equation for current Protein_i\r\n	specie(NameProtein),\r\n	write_f(NameProtein,Timescale,Sigma,W),\r\n        compute_equations_sbml(Rest,Proteins).\r\n\r\n%for each repressor of this promoter\r\nrepressor_sbml([],Proteins).\r\nrepressor_sbml([[NameRep,Rate]|Rest],Proteins) :-\r\n		%if one of the repressor of the current promoter or rbs is in proteins then equations else nothing\r\n		(member(NameRep, Proteins) -> b_getval(w, Win), concat_atom([Rate,NameRep],\'*\',Wext), concat_atom([Win,Wext],\'+\',Wout),b_setval(w, Wout),!;true),\r\n        repressor_sbml(Rest, Proteins).\r\n\r\n\r\n\r\n', 'sbml');
INSERT INTO `code_tbgenerated` VALUES ('4', '1183', '%=====INIT SBML FILE====\r\n\r\n%% INTRO\r\n%XML version and character encoding\r\n%SBML level and version\r\n%Model ID and name\r\n%Define the units, e.g., volume, substance\r\n%List of the compartments\r\n\r\ninit_sbml :-write(\'\r\nimport org.sbml.libsbml.*;\r\nimport java.io.*;\r\n\'),write(\'\r\n/*\r\njavac -classpath /usr/local/share/java/libsbmlj.jar sbml.java\r\nexport LD_LIBRARY_PATH=/usr/local/lib/\r\n\'),write(\'\r\nexport CLASSPATH=.:/usr/local/share/java/libsbmlj.jar\r\njava sbml\r\n*/\r\n\'),write(\'\r\n\r\n\r\npublic class sbml\r\n{\r\n\'),write(\'\r\n\r\n  public static void main(String[] args)\r\n  {\r\n\'),write(\'\r\n//Standard intro\r\n\r\nSBMLDocument file=new SBMLDocument(2,4);\r\n\'),write(\'\r\nModel model=file.createModel();\r\nmodel.setId(\"Model\");\r\n\'),write(\'\r\n\r\n//UNITS\r\n\r\n\'),write(\'\r\n//time rate\r\nUnitDefinition time=model.createUnitDefinition();\r\nUnit min=time.createUnit();\r\nmin.setKind(libsbmlConstants.UNIT_KIND_SECOND);\r\n\'),write(\'\r\nmin.setMultiplier(60);\r\nmin.setScale(0);\r\n\'),write(\'\r\n//min.setExponent(1);\r\ntime.setId(\"time\");\r\n\'),write(\'\r\n//compartement\r\nCompartment system=model.createCompartment();\r\nsystem.setId(\"system\");\r\nsystem.setSize(1);\r\n\'),write(\'\r\nsystem.setName(\"system\");\r\nsystem.setConstant(true);\r\n\'),write(\'\r\nString sw;\r\n\').\r\n\r\n%=====END SBML====\r\n\r\nend_sbml:- write(\'\r\n\r\nSBMLWriter writer=new SBMLWriter();\r\n\r\nString sbml=writer.writeSBMLToString(file);\r\n \'),write(\'\r\n//System.out.println(sbml);\r\n \'),write(\'\r\ntry{\r\n \'),write(\'\r\n    Writer output = null;\r\n	 \'),write(\'\r\n    File xml = new File(\"sbml.xml\");\r\n	 \'),write(\'\r\n    output = new BufferedWriter(new FileWriter(xml));\r\n	 \'),write(\'\r\n    output.write(sbml);\r\n	 \'),write(\'\r\n    output.close();\r\n	 \'),write(\'\r\n    }catch (IOException e) {\r\n	 \'),write(\'\r\n    System.out.println(\"Error in sbml.java: \"+e.getMessage());\r\n	}\r\n \'),write(\'\r\n\r\n  }\r\n   \'),write(\'\r\n  /**\r\n   * The following static block is needed in order to load the\r\n   * the libSBML Java module when the application starts.\r\n   */\r\n \'),write(\'\r\n\r\n\r\n  static\r\n  {\r\n\'),write(\'\r\n\r\n    String varname;\r\n    String shlibname;\r\n\'),write(\'\r\n\r\n   if (System.getProperty(\"mrj.version\") != null)\r\n    {\r\n      varname = \"DYLD_LIBRARY_PATH\";    // We are on a Mac.\r\n\'),write(\'\r\n      shlibname = \"libsbmlj.jnilib and/or libsbml.dylib\";\r\n    }\r\n\'),write(\'\r\n    else\r\n    {\r\n      varname = \"LD_LIBRARY_PATH\";      // We are not on a Mac.\r\n\'),write(\'\r\n      shlibname = \"libsbmlj.so and/or libsbml.so\";\r\n    }\r\n\'),write(\'\r\n    try\r\n    {\r\n      System.loadLibrary(\"sbmlj\");\r\n\'),write(\'\r\n      // For extra safety, check that the jar file is in the classpath.\r\n      Class.forName(\"org.sbml.libsbml.libsbml\");\r\n    }\r\n\'),write(\'\r\n    catch (UnsatisfiedLinkError e)\r\n    {\r\n\'),write(\'\r\n      System.err.println(\"Error encountered while attempting to load libSBML:\");\r\n      e.printStackTrace();\r\n\'),write(\'\r\n      System.err.println(\"Please check the value of your \" + varname +\r\n\'),write(\'\r\n             \" environment variable and/or\" +\r\n\'),write(\'\r\n                         \" your java.library.path system property\" +\r\n                         \" (depending on which one you are using) to\" +\r\n\'),write(\'\r\n                         \" make sure it lists all the directories needed to\" +\r\n                         \" find the \" + shlibname + \" library file and the\" +\r\n\'),write(\'\r\n                         \" libraries it depends upon (e.g., the XML parser).\");\r\n      System.exit(1);\r\n    }\r\n\'),write(\'\r\n    catch (ClassNotFoundException e)\r\n    {\r\n      e.printStackTrace();\r\n\'),write(\'\r\n      System.err.println(\"Error: unable to load the file libsbmlj.jar.\" +\r\n\'),write(\'\r\n                         \" It is likely your -classpath option and/or\" +\r\n                         \" CLASSPATH environment variable do not\" +\r\n\'),write(\'\r\n                         \" include the path to the file libsbmlj.jar.\");\r\n      System.exit(1);\r\n    }\r\n\'),write(\'\r\n    catch (SecurityException e)\r\n    {\r\n\'),write(\'\r\n      System.err.println(\"Error encountered while attempting to load libSBML:\");\r\n\'),write(\'\r\n      e.printStackTrace();\r\n      System.err.println(\"Could not load the libSBML library files due to a\"+\'),write(\'\"security exception.\");\r\n\'),write(\'\r\n      System.exit(1);\r\n    }\r\n  }\r\n\r\n}\r\n\').\r\n', 'sbml');
INSERT INTO `code_tbgenerated` VALUES ('5', '1183', '%=====Functions SBML====\r\n%\r\nspecie(Name):-\r\nwrite(\'\r\nSpecies \'),write(Name),write(\'=model.createSpecies();\r\n\'),write(Name),write(\'.setId(\"\'),write(Name),write(\'\");\r\n\'),write(Name),write(\'.setName(\"\'),write(Name),write(\'\");\r\n\'),write(Name),write(\'.setCompartment(\"system\");\r\n\'),write(Name),write(\'.setConstant(false);\r\n\'),write(Name),write(\'.setBoundaryCondition(false);\r\n\'),write(Name),write(\'.setHasOnlySubstanceUnits(true);\r\n\'),write(Name),write(\'.setInitialConcentration(0);\r\n\'),\r\nwrite(\'\r\nSpeciesReference ref_\'),write(Name),write(\'=new SpeciesReference(2,4);\r\nref_\'),write(Name),write(\'.setSpecies(\"\'),write(Name),write(\'\");\r\nref_\'),write(Name),write(\'.setConstant(false);\r\n\').\r\n\r\n\r\nwrite_f(NameProtein,Timescale,Sigma,W):-\r\nwrite(\'\r\n\r\n//reaction\r\nReaction equation_\'),write(NameProtein),write(\'=model.createReaction();\r\n\'),write(\'\r\nequation_\'),write(NameProtein),write(\'.setId(\"equation_\'),write(NameProtein),write(\'\");\r\nequation_\'),write(NameProtein),write(\'.setName(\"equation_\'),write(NameProtein),write(\'\");\r\nequation_\'),write(NameProtein),write(\'.setReversible(false);\r\n\'),write(\'\r\nequation_\'),write(NameProtein),write(\'.setCompartment(\"system\");\r\nequation_\'),write(NameProtein),write(\'.setFast(false);\r\n\'),write(\'\r\n\r\n//reactants\r\n//equation_\'),write(NameProtein),write(\'.addReactant(ref_\'),write(NameProtein),write(\');\r\n\'),write(\'\r\n\r\n//products\r\nequation_\'),write(NameProtein),write(\'.addProduct(ref_\'),write(NameProtein),write(\');\r\n\'),write(\'\r\n\r\n//modifier\r\n//since I do not know what is in W, I will add all of them for now\r\n\'),\r\nwrite_modifiers(NameProtein),\r\nwrite(\'\r\n\r\n//Kinetic law\r\nKineticLaw kl_equation_\'),write(NameProtein),write(\'=equation_\'),write(NameProtein),write(\'.createKineticLaw();\r\n\'),write(\'\r\n\r\nASTNode ntop_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_equation_\'),write(NameProtein),write(\'.setType(libsbmlConstants.AST_TIMES);\r\n\'),write(\'\r\nASTNode ntop_L_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_L_equation_\'),write(NameProtein),write(\'.setValue(\'),write(Timescale),write(\');\r\n\r\n\'),write(\'\r\nASTNode ntop_R_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_R_equation_\'),write(NameProtein),write(\'.setType(libsbmlConstants.AST_MINUS);\r\n\'),write(\'\r\nASTNode ntop_RL_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RL_equation_\'),write(NameProtein),write(\'.setType(libsbmlConstants.AST_DIVIDE);\r\n\'),write(\'\r\nASTNode ntop_RLL_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RLL_equation_\'),write(NameProtein),write(\'.setValue(1);\r\n\'),write(\'\r\nASTNode ntop_RLR_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RLR_equation_\'),write(NameProtein),write(\'.setType(libsbmlConstants.AST_PLUS);\r\n\'),write(\'\r\nASTNode ntop_RLRL_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RLRL_equation_\'),write(NameProtein),write(\'.setValue(1);\r\n\'),write(\'\r\nASTNode ntop_RLRR_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RLRR_equation_\'),write(NameProtein),write(\'.setType(libsbmlConstants.AST_FUNCTION_EXP);\r\n\'),write(\'\r\n//compute sigma*W\r\nsw=\"-\'),write(Sigma),write(\'*(\'),write(W),write(\')\";\r\n//process it because of the negative signs\r\nsw.replace(\"+ -\", \"-\");\r\nsw.replace(\"+-\", \"-\");\r\nASTNode ntop_RLRkid_equation_\'),write(NameProtein),write(\'=libsbml.parseFormula(sw);\r\n\r\n\'),write(\'\r\nASTNode ntop_RR_equation_\'),write(NameProtein),write(\'=new ASTNode();\r\nntop_RR_equation_\'),write(NameProtein),write(\'.setName(\"\'),write(NameProtein),write(\'\");\r\n\r\n\'),write(\'\r\nntop_RLRR_equation_\'),write(NameProtein),write(\'.addChild(ntop_RLRkid_equation_\'),write(NameProtein),write(\');\r\n\r\n\'),write(\'\r\nntop_RLR_equation_\'),write(NameProtein),write(\'.addChild(ntop_RLRL_equation_\'),write(NameProtein),write(\');\r\nntop_RLR_equation_\'),write(NameProtein),write(\'.addChild(ntop_RLRR_equation_\'),write(NameProtein),write(\');\r\n\r\n\'),write(\'\r\nntop_RL_equation_\'),write(NameProtein),write(\'.addChild(ntop_RLL_equation_\'),write(NameProtein),write(\');\r\nntop_RL_equation_\'),write(NameProtein),write(\'.addChild(ntop_RLR_equation_\'),write(NameProtein),write(\');\r\n\r\n\'),write(\'\r\nntop_R_equation_\'),write(NameProtein),write(\'.addChild(ntop_RL_equation_\'),write(NameProtein),write(\');\r\nntop_R_equation_\'),write(NameProtein),write(\'.addChild(ntop_RR_equation_\'),write(NameProtein),write(\');\r\n\r\n\'),write(\'\r\nntop_equation_\'),write(NameProtein),write(\'.addChild(ntop_L_equation_\'),write(NameProtein),write(\');\r\nntop_equation_\'),write(NameProtein),write(\'.addChild(ntop_R_equation_\'),write(NameProtein),write(\');\r\n\r\n\'),write(\'\r\nkl_equation_\'),write(NameProtein),write(\'.setMath(ntop_equation_\'),write(NameProtein),write(\');\r\n\').\r\n\r\nwrite_modifiers(NamePro):-\r\nb_getval(proteins, Proteins),\r\nmodifiers(Proteins,NamePro).\r\n\r\nmodifiers([],NamePro).\r\nmodifiers([Name|Rest],NamePro):-\r\nwrite(\'\r\nModifierSpeciesReference refmod_equation_\'),write(NamePro),write(\'_\'),write(Name),write(\' = equation_\'),write(NamePro),write(\'.createModifier();\r\nrefmod_equation_\'),write(NamePro),write(\'_\'),write(Name),write(\'.setSpecies(\"\'),write(Name),write(\'\");\'),modifiers(Rest,NamePro).\r\n', 'sbml');

-- ----------------------------
-- Table structure for `designs`
-- ----------------------------
DROP TABLE IF EXISTS `designs`;
CREATE TABLE `designs` (
  `design_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `design_json` text,
  `user_id` int(10) unsigned DEFAULT NULL,
  `last_modification` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `terminals_json` text,
  `library_id` int(10) unsigned NOT NULL,
  `is_public` tinyint(4) NOT NULL DEFAULT '0',
  `sequence` text,
  `is_validated` int(11) DEFAULT '0',
  PRIMARY KEY (`design_id`),
  KEY `des_user_id_index` (`user_id`),
  KEY `des_library_id_index` (`library_id`) USING BTREE,
  CONSTRAINT `des_library_id_fk` FOREIGN KEY (`library_id`) REFERENCES `libraries` (`library_id`)
) ENGINE=InnoDB AUTO_INCREMENT=676 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of designs
-- ----------------------------
INSERT INTO `designs` VALUES ('673', 'Switch LacI/TetR', 'placi tetr ptetr laci\r\n\r\nReferences:\r\n\r\nGardner, T. S., Cantor, C. R., & Collins, J. J. (2000). Construction of a genetic toggle switch in Escherichia coli. Nature, 403(6767), 339-42. doi:10.1038/35002131\r\n', null, '0', '2012-10-03 11:21:29', null, '1154', '0', 'caatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagtgagcgcaacgcaattaatgtgagttagctcactcattaggcaccccaggctttacactttatgcttccggctcgtatgttgtgtggaattgtgagcggataacaatttcacacaaaagaggagaaaatgtctagattagataaaagtaaagtgattaacagcgcattagagctgcttaatgaggtcggaatcgaaggtttaacaacccgtaaactcgcccagaagctaggtgtagagcagcctacattgtattggcatgtaaaaaataagcgggctttgctcgacgccttagccattgagatgttagataggcaccatactcacttttgccctttagaaggggaaagctggcaagattttttacgtaataacgctaaaagttttagatgtgctttactaagtcatcgcgatggagcaaaagtacatttaggtacacggcctacagaaaaacagtatgaaactctcgaaaatcaattagcctttttatgccaacaaggtttttcactagagaatgcattatatgcactcagcgctgtggggcattttactttaggttgcgtattggaagatcaagagcatcaagtcgctaaagaagaaagggaaacacctactactgatagtatgccgccattattacgacaagctatcgaattatttgatcaccaaggtgcagagccagccttcttattcggccttgaattgatcatatgcggattagaaaaacaacttaaatgtgaaagtgggtcttaaccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctctccctatcagtgatagagattgacatccctatcagtgatagagatactgagcacaaagaggagaaagtgaaaccagtaacgttatacgatgtcgcagagtatgccggtgtctcttatcagaccgtttcccgcgtggtgaaccaggccagccacgtttctgcgaaaacgcgggaaaaagtggaagcggcgatggcggagctgaattacattcccaaccgcgtggcacaacaactggcgggcaaacagtcgttgctgattggcgttgccacctccagtctggccctgcacgcgccgtcgcaaattgtcgcggcgattaaatctcgcgccgatcaactgggtgccagcgtggtggtgtcgatggtagaacgaagcggcgtcgaagcctgtaaagcggcggtgcacaatcttctcgcgcaacgcgtcagtgggctgatcattaactatccgctggatgaccaggatgccattgctgtggaagctgcctgcactaatgttccggcgttatttcttgatgtctctgaccagacacccatcaacagtattattttctcccatgaagacggtacgcgactgggcgtggagcatctggtcgcattgggtcaccagcaaatcgcgctgttagcgggcccattaagttctgtctcggcgcgtctgcgtctggctggctggcataaatatctcactcgcaatcaaattcagccgatagcggaacgggaaggcgactggagtgccatgtccggttttcaacaaaccatgcaaatgctgaatgagggcatcgttcccactgcgatgctggttgccaacgatcagatggcgctgggcgcaatgcgcgccattaccgagtccgggctgcgcgttggtgcggatatctcggtagtgggatacgacgataccgaagacagctcatgttatatcccgccgtcaaccaccatcaaacaggattttcgcctgctggggcaaaccagcgtggaccgcttgctgcaactctctcagggccaggcggtgaagggcaatcagctgttgcccgtctcactggtgaaaagaaaaaccaccctggcgcccaatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctc', '1');
INSERT INTO `designs` VALUES ('674', 'Repressilator', 'placi tetr pci laci ptetr ci\r\n\r\nReferences:\r\n\r\nElowitz, M. B., & Leibler, S. (2000). A synthetic oscillatory network of transcriptional regulators. Nature, 403(6767), 335-8. doi:10.1038/35002125\r\n', null, '0', '2012-10-03 11:22:58', null, '1154', '0', 'caatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagtgagcgcaacgcaattaatgtgagttagctcactcattaggcaccccaggctttacactttatgcttccggctcgtatgttgtgtggaattgtgagcggataacaatttcacacaaaagaggagaaaatgtctagattagataaaagtaaagtgattaacagcgcattagagctgcttaatgaggtcggaatcgaaggtttaacaacccgtaaactcgcccagaagctaggtgtagagcagcctacattgtattggcatgtaaaaaataagcgggctttgctcgacgccttagccattgagatgttagataggcaccatactcacttttgccctttagaaggggaaagctggcaagattttttacgtaataacgctaaaagttttagatgtgctttactaagtcatcgcgatggagcaaaagtacatttaggtacacggcctacagaaaaacagtatgaaactctcgaaaatcaattagcctttttatgccaacaaggtttttcactagagaatgcattatatgcactcagcgctgtggggcattttactttaggttgcgtattggaagatcaagagcatcaagtcgctaaagaagaaagggaaacacctactactgatagtatgccgccattattacgacaagctatcgaattatttgatcaccaaggtgcagagccagccttcttattcggccttgaattgatcatatgcggattagaaaaacaacttaaatgtgaaagtgggtcttaaccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctctaacaccgtgcgtgttgactattttacctctggcggtgataatggttgcaaagaggagaaagtgaaaccagtaacgttatacgatgtcgcagagtatgccggtgtctcttatcagaccgtttcccgcgtggtgaaccaggccagccacgtttctgcgaaaacgcgggaaaaagtggaagcggcgatggcggagctgaattacattcccaaccgcgtggcacaacaactggcgggcaaacagtcgttgctgattggcgttgccacctccagtctggccctgcacgcgccgtcgcaaattgtcgcggcgattaaatctcgcgccgatcaactgggtgccagcgtggtggtgtcgatggtagaacgaagcggcgtcgaagcctgtaaagcggcggtgcacaatcttctcgcgcaacgcgtcagtgggctgatcattaactatccgctggatgaccaggatgccattgctgtggaagctgcctgcactaatgttccggcgttatttcttgatgtctctgaccagacacccatcaacagtattattttctcccatgaagacggtacgcgactgggcgtggagcatctggtcgcattgggtcaccagcaaatcgcgctgttagcgggcccattaagttctgtctcggcgcgtctgcgtctggctggctggcataaatatctcactcgcaatcaaattcagccgatagcggaacgggaaggcgactggagtgccatgtccggttttcaacaaaccatgcaaatgctgaatgagggcatcgttcccactgcgatgctggttgccaacgatcagatggcgctgggcgcaatgcgcgccattaccgagtccgggctgcgcgttggtgcggatatctcggtagtgggatacgacgataccgaagacagctcatgttatatcccgccgtcaaccaccatcaaacaggattttcgcctgctggggcaaaccagcgtggaccgcttgctgcaactctctcagggccaggcggtgaagggcaatcagctgttgcccgtctcactggtgaaaagaaaaaccaccctggcgcccaatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctctccctatcagtgatagagattgacatccctatcagtgatagagatactgagcacaaagaggagaaaagcacaaaaaagaaaccattaacacaagagcagcttgaggacgcacgtcgccttaaagcaatttatgaaaaaaagaaaaatgaacttggcttatcccaggaatctgtcgcagacaagatggggatggggcagtcaggcgttggtgctttatttaatggcatcaatgcattaaatgcttataacgccgcattgcttgcaaaaattctcaaagttagcgttgaagaatttagcccttcaatcgccagagaaatctacgagatgtatgaagcggttagtatgcagccgtcacttagaagtgagtatgagtaccctgttttttctcatgttcaggcagggatgttctcacctgagcttagaacctttaccaaaggtgatgcggagagatgggtaagcacaaccaaaaaagccagtgattctgcattctggcttgaggttgaaggtaattccatgaccgcaccaacaggctccaagccaagctttcctgacggaatgttaattctcgttgaccctgagcaggctgttgagccaggtgatttctgcatagccagacttgggggtgatgagtttaccttcaagaaactgatcagggatagcggtcaggtgtttttacaaccactaaacccacagtacccaatgatcccatgcaatgagagttgttccgttgtggggaaagttatcgctagtcagtggcctgaagagacgtttggcccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctc', '1');
INSERT INTO `designs` VALUES ('675', 'Switch LacI/cI', 'placi ci pci laci\r\n\r\nReferences:\r\nGardner, T. S., Cantor, C. R., & Collins, J. J. (2000). Construction of a genetic toggle switch in Escherichia coli. Nature, 403(6767), 339-42. doi:10.1038/35002131\r\n', null, '0', '2012-10-03 11:24:03', null, '1154', '0', 'caatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagtgagcgcaacgcaattaatgtgagttagctcactcattaggcaccccaggctttacactttatgcttccggctcgtatgttgtgtggaattgtgagcggataacaatttcacacaaaagaggagaaaagcacaaaaaagaaaccattaacacaagagcagcttgaggacgcacgtcgccttaaagcaatttatgaaaaaaagaaaaatgaacttggcttatcccaggaatctgtcgcagacaagatggggatggggcagtcaggcgttggtgctttatttaatggcatcaatgcattaaatgcttataacgccgcattgcttgcaaaaattctcaaagttagcgttgaagaatttagcccttcaatcgccagagaaatctacgagatgtatgaagcggttagtatgcagccgtcacttagaagtgagtatgagtaccctgttttttctcatgttcaggcagggatgttctcacctgagcttagaacctttaccaaaggtgatgcggagagatgggtaagcacaaccaaaaaagccagtgattctgcattctggcttgaggttgaaggtaattccatgaccgcaccaacaggctccaagccaagctttcctgacggaatgttaattctcgttgaccctgagcaggctgttgagccaggtgatttctgcatagccagacttgggggtgatgagtttaccttcaagaaactgatcagggatagcggtcaggtgtttttacaaccactaaacccacagtacccaatgatcccatgcaatgagagttgttccgttgtggggaaagttatcgctagtcagtggcctgaagagacgtttggcccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctctaacaccgtgcgtgttgactattttacctctggcggtgataatggttgcaaagaggagaaagtgaaaccagtaacgttatacgatgtcgcagagtatgccggtgtctcttatcagaccgtttcccgcgtggtgaaccaggccagccacgtttctgcgaaaacgcgggaaaaagtggaagcggcgatggcggagctgaattacattcccaaccgcgtggcacaacaactggcgggcaaacagtcgttgctgattggcgttgccacctccagtctggccctgcacgcgccgtcgcaaattgtcgcggcgattaaatctcgcgccgatcaactgggtgccagcgtggtggtgtcgatggtagaacgaagcggcgtcgaagcctgtaaagcggcggtgcacaatcttctcgcgcaacgcgtcagtgggctgatcattaactatccgctggatgaccaggatgccattgctgtggaagctgcctgcactaatgttccggcgttatttcttgatgtctctgaccagacacccatcaacagtattattttctcccatgaagacggtacgcgactgggcgtggagcatctggtcgcattgggtcaccagcaaatcgcgctgttagcgggcccattaagttctgtctcggcgcgtctgcgtctggctggctggcataaatatctcactcgcaatcaaattcagccgatagcggaacgggaaggcgactggagtgccatgtccggttttcaacaaaccatgcaaatgctgaatgagggcatcgttcccactgcgatgctggttgccaacgatcagatggcgctgggcgcaatgcgcgccattaccgagtccgggctgcgcgttggtgcggatatctcggtagtgggatacgacgataccgaagacagctcatgttatatcccgccgtcaaccaccatcaaacaggattttcgcctgctggggcaaaccagcgtggaccgcttgctgcaactctctcagggccaggcggtgaagggcaatcagctgttgcccgtctcactggtgaaaagaaaaaccaccctggcgcccaatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctc', '1');

-- ----------------------------
-- Table structure for `design_steps`
-- ----------------------------
DROP TABLE IF EXISTS `design_steps`;
CREATE TABLE `design_steps` (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `step_index` int(11) NOT NULL,
  `design_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`step_id`),
  KEY `fk_design_steps_01` (`design_id`),
  CONSTRAINT `fk_design_steps_01` FOREIGN KEY (`design_id`) REFERENCES `designs` (`design_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12224 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of design_steps
-- ----------------------------
INSERT INTO `design_steps` VALUES ('12197', '0', '673');
INSERT INTO `design_steps` VALUES ('12198', '1', '673');
INSERT INTO `design_steps` VALUES ('12199', '2', '673');
INSERT INTO `design_steps` VALUES ('12200', '3', '673');
INSERT INTO `design_steps` VALUES ('12201', '4', '673');
INSERT INTO `design_steps` VALUES ('12202', '5', '673');
INSERT INTO `design_steps` VALUES ('12203', '6', '673');
INSERT INTO `design_steps` VALUES ('12204', '7', '673');
INSERT INTO `design_steps` VALUES ('12205', '0', '674');
INSERT INTO `design_steps` VALUES ('12206', '1', '674');
INSERT INTO `design_steps` VALUES ('12207', '2', '674');
INSERT INTO `design_steps` VALUES ('12208', '3', '674');
INSERT INTO `design_steps` VALUES ('12209', '4', '674');
INSERT INTO `design_steps` VALUES ('12210', '5', '674');
INSERT INTO `design_steps` VALUES ('12211', '6', '674');
INSERT INTO `design_steps` VALUES ('12212', '7', '674');
INSERT INTO `design_steps` VALUES ('12213', '8', '674');
INSERT INTO `design_steps` VALUES ('12214', '9', '674');
INSERT INTO `design_steps` VALUES ('12215', '10', '674');
INSERT INTO `design_steps` VALUES ('12216', '0', '675');
INSERT INTO `design_steps` VALUES ('12217', '1', '675');
INSERT INTO `design_steps` VALUES ('12218', '2', '675');
INSERT INTO `design_steps` VALUES ('12219', '3', '675');
INSERT INTO `design_steps` VALUES ('12220', '4', '675');
INSERT INTO `design_steps` VALUES ('12221', '5', '675');
INSERT INTO `design_steps` VALUES ('12222', '6', '675');
INSERT INTO `design_steps` VALUES ('12223', '7', '675');

-- ----------------------------
-- Table structure for `design_step_parts`
-- ----------------------------
DROP TABLE IF EXISTS `design_step_parts`;
CREATE TABLE `design_step_parts` (
  `step_id` int(11) NOT NULL,
  `category_index` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `part_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`step_id`,`category_index`),
  KEY `fk_design_step_parts_02` (`category_id`),
  KEY `fk_design_step_parts_03` (`part_id`),
  CONSTRAINT `fk_design_step_parts_01` FOREIGN KEY (`step_id`) REFERENCES `design_steps` (`step_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_design_step_parts_02` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_design_step_parts_03` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of design_step_parts
-- ----------------------------
INSERT INTO `design_step_parts` VALUES ('12197', '0', '3262', null);
INSERT INTO `design_step_parts` VALUES ('12198', '0', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12198', '1', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12199', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12199', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12199', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12199', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12199', '4', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12200', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12200', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12200', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12200', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12200', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12200', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12200', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12200', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12201', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12201', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12201', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12201', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12201', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12201', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12201', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12201', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12202', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12202', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12202', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12202', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12202', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12202', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12202', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12202', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12203', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12203', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12203', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12203', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12203', '4', '3271', '21359');
INSERT INTO `design_step_parts` VALUES ('12203', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12203', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12203', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12204', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12204', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12204', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12204', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12204', '4', '3271', '21359');
INSERT INTO `design_step_parts` VALUES ('12204', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12204', '6', '3273', '21361');
INSERT INTO `design_step_parts` VALUES ('12204', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12205', '0', '3262', null);
INSERT INTO `design_step_parts` VALUES ('12206', '0', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12206', '1', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12206', '2', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12207', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12207', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12207', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12207', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12207', '4', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12207', '5', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12208', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12208', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12208', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12208', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12208', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12208', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12208', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12208', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12208', '8', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12209', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12209', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12209', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12209', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12209', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12209', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12209', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12209', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12209', '8', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12209', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12209', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12209', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12210', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12210', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12210', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12210', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12210', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12210', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12210', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12210', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12210', '8', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12210', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12210', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12210', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12211', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12211', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12211', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12211', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12211', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12211', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12211', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12211', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12211', '8', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12211', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12211', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12211', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12212', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12212', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12212', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12212', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12212', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12212', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12212', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12212', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12212', '8', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12212', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12212', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12212', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12213', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12213', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12213', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12213', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12213', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12213', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12213', '6', '3273', '21361');
INSERT INTO `design_step_parts` VALUES ('12213', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12213', '8', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12213', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12213', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12213', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12214', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12214', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12214', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12214', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12214', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12214', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12214', '6', '3273', '21361');
INSERT INTO `design_step_parts` VALUES ('12214', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12214', '8', '3271', '21359');
INSERT INTO `design_step_parts` VALUES ('12214', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12214', '10', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12214', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12215', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12215', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12215', '2', '3273', '21362');
INSERT INTO `design_step_parts` VALUES ('12215', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12215', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12215', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12215', '6', '3273', '21361');
INSERT INTO `design_step_parts` VALUES ('12215', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12215', '8', '3271', '21359');
INSERT INTO `design_step_parts` VALUES ('12215', '9', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12215', '10', '3273', '21360');
INSERT INTO `design_step_parts` VALUES ('12215', '11', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12216', '0', '3262', null);
INSERT INTO `design_step_parts` VALUES ('12217', '0', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12217', '1', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12218', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12218', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12218', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12218', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12218', '4', '3269', null);
INSERT INTO `design_step_parts` VALUES ('12219', '0', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12219', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12219', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12219', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12219', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12219', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12219', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12219', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12220', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12220', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12220', '2', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12220', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12220', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12220', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12220', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12220', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12221', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12221', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12221', '2', '3273', '21360');
INSERT INTO `design_step_parts` VALUES ('12221', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12221', '4', '3271', null);
INSERT INTO `design_step_parts` VALUES ('12221', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12221', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12221', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12222', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12222', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12222', '2', '3273', '21360');
INSERT INTO `design_step_parts` VALUES ('12222', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12222', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12222', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12222', '6', '3273', null);
INSERT INTO `design_step_parts` VALUES ('12222', '7', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12223', '0', '3271', '21357');
INSERT INTO `design_step_parts` VALUES ('12223', '1', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12223', '2', '3273', '21360');
INSERT INTO `design_step_parts` VALUES ('12223', '3', '3270', '21364');
INSERT INTO `design_step_parts` VALUES ('12223', '4', '3271', '21358');
INSERT INTO `design_step_parts` VALUES ('12223', '5', '3272', '21363');
INSERT INTO `design_step_parts` VALUES ('12223', '6', '3273', '21361');
INSERT INTO `design_step_parts` VALUES ('12223', '7', '3270', '21364');

-- ----------------------------
-- Table structure for `genbank_qualifiers`
-- ----------------------------
DROP TABLE IF EXISTS `genbank_qualifiers`;
CREATE TABLE `genbank_qualifiers` (
  `genbank_qualifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `qualifier` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`genbank_qualifier_id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of genbank_qualifiers
-- ----------------------------
INSERT INTO `genbank_qualifiers` VALUES ('1', 'allele', 'Obsolete; see variation feature key');
INSERT INTO `genbank_qualifiers` VALUES ('2', 'attenuator', 'Sequence related to transcription termination');
INSERT INTO `genbank_qualifiers` VALUES ('3', 'C_region', 'Span of the C immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('4', 'CAAT_signal', '`CAAT box\' in eukaryotic promoters');
INSERT INTO `genbank_qualifiers` VALUES ('5', 'CDS', 'Sequence coding for amino acids in protein (includes stop codon)');
INSERT INTO `genbank_qualifiers` VALUES ('6', 'conflict', 'Independent sequence determinations differ');
INSERT INTO `genbank_qualifiers` VALUES ('7', 'D-loop      ', 'Displacement loop');
INSERT INTO `genbank_qualifiers` VALUES ('8', 'D_segment', 'Span of the D immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('9', 'enhancer', 'Cis-acting enhancer of promoter function');
INSERT INTO `genbank_qualifiers` VALUES ('10', 'exon', 'Region that codes for part of spliced mRNA');
INSERT INTO `genbank_qualifiers` VALUES ('11', 'gene            ', 'Region that defines a functional gene, possibly including upstream (promotor, enhancer, etc) and downstream control elements, and for which a name has been assigned.');
INSERT INTO `genbank_qualifiers` VALUES ('12', 'GC_signal', '`GC box\' in eukaryotic promoters');
INSERT INTO `genbank_qualifiers` VALUES ('13', 'iDNA', 'Intervening DNA eliminated by recombination');
INSERT INTO `genbank_qualifiers` VALUES ('14', 'intron', 'Transcribed region excised by mRNA splicing');
INSERT INTO `genbank_qualifiers` VALUES ('15', 'J_region', 'Span of the J immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('16', 'LTR', 'Long terminal repeat');
INSERT INTO `genbank_qualifiers` VALUES ('17', 'mat_peptide', 'Mature peptide coding region (does not include stop codon)');
INSERT INTO `genbank_qualifiers` VALUES ('18', 'misc_binding', 'Miscellaneous binding site');
INSERT INTO `genbank_qualifiers` VALUES ('19', 'misc_difference', 'Miscellaneous difference feature');
INSERT INTO `genbank_qualifiers` VALUES ('20', 'misc_feature', 'Region of biological significance that cannot be described by any other feature');
INSERT INTO `genbank_qualifiers` VALUES ('21', 'misc_recomb', 'Miscellaneous recombination feature');
INSERT INTO `genbank_qualifiers` VALUES ('22', 'misc_RNA', 'Miscellaneous transcript feature not defined by other RNA keys');
INSERT INTO `genbank_qualifiers` VALUES ('23', 'misc_signal', 'Miscellaneous signal');
INSERT INTO `genbank_qualifiers` VALUES ('24', 'misc_structure', 'Miscellaneous DNA or RNA structure');
INSERT INTO `genbank_qualifiers` VALUES ('25', 'modified_base', 'The indicated base is a modified nucleotide');
INSERT INTO `genbank_qualifiers` VALUES ('26', 'mRNA', 'Messenger RNA');
INSERT INTO `genbank_qualifiers` VALUES ('27', 'mutation ', 'Obsolete: see variation feature key');
INSERT INTO `genbank_qualifiers` VALUES ('28', 'N_region', 'Span of the N immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('29', 'old_sequence', 'Presented sequence revises a previous version');
INSERT INTO `genbank_qualifiers` VALUES ('30', 'polyA_signal', 'Signal for cleavage & polyadenylation');
INSERT INTO `genbank_qualifiers` VALUES ('31', 'polyA_site', 'Site at which polyadenine is added to mRNA');
INSERT INTO `genbank_qualifiers` VALUES ('32', 'precursor_RNA', 'Any RNA species that is not yet the mature RNA product');
INSERT INTO `genbank_qualifiers` VALUES ('33', 'prim_transcript', 'Primary (unprocessed) transcript');
INSERT INTO `genbank_qualifiers` VALUES ('34', 'primer', 'Primer binding region used with PCR');
INSERT INTO `genbank_qualifiers` VALUES ('35', 'primer_bind', 'Non-covalent primer binding site');
INSERT INTO `genbank_qualifiers` VALUES ('36', 'promoter', 'A region involved in transcription initiation');
INSERT INTO `genbank_qualifiers` VALUES ('37', 'protein_bind', 'Non-covalent protein binding site on DNA or RNA');
INSERT INTO `genbank_qualifiers` VALUES ('38', 'RBS', 'Ribosome binding site');
INSERT INTO `genbank_qualifiers` VALUES ('39', 'rep_origin', 'Replication origin for duplex DNA');
INSERT INTO `genbank_qualifiers` VALUES ('40', 'repeat_region', 'Sequence containing repeated subsequences');
INSERT INTO `genbank_qualifiers` VALUES ('41', 'repeat_unit', 'One repeated unit of a repeat_region');
INSERT INTO `genbank_qualifiers` VALUES ('42', 'rRNA', 'Ribosomal RNA');
INSERT INTO `genbank_qualifiers` VALUES ('43', 'S_region', 'Span of the S immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('44', 'satellite', 'Satellite repeated sequence');
INSERT INTO `genbank_qualifiers` VALUES ('45', 'scRNA', 'Small cytoplasmic RNA');
INSERT INTO `genbank_qualifiers` VALUES ('46', 'sig_peptide', 'Signal peptide coding region');
INSERT INTO `genbank_qualifiers` VALUES ('47', 'snRNA', 'Small nuclear RNA');
INSERT INTO `genbank_qualifiers` VALUES ('48', 'source', 'Biological source of the sequence data represented by a GenBank record. Mandatory feature, one or more per record. For organisms that have been incorporated within the qualifier will be present (where');
INSERT INTO `genbank_qualifiers` VALUES ('49', 'stem_loop', 'Hair-pin loop structure in DNA or RNA');
INSERT INTO `genbank_qualifiers` VALUES ('50', 'STS', 'Sequence Tagged Site; operationally unique sequence that identifies the combination of primer spans used in a PCR assay');
INSERT INTO `genbank_qualifiers` VALUES ('51', 'TATA_signal', '`TATA box\' in eukaryotic promoters');
INSERT INTO `genbank_qualifiers` VALUES ('52', 'terminator', 'Sequence causing transcription termination');
INSERT INTO `genbank_qualifiers` VALUES ('53', 'transit_peptide', 'Transit peptide coding region');
INSERT INTO `genbank_qualifiers` VALUES ('54', 'transposon', 'Transposable element (TN)');
INSERT INTO `genbank_qualifiers` VALUES ('55', 'tRNA ', 'Transfer RNA');
INSERT INTO `genbank_qualifiers` VALUES ('56', 'unsure', 'Authors are unsure about the sequence in this region');
INSERT INTO `genbank_qualifiers` VALUES ('57', 'V_region', 'Span of the V immunological feature');
INSERT INTO `genbank_qualifiers` VALUES ('58', 'variation ', 'A related population contains stable mutation');
INSERT INTO `genbank_qualifiers` VALUES ('59', '- (hyphen)', 'Placeholder');
INSERT INTO `genbank_qualifiers` VALUES ('60', '-10_signal', '`Pribnow box\' in prokaryotic promoters');
INSERT INTO `genbank_qualifiers` VALUES ('61', '-35_signal', '`-35 box\' in prokaryotic promoters');
INSERT INTO `genbank_qualifiers` VALUES ('62', '3\'clip', '3\'-most region of a precursor transcript removed in processing');
INSERT INTO `genbank_qualifiers` VALUES ('63', '3\'UTR', '3\' untranslated region (trailer)');
INSERT INTO `genbank_qualifiers` VALUES ('64', '5\'clip', '5\'-most region of a precursor transcript removed in processing');
INSERT INTO `genbank_qualifiers` VALUES ('65', '5\'UTR', '5\' untranslated region (leader)');

-- ----------------------------
-- Table structure for `genbank_specs`
-- ----------------------------
DROP TABLE IF EXISTS `genbank_specs`;
CREATE TABLE `genbank_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_number` int(11) NOT NULL,
  `start_position` int(11) NOT NULL,
  `end_position` int(11) NOT NULL,
  `justification` char(1) NOT NULL,
  `value` varchar(80) DEFAULT NULL,
  `field_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of genbank_specs
-- ----------------------------
INSERT INTO `genbank_specs` VALUES ('1', '1', '1', '5', 'L', 'LOCUS', 'locus');
INSERT INTO `genbank_specs` VALUES ('2', '1', '6', '12', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('3', '1', '13', '28', 'L', null, 'design_name');
INSERT INTO `genbank_specs` VALUES ('4', '1', '29', '29', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('5', '1', '30', '40', 'R', null, 'total_base_pairs');
INSERT INTO `genbank_specs` VALUES ('6', '1', '41', '41', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('7', '1', '42', '43', 'L', 'bp', null);
INSERT INTO `genbank_specs` VALUES ('8', '1', '44', '44', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('9', '1', '45', '47', 'L', '(blank)', 'p1');
INSERT INTO `genbank_specs` VALUES ('10', '1', '48', '53', 'L', 'DNA', 'p2');
INSERT INTO `genbank_specs` VALUES ('11', '1', '54', '55', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('12', '1', '56', '63', 'L', 'linear', 'orientation');
INSERT INTO `genbank_specs` VALUES ('13', '1', '64', '64', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('14', '1', '65', '67', 'L', '(blank)', 'division_code');
INSERT INTO `genbank_specs` VALUES ('15', '1', '68', '68', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('16', '1', '69', '79', 'L', null, 'mod_date');
INSERT INTO `genbank_specs` VALUES ('17', '2', '1', '12', 'L', 'DEFINITION', null);
INSERT INTO `genbank_specs` VALUES ('19', '2', '13', '80', 'L', null, 'definition');
INSERT INTO `genbank_specs` VALUES ('20', '3', '1', '12', 'L', 'ACCESSION', null);
INSERT INTO `genbank_specs` VALUES ('21', '3', '13', '80', 'L', '(blank)', 'accession');
INSERT INTO `genbank_specs` VALUES ('22', '4', '1', '12', 'L', 'VERSION', null);
INSERT INTO `genbank_specs` VALUES ('23', '4', '13', '80', 'L', '(blank)', 'version');
INSERT INTO `genbank_specs` VALUES ('24', '5', '1', '12', 'L', 'KEYWORDS', null);
INSERT INTO `genbank_specs` VALUES ('25', '5', '13', '80', 'L', '.', 'keywords');
INSERT INTO `genbank_specs` VALUES ('26', '7', '1', '21', 'L', 'FEATURES', null);
INSERT INTO `genbank_specs` VALUES ('27', '7', '22', '40', 'L', 'Location/Qualifiers', null);
INSERT INTO `genbank_specs` VALUES ('28', '8', '1', '5', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('29', '8', '6', '20', 'L', null, 'category_key');
INSERT INTO `genbank_specs` VALUES ('30', '8', '21', '21', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('31', '8', '22', '80', 'L', null, 'part_base_pairs');
INSERT INTO `genbank_specs` VALUES ('32', '9', '1', '21', 'L', '(blank)', null);
INSERT INTO `genbank_specs` VALUES ('33', '9', '22', '80', 'L', null, 'qualifier');
INSERT INTO `genbank_specs` VALUES ('34', '10', '1', '6', 'L', 'ORIGIN', null);
INSERT INTO `genbank_specs` VALUES ('37', '6', '1', '12', 'L', 'COMMENT', null);
INSERT INTO `genbank_specs` VALUES ('38', '6', '13', '80', 'L', null, 'comment');

-- ----------------------------
-- Table structure for `grammars`
-- ----------------------------
DROP TABLE IF EXISTS `grammars`;
CREATE TABLE `grammars` (
  `grammar_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `starting_category_id` int(11) DEFAULT NULL,
  `is_compilable` int(11) DEFAULT '1',
  `icon_set` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`grammar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1238 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of grammars
-- ----------------------------
INSERT INTO `grammars` VALUES ('1183', 'Basic Grammar -- No Simulation', '1, 2 or 3 cassette(s), each with a promoter, a ribosome binding site, a coding sequence and a terminator.', '2316', '1', 'sbol_v1_0_icon_set', '0');
INSERT INTO `grammars` VALUES ('1237', 'Gene Regulatory Networks', '*One to three proteins\r\n*Wilson Cowan modeling approach\r\n--REFERENCE:\r\nTyson, J. J., ', '3262', '1', 'sbol_v1_0_icon_set', '0');

-- ----------------------------
-- Table structure for `libraries`
-- ----------------------------
DROP TABLE IF EXISTS `libraries`;
CREATE TABLE `libraries` (
  `library_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grammar_id` int(11) NOT NULL,
  `complete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`library_id`),
  KEY `lib_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of libraries
-- ----------------------------
INSERT INTO `libraries` VALUES ('1073', '0', 'E.coli public', '', '2012-04-29 19:36:54', '1183', null);
INSERT INTO `libraries` VALUES ('1154', '0', 'Standard parts', '', '2012-10-03 14:31:07', '1237', null);

-- ----------------------------
-- Table structure for `library_part_join`
-- ----------------------------
DROP TABLE IF EXISTS `library_part_join`;
CREATE TABLE `library_part_join` (
  `library_id` int(10) unsigned NOT NULL DEFAULT '0',
  `part_id` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`library_id`,`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of library_part_join
-- ----------------------------
INSERT INTO `library_part_join` VALUES ('1073', '16017');
INSERT INTO `library_part_join` VALUES ('1073', '16018');
INSERT INTO `library_part_join` VALUES ('1073', '16019');
INSERT INTO `library_part_join` VALUES ('1073', '16020');
INSERT INTO `library_part_join` VALUES ('1073', '16021');
INSERT INTO `library_part_join` VALUES ('1073', '16022');
INSERT INTO `library_part_join` VALUES ('1073', '16029');
INSERT INTO `library_part_join` VALUES ('1073', '16030');
INSERT INTO `library_part_join` VALUES ('1073', '16031');
INSERT INTO `library_part_join` VALUES ('1073', '16032');
INSERT INTO `library_part_join` VALUES ('1073', '16033');
INSERT INTO `library_part_join` VALUES ('1073', '16034');
INSERT INTO `library_part_join` VALUES ('1073', '16035');
INSERT INTO `library_part_join` VALUES ('1073', '16036');
INSERT INTO `library_part_join` VALUES ('1073', '16037');
INSERT INTO `library_part_join` VALUES ('1073', '16038');
INSERT INTO `library_part_join` VALUES ('1073', '16039');
INSERT INTO `library_part_join` VALUES ('1073', '16040');
INSERT INTO `library_part_join` VALUES ('1073', '16041');
INSERT INTO `library_part_join` VALUES ('1073', '16042');
INSERT INTO `library_part_join` VALUES ('1073', '16043');
INSERT INTO `library_part_join` VALUES ('1073', '16044');
INSERT INTO `library_part_join` VALUES ('1073', '16045');
INSERT INTO `library_part_join` VALUES ('1073', '16046');
INSERT INTO `library_part_join` VALUES ('1073', '16047');
INSERT INTO `library_part_join` VALUES ('1073', '16048');
INSERT INTO `library_part_join` VALUES ('1073', '16049');
INSERT INTO `library_part_join` VALUES ('1073', '16050');
INSERT INTO `library_part_join` VALUES ('1073', '16051');
INSERT INTO `library_part_join` VALUES ('1073', '16052');
INSERT INTO `library_part_join` VALUES ('1073', '16053');
INSERT INTO `library_part_join` VALUES ('1073', '16054');
INSERT INTO `library_part_join` VALUES ('1073', '16055');
INSERT INTO `library_part_join` VALUES ('1073', '16056');
INSERT INTO `library_part_join` VALUES ('1073', '16057');
INSERT INTO `library_part_join` VALUES ('1073', '16058');
INSERT INTO `library_part_join` VALUES ('1073', '16059');
INSERT INTO `library_part_join` VALUES ('1073', '16060');
INSERT INTO `library_part_join` VALUES ('1073', '16061');
INSERT INTO `library_part_join` VALUES ('1073', '16062');
INSERT INTO `library_part_join` VALUES ('1154', '21351');
INSERT INTO `library_part_join` VALUES ('1154', '21352');
INSERT INTO `library_part_join` VALUES ('1154', '21353');
INSERT INTO `library_part_join` VALUES ('1154', '21354');
INSERT INTO `library_part_join` VALUES ('1154', '21355');
INSERT INTO `library_part_join` VALUES ('1154', '21356');
INSERT INTO `library_part_join` VALUES ('1154', '21357');
INSERT INTO `library_part_join` VALUES ('1154', '21358');
INSERT INTO `library_part_join` VALUES ('1154', '21359');
INSERT INTO `library_part_join` VALUES ('1154', '21360');
INSERT INTO `library_part_join` VALUES ('1154', '21361');
INSERT INTO `library_part_join` VALUES ('1154', '21362');
INSERT INTO `library_part_join` VALUES ('1154', '21363');
INSERT INTO `library_part_join` VALUES ('1154', '21364');

-- ----------------------------
-- Table structure for `parts`
-- ----------------------------
DROP TABLE IF EXISTS `parts`;
CREATE TABLE `parts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `part_id` varchar(45) NOT NULL DEFAULT '',
  `description` varchar(45) NOT NULL DEFAULT '',
  `segment` mediumtext,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `description_text` text,
  `last_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `part_id` (`part_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21365 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of parts
-- ----------------------------
INSERT INTO `parts` VALUES ('16017', 'a0254', 'Opening reverse complement delimiter', '[', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16018', 'a0255', 'Closing reverse complement delimiter', ']', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16019', 'a0256', 'Opening plasmid delimiter', '(', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16020', 'a0257', 'Closing plasmid delimiter', ')', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16021', 'a0258', 'Opening chromosome delimiter', '{', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16022', 'a0259', 'Closing chromosome delimiter', '}', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:21:01');
INSERT INTO `parts` VALUES ('16029', 'a025g', 'I0500 - Inducible pBad/araC promoter', 'ttatgacaacttgacggctacatcattcactttttcttcacaaccggcacggaactcgctcgggctggccccggtgcattttttaaatacccgcgagaaatagagttgatcgtcaaaaccaacattgcgaccgacggtggcgataggcatccgggtggtgctcaaaagcagcttcgcctggctgatacgttggtcctcgcgccagcttaagacgctaatccctaactgctggcggaaaagatgtgacagacgcga', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16030', 'a025h', 'R0040 - TetR repressible promoter', 'tccctatcagtgatagagattgacatccctatcagtgatagagatactgagcac', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16031', 'a025i', 'R0010 - LacI regulated promoter', 'caatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagtgagcgcaacgcaat', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16032', 'a025j', 'I13453 - Pbad promoter no AraC', 'acattgattatttgcacggcgtcacactttgctatgccatagcatttttatccataagattagcggatcctacctgacgctttttatcgcaactctctactgtttctccataccgtttttttgggctagc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16033', 'a025k', 'J52034 -', 'cgatgtacgggccagatatacgcgttgacattgattattgcctagttattaatagtaatcaattacggggtcattagttcatagcccatatatggagttccgcgttacataacttacggtaaatggcccgcctggctgaccgcccaacgacccccgcccattgacgtcaataatgacgtatgttcccatagtaacgccaatagggactttccattgacgtcaatgggtggagtatttacggtaaactgcccactt', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16034', 'a025l', 'R0011', 'aattgtgagcggataacaattgacattgtgagcggataacaagatactgagcaca', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16035', 'a025m', 'R0085 - T7 Consensus Promoter', 'taatacgactcactatagggaga', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16036', 'a025n', 'Ptrc-2', 'ccatcgaatggctgaaatgagctgttgacaattaatcatccggctcgtataatgtgtggaattgtgagcggataacaatttcacac', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16037', 'a025o', 'Pl-s1con', 'gcatgcacagataaccatctgcggtgataaattatctctggcggtgttgacataaataccactggcggttataatgagcacatcagcagggtatgcaa', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16038', 'a025p', 'Pltet0-1', 'gcatgctccctatcagtgatagagattgacatccctatcagtgatagagatactgagcacatcagcaggacgcactgacc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16039', 'a025q', 'RBS A', 'aggaggaaaaaa', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16040', 'a025r', 'RBS B', 'aggaatttaa', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16041', 'a025s', 'RBS C', 'aggaaacagacc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16042', 'a025t', 'RBS D', 'aggaaaccggttcg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16043', 'a025u', 'RBS E', 'aggaaaccggtt', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16044', 'a025v', 'RBS F', 'aggacggttcg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16045', 'a025w', 'RBS G', 'aggaaaggcctcg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16046', 'a025x', 'RBS H', 'aggacggccgg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16047', 'a025y', 'E1010 - RFP Mutant', 'atggcttcctccgaagacgttatcaaagagttcatgcgtttcaaagttcgtatggaaggttccgttaacggtcacgagttcgaaatcgaaggtgaaggtgaaggtcgtccgtacgaaggtacccagaccgctaaactgaaagttaccaaaggtggtccgctgccgttcgcttgggacatcctgtccccgcagttccagtacggttccaaagcttacgttaaacacccggctgacatcccggactacctgaaactg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16048', 'a025z', 'J45004 - salicylic acid carboxyl methyltransf', 'atggaagttgttgaagttcttcacatgaatggaggaaatggagacagtagctatgcaaacaattctttggttcagcaaaaggtgattctcatgacaaagccaataactgagcaagccatgattgatctctacagcagcctctttccagaaaccttatgcattgcagatttgggttgttctttgggagctaacactttcttggtggtctcacagcttgttaaaatagtagaaaaagaacgaaaaaagcatggtttt', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16049', 'a0260', 'E0020 - eCFP', 'atggtgagcaagggcgaggagctgttcaccggggtggtgcccatcctggtcgagctggacggcgacgtgaacggccacaagttcagcgtgtccggcgagggcgagggcgatgccacctacggcaagctgaccctgaagttcatctgcaccaccggcaagctgcccgtgccctggcccaccctcgtgaccaccctgacctggggcgtgcagtgcttcagccgctaccccgaccacatgaagcagcacgacttcttc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16050', 'a0261', 'E0030 - eYFP', 'atggtgagcaagggcgaggagctgttcaccggggtggtgcccatcctggtcgagctggacggcgacgtaaacggccacaagttcagcgtgtccggcgagggcgagggcgatgccacctacggcaagctgaccctgaagttcatctgcaccaccggcaagctgcccgtgccctggcccaccctcgtgaccaccttcggctacggcctgcaatgcttcgcccgctaccccgaccacatgaagctgcacgacttcttc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16051', 'a0262', 'J36801 - KaiA coding region', 'gtgctctcgcaaattgcaatctgcatttgggtggaatcgacggcaattttgcaggattgccagcgggcgctgtcggccgatcgctatcaactccaagtctgtgagtctggcgaaatgctcttggagtatgcccaaacccatcgtgaccaaatcgactgcctgattttagtggcagccaatcccagcttcagggcagttgttcagcagctctgctttgagggagtggtggtaccagcgattgtcgtaggcgatcgc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16052', 'a0263', 'J36804 - KaiC coding region', 'atgacttccgctgagatgactagccctaataataattctgagcaccaagccatcgctaagatgcgcacgatgattgaaggctttgatgatattagtcatggcggtcttccaatcgggcgatcgaccctcgttagtggtacttcaggaaccggcaagacccttttttctattcaatttctctataacggtattatcgagtttgatgagcctggggttttcgttactttcgaagaaaccccgcaagatatcattaaa', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16053', 'a0264', 'J31007 - tetracycline resistance protein TetA', 'atgaaatctaacaatgcgctcatcgtcatcctcggcaccgtcaccctggatgctgtaggcataggcttggttatgccggtactgccgggcctcttgcgggatatcgtccattccgacagcatcgccagtcactatggcgtgctgctagcgctatatgcgttgatgcaatttctatgcgcacccgttctcggagcactgtccgaccgctttggccgccgcccagtcctgctcgcttcgctacttggagccactatc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16054', 'a0265', 'J52008 - luciferase', 'atggcttccaaggtgtacgaccccgagcaacgcaaacgcatgatcactgggcctcagtggtgggctcgctgcaagcaaatgaacgtgctggactccttcatcaactactatgattccgagaagcacgccgagaacgccgtgatttttctgcatggtaacgctgcctccagctacctgtggaggcacgtcgtgcctcacatcgagcccgtggctagatgcatcatccctgatctgatcggaatgggtaagtccggc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16055', 'a0266', 'E0040 - GFP Wild Type', 'atgcgtaaaggagaagaacttttcactggagttgtcccaattcttgttgaattagatggtgatgttaatgggcacaaattttctgtcagtggagagggtgaaggtgatgcaacatacggaaaacttacccttaaatttatttgcactactggaaaactacctgttccatggccaacacttgtcactactttcggttatggtgttcaatgctttgcgagatacccagatcatatgaaacagcatgactttttcaag', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16056', 'a0267', 'J06501 - LacI repressor ts', 'atggtgaatgtgaaaccagtaacgttatacgatgtcgcagagtatgccggtgtctcttatcagaccgtttcccgcgtggtgaaccaggccagccacgtttctgcgaaaacgcgggaaaaagtggaagcggcgatggcggagctgaattacattcccaaccgcgtggcacaacaactggcgggcaaacagtcgttgctgattggcgttgccacctccagtctggccctgcacgcgccgtcgcaaattgtcgcggcg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16057', 'a0268', 'cIts', 'atgagcacaaaaaagaaaccattaacacaagagcagcttgaggacgcacgtcgccttaaagcaatttatgaaaaaaagaaaaatgaacttggcttatcccaggaatctgtcgcagacaagatggggatggggcagtcaggcgttggtgctttatttaatggcatcaatgcattaaatgcttataacgccgcattgcttgcaaaaattctcaaagttagcgttgaagaatttagcccttcaatcgccagagaaatc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16058', 'a0269', 'TetR', 'atgtctagattagataaaagtaaagtgattaacagcgcattagagctgcttaatgaggtcggaatcgaaggtttaacaacccgtaaactcgcccagaagctaggtgtagagcagcctacattgtattggcatgtaaaaaataagcgggctttgctcgacgccttagccattgagatgttagataggcaccatactcacttttgccctttagaaggggaaagctggcaagattttttacgtaataacgctaaaagt', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16059', 'a026a', 'tgGFPmut3', 'atgggtaccatgagtaaaggagaagaacttttcactggagttgtcccaattcttgttgaattagatggcgatgttaatgggcaaaaattctctgtcagtggagagggtgaaggtgatgcaacatacggaaaacttacccttaaatttatttgcactactgggaagctacctgttccatggccaacacttgtcactactttcggttatggtgttcaatgctttgcgagatacccagatcatatgaaacagcatgac', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16060', 'a026b', 'B0010 - T1 from E. coli rrnB', 'ccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctc', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16061', 'a026c', 'B0012', 'tcacactggctcaccttcgggtgggcctttctgcgtttata', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('16062', 'a026d', 'B0016 - T7 terminator', 'ctagcataaccccttggggcctctaaacgggtcttgaggggttttttg', '0', '', '2012-04-29 19:40:32', '2012-04-29 19:22:51');
INSERT INTO `parts` VALUES ('21351', 'a069a', 'Opening reverse complement delimiter', '[', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21352', 'a069b', 'Closing reverse complement delimiter', ']', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21353', 'a069c', 'Opening plasmid delimiter', '(', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21354', 'a069d', 'Closing plasmid delimiter', ')', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21355', 'a069e', 'Opening chromosome delimiter', '{', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21356', 'a069f', 'Closing chromosome delimiter', '}', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:56:28');
INSERT INTO `parts` VALUES ('21357', 'a069g', 'placI', 'caatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcagtgagcgcaacgcaattaatgtgagttagctcactcattaggcaccccaggctttacactttatgcttccggctcgtatgttgtgtggaattgtgagcggataacaatttcacaca', '0', 'BBa_R0010\r \r     In the absence of LacI protein and CAP protein, this part promotes transcription.\r     In the presence of LacI protein and CAP protein, this part inhibits transcription.\r     LacI can be inhibited by IPTG.\r     LacI is coded by BBa_C0010', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21358', 'a069h', 'pcI', 'taacaccgtgcgtgttgactattttacctctggcggtgataatggttgc', '0', 'BBa_R0051\r The cI regulated promoter is based on the pR promoter from bacteriophage lambda. The promoter has two DNA binding sites for lambda cI repressor BBa_C0051. cI binding results in repression of transcription. The specific sequence used here is based on the cI repressible promoter used in the Elowitz repressilator (and references therein).', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21359', 'a069i', 'pTetR', 'tccctatcagtgatagagattgacatccctatcagtgatagagatactgagcac', '0', 'BBa_R0040\r Sequence for pTet inverting regulator. Promoter is constitutively ON and repressed by TetR. TetR repression is inhibited by the addition of tetracycline or its analog,', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21360', 'a069j', 'cIts', 'agcacaaaaaagaaaccattaacacaagagcagcttgaggacgcacgtcgccttaaagcaatttatgaaaaaaagaaaaatgaacttggcttatcccaggaatctgtcgcagacaagatggggatggggcagtcaggcgttggtgctttatttaatggcatcaatgcattaaatgcttataacgccgcattgcttgcaaaaattctcaaagttagcgttgaagaatttagcccttcaatcgccagagaaatctacgagatgtatgaagcggttagtatgcagccgtcacttagaagtgagtatgagtaccctgttttttctcatgttcaggcagggatgttctcacctgagcttagaacctttaccaaaggtgatgcggagagatgggtaagcacaaccaaaaaagccagtgattctgcattctggcttgaggttgaaggtaattccatgaccgcaccaacaggctccaagccaagctttcctgacggaatgttaattctcgttgaccctgagcaggctgttgagccaggtgatttctgcatagccagacttgggggtgatgagtttaccttcaagaaactgatcagggatagcggtcaggtgtttttacaaccactaaacccacagtacccaatgatcccatgcaatgagagttgttccgttgtggggaaagttatcgctagtcagtggcctgaagagacgtttggc', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21361', 'a069k', 'lacI', 'gtgaaaccagtaacgttatacgatgtcgcagagtatgccggtgtctcttatcagaccgtttcccgcgtggtgaaccaggccagccacgtttctgcgaaaacgcgggaaaaagtggaagcggcgatggcggagctgaattacattcccaaccgcgtggcacaacaactggcgggcaaacagtcgttgctgattggcgttgccacctccagtctggccctgcacgcgccgtcgcaaattgtcgcggcgattaaatctcgcgccgatcaactgggtgccagcgtggtggtgtcgatggtagaacgaagcggcgtcgaagcctgtaaagcggcggtgcacaatcttctcgcgcaacgcgtcagtgggctgatcattaactatccgctggatgaccaggatgccattgctgtggaagctgcctgcactaatgttccggcgttatttcttgatgtctctgaccagacacccatcaacagtattattttctcccatgaagacggtacgcgactgggcgtggagcatctggtcgcattgggtcaccagcaaatcgcgctgttagcgggcccattaagttctgtctcggcgcgtctgcgtctggctggctggcataaatatctcactcgcaatcaaattcagccgatagcggaacgggaaggcgactggagtgccatgtccggttttcaacaaaccatgcaaatgctgaatgagggcatcgttcccactgcgatgctggttgccaacgatcagatggcgctgggcgcaatgcgcgccattaccgagtccgggctgcgcgttggtgcggatatctcggtagtgggatacgacgataccgaagacagctcatgttatatcccgccgtcaaccaccatcaaacaggattttcgcctgctggggcaaaccagcgtggaccgcttgctgcaactctctcagggccaggcggtgaagggcaatcagctgttgcccgtctcactggtgaaaagaaaaaccaccctggcgcccaatacgcaaaccgcctctccccgcgcgttggccgattcattaatgcagctggcacgacaggtttcccgactggaaagcgggcag', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21362', 'a069l', 'tetR', 'atgtctagattagataaaagtaaagtgattaacagcgcattagagctgcttaatgaggtcggaatcgaaggtttaacaacccgtaaactcgcccagaagctaggtgtagagcagcctacattgtattggcatgtaaaaaataagcgggctttgctcgacgccttagccattgagatgttagataggcaccatactcacttttgccctttagaaggggaaagctggcaagattttttacgtaataacgctaaaagttttagatgtgctttactaagtcatcgcgatggagcaaaagtacatttaggtacacggcctacagaaaaacagtatgaaactctcgaaaatcaattagcctttttatgccaacaaggtttttcactagagaatgcattatatgcactcagcgctgtggggcattttactttaggttgcgtattggaagatcaagagcatcaagtcgctaaagaagaaagggaaacacctactactgatagtatgccgccattattacgacaagctatcgaattatttgatcaccaaggtgcagagccagccttcttattcggccttgaattgatcatatgcggattagaaaaacaacttaaatgtgaaagtgggtcttaa', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21363', 'a069m', 'My_RBS', 'aaagaggagaaa', '0', 'Strong_RBS', '2012-10-03 14:31:07', '2012-10-03 10:57:38');
INSERT INTO `parts` VALUES ('21364', 'a069n', 'B0010', 'ccaggcatcaaataaaacgaaaggctcagtcgaaagactgggcctttcgttttatctgttgtttgtcggtgaacgctctc', '0', '', '2012-10-03 14:31:07', '2012-10-03 10:57:38');

-- ----------------------------
-- Table structure for `partslist`
-- ----------------------------
DROP TABLE IF EXISTS `partslist`;
CREATE TABLE `partslist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4891 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of partslist
-- ----------------------------
INSERT INTO `partslist` VALUES ('4888', '2013-02-07 14:41:58', '2013-02-07 14:41:58', '-1');
INSERT INTO `partslist` VALUES ('4889', '2013-02-07 14:43:17', '2013-02-07 14:43:17', '80');
INSERT INTO `partslist` VALUES ('4890', '2013-08-06 15:07:34', '2013-08-06 15:07:34', '0');

-- ----------------------------
-- Table structure for `partslist_parts`
-- ----------------------------
DROP TABLE IF EXISTS `partslist_parts`;
CREATE TABLE `partslist_parts` (
  `partslist_id` int(10) unsigned NOT NULL,
  `part_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`partslist_id`,`part_id`),
  CONSTRAINT `FK_partslist_parts_1` FOREIGN KEY (`partslist_id`) REFERENCES `partslist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of partslist_parts
-- ----------------------------

-- ----------------------------
-- Table structure for `parts_category_attribute_assign`
-- ----------------------------
DROP TABLE IF EXISTS `parts_category_attribute_assign`;
CREATE TABLE `parts_category_attribute_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part_id` int(11) NOT NULL,
  `category_attribute_id` int(11) NOT NULL,
  `value` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of parts_category_attribute_assign
-- ----------------------------

-- ----------------------------
-- Table structure for `rebase_parts`
-- ----------------------------
DROP TABLE IF EXISTS `rebase_parts`;
CREATE TABLE `rebase_parts` (
  `library_id` int(10) unsigned NOT NULL DEFAULT '0',
  `part_id` varchar(45) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of rebase_parts
-- ----------------------------
INSERT INTO `rebase_parts` VALUES ('137', '14095');
INSERT INTO `rebase_parts` VALUES ('137', '14096');
INSERT INTO `rebase_parts` VALUES ('137', '14097');
INSERT INTO `rebase_parts` VALUES ('137', '14098');
INSERT INTO `rebase_parts` VALUES ('137', '14099');
INSERT INTO `rebase_parts` VALUES ('137', '14100');
INSERT INTO `rebase_parts` VALUES ('137', '14101');
INSERT INTO `rebase_parts` VALUES ('137', '14102');
INSERT INTO `rebase_parts` VALUES ('137', '14103');
INSERT INTO `rebase_parts` VALUES ('137', '14104');
INSERT INTO `rebase_parts` VALUES ('137', '14105');
INSERT INTO `rebase_parts` VALUES ('137', '14106');
INSERT INTO `rebase_parts` VALUES ('137', '14107');
INSERT INTO `rebase_parts` VALUES ('137', '14108');
INSERT INTO `rebase_parts` VALUES ('137', '14109');
INSERT INTO `rebase_parts` VALUES ('137', '14110');
INSERT INTO `rebase_parts` VALUES ('137', '14111');
INSERT INTO `rebase_parts` VALUES ('137', '14112');
INSERT INTO `rebase_parts` VALUES ('137', '14113');
INSERT INTO `rebase_parts` VALUES ('137', '14114');
INSERT INTO `rebase_parts` VALUES ('137', '14115');
INSERT INTO `rebase_parts` VALUES ('137', '14116');
INSERT INTO `rebase_parts` VALUES ('137', '14117');
INSERT INTO `rebase_parts` VALUES ('137', '14118');
INSERT INTO `rebase_parts` VALUES ('137', '14119');
INSERT INTO `rebase_parts` VALUES ('137', '14120');
INSERT INTO `rebase_parts` VALUES ('137', '14121');
INSERT INTO `rebase_parts` VALUES ('137', '14122');
INSERT INTO `rebase_parts` VALUES ('137', '14123');
INSERT INTO `rebase_parts` VALUES ('137', '14124');
INSERT INTO `rebase_parts` VALUES ('137', '14125');
INSERT INTO `rebase_parts` VALUES ('137', '14126');
INSERT INTO `rebase_parts` VALUES ('137', '14127');
INSERT INTO `rebase_parts` VALUES ('137', '14128');
INSERT INTO `rebase_parts` VALUES ('137', '14129');
INSERT INTO `rebase_parts` VALUES ('137', '14130');
INSERT INTO `rebase_parts` VALUES ('137', '14131');
INSERT INTO `rebase_parts` VALUES ('137', '14132');
INSERT INTO `rebase_parts` VALUES ('137', '14133');
INSERT INTO `rebase_parts` VALUES ('137', '14134');
INSERT INTO `rebase_parts` VALUES ('137', '14135');
INSERT INTO `rebase_parts` VALUES ('137', '14136');
INSERT INTO `rebase_parts` VALUES ('137', '14137');
INSERT INTO `rebase_parts` VALUES ('137', '14138');
INSERT INTO `rebase_parts` VALUES ('137', '14139');
INSERT INTO `rebase_parts` VALUES ('137', '14140');
INSERT INTO `rebase_parts` VALUES ('137', '14141');
INSERT INTO `rebase_parts` VALUES ('137', '14142');
INSERT INTO `rebase_parts` VALUES ('137', '14143');
INSERT INTO `rebase_parts` VALUES ('137', '14144');
INSERT INTO `rebase_parts` VALUES ('137', '14145');
INSERT INTO `rebase_parts` VALUES ('137', '14146');
INSERT INTO `rebase_parts` VALUES ('137', '14147');
INSERT INTO `rebase_parts` VALUES ('137', '14148');
INSERT INTO `rebase_parts` VALUES ('137', '14149');
INSERT INTO `rebase_parts` VALUES ('137', '14150');
INSERT INTO `rebase_parts` VALUES ('137', '14151');
INSERT INTO `rebase_parts` VALUES ('137', '14152');
INSERT INTO `rebase_parts` VALUES ('137', '14153');
INSERT INTO `rebase_parts` VALUES ('137', '14154');
INSERT INTO `rebase_parts` VALUES ('137', '14155');
INSERT INTO `rebase_parts` VALUES ('137', '14156');
INSERT INTO `rebase_parts` VALUES ('137', '14157');
INSERT INTO `rebase_parts` VALUES ('137', '14158');
INSERT INTO `rebase_parts` VALUES ('137', '14159');
INSERT INTO `rebase_parts` VALUES ('137', '14160');
INSERT INTO `rebase_parts` VALUES ('137', '14161');
INSERT INTO `rebase_parts` VALUES ('137', '14162');
INSERT INTO `rebase_parts` VALUES ('137', '14163');
INSERT INTO `rebase_parts` VALUES ('137', '14164');
INSERT INTO `rebase_parts` VALUES ('137', '14165');
INSERT INTO `rebase_parts` VALUES ('137', '14166');
INSERT INTO `rebase_parts` VALUES ('137', '14167');
INSERT INTO `rebase_parts` VALUES ('137', '14168');
INSERT INTO `rebase_parts` VALUES ('137', '14169');
INSERT INTO `rebase_parts` VALUES ('137', '14170');
INSERT INTO `rebase_parts` VALUES ('137', '14171');
INSERT INTO `rebase_parts` VALUES ('137', '14172');
INSERT INTO `rebase_parts` VALUES ('137', '14173');
INSERT INTO `rebase_parts` VALUES ('137', '14174');
INSERT INTO `rebase_parts` VALUES ('137', '14175');
INSERT INTO `rebase_parts` VALUES ('137', '14176');
INSERT INTO `rebase_parts` VALUES ('137', '14177');
INSERT INTO `rebase_parts` VALUES ('137', '14178');
INSERT INTO `rebase_parts` VALUES ('137', '14179');
INSERT INTO `rebase_parts` VALUES ('137', '14180');
INSERT INTO `rebase_parts` VALUES ('137', '14181');
INSERT INTO `rebase_parts` VALUES ('137', '14182');
INSERT INTO `rebase_parts` VALUES ('137', '14183');
INSERT INTO `rebase_parts` VALUES ('137', '14184');
INSERT INTO `rebase_parts` VALUES ('137', '14185');
INSERT INTO `rebase_parts` VALUES ('137', '14186');
INSERT INTO `rebase_parts` VALUES ('137', '14187');
INSERT INTO `rebase_parts` VALUES ('137', '14188');
INSERT INTO `rebase_parts` VALUES ('137', '14189');
INSERT INTO `rebase_parts` VALUES ('137', '14190');
INSERT INTO `rebase_parts` VALUES ('137', '14191');
INSERT INTO `rebase_parts` VALUES ('137', '14192');
INSERT INTO `rebase_parts` VALUES ('137', '14193');
INSERT INTO `rebase_parts` VALUES ('137', '14194');
INSERT INTO `rebase_parts` VALUES ('137', '14195');
INSERT INTO `rebase_parts` VALUES ('137', '14196');
INSERT INTO `rebase_parts` VALUES ('137', '14197');
INSERT INTO `rebase_parts` VALUES ('137', '14198');
INSERT INTO `rebase_parts` VALUES ('137', '14199');
INSERT INTO `rebase_parts` VALUES ('137', '14200');
INSERT INTO `rebase_parts` VALUES ('137', '14201');
INSERT INTO `rebase_parts` VALUES ('137', '14202');
INSERT INTO `rebase_parts` VALUES ('137', '14203');
INSERT INTO `rebase_parts` VALUES ('137', '14204');
INSERT INTO `rebase_parts` VALUES ('137', '14205');
INSERT INTO `rebase_parts` VALUES ('137', '14206');
INSERT INTO `rebase_parts` VALUES ('137', '14207');
INSERT INTO `rebase_parts` VALUES ('137', '14208');
INSERT INTO `rebase_parts` VALUES ('137', '14209');
INSERT INTO `rebase_parts` VALUES ('137', '14210');
INSERT INTO `rebase_parts` VALUES ('137', '14211');
INSERT INTO `rebase_parts` VALUES ('137', '14212');
INSERT INTO `rebase_parts` VALUES ('137', '14213');
INSERT INTO `rebase_parts` VALUES ('137', '14214');
INSERT INTO `rebase_parts` VALUES ('137', '14215');
INSERT INTO `rebase_parts` VALUES ('137', '14216');
INSERT INTO `rebase_parts` VALUES ('137', '14217');
INSERT INTO `rebase_parts` VALUES ('137', '14218');
INSERT INTO `rebase_parts` VALUES ('137', '14219');
INSERT INTO `rebase_parts` VALUES ('137', '14220');
INSERT INTO `rebase_parts` VALUES ('137', '14221');
INSERT INTO `rebase_parts` VALUES ('137', '14222');
INSERT INTO `rebase_parts` VALUES ('137', '14223');
INSERT INTO `rebase_parts` VALUES ('137', '14224');
INSERT INTO `rebase_parts` VALUES ('137', '14225');
INSERT INTO `rebase_parts` VALUES ('137', '14226');
INSERT INTO `rebase_parts` VALUES ('137', '14227');
INSERT INTO `rebase_parts` VALUES ('137', '14228');
INSERT INTO `rebase_parts` VALUES ('137', '14229');
INSERT INTO `rebase_parts` VALUES ('137', '14230');
INSERT INTO `rebase_parts` VALUES ('137', '14231');
INSERT INTO `rebase_parts` VALUES ('137', '14232');
INSERT INTO `rebase_parts` VALUES ('137', '14233');
INSERT INTO `rebase_parts` VALUES ('137', '14234');
INSERT INTO `rebase_parts` VALUES ('137', '14235');
INSERT INTO `rebase_parts` VALUES ('137', '14236');
INSERT INTO `rebase_parts` VALUES ('137', '14237');
INSERT INTO `rebase_parts` VALUES ('137', '14238');
INSERT INTO `rebase_parts` VALUES ('137', '14239');
INSERT INTO `rebase_parts` VALUES ('137', '14240');
INSERT INTO `rebase_parts` VALUES ('137', '14241');
INSERT INTO `rebase_parts` VALUES ('137', '14242');
INSERT INTO `rebase_parts` VALUES ('137', '14243');
INSERT INTO `rebase_parts` VALUES ('137', '14244');
INSERT INTO `rebase_parts` VALUES ('137', '14245');
INSERT INTO `rebase_parts` VALUES ('137', '14246');
INSERT INTO `rebase_parts` VALUES ('137', '14247');
INSERT INTO `rebase_parts` VALUES ('137', '14248');

-- ----------------------------
-- Table structure for `rules`
-- ----------------------------
DROP TABLE IF EXISTS `rules`;
CREATE TABLE `rules` (
  `rule_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `grammar_id` int(11) NOT NULL,
  PRIMARY KEY (`rule_id`),
  KEY `FK_rules_categories` (`category_id`),
  KEY `FK_rules_grammars` (`grammar_id`),
  CONSTRAINT `FK_rules_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `FK_rules_grammars` FOREIGN KEY (`grammar_id`) REFERENCES `grammars` (`grammar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of rules
-- ----------------------------
INSERT INTO `rules` VALUES ('335', '1cas', '2316', '1183');
INSERT INTO `rules` VALUES ('336', '2cas', '2316', '1183');
INSERT INTO `rules` VALUES ('337', '3cas', '2316', '1183');
INSERT INTO `rules` VALUES ('338', 'Transcription', '2323', '1183');
INSERT INTO `rules` VALUES ('1012', '1cas', '3262', '1237');
INSERT INTO `rules` VALUES ('1013', '2cas', '3262', '1237');
INSERT INTO `rules` VALUES ('1014', '3cas', '3262', '1237');
INSERT INTO `rules` VALUES ('1015', 'Transcription', '3269', '1237');

-- ----------------------------
-- Table structure for `rule_semantic_action`
-- ----------------------------
DROP TABLE IF EXISTS `rule_semantic_action`;
CREATE TABLE `rule_semantic_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) NOT NULL,
  `action` varchar(10000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of rule_semantic_action
-- ----------------------------

-- ----------------------------
-- Table structure for `rule_transform`
-- ----------------------------
DROP TABLE IF EXISTS `rule_transform`;
CREATE TABLE `rule_transform` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `transform_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rule_transform_categories` (`category_id`),
  KEY `FK_rule_transform_rules` (`rule_id`),
  CONSTRAINT `FK_rule_transform_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `FK_rule_transform_rules` FOREIGN KEY (`rule_id`) REFERENCES `rules` (`rule_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3148 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of rule_transform
-- ----------------------------
INSERT INTO `rule_transform` VALUES ('1174', '335', '2323', '0');
INSERT INTO `rule_transform` VALUES ('1175', '336', '2323', '0');
INSERT INTO `rule_transform` VALUES ('1176', '336', '2323', '1');
INSERT INTO `rule_transform` VALUES ('1177', '337', '2323', '0');
INSERT INTO `rule_transform` VALUES ('1178', '337', '2323', '1');
INSERT INTO `rule_transform` VALUES ('1179', '337', '2323', '2');
INSERT INTO `rule_transform` VALUES ('1180', '338', '2325', '0');
INSERT INTO `rule_transform` VALUES ('1181', '338', '2326', '1');
INSERT INTO `rule_transform` VALUES ('1182', '338', '2327', '2');
INSERT INTO `rule_transform` VALUES ('1183', '338', '2324', '3');
INSERT INTO `rule_transform` VALUES ('3138', '1012', '3269', '0');
INSERT INTO `rule_transform` VALUES ('3139', '1013', '3269', '0');
INSERT INTO `rule_transform` VALUES ('3140', '1013', '3269', '1');
INSERT INTO `rule_transform` VALUES ('3141', '1014', '3269', '0');
INSERT INTO `rule_transform` VALUES ('3142', '1014', '3269', '1');
INSERT INTO `rule_transform` VALUES ('3143', '1014', '3269', '2');
INSERT INTO `rule_transform` VALUES ('3144', '1015', '3271', '0');
INSERT INTO `rule_transform` VALUES ('3145', '1015', '3272', '1');
INSERT INTO `rule_transform` VALUES ('3146', '1015', '3273', '2');
INSERT INTO `rule_transform` VALUES ('3147', '1015', '3270', '3');

-- ----------------------------
-- Table structure for `sessions`
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` char(255) NOT NULL,
  `user_id` int(10) NOT NULL,
  `login_ts` timestamp NULL DEFAULT NULL,
  `last_accessed_ts` timestamp NULL DEFAULT NULL,
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2107 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('1', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:10:50', '2010-05-06 12:24:37', '0');
INSERT INTO `sessions` VALUES ('2', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:24:37', '2010-05-06 12:25:28', '0');
INSERT INTO `sessions` VALUES ('3', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:25:28', '2010-05-06 12:25:35', '0');
INSERT INTO `sessions` VALUES ('4', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:25:35', '2010-05-06 12:25:50', '0');
INSERT INTO `sessions` VALUES ('5', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:25:50', '2010-05-06 12:26:15', '0');
INSERT INTO `sessions` VALUES ('6', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:26:15', '2010-05-06 12:26:30', '0');
INSERT INTO `sessions` VALUES ('7', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:26:30', '2010-05-06 12:26:53', '0');
INSERT INTO `sessions` VALUES ('8', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:26:53', '2010-05-06 12:27:13', '0');
INSERT INTO `sessions` VALUES ('9', '78de5ijvj11qoftdh925s0l8upv42p4l', '80', '2010-05-06 12:27:13', '2010-05-06 12:58:26', '0');
INSERT INTO `sessions` VALUES ('10', '78de5ijvj11qoftdh925s0l8upv42p4l', '98', '2010-05-06 13:13:10', '2010-05-06 13:13:10', '0');
INSERT INTO `sessions` VALUES ('11', '78de5ijvj11qoftdh925s0l8upv42p4l', '98', '2010-05-06 13:13:10', '2010-05-06 13:13:31', '1');
INSERT INTO `sessions` VALUES ('12', 'o6389folm1m7srfqr55bae9igc9mgre3', '86', '2010-05-06 13:54:12', '2010-05-06 13:54:12', '0');
INSERT INTO `sessions` VALUES ('13', 'o6389folm1m7srfqr55bae9igc9mgre3', '86', '2010-05-06 13:54:12', '2010-05-06 13:54:32', '0');
INSERT INTO `sessions` VALUES ('14', 'o6389folm1m7srfqr55bae9igc9mgre3', '86', '2010-05-06 13:54:32', '2010-05-06 13:54:46', '0');
INSERT INTO `sessions` VALUES ('15', 'o6389folm1m7srfqr55bae9igc9mgre3', '86', '2010-05-06 13:54:46', '2010-05-06 13:55:40', '0');
INSERT INTO `sessions` VALUES ('16', 'fll7pvhogt885cefsdac7t8aecldc3iu', '8', '2010-05-10 09:21:09', '2010-05-10 09:21:09', '0');
INSERT INTO `sessions` VALUES ('17', 'fll7pvhogt885cefsdac7t8aecldc3iu', '8', '2010-05-10 09:21:09', '2010-05-10 09:21:43', '1');
INSERT INTO `sessions` VALUES ('18', '9pukdch59dkbojifunv5g3riubvaaqq3', '86', '2010-05-10 09:21:38', '2010-05-10 09:21:38', '0');
INSERT INTO `sessions` VALUES ('19', '9pukdch59dkbojifunv5g3riubvaaqq3', '86', '2010-05-10 09:21:38', '2010-05-10 13:30:44', '1');
INSERT INTO `sessions` VALUES ('20', 'fgoae34c4am8l3fss25jl5mnhdj16uv1', '81', '2010-05-10 17:39:13', '2010-05-10 17:39:13', '0');
INSERT INTO `sessions` VALUES ('21', 'fgoae34c4am8l3fss25jl5mnhdj16uv1', '81', '2010-05-10 17:39:13', '2010-05-10 17:39:20', '0');
INSERT INTO `sessions` VALUES ('22', 'fgoae34c4am8l3fss25jl5mnhdj16uv1', '81', '2010-05-10 17:39:20', '2010-05-10 17:39:20', '0');
INSERT INTO `sessions` VALUES ('23', 'fgoae34c4am8l3fss25jl5mnhdj16uv1', '81', '2010-05-10 17:39:20', '2010-05-10 17:41:20', '0');
INSERT INTO `sessions` VALUES ('24', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:37:53', '2010-05-11 14:37:53', '0');
INSERT INTO `sessions` VALUES ('25', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:37:53', '2010-05-11 14:38:00', '0');
INSERT INTO `sessions` VALUES ('26', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:38:00', '2010-05-11 14:38:47', '0');
INSERT INTO `sessions` VALUES ('27', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:38:47', '2010-05-11 14:42:16', '0');
INSERT INTO `sessions` VALUES ('28', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:42:16', '2010-05-11 14:42:25', '0');
INSERT INTO `sessions` VALUES ('29', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:42:25', '2010-05-11 14:48:09', '0');
INSERT INTO `sessions` VALUES ('30', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:48:09', '2010-05-11 14:48:32', '0');
INSERT INTO `sessions` VALUES ('31', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 14:48:32', '2010-05-11 15:04:13', '0');
INSERT INTO `sessions` VALUES ('32', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:04:13', '2010-05-11 15:04:19', '0');
INSERT INTO `sessions` VALUES ('33', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:04:19', '2010-05-11 15:04:32', '0');
INSERT INTO `sessions` VALUES ('34', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:04:32', '2010-05-11 15:04:52', '0');
INSERT INTO `sessions` VALUES ('35', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:04:52', '2010-05-11 15:06:15', '0');
INSERT INTO `sessions` VALUES ('36', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:06:15', '2010-05-11 15:08:19', '0');
INSERT INTO `sessions` VALUES ('37', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:08:19', '2010-05-11 15:26:32', '0');
INSERT INTO `sessions` VALUES ('38', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:26:32', '2010-05-11 15:43:49', '0');
INSERT INTO `sessions` VALUES ('39', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:43:49', '2010-05-11 15:46:23', '0');
INSERT INTO `sessions` VALUES ('40', 'j2s47013vv8pc05un147q9thangaopn6', '100', '2010-05-11 15:46:23', '2010-05-11 15:46:23', '1');
INSERT INTO `sessions` VALUES ('41', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 10:16:14', '2010-05-12 10:27:24', '0');
INSERT INTO `sessions` VALUES ('42', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 10:27:24', '2010-05-12 10:37:43', '0');
INSERT INTO `sessions` VALUES ('43', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 10:37:43', '2010-05-12 10:54:40', '0');
INSERT INTO `sessions` VALUES ('44', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 10:54:40', '2010-05-12 11:40:01', '0');
INSERT INTO `sessions` VALUES ('45', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 11:40:01', '2010-05-12 11:42:45', '0');
INSERT INTO `sessions` VALUES ('46', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 11:42:45', '2010-05-12 13:36:41', '0');
INSERT INTO `sessions` VALUES ('47', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:36:41', '2010-05-12 13:46:53', '0');
INSERT INTO `sessions` VALUES ('48', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:46:53', '2010-05-12 13:47:01', '0');
INSERT INTO `sessions` VALUES ('49', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:47:01', '2010-05-12 13:47:17', '0');
INSERT INTO `sessions` VALUES ('50', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:47:17', '2010-05-12 13:47:26', '0');
INSERT INTO `sessions` VALUES ('51', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:47:26', '2010-05-12 13:47:30', '0');
INSERT INTO `sessions` VALUES ('52', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:47:30', '2010-05-12 13:49:57', '0');
INSERT INTO `sessions` VALUES ('53', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:49:57', '2010-05-12 13:50:03', '0');
INSERT INTO `sessions` VALUES ('54', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:50:03', '2010-05-12 13:53:05', '0');
INSERT INTO `sessions` VALUES ('55', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 13:53:05', '2010-05-12 14:04:32', '0');
INSERT INTO `sessions` VALUES ('56', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:04:32', '2010-05-12 14:04:49', '0');
INSERT INTO `sessions` VALUES ('57', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:04:49', '2010-05-12 14:04:57', '0');
INSERT INTO `sessions` VALUES ('58', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:04:57', '2010-05-12 14:05:00', '0');
INSERT INTO `sessions` VALUES ('59', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:00', '2010-05-12 14:05:08', '0');
INSERT INTO `sessions` VALUES ('60', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:08', '2010-05-12 14:05:19', '0');
INSERT INTO `sessions` VALUES ('61', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:19', '2010-05-12 14:05:34', '0');
INSERT INTO `sessions` VALUES ('62', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:34', '2010-05-12 14:05:37', '0');
INSERT INTO `sessions` VALUES ('63', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:37', '2010-05-12 14:05:49', '0');
INSERT INTO `sessions` VALUES ('64', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:05:49', '2010-05-12 14:58:14', '0');
INSERT INTO `sessions` VALUES ('65', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 14:58:14', '2010-05-12 15:02:44', '0');
INSERT INTO `sessions` VALUES ('66', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 15:02:44', '2010-05-12 16:03:30', '0');
INSERT INTO `sessions` VALUES ('67', '7v5jtfsiqblff1fnb90pjcccme8pqln4', '100', '2010-05-12 15:50:13', '2010-05-12 15:50:13', '1');
INSERT INTO `sessions` VALUES ('68', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 16:03:30', '2010-05-12 16:04:28', '0');
INSERT INTO `sessions` VALUES ('69', '04fv4ls7279cmdvvb2ptc2ilqsmv9p6f', '100', '2010-05-12 16:04:28', '2010-05-12 16:04:28', '1');
INSERT INTO `sessions` VALUES ('70', 'mf84rj554ensngjljk6ckkic2n30528u', '100', '2010-05-12 21:26:33', '2010-05-12 21:26:33', '1');
INSERT INTO `sessions` VALUES ('71', 'v8lvmlaik580vqnoe3t93483dnokppsq', '100', '2010-05-13 15:58:21', '2010-05-13 15:58:21', '1');
INSERT INTO `sessions` VALUES ('72', '2iadtlqgil7o8i1hlgivc8kqr2dlm5oo', '100', '2010-05-13 19:39:34', '2010-05-13 19:39:34', '1');
INSERT INTO `sessions` VALUES ('73', 'cgv6i6qjpeb3986mlscuvlccsgcrcvr2', '100', '2010-05-13 22:18:42', '2010-05-13 22:18:42', '1');
INSERT INTO `sessions` VALUES ('74', '4nfcqhe2os30giqe51e892hptue33ncc', '80', '2010-05-14 07:13:51', '2010-05-14 07:13:54', '1');
INSERT INTO `sessions` VALUES ('75', 'tctjele2v94jhbcnb45dqu71i29cs1rm', '100', '2010-05-14 08:28:24', '2010-05-14 08:28:24', '1');
INSERT INTO `sessions` VALUES ('76', '6c2hqdoekumnejnm5ppi3daohaqo15gh', '100', '2010-05-14 09:40:05', '2010-05-14 09:40:05', '1');
INSERT INTO `sessions` VALUES ('77', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:07:06', '2010-05-14 10:07:11', '0');
INSERT INTO `sessions` VALUES ('78', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:07:11', '2010-05-14 10:17:44', '0');
INSERT INTO `sessions` VALUES ('79', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:17:44', '2010-05-14 10:18:07', '0');
INSERT INTO `sessions` VALUES ('80', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:18:07', '2010-05-14 10:18:16', '0');
INSERT INTO `sessions` VALUES ('81', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:18:16', '2010-05-14 10:18:28', '0');
INSERT INTO `sessions` VALUES ('82', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:18:28', '2010-05-14 10:18:31', '0');
INSERT INTO `sessions` VALUES ('83', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:18:31', '2010-05-14 10:20:42', '0');
INSERT INTO `sessions` VALUES ('84', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:20:42', '2010-05-14 10:21:07', '0');
INSERT INTO `sessions` VALUES ('85', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:21:07', '2010-05-14 10:21:21', '0');
INSERT INTO `sessions` VALUES ('86', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:21:21', '2010-05-14 10:21:24', '0');
INSERT INTO `sessions` VALUES ('87', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:21:24', '2010-05-14 10:23:20', '0');
INSERT INTO `sessions` VALUES ('88', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:23:20', '2010-05-14 10:23:31', '0');
INSERT INTO `sessions` VALUES ('89', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:23:31', '2010-05-14 10:27:10', '0');
INSERT INTO `sessions` VALUES ('90', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:27:12', '2010-05-14 10:27:12', '0');
INSERT INTO `sessions` VALUES ('91', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:27:12', '2010-05-14 10:33:25', '0');
INSERT INTO `sessions` VALUES ('92', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:45:42', '2010-05-14 10:45:42', '0');
INSERT INTO `sessions` VALUES ('93', 'garjrobhvlmlbt2vugk31vgqs7o2rgua', '100', '2010-05-14 10:45:42', '2010-05-14 11:44:40', '1');
INSERT INTO `sessions` VALUES ('94', 'sj8ntlllblhro95n8l973kafkjo6e66i', '80', '2010-05-14 12:42:05', '2010-05-14 12:42:05', '0');
INSERT INTO `sessions` VALUES ('95', 'sj8ntlllblhro95n8l973kafkjo6e66i', '80', '2010-05-14 12:42:05', '2010-05-14 12:42:10', '0');
INSERT INTO `sessions` VALUES ('96', 'sj8ntlllblhro95n8l973kafkjo6e66i', '80', '2010-05-14 12:42:10', '2010-05-14 12:42:10', '0');
INSERT INTO `sessions` VALUES ('97', 'sj8ntlllblhro95n8l973kafkjo6e66i', '80', '2010-05-14 12:42:10', '2010-05-14 12:48:50', '1');
INSERT INTO `sessions` VALUES ('98', 'so9niihk9n40irmj3u6fouqkii3ick2g', '100', '2010-05-14 13:01:39', '2010-05-14 13:01:39', '1');
INSERT INTO `sessions` VALUES ('99', 'ehs3s3ld52vkqsdhnqiecnocjm7evmvq', '100', '2010-05-14 15:51:48', '2010-05-14 15:51:48', '1');
INSERT INTO `sessions` VALUES ('100', 'ieffpgnh93tj72c5v60ou6fh9h4jq3jc', '101', '2010-05-14 22:45:11', '2010-05-14 22:45:11', '0');
INSERT INTO `sessions` VALUES ('101', 'ieffpgnh93tj72c5v60ou6fh9h4jq3jc', '101', '2010-05-14 22:45:11', '2010-05-14 22:55:49', '0');
INSERT INTO `sessions` VALUES ('102', '6rmdse6r7tim66stem8145452odm3o4u', '100', '2010-05-15 12:27:33', '2010-05-15 12:27:33', '1');
INSERT INTO `sessions` VALUES ('103', 'h950shrr6mn2prckfugq610k8cgt1dtv', '100', '2010-05-15 17:51:09', '2010-05-15 17:51:09', '1');
INSERT INTO `sessions` VALUES ('104', '2lub0heiqh3a15ag9tjkorsltfu7sm7o', '100', '2010-05-15 18:58:55', '2010-05-15 18:58:55', '1');
INSERT INTO `sessions` VALUES ('105', 'qbaqpp4imcsab0nr1bhs8iqcsq5buvhh', '100', '2010-05-15 22:42:38', '2010-05-15 22:42:38', '1');
INSERT INTO `sessions` VALUES ('106', '623ia3kj4pgqr4qopgbl949akpkrbk23', '100', '2010-05-16 10:03:48', '2010-05-16 10:03:48', '1');
INSERT INTO `sessions` VALUES ('107', 'sftoj7dqlm35shectfhp6sfann02icp9', '100', '2010-05-16 15:07:10', '2010-05-16 15:07:10', '1');
INSERT INTO `sessions` VALUES ('108', '669onkqhdmrkl9fc037nffm6g8k2tno6', '100', '2010-05-17 09:54:56', '2010-05-17 09:54:56', '1');
INSERT INTO `sessions` VALUES ('109', 's5083tiqqveqet3gu6ocnl2pbi9csvcd', '100', '2010-05-17 12:06:39', '2010-05-17 12:06:39', '1');
INSERT INTO `sessions` VALUES ('110', '3d593s2tc9t83afvsf8ohnl8frh11voa', '100', '2010-05-17 13:41:21', '2010-05-17 13:41:21', '1');
INSERT INTO `sessions` VALUES ('111', '5ck1t8mk1c5kd4ro6ufjrd1k7vvkrpie', '100', '2010-05-17 15:11:56', '2010-05-17 15:11:56', '1');
INSERT INTO `sessions` VALUES ('112', 'e91if3jna0tljkded4bp6lmdjivvvs4g', '100', '2010-05-17 18:24:00', '2010-05-17 18:24:00', '1');
INSERT INTO `sessions` VALUES ('113', 'h917b38nhtqa5nh3hb16boho6338q3o6', '100', '2010-05-18 09:45:46', '2010-05-18 09:45:46', '1');
INSERT INTO `sessions` VALUES ('114', 'q44ndmdu6cdc9jeiap07pc4upcvps1tl', '100', '2010-05-18 11:24:01', '2010-05-18 11:24:01', '1');
INSERT INTO `sessions` VALUES ('115', 'odpofgvo23acc8gjtkh6vapgn88ns7bl', '100', '2010-05-18 15:47:38', '2010-05-18 15:47:38', '1');
INSERT INTO `sessions` VALUES ('116', 'pvkeo3a9691jii1sbli7obmforaubbii', '100', '2010-05-18 22:36:55', '2010-05-18 22:36:55', '1');
INSERT INTO `sessions` VALUES ('117', 'urti26e0vqsuri9nlnhakd9k289sd62h', '100', '2010-05-19 09:44:29', '2010-05-19 09:44:29', '1');
INSERT INTO `sessions` VALUES ('118', 'fl5to9odd78p5asdh4g0rffc688m3144', '100', '2010-05-19 11:09:54', '2010-05-19 11:09:54', '1');
INSERT INTO `sessions` VALUES ('119', 'ql0acgo7st07695nevmtej06edmtvkpp', '100', '2010-05-19 13:55:02', '2010-05-19 13:55:02', '1');
INSERT INTO `sessions` VALUES ('120', '686mj0ebggh1ctprb4i6l008vcj1ds5k', '100', '2010-05-19 15:38:26', '2010-05-19 15:38:26', '1');
INSERT INTO `sessions` VALUES ('121', '2j2knd2n65judcub4pvug3h6rbgenmf1', '94', '2010-05-19 16:16:26', '2010-05-19 16:16:26', '0');
INSERT INTO `sessions` VALUES ('122', '2j2knd2n65judcub4pvug3h6rbgenmf1', '94', '2010-05-19 16:16:26', '2010-05-19 16:22:36', '1');
INSERT INTO `sessions` VALUES ('123', 'uacpc5l87qrpc2h9dasrfdepr4mspalq', '100', '2010-05-19 19:56:19', '2010-05-19 19:56:19', '1');
INSERT INTO `sessions` VALUES ('124', 'uvnm7cb8527mbkq87nhc69s5f46npoas', '100', '2010-05-19 23:19:58', '2010-05-19 23:19:58', '1');
INSERT INTO `sessions` VALUES ('125', '589mi4sm0e79arsmd86umapqnvvn4qg8', '86', '2010-05-20 09:43:06', '2010-05-20 09:43:06', '0');
INSERT INTO `sessions` VALUES ('126', '589mi4sm0e79arsmd86umapqnvvn4qg8', '86', '2010-05-20 09:43:06', '2010-05-20 09:43:16', '0');
INSERT INTO `sessions` VALUES ('127', '589mi4sm0e79arsmd86umapqnvvn4qg8', '86', '2010-05-20 09:43:16', '2010-05-20 09:43:16', '0');
INSERT INTO `sessions` VALUES ('128', '589mi4sm0e79arsmd86umapqnvvn4qg8', '86', '2010-05-20 09:43:16', '2010-05-20 09:43:22', '0');
INSERT INTO `sessions` VALUES ('129', '589mi4sm0e79arsmd86umapqnvvn4qg8', '86', '2010-05-20 09:43:22', '2010-05-20 09:44:18', '1');
INSERT INTO `sessions` VALUES ('130', 'm6s8f5b922i3vgvn5rg07mrejeejk7v3', '100', '2010-05-20 10:49:12', '2010-05-20 10:49:12', '1');
INSERT INTO `sessions` VALUES ('131', 'n3ld5ogq627decbsoor3s9lf0o7b1od0', '100', '2010-05-20 13:06:07', '2010-05-20 13:06:07', '1');
INSERT INTO `sessions` VALUES ('132', '541diu0b7hgl0tfjac0ubv14m3618v9j', '100', '2010-05-20 14:38:40', '2010-05-20 14:38:40', '1');
INSERT INTO `sessions` VALUES ('133', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 14:55:26', '2010-05-20 14:55:26', '0');
INSERT INTO `sessions` VALUES ('134', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 14:55:26', '2010-05-20 14:55:27', '0');
INSERT INTO `sessions` VALUES ('135', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 14:55:27', '2010-05-20 14:55:27', '0');
INSERT INTO `sessions` VALUES ('136', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 14:55:27', '2010-05-20 15:22:31', '0');
INSERT INTO `sessions` VALUES ('137', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 15:22:31', '2010-05-20 15:23:34', '0');
INSERT INTO `sessions` VALUES ('138', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 15:23:34', '2010-05-20 15:24:38', '0');
INSERT INTO `sessions` VALUES ('139', 'jff9e7pm3hduorovp22h5t9j8ibg4bpc', '100', '2010-05-20 15:24:38', '2010-05-20 15:25:16', '1');
INSERT INTO `sessions` VALUES ('140', 'bueao8n1b0m0494mt33ml8q40f8vda8t', '100', '2010-05-20 20:12:44', '2010-05-20 20:12:44', '1');
INSERT INTO `sessions` VALUES ('141', 'ddf93h9tiubf61fu5vk0g8eljtb3an9m', '100', '2010-05-20 21:35:19', '2010-05-20 21:35:19', '1');
INSERT INTO `sessions` VALUES ('142', '42o02hrjhpv2csn01ea8rev28srfrllb', '100', '2010-05-20 22:36:53', '2010-05-20 22:36:53', '1');
INSERT INTO `sessions` VALUES ('143', '4hnsmsat5t7h4mj43bpgm0chg91ts7e9', '100', '2010-05-20 23:42:38', '2010-05-20 23:42:38', '1');
INSERT INTO `sessions` VALUES ('144', 'vmg3rf0ln0j4d24s29ubuflfi9qivo3m', '100', '2010-05-21 09:40:11', '2010-05-21 09:40:11', '1');
INSERT INTO `sessions` VALUES ('145', 'bkmmkemgtsfi76f8370let293u9u7jeh', '100', '2010-05-21 12:56:13', '2010-05-21 12:56:20', '1');
INSERT INTO `sessions` VALUES ('146', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:50:18', '2010-05-21 13:50:18', '0');
INSERT INTO `sessions` VALUES ('147', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:50:18', '2010-05-21 13:51:06', '0');
INSERT INTO `sessions` VALUES ('148', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:51:06', '2010-05-21 13:52:10', '0');
INSERT INTO `sessions` VALUES ('149', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:52:10', '2010-05-21 13:57:02', '0');
INSERT INTO `sessions` VALUES ('150', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:57:02', '2010-05-21 13:57:26', '0');
INSERT INTO `sessions` VALUES ('151', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:57:26', '2010-05-21 13:58:17', '0');
INSERT INTO `sessions` VALUES ('152', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:58:17', '2010-05-21 13:59:26', '0');
INSERT INTO `sessions` VALUES ('153', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:59:26', '2010-05-21 13:59:31', '0');
INSERT INTO `sessions` VALUES ('154', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 13:59:31', '2010-05-21 14:01:18', '0');
INSERT INTO `sessions` VALUES ('155', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 14:01:18', '2010-05-21 14:01:58', '0');
INSERT INTO `sessions` VALUES ('156', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 14:01:58', '2010-05-21 14:03:02', '0');
INSERT INTO `sessions` VALUES ('157', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 14:03:02', '2010-05-21 14:19:53', '0');
INSERT INTO `sessions` VALUES ('158', '90b6sjprppbbq7u5mc48n9bo362ordut', '100', '2010-05-21 14:19:53', '2010-05-21 14:19:53', '1');
INSERT INTO `sessions` VALUES ('159', 'mqriqn1qlhbraejrhnlbu797ih5rlq8s', '100', '2010-05-21 16:02:15', '2010-05-21 16:02:15', '1');
INSERT INTO `sessions` VALUES ('160', 'l1sv4vq87gp00oqrgom98hnl17r9kntg', '100', '2010-05-21 16:14:01', '2010-05-21 16:14:04', '0');
INSERT INTO `sessions` VALUES ('161', 'l1sv4vq87gp00oqrgom98hnl17r9kntg', '100', '2010-05-21 16:14:04', '2010-05-21 16:14:39', '0');
INSERT INTO `sessions` VALUES ('162', 'l1sv4vq87gp00oqrgom98hnl17r9kntg', '100', '2010-05-21 16:14:39', '2010-05-21 18:26:22', '0');
INSERT INTO `sessions` VALUES ('163', '513oot1fvqhchns533mea843kd68ehmr', '100', '2010-05-21 18:24:14', '2010-05-21 18:24:14', '1');
INSERT INTO `sessions` VALUES ('164', 'l1sv4vq87gp00oqrgom98hnl17r9kntg', '100', '2010-05-21 18:26:22', '2010-05-21 20:15:07', '1');
INSERT INTO `sessions` VALUES ('165', '289oq3e5om356mekr2d7b3emt8hemthv', '100', '2010-05-21 22:46:08', '2010-05-21 22:46:08', '1');
INSERT INTO `sessions` VALUES ('166', '8alaas9bbevoa6solcso7r9323r7903m', '100', '2010-05-23 23:04:03', '2010-05-23 23:04:03', '1');
INSERT INTO `sessions` VALUES ('167', 'bquvgc6pis4imi4bbd5fqth18bn47t21', '100', '2010-05-24 09:18:42', '2010-05-24 09:18:42', '1');
INSERT INTO `sessions` VALUES ('168', 'mnatl9olfq629fpd4n0ocujppov8td99', '100', '2010-05-24 10:40:31', '2010-05-24 10:40:31', '1');
INSERT INTO `sessions` VALUES ('169', '8dks6n54s74rovohmf2kie04gntskiao', '100', '2010-05-24 12:33:35', '2010-05-24 12:33:35', '1');
INSERT INTO `sessions` VALUES ('170', 'hopashnu2sbmm6g2soqm4g3uq69938ui', '100', '2010-05-24 20:54:06', '2010-05-24 20:54:06', '1');
INSERT INTO `sessions` VALUES ('171', 'ckvpt6pnmg1h84m6h6a9oic9nrla2g6l', '100', '2010-05-24 20:57:48', '2010-05-24 20:58:57', '1');
INSERT INTO `sessions` VALUES ('172', 'velsajue4i299kusdlbh7fvgths1s14v', '100', '2010-05-25 08:41:22', '2010-05-25 08:41:22', '1');
INSERT INTO `sessions` VALUES ('173', '4o8hm3v5rqc7fpjqhpaofsjei2jatjr3', '8', '2010-05-25 10:59:44', '2010-05-25 10:59:44', '0');
INSERT INTO `sessions` VALUES ('174', '4o8hm3v5rqc7fpjqhpaofsjei2jatjr3', '8', '2010-05-25 10:59:44', '2010-05-25 10:59:44', '1');
INSERT INTO `sessions` VALUES ('175', 'tqfhq54lrjfprt0nrnm678dcpp7lsbp8', '100', '2010-05-25 11:11:07', '2010-05-25 11:11:07', '1');
INSERT INTO `sessions` VALUES ('176', 'r4isgn7l03t55iln1p0p7398v2n7m87a', '100', '2010-05-25 16:49:54', '2010-05-25 16:49:54', '1');
INSERT INTO `sessions` VALUES ('177', '646dje0r8tv6bkmvha5itqv8mlt8m8o4', '100', '2010-05-25 18:15:25', '2010-05-25 18:15:25', '1');
INSERT INTO `sessions` VALUES ('178', '3u8ace557ho7upoonsh3e2c84s6khvv3', '100', '2010-05-25 20:24:24', '2010-05-25 20:24:24', '1');
INSERT INTO `sessions` VALUES ('179', 'tucj5q7gbnvobv0sa91139dg5qb3rhtf', '100', '2010-05-26 10:06:39', '2010-05-26 10:06:39', '1');
INSERT INTO `sessions` VALUES ('180', 'u56dep96i8rnbfs58q5ef6psa8geki27', '100', '2010-05-26 11:03:53', '2010-05-26 11:04:11', '0');
INSERT INTO `sessions` VALUES ('181', 'u56dep96i8rnbfs58q5ef6psa8geki27', '100', '2010-05-26 11:04:11', '2010-05-26 14:40:41', '1');
INSERT INTO `sessions` VALUES ('182', 'utkqukh7ppjfuhrnr9vavukvtiauvv3g', '100', '2010-05-26 13:41:52', '2010-05-26 13:41:52', '1');
INSERT INTO `sessions` VALUES ('183', 'bfnc29e7qng8f9pgpnbr13ibqeh8772g', '100', '2010-05-26 14:59:16', '2010-05-26 14:59:16', '1');
INSERT INTO `sessions` VALUES ('184', 'a7s80vbrggfneddk91sb38ch8d4mua0n', '100', '2010-05-26 16:05:35', '2010-05-26 16:05:35', '1');
INSERT INTO `sessions` VALUES ('185', 't6eaid4i6554dqed2st1fuiegov1ainf', '100', '2010-05-26 22:17:13', '2010-05-26 22:17:16', '0');
INSERT INTO `sessions` VALUES ('186', 't6eaid4i6554dqed2st1fuiegov1ainf', '100', '2010-05-26 22:17:16', '2010-05-26 22:17:16', '1');
INSERT INTO `sessions` VALUES ('187', 'dkj37991405c6ojtvkrv8b4hjgm17u0t', '100', '2010-05-26 23:37:25', '2010-05-26 23:37:25', '1');
INSERT INTO `sessions` VALUES ('188', 'lf3u3v6mmtfng81m5qg3j231mhtlheqp', '100', '2010-05-27 08:49:58', '2010-05-27 08:49:58', '1');
INSERT INTO `sessions` VALUES ('189', '84bo86l6aoj276j4eqbglg1demtqo1ad', '57', '2010-05-27 09:34:31', '2010-05-27 09:34:31', '0');
INSERT INTO `sessions` VALUES ('190', '84bo86l6aoj276j4eqbglg1demtqo1ad', '57', '2010-05-27 09:34:31', '2010-05-27 09:34:37', '0');
INSERT INTO `sessions` VALUES ('191', '84bo86l6aoj276j4eqbglg1demtqo1ad', '57', '2010-05-27 09:34:49', '2010-05-27 09:34:49', '0');
INSERT INTO `sessions` VALUES ('192', '84bo86l6aoj276j4eqbglg1demtqo1ad', '57', '2010-05-27 09:34:49', '2010-05-27 09:36:36', '0');
INSERT INTO `sessions` VALUES ('193', 'rhncrd0ia0cq6ibtu100d0p184d2jadg', '100', '2010-05-27 10:01:55', '2010-05-27 10:01:55', '1');
INSERT INTO `sessions` VALUES ('194', 'u0c3s30e4101gtd30cu01s2lq477ruag', '100', '2010-05-27 11:09:50', '2010-05-27 11:09:50', '1');
INSERT INTO `sessions` VALUES ('195', 'ho0es32ulqaj0g5bkuj0qen8svt21vv3', '100', '2010-05-27 13:31:05', '2010-05-27 13:31:05', '1');
INSERT INTO `sessions` VALUES ('196', 'jdti72hbcs9vb03eaiglidam5gsmo5p6', '100', '2010-05-27 14:28:12', '2010-05-27 14:28:12', '0');
INSERT INTO `sessions` VALUES ('197', 'jdti72hbcs9vb03eaiglidam5gsmo5p6', '100', '2010-05-27 14:28:12', '2010-05-27 14:28:12', '1');
INSERT INTO `sessions` VALUES ('198', 'vdg9a6sqjuibr22b5q9q3q0p4tfolfk2', '100', '2010-05-27 15:13:04', '2010-05-27 15:13:04', '0');
INSERT INTO `sessions` VALUES ('199', 'vdg9a6sqjuibr22b5q9q3q0p4tfolfk2', '100', '2010-05-27 15:13:04', '2010-05-27 15:13:17', '1');
INSERT INTO `sessions` VALUES ('200', 'qu0a1snrauc9fp9m3g7ug1r71umnv032', '100', '2010-05-27 15:54:31', '2010-05-27 15:54:31', '1');
INSERT INTO `sessions` VALUES ('201', '923j2g53nu52edq2m4948nmiven2c7il', '100', '2010-05-27 16:52:12', '2010-05-27 16:52:20', '1');
INSERT INTO `sessions` VALUES ('202', '1p8e8nng2ua7rlep4ph44v82dj29rugm', '100', '2010-05-27 17:56:30', '2010-05-27 17:56:30', '1');
INSERT INTO `sessions` VALUES ('203', '65be5vg36a5hslpumpu9ajm6q6m7rj2j', '100', '2010-05-27 22:23:46', '2010-05-27 22:23:46', '1');
INSERT INTO `sessions` VALUES ('204', '84ba5f08c6fej4ecbh9a49bqk8m657me', '100', '2010-05-28 08:49:26', '2010-05-28 08:49:26', '1');
INSERT INTO `sessions` VALUES ('205', 'shun4d9q4g3i410govum1o577kaf77t6', '100', '2010-05-28 11:52:16', '2010-05-28 11:52:16', '1');
INSERT INTO `sessions` VALUES ('206', '0laadem3s1pinlol0nb1s379jvr1mnet', '100', '2010-05-28 13:13:57', '2010-05-28 13:13:57', '1');
INSERT INTO `sessions` VALUES ('207', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:54:51', '2010-05-28 14:54:57', '0');
INSERT INTO `sessions` VALUES ('208', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:54:57', '2010-05-28 14:56:37', '0');
INSERT INTO `sessions` VALUES ('209', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:56:37', '2010-05-28 14:57:07', '0');
INSERT INTO `sessions` VALUES ('210', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:57:07', '2010-05-28 14:57:12', '0');
INSERT INTO `sessions` VALUES ('211', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:57:12', '2010-05-28 14:58:07', '0');
INSERT INTO `sessions` VALUES ('212', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-28 14:58:07', '2010-05-29 10:52:51', '0');
INSERT INTO `sessions` VALUES ('213', 'ub84rm567knhs1koqh3bor2qjvc1dtap', '100', '2010-05-28 16:04:50', '2010-05-28 16:04:50', '1');
INSERT INTO `sessions` VALUES ('214', 'pr2pmdcor5o8q0up2ea3cd899kl5kq05', '100', '2010-05-28 17:15:25', '2010-05-28 17:15:25', '1');
INSERT INTO `sessions` VALUES ('215', 't4jm285ta9p9p4knkf0fc11rgfduvnmq', '102', '2010-05-28 21:34:58', '2010-05-28 21:34:58', '0');
INSERT INTO `sessions` VALUES ('216', 't4jm285ta9p9p4knkf0fc11rgfduvnmq', '102', '2010-05-28 21:34:58', '2010-05-28 21:35:02', '0');
INSERT INTO `sessions` VALUES ('217', 't4jm285ta9p9p4knkf0fc11rgfduvnmq', '102', '2010-05-28 21:35:02', '2010-05-28 21:37:23', '1');
INSERT INTO `sessions` VALUES ('218', 'fp9ivjjnllnv7cal81tghr8lg9dcqtdu', '100', '2010-05-29 09:57:22', '2010-05-29 09:57:22', '1');
INSERT INTO `sessions` VALUES ('219', 'adsh4gi85ut8o33t5ceon627cruque8u', '100', '2010-05-29 10:52:51', '2010-05-29 10:52:51', '1');
INSERT INTO `sessions` VALUES ('220', 'u2rn0c8e1boarcrhk1o23d375p592g71', '100', '2010-05-29 11:05:32', '2010-05-29 11:05:32', '1');
INSERT INTO `sessions` VALUES ('221', 'ac42hl2vtg19n2l47rmspbr328ie0sek', '100', '2010-05-29 18:53:50', '2010-05-29 18:53:50', '1');
INSERT INTO `sessions` VALUES ('222', 'ma5hvrm1ojfcjofk408qept3mauvd2lr', '100', '2010-05-29 20:03:10', '2010-05-29 20:03:10', '1');
INSERT INTO `sessions` VALUES ('223', '4kebf8qn5aadme5nal0t7jahb6qcmrt2', '8', '2010-05-30 06:31:25', '2010-05-30 06:31:25', '0');
INSERT INTO `sessions` VALUES ('224', '4kebf8qn5aadme5nal0t7jahb6qcmrt2', '8', '2010-05-30 06:31:25', '2010-05-30 06:31:29', '1');
INSERT INTO `sessions` VALUES ('225', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:01:17', '2010-05-30 08:08:51', '0');
INSERT INTO `sessions` VALUES ('226', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:08:51', '2010-05-30 08:09:11', '0');
INSERT INTO `sessions` VALUES ('227', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:09:11', '2010-05-30 08:20:03', '0');
INSERT INTO `sessions` VALUES ('228', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:20:03', '2010-05-30 08:26:46', '0');
INSERT INTO `sessions` VALUES ('229', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:26:46', '2010-05-30 08:27:18', '0');
INSERT INTO `sessions` VALUES ('230', 'qklljatorpb3imv1acgpptbb5ehfk90d', '102', '2010-05-30 08:27:18', '2010-05-30 08:38:09', '1');
INSERT INTO `sessions` VALUES ('231', 'vnj2bfjtirten75ftuamjdoo6uk0lp1t', '100', '2010-05-30 10:07:03', '2010-05-30 10:07:03', '1');
INSERT INTO `sessions` VALUES ('232', 'cvmtdb4deairnevtpm993gv67nl0n264', '100', '2010-05-30 12:43:31', '2010-05-30 12:43:31', '1');
INSERT INTO `sessions` VALUES ('233', 'bdeenhg9lf7qnvjjdp9ffadnfqbimsbk', '100', '2010-05-31 10:01:14', '2010-05-31 10:01:14', '1');
INSERT INTO `sessions` VALUES ('234', 'g38n2aqcdeh208vvmdosilkhnv6ch0d1', '100', '2010-05-31 19:26:45', '2010-05-31 19:26:45', '1');
INSERT INTO `sessions` VALUES ('235', 'b1hnq0sb95bisqhdq66luu50bmpb3dfc', '80', '2010-05-31 19:37:25', '2010-05-31 19:37:25', '0');
INSERT INTO `sessions` VALUES ('236', 'b1hnq0sb95bisqhdq66luu50bmpb3dfc', '80', '2010-05-31 19:37:25', '2010-05-31 19:37:33', '0');
INSERT INTO `sessions` VALUES ('237', 'b1hnq0sb95bisqhdq66luu50bmpb3dfc', '80', '2010-05-31 19:37:33', '2010-05-31 19:38:09', '0');
INSERT INTO `sessions` VALUES ('238', 'b1hnq0sb95bisqhdq66luu50bmpb3dfc', '80', '2010-05-31 19:38:09', '2010-05-31 19:41:27', '1');
INSERT INTO `sessions` VALUES ('239', 't81ve7eepcsb07kj92to1dem50va2k3d', '100', '2010-05-31 21:33:47', '2010-05-31 21:33:47', '1');
INSERT INTO `sessions` VALUES ('240', 't4fictaotdlpgq9bqij4e70cbvi69kg8', '100', '2010-06-01 08:38:57', '2010-06-01 08:38:57', '1');
INSERT INTO `sessions` VALUES ('241', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:32:11', '2010-06-01 09:32:11', '0');
INSERT INTO `sessions` VALUES ('242', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:32:11', '2010-06-01 09:32:17', '0');
INSERT INTO `sessions` VALUES ('243', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:33:30', '2010-06-01 09:33:30', '0');
INSERT INTO `sessions` VALUES ('244', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:33:30', '2010-06-01 09:44:03', '0');
INSERT INTO `sessions` VALUES ('245', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:44:03', '2010-06-01 09:46:15', '0');
INSERT INTO `sessions` VALUES ('246', 'k7sdc6k5t45uf6ocqspsj458tal0pibj', '80', '2010-06-01 09:46:15', '2010-06-01 10:12:47', '1');
INSERT INTO `sessions` VALUES ('247', '3u14jos7fpgabibaj0tv8hjjibkatsh5', '100', '2010-06-01 10:58:31', '2010-06-01 10:58:31', '1');
INSERT INTO `sessions` VALUES ('248', 'r1at2ee36dal3df7u821rrdd52fqpf3b', '103', '2010-06-01 13:16:31', '2010-06-01 13:16:31', '0');
INSERT INTO `sessions` VALUES ('249', 'r1at2ee36dal3df7u821rrdd52fqpf3b', '103', '2010-06-01 13:16:31', '2010-06-01 13:16:46', '1');
INSERT INTO `sessions` VALUES ('250', 'qf9d5nlldq0d985b50qci8iblge5kqo8', '103', '2010-06-01 13:17:50', '2010-06-01 13:17:50', '0');
INSERT INTO `sessions` VALUES ('251', 'qf9d5nlldq0d985b50qci8iblge5kqo8', '103', '2010-06-01 13:17:50', '2010-06-01 13:17:53', '0');
INSERT INTO `sessions` VALUES ('252', 'qf9d5nlldq0d985b50qci8iblge5kqo8', '103', '2010-06-01 13:17:53', '2010-06-01 13:17:53', '1');
INSERT INTO `sessions` VALUES ('253', 'qhbc0e9shoa0r5031jdd90kkotuh98fr', '100', '2010-06-01 13:54:54', '2010-06-01 13:54:54', '1');
INSERT INTO `sessions` VALUES ('254', '0i2vjuem5651e6df2pb11uqi437d88p6', '100', '2010-06-01 15:08:09', '2010-06-01 15:08:09', '1');
INSERT INTO `sessions` VALUES ('255', 'gfltjtcc7i6bfvtnuuiv8ifhf742vn57', '100', '2010-06-01 19:49:32', '2010-06-01 19:49:32', '1');
INSERT INTO `sessions` VALUES ('256', 'd384om12b229610o0ao8gal5nbvutku5', '100', '2010-06-02 08:22:25', '2010-06-02 08:22:25', '1');
INSERT INTO `sessions` VALUES ('257', 'spivi98cj7g7kcbc0boq46t3f4fejh2g', '100', '2010-06-02 10:19:16', '2010-06-02 10:19:16', '1');
INSERT INTO `sessions` VALUES ('258', 'kjogvgdbjtcnmokerjko9gpklecih1r9', '100', '2010-06-02 11:54:18', '2010-06-02 11:54:18', '1');
INSERT INTO `sessions` VALUES ('259', '6aho7li6hiooklb5cd3hbmsirgtrao03', '100', '2010-06-02 13:01:07', '2010-06-02 13:01:07', '1');
INSERT INTO `sessions` VALUES ('260', 'm5kdk00npben5ev4f8f49n44u09i52ld', '100', '2010-06-02 15:23:02', '2010-06-02 15:23:02', '1');
INSERT INTO `sessions` VALUES ('261', 'fhm2u87mhja9r5vhsu5ijaj0bjttphuo', '100', '2010-06-02 16:37:03', '2010-06-02 16:37:03', '1');
INSERT INTO `sessions` VALUES ('262', '88nqh0vsjbdsk16scpbuas03gmnsf19a', '100', '2010-06-02 19:02:52', '2010-06-02 19:02:52', '1');
INSERT INTO `sessions` VALUES ('263', 'otf4c8cl4q692qnfv0s0gvrrnepngubd', '100', '2010-06-02 21:04:27', '2010-06-02 21:04:27', '1');
INSERT INTO `sessions` VALUES ('264', 'bbghsn225ifjhfn5657mdp5hatnlp8rb', '100', '2010-06-03 09:21:07', '2010-06-03 09:21:07', '1');
INSERT INTO `sessions` VALUES ('265', 'ohhrk0uj299hiv8gr9acuoor2bgaqhdc', '100', '2010-06-03 14:37:39', '2010-06-03 14:37:39', '1');
INSERT INTO `sessions` VALUES ('266', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '57', '2010-06-03 14:47:56', '2010-06-03 14:58:05', '0');
INSERT INTO `sessions` VALUES ('267', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '57', '2010-06-03 14:58:05', '2010-06-03 14:59:01', '0');
INSERT INTO `sessions` VALUES ('268', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '57', '2010-06-03 14:59:01', '2010-06-03 15:28:41', '0');
INSERT INTO `sessions` VALUES ('269', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:22:04', '2010-06-03 15:22:04', '0');
INSERT INTO `sessions` VALUES ('270', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:22:04', '2010-06-03 15:22:10', '0');
INSERT INTO `sessions` VALUES ('271', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:22:26', '2010-06-03 15:22:26', '0');
INSERT INTO `sessions` VALUES ('272', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:22:26', '2010-06-03 15:24:04', '0');
INSERT INTO `sessions` VALUES ('273', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:24:04', '2010-06-03 15:24:26', '0');
INSERT INTO `sessions` VALUES ('274', 'ggh47e942ptde0m8gmb8s6c30r2r4s86', '86', '2010-06-03 15:24:26', '2010-06-03 16:13:58', '1');
INSERT INTO `sessions` VALUES ('275', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '57', '2010-06-03 15:28:41', '2010-06-03 15:36:21', '0');
INSERT INTO `sessions` VALUES ('276', 'bmkbiuor4butumaatl7jqkr04fkmebsb', '104', '2010-06-03 15:41:04', '2010-06-03 15:41:04', '0');
INSERT INTO `sessions` VALUES ('277', 'bmkbiuor4butumaatl7jqkr04fkmebsb', '104', '2010-06-03 15:41:04', '2010-06-03 15:41:35', '0');
INSERT INTO `sessions` VALUES ('278', 'qvksn197u9dtlk5krn30sflki8610apf', '106', '2010-06-03 15:41:16', '2010-06-03 15:41:16', '0');
INSERT INTO `sessions` VALUES ('279', 'qvksn197u9dtlk5krn30sflki8610apf', '106', '2010-06-03 15:41:16', '2010-06-03 15:41:37', '0');
INSERT INTO `sessions` VALUES ('280', 'bmkbiuor4butumaatl7jqkr04fkmebsb', '104', '2010-06-03 15:41:35', '2010-06-03 15:42:16', '0');
INSERT INTO `sessions` VALUES ('281', 'qvksn197u9dtlk5krn30sflki8610apf', '106', '2010-06-03 15:41:37', '2010-06-03 15:44:57', '0');
INSERT INTO `sessions` VALUES ('282', 'bmkbiuor4butumaatl7jqkr04fkmebsb', '104', '2010-06-03 15:42:16', '2010-06-03 15:42:18', '1');
INSERT INTO `sessions` VALUES ('283', '5cmdbpev1qvlkgai8i4pi5ijcgmk917b', '105', '2010-06-03 15:43:00', '2010-06-03 15:43:00', '0');
INSERT INTO `sessions` VALUES ('284', '5cmdbpev1qvlkgai8i4pi5ijcgmk917b', '105', '2010-06-03 15:43:00', '2010-06-03 15:43:04', '0');
INSERT INTO `sessions` VALUES ('285', '5cmdbpev1qvlkgai8i4pi5ijcgmk917b', '107', '2010-06-03 15:43:09', '2010-06-03 15:43:09', '0');
INSERT INTO `sessions` VALUES ('286', '5cmdbpev1qvlkgai8i4pi5ijcgmk917b', '107', '2010-06-03 15:43:09', '2010-06-03 15:43:14', '0');
INSERT INTO `sessions` VALUES ('287', '94190ddmbo8qpup3ti67f2bqgp0j7egb', '100', '2010-06-03 15:44:03', '2010-06-03 15:44:03', '1');
INSERT INTO `sessions` VALUES ('288', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:55:58', '2010-06-03 15:55:58', '0');
INSERT INTO `sessions` VALUES ('289', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:55:58', '2010-06-03 15:56:03', '0');
INSERT INTO `sessions` VALUES ('290', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:56:03', '2010-06-03 15:56:50', '0');
INSERT INTO `sessions` VALUES ('291', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:56:50', '2010-06-03 15:58:34', '0');
INSERT INTO `sessions` VALUES ('292', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:58:34', '2010-06-03 15:59:15', '0');
INSERT INTO `sessions` VALUES ('293', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:59:15', '2010-06-03 15:59:50', '0');
INSERT INTO `sessions` VALUES ('294', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 15:59:50', '2010-06-03 16:02:57', '0');
INSERT INTO `sessions` VALUES ('295', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 16:02:57', '2010-06-03 16:03:15', '0');
INSERT INTO `sessions` VALUES ('296', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 16:03:15', '2010-06-03 16:03:19', '0');
INSERT INTO `sessions` VALUES ('297', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 16:03:19', '2010-06-03 16:03:41', '0');
INSERT INTO `sessions` VALUES ('298', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 16:03:41', '2010-06-03 16:03:46', '0');
INSERT INTO `sessions` VALUES ('299', '5derc46nlafok4doq9r2tv2mlctourgh', '113', '2010-06-03 16:03:46', '2010-06-03 16:04:46', '1');
INSERT INTO `sessions` VALUES ('300', '969n92or19tgn2fn27fqahnbc8ahvl0c', '100', '2010-06-03 18:26:39', '2010-06-03 18:26:39', '1');
INSERT INTO `sessions` VALUES ('301', 'ikda82puff2e9vnn6ege66v86mj8vmrm', '100', '2010-06-03 19:31:57', '2010-06-03 19:31:57', '1');
INSERT INTO `sessions` VALUES ('302', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '108', '2010-06-03 20:19:49', '2010-06-03 20:19:49', '0');
INSERT INTO `sessions` VALUES ('303', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '108', '2010-06-03 20:19:49', '2010-06-03 20:19:49', '0');
INSERT INTO `sessions` VALUES ('304', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:21:09', '2010-06-03 20:21:09', '0');
INSERT INTO `sessions` VALUES ('305', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:21:09', '2010-06-03 20:21:52', '0');
INSERT INTO `sessions` VALUES ('306', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:21:52', '2010-06-03 20:22:23', '0');
INSERT INTO `sessions` VALUES ('307', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:22:23', '2010-06-03 20:22:45', '0');
INSERT INTO `sessions` VALUES ('308', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:22:45', '2010-06-03 20:22:58', '0');
INSERT INTO `sessions` VALUES ('309', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:22:58', '2010-06-03 20:23:04', '0');
INSERT INTO `sessions` VALUES ('310', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:29:14', '2010-06-03 20:29:51', '0');
INSERT INTO `sessions` VALUES ('311', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:29:45', '2010-06-03 20:29:45', '0');
INSERT INTO `sessions` VALUES ('312', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:29:45', '2010-06-03 20:30:24', '0');
INSERT INTO `sessions` VALUES ('313', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:29:51', '2010-06-03 20:30:23', '0');
INSERT INTO `sessions` VALUES ('314', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:30:23', '2010-06-03 20:30:26', '0');
INSERT INTO `sessions` VALUES ('315', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '113', '2010-06-03 20:30:24', '2010-06-03 20:30:26', '0');
INSERT INTO `sessions` VALUES ('316', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:30:26', '2010-06-03 20:30:28', '0');
INSERT INTO `sessions` VALUES ('317', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:30:28', '2010-06-03 20:31:22', '0');
INSERT INTO `sessions` VALUES ('318', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:31:22', '2010-06-03 20:35:44', '0');
INSERT INTO `sessions` VALUES ('319', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:35:44', '2010-06-03 20:37:16', '0');
INSERT INTO `sessions` VALUES ('320', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:37:16', '2010-06-03 20:39:50', '0');
INSERT INTO `sessions` VALUES ('321', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:39:50', '2010-06-03 20:52:31', '0');
INSERT INTO `sessions` VALUES ('322', '6ar0b4imkvbdai1eins9j80h9bf6430i', '114', '2010-06-03 20:49:49', '2010-06-03 20:49:59', '0');
INSERT INTO `sessions` VALUES ('323', '6ar0b4imkvbdai1eins9j80h9bf6430i', '114', '2010-06-03 20:49:59', '2010-06-03 20:56:39', '0');
INSERT INTO `sessions` VALUES ('324', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:52:31', '2010-06-03 20:53:32', '0');
INSERT INTO `sessions` VALUES ('325', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:53:32', '2010-06-03 20:57:12', '0');
INSERT INTO `sessions` VALUES ('326', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '57', '2010-06-03 20:54:29', '2010-06-03 20:54:29', '0');
INSERT INTO `sessions` VALUES ('327', '6ar0b4imkvbdai1eins9j80h9bf6430i', '114', '2010-06-03 20:56:39', '2010-06-03 20:56:39', '1');
INSERT INTO `sessions` VALUES ('328', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 20:57:12', '2010-06-03 21:00:43', '0');
INSERT INTO `sessions` VALUES ('329', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 21:00:43', '2010-06-03 21:00:49', '0');
INSERT INTO `sessions` VALUES ('330', '8ifvvpfi0fll1flqe1t93977fhe38sua', '113', '2010-06-03 21:00:49', '2010-06-03 21:16:00', '1');
INSERT INTO `sessions` VALUES ('331', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '115', '2010-06-03 21:07:45', '2010-06-03 21:07:45', '0');
INSERT INTO `sessions` VALUES ('332', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '115', '2010-06-03 21:07:45', '2010-06-03 21:07:50', '0');
INSERT INTO `sessions` VALUES ('333', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '115', '2010-06-03 21:07:50', '2010-06-03 21:08:45', '0');
INSERT INTO `sessions` VALUES ('334', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '115', '2010-06-03 21:08:57', '2010-06-03 21:08:57', '0');
INSERT INTO `sessions` VALUES ('335', 'hpmis9dbvhr9vbm50s6d2knesscvka0k', '115', '2010-06-03 21:08:57', '2010-06-03 21:09:02', '0');
INSERT INTO `sessions` VALUES ('336', 'a4v2nica3mk31tuk9nlc7gqu2g52j7t4', '115', '2010-06-03 21:09:08', '2010-06-04 00:32:56', '1');
INSERT INTO `sessions` VALUES ('337', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:09:23', '2010-06-03 21:09:23', '0');
INSERT INTO `sessions` VALUES ('338', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:09:23', '2010-06-03 21:24:57', '0');
INSERT INTO `sessions` VALUES ('339', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:09:28', '2010-06-03 21:09:28', '0');
INSERT INTO `sessions` VALUES ('340', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:09:28', '2010-06-03 21:10:27', '0');
INSERT INTO `sessions` VALUES ('341', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:10:27', '2010-06-03 21:10:38', '0');
INSERT INTO `sessions` VALUES ('342', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:10:38', '2010-06-03 21:10:56', '0');
INSERT INTO `sessions` VALUES ('343', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:10:56', '2010-06-03 21:11:27', '0');
INSERT INTO `sessions` VALUES ('344', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:11:27', '2010-06-03 21:15:43', '0');
INSERT INTO `sessions` VALUES ('345', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:15:43', '2010-06-03 21:16:25', '0');
INSERT INTO `sessions` VALUES ('346', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:16:25', '2010-06-03 21:17:15', '0');
INSERT INTO `sessions` VALUES ('347', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:17:15', '2010-06-03 21:25:32', '0');
INSERT INTO `sessions` VALUES ('348', '9m7fpjmvuf84pqjdfe3b63kfm456rnu6', '115', '2010-06-03 21:22:30', '2010-06-03 21:22:30', '0');
INSERT INTO `sessions` VALUES ('349', '9m7fpjmvuf84pqjdfe3b63kfm456rnu6', '115', '2010-06-03 21:22:30', '2010-06-03 21:23:29', '0');
INSERT INTO `sessions` VALUES ('350', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:24:57', '2010-06-03 21:41:32', '0');
INSERT INTO `sessions` VALUES ('351', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:25:32', '2010-06-03 21:25:43', '0');
INSERT INTO `sessions` VALUES ('352', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:25:43', '2010-06-03 21:25:57', '0');
INSERT INTO `sessions` VALUES ('353', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:25:57', '2010-06-03 21:26:18', '0');
INSERT INTO `sessions` VALUES ('354', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:26:18', '2010-06-03 21:31:43', '0');
INSERT INTO `sessions` VALUES ('355', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:31:43', '2010-06-03 21:31:48', '0');
INSERT INTO `sessions` VALUES ('356', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:31:48', '2010-06-03 21:34:44', '0');
INSERT INTO `sessions` VALUES ('357', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:34:44', '2010-06-03 21:34:48', '0');
INSERT INTO `sessions` VALUES ('358', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:34:48', '2010-06-03 21:37:26', '0');
INSERT INTO `sessions` VALUES ('359', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:37:26', '2010-06-03 21:38:15', '0');
INSERT INTO `sessions` VALUES ('360', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:38:15', '2010-06-03 21:38:58', '0');
INSERT INTO `sessions` VALUES ('361', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:38:58', '2010-06-03 21:39:59', '0');
INSERT INTO `sessions` VALUES ('362', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:39:59', '2010-06-03 21:42:29', '0');
INSERT INTO `sessions` VALUES ('363', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:41:32', '2010-06-03 21:43:35', '0');
INSERT INTO `sessions` VALUES ('364', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:42:29', '2010-06-03 21:48:20', '0');
INSERT INTO `sessions` VALUES ('365', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:43:35', '2010-06-03 21:45:46', '0');
INSERT INTO `sessions` VALUES ('366', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:45:46', '2010-06-03 21:49:33', '0');
INSERT INTO `sessions` VALUES ('367', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:48:20', '2010-06-03 21:54:18', '0');
INSERT INTO `sessions` VALUES ('368', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:49:33', '2010-06-03 21:50:10', '0');
INSERT INTO `sessions` VALUES ('369', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:50:10', '2010-06-03 21:58:07', '0');
INSERT INTO `sessions` VALUES ('370', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:54:18', '2010-06-03 21:55:07', '0');
INSERT INTO `sessions` VALUES ('371', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:55:07', '2010-06-03 21:58:09', '0');
INSERT INTO `sessions` VALUES ('372', 'ajsbtoc9blh2jehq8pudfvnr5hi1kng8', '115', '2010-06-03 21:58:07', '2010-06-03 21:58:07', '1');
INSERT INTO `sessions` VALUES ('373', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:58:09', '2010-06-03 21:58:32', '0');
INSERT INTO `sessions` VALUES ('374', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 21:58:32', '2010-06-03 22:02:44', '0');
INSERT INTO `sessions` VALUES ('375', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 22:02:44', '2010-06-03 22:02:50', '0');
INSERT INTO `sessions` VALUES ('376', '89a9anvbeif1l3j4ohmmgn3p4mqnqrse', '115', '2010-06-03 22:02:50', '2010-06-03 22:02:50', '1');
INSERT INTO `sessions` VALUES ('377', 'g0f6avgbcqbnv54l58d9k56p2902eobr', '100', '2010-06-04 07:46:56', '2010-06-04 07:46:56', '1');
INSERT INTO `sessions` VALUES ('378', 'vq8ka71gnh9ol7b2vifb490902dlt26v', '115', '2010-06-04 12:58:47', '2010-06-04 12:58:47', '0');
INSERT INTO `sessions` VALUES ('379', 'vq8ka71gnh9ol7b2vifb490902dlt26v', '115', '2010-06-04 12:58:47', '2010-06-04 12:58:50', '1');
INSERT INTO `sessions` VALUES ('380', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:01:16', '2010-06-04 13:01:16', '0');
INSERT INTO `sessions` VALUES ('381', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:01:16', '2010-06-04 13:01:24', '0');
INSERT INTO `sessions` VALUES ('382', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:01:24', '2010-06-04 13:01:31', '0');
INSERT INTO `sessions` VALUES ('383', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:01:57', '2010-06-04 13:01:57', '0');
INSERT INTO `sessions` VALUES ('384', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:01:57', '2010-06-04 13:02:43', '0');
INSERT INTO `sessions` VALUES ('385', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:02:43', '2010-06-04 13:03:16', '0');
INSERT INTO `sessions` VALUES ('386', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:03:16', '2010-06-04 13:03:19', '0');
INSERT INTO `sessions` VALUES ('387', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:03:19', '2010-06-04 13:03:40', '0');
INSERT INTO `sessions` VALUES ('388', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:03:40', '2010-06-04 13:04:23', '0');
INSERT INTO `sessions` VALUES ('389', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:04:23', '2010-06-04 13:07:01', '0');
INSERT INTO `sessions` VALUES ('390', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:07:01', '2010-06-04 13:09:45', '0');
INSERT INTO `sessions` VALUES ('391', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:09:45', '2010-06-04 13:09:54', '0');
INSERT INTO `sessions` VALUES ('392', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:09:54', '2010-06-04 13:12:34', '0');
INSERT INTO `sessions` VALUES ('393', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:12:34', '2010-06-04 13:13:15', '0');
INSERT INTO `sessions` VALUES ('394', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:13:15', '2010-06-04 13:14:26', '0');
INSERT INTO `sessions` VALUES ('395', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:14:26', '2010-06-04 13:14:41', '0');
INSERT INTO `sessions` VALUES ('396', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:14:41', '2010-06-04 13:14:58', '0');
INSERT INTO `sessions` VALUES ('397', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:14:58', '2010-06-04 13:15:50', '0');
INSERT INTO `sessions` VALUES ('398', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:15:50', '2010-06-04 13:16:00', '0');
INSERT INTO `sessions` VALUES ('399', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:16:00', '2010-06-04 13:16:05', '0');
INSERT INTO `sessions` VALUES ('400', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:16:05', '2010-06-04 13:16:28', '0');
INSERT INTO `sessions` VALUES ('401', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:16:28', '2010-06-04 13:18:55', '0');
INSERT INTO `sessions` VALUES ('402', 'bnf7vubkkgtbb5gnt55j4o6oq5grkc82', '115', '2010-06-04 13:18:55', '2010-06-04 13:18:55', '1');
INSERT INTO `sessions` VALUES ('403', 'u05s9vpsmu3m3ipf3sj9uuqtjd6hsnj3', '100', '2010-06-04 17:48:03', '2010-06-04 17:48:03', '1');
INSERT INTO `sessions` VALUES ('404', 'dtrt7ludhfim5idgs8tvoqbdajfi1bbg', '100', '2010-06-04 19:15:16', '2010-06-04 19:15:16', '1');
INSERT INTO `sessions` VALUES ('405', 'iboc36593lba8755mpcaflpc2a8t7apb', '100', '2010-06-04 21:31:36', '2010-06-04 21:31:36', '1');
INSERT INTO `sessions` VALUES ('406', '52n86690n8415t3d5rvf4ja2gbh7cmp9', '100', '2010-06-05 09:06:03', '2010-06-05 09:06:03', '1');
INSERT INTO `sessions` VALUES ('407', 'nrcbktceehv94veibdsetl4ri3q6fp50', '114', '2010-06-05 15:34:40', '2010-06-05 15:34:40', '0');
INSERT INTO `sessions` VALUES ('408', 'nrcbktceehv94veibdsetl4ri3q6fp50', '114', '2010-06-05 15:34:40', '2010-06-05 15:35:42', '0');
INSERT INTO `sessions` VALUES ('409', 'nrcbktceehv94veibdsetl4ri3q6fp50', '114', '2010-06-05 15:35:42', '2010-06-05 16:24:24', '1');
INSERT INTO `sessions` VALUES ('410', 'ldf0vgl16aitaiu0pnq1kelc597q428i', '100', '2010-06-05 18:22:03', '2010-06-05 18:22:03', '1');
INSERT INTO `sessions` VALUES ('411', 'a9eae7p4a0cp12enlnqa5u8cqmp3flq3', '100', '2010-06-06 09:32:19', '2010-06-06 09:32:19', '1');
INSERT INTO `sessions` VALUES ('412', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 10:55:54', '2010-06-06 10:55:54', '0');
INSERT INTO `sessions` VALUES ('413', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 10:55:54', '2010-06-06 10:57:30', '0');
INSERT INTO `sessions` VALUES ('414', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 10:57:38', '2010-06-06 10:57:38', '0');
INSERT INTO `sessions` VALUES ('415', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 10:57:38', '2010-06-06 11:01:04', '0');
INSERT INTO `sessions` VALUES ('416', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:01:04', '2010-06-06 11:01:44', '0');
INSERT INTO `sessions` VALUES ('417', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:01:44', '2010-06-06 11:02:06', '0');
INSERT INTO `sessions` VALUES ('418', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 11:02:49', '2010-06-06 11:02:49', '0');
INSERT INTO `sessions` VALUES ('419', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 11:02:49', '2010-06-06 11:04:15', '0');
INSERT INTO `sessions` VALUES ('420', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 11:04:15', '2010-06-06 11:05:04', '0');
INSERT INTO `sessions` VALUES ('421', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '115', '2010-06-06 11:05:04', '2010-06-06 11:05:28', '0');
INSERT INTO `sessions` VALUES ('422', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:05:31', '2010-06-06 11:05:31', '0');
INSERT INTO `sessions` VALUES ('423', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:05:31', '2010-06-06 11:05:40', '0');
INSERT INTO `sessions` VALUES ('424', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:05:40', '2010-06-06 11:06:49', '0');
INSERT INTO `sessions` VALUES ('425', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:06:49', '2010-06-06 11:07:03', '0');
INSERT INTO `sessions` VALUES ('426', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:07:03', '2010-06-06 11:07:32', '0');
INSERT INTO `sessions` VALUES ('427', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:07:32', '2010-06-06 11:08:05', '0');
INSERT INTO `sessions` VALUES ('428', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:08:05', '2010-06-06 11:08:36', '0');
INSERT INTO `sessions` VALUES ('429', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:08:36', '2010-06-06 11:10:07', '0');
INSERT INTO `sessions` VALUES ('430', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:10:07', '2010-06-06 11:11:01', '0');
INSERT INTO `sessions` VALUES ('431', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:11:01', '2010-06-06 11:12:04', '0');
INSERT INTO `sessions` VALUES ('432', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:12:24', '2010-06-06 11:12:24', '0');
INSERT INTO `sessions` VALUES ('433', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 11:12:24', '2010-06-06 14:03:19', '0');
INSERT INTO `sessions` VALUES ('434', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 14:03:19', '2010-06-06 14:04:02', '0');
INSERT INTO `sessions` VALUES ('435', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 14:04:02', '2010-06-06 14:06:24', '0');
INSERT INTO `sessions` VALUES ('436', 'dm2c2hk81pora12fo21rr2huk4bmh6mk', '114', '2010-06-06 14:06:24', '2010-06-06 14:14:31', '1');
INSERT INTO `sessions` VALUES ('437', 'q31hv3ju1g54sfb06ertgnuqq56okb17', '100', '2010-06-07 07:27:20', '2010-06-07 07:27:20', '1');
INSERT INTO `sessions` VALUES ('438', 'pnnjnpha6t9m8n848ci7l0082d1nf5r1', '100', '2010-06-07 09:30:27', '2010-06-07 09:30:27', '1');
INSERT INTO `sessions` VALUES ('439', 'auo0dijdevljq1c69bhj6baig1ookec8', '100', '2010-06-07 10:32:52', '2010-06-07 10:32:52', '1');
INSERT INTO `sessions` VALUES ('440', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '108', '2010-06-07 10:51:40', '2010-06-07 10:51:40', '0');
INSERT INTO `sessions` VALUES ('441', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '108', '2010-06-07 10:51:40', '2010-06-07 10:52:56', '1');
INSERT INTO `sessions` VALUES ('442', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 10:52:56', '2010-06-07 10:52:56', '0');
INSERT INTO `sessions` VALUES ('443', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 10:52:56', '2010-06-07 11:27:19', '0');
INSERT INTO `sessions` VALUES ('444', '7kmqetnaq8u3svivs8ma0flilgi68p9g', '113', '2010-06-07 10:58:49', '2010-06-07 10:58:49', '0');
INSERT INTO `sessions` VALUES ('445', '7kmqetnaq8u3svivs8ma0flilgi68p9g', '113', '2010-06-07 10:58:49', '2010-06-07 10:59:36', '1');
INSERT INTO `sessions` VALUES ('446', '7kmqetnaq8u3svivs8ma0flilgi68p9g', '115', '2010-06-07 10:59:36', '2010-06-07 11:47:35', '1');
INSERT INTO `sessions` VALUES ('447', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:01:37', '2010-06-07 11:01:37', '0');
INSERT INTO `sessions` VALUES ('448', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:01:37', '2010-06-07 11:01:46', '0');
INSERT INTO `sessions` VALUES ('449', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:01:46', '2010-06-07 11:01:46', '0');
INSERT INTO `sessions` VALUES ('450', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:01:46', '2010-06-07 11:26:31', '0');
INSERT INTO `sessions` VALUES ('451', '6676capitr2fmot4ruk6c68ir2b7afnv', '115', '2010-06-07 11:08:18', '2010-06-07 11:08:18', '0');
INSERT INTO `sessions` VALUES ('452', '6676capitr2fmot4ruk6c68ir2b7afnv', '115', '2010-06-07 11:08:18', '2010-06-07 11:08:28', '0');
INSERT INTO `sessions` VALUES ('453', '6676capitr2fmot4ruk6c68ir2b7afnv', '115', '2010-06-07 11:08:28', '2010-06-07 11:08:38', '1');
INSERT INTO `sessions` VALUES ('454', '8orqlfovi1fao4l3nsrsntph1fbup8ok', '115', '2010-06-07 11:15:38', '2010-06-07 11:30:14', '0');
INSERT INTO `sessions` VALUES ('455', '6vnhgmuhdbe5mgkd9939oo7irt4769eu', '115', '2010-06-07 11:16:47', '2010-06-07 11:16:53', '1');
INSERT INTO `sessions` VALUES ('456', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:26:31', '2010-06-07 11:28:27', '0');
INSERT INTO `sessions` VALUES ('457', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 11:27:19', '2010-06-07 11:28:20', '0');
INSERT INTO `sessions` VALUES ('458', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 11:28:20', '2010-06-07 11:28:54', '0');
INSERT INTO `sessions` VALUES ('459', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 11:28:54', '2010-06-07 15:36:48', '0');
INSERT INTO `sessions` VALUES ('460', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:29:17', '2010-06-07 11:29:17', '0');
INSERT INTO `sessions` VALUES ('461', '780oitn4e9v0q32jh3c88en3fcd7ndb4', '8', '2010-06-07 11:29:17', '2010-06-07 11:42:58', '1');
INSERT INTO `sessions` VALUES ('462', '8orqlfovi1fao4l3nsrsntph1fbup8ok', '115', '2010-06-07 11:30:14', '2010-06-07 11:34:02', '0');
INSERT INTO `sessions` VALUES ('463', '8orqlfovi1fao4l3nsrsntph1fbup8ok', '115', '2010-06-07 11:34:02', '2010-06-07 11:34:10', '1');
INSERT INTO `sessions` VALUES ('464', '0ab95vb177tlb0rf9vt0udcvf0s3al05', '115', '2010-06-07 11:41:18', '2010-06-07 11:41:18', '0');
INSERT INTO `sessions` VALUES ('465', '0ab95vb177tlb0rf9vt0udcvf0s3al05', '115', '2010-06-07 11:41:18', '2010-06-07 11:44:56', '1');
INSERT INTO `sessions` VALUES ('466', '2nosvl18gf50i73meabq0nimtd903vbu', '100', '2010-06-07 11:42:14', '2010-06-07 11:42:14', '1');
INSERT INTO `sessions` VALUES ('467', '0cti1j9fs62cu3hl0ir99t59v5bgkrus', '115', '2010-06-07 11:45:01', '2010-06-07 11:45:01', '0');
INSERT INTO `sessions` VALUES ('468', '0cti1j9fs62cu3hl0ir99t59v5bgkrus', '115', '2010-06-07 11:45:01', '2010-06-07 11:48:08', '1');
INSERT INTO `sessions` VALUES ('469', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-07 15:36:48', '2010-06-08 13:54:19', '0');
INSERT INTO `sessions` VALUES ('470', 'q0c8suticcpn45f2p0n7u2dvjr1oso8g', '100', '2010-06-07 15:41:13', '2010-06-07 15:41:13', '1');
INSERT INTO `sessions` VALUES ('471', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '114', '2010-06-07 15:49:43', '2010-06-07 15:49:43', '0');
INSERT INTO `sessions` VALUES ('472', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '114', '2010-06-07 15:49:43', '2010-06-07 15:51:11', '1');
INSERT INTO `sessions` VALUES ('473', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:51:11', '2010-06-07 15:51:11', '0');
INSERT INTO `sessions` VALUES ('474', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:51:11', '2010-06-07 15:52:58', '0');
INSERT INTO `sessions` VALUES ('475', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:52:58', '2010-06-07 15:53:00', '0');
INSERT INTO `sessions` VALUES ('476', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:53:00', '2010-06-07 15:53:00', '0');
INSERT INTO `sessions` VALUES ('477', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:53:00', '2010-06-07 15:54:43', '0');
INSERT INTO `sessions` VALUES ('478', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:54:43', '2010-06-07 15:54:46', '0');
INSERT INTO `sessions` VALUES ('479', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:54:46', '2010-06-07 15:54:46', '0');
INSERT INTO `sessions` VALUES ('480', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-07 15:54:46', '2010-06-08 13:41:40', '0');
INSERT INTO `sessions` VALUES ('481', 'd9ci7jc5d4ltnfn7anhnj8jsijt576ih', '100', '2010-06-07 18:31:02', '2010-06-07 18:31:02', '1');
INSERT INTO `sessions` VALUES ('482', '1rmjs8hf1vje72voflm88pgfhh015f5g', '100', '2010-06-07 19:45:20', '2010-06-07 19:45:20', '1');
INSERT INTO `sessions` VALUES ('483', '2sgjeunpotth76gt6l72poeo09vkhn2i', '115', '2010-06-07 20:12:59', '2010-06-07 21:16:58', '0');
INSERT INTO `sessions` VALUES ('484', '2sgjeunpotth76gt6l72poeo09vkhn2i', '115', '2010-06-07 21:16:58', '2010-06-07 21:16:58', '1');
INSERT INTO `sessions` VALUES ('485', 'gv77lae0c3df6fo0j7v2baj97g3odi55', '100', '2010-06-08 08:38:07', '2010-06-08 08:38:07', '1');
INSERT INTO `sessions` VALUES ('486', 'cqgaq566codgepah2nm857bec5git9b8', '100', '2010-06-08 11:11:54', '2010-06-08 11:11:54', '1');
INSERT INTO `sessions` VALUES ('487', 're4vskia9288rheim5g4ledvbgd1oda8', '100', '2010-06-08 11:47:03', '2010-06-08 11:47:03', '1');
INSERT INTO `sessions` VALUES ('488', 'qoshdi21dm9blitrlaevcsrlbvff83l4', '115', '2010-06-08 13:28:59', '2010-06-08 13:29:00', '1');
INSERT INTO `sessions` VALUES ('489', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 13:41:40', '2010-06-08 13:41:43', '0');
INSERT INTO `sessions` VALUES ('490', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 13:41:43', '2010-06-08 13:41:43', '0');
INSERT INTO `sessions` VALUES ('491', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 13:41:43', '2010-06-08 13:41:55', '0');
INSERT INTO `sessions` VALUES ('492', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 13:41:55', '2010-06-08 14:50:09', '0');
INSERT INTO `sessions` VALUES ('493', 'kgpcbj83ojsinkbrkhd71ngp96fkv8dl', '100', '2010-06-08 13:44:14', '2010-06-08 13:44:14', '1');
INSERT INTO `sessions` VALUES ('494', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:54:19', '2010-06-08 13:54:22', '0');
INSERT INTO `sessions` VALUES ('495', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:54:22', '2010-06-08 13:55:27', '0');
INSERT INTO `sessions` VALUES ('496', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:55:27', '2010-06-08 13:55:51', '0');
INSERT INTO `sessions` VALUES ('497', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:55:51', '2010-06-08 13:57:44', '0');
INSERT INTO `sessions` VALUES ('498', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:57:44', '2010-06-08 13:57:57', '0');
INSERT INTO `sessions` VALUES ('499', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:57:57', '2010-06-08 13:58:40', '0');
INSERT INTO `sessions` VALUES ('500', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:58:40', '2010-06-08 13:59:08', '0');
INSERT INTO `sessions` VALUES ('501', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 13:59:08', '2010-06-08 14:00:05', '0');
INSERT INTO `sessions` VALUES ('502', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:00:05', '2010-06-08 14:10:13', '0');
INSERT INTO `sessions` VALUES ('503', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:10:13', '2010-06-08 14:10:15', '0');
INSERT INTO `sessions` VALUES ('504', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:10:15', '2010-06-08 14:11:40', '0');
INSERT INTO `sessions` VALUES ('505', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:11:40', '2010-06-08 14:11:57', '0');
INSERT INTO `sessions` VALUES ('506', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:11:57', '2010-06-08 14:12:02', '0');
INSERT INTO `sessions` VALUES ('507', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:12:02', '2010-06-08 14:12:23', '0');
INSERT INTO `sessions` VALUES ('508', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:12:23', '2010-06-08 14:13:57', '0');
INSERT INTO `sessions` VALUES ('509', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:13:58', '2010-06-08 14:21:04', '0');
INSERT INTO `sessions` VALUES ('510', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:21:04', '2010-06-08 14:33:40', '0');
INSERT INTO `sessions` VALUES ('511', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:33:40', '2010-06-08 14:42:32', '0');
INSERT INTO `sessions` VALUES ('512', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:42:32', '2010-06-08 14:48:21', '0');
INSERT INTO `sessions` VALUES ('513', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 14:48:21', '2010-06-08 15:23:39', '0');
INSERT INTO `sessions` VALUES ('514', 'ncp6crspe8pok6eis0l3fpo8kud80olh', '115', '2010-06-08 14:49:47', '2010-06-08 14:49:47', '0');
INSERT INTO `sessions` VALUES ('515', 'ncp6crspe8pok6eis0l3fpo8kud80olh', '115', '2010-06-08 14:49:47', '2010-06-08 14:49:59', '0');
INSERT INTO `sessions` VALUES ('516', 'ncp6crspe8pok6eis0l3fpo8kud80olh', '115', '2010-06-08 14:49:59', '2010-06-08 14:49:59', '0');
INSERT INTO `sessions` VALUES ('517', 'ncp6crspe8pok6eis0l3fpo8kud80olh', '115', '2010-06-08 14:49:59', '2010-06-08 14:50:19', '1');
INSERT INTO `sessions` VALUES ('518', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 14:50:09', '2010-06-08 14:50:11', '0');
INSERT INTO `sessions` VALUES ('519', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 14:50:11', '2010-06-08 14:50:11', '0');
INSERT INTO `sessions` VALUES ('520', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 14:50:11', '2010-06-08 15:59:45', '0');
INSERT INTO `sessions` VALUES ('521', 'gn4tf7o9sd3juv6janm1k0ofuha12ri0', '100', '2010-06-08 15:09:46', '2010-06-08 15:09:46', '1');
INSERT INTO `sessions` VALUES ('522', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 15:23:39', '2010-06-08 16:00:32', '0');
INSERT INTO `sessions` VALUES ('523', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 15:59:45', '2010-06-08 15:59:47', '0');
INSERT INTO `sessions` VALUES ('524', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 15:59:47', '2010-06-08 15:59:47', '0');
INSERT INTO `sessions` VALUES ('525', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 15:59:47', '2010-06-08 16:09:19', '0');
INSERT INTO `sessions` VALUES ('526', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 16:00:32', '2010-06-08 16:38:16', '0');
INSERT INTO `sessions` VALUES ('527', 'tr7psge5npejr6eu58odaq0f94gd1m2n', '115', '2010-06-08 16:09:19', '2010-06-08 16:09:19', '1');
INSERT INTO `sessions` VALUES ('528', '4ju247lond06djl21upqmh9krh06ckk1', '100', '2010-06-08 16:22:54', '2010-06-08 16:22:54', '1');
INSERT INTO `sessions` VALUES ('529', '585vgskg4usco88lrk54mtu8505uverk', '115', '2010-06-08 16:30:40', '2010-06-08 16:30:40', '0');
INSERT INTO `sessions` VALUES ('530', '585vgskg4usco88lrk54mtu8505uverk', '115', '2010-06-08 16:30:40', '2010-06-08 16:31:09', '1');
INSERT INTO `sessions` VALUES ('531', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-08 16:38:16', '2010-06-09 11:06:17', '0');
INSERT INTO `sessions` VALUES ('532', '3lf37cpki9bj5oodvqt8k7bqsc9poc04', '115', '2010-06-08 17:53:46', '2010-06-08 17:53:46', '0');
INSERT INTO `sessions` VALUES ('533', '3lf37cpki9bj5oodvqt8k7bqsc9poc04', '115', '2010-06-08 17:53:46', '2010-06-08 17:53:46', '1');
INSERT INTO `sessions` VALUES ('534', 'b5i25bdcqu49ne8a3un7qhsqpo0kalcm', '100', '2010-06-08 18:00:23', '2010-06-08 18:00:23', '1');
INSERT INTO `sessions` VALUES ('535', 'hb52te4rh8vg3978v6uc7hldtrrnr366', '100', '2010-06-09 07:13:05', '2010-06-09 07:13:05', '1');
INSERT INTO `sessions` VALUES ('536', 'uc4rveckhdt7ri17t8k1rl9jo233m9a7', '100', '2010-06-09 08:23:33', '2010-06-09 08:23:33', '1');
INSERT INTO `sessions` VALUES ('537', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-09 11:06:17', '2010-06-09 11:06:41', '0');
INSERT INTO `sessions` VALUES ('538', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-09 11:06:41', '2010-06-09 11:06:41', '0');
INSERT INTO `sessions` VALUES ('539', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-09 11:06:41', '2010-06-09 11:07:09', '0');
INSERT INTO `sessions` VALUES ('540', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-09 11:07:09', '2010-06-09 11:16:37', '0');
INSERT INTO `sessions` VALUES ('541', 'nnnv6109jsdbcj3drsvv6va379kbjrge', '115', '2010-06-09 11:16:37', '2010-06-09 11:16:37', '1');
INSERT INTO `sessions` VALUES ('542', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:15:27', '2010-06-09 13:15:27', '0');
INSERT INTO `sessions` VALUES ('543', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:15:27', '2010-06-09 13:15:42', '0');
INSERT INTO `sessions` VALUES ('544', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:15:42', '2010-06-09 13:15:42', '0');
INSERT INTO `sessions` VALUES ('545', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:15:42', '2010-06-09 13:16:17', '0');
INSERT INTO `sessions` VALUES ('546', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:16:17', '2010-06-09 13:16:52', '0');
INSERT INTO `sessions` VALUES ('547', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:16:52', '2010-06-09 13:34:10', '0');
INSERT INTO `sessions` VALUES ('548', '252sk66jumg26dip2c3uij4vb5katsdq', '115', '2010-06-09 13:17:40', '2010-06-09 13:17:40', '1');
INSERT INTO `sessions` VALUES ('549', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:34:10', '2010-06-09 13:34:16', '0');
INSERT INTO `sessions` VALUES ('550', 'fpp9k5fjlissrmrksbtgf89dkjkgmr7n', '115', '2010-06-09 13:34:16', '2010-06-09 13:34:16', '1');
INSERT INTO `sessions` VALUES ('551', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:40:39', '2010-06-09 13:40:39', '0');
INSERT INTO `sessions` VALUES ('552', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:40:39', '2010-06-09 13:41:20', '0');
INSERT INTO `sessions` VALUES ('553', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:41:16', '2010-06-09 13:41:16', '0');
INSERT INTO `sessions` VALUES ('554', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:41:16', '2010-06-09 13:41:19', '0');
INSERT INTO `sessions` VALUES ('555', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:41:19', '2010-06-09 13:41:19', '0');
INSERT INTO `sessions` VALUES ('556', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:41:19', '2010-06-09 13:41:38', '0');
INSERT INTO `sessions` VALUES ('557', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:41:20', '2010-06-09 13:45:52', '0');
INSERT INTO `sessions` VALUES ('558', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:41:38', '2010-06-09 13:42:41', '0');
INSERT INTO `sessions` VALUES ('559', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:42:41', '2010-06-09 13:42:59', '0');
INSERT INTO `sessions` VALUES ('560', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:42:59', '2010-06-09 13:43:18', '0');
INSERT INTO `sessions` VALUES ('561', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:43:18', '2010-06-09 13:46:38', '0');
INSERT INTO `sessions` VALUES ('562', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:45:52', '2010-06-09 13:48:24', '0');
INSERT INTO `sessions` VALUES ('563', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 13:46:38', '2010-06-09 14:11:08', '0');
INSERT INTO `sessions` VALUES ('564', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:48:24', '2010-06-09 13:50:09', '0');
INSERT INTO `sessions` VALUES ('565', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:50:09', '2010-06-09 13:50:24', '0');
INSERT INTO `sessions` VALUES ('566', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:50:24', '2010-06-09 13:50:39', '0');
INSERT INTO `sessions` VALUES ('567', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:50:39', '2010-06-09 13:53:34', '0');
INSERT INTO `sessions` VALUES ('568', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 13:51:26', '2010-06-09 13:51:26', '0');
INSERT INTO `sessions` VALUES ('569', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 13:51:26', '2010-06-09 14:49:40', '0');
INSERT INTO `sessions` VALUES ('570', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:53:34', '2010-06-09 13:54:31', '0');
INSERT INTO `sessions` VALUES ('571', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:54:31', '2010-06-09 13:55:07', '0');
INSERT INTO `sessions` VALUES ('572', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:55:07', '2010-06-09 13:55:11', '0');
INSERT INTO `sessions` VALUES ('573', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:55:11', '2010-06-09 13:55:46', '0');
INSERT INTO `sessions` VALUES ('574', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:55:46', '2010-06-09 13:56:04', '0');
INSERT INTO `sessions` VALUES ('575', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:56:04', '2010-06-09 13:56:11', '0');
INSERT INTO `sessions` VALUES ('576', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:56:11', '2010-06-09 13:58:33', '0');
INSERT INTO `sessions` VALUES ('577', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:58:33', '2010-06-09 13:59:07', '0');
INSERT INTO `sessions` VALUES ('578', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:59:07', '2010-06-09 13:59:31', '0');
INSERT INTO `sessions` VALUES ('579', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:59:31', '2010-06-09 13:59:35', '0');
INSERT INTO `sessions` VALUES ('580', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 13:59:35', '2010-06-09 14:00:01', '0');
INSERT INTO `sessions` VALUES ('581', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:00:01', '2010-06-09 14:00:06', '0');
INSERT INTO `sessions` VALUES ('582', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:00:06', '2010-06-09 14:02:59', '0');
INSERT INTO `sessions` VALUES ('583', 'qefa2fld12qr78tpv7g6nlep6k3naub0', '100', '2010-06-09 14:00:29', '2010-06-09 14:00:29', '1');
INSERT INTO `sessions` VALUES ('584', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:02:59', '2010-06-09 14:03:21', '0');
INSERT INTO `sessions` VALUES ('585', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:03:21', '2010-06-09 14:03:27', '0');
INSERT INTO `sessions` VALUES ('586', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:03:27', '2010-06-09 14:05:14', '0');
INSERT INTO `sessions` VALUES ('587', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-09 14:05:14', '2010-06-09 14:53:29', '0');
INSERT INTO `sessions` VALUES ('588', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 14:11:08', '2010-06-09 14:11:11', '0');
INSERT INTO `sessions` VALUES ('589', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 14:11:11', '2010-06-09 14:11:11', '0');
INSERT INTO `sessions` VALUES ('590', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-09 14:11:11', '2010-06-09 14:11:16', '0');
INSERT INTO `sessions` VALUES ('591', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 14:49:40', '2010-06-09 14:49:57', '0');
INSERT INTO `sessions` VALUES ('592', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 14:49:57', '2010-06-09 14:59:36', '0');
INSERT INTO `sessions` VALUES ('593', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 14:59:36', '2010-06-09 14:59:46', '0');
INSERT INTO `sessions` VALUES ('594', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 14:59:46', '2010-06-09 15:00:09', '0');
INSERT INTO `sessions` VALUES ('595', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 15:00:09', '2010-06-09 15:00:18', '0');
INSERT INTO `sessions` VALUES ('596', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 15:00:18', '2010-06-09 15:02:27', '0');
INSERT INTO `sessions` VALUES ('597', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 15:02:27', '2010-06-09 16:09:24', '0');
INSERT INTO `sessions` VALUES ('598', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 15:43:42', '2010-06-09 15:43:42', '0');
INSERT INTO `sessions` VALUES ('599', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 15:43:42', '2010-06-09 15:51:43', '0');
INSERT INTO `sessions` VALUES ('600', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 15:51:43', '2010-06-09 16:02:40', '0');
INSERT INTO `sessions` VALUES ('601', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 15:53:06', '2010-06-09 15:53:17', '0');
INSERT INTO `sessions` VALUES ('602', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 15:53:17', '2010-06-09 15:53:17', '0');
INSERT INTO `sessions` VALUES ('603', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 15:53:17', '2010-06-09 16:00:59', '0');
INSERT INTO `sessions` VALUES ('604', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 16:00:59', '2010-06-09 16:17:27', '0');
INSERT INTO `sessions` VALUES ('605', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:02:40', '2010-06-09 16:09:17', '0');
INSERT INTO `sessions` VALUES ('606', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:09:17', '2010-06-09 16:09:43', '0');
INSERT INTO `sessions` VALUES ('607', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:09:24', '2010-06-09 16:09:33', '0');
INSERT INTO `sessions` VALUES ('608', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:09:40', '2010-06-09 16:09:40', '0');
INSERT INTO `sessions` VALUES ('609', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:09:40', '2010-06-09 16:13:32', '0');
INSERT INTO `sessions` VALUES ('610', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:09:43', '2010-06-09 16:20:45', '0');
INSERT INTO `sessions` VALUES ('611', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:13:32', '2010-06-09 16:28:14', '0');
INSERT INTO `sessions` VALUES ('612', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 16:17:27', '2010-06-09 16:22:01', '0');
INSERT INTO `sessions` VALUES ('613', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:20:45', '2010-06-09 16:24:48', '0');
INSERT INTO `sessions` VALUES ('614', 'rn6f8vc1rjvdqvdk9rb40ed8dug93vgs', '115', '2010-06-09 16:22:01', '2010-06-09 16:23:01', '1');
INSERT INTO `sessions` VALUES ('615', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:24:48', '2010-06-09 16:26:34', '0');
INSERT INTO `sessions` VALUES ('616', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:26:34', '2010-06-09 16:28:51', '0');
INSERT INTO `sessions` VALUES ('617', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:28:14', '2010-06-09 16:28:29', '0');
INSERT INTO `sessions` VALUES ('618', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:28:29', '2010-06-09 16:28:34', '0');
INSERT INTO `sessions` VALUES ('619', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-09 16:28:34', '2010-06-09 16:28:34', '0');
INSERT INTO `sessions` VALUES ('620', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:28:51', '2010-06-09 16:31:20', '0');
INSERT INTO `sessions` VALUES ('621', '20v77jt77gnnja94nmf7ihvl8mfp5o9f', '115', '2010-06-09 16:31:20', '2010-06-09 16:34:03', '1');
INSERT INTO `sessions` VALUES ('622', 'hjsfg42n7r4n07l8ujgbfacib4ldg5cm', '115', '2010-06-11 09:20:27', '2010-06-11 09:20:27', '0');
INSERT INTO `sessions` VALUES ('623', 'hjsfg42n7r4n07l8ujgbfacib4ldg5cm', '115', '2010-06-11 09:20:27', '2010-06-11 09:20:50', '0');
INSERT INTO `sessions` VALUES ('624', 'hjsfg42n7r4n07l8ujgbfacib4ldg5cm', '115', '2010-06-11 09:20:50', '2010-06-11 10:33:31', '1');
INSERT INTO `sessions` VALUES ('625', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-11 09:20:59', '2010-06-11 09:20:59', '0');
INSERT INTO `sessions` VALUES ('626', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-11 09:20:59', '2010-06-11 09:32:18', '0');
INSERT INTO `sessions` VALUES ('627', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-11 09:32:18', '2010-06-11 09:32:18', '0');
INSERT INTO `sessions` VALUES ('628', 'c2ddl43vpi6729lp0kefnm19clfutjrc', '115', '2010-06-11 09:32:18', '2010-06-11 09:33:40', '1');
INSERT INTO `sessions` VALUES ('629', 'u5s1hosrok26h8p8ljp6c7e9o4aarhr6', '115', '2010-06-11 16:23:15', '2010-06-11 16:23:15', '0');
INSERT INTO `sessions` VALUES ('630', 'u5s1hosrok26h8p8ljp6c7e9o4aarhr6', '115', '2010-06-11 16:23:15', '2010-06-11 16:23:27', '0');
INSERT INTO `sessions` VALUES ('631', 'u5s1hosrok26h8p8ljp6c7e9o4aarhr6', '115', '2010-06-11 16:23:27', '2010-06-11 16:59:04', '1');
INSERT INTO `sessions` VALUES ('632', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:06', '2010-06-11 16:24:06', '0');
INSERT INTO `sessions` VALUES ('633', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:07', '2010-06-11 16:24:19', '0');
INSERT INTO `sessions` VALUES ('634', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:19', '2010-06-11 16:24:19', '0');
INSERT INTO `sessions` VALUES ('635', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:19', '2010-06-11 16:24:34', '0');
INSERT INTO `sessions` VALUES ('636', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:34', '2010-06-11 16:24:49', '0');
INSERT INTO `sessions` VALUES ('637', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:24:49', '2010-06-11 16:58:55', '0');
INSERT INTO `sessions` VALUES ('638', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 16:58:55', '2010-06-11 17:01:18', '0');
INSERT INTO `sessions` VALUES ('639', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-11 17:01:18', '2010-06-11 17:01:50', '0');
INSERT INTO `sessions` VALUES ('640', '6779itf0pr5c2b54h2bqbi4nnor8sasb', '115', '2010-06-14 09:13:11', '2010-06-14 09:13:11', '0');
INSERT INTO `sessions` VALUES ('641', '6779itf0pr5c2b54h2bqbi4nnor8sasb', '115', '2010-06-14 09:13:11', '2010-06-14 09:13:18', '0');
INSERT INTO `sessions` VALUES ('642', '6779itf0pr5c2b54h2bqbi4nnor8sasb', '115', '2010-06-14 09:13:25', '2010-06-14 09:13:25', '0');
INSERT INTO `sessions` VALUES ('643', '6779itf0pr5c2b54h2bqbi4nnor8sasb', '115', '2010-06-14 09:13:25', '2010-06-14 09:13:25', '1');
INSERT INTO `sessions` VALUES ('644', '9bj6kd6tb2a50l5bp4i47t3pvfe2eqf4', '80', '2010-06-14 09:20:15', '2010-06-14 09:20:15', '0');
INSERT INTO `sessions` VALUES ('645', '9bj6kd6tb2a50l5bp4i47t3pvfe2eqf4', '80', '2010-06-14 09:20:15', '2010-06-14 11:54:06', '1');
INSERT INTO `sessions` VALUES ('646', 'd6ugenaqm157htsvftaikm4hq53cn5nu', '115', '2010-06-14 10:36:01', '2010-06-14 10:36:01', '0');
INSERT INTO `sessions` VALUES ('647', 'd6ugenaqm157htsvftaikm4hq53cn5nu', '115', '2010-06-14 10:36:01', '2010-06-14 10:36:03', '0');
INSERT INTO `sessions` VALUES ('648', 'd6ugenaqm157htsvftaikm4hq53cn5nu', '115', '2010-06-14 10:36:03', '2010-06-14 10:36:03', '0');
INSERT INTO `sessions` VALUES ('649', 'd6ugenaqm157htsvftaikm4hq53cn5nu', '115', '2010-06-14 10:36:03', '2010-06-14 11:09:26', '1');
INSERT INTO `sessions` VALUES ('650', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-14 10:50:28', '2010-06-14 10:50:28', '0');
INSERT INTO `sessions` VALUES ('651', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-14 10:50:28', '2010-06-14 10:50:43', '0');
INSERT INTO `sessions` VALUES ('652', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-14 10:50:43', '2010-06-14 10:50:43', '0');
INSERT INTO `sessions` VALUES ('653', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-14 10:50:43', '2010-06-15 09:50:12', '0');
INSERT INTO `sessions` VALUES ('654', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:30:31', '2010-06-14 11:30:31', '0');
INSERT INTO `sessions` VALUES ('655', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:30:31', '2010-06-14 11:30:33', '0');
INSERT INTO `sessions` VALUES ('656', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:30:33', '2010-06-14 11:30:33', '0');
INSERT INTO `sessions` VALUES ('657', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:30:33', '2010-06-14 11:42:12', '0');
INSERT INTO `sessions` VALUES ('658', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:42:12', '2010-06-14 11:44:40', '0');
INSERT INTO `sessions` VALUES ('659', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:44:40', '2010-06-14 11:45:30', '0');
INSERT INTO `sessions` VALUES ('660', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:45:30', '2010-06-14 11:46:05', '0');
INSERT INTO `sessions` VALUES ('661', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 11:46:05', '2010-06-14 13:01:18', '0');
INSERT INTO `sessions` VALUES ('662', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 13:01:18', '2010-06-14 13:01:20', '0');
INSERT INTO `sessions` VALUES ('663', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 13:01:20', '2010-06-14 13:01:20', '0');
INSERT INTO `sessions` VALUES ('664', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 13:01:20', '2010-06-14 15:44:56', '0');
INSERT INTO `sessions` VALUES ('665', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 15:44:56', '2010-06-14 15:44:58', '0');
INSERT INTO `sessions` VALUES ('666', 'olg7566au6pvv98ogfjbaoi91c4l00m9', '115', '2010-06-14 15:44:57', '2010-06-14 15:44:57', '0');
INSERT INTO `sessions` VALUES ('667', 'olg7566au6pvv98ogfjbaoi91c4l00m9', '115', '2010-06-14 15:44:57', '2010-06-14 15:44:59', '0');
INSERT INTO `sessions` VALUES ('668', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 15:44:58', '2010-06-14 15:44:58', '0');
INSERT INTO `sessions` VALUES ('669', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 15:44:58', '2010-06-14 16:04:58', '0');
INSERT INTO `sessions` VALUES ('670', 'olg7566au6pvv98ogfjbaoi91c4l00m9', '115', '2010-06-14 15:44:59', '2010-06-14 15:44:59', '0');
INSERT INTO `sessions` VALUES ('671', 'olg7566au6pvv98ogfjbaoi91c4l00m9', '115', '2010-06-14 15:44:59', '2010-06-14 15:48:42', '0');
INSERT INTO `sessions` VALUES ('672', 'olg7566au6pvv98ogfjbaoi91c4l00m9', '115', '2010-06-14 15:48:42', '2010-06-14 16:10:48', '1');
INSERT INTO `sessions` VALUES ('673', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 16:04:58', '2010-06-14 16:05:08', '0');
INSERT INTO `sessions` VALUES ('674', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 16:05:08', '2010-06-14 16:05:08', '0');
INSERT INTO `sessions` VALUES ('675', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 16:05:08', '2010-06-14 16:11:11', '0');
INSERT INTO `sessions` VALUES ('676', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-14 16:11:11', '2010-06-15 10:00:50', '0');
INSERT INTO `sessions` VALUES ('677', 'uuhc7896gdbpntudb6h15f5ljsq78ueq', '115', '2010-06-14 16:39:52', '2010-06-14 16:39:54', '1');
INSERT INTO `sessions` VALUES ('678', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:31:01', '2010-06-14 22:31:01', '0');
INSERT INTO `sessions` VALUES ('679', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:31:01', '2010-06-14 22:31:22', '0');
INSERT INTO `sessions` VALUES ('680', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:31:52', '2010-06-14 22:31:52', '0');
INSERT INTO `sessions` VALUES ('681', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:31:52', '2010-06-14 22:35:09', '0');
INSERT INTO `sessions` VALUES ('682', 'm3f39j1dd57tjqpk8569lhn3kd31omik', '115', '2010-06-14 22:33:12', '2010-06-14 22:33:21', '0');
INSERT INTO `sessions` VALUES ('683', 'm3f39j1dd57tjqpk8569lhn3kd31omik', '115', '2010-06-14 22:33:21', '2010-06-14 22:34:07', '0');
INSERT INTO `sessions` VALUES ('684', 'm3f39j1dd57tjqpk8569lhn3kd31omik', '115', '2010-06-14 22:34:07', '2010-06-16 13:39:34', '0');
INSERT INTO `sessions` VALUES ('685', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:35:09', '2010-06-14 22:35:16', '0');
INSERT INTO `sessions` VALUES ('686', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:35:16', '2010-06-14 22:35:32', '0');
INSERT INTO `sessions` VALUES ('687', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:35:32', '2010-06-14 22:36:59', '0');
INSERT INTO `sessions` VALUES ('688', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:36:59', '2010-06-14 22:37:09', '0');
INSERT INTO `sessions` VALUES ('689', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:37:09', '2010-06-14 22:37:16', '0');
INSERT INTO `sessions` VALUES ('690', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:37:16', '2010-06-14 22:41:15', '0');
INSERT INTO `sessions` VALUES ('691', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:41:15', '2010-06-14 22:45:10', '0');
INSERT INTO `sessions` VALUES ('692', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:45:10', '2010-06-14 22:49:39', '0');
INSERT INTO `sessions` VALUES ('693', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:49:39', '2010-06-14 22:52:00', '0');
INSERT INTO `sessions` VALUES ('694', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:52:00', '2010-06-14 22:53:55', '0');
INSERT INTO `sessions` VALUES ('695', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:53:55', '2010-06-14 22:53:58', '0');
INSERT INTO `sessions` VALUES ('696', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:53:58', '2010-06-14 22:54:05', '0');
INSERT INTO `sessions` VALUES ('697', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:54:05', '2010-06-14 22:54:18', '0');
INSERT INTO `sessions` VALUES ('698', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:54:18', '2010-06-14 22:54:23', '0');
INSERT INTO `sessions` VALUES ('699', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:54:23', '2010-06-14 22:54:52', '0');
INSERT INTO `sessions` VALUES ('700', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:54:52', '2010-06-14 22:55:25', '0');
INSERT INTO `sessions` VALUES ('701', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:55:25', '2010-06-14 22:55:59', '0');
INSERT INTO `sessions` VALUES ('702', 'fqjnghatra4dg05a85i9pvl0plj246pn', '115', '2010-06-14 22:55:59', '2010-06-14 22:55:59', '1');
INSERT INTO `sessions` VALUES ('703', '46lh8k359f3gu0tu1cpl516484s84nmi', '115', '2010-06-15 09:14:43', '2010-06-15 09:14:43', '0');
INSERT INTO `sessions` VALUES ('704', '46lh8k359f3gu0tu1cpl516484s84nmi', '115', '2010-06-15 09:14:43', '2010-06-15 09:14:57', '0');
INSERT INTO `sessions` VALUES ('705', '46lh8k359f3gu0tu1cpl516484s84nmi', '115', '2010-06-15 09:14:57', '2010-06-15 09:14:57', '0');
INSERT INTO `sessions` VALUES ('706', '46lh8k359f3gu0tu1cpl516484s84nmi', '115', '2010-06-15 09:14:57', '2010-06-15 09:49:59', '1');
INSERT INTO `sessions` VALUES ('707', '30oseor52ljf06chihjlj6m0mvd3ilu1', '80', '2010-06-15 09:39:58', '2010-06-15 09:39:58', '0');
INSERT INTO `sessions` VALUES ('708', '30oseor52ljf06chihjlj6m0mvd3ilu1', '80', '2010-06-15 09:39:58', '2010-06-15 09:44:00', '1');
INSERT INTO `sessions` VALUES ('709', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 09:50:12', '2010-06-15 09:50:22', '0');
INSERT INTO `sessions` VALUES ('710', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 09:50:22', '2010-06-15 09:50:22', '0');
INSERT INTO `sessions` VALUES ('711', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 09:50:22', '2010-06-15 10:17:20', '0');
INSERT INTO `sessions` VALUES ('712', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:00:50', '2010-06-15 10:00:52', '0');
INSERT INTO `sessions` VALUES ('713', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:00:52', '2010-06-15 10:00:52', '0');
INSERT INTO `sessions` VALUES ('714', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:00:52', '2010-06-15 10:13:09', '0');
INSERT INTO `sessions` VALUES ('715', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:13:09', '2010-06-15 10:14:14', '0');
INSERT INTO `sessions` VALUES ('716', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:14:14', '2010-06-15 10:15:29', '0');
INSERT INTO `sessions` VALUES ('717', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:15:29', '2010-06-15 10:16:56', '0');
INSERT INTO `sessions` VALUES ('718', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-15 10:16:56', '2010-06-16 11:01:25', '0');
INSERT INTO `sessions` VALUES ('719', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 10:17:20', '2010-06-15 10:17:29', '0');
INSERT INTO `sessions` VALUES ('720', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 10:17:29', '2010-06-15 10:17:29', '0');
INSERT INTO `sessions` VALUES ('721', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 10:17:29', '2010-06-15 10:48:45', '0');
INSERT INTO `sessions` VALUES ('722', 'ntuu21o8a77so6ncsfr8to7c592b1reg', '8', '2010-06-15 10:45:50', '2010-06-15 10:45:50', '0');
INSERT INTO `sessions` VALUES ('723', 'ntuu21o8a77so6ncsfr8to7c592b1reg', '8', '2010-06-15 10:45:50', '2010-06-15 10:45:58', '0');
INSERT INTO `sessions` VALUES ('724', 'ntuu21o8a77so6ncsfr8to7c592b1reg', '8', '2010-06-15 10:45:58', '2010-06-15 10:45:58', '0');
INSERT INTO `sessions` VALUES ('725', 'ntuu21o8a77so6ncsfr8to7c592b1reg', '8', '2010-06-15 10:45:58', '2010-06-15 14:52:34', '0');
INSERT INTO `sessions` VALUES ('726', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 10:48:45', '2010-06-15 10:50:20', '0');
INSERT INTO `sessions` VALUES ('727', '9n7t26kblj8vm5v7voku1ajsnk80ai0u', '115', '2010-06-15 10:50:20', '2010-06-15 11:28:41', '1');
INSERT INTO `sessions` VALUES ('728', 'fo0v7g2unk6n08skml7pmqoctm9otntv', '115', '2010-06-15 12:47:41', '2010-06-15 12:47:41', '0');
INSERT INTO `sessions` VALUES ('729', 'fo0v7g2unk6n08skml7pmqoctm9otntv', '115', '2010-06-15 12:47:41', '2010-06-15 12:47:43', '0');
INSERT INTO `sessions` VALUES ('730', 'fo0v7g2unk6n08skml7pmqoctm9otntv', '115', '2010-06-15 12:47:43', '2010-06-15 12:47:43', '0');
INSERT INTO `sessions` VALUES ('731', 'fo0v7g2unk6n08skml7pmqoctm9otntv', '115', '2010-06-15 12:47:43', '2010-06-15 12:52:49', '0');
INSERT INTO `sessions` VALUES ('732', 'fo0v7g2unk6n08skml7pmqoctm9otntv', '115', '2010-06-15 12:52:49', '2010-06-15 13:03:54', '1');
INSERT INTO `sessions` VALUES ('733', 'l0kfbahq4npdp6qk6m2o68f3nomo0tne', '115', '2010-06-15 16:28:48', '2010-06-15 16:28:48', '0');
INSERT INTO `sessions` VALUES ('734', 'l0kfbahq4npdp6qk6m2o68f3nomo0tne', '115', '2010-06-15 16:28:48', '2010-06-15 16:28:50', '0');
INSERT INTO `sessions` VALUES ('735', 'l0kfbahq4npdp6qk6m2o68f3nomo0tne', '115', '2010-06-15 16:28:50', '2010-06-15 16:28:50', '0');
INSERT INTO `sessions` VALUES ('736', 'l0kfbahq4npdp6qk6m2o68f3nomo0tne', '115', '2010-06-15 16:28:50', '2010-06-15 16:28:50', '1');
INSERT INTO `sessions` VALUES ('737', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:57:39', '2010-06-16 10:57:39', '0');
INSERT INTO `sessions` VALUES ('738', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:57:39', '2010-06-16 10:57:41', '0');
INSERT INTO `sessions` VALUES ('739', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:57:41', '2010-06-16 10:57:41', '0');
INSERT INTO `sessions` VALUES ('740', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:57:41', '2010-06-16 10:58:51', '0');
INSERT INTO `sessions` VALUES ('741', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:58:51', '2010-06-16 10:58:52', '0');
INSERT INTO `sessions` VALUES ('742', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:58:52', '2010-06-16 10:58:52', '0');
INSERT INTO `sessions` VALUES ('743', 'crao6bg240cctm36hqg5ib4o7trlq101', '115', '2010-06-16 10:58:52', '2010-06-16 10:59:09', '1');
INSERT INTO `sessions` VALUES ('744', 'c35m450fcqq2ahqog04qerqluqe897k2', '115', '2010-06-16 11:01:23', '2010-06-16 11:01:23', '0');
INSERT INTO `sessions` VALUES ('745', 'c35m450fcqq2ahqog04qerqluqe897k2', '115', '2010-06-16 11:01:23', '2010-06-16 11:01:42', '0');
INSERT INTO `sessions` VALUES ('746', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-16 11:01:25', '2010-06-16 11:01:26', '0');
INSERT INTO `sessions` VALUES ('747', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-16 11:01:26', '2010-06-16 11:01:26', '0');
INSERT INTO `sessions` VALUES ('748', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-16 11:01:26', '2010-06-18 15:44:50', '0');
INSERT INTO `sessions` VALUES ('749', 'c35m450fcqq2ahqog04qerqluqe897k2', '115', '2010-06-16 11:01:42', '2010-06-16 11:01:42', '0');
INSERT INTO `sessions` VALUES ('750', 'c35m450fcqq2ahqog04qerqluqe897k2', '115', '2010-06-16 11:01:42', '2010-06-16 11:01:50', '1');
INSERT INTO `sessions` VALUES ('751', 'm3f39j1dd57tjqpk8569lhn3kd31omik', '115', '2010-06-16 13:39:34', '2010-06-16 18:44:47', '1');
INSERT INTO `sessions` VALUES ('752', 'fgt0pj4irdif6th705u2u26plejur05g', '8', '2010-06-17 09:44:05', '2010-06-17 10:18:32', '1');
INSERT INTO `sessions` VALUES ('753', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:18:02', '2010-06-18 11:18:02', '0');
INSERT INTO `sessions` VALUES ('754', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:18:02', '2010-06-18 11:18:30', '0');
INSERT INTO `sessions` VALUES ('755', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:18:43', '2010-06-18 11:18:43', '0');
INSERT INTO `sessions` VALUES ('756', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:18:43', '2010-06-18 11:19:10', '0');
INSERT INTO `sessions` VALUES ('757', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:19:10', '2010-06-18 11:19:50', '0');
INSERT INTO `sessions` VALUES ('758', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:19:50', '2010-06-18 11:27:35', '0');
INSERT INTO `sessions` VALUES ('759', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:27:35', '2010-06-18 11:27:51', '0');
INSERT INTO `sessions` VALUES ('760', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:27:51', '2010-06-18 11:28:17', '0');
INSERT INTO `sessions` VALUES ('761', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:28:17', '2010-06-18 11:33:23', '0');
INSERT INTO `sessions` VALUES ('762', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:33:23', '2010-06-18 11:56:19', '0');
INSERT INTO `sessions` VALUES ('763', 'ci78f3hvtc2phn0473qu80ij0mabural', '115', '2010-06-18 11:56:19', '2010-06-18 11:57:26', '1');
INSERT INTO `sessions` VALUES ('764', 'rt90u1aariu02dbqnc830fbj7korhcbm', '115', '2010-06-18 13:41:25', '2010-06-18 13:41:25', '0');
INSERT INTO `sessions` VALUES ('765', 'rt90u1aariu02dbqnc830fbj7korhcbm', '115', '2010-06-18 13:41:25', '2010-06-18 13:41:32', '0');
INSERT INTO `sessions` VALUES ('766', 'rt90u1aariu02dbqnc830fbj7korhcbm', '115', '2010-06-18 13:41:46', '2010-06-18 13:41:46', '0');
INSERT INTO `sessions` VALUES ('767', 'rt90u1aariu02dbqnc830fbj7korhcbm', '115', '2010-06-18 13:41:46', '2010-06-18 15:54:23', '0');
INSERT INTO `sessions` VALUES ('768', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:44:50', '2010-06-18 15:45:08', '0');
INSERT INTO `sessions` VALUES ('769', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:45:08', '2010-06-18 15:48:03', '0');
INSERT INTO `sessions` VALUES ('770', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:48:03', '2010-06-18 15:49:07', '0');
INSERT INTO `sessions` VALUES ('771', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:49:07', '2010-06-18 15:52:17', '0');
INSERT INTO `sessions` VALUES ('772', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:52:17', '2010-06-18 15:53:17', '0');
INSERT INTO `sessions` VALUES ('773', 've36pur361v6dhlqllvm99n2kd5ogjqv', '115', '2010-06-18 15:52:57', '2010-06-18 15:52:57', '0');
INSERT INTO `sessions` VALUES ('774', 've36pur361v6dhlqllvm99n2kd5ogjqv', '115', '2010-06-18 15:52:57', '2010-06-18 15:53:17', '0');
INSERT INTO `sessions` VALUES ('775', 'tik3jri3v3qu8ld5l6luj0b6971hodk8', '115', '2010-06-18 15:53:17', '2010-06-18 16:03:57', '1');
INSERT INTO `sessions` VALUES ('776', 've36pur361v6dhlqllvm99n2kd5ogjqv', '115', '2010-06-18 15:53:17', '2010-06-18 15:53:22', '1');
INSERT INTO `sessions` VALUES ('777', 'rt90u1aariu02dbqnc830fbj7korhcbm', '115', '2010-06-18 15:54:23', '2010-06-18 15:56:05', '1');
INSERT INTO `sessions` VALUES ('778', 'v0acvpahfp3c8l14p35hvf41iq3g82cs', '8', '2010-06-21 11:05:18', '2010-06-21 11:05:18', '0');
INSERT INTO `sessions` VALUES ('779', 'v0acvpahfp3c8l14p35hvf41iq3g82cs', '8', '2010-06-21 11:05:18', '2010-06-21 11:05:26', '0');
INSERT INTO `sessions` VALUES ('780', 'v0acvpahfp3c8l14p35hvf41iq3g82cs', '8', '2010-06-21 11:05:26', '2010-06-21 11:10:24', '0');
INSERT INTO `sessions` VALUES ('781', '72gfbf1tnt6ngo4h5qv3g20i8e67m218', '86', '2010-06-21 11:06:05', '2010-06-21 11:06:07', '0');
INSERT INTO `sessions` VALUES ('782', '72gfbf1tnt6ngo4h5qv3g20i8e67m218', '86', '2010-06-21 11:06:07', '2010-06-21 11:06:07', '0');
INSERT INTO `sessions` VALUES ('783', '72gfbf1tnt6ngo4h5qv3g20i8e67m218', '86', '2010-06-21 11:06:07', '2010-06-21 11:06:24', '0');
INSERT INTO `sessions` VALUES ('784', '72gfbf1tnt6ngo4h5qv3g20i8e67m218', '86', '2010-06-21 11:06:24', '2010-06-21 11:09:39', '0');
INSERT INTO `sessions` VALUES ('785', 'gffbtbvpk471fvg22krot4otk3jmonh1', '94', '2010-06-21 11:06:43', '2010-06-21 11:06:43', '0');
INSERT INTO `sessions` VALUES ('786', 'gffbtbvpk471fvg22krot4otk3jmonh1', '94', '2010-06-21 11:06:43', '2010-06-22 11:07:36', '1');
INSERT INTO `sessions` VALUES ('787', '72gfbf1tnt6ngo4h5qv3g20i8e67m218', '86', '2010-06-21 11:09:39', '2010-06-21 11:09:39', '1');
INSERT INTO `sessions` VALUES ('788', 'v0acvpahfp3c8l14p35hvf41iq3g82cs', '8', '2010-06-21 11:10:24', '2010-06-21 11:10:24', '1');
INSERT INTO `sessions` VALUES ('789', 'qff9gt28qo0edmd75mhgu65vad25uou6', '55', '2010-06-21 13:23:33', '2010-06-21 13:23:33', '0');
INSERT INTO `sessions` VALUES ('790', 'qff9gt28qo0edmd75mhgu65vad25uou6', '55', '2010-06-21 13:23:33', '2010-06-21 13:24:12', '1');
INSERT INTO `sessions` VALUES ('791', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-22 12:56:49', '2010-06-22 12:56:49', '0');
INSERT INTO `sessions` VALUES ('792', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-22 12:56:49', '2010-06-22 12:56:50', '0');
INSERT INTO `sessions` VALUES ('793', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-22 12:56:50', '2010-06-22 12:56:50', '0');
INSERT INTO `sessions` VALUES ('794', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-22 12:56:50', '2010-06-23 10:38:58', '0');
INSERT INTO `sessions` VALUES ('795', '0lobgpse0fp150b89t90lg01fugn8pqi', '115', '2010-06-22 15:52:21', '2010-06-22 15:52:21', '0');
INSERT INTO `sessions` VALUES ('796', '0lobgpse0fp150b89t90lg01fugn8pqi', '115', '2010-06-22 15:52:21', '2010-06-22 15:53:15', '0');
INSERT INTO `sessions` VALUES ('797', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-23 10:38:58', '2010-06-23 10:39:00', '0');
INSERT INTO `sessions` VALUES ('798', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-23 10:39:00', '2010-06-23 10:39:00', '0');
INSERT INTO `sessions` VALUES ('799', '0ojtjo0639e8grh29s5ssh4ielnvm2qt', '115', '2010-06-23 10:39:00', '2010-06-23 10:39:20', '1');
INSERT INTO `sessions` VALUES ('800', '0lobgpse0fp150b89t90lg01fugn8pqi', '115', '2010-06-23 14:50:58', '2010-06-23 14:50:58', '0');
INSERT INTO `sessions` VALUES ('801', 'vh1cgm7rkm5lbqijgbkhr97kk89jhlu9', '86', '2010-06-23 15:08:31', '2010-06-23 15:08:31', '0');
INSERT INTO `sessions` VALUES ('802', 'vh1cgm7rkm5lbqijgbkhr97kk89jhlu9', '86', '2010-06-23 15:08:31', '2010-06-23 15:08:34', '0');
INSERT INTO `sessions` VALUES ('803', 'vh1cgm7rkm5lbqijgbkhr97kk89jhlu9', '86', '2010-06-23 15:08:34', '2010-06-23 15:08:34', '0');
INSERT INTO `sessions` VALUES ('804', 'vh1cgm7rkm5lbqijgbkhr97kk89jhlu9', '86', '2010-06-23 15:08:34', '2010-06-23 15:18:57', '0');
INSERT INTO `sessions` VALUES ('805', 'vh1cgm7rkm5lbqijgbkhr97kk89jhlu9', '86', '2010-06-23 15:18:57', '2010-06-23 15:25:13', '0');
INSERT INTO `sessions` VALUES ('806', '1i98vfu9broi0oig2bc3q7gqji1ivgg6', '8', '2010-06-24 09:15:39', '2010-06-24 09:15:39', '0');
INSERT INTO `sessions` VALUES ('807', '1i98vfu9broi0oig2bc3q7gqji1ivgg6', '8', '2010-06-24 09:15:39', '2010-06-24 09:35:58', '1');
INSERT INTO `sessions` VALUES ('808', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:24:10', '2010-06-25 11:24:10', '0');
INSERT INTO `sessions` VALUES ('809', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:24:10', '2010-06-25 11:24:24', '0');
INSERT INTO `sessions` VALUES ('810', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:24:24', '2010-06-25 11:24:24', '0');
INSERT INTO `sessions` VALUES ('811', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:24:24', '2010-06-25 11:32:34', '0');
INSERT INTO `sessions` VALUES ('812', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:32:34', '2010-06-25 11:34:59', '0');
INSERT INTO `sessions` VALUES ('813', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:34:59', '2010-06-25 11:40:00', '0');
INSERT INTO `sessions` VALUES ('814', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-25 11:40:00', '2010-06-30 14:41:07', '0');
INSERT INTO `sessions` VALUES ('815', 'qg57ntuoj87jc558hi4c62gc0uvuba3l', '115', '2010-06-25 11:49:42', '2010-06-25 11:49:45', '0');
INSERT INTO `sessions` VALUES ('816', 'qg57ntuoj87jc558hi4c62gc0uvuba3l', '115', '2010-06-25 11:49:45', '2010-06-25 11:49:45', '0');
INSERT INTO `sessions` VALUES ('817', 'qg57ntuoj87jc558hi4c62gc0uvuba3l', '115', '2010-06-25 11:49:45', '2010-06-25 12:51:42', '0');
INSERT INTO `sessions` VALUES ('818', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:49:54', '2010-06-25 11:49:54', '0');
INSERT INTO `sessions` VALUES ('819', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:49:54', '2010-06-25 11:50:02', '0');
INSERT INTO `sessions` VALUES ('820', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:50:02', '2010-06-25 11:50:02', '0');
INSERT INTO `sessions` VALUES ('821', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:50:02', '2010-06-25 11:50:12', '0');
INSERT INTO `sessions` VALUES ('822', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:50:12', '2010-06-25 11:52:31', '0');
INSERT INTO `sessions` VALUES ('823', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 11:52:31', '2010-06-25 12:13:00', '0');
INSERT INTO `sessions` VALUES ('824', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 12:13:00', '2010-06-25 12:15:52', '0');
INSERT INTO `sessions` VALUES ('825', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 12:15:52', '2010-06-25 12:16:58', '0');
INSERT INTO `sessions` VALUES ('826', 'ecfp3if5ifknue398svol6in251bvam1', '115', '2010-06-25 12:16:58', '2010-06-25 12:28:01', '1');
INSERT INTO `sessions` VALUES ('827', 'qg57ntuoj87jc558hi4c62gc0uvuba3l', '115', '2010-06-25 12:51:42', '2010-06-25 12:51:42', '1');
INSERT INTO `sessions` VALUES ('828', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:10:18', '2010-06-25 15:10:18', '0');
INSERT INTO `sessions` VALUES ('829', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:10:18', '2010-06-25 15:12:01', '0');
INSERT INTO `sessions` VALUES ('830', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:12:01', '2010-06-25 15:12:02', '0');
INSERT INTO `sessions` VALUES ('831', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:12:02', '2010-06-25 15:15:40', '0');
INSERT INTO `sessions` VALUES ('832', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:15:40', '2010-06-25 15:15:41', '0');
INSERT INTO `sessions` VALUES ('833', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:15:41', '2010-06-25 15:15:41', '0');
INSERT INTO `sessions` VALUES ('834', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:15:41', '2010-06-25 15:18:30', '0');
INSERT INTO `sessions` VALUES ('835', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 15:18:30', '2010-06-25 17:45:23', '0');
INSERT INTO `sessions` VALUES ('836', '7d68udtbnj72lv5p98cs2e1p8tbmdfgp', '115', '2010-06-25 17:45:23', '2010-06-25 17:45:53', '1');
INSERT INTO `sessions` VALUES ('837', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 12:58:06', '2010-06-28 12:58:06', '0');
INSERT INTO `sessions` VALUES ('838', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 12:58:06', '2010-06-28 13:20:24', '0');
INSERT INTO `sessions` VALUES ('839', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 13:20:24', '2010-06-28 13:30:10', '0');
INSERT INTO `sessions` VALUES ('840', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 13:30:10', '2010-06-28 13:30:54', '0');
INSERT INTO `sessions` VALUES ('841', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 13:30:54', '2010-06-28 13:32:09', '0');
INSERT INTO `sessions` VALUES ('842', 'l7flpb950te7gc22fp7khngqfn09f8h0', '57', '2010-06-28 13:32:09', '2010-06-28 14:00:59', '1');
INSERT INTO `sessions` VALUES ('843', '1t90komqtqiccvq63famie9bl8e178n5', '86', '2010-06-28 14:41:18', '2010-06-28 14:41:18', '0');
INSERT INTO `sessions` VALUES ('844', '1t90komqtqiccvq63famie9bl8e178n5', '86', '2010-06-28 14:41:18', '2010-06-28 14:41:25', '0');
INSERT INTO `sessions` VALUES ('845', '1t90komqtqiccvq63famie9bl8e178n5', '86', '2010-06-28 14:41:25', '2010-06-28 14:50:01', '1');
INSERT INTO `sessions` VALUES ('846', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 13:36:57', '2010-06-29 13:36:57', '0');
INSERT INTO `sessions` VALUES ('847', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 13:36:57', '2010-06-29 13:37:20', '0');
INSERT INTO `sessions` VALUES ('848', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 13:37:20', '2010-06-29 14:01:16', '0');
INSERT INTO `sessions` VALUES ('849', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 14:03:32', '2010-06-29 14:04:00', '0');
INSERT INTO `sessions` VALUES ('850', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 14:04:00', '2010-06-29 14:08:05', '0');
INSERT INTO `sessions` VALUES ('851', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 14:08:05', '2010-06-29 14:11:49', '0');
INSERT INTO `sessions` VALUES ('852', 'q4ccau0rqc6o0o22pqv4bco3tbe9hq99', '116', '2010-06-29 14:11:49', '2010-06-29 14:12:01', '1');
INSERT INTO `sessions` VALUES ('853', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-30 14:41:07', '2010-06-30 14:41:13', '0');
INSERT INTO `sessions` VALUES ('854', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-30 14:41:13', '2010-06-30 14:41:13', '0');
INSERT INTO `sessions` VALUES ('855', 'ea49347q2te52dq29jcgb3gr6u1uot0u', '115', '2010-06-30 14:41:13', '2010-06-30 14:41:13', '1');
INSERT INTO `sessions` VALUES ('856', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-02 15:17:06', '2010-07-02 15:17:06', '0');
INSERT INTO `sessions` VALUES ('857', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-02 15:17:06', '2010-07-08 09:26:44', '0');
INSERT INTO `sessions` VALUES ('858', 'u697529k7kovbkp3e6phsq2khl3u4buc', '8', '2010-07-06 07:13:44', '2010-07-06 07:13:44', '0');
INSERT INTO `sessions` VALUES ('859', 'u697529k7kovbkp3e6phsq2khl3u4buc', '8', '2010-07-06 07:13:44', '2010-07-06 07:22:04', '0');
INSERT INTO `sessions` VALUES ('860', 'u697529k7kovbkp3e6phsq2khl3u4buc', '8', '2010-07-06 07:22:04', '2010-07-06 07:22:13', '1');
INSERT INTO `sessions` VALUES ('861', 'v28lv4i5ppcc8t17pj9vt3s4e9u5f0pi', '119', '2010-07-06 16:12:58', '2010-07-06 16:12:58', '0');
INSERT INTO `sessions` VALUES ('862', 'v28lv4i5ppcc8t17pj9vt3s4e9u5f0pi', '119', '2010-07-06 16:12:58', '2010-07-06 16:13:09', '0');
INSERT INTO `sessions` VALUES ('863', 'v28lv4i5ppcc8t17pj9vt3s4e9u5f0pi', '119', '2010-07-06 16:13:09', '2010-07-06 16:13:52', '0');
INSERT INTO `sessions` VALUES ('864', 'tocgqniutja258mp5v8sp13m2ru0hcka', '119', '2010-07-06 16:16:21', '2010-07-06 16:16:21', '0');
INSERT INTO `sessions` VALUES ('865', 'tocgqniutja258mp5v8sp13m2ru0hcka', '119', '2010-07-06 16:16:21', '2010-07-06 16:16:21', '1');
INSERT INTO `sessions` VALUES ('866', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:35:20', '2010-07-06 17:35:20', '0');
INSERT INTO `sessions` VALUES ('867', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:35:20', '2010-07-06 17:36:28', '0');
INSERT INTO `sessions` VALUES ('868', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:37:11', '2010-07-06 17:37:11', '0');
INSERT INTO `sessions` VALUES ('869', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:37:11', '2010-07-06 17:37:48', '0');
INSERT INTO `sessions` VALUES ('870', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:38:00', '2010-07-06 17:38:00', '0');
INSERT INTO `sessions` VALUES ('871', '7595anvpv5bklg1t6j6892e3vap5brtv', '119', '2010-07-06 17:38:00', '2010-07-06 17:38:27', '1');
INSERT INTO `sessions` VALUES ('872', '6q4qupjjjmvg049crv6oerr49f29aed4', '121', '2010-07-06 22:54:18', '2010-07-06 22:54:18', '0');
INSERT INTO `sessions` VALUES ('873', '6q4qupjjjmvg049crv6oerr49f29aed4', '121', '2010-07-06 22:54:18', '2010-07-06 22:54:39', '1');
INSERT INTO `sessions` VALUES ('874', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-07 12:09:28', '2010-07-08 12:53:38', '0');
INSERT INTO `sessions` VALUES ('875', '9hjhat6n0kurkvvi8lkc0iv0f3qr6qua', '117', '2010-07-07 23:55:21', '2010-07-07 23:55:21', '0');
INSERT INTO `sessions` VALUES ('876', '9hjhat6n0kurkvvi8lkc0iv0f3qr6qua', '117', '2010-07-07 23:55:21', '2010-07-07 23:57:02', '0');
INSERT INTO `sessions` VALUES ('877', '9hjhat6n0kurkvvi8lkc0iv0f3qr6qua', '117', '2010-07-07 23:57:02', '2010-07-08 00:01:57', '0');
INSERT INTO `sessions` VALUES ('878', '9hjhat6n0kurkvvi8lkc0iv0f3qr6qua', '117', '2010-07-08 00:01:57', '2010-07-08 00:14:27', '0');
INSERT INTO `sessions` VALUES ('879', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-08 09:26:44', '2010-07-08 09:26:46', '0');
INSERT INTO `sessions` VALUES ('880', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-08 09:26:46', '2010-07-08 09:26:46', '0');
INSERT INTO `sessions` VALUES ('881', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-08 09:26:46', '2010-07-08 10:59:34', '0');
INSERT INTO `sessions` VALUES ('882', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-08 10:59:34', '2010-07-08 11:04:26', '0');
INSERT INTO `sessions` VALUES ('883', 'b46jaeunmh2gmjrcu1b5b2i0et9id859', '115', '2010-07-08 11:04:26', '2010-07-08 11:04:53', '1');
INSERT INTO `sessions` VALUES ('884', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:53:38', '2010-07-08 12:53:56', '0');
INSERT INTO `sessions` VALUES ('885', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:53:56', '2010-07-08 12:54:38', '0');
INSERT INTO `sessions` VALUES ('886', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:54:38', '2010-07-08 12:54:43', '0');
INSERT INTO `sessions` VALUES ('887', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:54:43', '2010-07-08 12:55:09', '0');
INSERT INTO `sessions` VALUES ('888', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:55:09', '2010-07-08 12:55:12', '0');
INSERT INTO `sessions` VALUES ('889', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:55:12', '2010-07-08 12:55:37', '0');
INSERT INTO `sessions` VALUES ('890', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:55:37', '2010-07-08 12:55:39', '0');
INSERT INTO `sessions` VALUES ('891', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:55:39', '2010-07-08 12:56:09', '0');
INSERT INTO `sessions` VALUES ('892', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:56:09', '2010-07-08 12:56:28', '0');
INSERT INTO `sessions` VALUES ('893', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:56:28', '2010-07-08 12:56:49', '0');
INSERT INTO `sessions` VALUES ('894', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:56:49', '2010-07-08 12:57:06', '0');
INSERT INTO `sessions` VALUES ('895', 'ec37gs6j2ci7j8b6r0fpc1l1ct2a3j17', '116', '2010-07-08 12:57:06', '2010-07-08 13:03:22', '1');
INSERT INTO `sessions` VALUES ('896', 'irn0n3ve7033ta5g3h2t5mdr5ht8fjar', '115', '2010-07-08 15:26:50', '2010-07-08 15:26:50', '0');
INSERT INTO `sessions` VALUES ('897', 'irn0n3ve7033ta5g3h2t5mdr5ht8fjar', '115', '2010-07-08 15:26:50', '2010-07-09 09:13:37', '0');
INSERT INTO `sessions` VALUES ('898', 'irn0n3ve7033ta5g3h2t5mdr5ht8fjar', '115', '2010-07-09 09:13:37', '2010-07-09 09:13:45', '0');
INSERT INTO `sessions` VALUES ('899', 'irn0n3ve7033ta5g3h2t5mdr5ht8fjar', '115', '2010-07-09 09:13:45', '2010-07-09 09:13:45', '0');
INSERT INTO `sessions` VALUES ('900', 'irn0n3ve7033ta5g3h2t5mdr5ht8fjar', '115', '2010-07-09 09:13:45', '2010-07-09 09:14:46', '1');
INSERT INTO `sessions` VALUES ('901', 'rptmejj54dv32sdcloqmnm6faddn5ji3', '8', '2010-07-09 15:00:21', '2010-07-09 15:00:21', '0');
INSERT INTO `sessions` VALUES ('902', 'rptmejj54dv32sdcloqmnm6faddn5ji3', '8', '2010-07-09 15:00:21', '2010-07-09 15:00:23', '1');
INSERT INTO `sessions` VALUES ('903', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:14:10', '2010-07-09 16:14:10', '0');
INSERT INTO `sessions` VALUES ('904', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:14:10', '2010-07-09 16:14:19', '0');
INSERT INTO `sessions` VALUES ('905', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:14:27', '2010-07-09 16:14:27', '0');
INSERT INTO `sessions` VALUES ('906', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:14:27', '2010-07-09 16:15:31', '0');
INSERT INTO `sessions` VALUES ('907', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:15:58', '2010-07-09 16:15:58', '0');
INSERT INTO `sessions` VALUES ('908', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:15:58', '2010-07-09 16:16:02', '0');
INSERT INTO `sessions` VALUES ('909', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:02', '2010-07-09 16:16:16', '0');
INSERT INTO `sessions` VALUES ('910', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:26', '2010-07-09 16:16:26', '0');
INSERT INTO `sessions` VALUES ('911', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:26', '2010-07-09 16:16:35', '0');
INSERT INTO `sessions` VALUES ('912', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:45', '2010-07-09 16:16:45', '0');
INSERT INTO `sessions` VALUES ('913', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:45', '2010-07-09 16:16:46', '0');
INSERT INTO `sessions` VALUES ('914', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:16:46', '2010-07-09 16:16:50', '0');
INSERT INTO `sessions` VALUES ('915', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:24', '2010-07-09 16:17:24', '0');
INSERT INTO `sessions` VALUES ('916', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:24', '2010-07-09 16:17:36', '0');
INSERT INTO `sessions` VALUES ('917', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:36', '2010-07-09 16:17:40', '0');
INSERT INTO `sessions` VALUES ('918', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:40', '2010-07-09 16:17:40', '0');
INSERT INTO `sessions` VALUES ('919', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:40', '2010-07-09 16:17:41', '0');
INSERT INTO `sessions` VALUES ('920', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:17:41', '2010-07-09 16:17:45', '0');
INSERT INTO `sessions` VALUES ('921', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:19', '2010-07-09 16:18:19', '0');
INSERT INTO `sessions` VALUES ('922', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:19', '2010-07-09 16:18:33', '0');
INSERT INTO `sessions` VALUES ('923', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:36', '2010-07-09 16:18:36', '0');
INSERT INTO `sessions` VALUES ('924', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:36', '2010-07-09 16:18:44', '0');
INSERT INTO `sessions` VALUES ('925', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:53', '2010-07-09 16:18:53', '0');
INSERT INTO `sessions` VALUES ('926', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:18:53', '2010-07-09 16:19:16', '0');
INSERT INTO `sessions` VALUES ('927', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:19:16', '2010-07-09 16:20:16', '0');
INSERT INTO `sessions` VALUES ('928', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:21:01', '2010-07-09 16:21:01', '0');
INSERT INTO `sessions` VALUES ('929', '9e3of8jdt102kpeurptda88mgljaa7u3', '119', '2010-07-09 16:21:01', '2010-07-09 16:21:17', '1');
INSERT INTO `sessions` VALUES ('930', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:37:54', '2010-07-11 17:37:54', '0');
INSERT INTO `sessions` VALUES ('931', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:37:54', '2010-07-11 17:38:18', '0');
INSERT INTO `sessions` VALUES ('932', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:38:18', '2010-07-11 17:38:18', '0');
INSERT INTO `sessions` VALUES ('933', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:38:18', '2010-07-11 17:39:17', '0');
INSERT INTO `sessions` VALUES ('934', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:39:17', '2010-07-11 17:39:40', '0');
INSERT INTO `sessions` VALUES ('935', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:39:40', '2010-07-11 17:39:46', '0');
INSERT INTO `sessions` VALUES ('936', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:39:46', '2010-07-11 17:39:46', '0');
INSERT INTO `sessions` VALUES ('937', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:39:46', '2010-07-11 17:41:45', '0');
INSERT INTO `sessions` VALUES ('938', '453inh1a76tm2c38mfjfcfr1n9tqrcf7', '119', '2010-07-11 17:41:45', '2010-07-11 17:41:54', '0');
INSERT INTO `sessions` VALUES ('939', '3epjckaforur4e4j244o67dc2l1sfcfj', '80', '2010-07-12 10:50:30', '2010-07-12 10:50:30', '0');
INSERT INTO `sessions` VALUES ('940', '3epjckaforur4e4j244o67dc2l1sfcfj', '80', '2010-07-12 10:50:30', '2010-07-12 10:50:45', '0');
INSERT INTO `sessions` VALUES ('941', '3epjckaforur4e4j244o67dc2l1sfcfj', '80', '2010-07-12 10:50:45', '2010-07-12 10:50:45', '0');
INSERT INTO `sessions` VALUES ('942', '3epjckaforur4e4j244o67dc2l1sfcfj', '80', '2010-07-12 10:50:45', '2010-07-12 10:51:01', '0');
INSERT INTO `sessions` VALUES ('943', '3epjckaforur4e4j244o67dc2l1sfcfj', '80', '2010-07-12 10:51:01', '2010-07-12 11:45:03', '1');
INSERT INTO `sessions` VALUES ('944', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 10:54:36', '2010-07-12 10:54:36', '0');
INSERT INTO `sessions` VALUES ('945', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 10:54:36', '2010-07-12 11:16:57', '0');
INSERT INTO `sessions` VALUES ('946', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:16:57', '2010-07-12 11:17:04', '0');
INSERT INTO `sessions` VALUES ('947', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:24:23', '2010-07-12 11:24:43', '0');
INSERT INTO `sessions` VALUES ('948', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:24:43', '2010-07-12 11:24:53', '0');
INSERT INTO `sessions` VALUES ('949', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:25:14', '2010-07-12 11:25:14', '0');
INSERT INTO `sessions` VALUES ('950', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:25:14', '2010-07-12 11:34:31', '0');
INSERT INTO `sessions` VALUES ('951', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:46:57', '2010-07-12 11:46:59', '0');
INSERT INTO `sessions` VALUES ('952', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:46:59', '2010-07-12 11:47:05', '0');
INSERT INTO `sessions` VALUES ('953', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:47:05', '2010-07-12 11:47:05', '0');
INSERT INTO `sessions` VALUES ('954', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:47:05', '2010-07-12 11:47:38', '0');
INSERT INTO `sessions` VALUES ('955', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:47:34', '2010-07-12 11:47:34', '0');
INSERT INTO `sessions` VALUES ('956', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:47:34', '2010-07-12 11:47:51', '0');
INSERT INTO `sessions` VALUES ('957', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:47:38', '2010-07-12 11:47:42', '0');
INSERT INTO `sessions` VALUES ('958', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:47:42', '2010-07-12 11:47:42', '0');
INSERT INTO `sessions` VALUES ('959', 'gao3g3bdgo339os1n09vs8c15dtjriu2', '80', '2010-07-12 11:47:42', '2010-07-12 11:50:03', '1');
INSERT INTO `sessions` VALUES ('960', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:52:31', '2010-07-12 11:52:31', '0');
INSERT INTO `sessions` VALUES ('961', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:52:31', '2010-07-12 11:53:05', '0');
INSERT INTO `sessions` VALUES ('962', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:54:47', '2010-07-12 11:54:47', '0');
INSERT INTO `sessions` VALUES ('963', 'lnbi4o68ps14mdphqrclb93ou2d354p4', '119', '2010-07-12 11:54:47', '2010-07-12 11:58:47', '0');
INSERT INTO `sessions` VALUES ('964', 'v2l45kggvjmiq4kkd0r1mo53gbk3kge9', '8', '2010-07-12 17:01:11', '2010-07-12 17:01:11', '0');
INSERT INTO `sessions` VALUES ('965', 'v2l45kggvjmiq4kkd0r1mo53gbk3kge9', '8', '2010-07-12 17:01:11', '2010-07-12 17:01:23', '0');
INSERT INTO `sessions` VALUES ('966', 'v2l45kggvjmiq4kkd0r1mo53gbk3kge9', '8', '2010-07-12 17:01:23', '2010-07-12 17:01:23', '0');
INSERT INTO `sessions` VALUES ('967', 'v2l45kggvjmiq4kkd0r1mo53gbk3kge9', '8', '2010-07-12 17:01:23', '2010-07-12 17:06:36', '0');
INSERT INTO `sessions` VALUES ('968', 'v2l45kggvjmiq4kkd0r1mo53gbk3kge9', '8', '2010-07-12 17:06:36', '2010-07-12 20:11:09', '1');
INSERT INTO `sessions` VALUES ('969', 'qdelsvm0dpfv33hps5lp2ul6if0dais2', '94', '2010-07-12 21:16:33', '2010-07-12 21:16:33', '0');
INSERT INTO `sessions` VALUES ('970', 'qdelsvm0dpfv33hps5lp2ul6if0dais2', '94', '2010-07-12 21:16:33', '2010-07-13 10:05:59', '0');
INSERT INTO `sessions` VALUES ('971', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 09:33:38', '2010-07-13 09:33:38', '0');
INSERT INTO `sessions` VALUES ('972', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 09:33:38', '2010-07-13 09:33:45', '0');
INSERT INTO `sessions` VALUES ('973', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 09:35:08', '2010-07-13 09:35:08', '0');
INSERT INTO `sessions` VALUES ('974', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 09:35:08', '2010-07-13 09:35:10', '0');
INSERT INTO `sessions` VALUES ('975', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 09:35:10', '2010-07-13 09:35:10', '0');
INSERT INTO `sessions` VALUES ('976', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 09:35:10', '2010-07-13 10:54:29', '0');
INSERT INTO `sessions` VALUES ('977', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 10:54:29', '2010-07-13 10:55:34', '0');
INSERT INTO `sessions` VALUES ('978', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 10:55:34', '2010-07-13 11:00:13', '0');
INSERT INTO `sessions` VALUES ('979', 'u68kpnucnie6m86geufpq7jpm6tsk7jl', '115', '2010-07-13 11:00:13', '2010-07-13 11:00:19', '1');
INSERT INTO `sessions` VALUES ('980', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 11:03:25', '2010-07-13 11:03:25', '0');
INSERT INTO `sessions` VALUES ('981', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 11:03:25', '2010-07-13 11:03:27', '0');
INSERT INTO `sessions` VALUES ('982', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 11:03:27', '2010-07-13 11:03:27', '0');
INSERT INTO `sessions` VALUES ('983', '2l09evhlm15du14nf8t5u65h18k09q48', '115', '2010-07-13 11:03:27', '2010-07-13 11:04:17', '1');
INSERT INTO `sessions` VALUES ('984', 'qdelsvm0dpfv33hps5lp2ul6if0dais2', '94', '2010-07-13 13:26:58', '2010-07-13 13:26:58', '0');
INSERT INTO `sessions` VALUES ('985', 'qdelsvm0dpfv33hps5lp2ul6if0dais2', '94', '2010-07-13 13:26:58', '2010-07-13 13:27:00', '0');
INSERT INTO `sessions` VALUES ('986', 'qdelsvm0dpfv33hps5lp2ul6if0dais2', '94', '2010-07-13 13:27:00', '2010-07-13 13:27:01', '1');
INSERT INTO `sessions` VALUES ('987', 'ollvrushnd3ekipsamtgarmd4cugfp7g', '57', '2010-07-13 15:08:05', '2010-07-13 15:08:15', '1');
INSERT INTO `sessions` VALUES ('988', 'qvjkpo1sb3tm4180hfuhgckd1iiecc0g', '57', '2010-07-13 15:52:28', '2010-07-13 15:52:28', '0');
INSERT INTO `sessions` VALUES ('989', 'qvjkpo1sb3tm4180hfuhgckd1iiecc0g', '57', '2010-07-13 15:52:28', '2010-07-13 15:53:07', '1');
INSERT INTO `sessions` VALUES ('990', 'd3n99n6gbpe32qhq0u1tibujv6hvupl1', '80', '2010-07-16 20:06:23', '2010-07-16 20:06:23', '0');
INSERT INTO `sessions` VALUES ('991', 'd3n99n6gbpe32qhq0u1tibujv6hvupl1', '80', '2010-07-16 20:06:23', '2010-07-16 20:06:29', '0');
INSERT INTO `sessions` VALUES ('992', 'd3n99n6gbpe32qhq0u1tibujv6hvupl1', '80', '2010-07-16 20:06:29', '2010-07-16 20:06:39', '0');
INSERT INTO `sessions` VALUES ('993', 'oo09b1s39e9gq56ugkt5i7i0de3jri7f', '119', '2010-07-18 22:23:03', '2010-07-18 22:23:03', '0');
INSERT INTO `sessions` VALUES ('994', 'oo09b1s39e9gq56ugkt5i7i0de3jri7f', '119', '2010-07-18 22:23:03', '2010-07-18 22:25:26', '0');
INSERT INTO `sessions` VALUES ('995', 'oo09b1s39e9gq56ugkt5i7i0de3jri7f', '119', '2010-07-18 22:25:26', '2010-07-18 22:25:26', '0');
INSERT INTO `sessions` VALUES ('996', 'oo09b1s39e9gq56ugkt5i7i0de3jri7f', '119', '2010-07-18 22:25:26', '2010-07-18 22:25:30', '0');
INSERT INTO `sessions` VALUES ('997', 'oo09b1s39e9gq56ugkt5i7i0de3jri7f', '119', '2010-07-18 23:11:55', '2010-07-18 23:12:12', '0');
INSERT INTO `sessions` VALUES ('998', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:20:25', '2010-07-19 10:20:25', '0');
INSERT INTO `sessions` VALUES ('999', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:20:25', '2010-07-19 10:21:09', '0');
INSERT INTO `sessions` VALUES ('1000', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:09', '2010-07-19 10:21:12', '0');
INSERT INTO `sessions` VALUES ('1001', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:12', '2010-07-19 10:21:12', '0');
INSERT INTO `sessions` VALUES ('1002', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:12', '2010-07-19 10:21:42', '0');
INSERT INTO `sessions` VALUES ('1003', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:42', '2010-07-19 10:21:45', '0');
INSERT INTO `sessions` VALUES ('1004', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:45', '2010-07-19 10:21:45', '0');
INSERT INTO `sessions` VALUES ('1005', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:21:45', '2010-07-19 10:24:05', '0');
INSERT INTO `sessions` VALUES ('1006', 'oad30kbb719hnrf9pk1kkhesk66dh2kj', '119', '2010-07-19 10:24:05', '2010-07-19 10:29:48', '1');
INSERT INTO `sessions` VALUES ('1007', '8dnfbhh3dm8d4cgjrcug4qqa4hbkhsbd', '8', '2010-07-19 10:25:13', '2010-07-19 10:31:16', '0');
INSERT INTO `sessions` VALUES ('1008', '6tukrl8rcepiunrkuiqie3u17uf4bt1a', '8', '2010-07-19 10:29:06', '2010-07-19 10:29:06', '0');
INSERT INTO `sessions` VALUES ('1009', '6tukrl8rcepiunrkuiqie3u17uf4bt1a', '8', '2010-07-19 10:29:06', '2010-07-19 10:29:28', '1');
INSERT INTO `sessions` VALUES ('1010', 'krsrlgdrel1sp643ahkbhqnarlite752', '116', '2010-07-20 11:17:01', '2010-07-20 11:17:10', '0');
INSERT INTO `sessions` VALUES ('1011', 'krsrlgdrel1sp643ahkbhqnarlite752', '116', '2010-07-20 11:17:10', '2010-07-20 11:17:10', '0');
INSERT INTO `sessions` VALUES ('1012', 'krsrlgdrel1sp643ahkbhqnarlite752', '116', '2010-07-20 11:17:10', '2010-07-20 13:27:37', '0');
INSERT INTO `sessions` VALUES ('1013', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 13:57:53', '2010-07-20 13:57:53', '0');
INSERT INTO `sessions` VALUES ('1014', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 13:57:53', '2010-07-20 13:57:56', '0');
INSERT INTO `sessions` VALUES ('1015', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 13:57:56', '2010-07-20 13:59:40', '0');
INSERT INTO `sessions` VALUES ('1016', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:02:43', '2010-07-20 14:02:43', '0');
INSERT INTO `sessions` VALUES ('1017', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:02:43', '2010-07-20 14:03:17', '0');
INSERT INTO `sessions` VALUES ('1018', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:03:17', '2010-07-20 14:03:20', '0');
INSERT INTO `sessions` VALUES ('1019', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:03:20', '2010-07-20 14:03:20', '0');
INSERT INTO `sessions` VALUES ('1020', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:03:20', '2010-07-20 14:04:51', '0');
INSERT INTO `sessions` VALUES ('1021', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:04:51', '2010-07-20 14:04:54', '0');
INSERT INTO `sessions` VALUES ('1022', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:04:54', '2010-07-20 14:04:54', '0');
INSERT INTO `sessions` VALUES ('1023', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:04:54', '2010-07-20 14:05:39', '0');
INSERT INTO `sessions` VALUES ('1024', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:05:39', '2010-07-20 14:05:42', '0');
INSERT INTO `sessions` VALUES ('1025', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:05:42', '2010-07-20 14:05:42', '0');
INSERT INTO `sessions` VALUES ('1026', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:05:42', '2010-07-20 14:06:28', '0');
INSERT INTO `sessions` VALUES ('1027', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:06:28', '2010-07-20 14:06:31', '0');
INSERT INTO `sessions` VALUES ('1028', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:06:31', '2010-07-20 14:06:31', '0');
INSERT INTO `sessions` VALUES ('1029', '415je1kv0m4dbfssgj1mfpj21tf2vjol', '119', '2010-07-20 14:06:31', '2010-07-20 14:29:45', '1');
INSERT INTO `sessions` VALUES ('1030', 'q9d0njg3jaqe3j7i4pifl81tjavq8bck', '8', '2010-07-21 08:51:59', '2010-07-21 08:51:59', '0');
INSERT INTO `sessions` VALUES ('1031', 'q9d0njg3jaqe3j7i4pifl81tjavq8bck', '8', '2010-07-21 08:51:59', '2010-07-21 11:48:15', '1');
INSERT INTO `sessions` VALUES ('1032', 'stb7ithg9c2595isd0dlp1h9rqnjj54h', '80', '2010-07-21 09:48:28', '2010-07-21 09:48:28', '0');
INSERT INTO `sessions` VALUES ('1033', 'stb7ithg9c2595isd0dlp1h9rqnjj54h', '80', '2010-07-21 09:48:28', '2010-07-21 09:48:50', '0');
INSERT INTO `sessions` VALUES ('1034', 'stb7ithg9c2595isd0dlp1h9rqnjj54h', '80', '2010-07-21 09:48:50', '2010-07-21 09:48:50', '1');
INSERT INTO `sessions` VALUES ('1035', 'krsrlgdrel1sp643ahkbhqnarlite752', '116', '2010-07-21 14:17:23', '2010-07-21 14:17:30', '1');
INSERT INTO `sessions` VALUES ('1036', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:48:42', '2010-07-22 08:48:42', '0');
INSERT INTO `sessions` VALUES ('1037', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:48:42', '2010-07-22 08:48:51', '0');
INSERT INTO `sessions` VALUES ('1038', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:48:51', '2010-07-22 08:48:51', '0');
INSERT INTO `sessions` VALUES ('1039', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:48:51', '2010-07-22 08:49:09', '0');
INSERT INTO `sessions` VALUES ('1040', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:49:31', '2010-07-22 08:49:31', '0');
INSERT INTO `sessions` VALUES ('1041', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 08:49:31', '2010-07-22 08:49:36', '0');
INSERT INTO `sessions` VALUES ('1042', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:03:43', '2010-07-22 09:03:43', '0');
INSERT INTO `sessions` VALUES ('1043', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:03:43', '2010-07-22 09:03:48', '0');
INSERT INTO `sessions` VALUES ('1044', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:04:15', '2010-07-22 09:04:15', '0');
INSERT INTO `sessions` VALUES ('1045', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:04:15', '2010-07-22 09:04:20', '0');
INSERT INTO `sessions` VALUES ('1046', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:08:07', '2010-07-22 09:08:07', '0');
INSERT INTO `sessions` VALUES ('1047', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:08:07', '2010-07-22 09:09:46', '0');
INSERT INTO `sessions` VALUES ('1048', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:09:51', '2010-07-22 09:09:51', '0');
INSERT INTO `sessions` VALUES ('1049', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:09:51', '2010-07-22 09:10:10', '0');
INSERT INTO `sessions` VALUES ('1050', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:10:10', '2010-07-22 09:10:14', '0');
INSERT INTO `sessions` VALUES ('1051', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:10:14', '2010-07-22 09:10:14', '0');
INSERT INTO `sessions` VALUES ('1052', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:10:14', '2010-07-22 09:11:38', '0');
INSERT INTO `sessions` VALUES ('1053', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:11:38', '2010-07-22 09:11:42', '0');
INSERT INTO `sessions` VALUES ('1054', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:11:42', '2010-07-22 09:11:42', '0');
INSERT INTO `sessions` VALUES ('1055', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:11:42', '2010-07-22 09:12:00', '0');
INSERT INTO `sessions` VALUES ('1056', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:25:41', '2010-07-22 09:25:47', '0');
INSERT INTO `sessions` VALUES ('1057', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:25:52', '2010-07-22 09:25:52', '0');
INSERT INTO `sessions` VALUES ('1058', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:25:52', '2010-07-22 09:26:10', '0');
INSERT INTO `sessions` VALUES ('1059', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:29:07', '2010-07-22 09:29:07', '0');
INSERT INTO `sessions` VALUES ('1060', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:29:07', '2010-07-22 09:29:28', '0');
INSERT INTO `sessions` VALUES ('1061', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:29:28', '2010-07-22 09:29:32', '0');
INSERT INTO `sessions` VALUES ('1062', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:29:32', '2010-07-22 09:29:32', '0');
INSERT INTO `sessions` VALUES ('1063', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:29:32', '2010-07-22 09:29:57', '0');
INSERT INTO `sessions` VALUES ('1064', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:30:20', '2010-07-22 09:30:20', '0');
INSERT INTO `sessions` VALUES ('1065', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:30:20', '2010-07-22 09:31:22', '0');
INSERT INTO `sessions` VALUES ('1066', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:31:22', '2010-07-22 09:31:26', '0');
INSERT INTO `sessions` VALUES ('1067', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:31:26', '2010-07-22 09:31:26', '0');
INSERT INTO `sessions` VALUES ('1068', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:31:26', '2010-07-22 09:34:52', '0');
INSERT INTO `sessions` VALUES ('1069', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:34:52', '2010-07-22 09:34:55', '0');
INSERT INTO `sessions` VALUES ('1070', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:34:55', '2010-07-22 09:34:55', '0');
INSERT INTO `sessions` VALUES ('1071', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 09:34:55', '2010-07-22 09:35:11', '0');
INSERT INTO `sessions` VALUES ('1072', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:25:19', '2010-07-22 10:25:19', '0');
INSERT INTO `sessions` VALUES ('1073', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:25:19', '2010-07-22 10:25:24', '0');
INSERT INTO `sessions` VALUES ('1074', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:25:29', '2010-07-22 10:25:29', '0');
INSERT INTO `sessions` VALUES ('1075', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:25:29', '2010-07-22 10:25:46', '0');
INSERT INTO `sessions` VALUES ('1076', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:26:48', '2010-07-22 10:26:48', '0');
INSERT INTO `sessions` VALUES ('1077', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:26:48', '2010-07-22 10:26:53', '0');
INSERT INTO `sessions` VALUES ('1078', 'cojr6auc9pvs5v1dnckpi6u64lt07ks6', '119', '2010-07-22 10:26:58', '2010-07-22 10:27:15', '0');
INSERT INTO `sessions` VALUES ('1079', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 13:44:11', '2010-07-22 13:44:11', '0');
INSERT INTO `sessions` VALUES ('1080', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 13:44:11', '2010-07-22 13:59:13', '0');
INSERT INTO `sessions` VALUES ('1081', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 13:59:13', '2010-07-22 13:59:16', '0');
INSERT INTO `sessions` VALUES ('1082', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 13:59:16', '2010-07-22 13:59:16', '0');
INSERT INTO `sessions` VALUES ('1083', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 13:59:16', '2010-07-22 13:59:21', '0');
INSERT INTO `sessions` VALUES ('1084', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 14:22:55', '2010-07-22 14:22:55', '0');
INSERT INTO `sessions` VALUES ('1085', 'iebenetjrqrgokup1bcensib74inspf4', '119', '2010-07-22 14:22:55', '2010-07-22 14:23:16', '0');
INSERT INTO `sessions` VALUES ('1086', 'n45amrvb9iktludicbsd0agh84fego8h', '8', '2010-07-23 09:26:13', '2010-07-23 09:26:13', '0');
INSERT INTO `sessions` VALUES ('1087', 'n45amrvb9iktludicbsd0agh84fego8h', '8', '2010-07-23 09:26:13', '2010-07-23 09:28:01', '1');
INSERT INTO `sessions` VALUES ('1088', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:05:48', '2010-07-26 08:05:48', '0');
INSERT INTO `sessions` VALUES ('1089', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:05:48', '2010-07-26 08:06:05', '0');
INSERT INTO `sessions` VALUES ('1090', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:06:05', '2010-07-26 08:06:05', '0');
INSERT INTO `sessions` VALUES ('1091', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:06:05', '2010-07-26 08:06:05', '0');
INSERT INTO `sessions` VALUES ('1092', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:06:05', '2010-07-26 08:06:41', '0');
INSERT INTO `sessions` VALUES ('1093', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:13:41', '2010-07-26 08:13:41', '0');
INSERT INTO `sessions` VALUES ('1094', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:13:41', '2010-07-26 08:13:46', '0');
INSERT INTO `sessions` VALUES ('1095', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:13:58', '2010-07-26 08:13:58', '0');
INSERT INTO `sessions` VALUES ('1096', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:13:58', '2010-07-26 08:14:03', '0');
INSERT INTO `sessions` VALUES ('1097', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:14:16', '2010-07-26 08:14:16', '0');
INSERT INTO `sessions` VALUES ('1098', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:14:16', '2010-07-26 08:14:33', '0');
INSERT INTO `sessions` VALUES ('1099', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:14:50', '2010-07-26 08:14:50', '0');
INSERT INTO `sessions` VALUES ('1100', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:14:50', '2010-07-26 08:15:43', '0');
INSERT INTO `sessions` VALUES ('1101', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:15:43', '2010-07-26 08:15:43', '0');
INSERT INTO `sessions` VALUES ('1102', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:15:43', '2010-07-26 08:16:28', '0');
INSERT INTO `sessions` VALUES ('1103', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:16:28', '2010-07-26 08:16:31', '0');
INSERT INTO `sessions` VALUES ('1104', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:16:31', '2010-07-26 08:16:31', '0');
INSERT INTO `sessions` VALUES ('1105', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:16:31', '2010-07-26 08:16:49', '0');
INSERT INTO `sessions` VALUES ('1106', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:16:57', '2010-07-26 08:16:57', '0');
INSERT INTO `sessions` VALUES ('1107', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:16:57', '2010-07-26 08:17:14', '0');
INSERT INTO `sessions` VALUES ('1108', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:17:26', '2010-07-26 08:17:26', '0');
INSERT INTO `sessions` VALUES ('1109', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:17:26', '2010-07-26 08:18:40', '0');
INSERT INTO `sessions` VALUES ('1110', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:18:40', '2010-07-26 08:18:43', '0');
INSERT INTO `sessions` VALUES ('1111', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:18:43', '2010-07-26 08:18:43', '0');
INSERT INTO `sessions` VALUES ('1112', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:18:43', '2010-07-26 08:19:06', '0');
INSERT INTO `sessions` VALUES ('1113', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:01', '2010-07-26 08:33:01', '0');
INSERT INTO `sessions` VALUES ('1114', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:01', '2010-07-26 08:33:06', '0');
INSERT INTO `sessions` VALUES ('1115', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:17', '2010-07-26 08:33:17', '0');
INSERT INTO `sessions` VALUES ('1116', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:17', '2010-07-26 08:33:22', '0');
INSERT INTO `sessions` VALUES ('1117', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:35', '2010-07-26 08:33:35', '0');
INSERT INTO `sessions` VALUES ('1118', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:35', '2010-07-26 08:33:40', '0');
INSERT INTO `sessions` VALUES ('1119', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:49', '2010-07-26 08:33:49', '0');
INSERT INTO `sessions` VALUES ('1120', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:33:49', '2010-07-26 08:35:36', '0');
INSERT INTO `sessions` VALUES ('1121', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:35:36', '2010-07-26 08:35:39', '0');
INSERT INTO `sessions` VALUES ('1122', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:35:39', '2010-07-26 08:35:39', '0');
INSERT INTO `sessions` VALUES ('1123', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:35:39', '2010-07-26 08:36:02', '0');
INSERT INTO `sessions` VALUES ('1124', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:36:27', '2010-07-26 08:36:27', '0');
INSERT INTO `sessions` VALUES ('1125', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:36:27', '2010-07-26 08:36:49', '0');
INSERT INTO `sessions` VALUES ('1126', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:37:15', '2010-07-26 08:37:15', '0');
INSERT INTO `sessions` VALUES ('1127', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 08:37:15', '2010-07-26 08:37:40', '0');
INSERT INTO `sessions` VALUES ('1128', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 09:09:16', '2010-07-26 09:09:16', '0');
INSERT INTO `sessions` VALUES ('1129', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 09:09:16', '2010-07-26 09:09:21', '0');
INSERT INTO `sessions` VALUES ('1130', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 09:09:26', '2010-07-26 09:09:26', '0');
INSERT INTO `sessions` VALUES ('1131', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 09:09:26', '2010-07-26 09:09:49', '0');
INSERT INTO `sessions` VALUES ('1132', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:28:51', '2010-07-26 10:28:51', '0');
INSERT INTO `sessions` VALUES ('1133', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:28:51', '2010-07-26 10:28:56', '0');
INSERT INTO `sessions` VALUES ('1134', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:29:02', '2010-07-26 10:29:02', '0');
INSERT INTO `sessions` VALUES ('1135', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:29:02', '2010-07-26 10:29:24', '0');
INSERT INTO `sessions` VALUES ('1136', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:32:57', '2010-07-26 10:32:57', '0');
INSERT INTO `sessions` VALUES ('1137', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:32:57', '2010-07-26 10:32:57', '0');
INSERT INTO `sessions` VALUES ('1138', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:32:57', '2010-07-26 10:32:58', '0');
INSERT INTO `sessions` VALUES ('1139', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:32:58', '2010-07-26 10:32:58', '0');
INSERT INTO `sessions` VALUES ('1140', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:32:58', '2010-07-26 10:33:11', '0');
INSERT INTO `sessions` VALUES ('1141', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:11', '2010-07-26 10:33:14', '0');
INSERT INTO `sessions` VALUES ('1142', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:14', '2010-07-26 10:33:14', '0');
INSERT INTO `sessions` VALUES ('1143', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:14', '2010-07-26 10:33:19', '0');
INSERT INTO `sessions` VALUES ('1144', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:19', '2010-07-26 10:33:19', '0');
INSERT INTO `sessions` VALUES ('1145', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:25', '2010-07-26 10:33:25', '0');
INSERT INTO `sessions` VALUES ('1146', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:33:25', '2010-07-26 10:33:48', '0');
INSERT INTO `sessions` VALUES ('1147', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:38:44', '2010-07-26 10:38:45', '0');
INSERT INTO `sessions` VALUES ('1148', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:38:45', '2010-07-26 10:38:47', '0');
INSERT INTO `sessions` VALUES ('1149', 'crm2hjskcjkudjbn0ph0ebkhfhpddovi', '119', '2010-07-26 10:38:47', '2010-07-26 10:38:50', '0');
INSERT INTO `sessions` VALUES ('1150', 'sdsllvdoppp23bqcfcdtv6fg4rafdvbg', '100', '2010-07-26 13:15:29', '2010-07-26 13:15:29', '0');
INSERT INTO `sessions` VALUES ('1151', 'sdsllvdoppp23bqcfcdtv6fg4rafdvbg', '100', '2010-07-26 13:15:29', '2010-07-26 13:16:56', '0');
INSERT INTO `sessions` VALUES ('1152', 'sdsllvdoppp23bqcfcdtv6fg4rafdvbg', '100', '2010-07-26 13:16:56', '2010-07-26 13:18:50', '0');
INSERT INTO `sessions` VALUES ('1153', 'sdsllvdoppp23bqcfcdtv6fg4rafdvbg', '100', '2010-07-26 13:18:50', '2010-07-26 13:20:35', '0');
INSERT INTO `sessions` VALUES ('1154', 'sdsllvdoppp23bqcfcdtv6fg4rafdvbg', '100', '2010-07-26 13:20:35', '2010-07-27 08:18:56', '1');
INSERT INTO `sessions` VALUES ('1155', 'cqtkmigpqo7cudc6rq285g90roudbvo9', '100', '2010-07-26 14:12:11', '2010-07-26 14:54:54', '0');
INSERT INTO `sessions` VALUES ('1156', 'lja1d7c98iug0v24jihj75bkd0ijjoho', '119', '2010-07-29 14:35:40', '2010-07-29 14:35:40', '0');
INSERT INTO `sessions` VALUES ('1157', 'lja1d7c98iug0v24jihj75bkd0ijjoho', '119', '2010-07-29 14:35:40', '2010-07-29 14:58:12', '1');
INSERT INTO `sessions` VALUES ('1158', 'rnbveutti4uohpt0akikdsqjqerapshb', '100', '2010-07-30 14:54:46', '2010-07-30 14:54:46', '0');
INSERT INTO `sessions` VALUES ('1159', 'rnbveutti4uohpt0akikdsqjqerapshb', '100', '2010-07-30 14:54:46', '2010-07-30 14:54:53', '0');
INSERT INTO `sessions` VALUES ('1160', 'rnbveutti4uohpt0akikdsqjqerapshb', '100', '2010-07-30 14:54:53', '2010-07-30 15:10:12', '1');
INSERT INTO `sessions` VALUES ('1161', 'p83ke7td1vdvd73brc2cparp1a0iq0l9', '119', '2010-08-01 23:23:03', '2010-08-01 23:23:03', '0');
INSERT INTO `sessions` VALUES ('1162', 'p83ke7td1vdvd73brc2cparp1a0iq0l9', '119', '2010-08-01 23:23:03', '2010-08-01 23:23:11', '0');
INSERT INTO `sessions` VALUES ('1163', 'p83ke7td1vdvd73brc2cparp1a0iq0l9', '119', '2010-08-01 23:23:11', '2010-08-01 23:23:11', '0');
INSERT INTO `sessions` VALUES ('1164', 'p83ke7td1vdvd73brc2cparp1a0iq0l9', '119', '2010-08-01 23:23:11', '2010-08-01 23:27:25', '1');
INSERT INTO `sessions` VALUES ('1165', '5sgtdb8molj7b2oo50vpobolsjj37jpd', '119', '2010-08-02 14:49:14', '2010-08-02 14:49:14', '0');
INSERT INTO `sessions` VALUES ('1166', '5sgtdb8molj7b2oo50vpobolsjj37jpd', '119', '2010-08-02 14:49:14', '2010-08-02 14:49:14', '1');
INSERT INTO `sessions` VALUES ('1167', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 08:23:31', '2010-08-03 08:23:31', '0');
INSERT INTO `sessions` VALUES ('1168', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 08:23:31', '2010-08-03 08:23:53', '0');
INSERT INTO `sessions` VALUES ('1169', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 08:23:53', '2010-08-03 08:23:53', '0');
INSERT INTO `sessions` VALUES ('1170', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 08:23:53', '2010-08-03 08:37:10', '0');
INSERT INTO `sessions` VALUES ('1171', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 13:58:22', '2010-08-03 13:58:22', '0');
INSERT INTO `sessions` VALUES ('1172', '4dlqum3qmsimnv5v842m3qluujqna7gb', '119', '2010-08-03 13:58:22', '2010-08-03 14:03:05', '1');
INSERT INTO `sessions` VALUES ('1173', 'ov262obafl34s5nqaif2lslcrec57i2h', '8', '2010-08-04 20:49:36', '2010-08-04 20:49:36', '1');
INSERT INTO `sessions` VALUES ('1174', 's34r0e4090tfn7n3kl62b3r31mos7fer', '80', '2010-08-04 22:05:17', '2010-08-04 22:05:17', '0');
INSERT INTO `sessions` VALUES ('1175', 's34r0e4090tfn7n3kl62b3r31mos7fer', '80', '2010-08-04 22:05:17', '2010-08-04 22:05:30', '0');
INSERT INTO `sessions` VALUES ('1176', 's34r0e4090tfn7n3kl62b3r31mos7fer', '80', '2010-08-04 22:05:30', '2010-08-04 22:05:30', '0');
INSERT INTO `sessions` VALUES ('1177', 's34r0e4090tfn7n3kl62b3r31mos7fer', '80', '2010-08-04 22:05:30', '2010-08-04 22:06:12', '1');
INSERT INTO `sessions` VALUES ('1178', 'q3d66i451knvflouhmruq77mvrr68kg8', '119', '2010-08-05 08:07:03', '2010-08-05 08:07:03', '0');
INSERT INTO `sessions` VALUES ('1179', 'q3d66i451knvflouhmruq77mvrr68kg8', '119', '2010-08-05 08:07:03', '2010-08-05 08:07:14', '1');
INSERT INTO `sessions` VALUES ('1180', 'q3d66i451knvflouhmruq77mvrr68kg8', '8', '2010-08-05 08:07:14', '2010-08-05 08:07:14', '0');
INSERT INTO `sessions` VALUES ('1181', 'q3d66i451knvflouhmruq77mvrr68kg8', '8', '2010-08-05 08:07:14', '2010-08-05 08:07:26', '0');
INSERT INTO `sessions` VALUES ('1182', 'q3d66i451knvflouhmruq77mvrr68kg8', '8', '2010-08-05 08:07:26', '2010-08-05 08:07:31', '0');
INSERT INTO `sessions` VALUES ('1183', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 08:54:29', '2010-08-09 08:54:29', '0');
INSERT INTO `sessions` VALUES ('1184', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 08:54:29', '2010-08-09 08:58:24', '0');
INSERT INTO `sessions` VALUES ('1185', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:01:10', '2010-08-09 09:01:10', '0');
INSERT INTO `sessions` VALUES ('1186', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:01:10', '2010-08-09 09:02:23', '0');
INSERT INTO `sessions` VALUES ('1187', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:02:33', '2010-08-09 09:02:33', '0');
INSERT INTO `sessions` VALUES ('1188', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:02:33', '2010-08-09 09:02:51', '0');
INSERT INTO `sessions` VALUES ('1189', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:02:51', '2010-08-09 09:02:54', '0');
INSERT INTO `sessions` VALUES ('1190', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:02:54', '2010-08-09 09:02:54', '0');
INSERT INTO `sessions` VALUES ('1191', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:02:54', '2010-08-09 09:03:12', '0');
INSERT INTO `sessions` VALUES ('1192', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:21', '2010-08-09 09:03:21', '0');
INSERT INTO `sessions` VALUES ('1193', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:21', '2010-08-09 09:03:23', '0');
INSERT INTO `sessions` VALUES ('1194', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:23', '2010-08-09 09:03:24', '0');
INSERT INTO `sessions` VALUES ('1195', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:24', '2010-08-09 09:03:27', '0');
INSERT INTO `sessions` VALUES ('1196', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:27', '2010-08-09 09:03:31', '0');
INSERT INTO `sessions` VALUES ('1197', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:37', '2010-08-09 09:03:37', '0');
INSERT INTO `sessions` VALUES ('1198', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:37', '2010-08-09 09:03:37', '0');
INSERT INTO `sessions` VALUES ('1199', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:37', '2010-08-09 09:03:38', '0');
INSERT INTO `sessions` VALUES ('1200', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:38', '2010-08-09 09:03:38', '0');
INSERT INTO `sessions` VALUES ('1201', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:38', '2010-08-09 09:03:39', '0');
INSERT INTO `sessions` VALUES ('1202', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:39', '2010-08-09 09:03:39', '0');
INSERT INTO `sessions` VALUES ('1203', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:39', '2010-08-09 09:03:40', '0');
INSERT INTO `sessions` VALUES ('1204', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:40', '2010-08-09 09:03:41', '0');
INSERT INTO `sessions` VALUES ('1205', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:41', '2010-08-09 09:03:42', '0');
INSERT INTO `sessions` VALUES ('1206', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:42', '2010-08-09 09:03:42', '0');
INSERT INTO `sessions` VALUES ('1207', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:49', '2010-08-09 09:03:49', '0');
INSERT INTO `sessions` VALUES ('1208', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:03:49', '2010-08-09 09:06:52', '0');
INSERT INTO `sessions` VALUES ('1209', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:06:52', '2010-08-09 09:06:52', '0');
INSERT INTO `sessions` VALUES ('1210', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:06:52', '2010-08-09 09:06:52', '0');
INSERT INTO `sessions` VALUES ('1211', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:06:52', '2010-08-09 09:06:52', '0');
INSERT INTO `sessions` VALUES ('1212', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:06:52', '2010-08-09 09:07:54', '0');
INSERT INTO `sessions` VALUES ('1213', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:08:36', '2010-08-09 09:08:36', '0');
INSERT INTO `sessions` VALUES ('1214', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:08:36', '2010-08-09 09:08:56', '0');
INSERT INTO `sessions` VALUES ('1215', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:08:56', '2010-08-09 09:08:56', '0');
INSERT INTO `sessions` VALUES ('1216', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:08:56', '2010-08-09 09:08:56', '0');
INSERT INTO `sessions` VALUES ('1217', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:08:56', '2010-08-09 09:09:01', '0');
INSERT INTO `sessions` VALUES ('1218', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:01', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1219', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1220', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1221', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1222', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1223', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:02', '0');
INSERT INTO `sessions` VALUES ('1224', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:02', '2010-08-09 09:09:03', '0');
INSERT INTO `sessions` VALUES ('1225', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:03', '2010-08-09 09:09:04', '0');
INSERT INTO `sessions` VALUES ('1226', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:04', '2010-08-09 09:09:04', '0');
INSERT INTO `sessions` VALUES ('1227', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:04', '2010-08-09 09:09:04', '0');
INSERT INTO `sessions` VALUES ('1228', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:04', '2010-08-09 09:09:05', '0');
INSERT INTO `sessions` VALUES ('1229', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:05', '2010-08-09 09:09:05', '0');
INSERT INTO `sessions` VALUES ('1230', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:09:05', '2010-08-09 09:09:05', '0');
INSERT INTO `sessions` VALUES ('1231', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:40', '2010-08-09 09:12:40', '0');
INSERT INTO `sessions` VALUES ('1232', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:40', '2010-08-09 09:12:40', '0');
INSERT INTO `sessions` VALUES ('1233', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:40', '2010-08-09 09:12:40', '0');
INSERT INTO `sessions` VALUES ('1234', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:40', '2010-08-09 09:12:41', '0');
INSERT INTO `sessions` VALUES ('1235', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:41', '2010-08-09 09:12:41', '0');
INSERT INTO `sessions` VALUES ('1236', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:41', '2010-08-09 09:12:42', '0');
INSERT INTO `sessions` VALUES ('1237', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:42', '2010-08-09 09:12:42', '0');
INSERT INTO `sessions` VALUES ('1238', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:42', '2010-08-09 09:12:42', '0');
INSERT INTO `sessions` VALUES ('1239', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:42', '2010-08-09 09:12:44', '0');
INSERT INTO `sessions` VALUES ('1240', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:44', '2010-08-09 09:12:45', '0');
INSERT INTO `sessions` VALUES ('1241', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:47', '2010-08-09 09:12:47', '0');
INSERT INTO `sessions` VALUES ('1242', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:47', '2010-08-09 09:12:48', '0');
INSERT INTO `sessions` VALUES ('1243', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:48', '2010-08-09 09:12:48', '0');
INSERT INTO `sessions` VALUES ('1244', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:48', '2010-08-09 09:12:48', '0');
INSERT INTO `sessions` VALUES ('1245', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:48', '2010-08-09 09:12:49', '0');
INSERT INTO `sessions` VALUES ('1246', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:49', '2010-08-09 09:12:49', '0');
INSERT INTO `sessions` VALUES ('1247', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:49', '2010-08-09 09:12:49', '0');
INSERT INTO `sessions` VALUES ('1248', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:49', '2010-08-09 09:12:50', '0');
INSERT INTO `sessions` VALUES ('1249', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:50', '2010-08-09 09:12:50', '0');
INSERT INTO `sessions` VALUES ('1250', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:50', '2010-08-09 09:12:50', '0');
INSERT INTO `sessions` VALUES ('1251', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:50', '2010-08-09 09:12:51', '0');
INSERT INTO `sessions` VALUES ('1252', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:54', '2010-08-09 09:12:54', '0');
INSERT INTO `sessions` VALUES ('1253', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:12:54', '2010-08-09 09:15:56', '0');
INSERT INTO `sessions` VALUES ('1254', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:15:56', '2010-08-09 09:15:56', '0');
INSERT INTO `sessions` VALUES ('1255', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:15:56', '2010-08-09 09:15:56', '0');
INSERT INTO `sessions` VALUES ('1256', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:15:56', '2010-08-09 09:15:56', '0');
INSERT INTO `sessions` VALUES ('1257', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:15:56', '2010-08-09 09:16:05', '0');
INSERT INTO `sessions` VALUES ('1258', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:05', '2010-08-09 09:16:06', '0');
INSERT INTO `sessions` VALUES ('1259', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:06', '2010-08-09 09:16:06', '0');
INSERT INTO `sessions` VALUES ('1260', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:06', '2010-08-09 09:16:19', '0');
INSERT INTO `sessions` VALUES ('1261', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:19', '2010-08-09 09:16:19', '0');
INSERT INTO `sessions` VALUES ('1262', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:19', '2010-08-09 09:16:19', '0');
INSERT INTO `sessions` VALUES ('1263', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:19', '2010-08-09 09:16:19', '0');
INSERT INTO `sessions` VALUES ('1264', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:19', '2010-08-09 09:16:38', '0');
INSERT INTO `sessions` VALUES ('1265', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:38', '2010-08-09 09:16:38', '0');
INSERT INTO `sessions` VALUES ('1266', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:38', '2010-08-09 09:16:38', '0');
INSERT INTO `sessions` VALUES ('1267', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:38', '2010-08-09 09:16:38', '0');
INSERT INTO `sessions` VALUES ('1268', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:38', '2010-08-09 09:16:40', '0');
INSERT INTO `sessions` VALUES ('1269', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:40', '2010-08-09 09:16:40', '0');
INSERT INTO `sessions` VALUES ('1270', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:40', '2010-08-09 09:16:41', '0');
INSERT INTO `sessions` VALUES ('1271', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:41', '2010-08-09 09:16:41', '0');
INSERT INTO `sessions` VALUES ('1272', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:41', '2010-08-09 09:16:41', '0');
INSERT INTO `sessions` VALUES ('1273', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:41', '2010-08-09 09:16:42', '0');
INSERT INTO `sessions` VALUES ('1274', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:42', '2010-08-09 09:16:42', '0');
INSERT INTO `sessions` VALUES ('1275', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:42', '2010-08-09 09:16:42', '0');
INSERT INTO `sessions` VALUES ('1276', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:42', '2010-08-09 09:16:43', '0');
INSERT INTO `sessions` VALUES ('1277', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:45', '2010-08-09 09:16:45', '0');
INSERT INTO `sessions` VALUES ('1278', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:45', '2010-08-09 09:16:47', '0');
INSERT INTO `sessions` VALUES ('1279', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:47', '2010-08-09 09:16:47', '0');
INSERT INTO `sessions` VALUES ('1280', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:47', '2010-08-09 09:16:47', '0');
INSERT INTO `sessions` VALUES ('1281', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:47', '2010-08-09 09:16:47', '0');
INSERT INTO `sessions` VALUES ('1282', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:47', '2010-08-09 09:16:48', '0');
INSERT INTO `sessions` VALUES ('1283', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:48', '2010-08-09 09:16:48', '0');
INSERT INTO `sessions` VALUES ('1284', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:48', '2010-08-09 09:16:48', '0');
INSERT INTO `sessions` VALUES ('1285', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:48', '2010-08-09 09:16:52', '0');
INSERT INTO `sessions` VALUES ('1286', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:58', '2010-08-09 09:16:58', '0');
INSERT INTO `sessions` VALUES ('1287', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:58', '2010-08-09 09:16:58', '0');
INSERT INTO `sessions` VALUES ('1288', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:58', '2010-08-09 09:16:59', '0');
INSERT INTO `sessions` VALUES ('1289', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:59', '2010-08-09 09:16:59', '0');
INSERT INTO `sessions` VALUES ('1290', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:59', '2010-08-09 09:16:59', '0');
INSERT INTO `sessions` VALUES ('1291', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:16:59', '2010-08-09 09:17:00', '0');
INSERT INTO `sessions` VALUES ('1292', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:17:00', '2010-08-09 09:17:00', '0');
INSERT INTO `sessions` VALUES ('1293', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:17:00', '2010-08-09 09:17:00', '0');
INSERT INTO `sessions` VALUES ('1294', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:17:00', '2010-08-09 09:17:00', '0');
INSERT INTO `sessions` VALUES ('1295', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:17:00', '2010-08-09 09:17:01', '0');
INSERT INTO `sessions` VALUES ('1296', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:17:01', '2010-08-09 09:17:02', '0');
INSERT INTO `sessions` VALUES ('1297', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:10', '2010-08-09 09:20:10', '0');
INSERT INTO `sessions` VALUES ('1298', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:10', '2010-08-09 09:20:10', '0');
INSERT INTO `sessions` VALUES ('1299', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:10', '2010-08-09 09:20:10', '0');
INSERT INTO `sessions` VALUES ('1300', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:10', '2010-08-09 09:20:11', '0');
INSERT INTO `sessions` VALUES ('1301', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:11', '2010-08-09 09:20:11', '0');
INSERT INTO `sessions` VALUES ('1302', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:11', '2010-08-09 09:20:11', '0');
INSERT INTO `sessions` VALUES ('1303', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:11', '2010-08-09 09:20:11', '0');
INSERT INTO `sessions` VALUES ('1304', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:11', '2010-08-09 09:20:12', '0');
INSERT INTO `sessions` VALUES ('1305', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:12', '2010-08-09 09:20:12', '0');
INSERT INTO `sessions` VALUES ('1306', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:12', '2010-08-09 09:20:12', '0');
INSERT INTO `sessions` VALUES ('1307', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:12', '2010-08-09 09:20:13', '0');
INSERT INTO `sessions` VALUES ('1308', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 09:20:13', '2010-08-09 09:20:13', '0');
INSERT INTO `sessions` VALUES ('1309', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 11:38:02', '2010-08-09 11:38:02', '0');
INSERT INTO `sessions` VALUES ('1310', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-09 11:38:02', '2010-08-09 11:49:22', '0');
INSERT INTO `sessions` VALUES ('1311', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-10 11:01:02', '2010-08-10 11:01:02', '0');
INSERT INTO `sessions` VALUES ('1312', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-10 11:01:02', '2010-08-10 11:01:28', '0');
INSERT INTO `sessions` VALUES ('1313', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-10 11:01:34', '2010-08-10 11:01:34', '0');
INSERT INTO `sessions` VALUES ('1314', 'v6jgm2luv8irprmjuvt1cahtdrd9c9sc', '119', '2010-08-10 11:01:34', '2010-08-10 11:26:29', '0');
INSERT INTO `sessions` VALUES ('1315', 'gqpoj7d3snq577dom7siiajpofrhp900', '116', '2010-08-11 11:28:13', '2010-08-11 11:33:40', '1');
INSERT INTO `sessions` VALUES ('1316', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-13 17:56:17', '2010-08-13 17:56:38', '0');
INSERT INTO `sessions` VALUES ('1317', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-13 17:56:38', '2010-08-13 18:48:29', '0');
INSERT INTO `sessions` VALUES ('1318', 'cgrq5cn3ncoa3eisi1kt07295o9rg8tc', '80', '2010-08-13 18:08:18', '2010-08-13 18:08:21', '1');
INSERT INTO `sessions` VALUES ('1319', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-13 18:48:29', '2010-08-13 19:06:05', '0');
INSERT INTO `sessions` VALUES ('1320', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-13 19:06:05', '2010-08-13 19:14:32', '0');
INSERT INTO `sessions` VALUES ('1321', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-13 19:14:32', '2010-08-14 17:02:51', '0');
INSERT INTO `sessions` VALUES ('1322', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-14 17:02:51', '2010-08-14 17:03:07', '0');
INSERT INTO `sessions` VALUES ('1323', 'hbuu8356mafeerhlh87ahsflt1iftslf', '124', '2010-08-14 18:21:27', '2010-08-16 05:55:54', '1');
INSERT INTO `sessions` VALUES ('1324', '6q7a0g95rt87hljecf7o79fkfvvb1jgd', '94', '2010-08-15 23:59:10', '2010-08-16 00:44:18', '1');
INSERT INTO `sessions` VALUES ('1325', 'cc7udbh0l7jlgaimjkfs0e8vh008l7aq', '116', '2010-08-16 13:14:31', '2010-08-16 13:14:33', '0');
INSERT INTO `sessions` VALUES ('1326', 'cc7udbh0l7jlgaimjkfs0e8vh008l7aq', '116', '2010-08-16 13:14:33', '2010-08-16 13:14:38', '1');
INSERT INTO `sessions` VALUES ('1327', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:40:18', '2010-08-18 09:40:18', '0');
INSERT INTO `sessions` VALUES ('1328', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:40:18', '2010-08-18 09:41:01', '0');
INSERT INTO `sessions` VALUES ('1329', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:06', '2010-08-18 09:41:06', '0');
INSERT INTO `sessions` VALUES ('1330', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:06', '2010-08-18 09:41:17', '0');
INSERT INTO `sessions` VALUES ('1331', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:17', '2010-08-18 09:41:20', '0');
INSERT INTO `sessions` VALUES ('1332', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:20', '2010-08-18 09:41:20', '0');
INSERT INTO `sessions` VALUES ('1333', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:20', '2010-08-18 09:41:36', '0');
INSERT INTO `sessions` VALUES ('1334', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:41:36', '2010-08-18 09:42:08', '0');
INSERT INTO `sessions` VALUES ('1335', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:42:08', '2010-08-18 09:42:30', '0');
INSERT INTO `sessions` VALUES ('1336', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:42:30', '2010-08-18 09:42:40', '0');
INSERT INTO `sessions` VALUES ('1337', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:42:40', '2010-08-18 09:42:40', '0');
INSERT INTO `sessions` VALUES ('1338', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:42:40', '2010-08-18 09:42:54', '0');
INSERT INTO `sessions` VALUES ('1339', 'mbknfeu6tpt4e4t3du1ggun9t45v5hf7', '119', '2010-08-18 09:42:54', '2010-08-18 09:42:59', '0');
INSERT INTO `sessions` VALUES ('1340', '6dnq9dlslfbdm1fm3bpra5kiegp59bid', '101', '2010-08-20 01:50:27', '2010-08-20 01:50:27', '0');
INSERT INTO `sessions` VALUES ('1341', '6dnq9dlslfbdm1fm3bpra5kiegp59bid', '101', '2010-08-20 01:50:27', '2010-08-20 02:03:13', '0');
INSERT INTO `sessions` VALUES ('1342', '6dnq9dlslfbdm1fm3bpra5kiegp59bid', '101', '2010-08-20 02:03:13', '2010-08-20 02:03:21', '0');
INSERT INTO `sessions` VALUES ('1343', '6dnq9dlslfbdm1fm3bpra5kiegp59bid', '101', '2010-08-20 02:03:21', '2010-08-20 02:03:21', '1');
INSERT INTO `sessions` VALUES ('1344', 'f4il1i1jpnp8glal43ulqdq51kubdqtl', '101', '2010-08-20 02:06:21', '2010-08-20 02:06:28', '0');
INSERT INTO `sessions` VALUES ('1345', 'f4il1i1jpnp8glal43ulqdq51kubdqtl', '101', '2010-08-20 02:06:28', '2010-08-20 02:07:48', '0');
INSERT INTO `sessions` VALUES ('1346', 'f4il1i1jpnp8glal43ulqdq51kubdqtl', '101', '2010-08-20 02:07:48', '2010-08-20 02:08:25', '1');
INSERT INTO `sessions` VALUES ('1347', '6fiue0pe05sf1s81ll8737ismr8h2bgo', '94', '2010-08-22 18:40:06', '2010-08-22 18:40:07', '1');
INSERT INTO `sessions` VALUES ('1348', 'uuarsgeclpgnrmrqnn5cvnmg2m78u5bf', '119', '2010-08-23 14:24:27', '2010-08-23 14:24:27', '0');
INSERT INTO `sessions` VALUES ('1349', 'uuarsgeclpgnrmrqnn5cvnmg2m78u5bf', '119', '2010-08-23 14:24:27', '2010-08-23 14:24:30', '0');
INSERT INTO `sessions` VALUES ('1350', 'ung510joonm9uq9orlemcr4ut1e0cq90', '80', '2010-08-26 09:27:37', '2010-08-26 09:27:37', '0');
INSERT INTO `sessions` VALUES ('1351', 'ung510joonm9uq9orlemcr4ut1e0cq90', '80', '2010-08-26 09:27:37', '2010-08-26 09:27:50', '0');
INSERT INTO `sessions` VALUES ('1352', 'ung510joonm9uq9orlemcr4ut1e0cq90', '80', '2010-08-26 09:27:59', '2010-08-26 09:27:59', '0');
INSERT INTO `sessions` VALUES ('1353', 'ung510joonm9uq9orlemcr4ut1e0cq90', '80', '2010-08-26 09:27:59', '2010-08-26 10:20:05', '1');
INSERT INTO `sessions` VALUES ('1354', '4h8p97v10gfdp5kchrphodli30spfcok', '119', '2010-08-26 12:31:17', '2010-08-26 12:31:17', '0');
INSERT INTO `sessions` VALUES ('1355', '4h8p97v10gfdp5kchrphodli30spfcok', '119', '2010-08-26 12:31:17', '2010-08-26 12:31:45', '0');
INSERT INTO `sessions` VALUES ('1356', 'vppo62dk6gv8l67j8g1sv85rt1r7471g', '94', '2010-08-26 15:13:44', '2010-08-26 15:13:52', '1');
INSERT INTO `sessions` VALUES ('1357', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:02', '2010-08-27 10:34:02', '0');
INSERT INTO `sessions` VALUES ('1358', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:02', '2010-08-27 10:34:13', '0');
INSERT INTO `sessions` VALUES ('1359', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:25', '2010-08-27 10:34:25', '0');
INSERT INTO `sessions` VALUES ('1360', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:25', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1361', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1362', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1363', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1364', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1365', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:38', '0');
INSERT INTO `sessions` VALUES ('1366', 'jtfbigmbf334lrlm9porig5pcunb2ct4', '119', '2010-08-27 10:34:38', '2010-08-27 10:34:39', '0');
INSERT INTO `sessions` VALUES ('1367', '01pv2f7q1s33fpq80rt00rchdo6qnavl', '101', '2010-08-30 08:35:22', '2010-08-30 08:35:44', '0');
INSERT INTO `sessions` VALUES ('1368', '01pv2f7q1s33fpq80rt00rchdo6qnavl', '101', '2010-08-30 08:35:44', '2010-08-30 08:35:44', '0');
INSERT INTO `sessions` VALUES ('1369', '01pv2f7q1s33fpq80rt00rchdo6qnavl', '101', '2010-08-30 08:35:44', '2010-08-30 08:35:44', '1');
INSERT INTO `sessions` VALUES ('1370', 'hg74c39tnop63eoeia8fhb1r65h3hll6', '86', '2010-09-02 11:38:45', '2010-09-02 11:38:45', '0');
INSERT INTO `sessions` VALUES ('1371', 'hg74c39tnop63eoeia8fhb1r65h3hll6', '86', '2010-09-02 11:38:45', '2010-09-02 11:38:48', '0');
INSERT INTO `sessions` VALUES ('1372', 'hg74c39tnop63eoeia8fhb1r65h3hll6', '86', '2010-09-02 11:38:48', '2010-09-02 11:38:49', '1');
INSERT INTO `sessions` VALUES ('1373', 'toruhfd71k4tj93l6d6jl98c96onb9fm', '57', '2010-09-03 13:53:44', '2010-09-03 13:53:44', '0');
INSERT INTO `sessions` VALUES ('1374', 'toruhfd71k4tj93l6d6jl98c96onb9fm', '57', '2010-09-03 13:53:44', '2010-09-03 14:02:42', '0');
INSERT INTO `sessions` VALUES ('1375', 'toruhfd71k4tj93l6d6jl98c96onb9fm', '57', '2010-09-03 14:02:42', '2010-09-03 14:02:42', '1');
INSERT INTO `sessions` VALUES ('1376', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 20:09:11', '2010-09-15 20:09:11', '0');
INSERT INTO `sessions` VALUES ('1377', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 20:09:11', '2010-09-15 20:09:29', '0');
INSERT INTO `sessions` VALUES ('1378', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 20:09:29', '2010-09-15 20:24:53', '0');
INSERT INTO `sessions` VALUES ('1379', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 20:24:53', '2010-09-15 20:28:36', '0');
INSERT INTO `sessions` VALUES ('1380', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 20:28:36', '2010-09-15 21:59:20', '0');
INSERT INTO `sessions` VALUES ('1381', 'gc62f69q3nbl3dd7f4lpdmf5lfmmhv82', '127', '2010-09-15 21:59:20', '2010-09-15 21:59:20', '1');
INSERT INTO `sessions` VALUES ('1382', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 13:56:53', '2010-09-16 13:56:53', '0');
INSERT INTO `sessions` VALUES ('1383', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 13:56:53', '2010-09-16 13:57:01', '0');
INSERT INTO `sessions` VALUES ('1384', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 13:57:01', '2010-09-16 13:57:01', '0');
INSERT INTO `sessions` VALUES ('1385', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 13:57:01', '2010-09-16 14:06:13', '0');
INSERT INTO `sessions` VALUES ('1386', 'knuehel1c1rfasmgmn888166rhjk9p2v', '94', '2010-09-16 14:02:22', '2010-09-16 14:02:22', '0');
INSERT INTO `sessions` VALUES ('1387', 'knuehel1c1rfasmgmn888166rhjk9p2v', '94', '2010-09-16 14:02:22', '2010-09-16 14:02:41', '0');
INSERT INTO `sessions` VALUES ('1388', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 14:06:13', '2010-09-16 14:06:35', '0');
INSERT INTO `sessions` VALUES ('1389', '09l87l92b5e9b3348kojc2h4suv9f3s5', '80', '2010-09-16 14:06:35', '2010-09-16 14:06:35', '1');
INSERT INTO `sessions` VALUES ('1390', 'n7vhedj8kf3gbmdahfok7ipns4rs32i1', '55', '2010-09-19 23:57:01', '2010-09-19 23:57:01', '0');
INSERT INTO `sessions` VALUES ('1391', 'n7vhedj8kf3gbmdahfok7ipns4rs32i1', '55', '2010-09-19 23:57:01', '2010-09-19 23:57:01', '1');
INSERT INTO `sessions` VALUES ('1392', 'mr10harlukun9359ab5ned503fsvrau2', '55', '2010-09-22 15:17:12', '2010-09-22 15:17:20', '0');
INSERT INTO `sessions` VALUES ('1393', 'mr10harlukun9359ab5ned503fsvrau2', '55', '2010-09-22 15:17:20', '2010-09-22 15:17:20', '0');
INSERT INTO `sessions` VALUES ('1394', 'mr10harlukun9359ab5ned503fsvrau2', '55', '2010-09-22 15:17:20', '2010-09-22 15:17:43', '0');
INSERT INTO `sessions` VALUES ('1395', 'mr10harlukun9359ab5ned503fsvrau2', '55', '2010-09-22 15:17:43', '2010-09-22 15:18:44', '1');
INSERT INTO `sessions` VALUES ('1396', 'jvoo202e1akjs8ka95igi9bp45ndtbk1', '94', '2010-09-28 11:20:18', '2010-09-28 11:20:18', '0');
INSERT INTO `sessions` VALUES ('1397', 'jvoo202e1akjs8ka95igi9bp45ndtbk1', '94', '2010-09-28 11:20:18', '2010-09-28 11:20:31', '1');
INSERT INTO `sessions` VALUES ('1398', 'd9mqisipdb0qkofj0u8bs1fqa9vb2aoa', '94', '2010-09-29 07:13:34', '2010-09-29 07:13:34', '0');
INSERT INTO `sessions` VALUES ('1399', 'd9mqisipdb0qkofj0u8bs1fqa9vb2aoa', '94', '2010-09-29 07:13:34', '2010-09-29 07:13:36', '0');
INSERT INTO `sessions` VALUES ('1400', 'd9mqisipdb0qkofj0u8bs1fqa9vb2aoa', '94', '2010-09-29 07:13:36', '2010-09-29 07:13:36', '0');
INSERT INTO `sessions` VALUES ('1401', 'd9mqisipdb0qkofj0u8bs1fqa9vb2aoa', '94', '2010-09-29 07:13:36', '2010-09-29 07:14:03', '0');
INSERT INTO `sessions` VALUES ('1402', 'jb3i02m76uk2c7a3u4lo5l343gpkh3du', '80', '2010-09-30 12:32:25', '2010-09-30 12:32:36', '0');
INSERT INTO `sessions` VALUES ('1403', 'jb3i02m76uk2c7a3u4lo5l343gpkh3du', '80', '2010-09-30 12:32:36', '2010-09-30 13:15:14', '0');
INSERT INTO `sessions` VALUES ('1404', 'jb3i02m76uk2c7a3u4lo5l343gpkh3du', '80', '2010-09-30 13:20:07', '2010-09-30 13:20:22', '0');
INSERT INTO `sessions` VALUES ('1405', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:23:36', '2010-09-30 13:23:36', '0');
INSERT INTO `sessions` VALUES ('1406', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:23:36', '2010-09-30 13:23:38', '0');
INSERT INTO `sessions` VALUES ('1407', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:23:38', '2010-09-30 13:41:16', '0');
INSERT INTO `sessions` VALUES ('1408', 'lrcebb8f0o3m0uja998ke92paop1v856', '8', '2010-09-30 13:29:00', '2010-09-30 13:29:00', '1');
INSERT INTO `sessions` VALUES ('1409', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:41:28', '2010-09-30 13:42:01', '0');
INSERT INTO `sessions` VALUES ('1410', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:42:01', '2010-09-30 13:42:26', '0');
INSERT INTO `sessions` VALUES ('1411', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:46:13', '2010-09-30 13:46:18', '0');
INSERT INTO `sessions` VALUES ('1412', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 13:47:03', '2010-09-30 13:47:10', '0');
INSERT INTO `sessions` VALUES ('1413', 'jb3i02m76uk2c7a3u4lo5l343gpkh3du', '80', '2010-09-30 14:04:36', '2010-09-30 14:04:36', '1');
INSERT INTO `sessions` VALUES ('1414', '4psi5hqvmtekluncesuav3b58h7gj25m', '130', '2010-09-30 14:14:18', '2010-09-30 14:14:37', '0');
INSERT INTO `sessions` VALUES ('1415', '4psi5hqvmtekluncesuav3b58h7gj25m', '130', '2010-09-30 14:14:42', '2010-09-30 14:14:52', '0');
INSERT INTO `sessions` VALUES ('1416', 'vad1ud31b19rcmqrp0a3ca96jmb1sa29', '86', '2010-09-30 14:21:37', '2010-09-30 14:21:37', '1');
INSERT INTO `sessions` VALUES ('1417', 'qp8udsoo59b577im2duv3pikj9d49khr', '80', '2010-09-30 17:43:36', '2010-09-30 17:43:48', '1');
INSERT INTO `sessions` VALUES ('1418', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 09:48:33', '2010-10-01 09:48:33', '0');
INSERT INTO `sessions` VALUES ('1419', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 09:48:33', '2010-10-01 09:48:34', '0');
INSERT INTO `sessions` VALUES ('1420', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 09:48:34', '2010-10-01 10:37:52', '0');
INSERT INTO `sessions` VALUES ('1421', '9fv4j5mtn1a8upbq15muh44ccur3d42f', '94', '2010-10-01 10:02:33', '2010-10-01 10:02:41', '0');
INSERT INTO `sessions` VALUES ('1422', 'qog5taf31dsug8asuootnptd7v5q4tji', '80', '2010-10-01 10:08:25', '2010-10-01 10:08:25', '0');
INSERT INTO `sessions` VALUES ('1423', 'qog5taf31dsug8asuootnptd7v5q4tji', '80', '2010-10-01 10:08:25', '2010-10-01 10:08:31', '0');
INSERT INTO `sessions` VALUES ('1424', 'qog5taf31dsug8asuootnptd7v5q4tji', '80', '2010-10-01 10:08:31', '2010-10-01 10:08:53', '0');
INSERT INTO `sessions` VALUES ('1425', 'qtdlbklk3rifhsk6nseo8frl0fmkudqr', '80', '2010-10-01 10:10:15', '2010-10-01 10:10:33', '0');
INSERT INTO `sessions` VALUES ('1426', '9fv4j5mtn1a8upbq15muh44ccur3d42f', '94', '2010-10-01 10:26:01', '2010-10-01 10:26:14', '0');
INSERT INTO `sessions` VALUES ('1427', '9fv4j5mtn1a8upbq15muh44ccur3d42f', '94', '2010-10-01 10:28:13', '2010-10-01 10:28:13', '1');
INSERT INTO `sessions` VALUES ('1428', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 10:37:53', '2010-10-01 10:38:06', '0');
INSERT INTO `sessions` VALUES ('1429', 'i86k93k0247p2rdhv3sb68ft7dna86dv', '86', '2010-10-01 10:40:26', '2010-10-01 10:40:34', '0');
INSERT INTO `sessions` VALUES ('1430', 'i86k93k0247p2rdhv3sb68ft7dna86dv', '86', '2010-10-01 10:41:04', '2010-10-01 10:41:12', '0');
INSERT INTO `sessions` VALUES ('1431', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 10:53:43', '2010-10-01 10:53:58', '0');
INSERT INTO `sessions` VALUES ('1432', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 10:54:37', '2010-10-01 10:55:58', '0');
INSERT INTO `sessions` VALUES ('1433', 'i86k93k0247p2rdhv3sb68ft7dna86dv', '86', '2010-10-01 10:55:14', '2010-10-01 10:55:25', '0');
INSERT INTO `sessions` VALUES ('1434', 'i86k93k0247p2rdhv3sb68ft7dna86dv', '86', '2010-10-01 10:57:57', '2010-10-01 10:58:06', '0');
INSERT INTO `sessions` VALUES ('1435', 'elkthcel8abi4kdj63j42v6dsp4e2suv', '94', '2010-10-01 11:01:17', '2010-10-01 11:01:17', '1');
INSERT INTO `sessions` VALUES ('1436', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 11:09:47', '2010-10-01 11:10:00', '0');
INSERT INTO `sessions` VALUES ('1437', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 11:10:05', '2010-10-01 11:10:08', '0');
INSERT INTO `sessions` VALUES ('1438', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 11:11:00', '2010-10-01 11:11:02', '0');
INSERT INTO `sessions` VALUES ('1439', 'pghvhs8ai23k0ffvuvb46t5otmc8rjc2', '94', '2010-10-01 11:11:18', '2010-10-01 11:11:18', '0');
INSERT INTO `sessions` VALUES ('1440', 'pghvhs8ai23k0ffvuvb46t5otmc8rjc2', '94', '2010-10-01 11:11:18', '2010-10-01 11:11:20', '0');
INSERT INTO `sessions` VALUES ('1441', 'pghvhs8ai23k0ffvuvb46t5otmc8rjc2', '94', '2010-10-01 11:11:20', '2010-10-01 11:11:30', '0');
INSERT INTO `sessions` VALUES ('1442', 'cr2v7umbh636rl4ln2nmdkcnf9jh6l1p', '86', '2010-10-01 11:11:42', '2010-10-01 11:11:42', '1');
INSERT INTO `sessions` VALUES ('1443', 'fqknh1k34ptqvvjsm93bs2mdvodgr5tv', '94', '2010-10-01 11:18:53', '2010-10-01 11:19:40', '0');
INSERT INTO `sessions` VALUES ('1444', 'fqknh1k34ptqvvjsm93bs2mdvodgr5tv', '94', '2010-10-01 11:19:43', '2010-10-01 11:20:58', '0');
INSERT INTO `sessions` VALUES ('1445', '9u9kci0tl5bvtvbmfa5vupigo7d9c0cl', '90', '2010-10-01 13:28:49', '2010-10-01 13:29:38', '1');
INSERT INTO `sessions` VALUES ('1446', 'u2p8usp9m14lkjuegcmpce5b2orbjqg1', '131', '2010-10-04 05:17:55', '2010-10-04 05:18:35', '1');
INSERT INTO `sessions` VALUES ('1447', 'g7qboeuv5b2c8gvccl4ne0l3sbsadvb4', '86', '2010-10-04 10:52:55', '2010-10-04 10:52:55', '0');
INSERT INTO `sessions` VALUES ('1448', 'g7qboeuv5b2c8gvccl4ne0l3sbsadvb4', '86', '2010-10-04 10:52:55', '2010-10-04 10:52:56', '0');
INSERT INTO `sessions` VALUES ('1449', 'g7qboeuv5b2c8gvccl4ne0l3sbsadvb4', '86', '2010-10-04 10:52:56', '2010-10-04 10:53:31', '0');
INSERT INTO `sessions` VALUES ('1450', '2tqhm863tb35mr3kh1cuu1vo2krv5dd5', '57', '2010-10-04 11:12:30', '2010-10-04 11:12:30', '1');
INSERT INTO `sessions` VALUES ('1451', 'brovj3uagfu9bsap09tjlan4q09bd7ee', '127', '2010-10-04 11:56:30', '2010-10-04 15:48:59', '0');
INSERT INTO `sessions` VALUES ('1452', '2vieumktn95q1sh20dlnu1md61dgrl4s', '127', '2010-10-04 16:02:20', '2010-10-04 16:14:04', '1');
INSERT INTO `sessions` VALUES ('1453', 'sdodivog4oj310u0l8p0rj162hlaqc6u', '55', '2010-10-05 05:29:53', '2010-10-05 05:30:00', '0');
INSERT INTO `sessions` VALUES ('1454', 'sdodivog4oj310u0l8p0rj162hlaqc6u', '55', '2010-10-05 05:30:00', '2010-10-05 05:38:34', '1');
INSERT INTO `sessions` VALUES ('1455', 'r1ho13mbm3u2lmutgcsm8l0ruos68q3l', '90', '2010-10-05 13:02:22', '2010-10-05 13:02:22', '0');
INSERT INTO `sessions` VALUES ('1456', 'r1ho13mbm3u2lmutgcsm8l0ruos68q3l', '90', '2010-10-05 13:02:22', '2010-10-05 13:02:23', '0');
INSERT INTO `sessions` VALUES ('1457', 'r1ho13mbm3u2lmutgcsm8l0ruos68q3l', '90', '2010-10-05 13:02:23', '2010-10-05 13:02:32', '1');
INSERT INTO `sessions` VALUES ('1458', '493gn9tqnsm123vbvb0bjopd94jqegdn', '8', '2010-10-05 15:08:29', '2010-10-05 15:12:22', '0');
INSERT INTO `sessions` VALUES ('1459', '493gn9tqnsm123vbvb0bjopd94jqegdn', '8', '2010-10-05 15:12:22', '2010-10-05 15:14:35', '0');
INSERT INTO `sessions` VALUES ('1460', '493gn9tqnsm123vbvb0bjopd94jqegdn', '8', '2010-10-05 17:16:51', '2010-10-05 17:17:08', '0');
INSERT INTO `sessions` VALUES ('1461', '493gn9tqnsm123vbvb0bjopd94jqegdn', '8', '2010-10-05 17:32:40', '2010-10-05 17:35:11', '0');
INSERT INTO `sessions` VALUES ('1462', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:37:16', '2010-10-05 17:38:02', '0');
INSERT INTO `sessions` VALUES ('1463', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:38:02', '2010-10-05 17:38:24', '0');
INSERT INTO `sessions` VALUES ('1464', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:38:24', '2010-10-05 17:40:25', '0');
INSERT INTO `sessions` VALUES ('1465', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:42:33', '2010-10-05 17:42:48', '0');
INSERT INTO `sessions` VALUES ('1466', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:42:48', '2010-10-05 17:43:07', '0');
INSERT INTO `sessions` VALUES ('1467', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-05 17:44:00', '2010-10-05 17:44:00', '0');
INSERT INTO `sessions` VALUES ('1468', 's6c0eago03m16kugoh39r9o3l49oq6on', '127', '2010-10-06 10:32:35', '2010-10-06 10:32:35', '0');
INSERT INTO `sessions` VALUES ('1469', 's6c0eago03m16kugoh39r9o3l49oq6on', '127', '2010-10-06 10:32:35', '2010-10-06 10:32:37', '0');
INSERT INTO `sessions` VALUES ('1470', 's6c0eago03m16kugoh39r9o3l49oq6on', '127', '2010-10-06 10:32:37', '2010-10-06 13:28:15', '1');
INSERT INTO `sessions` VALUES ('1471', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-06 17:21:16', '2010-10-06 17:21:16', '0');
INSERT INTO `sessions` VALUES ('1472', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-06 17:21:16', '2010-10-06 17:23:04', '0');
INSERT INTO `sessions` VALUES ('1473', '493gn9tqnsm123vbvb0bjopd94jqegdn', '99', '2010-10-06 17:23:04', '2010-10-07 16:46:06', '1');
INSERT INTO `sessions` VALUES ('1474', '46odh1l8v13oitalhrd5ih752qbqa129', '80', '2010-10-07 11:56:14', '2010-10-07 11:56:51', '0');
INSERT INTO `sessions` VALUES ('1475', '46odh1l8v13oitalhrd5ih752qbqa129', '80', '2010-10-07 11:56:51', '2010-10-07 11:56:51', '1');
INSERT INTO `sessions` VALUES ('1476', 'p59cbc4afni8k1jifb2201ul5n4r13p6', '8', '2010-10-07 15:24:22', '2010-10-07 15:24:22', '0');
INSERT INTO `sessions` VALUES ('1477', 'p59cbc4afni8k1jifb2201ul5n4r13p6', '8', '2010-10-07 15:24:22', '2010-10-07 15:24:33', '0');
INSERT INTO `sessions` VALUES ('1478', 'p59cbc4afni8k1jifb2201ul5n4r13p6', '8', '2010-10-07 15:24:33', '2010-10-07 17:18:33', '1');
INSERT INTO `sessions` VALUES ('1479', '258bb5h4nsupig3b37fd9mg67qlcdjc8', '57', '2010-10-08 07:46:29', '2010-10-08 07:46:29', '0');
INSERT INTO `sessions` VALUES ('1480', '258bb5h4nsupig3b37fd9mg67qlcdjc8', '57', '2010-10-08 07:46:29', '2010-10-08 07:46:32', '0');
INSERT INTO `sessions` VALUES ('1481', '258bb5h4nsupig3b37fd9mg67qlcdjc8', '57', '2010-10-08 07:46:32', '2010-10-08 07:46:32', '1');
INSERT INTO `sessions` VALUES ('1482', 'ku2qvcfe3oc1id0thupr9ii7punqg28e', '100', '2010-10-08 09:09:28', '2010-10-08 09:36:12', '1');
INSERT INTO `sessions` VALUES ('1483', 'hsra7d4kighkf39lkrp2qp8eok167rm0', '80', '2010-10-08 09:20:40', '2010-10-08 09:21:51', '0');
INSERT INTO `sessions` VALUES ('1484', 'hsra7d4kighkf39lkrp2qp8eok167rm0', '80', '2010-10-08 09:21:51', '2010-10-08 13:42:05', '0');
INSERT INTO `sessions` VALUES ('1485', 'k1ljnfri2to47ii05h5asff93mbj2027', '8', '2010-10-09 20:37:01', '2010-10-10 07:51:12', '0');
INSERT INTO `sessions` VALUES ('1486', 'k1ljnfri2to47ii05h5asff93mbj2027', '99', '2010-10-10 07:51:49', '2010-10-10 07:52:18', '0');
INSERT INTO `sessions` VALUES ('1487', 'k1ljnfri2to47ii05h5asff93mbj2027', '99', '2010-10-10 07:52:28', '2010-10-10 07:52:28', '1');
INSERT INTO `sessions` VALUES ('1488', 'qplevc4tg4ppjjalt36fs7qd956j0jle', '99', '2010-10-10 07:59:20', '2010-10-10 07:59:28', '0');
INSERT INTO `sessions` VALUES ('1489', 'dml8okc5e8llf7jgtht5n57icopijv8u', '100', '2010-10-10 08:34:20', '2010-10-10 08:34:20', '0');
INSERT INTO `sessions` VALUES ('1490', 'dml8okc5e8llf7jgtht5n57icopijv8u', '100', '2010-10-10 09:55:27', '2010-10-10 09:55:27', '0');
INSERT INTO `sessions` VALUES ('1491', 'dml8okc5e8llf7jgtht5n57icopijv8u', '100', '2010-10-10 09:55:27', '2010-10-10 09:55:30', '0');
INSERT INTO `sessions` VALUES ('1492', 'dml8okc5e8llf7jgtht5n57icopijv8u', '100', '2010-10-10 09:55:30', '2010-10-10 11:27:27', '1');
INSERT INTO `sessions` VALUES ('1493', 'u8k8qn7ujkit5695ihaje4cjsu741hm0', '138', '2010-10-10 10:02:41', '2010-10-10 11:27:15', '1');
INSERT INTO `sessions` VALUES ('1494', 'v22j3um92qihanqfg2gv9kim4bjkk3fm', '140', '2010-10-10 10:14:12', '2010-10-10 10:14:54', '0');
INSERT INTO `sessions` VALUES ('1495', 'eoomem76h3p5kqsqe61a9fbaolmlggh8', '134', '2010-10-10 10:19:32', '2010-10-10 11:20:55', '1');
INSERT INTO `sessions` VALUES ('1496', 'v22j3um92qihanqfg2gv9kim4bjkk3fm', '140', '2010-10-10 10:20:43', '2010-10-10 10:24:02', '1');
INSERT INTO `sessions` VALUES ('1497', '50rggof11v39e5rqen0qg1e1d70a6e5k', '139', '2010-10-10 10:20:45', '2010-10-10 11:26:52', '0');
INSERT INTO `sessions` VALUES ('1498', 'fvmisldprr7aejgb5411me62no79n0nr', '136', '2010-10-10 10:21:56', '2010-10-10 11:36:30', '1');
INSERT INTO `sessions` VALUES ('1499', '1me0tbnu5qhpunrdvd17e3741lrdmuc1', '137', '2010-10-10 10:23:39', '2010-10-10 11:09:15', '1');
INSERT INTO `sessions` VALUES ('1500', 'hk6uk3v99in4ivalnej9r9ifqa3q1o5q', '135', '2010-10-10 10:38:08', '2010-10-10 11:26:54', '1');
INSERT INTO `sessions` VALUES ('1501', 'c5n5u4rtujlarseh6pdksr4sv7n30scc', '140', '2010-10-10 10:53:59', '2010-10-10 11:41:41', '1');
INSERT INTO `sessions` VALUES ('1502', 'e6f0r97ks66hu5d5tl9ivuiq45gda2sv', '137', '2010-10-10 11:16:52', '2010-10-10 11:16:52', '0');
INSERT INTO `sessions` VALUES ('1503', 'e6f0r97ks66hu5d5tl9ivuiq45gda2sv', '137', '2010-10-10 11:16:52', '2010-10-10 11:17:02', '0');
INSERT INTO `sessions` VALUES ('1504', 'e6f0r97ks66hu5d5tl9ivuiq45gda2sv', '137', '2010-10-10 11:17:02', '2010-10-10 11:22:11', '1');
INSERT INTO `sessions` VALUES ('1505', 'cj0oo1404l7lhrpvcfph6kuqr4rj1hl0', '55', '2010-10-10 19:08:08', '2010-10-10 19:08:08', '0');
INSERT INTO `sessions` VALUES ('1506', 'cj0oo1404l7lhrpvcfph6kuqr4rj1hl0', '55', '2010-10-10 19:08:08', '2010-10-10 19:08:08', '1');
INSERT INTO `sessions` VALUES ('1507', 'qplevc4tg4ppjjalt36fs7qd956j0jle', '99', '2010-10-11 07:59:26', '2010-10-11 07:59:36', '1');
INSERT INTO `sessions` VALUES ('1508', 'qplevc4tg4ppjjalt36fs7qd956j0jle', '8', '2010-10-11 07:59:36', '2010-10-11 08:05:13', '1');
INSERT INTO `sessions` VALUES ('1509', '50rggof11v39e5rqen0qg1e1d70a6e5k', '139', '2010-10-12 06:17:05', '2010-10-12 06:17:05', '0');
INSERT INTO `sessions` VALUES ('1510', 'q2s2kudgge2tkrptl4t4utsl101c2drv', '80', '2010-10-13 14:28:57', '2010-10-13 14:28:57', '1');
INSERT INTO `sessions` VALUES ('1511', 'ein9c7eqa8crkd6qc3tsihqg18h9urgg', '57', '2010-10-18 12:18:35', '2010-10-18 12:18:35', '1');
INSERT INTO `sessions` VALUES ('1512', 't7otfhmsal343q4dcdqkke6divqlmmu0', '80', '2010-10-19 12:44:54', '2010-10-19 12:44:54', '0');
INSERT INTO `sessions` VALUES ('1513', 't7otfhmsal343q4dcdqkke6divqlmmu0', '80', '2010-10-19 12:44:54', '2010-10-19 12:45:04', '0');
INSERT INTO `sessions` VALUES ('1514', 't7otfhmsal343q4dcdqkke6divqlmmu0', '80', '2010-10-19 12:45:11', '2010-10-19 12:45:11', '1');
INSERT INTO `sessions` VALUES ('1515', 'e8bovnpr1j51afo8rcutel0l8517db9f', '80', '2010-10-21 12:02:22', '2010-10-21 12:02:22', '0');
INSERT INTO `sessions` VALUES ('1516', 'e8bovnpr1j51afo8rcutel0l8517db9f', '80', '2010-10-21 12:02:22', '2010-10-21 12:02:36', '0');
INSERT INTO `sessions` VALUES ('1517', 'e8bovnpr1j51afo8rcutel0l8517db9f', '80', '2010-10-21 12:02:36', '2010-10-21 12:02:36', '1');
INSERT INTO `sessions` VALUES ('1518', 'cs3i877npih9bjfnhkjjs40v9tdkf8t7', '80', '2010-10-21 15:05:53', '2010-10-21 15:05:53', '0');
INSERT INTO `sessions` VALUES ('1519', 'cs3i877npih9bjfnhkjjs40v9tdkf8t7', '80', '2010-10-21 15:05:53', '2010-10-21 15:06:03', '0');
INSERT INTO `sessions` VALUES ('1520', 'cs3i877npih9bjfnhkjjs40v9tdkf8t7', '80', '2010-10-21 15:06:17', '2010-10-21 15:06:32', '1');
INSERT INTO `sessions` VALUES ('1521', '3pj508e0p8h5epigu8f71fup1vo3jb6u', '100', '2010-10-21 15:35:12', '2010-10-21 15:35:12', '0');
INSERT INTO `sessions` VALUES ('1522', '3pj508e0p8h5epigu8f71fup1vo3jb6u', '100', '2010-10-21 15:35:12', '2010-10-21 15:35:13', '0');
INSERT INTO `sessions` VALUES ('1523', '3pj508e0p8h5epigu8f71fup1vo3jb6u', '100', '2010-10-21 15:35:13', '2010-10-21 15:35:13', '1');
INSERT INTO `sessions` VALUES ('1524', 'hd9opi38h4eb4bnsckrhasa5p7a01327', '100', '2010-10-22 11:49:09', '2010-10-22 11:49:09', '0');
INSERT INTO `sessions` VALUES ('1525', 'hd9opi38h4eb4bnsckrhasa5p7a01327', '100', '2010-10-22 11:49:17', '2010-10-22 12:09:00', '1');
INSERT INTO `sessions` VALUES ('1526', 'jb6ksj07ul4mts2egjt5p7c3togkf6lc', '80', '2010-10-24 19:39:09', '2010-10-24 19:39:09', '0');
INSERT INTO `sessions` VALUES ('1527', 'jb6ksj07ul4mts2egjt5p7c3togkf6lc', '80', '2010-10-24 19:39:09', '2010-10-24 19:39:23', '0');
INSERT INTO `sessions` VALUES ('1528', 'jb6ksj07ul4mts2egjt5p7c3togkf6lc', '80', '2010-10-24 19:39:32', '2010-10-24 19:50:10', '0');
INSERT INTO `sessions` VALUES ('1529', 'jb6ksj07ul4mts2egjt5p7c3togkf6lc', '80', '2010-10-24 22:49:41', '2010-10-24 22:49:41', '1');
INSERT INTO `sessions` VALUES ('1530', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-25 11:10:03', '2010-10-25 12:08:37', '0');
INSERT INTO `sessions` VALUES ('1531', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-25 12:09:05', '2010-10-25 12:09:05', '0');
INSERT INTO `sessions` VALUES ('1532', '1ua40osvfhv5ealc6n4ithcc9a893qev', '80', '2010-10-25 15:05:13', '2010-10-25 15:05:13', '0');
INSERT INTO `sessions` VALUES ('1533', '1ua40osvfhv5ealc6n4ithcc9a893qev', '80', '2010-10-25 15:05:13', '2010-10-25 15:05:21', '0');
INSERT INTO `sessions` VALUES ('1534', '1ua40osvfhv5ealc6n4ithcc9a893qev', '80', '2010-10-25 15:05:21', '2010-10-25 15:09:42', '1');
INSERT INTO `sessions` VALUES ('1535', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-26 14:14:02', '2010-10-26 14:14:02', '0');
INSERT INTO `sessions` VALUES ('1536', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-26 14:14:02', '2010-10-26 14:14:02', '0');
INSERT INTO `sessions` VALUES ('1537', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-27 09:25:00', '2010-10-27 09:25:00', '0');
INSERT INTO `sessions` VALUES ('1538', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-27 09:25:00', '2010-10-27 09:25:00', '0');
INSERT INTO `sessions` VALUES ('1539', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-27 09:25:00', '2010-10-27 09:25:05', '0');
INSERT INTO `sessions` VALUES ('1540', 'r2ijs89a6dka76439psrq5dv3ess44hp', '116', '2010-10-27 09:25:05', '2010-10-27 09:25:05', '1');
INSERT INTO `sessions` VALUES ('1541', 'v5a7u7t44eo8l1oupa9su7bqup2jre81', '136', '2010-10-27 16:29:39', '2010-10-27 16:29:40', '1');
INSERT INTO `sessions` VALUES ('1542', '54u6hrdfa7mqaf0ls8v6vebqk2atm6vb', '8', '2010-10-29 08:32:25', '2010-10-29 08:32:25', '0');
INSERT INTO `sessions` VALUES ('1543', '54u6hrdfa7mqaf0ls8v6vebqk2atm6vb', '8', '2010-10-29 08:32:25', '2010-10-29 08:32:25', '1');
INSERT INTO `sessions` VALUES ('1544', 'k13enao37brt513mom78olap9j7dv88r', '142', '2010-10-29 10:33:59', '2010-10-29 11:57:10', '0');
INSERT INTO `sessions` VALUES ('1545', 'pgfvutahr9isqf2mo9lb13p8sj7bf55e', '143', '2010-10-29 10:34:12', '2010-10-29 12:00:27', '0');
INSERT INTO `sessions` VALUES ('1546', 'tslo063okmat0rnmnk144ivcmh40evjg', '145', '2010-10-29 10:34:56', '2010-10-29 11:28:49', '1');
INSERT INTO `sessions` VALUES ('1547', 'ru2j6c9ok5e7k4mlklm2qoceam40au9v', '144', '2010-10-29 10:35:20', '2010-10-29 11:59:06', '0');
INSERT INTO `sessions` VALUES ('1548', 'bbulh5k806em5jtq4e1tbvt8rgd75pp1', '55', '2010-10-31 14:07:37', '2010-10-31 14:07:37', '0');
INSERT INTO `sessions` VALUES ('1549', 'bbulh5k806em5jtq4e1tbvt8rgd75pp1', '55', '2010-10-31 14:07:37', '2010-10-31 14:07:37', '1');
INSERT INTO `sessions` VALUES ('1550', 'rdmgte5k7h9vb31orde8a93ivs8hgmfi', '8', '2010-11-01 17:43:15', '2010-11-01 17:49:27', '1');
INSERT INTO `sessions` VALUES ('1551', '16pemktlk07nd9ulfu6llhfkgadvfevl', '8', '2010-11-02 08:33:32', '2010-11-02 08:33:32', '0');
INSERT INTO `sessions` VALUES ('1552', '16pemktlk07nd9ulfu6llhfkgadvfevl', '8', '2010-11-02 08:33:32', '2010-11-02 08:33:41', '0');
INSERT INTO `sessions` VALUES ('1553', '16pemktlk07nd9ulfu6llhfkgadvfevl', '8', '2010-11-02 08:33:41', '2010-11-02 08:33:53', '1');
INSERT INTO `sessions` VALUES ('1554', '05n1pp1v0v6odsgm68kc2bfn9o2frqs0', '90', '2010-11-02 12:52:49', '2010-11-02 12:53:01', '1');
INSERT INTO `sessions` VALUES ('1555', 'h1jeihmrq6l21tjsnpje95a355r3955c', '80', '2010-11-03 12:37:01', '2010-11-03 12:37:01', '0');
INSERT INTO `sessions` VALUES ('1556', 'h1jeihmrq6l21tjsnpje95a355r3955c', '80', '2010-11-03 12:37:01', '2010-11-03 12:37:05', '0');
INSERT INTO `sessions` VALUES ('1557', 'h1jeihmrq6l21tjsnpje95a355r3955c', '80', '2010-11-03 12:37:22', '2010-11-03 12:37:22', '1');
INSERT INTO `sessions` VALUES ('1558', 'gqplcc2k2g7aq2ss1p8kqc1a5ql7jc7f', '90', '2010-11-05 13:48:03', '2010-11-05 13:48:03', '0');
INSERT INTO `sessions` VALUES ('1559', 'gqplcc2k2g7aq2ss1p8kqc1a5ql7jc7f', '90', '2010-11-05 13:48:03', '2010-11-05 13:48:05', '0');
INSERT INTO `sessions` VALUES ('1560', 'gqplcc2k2g7aq2ss1p8kqc1a5ql7jc7f', '90', '2010-11-05 13:48:05', '2010-11-05 14:17:04', '0');
INSERT INTO `sessions` VALUES ('1561', 'gqplcc2k2g7aq2ss1p8kqc1a5ql7jc7f', '90', '2010-11-05 14:17:04', '2010-11-05 14:26:45', '1');
INSERT INTO `sessions` VALUES ('1562', 'jsn6gu88dqobhvpgh99t8f3ktlp1lmb9', '146', '2010-11-07 15:36:54', '2010-11-07 16:07:22', '0');
INSERT INTO `sessions` VALUES ('1563', 'jsn6gu88dqobhvpgh99t8f3ktlp1lmb9', '146', '2010-11-07 16:07:22', '2010-11-07 16:07:22', '1');
INSERT INTO `sessions` VALUES ('1564', 'p143t8pnq7blriq76r5v969j2ui0rbh3', '147', '2010-11-10 15:18:12', '2010-11-10 15:34:27', '0');
INSERT INTO `sessions` VALUES ('1565', 'p143t8pnq7blriq76r5v969j2ui0rbh3', '147', '2010-11-11 09:38:25', '2010-11-11 15:23:02', '0');
INSERT INTO `sessions` VALUES ('1566', '7r6tctnspp1nodahih3jj1sa8irl54n7', '86', '2010-11-11 09:47:22', '2010-11-11 15:57:16', '0');
INSERT INTO `sessions` VALUES ('1567', '7r6tctnspp1nodahih3jj1sa8irl54n7', '86', '2010-11-11 17:33:37', '2010-11-11 17:33:37', '1');
INSERT INTO `sessions` VALUES ('1568', 'hnmlq7bjbe7d89p2a560rukqoakldpch', '86', '2010-11-12 17:20:35', '2010-11-12 17:20:35', '0');
INSERT INTO `sessions` VALUES ('1569', 'hnmlq7bjbe7d89p2a560rukqoakldpch', '86', '2010-11-12 17:20:35', '2010-11-12 17:20:36', '0');
INSERT INTO `sessions` VALUES ('1570', 'hnmlq7bjbe7d89p2a560rukqoakldpch', '86', '2010-11-12 17:20:36', '2010-11-12 18:22:53', '1');
INSERT INTO `sessions` VALUES ('1571', '16458k3koo31499qc2onisujd9psg97c', '55', '2010-11-12 17:40:53', '2010-11-12 17:41:08', '1');
INSERT INTO `sessions` VALUES ('1572', 's98ga775cndofmbkb39olfiu9toeqlf3', '86', '2010-11-15 10:34:08', '2010-11-15 10:34:08', '0');
INSERT INTO `sessions` VALUES ('1573', 's98ga775cndofmbkb39olfiu9toeqlf3', '86', '2010-11-15 10:34:08', '2010-11-15 10:34:25', '0');
INSERT INTO `sessions` VALUES ('1574', 's98ga775cndofmbkb39olfiu9toeqlf3', '86', '2010-11-15 10:34:45', '2010-11-15 11:31:50', '1');
INSERT INTO `sessions` VALUES ('1575', 'p6nh8vbfm1cv6m2r0cn92nc47n10t34m', '124', '2010-11-15 11:25:04', '2010-11-15 11:25:54', '0');
INSERT INTO `sessions` VALUES ('1576', 'p6nh8vbfm1cv6m2r0cn92nc47n10t34m', '124', '2010-11-15 11:25:54', '2010-11-15 11:27:36', '1');
INSERT INTO `sessions` VALUES ('1577', '4vdfrhdgtlig8i9dsa6s5tci8pc0e7sc', '86', '2010-11-15 12:37:26', '2010-11-15 12:37:26', '0');
INSERT INTO `sessions` VALUES ('1578', '4vdfrhdgtlig8i9dsa6s5tci8pc0e7sc', '86', '2010-11-15 12:37:26', '2010-11-15 12:37:27', '0');
INSERT INTO `sessions` VALUES ('1579', '4vdfrhdgtlig8i9dsa6s5tci8pc0e7sc', '86', '2010-11-15 12:37:27', '2010-11-15 12:37:27', '1');
INSERT INTO `sessions` VALUES ('1580', 'bhgj1euqte3afk91p27gc9gnci4obksi', '81', '2010-11-17 10:52:08', '2010-11-17 11:34:53', '1');
INSERT INTO `sessions` VALUES ('1581', '7tdsumt64fotenvo6pivlcbpodo4vjsr', '86', '2010-11-17 12:43:46', '2010-11-17 12:43:46', '0');
INSERT INTO `sessions` VALUES ('1582', '7tdsumt64fotenvo6pivlcbpodo4vjsr', '86', '2010-11-17 12:43:46', '2010-11-17 13:19:03', '0');
INSERT INTO `sessions` VALUES ('1583', '7tdsumt64fotenvo6pivlcbpodo4vjsr', '86', '2010-11-17 13:19:03', '2010-11-17 13:19:12', '1');
INSERT INTO `sessions` VALUES ('1584', '98trd4l0ambqb5kobn5aakcdmo6fqob3', '86', '2010-11-17 14:56:19', '2010-11-17 14:56:19', '0');
INSERT INTO `sessions` VALUES ('1585', '98trd4l0ambqb5kobn5aakcdmo6fqob3', '86', '2010-11-17 14:56:19', '2010-11-17 14:56:20', '0');
INSERT INTO `sessions` VALUES ('1586', '98trd4l0ambqb5kobn5aakcdmo6fqob3', '86', '2010-11-17 14:56:20', '2010-11-17 15:58:46', '1');
INSERT INTO `sessions` VALUES ('1587', 'tp3ob03f086jst7ai97ee447c6b3avq3', '86', '2010-11-18 09:57:40', '2010-11-18 09:57:40', '0');
INSERT INTO `sessions` VALUES ('1588', 'tp3ob03f086jst7ai97ee447c6b3avq3', '86', '2010-11-18 09:57:40', '2010-11-18 09:57:43', '0');
INSERT INTO `sessions` VALUES ('1589', 'tp3ob03f086jst7ai97ee447c6b3avq3', '86', '2010-11-18 09:57:43', '2010-11-18 12:09:25', '0');
INSERT INTO `sessions` VALUES ('1590', 'k302gb1h5mgvgu1jtv75aivpb1383ff1', '81', '2010-11-18 10:14:08', '2010-11-18 10:14:08', '0');
INSERT INTO `sessions` VALUES ('1591', 'k302gb1h5mgvgu1jtv75aivpb1383ff1', '81', '2010-11-18 10:14:08', '2010-11-18 10:14:16', '0');
INSERT INTO `sessions` VALUES ('1592', 'k302gb1h5mgvgu1jtv75aivpb1383ff1', '81', '2010-11-18 10:14:16', '2010-11-18 10:14:22', '1');
INSERT INTO `sessions` VALUES ('1593', 'k302gb1h5mgvgu1jtv75aivpb1383ff1', '8', '2010-11-18 10:14:22', '2010-11-18 10:20:26', '1');
INSERT INTO `sessions` VALUES ('1594', 'ehoo2l57lbuj0bd24svoc9t4c1jrfp8r', '86', '2010-11-19 13:46:57', '2010-11-19 13:48:24', '1');
INSERT INTO `sessions` VALUES ('1595', '1giahoncbkbh8bipt7d92rih76sdsh7d', '8', '2010-11-22 13:23:45', '2010-11-22 13:23:45', '0');
INSERT INTO `sessions` VALUES ('1596', '1giahoncbkbh8bipt7d92rih76sdsh7d', '8', '2010-11-22 13:23:45', '2010-11-22 13:24:38', '0');
INSERT INTO `sessions` VALUES ('1597', '1giahoncbkbh8bipt7d92rih76sdsh7d', '81', '2010-11-22 13:28:54', '2010-11-22 13:48:13', '0');
INSERT INTO `sessions` VALUES ('1598', 'rgmecrc74cgv2fe03q1uul75ahp0lrkm', '86', '2010-11-23 17:17:38', '2010-11-23 17:17:38', '0');
INSERT INTO `sessions` VALUES ('1599', 'rgmecrc74cgv2fe03q1uul75ahp0lrkm', '86', '2010-11-23 17:17:38', '2010-11-23 17:17:39', '0');
INSERT INTO `sessions` VALUES ('1600', 'rgmecrc74cgv2fe03q1uul75ahp0lrkm', '86', '2010-11-23 17:17:39', '2010-11-23 17:17:39', '1');
INSERT INTO `sessions` VALUES ('1601', '7v5hgvp0ps5r9bsvhhbkbkl40ef1m6hk', '86', '2010-11-26 13:50:37', '2010-11-26 13:50:37', '0');
INSERT INTO `sessions` VALUES ('1602', '7v5hgvp0ps5r9bsvhhbkbkl40ef1m6hk', '86', '2010-11-26 13:50:37', '2010-11-26 13:50:40', '0');
INSERT INTO `sessions` VALUES ('1603', '7v5hgvp0ps5r9bsvhhbkbkl40ef1m6hk', '86', '2010-11-26 13:50:40', '2010-11-26 13:50:40', '1');
INSERT INTO `sessions` VALUES ('1604', '11ggi2rndolhnv732p2bpj5flm1fv5ai', '86', '2010-11-29 09:36:57', '2010-11-29 09:36:57', '0');
INSERT INTO `sessions` VALUES ('1605', '11ggi2rndolhnv732p2bpj5flm1fv5ai', '86', '2010-11-29 09:36:57', '2010-11-29 09:36:59', '0');
INSERT INTO `sessions` VALUES ('1606', '11ggi2rndolhnv732p2bpj5flm1fv5ai', '86', '2010-11-29 09:36:59', '2010-11-29 10:12:11', '1');
INSERT INTO `sessions` VALUES ('1607', 'g3dv1cbg8ja301n74t60jd3rf29pg2h9', '100', '2010-11-29 09:49:14', '2010-11-29 10:48:12', '1');
INSERT INTO `sessions` VALUES ('1608', 'd973pkbc04qpuktcg45jj6lv70v7kct8', '80', '2010-11-29 10:23:51', '2010-11-29 14:30:41', '0');
INSERT INTO `sessions` VALUES ('1609', 'rgi56umfv7532cbssm1jjekqab8aivoe', '8', '2010-11-29 11:53:50', '2010-11-29 11:53:59', '1');
INSERT INTO `sessions` VALUES ('1610', 'l836o2drsmob3mc9nb1hh444inov4rfe', '8', '2010-11-29 12:39:07', '2010-11-29 12:40:52', '1');
INSERT INTO `sessions` VALUES ('1611', 'd973pkbc04qpuktcg45jj6lv70v7kct8', '80', '2010-11-29 14:31:19', '2010-11-29 14:38:29', '0');
INSERT INTO `sessions` VALUES ('1612', 'mlfn1e4bhbjbik85161g9vuj0anorim1', '8', '2010-11-29 15:11:08', '2010-11-29 15:11:08', '0');
INSERT INTO `sessions` VALUES ('1613', 'mlfn1e4bhbjbik85161g9vuj0anorim1', '8', '2010-11-29 15:11:08', '2010-11-30 12:32:03', '1');
INSERT INTO `sessions` VALUES ('1614', 'ovfs7ivqmdfpkrm4j0o7e1u7hns49f7d', '55', '2010-11-29 15:37:17', '2010-11-29 15:37:38', '1');
INSERT INTO `sessions` VALUES ('1615', 'ieldsp3spf2q6k7qben9t2k541m42meg', '86', '2010-11-29 17:15:39', '2010-11-29 17:15:39', '0');
INSERT INTO `sessions` VALUES ('1616', 'ieldsp3spf2q6k7qben9t2k541m42meg', '86', '2010-11-29 17:15:39', '2010-11-29 17:15:40', '0');
INSERT INTO `sessions` VALUES ('1617', 'ieldsp3spf2q6k7qben9t2k541m42meg', '86', '2010-11-29 17:15:40', '2010-11-29 17:19:39', '1');
INSERT INTO `sessions` VALUES ('1618', 'tv7bl7b5qf7c9o6qp23jl1os605uumtl', '149', '2010-12-01 10:00:10', '2010-12-01 11:15:34', '1');
INSERT INTO `sessions` VALUES ('1619', 'rjip2cs5ggpjrfda32uf8s9ieo2ffu32', '86', '2010-12-06 15:38:29', '2010-12-06 15:38:29', '0');
INSERT INTO `sessions` VALUES ('1620', 'rjip2cs5ggpjrfda32uf8s9ieo2ffu32', '86', '2010-12-06 15:38:29', '2010-12-06 15:38:31', '0');
INSERT INTO `sessions` VALUES ('1621', 'rjip2cs5ggpjrfda32uf8s9ieo2ffu32', '86', '2010-12-06 15:38:31', '2010-12-06 15:38:33', '1');
INSERT INTO `sessions` VALUES ('1622', 'lbmm7v4634npabga52ik0v0k6bpi489o', '86', '2010-12-07 14:44:53', '2010-12-07 14:44:53', '0');
INSERT INTO `sessions` VALUES ('1623', 'lbmm7v4634npabga52ik0v0k6bpi489o', '86', '2010-12-07 14:44:53', '2010-12-07 14:44:54', '0');
INSERT INTO `sessions` VALUES ('1624', 'lbmm7v4634npabga52ik0v0k6bpi489o', '86', '2010-12-07 14:44:54', '2010-12-07 14:57:16', '1');
INSERT INTO `sessions` VALUES ('1625', 'l6cnhtcolu2vnijj8bighe6udkhb7un2', '86', '2010-12-08 11:16:30', '2010-12-08 11:16:30', '0');
INSERT INTO `sessions` VALUES ('1626', 'l6cnhtcolu2vnijj8bighe6udkhb7un2', '86', '2010-12-08 11:16:30', '2010-12-08 11:16:30', '0');
INSERT INTO `sessions` VALUES ('1627', 'l6cnhtcolu2vnijj8bighe6udkhb7un2', '86', '2010-12-08 11:16:30', '2010-12-08 11:16:30', '0');
INSERT INTO `sessions` VALUES ('1628', 'l6cnhtcolu2vnijj8bighe6udkhb7un2', '86', '2010-12-08 11:16:30', '2010-12-08 11:16:32', '1');
INSERT INTO `sessions` VALUES ('1629', '48o4umgst864hq5j4ihailnhs88v01cl', '8', '2010-12-08 22:09:27', '2010-12-08 22:09:27', '0');
INSERT INTO `sessions` VALUES ('1630', '48o4umgst864hq5j4ihailnhs88v01cl', '8', '2010-12-08 22:09:28', '2010-12-08 22:09:36', '0');
INSERT INTO `sessions` VALUES ('1631', '48o4umgst864hq5j4ihailnhs88v01cl', '8', '2010-12-08 22:09:36', '2010-12-08 22:09:36', '1');
INSERT INTO `sessions` VALUES ('1632', 'pe9mh7i8a4td1udrccp3fbfq5m6vb6iu', '86', '2010-12-10 11:24:13', '2010-12-10 11:24:13', '0');
INSERT INTO `sessions` VALUES ('1633', 'pe9mh7i8a4td1udrccp3fbfq5m6vb6iu', '86', '2010-12-10 11:24:13', '2010-12-10 11:24:14', '0');
INSERT INTO `sessions` VALUES ('1634', 'pe9mh7i8a4td1udrccp3fbfq5m6vb6iu', '86', '2010-12-10 11:24:14', '2010-12-10 16:22:40', '1');
INSERT INTO `sessions` VALUES ('1635', 'dtrleef97drdrbf6rm1mraib96ulb13u', '86', '2010-12-13 13:44:19', '2010-12-13 13:44:19', '0');
INSERT INTO `sessions` VALUES ('1636', 'dtrleef97drdrbf6rm1mraib96ulb13u', '86', '2010-12-13 13:44:19', '2010-12-13 13:44:20', '0');
INSERT INTO `sessions` VALUES ('1637', 'dtrleef97drdrbf6rm1mraib96ulb13u', '86', '2010-12-13 13:44:20', '2010-12-13 13:44:22', '1');
INSERT INTO `sessions` VALUES ('1638', '2ol1hnlmls7lf59r40v4nkbqa1hn5oi5', '8', '2010-12-15 14:55:19', '2010-12-15 14:55:19', '0');
INSERT INTO `sessions` VALUES ('1639', '2ol1hnlmls7lf59r40v4nkbqa1hn5oi5', '8', '2010-12-15 14:55:19', '2010-12-15 14:55:38', '0');
INSERT INTO `sessions` VALUES ('1640', '2ol1hnlmls7lf59r40v4nkbqa1hn5oi5', '8', '2010-12-15 14:55:38', '2010-12-15 14:55:38', '1');
INSERT INTO `sessions` VALUES ('1641', 'ocs3oned47ih9p71984l8456eod1306h', '66', '2010-12-23 08:31:52', '2010-12-23 08:31:52', '1');
INSERT INTO `sessions` VALUES ('1642', 'ajpjbapgnsbogr5n75mq1j1nmacuv20f', '152', '2011-01-04 10:37:59', '2011-01-04 10:38:39', '1');
INSERT INTO `sessions` VALUES ('1643', 'ad1ca5dhun11ijlj2j9uplfshv2pkjdb', '153', '2011-01-05 17:13:40', '2011-01-05 17:13:40', '1');
INSERT INTO `sessions` VALUES ('1644', '6lclknl0glbb2urt2i0tstnhcqjbumpv', '80', '2011-01-06 21:43:45', '2011-01-06 21:56:40', '1');
INSERT INTO `sessions` VALUES ('1645', 'njrm6rpf2sm9msnvrtgbkhukvcqtengb', '86', '2011-01-10 12:25:41', '2011-01-10 12:25:41', '0');
INSERT INTO `sessions` VALUES ('1646', 'njrm6rpf2sm9msnvrtgbkhukvcqtengb', '86', '2011-01-10 12:25:41', '2011-01-10 12:25:43', '0');
INSERT INTO `sessions` VALUES ('1647', 'njrm6rpf2sm9msnvrtgbkhukvcqtengb', '86', '2011-01-10 12:25:43', '2011-01-10 12:26:00', '1');
INSERT INTO `sessions` VALUES ('1648', 'jc8rlsrc1n7vr9t7u784vei549qfhhcn', '8', '2011-01-11 14:11:58', '2011-01-11 14:13:55', '1');
INSERT INTO `sessions` VALUES ('1649', 'ul1i0regnr2ec33gopoap64etnpb7cos', '86', '2011-01-12 11:15:32', '2011-01-12 11:15:32', '0');
INSERT INTO `sessions` VALUES ('1650', 'ul1i0regnr2ec33gopoap64etnpb7cos', '86', '2011-01-12 11:15:32', '2011-01-12 11:15:35', '0');
INSERT INTO `sessions` VALUES ('1651', 'ul1i0regnr2ec33gopoap64etnpb7cos', '86', '2011-01-12 11:15:35', '2011-01-12 11:26:18', '1');
INSERT INTO `sessions` VALUES ('1652', '54svgv4eit8eugnf2p1tok07u8k4gahi', '80', '2011-01-12 21:51:42', '2011-01-12 21:51:42', '0');
INSERT INTO `sessions` VALUES ('1653', '54svgv4eit8eugnf2p1tok07u8k4gahi', '80', '2011-01-12 21:51:42', '2011-01-12 21:54:09', '1');
INSERT INTO `sessions` VALUES ('1654', 'vsgqj0i18hk8cdq975t091fkp30mk1a1', '8', '2011-01-13 09:38:12', '2011-01-13 09:38:12', '0');
INSERT INTO `sessions` VALUES ('1655', 'vsgqj0i18hk8cdq975t091fkp30mk1a1', '8', '2011-01-13 09:38:12', '2011-01-13 09:38:22', '0');
INSERT INTO `sessions` VALUES ('1656', 'vsgqj0i18hk8cdq975t091fkp30mk1a1', '8', '2011-01-13 09:38:22', '2011-01-13 09:38:29', '1');
INSERT INTO `sessions` VALUES ('1657', 'bul4b90ricnfdlqgl65fe6hmufbq1o61', '0', '2011-01-14 14:02:40', '2011-01-14 14:23:09', '0');
INSERT INTO `sessions` VALUES ('1658', 'bul4b90ricnfdlqgl65fe6hmufbq1o61', '0', '2011-01-14 14:29:31', '2011-01-14 14:29:31', '1');
INSERT INTO `sessions` VALUES ('1659', '669asfedtu8m7b1m0vj11b1ok8096j8c', '55', '2011-01-14 14:51:13', '2011-01-14 14:52:02', '1');
INSERT INTO `sessions` VALUES ('1660', '6m3239cdkqnpgc9f8alooo5gte7nvnjn', '80', '2011-01-19 09:57:17', '2011-01-19 09:57:17', '0');
INSERT INTO `sessions` VALUES ('1661', '6m3239cdkqnpgc9f8alooo5gte7nvnjn', '80', '2011-01-19 09:57:17', '2011-01-19 09:57:29', '0');
INSERT INTO `sessions` VALUES ('1662', '6m3239cdkqnpgc9f8alooo5gte7nvnjn', '80', '2011-01-19 09:57:40', '2011-01-19 09:57:54', '1');
INSERT INTO `sessions` VALUES ('1663', 'ppqq359lvucvamvamln3a4pr70im22i3', '57', '2011-01-24 09:58:48', '2011-01-24 09:58:48', '1');
INSERT INTO `sessions` VALUES ('1664', 'laoe1gnhbik5leu0glf05pkvo3jvofbe', '86', '2011-01-24 11:05:58', '2011-01-24 11:05:58', '0');
INSERT INTO `sessions` VALUES ('1665', 'laoe1gnhbik5leu0glf05pkvo3jvofbe', '86', '2011-01-24 11:05:58', '2011-01-24 11:06:01', '0');
INSERT INTO `sessions` VALUES ('1666', 'laoe1gnhbik5leu0glf05pkvo3jvofbe', '86', '2011-01-24 11:06:01', '2011-01-24 11:06:19', '1');
INSERT INTO `sessions` VALUES ('1667', 'gr4l5ulgvfj4voaect98bbksb7c0hqjo', '94', '2011-01-24 11:59:27', '2011-01-25 05:26:50', '1');
INSERT INTO `sessions` VALUES ('1668', 'ti3562bhrsq3lm1giffk7mka7o3b92m6', '156', '2011-01-26 16:03:31', '2011-01-26 16:06:20', '0');
INSERT INTO `sessions` VALUES ('1669', 'ti3562bhrsq3lm1giffk7mka7o3b92m6', '8', '2011-01-26 16:06:27', '2011-01-26 16:08:14', '0');
INSERT INTO `sessions` VALUES ('1670', 'ti3562bhrsq3lm1giffk7mka7o3b92m6', '156', '2011-01-26 16:08:29', '2011-01-26 16:36:55', '1');
INSERT INTO `sessions` VALUES ('1671', '60ca4qpesanui1vtahpaktmjr0p0bqnq', '127', '2011-01-26 21:17:20', '2011-01-26 21:17:20', '1');
INSERT INTO `sessions` VALUES ('1672', '0srrc09h8826c51tdpd66t359i9hjlme', '127', '2011-01-27 12:42:16', '2011-01-27 12:50:29', '1');
INSERT INTO `sessions` VALUES ('1673', 'gfnr9re55ttrh4n988p18l7tvv00n6u5', '57', '2011-01-27 14:34:35', '2011-01-27 14:34:35', '0');
INSERT INTO `sessions` VALUES ('1674', 'gfnr9re55ttrh4n988p18l7tvv00n6u5', '57', '2011-01-27 14:34:35', '2011-01-27 14:34:45', '1');
INSERT INTO `sessions` VALUES ('1675', 'gfnr9re55ttrh4n988p18l7tvv00n6u5', '157', '2011-01-27 14:34:45', '2011-01-27 14:34:45', '1');
INSERT INTO `sessions` VALUES ('1676', 'kobloaemdb867jnfatch28filtje5165', '57', '2011-01-28 08:28:57', '2011-01-28 08:29:00', '0');
INSERT INTO `sessions` VALUES ('1677', 'kobloaemdb867jnfatch28filtje5165', '157', '2011-01-28 08:29:14', '2011-01-28 08:29:14', '1');
INSERT INTO `sessions` VALUES ('1678', '9ri3indjan04aaefsv1qpklhtumh0r43', '8', '2011-01-28 12:44:53', '2011-01-28 12:44:53', '0');
INSERT INTO `sessions` VALUES ('1679', '9ri3indjan04aaefsv1qpklhtumh0r43', '8', '2011-01-28 12:44:53', '2011-01-28 12:45:01', '0');
INSERT INTO `sessions` VALUES ('1680', '9ri3indjan04aaefsv1qpklhtumh0r43', '8', '2011-01-28 12:45:01', '2011-01-28 12:45:01', '0');
INSERT INTO `sessions` VALUES ('1681', 'p37ms91d8439l5pkcgpntab22hk028o2', '127', '2011-01-28 13:26:46', '2011-01-28 13:26:46', '0');
INSERT INTO `sessions` VALUES ('1682', 'p37ms91d8439l5pkcgpntab22hk028o2', '127', '2011-01-28 13:26:46', '2011-01-28 13:26:48', '0');
INSERT INTO `sessions` VALUES ('1683', 'p37ms91d8439l5pkcgpntab22hk028o2', '127', '2011-01-28 13:26:48', '2011-01-28 13:26:48', '1');
INSERT INTO `sessions` VALUES ('1684', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-01-31 09:25:44', '2011-01-31 09:25:44', '0');
INSERT INTO `sessions` VALUES ('1685', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-01-31 09:25:44', '2011-01-31 09:25:47', '0');
INSERT INTO `sessions` VALUES ('1686', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-01-31 09:25:47', '2011-01-31 10:26:43', '0');
INSERT INTO `sessions` VALUES ('1687', 'bgfoa3clubs792fenmg5ubi99j5r1jrp', '86', '2011-01-31 09:38:37', '2011-01-31 09:38:37', '0');
INSERT INTO `sessions` VALUES ('1688', 'bgfoa3clubs792fenmg5ubi99j5r1jrp', '86', '2011-01-31 09:38:37', '2011-01-31 09:38:38', '0');
INSERT INTO `sessions` VALUES ('1689', 'bgfoa3clubs792fenmg5ubi99j5r1jrp', '86', '2011-01-31 09:38:38', '2011-01-31 09:39:03', '1');
INSERT INTO `sessions` VALUES ('1690', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-01-31 10:26:57', '2011-01-31 12:58:04', '0');
INSERT INTO `sessions` VALUES ('1691', '9ri3indjan04aaefsv1qpklhtumh0r43', '8', '2011-01-31 11:56:02', '2011-01-31 11:56:03', '1');
INSERT INTO `sessions` VALUES ('1692', '654lc79p7spcsrevrht88g9a44o6rc8a', '86', '2011-01-31 12:02:32', '2011-01-31 12:02:32', '0');
INSERT INTO `sessions` VALUES ('1693', '654lc79p7spcsrevrht88g9a44o6rc8a', '86', '2011-01-31 12:02:32', '2011-01-31 12:02:34', '0');
INSERT INTO `sessions` VALUES ('1694', '654lc79p7spcsrevrht88g9a44o6rc8a', '86', '2011-01-31 12:02:34', '2011-01-31 12:02:54', '1');
INSERT INTO `sessions` VALUES ('1695', 'fkjnk569qmq4sgbprbnbd4l8uijhqf8d', '0', '2011-01-31 13:00:00', '2011-01-31 13:04:45', '0');
INSERT INTO `sessions` VALUES ('1696', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-01-31 13:02:35', '2011-01-31 13:02:40', '0');
INSERT INTO `sessions` VALUES ('1697', 'fkjnk569qmq4sgbprbnbd4l8uijhqf8d', '0', '2011-01-31 13:04:45', '2011-01-31 13:04:45', '1');
INSERT INTO `sessions` VALUES ('1698', '35bhekbotnoip8c6352v3ccrh2l8htrd', '86', '2011-02-01 15:39:55', '2011-02-01 15:39:55', '0');
INSERT INTO `sessions` VALUES ('1699', '35bhekbotnoip8c6352v3ccrh2l8htrd', '86', '2011-02-01 15:39:55', '2011-02-01 15:39:56', '0');
INSERT INTO `sessions` VALUES ('1700', '35bhekbotnoip8c6352v3ccrh2l8htrd', '86', '2011-02-01 15:39:56', '2011-02-01 15:39:58', '1');
INSERT INTO `sessions` VALUES ('1701', 'pcmsun9r4ripbuf0n6q2tcjcs75l8hms', '8', '2011-02-01 16:14:27', '2011-02-01 16:14:27', '0');
INSERT INTO `sessions` VALUES ('1702', 'pcmsun9r4ripbuf0n6q2tcjcs75l8hms', '8', '2011-02-01 16:14:27', '2011-02-01 16:14:35', '0');
INSERT INTO `sessions` VALUES ('1703', 'pcmsun9r4ripbuf0n6q2tcjcs75l8hms', '8', '2011-02-01 16:14:35', '2011-02-01 16:14:35', '1');
INSERT INTO `sessions` VALUES ('1704', 'n06t43pslfut05igl6ane4erqt2n396k', '86', '2011-02-02 14:06:20', '2011-02-02 14:06:20', '0');
INSERT INTO `sessions` VALUES ('1705', 'n06t43pslfut05igl6ane4erqt2n396k', '86', '2011-02-02 14:06:20', '2011-02-02 14:06:22', '0');
INSERT INTO `sessions` VALUES ('1706', 'n06t43pslfut05igl6ane4erqt2n396k', '86', '2011-02-02 14:06:22', '2011-02-02 14:06:28', '1');
INSERT INTO `sessions` VALUES ('1707', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-02-02 14:07:39', '2011-02-02 14:07:39', '0');
INSERT INTO `sessions` VALUES ('1708', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-02-02 14:07:39', '2011-02-02 14:07:41', '0');
INSERT INTO `sessions` VALUES ('1709', '1krbid77eikr7amlb2rsphqbl21dm0t6', '94', '2011-02-02 14:07:41', '2011-02-02 14:07:41', '1');
INSERT INTO `sessions` VALUES ('1710', '5kssoff8ub7gb2dp2geg0g6pdajbv65b', '8', '2011-02-02 18:19:30', '2011-02-02 18:19:30', '0');
INSERT INTO `sessions` VALUES ('1711', '5kssoff8ub7gb2dp2geg0g6pdajbv65b', '8', '2011-02-02 18:19:30', '2011-02-02 18:19:38', '0');
INSERT INTO `sessions` VALUES ('1712', '5kssoff8ub7gb2dp2geg0g6pdajbv65b', '8', '2011-02-02 18:19:38', '2011-02-03 13:46:12', '0');
INSERT INTO `sessions` VALUES ('1713', '3n1pe717vmfu816usl1m4rf30n164rp5', '0', '2011-02-03 13:40:45', '2011-02-03 13:40:45', '0');
INSERT INTO `sessions` VALUES ('1714', '3n1pe717vmfu816usl1m4rf30n164rp5', '0', '2011-02-03 13:40:45', '2011-02-03 13:41:20', '1');
INSERT INTO `sessions` VALUES ('1715', '3n1pe717vmfu816usl1m4rf30n164rp5', '8', '2011-02-03 13:41:20', '2011-02-04 10:31:35', '0');
INSERT INTO `sessions` VALUES ('1716', '5kssoff8ub7gb2dp2geg0g6pdajbv65b', '8', '2011-02-03 13:46:23', '2011-02-04 13:06:50', '1');
INSERT INTO `sessions` VALUES ('1717', '3n1pe717vmfu816usl1m4rf30n164rp5', '8', '2011-02-04 21:36:03', '2011-02-04 22:07:32', '1');
INSERT INTO `sessions` VALUES ('1718', 'qhejpv5ech34gef0mvjps08auqmmcgfq', '8', '2011-02-04 21:46:11', '2011-02-04 21:46:11', '0');
INSERT INTO `sessions` VALUES ('1719', '35sna41f404c6to67bmoa8rno9pfnirt', '8', '2011-02-04 22:36:51', '2011-02-04 22:36:51', '1');
INSERT INTO `sessions` VALUES ('1720', 'jh5am5ccj7fctssal31vfv6l6unrvk5q', '8', '2011-02-07 10:33:54', '2011-02-07 10:33:54', '1');
INSERT INTO `sessions` VALUES ('1721', 'chqbq20slpod2kqu1qlho3eblis0b6cv', '86', '2011-02-07 11:35:07', '2011-02-07 11:35:07', '0');
INSERT INTO `sessions` VALUES ('1722', 'chqbq20slpod2kqu1qlho3eblis0b6cv', '86', '2011-02-07 11:35:07', '2011-02-07 11:35:12', '0');
INSERT INTO `sessions` VALUES ('1723', 'chqbq20slpod2kqu1qlho3eblis0b6cv', '86', '2011-02-07 11:35:12', '2011-02-07 11:41:23', '1');
INSERT INTO `sessions` VALUES ('1724', 'qhejpv5ech34gef0mvjps08auqmmcgfq', '8', '2011-02-08 09:24:44', '2011-02-08 09:24:44', '0');
INSERT INTO `sessions` VALUES ('1725', 'n8nvlbtoeoeajlekebujnkhmkt6n10qa', '159', '2011-02-08 20:46:33', '2011-02-08 21:03:45', '1');
INSERT INTO `sessions` VALUES ('1726', 'hh971t4hkm628toc3tfmqqp6b3r65q18', '55', '2011-02-09 22:43:00', '2011-02-09 22:43:00', '0');
INSERT INTO `sessions` VALUES ('1727', 'hh971t4hkm628toc3tfmqqp6b3r65q18', '55', '2011-02-09 22:43:00', '2011-02-09 22:43:57', '1');
INSERT INTO `sessions` VALUES ('1728', 'pfok98bhu697pd51d8f0vucibs7adeiu', '160', '2011-02-11 14:41:42', '2011-02-11 15:45:08', '1');
INSERT INTO `sessions` VALUES ('1729', 'qocjtkpah4v1khks5h1od0gvmcqq3leh', '152', '2011-02-13 14:21:05', '2011-02-13 14:21:05', '1');
INSERT INTO `sessions` VALUES ('1730', 'rrkrluldlarilpd5i41j4d67n4uaqbqk', '152', '2011-02-14 09:05:10', '2011-02-14 09:05:10', '0');
INSERT INTO `sessions` VALUES ('1731', 'rrkrluldlarilpd5i41j4d67n4uaqbqk', '152', '2011-02-14 09:05:10', '2011-02-14 09:05:23', '0');
INSERT INTO `sessions` VALUES ('1732', 'rrkrluldlarilpd5i41j4d67n4uaqbqk', '152', '2011-02-14 09:05:23', '2011-02-14 09:05:23', '1');
INSERT INTO `sessions` VALUES ('1733', 'jm2flvo4j3eghnnug068fok4b8vkm702', '8', '2011-02-14 09:10:01', '2011-02-14 09:10:01', '0');
INSERT INTO `sessions` VALUES ('1734', 'jm2flvo4j3eghnnug068fok4b8vkm702', '8', '2011-02-14 09:10:01', '2011-02-14 09:10:32', '1');
INSERT INTO `sessions` VALUES ('1735', 'dqude5ivafd371nl71luqjp2t74i6nsg', '86', '2011-02-14 09:21:54', '2011-02-14 09:21:54', '0');
INSERT INTO `sessions` VALUES ('1736', 'dqude5ivafd371nl71luqjp2t74i6nsg', '86', '2011-02-14 09:21:54', '2011-02-14 09:22:03', '0');
INSERT INTO `sessions` VALUES ('1737', 'dqude5ivafd371nl71luqjp2t74i6nsg', '86', '2011-02-14 09:22:03', '2011-02-14 09:22:24', '1');
INSERT INTO `sessions` VALUES ('1738', 'jm2flvo4j3eghnnug068fok4b8vkm702', '156', '2011-02-14 09:34:59', '2011-02-14 12:36:52', '0');
INSERT INTO `sessions` VALUES ('1739', 'b8gsult24f37hpib7iearol1vq826s3r', '94', '2011-02-14 14:21:52', '2011-02-14 14:21:52', '0');
INSERT INTO `sessions` VALUES ('1740', 'b8gsult24f37hpib7iearol1vq826s3r', '94', '2011-02-14 14:21:52', '2011-02-14 14:22:39', '0');
INSERT INTO `sessions` VALUES ('1741', 'b8gsult24f37hpib7iearol1vq826s3r', '94', '2011-02-14 14:22:39', '2011-02-14 14:22:39', '1');
INSERT INTO `sessions` VALUES ('1742', 'jm2flvo4j3eghnnug068fok4b8vkm702', '156', '2011-02-16 09:06:13', '2011-02-16 09:06:13', '0');
INSERT INTO `sessions` VALUES ('1743', 'jm2flvo4j3eghnnug068fok4b8vkm702', '156', '2011-02-16 09:06:13', '2011-02-16 09:06:27', '1');
INSERT INTO `sessions` VALUES ('1744', 'jm2flvo4j3eghnnug068fok4b8vkm702', '80', '2011-02-16 09:06:27', '2011-02-16 11:27:27', '0');
INSERT INTO `sessions` VALUES ('1745', 'jm2flvo4j3eghnnug068fok4b8vkm702', '93', '2011-02-16 11:30:55', '2011-02-16 11:53:32', '0');
INSERT INTO `sessions` VALUES ('1746', 'jm2flvo4j3eghnnug068fok4b8vkm702', '80', '2011-02-16 11:53:45', '2011-02-16 14:58:52', '0');
INSERT INTO `sessions` VALUES ('1747', 'jm2flvo4j3eghnnug068fok4b8vkm702', '80', '2011-02-16 15:05:09', '2011-02-16 15:05:09', '1');
INSERT INTO `sessions` VALUES ('1748', 'o36cdn50krcjjj7kpmibhsf125t5c49s', '8', '2011-02-16 17:30:08', '2011-02-16 17:30:08', '0');
INSERT INTO `sessions` VALUES ('1749', 'o36cdn50krcjjj7kpmibhsf125t5c49s', '8', '2011-02-16 17:30:08', '2011-02-16 17:30:17', '0');
INSERT INTO `sessions` VALUES ('1750', 'o36cdn50krcjjj7kpmibhsf125t5c49s', '8', '2011-02-16 17:30:17', '2011-02-16 17:30:17', '1');
INSERT INTO `sessions` VALUES ('1751', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '80', '2011-02-17 08:41:21', '2011-02-17 08:41:21', '0');
INSERT INTO `sessions` VALUES ('1752', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '80', '2011-02-17 08:41:21', '2011-02-17 08:41:35', '0');
INSERT INTO `sessions` VALUES ('1753', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '80', '2011-02-17 08:41:35', '2011-02-17 08:46:52', '0');
INSERT INTO `sessions` VALUES ('1754', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '8', '2011-02-17 08:47:02', '2011-02-17 08:47:21', '0');
INSERT INTO `sessions` VALUES ('1755', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '80', '2011-02-17 08:47:34', '2011-02-18 12:07:37', '0');
INSERT INTO `sessions` VALUES ('1756', 's8p1mq56hr0iokg9m2ednh5q017naecq', '86', '2011-02-18 11:13:53', '2011-02-18 11:13:53', '0');
INSERT INTO `sessions` VALUES ('1757', 's8p1mq56hr0iokg9m2ednh5q017naecq', '86', '2011-02-18 11:13:53', '2011-02-18 11:13:55', '0');
INSERT INTO `sessions` VALUES ('1758', 's8p1mq56hr0iokg9m2ednh5q017naecq', '86', '2011-02-18 11:13:55', '2011-02-18 11:14:00', '1');
INSERT INTO `sessions` VALUES ('1759', 'c7k1mcrfo6lghr25i5msgfl6l9bpnf9c', '162', '2011-02-18 12:21:48', '2011-02-18 13:12:55', '1');
INSERT INTO `sessions` VALUES ('1760', 'mf0vm8u6lab3jpr05rd70t5acobi7gf4', '80', '2011-02-18 13:48:50', '2011-02-18 13:48:58', '1');
INSERT INTO `sessions` VALUES ('1761', '75dvge2ldiurli3e97r06bhcdnevruoa', '163', '2011-02-18 14:28:23', '2011-02-18 14:34:29', '0');
INSERT INTO `sessions` VALUES ('1762', 'bnqiv4hgv4rsunqm9u3b68flci30ri0v', '86', '2011-02-21 10:49:20', '2011-02-21 10:49:20', '0');
INSERT INTO `sessions` VALUES ('1763', 'bnqiv4hgv4rsunqm9u3b68flci30ri0v', '86', '2011-02-21 10:49:20', '2011-02-21 10:49:24', '0');
INSERT INTO `sessions` VALUES ('1764', 'bnqiv4hgv4rsunqm9u3b68flci30ri0v', '86', '2011-02-21 10:49:24', '2011-02-21 10:54:25', '1');
INSERT INTO `sessions` VALUES ('1765', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-21 19:55:14', '2011-02-21 19:55:14', '0');
INSERT INTO `sessions` VALUES ('1766', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-21 19:55:14', '2011-02-21 19:55:16', '0');
INSERT INTO `sessions` VALUES ('1767', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-21 19:55:16', '2011-02-22 00:13:36', '0');
INSERT INTO `sessions` VALUES ('1768', 'olg2apg01jiof9luep27diu7imm47t2c', '80', '2011-02-23 10:21:08', '2011-02-23 10:21:08', '0');
INSERT INTO `sessions` VALUES ('1769', 'olg2apg01jiof9luep27diu7imm47t2c', '80', '2011-02-23 10:21:08', '2011-02-23 10:21:21', '0');
INSERT INTO `sessions` VALUES ('1770', 'olg2apg01jiof9luep27diu7imm47t2c', '80', '2011-02-23 10:21:21', '2011-02-23 10:30:14', '0');
INSERT INTO `sessions` VALUES ('1771', '1d1aioscqtnhb46adrspv76smhk2rnra', '80', '2011-02-23 10:28:14', '2011-02-23 10:28:23', '1');
INSERT INTO `sessions` VALUES ('1772', 'olg2apg01jiof9luep27diu7imm47t2c', '8', '2011-02-23 10:30:22', '2011-02-23 10:32:17', '0');
INSERT INTO `sessions` VALUES ('1773', 'olg2apg01jiof9luep27diu7imm47t2c', '80', '2011-02-23 10:32:39', '2011-02-23 10:56:47', '0');
INSERT INTO `sessions` VALUES ('1774', '5gqk9p528o80oit0f6c5bo7354t68ot4', '86', '2011-02-23 10:35:45', '2011-02-23 10:35:45', '0');
INSERT INTO `sessions` VALUES ('1775', '5gqk9p528o80oit0f6c5bo7354t68ot4', '86', '2011-02-23 10:35:45', '2011-02-23 10:35:46', '0');
INSERT INTO `sessions` VALUES ('1776', '5gqk9p528o80oit0f6c5bo7354t68ot4', '86', '2011-02-23 10:35:46', '2011-02-23 11:39:44', '1');
INSERT INTO `sessions` VALUES ('1777', 'olg2apg01jiof9luep27diu7imm47t2c', '8', '2011-02-23 10:56:51', '2011-02-23 10:57:27', '0');
INSERT INTO `sessions` VALUES ('1778', 'vg40k6m36pa9ktlu3ip702b6shamj4si', '94', '2011-02-23 11:25:08', '2011-02-23 11:25:08', '0');
INSERT INTO `sessions` VALUES ('1779', 'vg40k6m36pa9ktlu3ip702b6shamj4si', '94', '2011-02-23 11:25:08', '2011-02-23 13:07:21', '0');
INSERT INTO `sessions` VALUES ('1780', 'vg40k6m36pa9ktlu3ip702b6shamj4si', '94', '2011-02-23 14:57:03', '2011-02-23 14:57:08', '0');
INSERT INTO `sessions` VALUES ('1781', 'vg40k6m36pa9ktlu3ip702b6shamj4si', '94', '2011-02-23 16:00:57', '2011-02-23 16:05:04', '1');
INSERT INTO `sessions` VALUES ('1782', 'k2n8l2jh5okutmfeami8mrstkpv6hvrs', '8', '2011-02-23 20:53:00', '2011-02-23 20:53:17', '1');
INSERT INTO `sessions` VALUES ('1783', 'oppk74to5f8do3fmgfl2a0nil3pignnr', '8', '2011-02-24 13:15:00', '2011-02-24 13:15:00', '0');
INSERT INTO `sessions` VALUES ('1784', 'oppk74to5f8do3fmgfl2a0nil3pignnr', '8', '2011-02-24 13:15:00', '2011-02-24 13:15:08', '0');
INSERT INTO `sessions` VALUES ('1785', 'oppk74to5f8do3fmgfl2a0nil3pignnr', '8', '2011-02-24 13:15:08', '2011-02-24 13:54:54', '1');
INSERT INTO `sessions` VALUES ('1786', '0enn1go9gbbrj1gb30eovf6849p0vthl', '156', '2011-02-24 17:30:19', '2011-02-24 17:30:19', '0');
INSERT INTO `sessions` VALUES ('1787', '0enn1go9gbbrj1gb30eovf6849p0vthl', '156', '2011-02-24 17:30:19', '2011-02-24 17:30:27', '1');
INSERT INTO `sessions` VALUES ('1788', '0enn1go9gbbrj1gb30eovf6849p0vthl', '8', '2011-02-24 17:30:27', '2011-02-24 17:30:27', '1');
INSERT INTO `sessions` VALUES ('1789', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-25 13:25:50', '2011-02-25 13:25:50', '0');
INSERT INTO `sessions` VALUES ('1790', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-25 13:25:50', '2011-02-25 13:25:53', '0');
INSERT INTO `sessions` VALUES ('1791', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-25 13:25:53', '2011-02-25 13:25:58', '0');
INSERT INTO `sessions` VALUES ('1792', '7j1648v0nma0i7effen9tp97vbju2o4m', '127', '2011-02-25 13:25:58', '2011-02-25 13:25:58', '1');
INSERT INTO `sessions` VALUES ('1793', 'ke0sk3g3vf52aaqagnrfjh4ctd9t1mod', '86', '2011-02-28 15:31:47', '2011-02-28 15:31:47', '0');
INSERT INTO `sessions` VALUES ('1794', 'ke0sk3g3vf52aaqagnrfjh4ctd9t1mod', '86', '2011-02-28 15:31:47', '2011-02-28 15:31:48', '0');
INSERT INTO `sessions` VALUES ('1795', 'ke0sk3g3vf52aaqagnrfjh4ctd9t1mod', '86', '2011-02-28 15:31:48', '2011-02-28 15:44:17', '1');
INSERT INTO `sessions` VALUES ('1796', '34undtankc5rp07vhjkekc0sku4jk1ps', '94', '2011-03-01 09:08:55', '2011-03-01 09:08:55', '0');
INSERT INTO `sessions` VALUES ('1797', '34undtankc5rp07vhjkekc0sku4jk1ps', '94', '2011-03-01 09:08:55', '2011-03-01 09:08:57', '0');
INSERT INTO `sessions` VALUES ('1798', '34undtankc5rp07vhjkekc0sku4jk1ps', '94', '2011-03-01 09:08:57', '2011-03-01 16:57:24', '1');
INSERT INTO `sessions` VALUES ('1799', 'gbkup696mmlbbd90ukhfp0477p08u0ao', '80', '2011-03-01 11:00:16', '2011-03-01 11:05:08', '0');
INSERT INTO `sessions` VALUES ('1800', 'j4l88dsin82b95jnhqo2v14tgcht2jf6', '57', '2011-03-01 11:27:28', '2011-03-01 11:27:58', '1');
INSERT INTO `sessions` VALUES ('1801', 'eubgui4d2cs1rs1skjf8mf9ugous3dpo', '57', '2011-03-01 14:05:56', '2011-03-01 14:06:39', '1');
INSERT INTO `sessions` VALUES ('1802', '9ul2hjm56bba1ua1mh29o3c0egg4c3cs', '94', '2011-03-01 17:26:40', '2011-03-01 17:26:40', '0');
INSERT INTO `sessions` VALUES ('1803', '9ul2hjm56bba1ua1mh29o3c0egg4c3cs', '94', '2011-03-01 17:26:40', '2011-03-01 17:26:41', '0');
INSERT INTO `sessions` VALUES ('1804', '9ul2hjm56bba1ua1mh29o3c0egg4c3cs', '94', '2011-03-01 17:26:41', '2011-03-01 17:27:20', '1');
INSERT INTO `sessions` VALUES ('1805', '0dchmfgncam06jgqf94jcrgkfrv6jt92', '55', '2011-03-02 01:03:33', '2011-03-02 01:04:11', '1');
INSERT INTO `sessions` VALUES ('1806', 'bmok6uem6ovi7nondf37i80h2ngj0s84', '86', '2011-03-02 09:31:58', '2011-03-02 09:31:58', '0');
INSERT INTO `sessions` VALUES ('1807', 'bmok6uem6ovi7nondf37i80h2ngj0s84', '86', '2011-03-02 09:31:58', '2011-03-02 09:31:59', '0');
INSERT INTO `sessions` VALUES ('1808', 'bmok6uem6ovi7nondf37i80h2ngj0s84', '86', '2011-03-02 09:31:59', '2011-03-02 10:41:03', '1');
INSERT INTO `sessions` VALUES ('1809', 'koj0cg4q9b9oavko4hruhi9ag0gdqmrl', '94', '2011-03-02 12:45:00', '2011-03-02 12:45:00', '0');
INSERT INTO `sessions` VALUES ('1810', 'koj0cg4q9b9oavko4hruhi9ag0gdqmrl', '94', '2011-03-02 12:45:00', '2011-03-02 12:45:02', '0');
INSERT INTO `sessions` VALUES ('1811', 'koj0cg4q9b9oavko4hruhi9ag0gdqmrl', '94', '2011-03-02 12:45:02', '2011-03-02 16:36:49', '1');
INSERT INTO `sessions` VALUES ('1812', 'ghhi1b2in112u0nj55tr47jlgq9f8ktd', '127', '2011-03-03 12:34:08', '2011-03-03 12:34:11', '0');
INSERT INTO `sessions` VALUES ('1813', 'ghhi1b2in112u0nj55tr47jlgq9f8ktd', '127', '2011-03-03 12:34:11', '2011-03-03 13:42:13', '1');
INSERT INTO `sessions` VALUES ('1814', 'pr5r9ke7s1o8m1p083coeo50bom5qsqv', '57', '2011-03-03 21:04:12', '2011-03-03 21:04:29', '0');
INSERT INTO `sessions` VALUES ('1815', 'pr5r9ke7s1o8m1p083coeo50bom5qsqv', '57', '2011-03-03 21:04:37', '2011-03-03 21:42:46', '1');
INSERT INTO `sessions` VALUES ('1816', '8pvtv0tt0lnf9r9rt27fa2gn97hsdar1', '165', '2011-03-04 07:40:19', '2011-03-04 07:48:06', '1');
INSERT INTO `sessions` VALUES ('1817', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 10:07:19', '2011-03-04 10:07:19', '0');
INSERT INTO `sessions` VALUES ('1818', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 10:07:19', '2011-03-04 10:07:21', '0');
INSERT INTO `sessions` VALUES ('1819', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 10:07:21', '2011-03-04 12:15:42', '0');
INSERT INTO `sessions` VALUES ('1820', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 16:16:58', '2011-03-04 16:16:58', '0');
INSERT INTO `sessions` VALUES ('1821', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 16:16:58', '2011-03-04 16:16:59', '0');
INSERT INTO `sessions` VALUES ('1822', 'iunutr4ip7i76405mirmu5fetdk35ihc', '94', '2011-03-04 16:16:59', '2011-03-04 16:17:03', '1');
INSERT INTO `sessions` VALUES ('1823', 'poibn7m0gfal2ek2u7jmokqef4jg3cgo', '165', '2011-03-05 05:47:35', '2011-03-05 05:47:35', '0');
INSERT INTO `sessions` VALUES ('1824', 'poibn7m0gfal2ek2u7jmokqef4jg3cgo', '165', '2011-03-05 05:47:35', '2011-03-05 05:47:55', '0');
INSERT INTO `sessions` VALUES ('1825', 'poibn7m0gfal2ek2u7jmokqef4jg3cgo', '165', '2011-03-05 05:47:55', '2011-03-05 05:54:25', '1');
INSERT INTO `sessions` VALUES ('1826', 'onck4s8goppa4jbuatlva5er3eub2rcm', '94', '2011-03-08 14:05:05', '2011-03-08 14:05:05', '0');
INSERT INTO `sessions` VALUES ('1827', 'onck4s8goppa4jbuatlva5er3eub2rcm', '94', '2011-03-08 14:05:05', '2011-03-08 14:05:09', '0');
INSERT INTO `sessions` VALUES ('1828', 'onck4s8goppa4jbuatlva5er3eub2rcm', '94', '2011-03-08 14:05:09', '2011-03-08 14:05:12', '1');
INSERT INTO `sessions` VALUES ('1829', 'gme6uqgbpbj4mpodc16361u8pocmi3u0', '94', '2011-03-09 10:25:12', '2011-03-09 10:25:12', '0');
INSERT INTO `sessions` VALUES ('1830', 'gme6uqgbpbj4mpodc16361u8pocmi3u0', '94', '2011-03-09 10:25:12', '2011-03-09 10:25:14', '0');
INSERT INTO `sessions` VALUES ('1831', 'gme6uqgbpbj4mpodc16361u8pocmi3u0', '94', '2011-03-09 10:25:14', '2011-03-09 14:10:44', '1');
INSERT INTO `sessions` VALUES ('1832', 'def7i00mddf4t0lubkn9864go5ll91hq', '80', '2011-03-10 08:53:51', '2011-03-10 08:53:51', '1');
INSERT INTO `sessions` VALUES ('1833', 'oe5okp0s1j49qlbditrl7kl2uk5aftvq', '80', '2011-03-10 13:10:36', '2011-03-10 13:10:46', '0');
INSERT INTO `sessions` VALUES ('1834', 'oe5okp0s1j49qlbditrl7kl2uk5aftvq', '80', '2011-03-10 13:10:58', '2011-03-10 13:11:03', '1');
INSERT INTO `sessions` VALUES ('1835', 'ghloid5h52ep9dtai19e4p2le1pai91o', '94', '2011-03-11 08:53:56', '2011-03-11 08:53:56', '0');
INSERT INTO `sessions` VALUES ('1836', 'ghloid5h52ep9dtai19e4p2le1pai91o', '94', '2011-03-11 08:53:56', '2011-03-11 08:53:58', '0');
INSERT INTO `sessions` VALUES ('1837', 'ghloid5h52ep9dtai19e4p2le1pai91o', '94', '2011-03-11 08:53:58', '2011-03-11 08:54:00', '1');
INSERT INTO `sessions` VALUES ('1838', 'pobcasn7sgi0c9pg4qt7vgtnrnmm94sk', '55', '2011-03-13 15:56:17', '2011-03-13 15:56:45', '1');
INSERT INTO `sessions` VALUES ('1839', 'bfi0i7ahnd4ejqilu5jg1hlbicleeq1m', '86', '2011-03-14 09:50:29', '2011-03-14 09:50:29', '0');
INSERT INTO `sessions` VALUES ('1840', 'bfi0i7ahnd4ejqilu5jg1hlbicleeq1m', '86', '2011-03-14 09:50:29', '2011-03-14 09:50:30', '0');
INSERT INTO `sessions` VALUES ('1841', 'bfi0i7ahnd4ejqilu5jg1hlbicleeq1m', '86', '2011-03-14 09:50:30', '2011-03-14 09:51:45', '1');
INSERT INTO `sessions` VALUES ('1842', 'e9klb4a284cmfi3btrl1q39bpb7feke7', '94', '2011-03-14 11:08:05', '2011-03-14 11:08:05', '0');
INSERT INTO `sessions` VALUES ('1843', 'e9klb4a284cmfi3btrl1q39bpb7feke7', '94', '2011-03-14 11:08:05', '2011-03-14 11:08:07', '0');
INSERT INTO `sessions` VALUES ('1844', 'e9klb4a284cmfi3btrl1q39bpb7feke7', '94', '2011-03-14 11:08:07', '2011-03-14 12:15:52', '1');
INSERT INTO `sessions` VALUES ('1845', 'jvqt21h0i2elr7tvpkjnmae6tdis4ubd', '8', '2011-03-15 15:48:24', '2011-03-15 15:48:24', '0');
INSERT INTO `sessions` VALUES ('1846', 'jvqt21h0i2elr7tvpkjnmae6tdis4ubd', '8', '2011-03-15 15:48:24', '2011-03-15 16:17:07', '0');
INSERT INTO `sessions` VALUES ('1847', 'jvqt21h0i2elr7tvpkjnmae6tdis4ubd', '8', '2011-03-15 16:17:07', '2011-03-15 16:17:18', '0');
INSERT INTO `sessions` VALUES ('1848', 'jvqt21h0i2elr7tvpkjnmae6tdis4ubd', '8', '2011-03-15 16:17:18', '2011-03-15 16:17:18', '1');
INSERT INTO `sessions` VALUES ('1849', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-16 10:35:11', '2011-03-16 10:35:47', '0');
INSERT INTO `sessions` VALUES ('1850', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-16 10:36:30', '2011-03-16 11:38:55', '0');
INSERT INTO `sessions` VALUES ('1851', '41h2crco33ke0vj0esolnjpvcs6gnvka', '94', '2011-03-16 10:53:37', '2011-03-16 10:53:37', '0');
INSERT INTO `sessions` VALUES ('1852', '41h2crco33ke0vj0esolnjpvcs6gnvka', '94', '2011-03-16 10:53:37', '2011-03-16 10:53:40', '0');
INSERT INTO `sessions` VALUES ('1853', '41h2crco33ke0vj0esolnjpvcs6gnvka', '94', '2011-03-16 10:53:40', '2011-03-16 13:03:18', '1');
INSERT INTO `sessions` VALUES ('1854', '39g8k60pngjrkoeq6rue0d9ecbhv0ufg', '165', '2011-03-17 10:22:12', '2011-03-17 10:22:12', '0');
INSERT INTO `sessions` VALUES ('1855', '39g8k60pngjrkoeq6rue0d9ecbhv0ufg', '165', '2011-03-17 10:22:12', '2011-03-17 10:22:29', '0');
INSERT INTO `sessions` VALUES ('1856', '39g8k60pngjrkoeq6rue0d9ecbhv0ufg', '165', '2011-03-17 10:22:29', '2011-03-17 10:23:04', '1');
INSERT INTO `sessions` VALUES ('1857', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-17 14:14:39', '2011-03-17 14:14:41', '0');
INSERT INTO `sessions` VALUES ('1858', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-17 14:14:41', '2011-03-18 09:20:33', '0');
INSERT INTO `sessions` VALUES ('1859', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:40:47', '2011-03-17 14:40:47', '0');
INSERT INTO `sessions` VALUES ('1860', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:40:47', '2011-03-17 14:41:01', '0');
INSERT INTO `sessions` VALUES ('1861', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:41:02', '2011-03-17 14:41:14', '0');
INSERT INTO `sessions` VALUES ('1862', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:41:14', '2011-03-17 14:47:13', '0');
INSERT INTO `sessions` VALUES ('1863', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:47:13', '2011-03-17 14:47:13', '0');
INSERT INTO `sessions` VALUES ('1864', '22flm3qp5kdvi0vl57641vfvcm4ev8tv', '80', '2011-03-17 14:47:13', '2011-03-17 14:47:16', '1');
INSERT INTO `sessions` VALUES ('1865', '75t010ia09a32bnto3268umr6806vhmk', '80', '2011-03-18 11:39:35', '2011-03-18 11:39:35', '0');
INSERT INTO `sessions` VALUES ('1866', '75t010ia09a32bnto3268umr6806vhmk', '80', '2011-03-18 11:39:35', '2011-03-18 11:39:45', '0');
INSERT INTO `sessions` VALUES ('1867', '75t010ia09a32bnto3268umr6806vhmk', '80', '2011-03-18 11:39:45', '2011-03-18 11:39:49', '0');
INSERT INTO `sessions` VALUES ('1868', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 08:55:39', '2011-03-20 08:55:39', '0');
INSERT INTO `sessions` VALUES ('1869', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 08:55:39', '2011-03-20 08:55:41', '0');
INSERT INTO `sessions` VALUES ('1870', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 08:55:41', '2011-03-20 08:55:41', '0');
INSERT INTO `sessions` VALUES ('1871', 'feu6o2sv5rlp1k2ve2ugjfeei411ebtf', '164', '2011-03-20 19:14:09', '2011-03-20 19:14:39', '0');
INSERT INTO `sessions` VALUES ('1872', 'feu6o2sv5rlp1k2ve2ugjfeei411ebtf', '164', '2011-03-20 19:14:39', '2011-03-20 19:14:49', '1');
INSERT INTO `sessions` VALUES ('1873', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 19:17:31', '2011-03-20 19:17:31', '0');
INSERT INTO `sessions` VALUES ('1874', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 19:17:31', '2011-03-20 19:17:34', '0');
INSERT INTO `sessions` VALUES ('1875', '6gprnnj0g6o78bpqsvqsdu3sdi4uupl5', '94', '2011-03-20 19:17:34', '2011-03-20 19:17:36', '1');
INSERT INTO `sessions` VALUES ('1876', '4tgsli3ulslj117645bjdn2ebflkvkpu', '94', '2011-03-21 09:55:09', '2011-03-21 09:55:11', '0');
INSERT INTO `sessions` VALUES ('1877', '4tgsli3ulslj117645bjdn2ebflkvkpu', '94', '2011-03-21 09:55:11', '2011-03-21 09:55:49', '1');
INSERT INTO `sessions` VALUES ('1878', '1v1a6cdsbdj5dbtq5r269qtj2eem6st9', '86', '2011-03-21 10:54:59', '2011-03-21 10:54:59', '0');
INSERT INTO `sessions` VALUES ('1879', '1v1a6cdsbdj5dbtq5r269qtj2eem6st9', '86', '2011-03-21 10:54:59', '2011-03-21 10:55:01', '0');
INSERT INTO `sessions` VALUES ('1880', '1v1a6cdsbdj5dbtq5r269qtj2eem6st9', '86', '2011-03-21 10:55:01', '2011-03-21 10:58:21', '1');
INSERT INTO `sessions` VALUES ('1881', 'tskh6ltr79o0ar41v928ep4c9gtgdi7q', '80', '2011-03-21 12:08:55', '2011-03-21 12:08:55', '1');
INSERT INTO `sessions` VALUES ('1882', '75t010ia09a32bnto3268umr6806vhmk', '80', '2011-03-21 13:56:32', '2011-03-21 13:56:32', '0');
INSERT INTO `sessions` VALUES ('1883', '75t010ia09a32bnto3268umr6806vhmk', '80', '2011-03-21 13:56:32', '2011-03-21 13:56:32', '1');
INSERT INTO `sessions` VALUES ('1884', 'jadfmkfjd568j2daq65imbem4tmkj2ru', '132', '2011-03-22 17:53:33', '2011-03-22 18:01:28', '1');
INSERT INTO `sessions` VALUES ('1885', 'cgnra7mgkvar5pgqfmk9cfafpp0d0d47', '94', '2011-03-23 16:22:21', '2011-03-23 16:22:21', '0');
INSERT INTO `sessions` VALUES ('1886', 'cgnra7mgkvar5pgqfmk9cfafpp0d0d47', '94', '2011-03-23 16:22:21', '2011-03-23 16:22:22', '0');
INSERT INTO `sessions` VALUES ('1887', 'cgnra7mgkvar5pgqfmk9cfafpp0d0d47', '94', '2011-03-23 16:22:22', '2011-03-23 16:22:27', '1');
INSERT INTO `sessions` VALUES ('1888', '6gtmt9678c8ba0gc9rcdbr4t4m3bn3da', '80', '2011-03-24 13:34:52', '2011-03-24 13:35:08', '0');
INSERT INTO `sessions` VALUES ('1889', '6gtmt9678c8ba0gc9rcdbr4t4m3bn3da', '80', '2011-03-24 13:35:08', '2011-03-24 13:38:28', '1');
INSERT INTO `sessions` VALUES ('1890', '665pddtqceg752nsauonmint6gvnh04g', '127', '2011-03-24 14:00:02', '2011-03-24 14:00:04', '0');
INSERT INTO `sessions` VALUES ('1891', '665pddtqceg752nsauonmint6gvnh04g', '127', '2011-03-24 14:00:04', '2011-03-25 17:00:09', '1');
INSERT INTO `sessions` VALUES ('1892', 'ps91qks2gdfk19t37fqhhpp8u43eo9e6', '94', '2011-03-25 11:41:29', '2011-03-25 11:41:29', '0');
INSERT INTO `sessions` VALUES ('1893', 'ps91qks2gdfk19t37fqhhpp8u43eo9e6', '94', '2011-03-25 11:41:29', '2011-03-25 11:41:31', '0');
INSERT INTO `sessions` VALUES ('1894', 'ps91qks2gdfk19t37fqhhpp8u43eo9e6', '94', '2011-03-25 11:41:31', '2011-03-25 14:24:09', '1');
INSERT INTO `sessions` VALUES ('1895', 'h75s8p60m0bgu8muqq567scsb7gaad95', '80', '2011-03-28 11:39:13', '2011-03-28 11:41:02', '1');
INSERT INTO `sessions` VALUES ('1896', 'dolctp7a9u1qfnm7qih62sic0enit8b6', '8', '2011-03-29 08:07:50', '2011-03-29 08:51:32', '0');
INSERT INTO `sessions` VALUES ('1897', 'dolctp7a9u1qfnm7qih62sic0enit8b6', '172', '2011-03-29 08:54:39', '2011-03-29 09:14:34', '0');
INSERT INTO `sessions` VALUES ('1898', 'dolctp7a9u1qfnm7qih62sic0enit8b6', '8', '2011-03-29 09:14:46', '2011-03-29 09:42:06', '0');
INSERT INTO `sessions` VALUES ('1899', 'dolctp7a9u1qfnm7qih62sic0enit8b6', '172', '2011-03-29 09:42:17', '2011-03-29 10:38:07', '1');
INSERT INTO `sessions` VALUES ('1900', 'lbnuiloh5no35dejphtipateae5nn9n6', '172', '2011-03-29 12:28:37', '2011-03-29 12:28:37', '1');
INSERT INTO `sessions` VALUES ('1901', 'tk9tnb2p7el030k8m54km7g836s507i6', '160', '2011-03-29 13:11:06', '2011-03-29 14:58:31', '1');
INSERT INTO `sessions` VALUES ('1902', 'ame5ctbm61g7sq8j3ig558aelpei526a', '177', '2011-03-29 13:14:08', '2011-03-29 14:25:39', '1');
INSERT INTO `sessions` VALUES ('1903', '2thgik9qiluk9aa1l8i1l088bf741a27', '175', '2011-03-29 13:14:15', '2011-03-29 14:36:08', '0');
INSERT INTO `sessions` VALUES ('1904', 'k3ujs5fu5e0fbrn14ggu1bjcgt170bou', '174', '2011-03-29 13:14:20', '2011-03-29 14:48:17', '1');
INSERT INTO `sessions` VALUES ('1905', 'u7dd9mre4pje76lufpfc0ovjdfgqb6c6', '176', '2011-03-29 13:14:22', '2011-03-29 14:25:47', '1');
INSERT INTO `sessions` VALUES ('1906', 'l1p97h7u2hhq8e0r5j081h1kmqqsk2pe', '173', '2011-03-29 13:14:22', '2011-03-29 14:27:24', '1');
INSERT INTO `sessions` VALUES ('1907', 'darhu9q483j019h30vom4r6ilhl2e7ft', '178', '2011-03-29 13:15:12', '2011-03-29 14:25:08', '1');
INSERT INTO `sessions` VALUES ('1908', '6o32pgrs5rs0c3n09137btso9c4bse98', '179', '2011-03-29 13:16:10', '2011-03-29 15:03:19', '0');
INSERT INTO `sessions` VALUES ('1909', '6ilptm1d0nlab330a2r37muulbmm5nep', '160', '2011-03-29 13:29:29', '2011-03-29 13:29:29', '1');
INSERT INTO `sessions` VALUES ('1910', 'ei1kggdcpu3ios4jnbseaopf8d4hlc4d', '160', '2011-03-29 13:30:35', '2011-03-29 13:30:44', '0');
INSERT INTO `sessions` VALUES ('1911', 'ei1kggdcpu3ios4jnbseaopf8d4hlc4d', '160', '2011-03-29 13:30:44', '2011-03-29 13:30:44', '1');
INSERT INTO `sessions` VALUES ('1912', 'gikafatk0tf1sm5rso8kchdvcb90l23i', '160', '2011-03-29 13:34:35', '2011-03-29 13:34:35', '0');
INSERT INTO `sessions` VALUES ('1913', 'gikafatk0tf1sm5rso8kchdvcb90l23i', '160', '2011-03-29 13:34:35', '2011-03-29 13:34:50', '0');
INSERT INTO `sessions` VALUES ('1914', 'gikafatk0tf1sm5rso8kchdvcb90l23i', '160', '2011-03-29 13:34:50', '2011-03-29 13:34:50', '1');
INSERT INTO `sessions` VALUES ('1915', 'pcpp6opr09i33hbiq5f80fkegmbqitcg', '180', '2011-03-29 13:59:09', '2011-03-29 14:24:28', '1');
INSERT INTO `sessions` VALUES ('1916', '4oot0bdlm0clif8h6890d2d5ddd5l8mp', '174', '2011-03-29 17:01:30', '2011-03-29 17:03:44', '0');
INSERT INTO `sessions` VALUES ('1917', 'u2ftqhujgcab31mc4bvl9po69iaibqp2', '180', '2011-03-29 18:13:54', '2011-03-29 18:13:54', '1');
INSERT INTO `sessions` VALUES ('1918', '8k6o7g09ikh6lcn7t17m7ho263lqb06a', '172', '2011-03-30 07:33:43', '2011-03-30 07:38:19', '1');
INSERT INTO `sessions` VALUES ('1919', 'at2p7t8pdk1hrg0naj879g75hjtdc1cm', '8', '2011-03-30 07:42:44', '2011-03-30 07:43:01', '1');
INSERT INTO `sessions` VALUES ('1920', 'o7pifl7vim60v169sghlp2igk2m537sa', '165', '2011-03-30 08:12:28', '2011-03-30 08:12:49', '1');
INSERT INTO `sessions` VALUES ('1921', 'u9caskgs2a8ilomdnjnl8b0bo797uthn', '81', '2011-03-30 10:03:47', '2011-03-30 17:23:10', '0');
INSERT INTO `sessions` VALUES ('1922', '4oot0bdlm0clif8h6890d2d5ddd5l8mp', '174', '2011-03-30 11:13:00', '2011-03-30 11:13:00', '0');
INSERT INTO `sessions` VALUES ('1923', '4oot0bdlm0clif8h6890d2d5ddd5l8mp', '174', '2011-03-30 11:13:00', '2011-03-30 11:13:11', '0');
INSERT INTO `sessions` VALUES ('1924', '4oot0bdlm0clif8h6890d2d5ddd5l8mp', '174', '2011-03-30 11:13:18', '2011-03-30 11:14:58', '0');
INSERT INTO `sessions` VALUES ('1925', '4oot0bdlm0clif8h6890d2d5ddd5l8mp', '174', '2011-03-30 11:18:02', '2011-03-30 11:18:02', '1');
INSERT INTO `sessions` VALUES ('1926', '6q8kodstmee6p1br6bg15fo5o7rhge1p', '172', '2011-03-30 12:06:05', '2011-03-30 12:06:05', '0');
INSERT INTO `sessions` VALUES ('1927', '6q8kodstmee6p1br6bg15fo5o7rhge1p', '172', '2011-03-30 12:06:05', '2011-03-30 12:06:18', '1');
INSERT INTO `sessions` VALUES ('1928', '6q8kodstmee6p1br6bg15fo5o7rhge1p', '8', '2011-03-30 12:06:18', '2011-03-30 12:06:18', '1');
INSERT INTO `sessions` VALUES ('1929', '19pcc5k33dh4q2ehbr4t4mgvau42ruk5', '80', '2011-03-30 14:19:57', '2011-03-30 14:20:11', '0');
INSERT INTO `sessions` VALUES ('1930', '19pcc5k33dh4q2ehbr4t4mgvau42ruk5', '80', '2011-03-30 14:20:11', '2011-03-30 21:24:48', '1');
INSERT INTO `sessions` VALUES ('1931', 't6142dg49ntgu1veq62okproojf913rq', '180', '2011-03-30 15:56:00', '2011-03-30 15:56:00', '1');
INSERT INTO `sessions` VALUES ('1932', 'snqu0jmgb22ohoagljj24q9c9sd8i31g', '180', '2011-03-30 19:04:56', '2011-03-30 19:04:56', '1');
INSERT INTO `sessions` VALUES ('1933', 'ulvbfllr2rvoeaqq0po1jaerm367nta5', '165', '2011-03-31 03:55:00', '2011-03-31 03:55:01', '1');
INSERT INTO `sessions` VALUES ('1934', '7k1vti1cb0mbsgi9r4dfhu9mgn1hvf21', '181', '2011-03-31 12:38:57', '2011-03-31 18:25:39', '1');
INSERT INTO `sessions` VALUES ('1935', '3p3v5dentc4skgk24188ghkg7nfspls2', '172', '2011-03-31 13:23:14', '2011-03-31 13:23:29', '1');
INSERT INTO `sessions` VALUES ('1936', 'nma2ru45gse7rprakc94datqcakk6r5m', '172', '2011-03-31 13:29:49', '2011-03-31 14:24:08', '1');
INSERT INTO `sessions` VALUES ('1937', 'onpt6ip4ndbrmskj0lab9ss95j14a619', '172', '2011-03-31 23:44:29', '2011-03-31 23:44:29', '1');
INSERT INTO `sessions` VALUES ('1938', 'pdipbd5aqsvq6emmsnfihqmt0fn4btnf', '172', '2011-04-01 02:43:20', '2011-04-01 02:43:20', '1');
INSERT INTO `sessions` VALUES ('1939', 'apcn49debf4fk7ltrfsno197jrb6b8m9', '180', '2011-04-01 15:10:18', '2011-04-01 15:10:18', '1');
INSERT INTO `sessions` VALUES ('1940', 'adkfbenv3pj1r8adv5b2k12b8oeltr20', '180', '2011-04-01 18:57:50', '2011-04-01 18:57:50', '1');
INSERT INTO `sessions` VALUES ('1941', 'el3cpu8a5fv4747uo0olq8r6blg43ed3', '172', '2011-04-01 23:00:43', '2011-04-01 23:00:43', '1');
INSERT INTO `sessions` VALUES ('1942', 'ov509g3v6luhukaa2r7gulbmf7g3cmu0', '172', '2011-04-02 00:44:50', '2011-04-02 00:44:50', '1');
INSERT INTO `sessions` VALUES ('1943', 'kn5uv501r8mhpf5eh7c6f7tgqu19p97v', '172', '2011-04-02 02:31:52', '2011-04-02 02:31:52', '1');
INSERT INTO `sessions` VALUES ('1944', 'pmkj0kp9ffsj37h0rpgk3rinn8d9e98e', '180', '2011-04-02 16:26:28', '2011-04-02 16:26:28', '1');
INSERT INTO `sessions` VALUES ('1945', '66h18q6haln22egjdk70fd0bluk7vv0m', '172', '2011-04-02 17:56:51', '2011-04-02 17:56:51', '1');
INSERT INTO `sessions` VALUES ('1946', 'mind2qnqo8kq7pdfskotj0iui997kprp', '132', '2011-04-02 22:40:22', '2011-04-02 22:40:22', '0');
INSERT INTO `sessions` VALUES ('1947', 'mind2qnqo8kq7pdfskotj0iui997kprp', '132', '2011-04-02 22:40:22', '2011-04-02 22:40:29', '0');
INSERT INTO `sessions` VALUES ('1948', 'mind2qnqo8kq7pdfskotj0iui997kprp', '132', '2011-04-02 22:41:39', '2011-04-02 22:41:39', '1');
INSERT INTO `sessions` VALUES ('1949', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-03 13:53:52', '2011-04-03 13:53:52', '0');
INSERT INTO `sessions` VALUES ('1950', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-03 13:53:52', '2011-04-03 13:54:12', '0');
INSERT INTO `sessions` VALUES ('1951', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-03 13:54:12', '2011-04-05 10:23:50', '0');
INSERT INTO `sessions` VALUES ('1952', 'rv6jc8s563h5td150s82p2rp6l52fvbv', '8', '2011-04-03 16:02:01', '2011-04-03 16:02:02', '0');
INSERT INTO `sessions` VALUES ('1953', 'rv6jc8s563h5td150s82p2rp6l52fvbv', '8', '2011-04-03 16:02:02', '2011-04-03 16:02:02', '0');
INSERT INTO `sessions` VALUES ('1954', 'rv6jc8s563h5td150s82p2rp6l52fvbv', '8', '2011-04-03 16:02:02', '2011-04-03 17:00:11', '0');
INSERT INTO `sessions` VALUES ('1955', 'gmmukt7g424pief9vou6qe2fd9ore1l4', '8', '2011-04-03 16:48:21', '2011-04-03 16:55:24', '0');
INSERT INTO `sessions` VALUES ('1956', 'gmmukt7g424pief9vou6qe2fd9ore1l4', '8', '2011-04-03 16:56:19', '2011-04-03 16:56:24', '1');
INSERT INTO `sessions` VALUES ('1957', '8r48r3la7ln10hnn8gnl0lsusascarcl', '172', '2011-04-03 17:41:22', '2011-04-03 17:41:22', '1');
INSERT INTO `sessions` VALUES ('1958', '40pmujp0hoke6mv1jo9no4g3oi8fdlsl', '172', '2011-04-04 14:13:27', '2011-04-04 14:13:27', '1');
INSERT INTO `sessions` VALUES ('1959', 'f3uv7fsu6qtd42e2svub7oa2uepv2mfb', '180', '2011-04-04 20:58:05', '2011-04-04 20:58:05', '1');
INSERT INTO `sessions` VALUES ('1960', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-05 10:23:50', '2011-04-05 10:23:50', '0');
INSERT INTO `sessions` VALUES ('1961', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-05 10:23:50', '2011-04-05 10:23:50', '0');
INSERT INTO `sessions` VALUES ('1962', '86eg3ddsub8ksfs4j7n3khfsubg72krn', '8', '2011-04-05 10:57:05', '2011-04-05 10:57:15', '1');
INSERT INTO `sessions` VALUES ('1963', 'k2d5dus231033bcn4n6ofpkh5acjitts', '100', '2011-04-05 11:06:49', '2011-04-05 11:07:09', '0');
INSERT INTO `sessions` VALUES ('1964', 'mcnj8fv8ipo73j6l0ed9pdi5bs4ev75k', '165', '2011-04-06 08:56:04', '2011-04-06 08:56:04', '0');
INSERT INTO `sessions` VALUES ('1965', 'mcnj8fv8ipo73j6l0ed9pdi5bs4ev75k', '165', '2011-04-06 08:56:04', '2011-04-06 08:56:07', '0');
INSERT INTO `sessions` VALUES ('1966', 'mcnj8fv8ipo73j6l0ed9pdi5bs4ev75k', '165', '2011-04-06 08:56:07', '2011-04-06 09:01:11', '1');
INSERT INTO `sessions` VALUES ('1967', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-06 10:34:07', '2011-04-06 10:34:07', '0');
INSERT INTO `sessions` VALUES ('1968', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-06 10:34:07', '2011-04-06 11:02:30', '0');
INSERT INTO `sessions` VALUES ('1969', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-06 11:02:30', '2011-04-06 13:17:57', '0');
INSERT INTO `sessions` VALUES ('1970', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-06 13:17:57', '2011-04-07 09:20:23', '0');
INSERT INTO `sessions` VALUES ('1971', 'untqk04g4hvfe4ujp3fb0ujmh0mtse0d', '172', '2011-04-06 19:15:12', '2011-04-06 19:15:12', '1');
INSERT INTO `sessions` VALUES ('1972', 'ld9iad04kdu91l1lk1tu5k61f6brjrrn', '172', '2011-04-07 00:55:22', '2011-04-07 00:55:22', '1');
INSERT INTO `sessions` VALUES ('1973', '0i1j237p9l15ilobs21jdntj4qse7301', '165', '2011-04-07 05:57:54', '2011-04-07 05:57:57', '0');
INSERT INTO `sessions` VALUES ('1974', '0i1j237p9l15ilobs21jdntj4qse7301', '165', '2011-04-07 05:57:57', '2011-04-07 05:58:06', '1');
INSERT INTO `sessions` VALUES ('1975', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-07 10:03:53', '2011-04-07 10:04:08', '0');
INSERT INTO `sessions` VALUES ('1976', 'l86timnjicajqmse43u9e1oe7k7u6j4j', '80', '2011-04-07 10:04:08', '2011-04-07 10:39:19', '1');
INSERT INTO `sessions` VALUES ('1977', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-07 14:46:17', '2011-04-07 16:20:07', '0');
INSERT INTO `sessions` VALUES ('1978', 's0g1183pl0cobk178vqg9nsoepua664p', '172', '2011-04-07 17:10:39', '2011-04-07 17:10:39', '1');
INSERT INTO `sessions` VALUES ('1979', 'e54aqcfmlvkeclutc9uvberjad9s9b2e', '172', '2011-04-08 00:54:18', '2011-04-08 00:54:18', '1');
INSERT INTO `sessions` VALUES ('1980', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-08 13:13:45', '2011-04-09 11:22:39', '0');
INSERT INTO `sessions` VALUES ('1981', '266c1gon882qtanngp0psppm2g902qkr', '172', '2011-04-09 01:21:32', '2011-04-09 01:21:32', '1');
INSERT INTO `sessions` VALUES ('1982', '476forg9gto5hapndq3927sk9fqtgmal', '172', '2011-04-09 19:37:40', '2011-04-09 19:37:40', '1');
INSERT INTO `sessions` VALUES ('1983', '09k459tfn11ks1ifjsb66s44k5lv6d5r', '172', '2011-04-10 15:18:33', '2011-04-10 15:18:33', '1');
INSERT INTO `sessions` VALUES ('1984', '6e6jmu9cfp29rm18e0gqfg5ed1teqtob', '172', '2011-04-10 18:00:49', '2011-04-10 18:00:49', '1');
INSERT INTO `sessions` VALUES ('1985', '20102qn3t36gon8oj994op6v3ga1pecb', '172', '2011-04-10 20:09:44', '2011-04-10 20:09:44', '1');
INSERT INTO `sessions` VALUES ('1986', '4s523llge149ken3ulqgps4pabu60qu9', '172', '2011-04-10 23:24:26', '2011-04-10 23:24:26', '1');
INSERT INTO `sessions` VALUES ('1987', '0is83fhtmeaiqvsd3558apfvjgr5f7ko', '172', '2011-04-11 01:50:03', '2011-04-11 01:50:03', '1');
INSERT INTO `sessions` VALUES ('1988', '8k6nd035mciaigb2biqdieulhfde9pnr', '8', '2011-04-11 11:03:58', '2011-04-11 11:03:58', '0');
INSERT INTO `sessions` VALUES ('1989', '8k6nd035mciaigb2biqdieulhfde9pnr', '8', '2011-04-11 11:03:58', '2011-04-11 11:04:06', '0');
INSERT INTO `sessions` VALUES ('1990', '8k6nd035mciaigb2biqdieulhfde9pnr', '8', '2011-04-11 11:04:06', '2011-04-11 11:04:06', '1');
INSERT INTO `sessions` VALUES ('1991', '3o2h78v5d0i4utq90p7g0gbitnd9h99e', '172', '2011-04-11 13:59:22', '2011-04-11 13:59:22', '1');
INSERT INTO `sessions` VALUES ('1992', '4b27btam6enlu99t1agqpqmi93hfk4a3', '172', '2011-04-11 17:16:38', '2011-04-11 17:16:38', '1');
INSERT INTO `sessions` VALUES ('1993', 'hfrua4i44re25k7h5j75f94a1tm8a5qm', '172', '2011-04-11 18:46:18', '2011-04-11 18:46:18', '1');
INSERT INTO `sessions` VALUES ('1994', 'gbl4pacea8c1jl8dqjvqbt35qgpr68ur', '172', '2011-04-11 20:02:55', '2011-04-11 20:02:55', '1');
INSERT INTO `sessions` VALUES ('1995', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-13 10:16:08', '2011-04-13 10:16:08', '0');
INSERT INTO `sessions` VALUES ('1996', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-13 10:16:08', '2011-04-13 10:16:10', '0');
INSERT INTO `sessions` VALUES ('1997', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-13 10:16:10', '2011-04-13 16:16:05', '0');
INSERT INTO `sessions` VALUES ('1998', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-13 16:16:05', '2011-04-15 10:14:35', '0');
INSERT INTO `sessions` VALUES ('1999', 'jktm2kas7j8vc37da07gv48nagrglurd', '8', '2011-04-14 15:51:14', '2011-04-14 15:52:38', '0');
INSERT INTO `sessions` VALUES ('2000', 'jktm2kas7j8vc37da07gv48nagrglurd', '8', '2011-04-14 15:52:38', '2011-04-14 15:52:38', '1');
INSERT INTO `sessions` VALUES ('2001', 'u7tg1taviouhbcsb1arn5i5vukv7n8a2', '8', '2011-04-14 17:25:46', '2011-04-14 17:26:10', '0');
INSERT INTO `sessions` VALUES ('2002', 'u7tg1taviouhbcsb1arn5i5vukv7n8a2', '8', '2011-04-14 17:26:10', '2011-04-14 17:26:33', '1');
INSERT INTO `sessions` VALUES ('2003', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-15 10:14:35', '2011-04-15 10:14:37', '0');
INSERT INTO `sessions` VALUES ('2004', 'p6lp079077rd1sido4pd2bbdnj3etkn5', '94', '2011-04-15 10:14:37', '2011-04-15 12:54:20', '1');
INSERT INTO `sessions` VALUES ('2005', 'ihegbmusdit8j0n1rcaflr4cs6sussdi', '80', '2011-04-15 14:20:20', '2011-04-15 14:20:20', '0');
INSERT INTO `sessions` VALUES ('2006', 'ihegbmusdit8j0n1rcaflr4cs6sussdi', '80', '2011-04-15 14:20:20', '2011-04-15 14:20:34', '0');
INSERT INTO `sessions` VALUES ('2007', 'ihegbmusdit8j0n1rcaflr4cs6sussdi', '80', '2011-04-15 14:20:34', '2011-04-15 14:21:00', '1');
INSERT INTO `sessions` VALUES ('2008', 'ifp8vtkffavgvdc24a7d61q7mpgruoug', '184', '2011-04-18 01:44:13', '2011-04-19 23:00:28', '0');
INSERT INTO `sessions` VALUES ('2009', 'ifp8vtkffavgvdc24a7d61q7mpgruoug', '184', '2011-04-19 23:00:28', '2011-04-21 10:20:29', '1');
INSERT INTO `sessions` VALUES ('2010', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:14:19', '2011-04-20 15:17:01', '0');
INSERT INTO `sessions` VALUES ('2011', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:17:01', '2011-04-20 15:17:01', '0');
INSERT INTO `sessions` VALUES ('2012', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:17:01', '2011-04-20 15:17:39', '0');
INSERT INTO `sessions` VALUES ('2013', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:17:39', '2011-04-20 15:17:39', '0');
INSERT INTO `sessions` VALUES ('2014', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:17:39', '2011-04-20 15:21:23', '0');
INSERT INTO `sessions` VALUES ('2015', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:21:23', '2011-04-20 15:21:32', '0');
INSERT INTO `sessions` VALUES ('2016', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:21:32', '2011-04-20 15:21:33', '0');
INSERT INTO `sessions` VALUES ('2017', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:21:33', '2011-04-20 15:21:33', '0');
INSERT INTO `sessions` VALUES ('2018', 'c2ef8sot33196m6h1kdvrqp016612hm8', '186', '2011-04-20 15:21:33', '2011-04-20 15:25:58', '1');
INSERT INTO `sessions` VALUES ('2019', '02t2mkorff2pi9uhdq3602o9gjcn0r00', '186', '2011-04-20 17:26:27', '2011-04-20 17:26:49', '0');
INSERT INTO `sessions` VALUES ('2020', '02t2mkorff2pi9uhdq3602o9gjcn0r00', '186', '2011-04-20 17:26:49', '2011-04-20 17:26:49', '1');
INSERT INTO `sessions` VALUES ('2021', '1ed92tg245ph8e3oc8583q3n8jlfl661', '186', '2011-04-20 17:33:04', '2011-04-20 17:33:15', '0');
INSERT INTO `sessions` VALUES ('2022', '1ed92tg245ph8e3oc8583q3n8jlfl661', '186', '2011-04-20 17:33:15', '2011-04-20 17:33:27', '1');
INSERT INTO `sessions` VALUES ('2023', 'jivk65h3vraunefjqptv7cv40svrbgj6', '86', '2011-04-22 10:14:46', '2011-04-22 10:51:17', '1');
INSERT INTO `sessions` VALUES ('2024', '87i7tuuidrd51gch20uc3auq8b3v8pu8', '188', '2011-04-25 16:43:33', '2011-04-25 17:00:40', '1');
INSERT INTO `sessions` VALUES ('2025', 'q6gci3ah1tc2h239unk7aikmsokuj7m1', '188', '2011-04-25 18:39:22', '2011-04-25 18:39:36', '1');
INSERT INTO `sessions` VALUES ('2026', '9gtlmv04a37kfr1js5dkkjcjsohiri74', '189', '2011-04-26 08:21:26', '2011-04-26 12:32:34', '1');
INSERT INTO `sessions` VALUES ('2027', 'loouq2liijck0c3jndvpts19mdle443q', '189', '2011-04-26 13:00:37', '2011-04-26 13:01:51', '1');
INSERT INTO `sessions` VALUES ('2028', '33n6l83srcudfiv7l9k24dd2cqsbh2gj', '188', '2011-04-26 15:51:27', '2011-04-26 15:51:27', '0');
INSERT INTO `sessions` VALUES ('2029', '33n6l83srcudfiv7l9k24dd2cqsbh2gj', '188', '2011-04-26 15:51:27', '2011-04-26 15:51:30', '0');
INSERT INTO `sessions` VALUES ('2030', '33n6l83srcudfiv7l9k24dd2cqsbh2gj', '188', '2011-04-26 15:51:30', '2011-04-26 15:51:51', '1');
INSERT INTO `sessions` VALUES ('2031', 'rcjfuao6vbcb8083qt2h2bbt79ukudsa', '80', '2011-04-27 10:23:12', '2011-04-27 10:23:12', '0');
INSERT INTO `sessions` VALUES ('2032', 'rcjfuao6vbcb8083qt2h2bbt79ukudsa', '80', '2011-04-27 10:23:12', '2011-04-27 10:23:25', '0');
INSERT INTO `sessions` VALUES ('2033', 'rcjfuao6vbcb8083qt2h2bbt79ukudsa', '80', '2011-04-27 10:23:25', '2011-04-27 10:34:35', '1');
INSERT INTO `sessions` VALUES ('2034', '30eudsd3id8sg506kkn78sfb26c21tj4', '94', '2011-04-27 13:24:05', '2011-04-28 09:22:19', '0');
INSERT INTO `sessions` VALUES ('2035', 'qpc1tc8s20svn4n43qh6134f5oib7ter', '80', '2011-04-28 10:32:02', '2011-04-28 10:32:02', '0');
INSERT INTO `sessions` VALUES ('2036', 'qpc1tc8s20svn4n43qh6134f5oib7ter', '80', '2011-04-28 10:32:02', '2011-04-28 10:32:13', '0');
INSERT INTO `sessions` VALUES ('2037', 'qpc1tc8s20svn4n43qh6134f5oib7ter', '80', '2011-04-28 10:32:13', '2011-04-28 11:17:01', '1');
INSERT INTO `sessions` VALUES ('2038', '4gef7ibm51cl7bmccm7j52laal7ce29d', '188', '2011-04-28 11:21:10', '2011-04-28 11:21:10', '0');
INSERT INTO `sessions` VALUES ('2039', '4gef7ibm51cl7bmccm7j52laal7ce29d', '188', '2011-04-28 11:21:10', '2011-04-28 11:21:12', '0');
INSERT INTO `sessions` VALUES ('2040', '4gef7ibm51cl7bmccm7j52laal7ce29d', '188', '2011-04-28 11:21:12', '2011-04-28 11:21:47', '1');
INSERT INTO `sessions` VALUES ('2041', '30eudsd3id8sg506kkn78sfb26c21tj4', '94', '2011-04-28 14:46:42', '2011-04-28 14:46:42', '0');
INSERT INTO `sessions` VALUES ('2042', '30eudsd3id8sg506kkn78sfb26c21tj4', '94', '2011-04-28 14:46:42', '2011-04-28 14:46:45', '0');
INSERT INTO `sessions` VALUES ('2043', '30eudsd3id8sg506kkn78sfb26c21tj4', '94', '2011-04-28 14:46:45', '2011-04-28 14:46:45', '1');
INSERT INTO `sessions` VALUES ('2044', '6qjvpug1p5kr12vtsoft69hcvmh2ji2m', '190', '2011-04-29 06:32:47', '2011-04-29 07:19:13', '1');
INSERT INTO `sessions` VALUES ('2045', 'g6pj121r67tn7cigh2emsaju3itmiln1', '133', '2011-04-29 10:35:47', '2011-04-29 10:36:06', '0');
INSERT INTO `sessions` VALUES ('2046', 'g6pj121r67tn7cigh2emsaju3itmiln1', '133', '2011-04-29 10:36:06', '2011-04-29 10:36:06', '1');
INSERT INTO `sessions` VALUES ('2047', 'bhjlp9qiru1vhhop1f0g578k4do9nst8', '81', '2011-04-29 18:09:11', '2011-04-29 18:09:53', '0');
INSERT INTO `sessions` VALUES ('2048', 'f95h9seioussjhkmeq1io69gblvv9pni', '189', '2011-04-30 02:34:38', '2011-04-30 02:34:42', '0');
INSERT INTO `sessions` VALUES ('2049', 'f95h9seioussjhkmeq1io69gblvv9pni', '189', '2011-04-30 02:34:42', '2011-04-30 02:37:15', '1');
INSERT INTO `sessions` VALUES ('2050', 'lq0vgbnaruvvfb4s2j49qqjk1r356a3n', '188', '2011-04-30 19:21:07', '2011-04-30 19:21:10', '0');
INSERT INTO `sessions` VALUES ('2051', 'lq0vgbnaruvvfb4s2j49qqjk1r356a3n', '188', '2011-04-30 19:21:10', '2011-05-01 11:52:19', '1');
INSERT INTO `sessions` VALUES ('2052', 'ht43c0hgbeib3ftutaf6jrhl74op392t', '188', '2011-05-01 18:15:09', '2011-05-01 18:15:09', '0');
INSERT INTO `sessions` VALUES ('2053', 'ht43c0hgbeib3ftutaf6jrhl74op392t', '188', '2011-05-01 18:15:09', '2011-05-01 18:15:10', '0');
INSERT INTO `sessions` VALUES ('2054', 'ht43c0hgbeib3ftutaf6jrhl74op392t', '188', '2011-05-01 18:15:10', '2011-05-01 18:19:36', '1');
INSERT INTO `sessions` VALUES ('2055', '01cco5dldvcgvl6qk693qqqkf8fbcqof', '188', '2011-05-02 01:08:35', '2011-05-02 01:08:35', '0');
INSERT INTO `sessions` VALUES ('2056', '01cco5dldvcgvl6qk693qqqkf8fbcqof', '188', '2011-05-02 01:08:35', '2011-05-02 01:08:37', '0');
INSERT INTO `sessions` VALUES ('2057', '01cco5dldvcgvl6qk693qqqkf8fbcqof', '188', '2011-05-02 01:08:37', '2011-05-02 01:08:37', '1');
INSERT INTO `sessions` VALUES ('2058', 'h4ielkshaoempnbo1ie2lrve44p3m7q3', '165', '2011-05-02 03:59:44', '2011-05-02 04:12:14', '0');
INSERT INTO `sessions` VALUES ('2059', 'h4ielkshaoempnbo1ie2lrve44p3m7q3', '165', '2011-05-02 04:12:14', '2011-05-02 04:12:14', '1');
INSERT INTO `sessions` VALUES ('2060', 'tsd5ucnrakib14k4vl2ddt07r3tceumh', '94', '2011-05-02 15:55:11', '2011-05-02 15:55:11', '0');
INSERT INTO `sessions` VALUES ('2061', 'tsd5ucnrakib14k4vl2ddt07r3tceumh', '94', '2011-05-02 15:55:11', '2011-05-02 15:55:13', '0');
INSERT INTO `sessions` VALUES ('2062', 'tsd5ucnrakib14k4vl2ddt07r3tceumh', '94', '2011-05-02 15:55:13', '2011-05-02 15:55:23', '1');
INSERT INTO `sessions` VALUES ('2063', 'bjt93s4g7d223h3kccpkfh0oqbfnl0l7', '80', '2011-05-03 09:48:23', '2011-05-03 09:48:23', '0');
INSERT INTO `sessions` VALUES ('2064', 'bjt93s4g7d223h3kccpkfh0oqbfnl0l7', '80', '2011-05-03 09:48:23', '2011-05-03 09:48:27', '0');
INSERT INTO `sessions` VALUES ('2065', 'bjt93s4g7d223h3kccpkfh0oqbfnl0l7', '80', '2011-05-03 09:48:41', '2011-05-03 09:50:16', '0');
INSERT INTO `sessions` VALUES ('2066', 'bjt93s4g7d223h3kccpkfh0oqbfnl0l7', '80', '2011-05-03 09:50:36', '2011-05-03 10:40:46', '0');
INSERT INTO `sessions` VALUES ('2067', 'bjt93s4g7d223h3kccpkfh0oqbfnl0l7', '80', '2011-05-03 11:09:52', '2011-05-03 11:18:55', '1');
INSERT INTO `sessions` VALUES ('2068', 'fkqb4dc4ojn2vge0dqeptvrr2kldjus4', '8', '2011-05-03 15:11:34', '2011-05-03 15:13:08', '0');
INSERT INTO `sessions` VALUES ('2069', 'fkqb4dc4ojn2vge0dqeptvrr2kldjus4', '172', '2011-05-03 15:13:22', '2011-05-03 15:16:23', '1');
INSERT INTO `sessions` VALUES ('2070', '1f00eppe3rdti1n17n3f4kgh94qlpiuk', '94', '2011-05-03 22:15:05', '2011-05-03 22:15:05', '0');
INSERT INTO `sessions` VALUES ('2071', '1f00eppe3rdti1n17n3f4kgh94qlpiuk', '94', '2011-05-03 22:15:05', '2011-05-03 22:15:08', '0');
INSERT INTO `sessions` VALUES ('2072', '1f00eppe3rdti1n17n3f4kgh94qlpiuk', '94', '2011-05-03 22:15:08', '2011-05-05 18:40:40', '1');
INSERT INTO `sessions` VALUES ('2073', 'bhjlp9qiru1vhhop1f0g578k4do9nst8', '81', '2011-05-05 11:17:48', '2011-05-06 10:32:25', '0');
INSERT INTO `sessions` VALUES ('2074', 'a8kkbceqp4vvqi466k40d3ofetav9ekb', '165', '2011-05-07 10:07:51', '2011-05-07 10:10:44', '1');
INSERT INTO `sessions` VALUES ('2075', 'qovhr259me9mfti8t71f4spvq3keu193', '94', '2011-05-09 09:29:55', '2011-05-09 09:29:55', '0');
INSERT INTO `sessions` VALUES ('2076', 'qovhr259me9mfti8t71f4spvq3keu193', '94', '2011-05-09 09:29:55', '2011-05-09 09:29:58', '0');
INSERT INTO `sessions` VALUES ('2077', 'qovhr259me9mfti8t71f4spvq3keu193', '94', '2011-05-09 09:29:58', '2011-05-09 09:29:58', '0');
INSERT INTO `sessions` VALUES ('2078', 'qovhr259me9mfti8t71f4spvq3keu193', '94', '2011-05-10 05:59:10', '2011-05-10 05:59:11', '1');
INSERT INTO `sessions` VALUES ('2079', 'ems1b4nberrekftdclcrm8pmvakh6j6e', '80', '2011-05-11 10:40:42', '2011-05-16 13:04:56', '1');
INSERT INTO `sessions` VALUES ('2080', 'nb6m0t8k7oijh5qndlarn6p43b9tklig', '80', '2011-05-13 10:21:18', '2011-05-15 21:01:57', '1');
INSERT INTO `sessions` VALUES ('2081', '6g659eoth63quufo9ndf39ibsbkraf6s', '191', '2011-05-13 13:08:07', '2011-05-13 13:09:44', '1');
INSERT INTO `sessions` VALUES ('2082', 'dv54cvcbp1ifcjb6clafujsngofjsing', '94', '2011-05-15 18:14:46', '2011-05-15 18:14:46', '0');
INSERT INTO `sessions` VALUES ('2083', 'dv54cvcbp1ifcjb6clafujsngofjsing', '94', '2011-05-15 18:14:46', '2011-05-15 18:14:48', '0');
INSERT INTO `sessions` VALUES ('2084', 'dv54cvcbp1ifcjb6clafujsngofjsing', '94', '2011-05-15 18:14:48', '2011-05-15 18:17:31', '1');
INSERT INTO `sessions` VALUES ('2085', '60l3lun0dpv7ttam4qeql0n6o6kcp50s', '192', '2011-05-16 10:41:48', '2011-05-16 11:37:29', '1');
INSERT INTO `sessions` VALUES ('2086', 'pcbun50lioc98p87sc5b738onrm2j3h9', '187', '2011-05-16 11:04:59', '2011-05-16 11:06:35', '0');
INSERT INTO `sessions` VALUES ('2087', 'ggqk25p30fptcsrcf7fhkpoe64u30chb', '187', '2011-05-18 19:24:40', '2011-05-18 19:32:42', '1');
INSERT INTO `sessions` VALUES ('2088', 'jdm5hukpt9i0r2ffhf9rmkqc2flqc4hv', '192', '2011-05-18 19:26:43', '2011-05-18 19:26:43', '1');
INSERT INTO `sessions` VALUES ('2089', 'pg1kj128fac1qlkfbmvlnkij6e8dfsa2', '80', '2011-05-19 21:22:54', '2011-05-19 21:22:54', '0');
INSERT INTO `sessions` VALUES ('2090', 'pg1kj128fac1qlkfbmvlnkij6e8dfsa2', '80', '2011-05-19 21:22:54', '2011-05-19 21:23:09', '0');
INSERT INTO `sessions` VALUES ('2091', 'pg1kj128fac1qlkfbmvlnkij6e8dfsa2', '80', '2011-05-19 21:23:09', '2011-05-20 14:08:48', '1');
INSERT INTO `sessions` VALUES ('2092', 'us7rbbnvqu8uvkgirtv9t7d2ppnufbp2', '80', '2011-05-23 10:11:16', '2011-05-23 10:11:31', '1');
INSERT INTO `sessions` VALUES ('2093', 'huhu05nd1bp1mnve3tbn9en9jii2cpif', '187', '2011-05-23 12:25:38', '2011-05-23 12:25:38', '0');
INSERT INTO `sessions` VALUES ('2094', 'huhu05nd1bp1mnve3tbn9en9jii2cpif', '187', '2011-05-23 12:25:38', '2011-05-23 12:32:04', '1');
INSERT INTO `sessions` VALUES ('2095', 'o4g7viom5psbbbj4irtbnslt52elh0gp', '94', '2011-05-23 16:21:34', '2011-05-23 16:21:34', '0');
INSERT INTO `sessions` VALUES ('2096', 'o4g7viom5psbbbj4irtbnslt52elh0gp', '94', '2011-05-23 16:21:34', '2011-05-23 16:21:35', '0');
INSERT INTO `sessions` VALUES ('2097', 'o4g7viom5psbbbj4irtbnslt52elh0gp', '94', '2011-05-23 16:21:35', '2011-05-23 16:21:38', '1');
INSERT INTO `sessions` VALUES ('2098', 'jbd86a6m4fomcdu7u9c0dookoscr7koc', '94', '2011-05-23 16:22:41', '2011-05-23 16:22:45', '1');
INSERT INTO `sessions` VALUES ('2099', 'ofehoh8memljmhujpioadb2ak4qgjk8e', '80', '2011-05-25 08:43:26', '2011-05-25 08:43:26', '0');
INSERT INTO `sessions` VALUES ('2100', 'ofehoh8memljmhujpioadb2ak4qgjk8e', '80', '2011-05-25 08:43:26', '2011-05-25 08:43:36', '0');
INSERT INTO `sessions` VALUES ('2101', 'ofehoh8memljmhujpioadb2ak4qgjk8e', '80', '2011-05-25 08:43:36', '2011-05-25 08:44:35', '0');
INSERT INTO `sessions` VALUES ('2102', 'ofehoh8memljmhujpioadb2ak4qgjk8e', '8', '2011-05-25 08:44:44', '2011-05-25 10:36:55', '0');
INSERT INTO `sessions` VALUES ('2103', 'gg07n9bhdcama05ohvkbe9g5p4dld22c', '94', '2011-05-25 08:58:45', '2011-05-25 08:58:45', '0');
INSERT INTO `sessions` VALUES ('2104', 'gg07n9bhdcama05ohvkbe9g5p4dld22c', '94', '2011-05-25 08:58:45', '2011-05-25 08:58:48', '0');
INSERT INTO `sessions` VALUES ('2105', 'gg07n9bhdcama05ohvkbe9g5p4dld22c', '94', '2011-05-25 08:58:48', '2011-05-25 09:00:57', '1');
INSERT INTO `sessions` VALUES ('2106', 'ofehoh8memljmhujpioadb2ak4qgjk8e', '80', '2011-05-27 08:27:45', '2011-05-27 12:28:12', '1');

-- ----------------------------
-- Table structure for `settings`
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(1) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `value` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES ('1', 'G', 'LAST_PART_ID', null, 'a086m');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `security_level` varchar(255) NOT NULL DEFAULT 'user',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `last_modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `approved_flag` tinyint(4) DEFAULT '1',
  `position` varchar(255) DEFAULT NULL,
  `why_ask_for_account` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0', 'genocad', 'dcf0464549675363212c879af96d2f2d', 'user', 'Genocad', 'Genocad', '', '', '', '', '', '', '', '', '', '2013-08-06 15:03:08', '1', '', '');
INSERT INTO `users` VALUES ('0', 'admin', 'dcf0464549675363212c879af96d2f2d', 'admin', 'Genocad', 'Genocad', '', '', '', '', '', '', '', '', '', '2013-08-06 15:03:08', '1', '', '');

-- ----------------------------
-- Table structure for `user_searches`
-- ----------------------------
DROP TABLE IF EXISTS `user_searches`;
CREATE TABLE `user_searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `query` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`search_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_searches
-- ----------------------------

-- ----------------------------
-- View structure for `v_parts_browser`
-- ----------------------------
DROP VIEW IF EXISTS `v_parts_browser`;
CREATE ALGORITHM=UNDEFINED DEFINER=`genocad`@`%` SQL SECURITY DEFINER VIEW `v_parts_browser` AS select `p`.`id` AS `id`,`p`.`part_id` AS `part_id`,`p`.`description` AS `part_name`,`p`.`segment` AS `part_segment`,`p`.`user_id` AS `part_user_id`,`p`.`description_text` AS `part_description_text`,date_format(`p`.`date_created`,_utf8'%m/%d/%Y') AS `part_date_created`,date_format(`p`.`last_modified`,_utf8'%m/%d/%Y') AS `part_last_modified`,`c`.`letter` AS `category_letter`,`c`.`description` AS `category_description`,`c`.`category_id` AS `category_id`,`c`.`grammar_id` AS `grammar_id`,`c`.`icon_name` AS `icon_name` from ((`parts` `p` join `categories_parts` `cp`) join `categories` `c`) where ((`p`.`id` = `cp`.`part_id`) and (`cp`.`category_id` = `c`.`category_id`)) ;

-- ----------------------------
-- View structure for `v_part_library`
-- ----------------------------
DROP VIEW IF EXISTS `v_part_library`;
CREATE ALGORITHM=UNDEFINED DEFINER=`genocad`@`%` SQL SECURITY DEFINER VIEW `v_part_library` AS select `parts`.`part_id` AS `part_identifier`,`parts`.`description` AS `part_name`,`parts`.`segment` AS `part_segment`,`categories_parts`.`user_id` AS `part_user_id`,`parts`.`description_text` AS `part_description_text`,`parts`.`last_modified` AS `part_last_modified`,`libraries`.`user_id` AS `library_user_id`,`libraries`.`name` AS `library_name`,`libraries`.`description` AS `library_description`,`libraries`.`last_modified` AS `library_last_modified`,`libraries`.`library_id` AS `library_id`,`categories_parts`.`category_id` AS `part_category_id`,`categories`.`letter` AS `category_letter`,`categories`.`description` AS `category_description`,`parts`.`id` AS `part_id`,`libraries`.`grammar_id` AS `grammar_id`,`categories`.`category_id` AS `category_id` from ((((`parts` join `library_part_join` on((`library_part_join`.`part_id` = `parts`.`id`))) join `libraries` on((`library_part_join`.`library_id` = `libraries`.`library_id`))) join `categories_parts` on(((`categories_parts`.`part_id` = `parts`.`id`) and (`categories_parts`.`user_id` = `parts`.`user_id`)))) join `categories` on((`categories`.`category_id` = `categories_parts`.`category_id`))) ;

-- ----------------------------
-- Procedure structure for `migrate_designs`
-- ----------------------------
DROP PROCEDURE IF EXISTS `migrate_designs`;
DELIMITER ;;
CREATE DEFINER=`mandywil`@`%` PROCEDURE `migrate_designs`()
BEGIN
	DECLARE done INT DEFAULT 0;
       DECLARE part_id_from_str VARCHAR(25);
      DECLARE part_id_to_str VARCHAR(25);
      DECLARE c_parts_migration CURSOR FOR
            SELECT part_id_from_string, part_id_to_string
            FROM temp_part_migration_table;
       DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
      
      OPEN c_parts_migration;

      design_string_loop: LOOP

      FETCH c_parts_migration INTO part_id_from_str, part_id_to_str;

      IF (done < 1) THEN 
        	UPDATE designs SET terminals_json = REPLACE(terminals_json, TRIM(part_id_from_str), TRIM(part_id_to_str));
	 ELSE
	 	LEAVE design_string_loop;
           END IF;
         END LOOP;

        CLOSE c_parts_migration;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getTabCategories`
-- ----------------------------
DROP FUNCTION IF EXISTS `getTabCategories`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getTabCategories`(`part_id` int) RETURNS varchar(100) CHARSET utf8
    READS SQL DATA
BEGIN
	#Routine body goes here...
  DECLARE done INT DEFAULT 0;
  DECLARE returnString VARCHAR(100) DEFAULT '';
  DECLARE categoryLetter VARCHAR(30);
  DECLARE c_parts_migration CURSOR FOR
            SELECT c.letter
            FROM categories_parts cp, categories c
            WHERE cp.part_id = part_id
						AND cp.user_id = 0
						AND c.category_id = cp.category_id;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

  OPEN c_parts_migration;

  make_string_loop: LOOP
		FETCH c_parts_migration INTO categoryLetter;
    
		IF (done < 1) THEN
				IF (LENGTH(returnString) > 0) THEN
					SET returnString := CONCAT(CONCAT(returnString, ','), categoryLetter);
				ELSE
					SET returnString := categoryLetter;
				END IF;
    ELSE
       LEAVE make_string_loop;
		END IF;
	END LOOP;
	CLOSE c_parts_migration;
	RETURN returnString;
END
;;
DELIMITER ;
