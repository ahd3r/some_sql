DROP DATABASE IF EXISTS businesses;
CREATE DATABASE businesses;
USE businesses;

CREATE TABLE type_of_businesses(
type_id SMALLINT UNSIGNED NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
type_name VARCHAR(45) NOT NULL,
status TINYINT NOT NULL DEFAULT 1);

CREATE TABLE problems(
problem_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
problem_name VARCHAR(255) NOT NULL,
decision TEXT NOT NULL);

CREATE TABLE companies(
companies_id INT UNSIGNED NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
companies_name VARCHAR(200) NOT NULL,
to_type_of_business SMALLINT UNSIGNED NOT NULL,
FOREIGN KEY (to_type_of_business ) REFERENCES type_of_businesses(type_id)
ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE companies_problem(
id_prob INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
id_comp_with_prob INT UNSIGNED NOT NULL,
id_prob_of_comp INT UNSIGNED NOT NULL,
FOREIGN KEY (id_comp_with_prob) REFERENCES companies(companies_id),
FOREIGN KEY (id_prob_of_comp) REFERENCES problems(problem_id),
UNIQUE (id_comp_with_prob,id_prob_of_comp));

CREATE TABLE my_coding(
my_id TINYINT NOT NULL PRIMARY KEY DEFAULT 1,
my_sphera VARCHAR(100) NOT NULL,
my_level VARCHAR(50) NOT NULL);
INSERT my_coding(my_sphera,my_level) VALUES ('Backend — developer','Junior');

CREATE TABLE job(
job_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
job_name VARCHAR(100) NOT NULL,
duration_month SMALLINT UNSIGNED NOT NULL,
position VARCHAR(100) NOT NULL);

CREATE TABLE lang(
id_lang SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
lang_name VARCHAR(100) NOT NULL,
my_know TINYINT NOT NULL DEFAULT 0,
how_good_know VARCHAR(100) NOT NULL DEFAULT 'nope',
comp_use TINYINT NOT NULL DEFAULT 0,
what_id_comp TINYINT NOT NULL DEFAULT 0);

CREATE TABLE lang_tech(
tech_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
tech_name VARCHAR(255) NOT NULL,
to_lang SMALLINT UNSIGNED,
FOREIGN KEY (to_lang) REFERENCES lang(id_lang) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE project(
project_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
project_name VARCHAR(100) NOT NULL,
my TINYINT NOT NULL DEFAULT 0,
companies TINYINT NOT NULL DEFAULT 0,
by_comp INT NOT NULL);

CREATE TABLE project_stack(
id_stack INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
id_proj INT UNSIGNED NOT NULL,
id_tech INT UNSIGNED NOT NULL,
UNIQUE(id_proj,id_tech),
FOREIGN KEY (id_proj) REFERENCES project(project_id),
FOREIGN KEY (id_tech) REFERENCES lang_tech(tech_id));



-- CREATE OR REPLACE VIEW full_main_page AS SELECT * FROM type_of_businesses;

delimiter //
CREATE PROCEDURE new_problem(to_comp INT UNSIGNED,new_prob_id INT UNSIGNED)
BEGIN
    INSERT companies_problem(id_comp_with_prob,id_prob_of_comp) VALUES (to_comp,new_prob_id);
    UPDATE type_of_businesses SET status=0 WHERE type_id=(SELECT to_type_of_business FROM companies WHERE companies_id=to_comp);
END//
delimiter ;

delimiter //
CREATE PROCEDURE done_problem(id_done_comp INT UNSIGNED, id_done_prob INT UNSIGNED)
BEGIN
	START TRANSACTION;
    IF EXISTS((SELECT * FROM companies_problem WHERE id_comp_with_prob=id_done_comp AND id_prob_of_comp=id_done_prob))
    THEN
   		DELETE FROM companies_problem WHERE id_comp_with_prob=id_done_comp AND id_prob_of_comp=id_done_prob;
        IF EXISTS((SELECT * FROM companies_problem WHERE id_comp_with_prob=id_done_comp))
        THEN
			COMMIT;
			SELECT correct();
		ELSE
			UPDATE type_of_businesses SET status=1 WHERE type_id=(SELECT to_type_of_business FROM companies WHERE companies_id=id_done_comp);
			COMMIT;
			SELECT correct();
        END IF;
    ELSE
		ROLLBACK;
        SELECT wrong();
    END IF;
END//
delimiter ;

delimiter //
CREATE FUNCTION correct()
RETURNS VARCHAR(45) DETERMINISTIC
BEGIN
	RETURN 'GOOD!';
END//
delimiter ;

delimiter //
CREATE FUNCTION wrong()
RETURNS VARCHAR(45) DETERMINISTIC
BEGIN
	RETURN 'WRONG!';
END//
delimiter ;
