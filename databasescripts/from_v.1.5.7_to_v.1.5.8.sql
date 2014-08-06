alter table designs 
add is_validated int default 0;

update designs set is_validated = 0 where length(trim(sequence)) > 0;

update designs set is_validated = -1 where length(trim(sequence)) = 0;

update designs set is_validated = -2 where instr(sequence, '-') > 0;

alter table grammars 
add is_compilable int default 0;

update grammars
set is_compilable = 1 
where grammar_id <> 101;

update grammars
set is_compilable = 0 
where grammar_id = 101;