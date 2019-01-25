SELECT * FROM type_of_businesses;

SELECT * FROM problems;

SELECT * FROM companies;

SELECT * FROM lang;

SELECT * FROM lang_tech;

SELECT * FROM project;

SELECT * FROM project_stack WHERE id_proj=(SELECT project_id FROM project WHERE project_name='Bank app');
