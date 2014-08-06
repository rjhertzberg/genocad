-- create v_parts_library, which is used by the design screen.
create or replace view v_part_library
as
select parts.part_id AS `part_identifier`
    ,parts.description AS `part_name`
    ,parts.segment AS `part_segment`
    ,parts.user_id AS `part_user_id`
    ,parts.description_text AS `part_description_text`
    ,parts.last_modified AS `part_last_modified`
    ,libraries.user_id AS `library_user_id`
    ,libraries.name AS `library_name`
    ,libraries.description AS `library_description`
    ,libraries.last_modified AS `library_last_modified`
    ,libraries.library_id AS `library_id`
    ,categories_parts.category_id AS `part_category_id`
    ,categories.letter AS `category_letter`
    ,categories.description AS `category_description`
    ,parts.id AS `part_id`
    ,libraries.grammar_id AS `grammar_id`
    ,categories.category_id AS `category_id` 
from ((((parts join library_part_join 
        on((library_part_join.part_id = parts.id))) 
    join libraries 
        on((library_part_join.library_id = libraries.library_id))) 
    join categories_parts 
        on(((parts.id = categories_parts.part_id) 
        and (categories_parts.user_id = parts.user_id)))) 
    join categories 
        on((categories_parts.category_id = categories.category_id)));