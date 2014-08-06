CREATE TABLE `genbank_qualifiers` (
  `genbank_qualifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `qualifier` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`genbank_qualifier_id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of genbank_qualifiers
-- ----------------------------
INSERT INTO genbank_qualifiers VALUES ('1', 'allele', 'Obsolete; see variation feature key');
INSERT INTO genbank_qualifiers VALUES ('2', 'attenuator', 'Sequence related to transcription termination');
INSERT INTO genbank_qualifiers VALUES ('3', 'C_region', 'Span of the C immunological feature');
INSERT INTO genbank_qualifiers VALUES ('4', 'CAAT_signal', '`CAAT box\' in eukaryotic promoters');
INSERT INTO genbank_qualifiers VALUES ('5', 'CDS', 'Sequence coding for amino acids in protein (includes stop codon)');
INSERT INTO genbank_qualifiers VALUES ('6', 'conflict', 'Independent sequence determinations differ');
INSERT INTO genbank_qualifiers VALUES ('7', 'D-loop      ', 'Displacement loop');
INSERT INTO genbank_qualifiers VALUES ('8', 'D_segment', 'Span of the D immunological feature');
INSERT INTO genbank_qualifiers VALUES ('9', 'enhancer', 'Cis-acting enhancer of promoter function');
INSERT INTO genbank_qualifiers VALUES ('10', 'exon', 'Region that codes for part of spliced mRNA');
INSERT INTO genbank_qualifiers VALUES ('11', 'gene            ', 'Region that defines a functional gene, possibly including upstream (promotor, enhancer, etc) and downstream control elements, and for which a name has been assigned.');
INSERT INTO genbank_qualifiers VALUES ('12', 'GC_signal', '`GC box\' in eukaryotic promoters');
INSERT INTO genbank_qualifiers VALUES ('13', 'iDNA', 'Intervening DNA eliminated by recombination');
INSERT INTO genbank_qualifiers VALUES ('14', 'intron', 'Transcribed region excised by mRNA splicing');
INSERT INTO genbank_qualifiers VALUES ('15', 'J_region', 'Span of the J immunological feature');
INSERT INTO genbank_qualifiers VALUES ('16', 'LTR', 'Long terminal repeat');
INSERT INTO genbank_qualifiers VALUES ('17', 'mat_peptide', 'Mature peptide coding region (does not include stop codon)');
INSERT INTO genbank_qualifiers VALUES ('18', 'misc_binding', 'Miscellaneous binding site');
INSERT INTO genbank_qualifiers VALUES ('19', 'misc_difference', 'Miscellaneous difference feature');
INSERT INTO genbank_qualifiers VALUES ('20', 'misc_feature', 'Region of biological significance that cannot be described by any other feature');
INSERT INTO genbank_qualifiers VALUES ('21', 'misc_recomb', 'Miscellaneous recombination feature');
INSERT INTO genbank_qualifiers VALUES ('22', 'misc_RNA', 'Miscellaneous transcript feature not defined by other RNA keys');
INSERT INTO genbank_qualifiers VALUES ('23', 'misc_signal', 'Miscellaneous signal');
INSERT INTO genbank_qualifiers VALUES ('24', 'misc_structure', 'Miscellaneous DNA or RNA structure');
INSERT INTO genbank_qualifiers VALUES ('25', 'modified_base', 'The indicated base is a modified nucleotide');
INSERT INTO genbank_qualifiers VALUES ('26', 'mRNA', 'Messenger RNA');
INSERT INTO genbank_qualifiers VALUES ('27', 'mutation ', 'Obsolete: see variation feature key');
INSERT INTO genbank_qualifiers VALUES ('28', 'N_region', 'Span of the N immunological feature');
INSERT INTO genbank_qualifiers VALUES ('29', 'old_sequence', 'Presented sequence revises a previous version');
INSERT INTO genbank_qualifiers VALUES ('30', 'polyA_signal', 'Signal for cleavage & polyadenylation');
INSERT INTO genbank_qualifiers VALUES ('31', 'polyA_site', 'Site at which polyadenine is added to mRNA');
INSERT INTO genbank_qualifiers VALUES ('32', 'precursor_RNA', 'Any RNA species that is not yet the mature RNA product');
INSERT INTO genbank_qualifiers VALUES ('33', 'prim_transcript', 'Primary (unprocessed) transcript');
INSERT INTO genbank_qualifiers VALUES ('34', 'primer', 'Primer binding region used with PCR');
INSERT INTO genbank_qualifiers VALUES ('35', 'primer_bind', 'Non-covalent primer binding site');
INSERT INTO genbank_qualifiers VALUES ('36', 'promoter', 'A region involved in transcription initiation');
INSERT INTO genbank_qualifiers VALUES ('37', 'protein_bind', 'Non-covalent protein binding site on DNA or RNA');
INSERT INTO genbank_qualifiers VALUES ('38', 'RBS', 'Ribosome binding site');
INSERT INTO genbank_qualifiers VALUES ('39', 'rep_origin', 'Replication origin for duplex DNA');
INSERT INTO genbank_qualifiers VALUES ('40', 'repeat_region', 'Sequence containing repeated subsequences');
INSERT INTO genbank_qualifiers VALUES ('41', 'repeat_unit', 'One repeated unit of a repeat_region');
INSERT INTO genbank_qualifiers VALUES ('42', 'rRNA', 'Ribosomal RNA');
INSERT INTO genbank_qualifiers VALUES ('43', 'S_region', 'Span of the S immunological feature');
INSERT INTO genbank_qualifiers VALUES ('44', 'satellite', 'Satellite repeated sequence');
INSERT INTO genbank_qualifiers VALUES ('45', 'scRNA', 'Small cytoplasmic RNA');
INSERT INTO genbank_qualifiers VALUES ('46', 'sig_peptide', 'Signal peptide coding region');
INSERT INTO genbank_qualifiers VALUES ('47', 'snRNA', 'Small nuclear RNA');
INSERT INTO genbank_qualifiers VALUES ('48', 'source', 'Biological source of the sequence data represented by a GenBank record. Mandatory feature, one or more per record. For organisms that have been incorporated within the qualifier will be present (where');
INSERT INTO genbank_qualifiers VALUES ('49', 'stem_loop', 'Hair-pin loop structure in DNA or RNA');
INSERT INTO genbank_qualifiers VALUES ('50', 'STS', 'Sequence Tagged Site; operationally unique sequence that identifies the combination of primer spans used in a PCR assay');
INSERT INTO genbank_qualifiers VALUES ('51', 'TATA_signal', '`TATA box\' in eukaryotic promoters');
INSERT INTO genbank_qualifiers VALUES ('52', 'terminator', 'Sequence causing transcription termination');
INSERT INTO genbank_qualifiers VALUES ('53', 'transit_peptide', 'Transit peptide coding region');
INSERT INTO genbank_qualifiers VALUES ('54', 'transposon', 'Transposable element (TN)');
INSERT INTO genbank_qualifiers VALUES ('55', 'tRNA ', 'Transfer RNA');
INSERT INTO genbank_qualifiers VALUES ('56', 'unsure', 'Authors are unsure about the sequence in this region');
INSERT INTO genbank_qualifiers VALUES ('57', 'V_region', 'Span of the V immunological feature');
INSERT INTO genbank_qualifiers VALUES ('58', 'variation ', 'A related population contains stable mutation');
INSERT INTO genbank_qualifiers VALUES ('59', '- (hyphen)', 'Placeholder');
INSERT INTO genbank_qualifiers VALUES ('60', '-10_signal', '`Pribnow box\' in prokaryotic promoters');
INSERT INTO genbank_qualifiers VALUES ('61', '-35_signal', '`-35 box\' in prokaryotic promoters');
INSERT INTO genbank_qualifiers VALUES ('62', '3\'clip', '3\'-most region of a precursor transcript removed in processing');
INSERT INTO genbank_qualifiers VALUES ('63', '3\'UTR', '3\' untranslated region (trailer)');
INSERT INTO genbank_qualifiers VALUES ('64', '5\'clip', '5\'-most region of a precursor transcript removed in processing');
INSERT INTO genbank_qualifiers VALUES ('65', '5\'UTR', '5\' untranslated region (leader)');

-- ----------------------------
-- Table structure for `genbank_specs`
-- ----------------------------
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
INSERT INTO genbank_specs VALUES ('1', '1', '1', '5', 'L', 'LOCUS', 'locus');
INSERT INTO genbank_specs VALUES ('2', '1', '6', '12', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('3', '1', '13', '28', 'L', null, 'design_name');
INSERT INTO genbank_specs VALUES ('4', '1', '29', '29', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('5', '1', '30', '40', 'R', null, 'total_base_pairs');
INSERT INTO genbank_specs VALUES ('6', '1', '41', '41', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('7', '1', '42', '43', 'L', 'bp', null);
INSERT INTO genbank_specs VALUES ('8', '1', '44', '44', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('9', '1', '45', '47', 'L', '(blank)', 'p1');
INSERT INTO genbank_specs VALUES ('10', '1', '48', '53', 'L', 'DNA', 'p2');
INSERT INTO genbank_specs VALUES ('11', '1', '54', '55', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('12', '1', '56', '63', 'L', 'linear', 'orientation');
INSERT INTO genbank_specs VALUES ('13', '1', '64', '64', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('14', '1', '65', '67', 'L', '(blank)', 'division_code');
INSERT INTO genbank_specs VALUES ('15', '1', '68', '68', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('16', '1', '69', '79', 'L', null, 'mod_date');
INSERT INTO genbank_specs VALUES ('17', '2', '1', '12', 'L', 'DEFINITION', null);
INSERT INTO genbank_specs VALUES ('19', '2', '13', '80', 'L', null, 'definition');
INSERT INTO genbank_specs VALUES ('20', '3', '1', '12', 'L', 'ACCESSION', null);
INSERT INTO genbank_specs VALUES ('21', '3', '13', '80', 'L', '(blank)', 'accession');
INSERT INTO genbank_specs VALUES ('22', '4', '1', '12', 'L', 'VERSION', null);
INSERT INTO genbank_specs VALUES ('23', '4', '13', '80', 'L', '(blank)', 'version');
INSERT INTO genbank_specs VALUES ('24', '5', '1', '12', 'L', 'KEYWORDS', null);
INSERT INTO genbank_specs VALUES ('25', '5', '13', '80', 'L', '.', 'keywords');
INSERT INTO genbank_specs VALUES ('26', '7', '1', '21', 'L', 'FEATURES', null);
INSERT INTO genbank_specs VALUES ('27', '7', '22', '40', 'L', 'Location/Qualifiers', null);
INSERT INTO genbank_specs VALUES ('28', '8', '1', '5', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('29', '8', '6', '20', 'L', null, 'category_key');
INSERT INTO genbank_specs VALUES ('30', '8', '21', '21', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('31', '8', '22', '80', 'L', null, 'part_base_pairs');
INSERT INTO genbank_specs VALUES ('32', '9', '1', '21', 'L', '(blank)', null);
INSERT INTO genbank_specs VALUES ('33', '9', '22', '80', 'L', null, 'qualifier');
INSERT INTO genbank_specs VALUES ('34', '10', '1', '6', 'L', 'ORIGIN', null);
INSERT INTO genbank_specs VALUES ('37', '6', '1', '12', 'L', 'COMMENT', null);
INSERT INTO genbank_specs VALUES ('38', '6', '13', '80', 'L', null, 'comment');

alter table categories add genbank_qualifier_id int;

update categories set genbank_qualifier_id = 11 where description like '%gene%';

update categories set genbank_qualifier_id = 36 where description like '%promoter%';

update categories set genbank_qualifier_id = 52 where description like '%terminator%';

update categories set genbank_qualifier_id = 38 where description like '%RBS%';

