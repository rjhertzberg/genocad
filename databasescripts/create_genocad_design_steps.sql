CREATE TABLE design_steps (
  step_id INTEGER AUTO_INCREMENT NOT NULL,
  step_index INTEGER NOT NULL,
  design_id INTEGER  UNSIGNED NOT NULL,
  CONSTRAINT pk_design_steps PRIMARY KEY (step_id)
);

CREATE TABLE design_step_parts (
  step_id INTEGER NOT NULL,
  category_index INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  part_id INTEGER UNSIGNED,
  CONSTRAINT pk_design_step_parts PRIMARY KEY (step_id, category_index)
);

ALTER TABLE design_steps
  ADD CONSTRAINT fk_design_steps_01
  FOREIGN KEY (design_id) REFERENCES designs (design_id)
  ON DELETE CASCADE;

ALTER TABLE design_step_parts
  ADD CONSTRAINT fk_design_step_parts_01
  FOREIGN KEY (step_id) REFERENCES design_steps (step_id)
  ON DELETE CASCADE;

ALTER TABLE design_step_parts
  ADD CONSTRAINT fk_design_step_parts_02
  FOREIGN KEY (category_id) REFERENCES categories (category_id);

ALTER TABLE design_step_parts
  ADD CONSTRAINT fk_design_step_parts_03
  FOREIGN KEY (part_id) REFERENCES parts (id);

ALTER TABLE users alter approved_flag set DEFAULT 1;
