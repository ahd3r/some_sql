INSERT type_of_businesses(type_name) VALUES ('Coding'),
('Dropshipping'),
('Entertainment'),
('Production'),
('Investing');

INSERT problems(problem_name,decision) VALUES ('Not enough people','Hire more'),
('Not enough money','Earn more'),
('Government pressure','Deal it'),
('Fire in the plant','Call the fireman'),
('Broke something','Repeat it'),
('Deadline soon','Work more');

INSERT companies(companies_name,to_type_of_business) VALUES ('EPUM',1),
('Rozetka',1),
('AnEn',2),
('Movie',3),
('Coropaley',4),
('Stock',5);

INSERT lang(lang_name,my_know,how_good_know,comp_use) VALUES ('Python',1,'junior',1),
('JS',1,'junior',1),
('Java',0,'nope',1),
('C#',0,'nope',1),
('Php',0,'nope',1);

INSERT lang_tech(tech_name,to_lang) VALUES ('NodeJS',2),
('Django',1),('Spring',3),('.NET',4);

INSERT project(project_name,my) VALUES ('Task manager',1),('Online shop',1),('Social network',1);

INSERT project(project_name,companies) VALUES ('Bank app',1);

INSERT project_stack(id_proj,id_tech) VALUES (1,1),(2,1),(3,1),(3,2),(4,3),(4,4);
