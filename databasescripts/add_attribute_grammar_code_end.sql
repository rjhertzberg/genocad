alter table attribute_grammar
add code_end varchar(1000);

update attribute_grammar
set code_end = 'produce_sbml(Tokens),produce_code' 
where grammar_id = 911;