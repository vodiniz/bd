-- ENTIDADES E ATRIBUTOS COMPOSTOS --

CREATE TABLE Question (
    ID_question NUMERIC(4) NOT NULL,
    name_question VARCHAR(30) NOT NULL,
    is_active TINYINT(1) NOT NULL,
    ID_related_topics NUMERIC(4) NOT NULL,
    ID_tags NUMERIC(4) NOT NULL,
    ID_field_area NUMERIC(4) NOT NULL,
    CONSTRAINT pk_question PRIMARY KEY (ID_question)
);

CREATE TABLE Related_Topics (
    ID_related_topics NUMERIC(4) NOT NULL,
    name_related_topics VARCHAR(30) NOT NULL,
    CONSTRAINT pk_related_topics PRIMARY KEY (ID_related_topics)
);

CREATE TABLE Tags (
    ID_tags NUMERIC(4) NOT NULL,
    name_tags VARCHAR(30) NOT NULL,
    CONSTRAINT pk_tags PRIMARY KEY (ID_tags)
);

CREATE TABLE Field_Area (
    ID_field_area NUMERIC(4) NOT NULL,
    name_field_area VARCHAR(30) NOT NULL,
    CONSTRAINT pk_field_area PRIMARY KEY (ID_field_area)
    
);
    
CREATE TABLE Tip (
    ID_tip NUMERIC(4) NOT NULL,
    title VARCHAR(30) NOT NULL,
    content VARCHAR(10000) NOT NULL,
    CONSTRAINT pk_tip PRIMARY KEY (ID_tip)
);

CREATE TABLE Question_Historic (
    ID_question_historic NUMERIC(4) NOT NULL,
    enunciate VARCHAR(10000) NOT NULL,
    level_question_historic NUMERIC(2) NOT NULL,
    variable VARCHAR(255) NOT NULL,
    criterion VARCHAR(255) NOT NULL,
    validity_begin DATETIME NOT NULL,
    validity_final DATETIME NOT NULL,
    ID_question NUMERIC(4) NOT NULL,
    CONSTRAINT pk_question_historic PRIMARY KEY (ID_question_historic)
);

CREATE TABLE Task (
    ID_task NUMERIC(4) NOT NULL,
    title VARCHAR(30) NOT NULL,
    enunciation VARCHAR(10000) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    pdf_enunciation VARCHAR(255), -- caminho para o PDF
    ID_summary NUMERIC(4) NOT NULL,
    CONSTRAINT pk_task PRIMARY KEY (ID_task)
);

CREATE TABLE Admin (
    ID_admin NUMERIC(4) NOT NULL,
    admin_type NUMERIC(1) NOT NULL,
    CONSTRAINT pk_admin PRIMARY KEY (ID_admin)
);

CREATE TABLE User (
    ID_user NUMERIC(4) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at DATE NOT NULL,
    first_access DATE NOT NULL,
    profile_image VARCHAR(255),
    ID_admin NUMERIC(4),
    CONSTRAINT pk_user PRIMARY KEY (ID_user)
);

CREATE TABLE Classgroup (
    ID_classgroup NUMERIC(4) NOT NULL,
    code VARCHAR(10) NOT NULL,
    is_active TINYINT(1) NOT NULL,
    year_classgroup NUMERIC(4) NOT NULL,
    semester NUMERIC(1) NOT NULL,
    ID_discipline NUMERIC(4) NOT NULL,
    CONSTRAINT pk_classgroup PRIMARY KEY (ID_classgroup)
);

CREATE TABLE Discipline (
    ID_discipline NUMERIC(4) NOT NULL,
    code VARCHAR(10) NOT NULL,
    description_discipline VARCHAR(100) NOT NULL,
    CONSTRAINT pk_discipline PRIMARY KEY (ID_discipline)
);

CREATE TABLE Correction_Strategy (
    ID_correction_strategy NUMERIC(4) NOT NULL,
    name_correction_strategy VARCHAR(30) NOT NULL,
    corrector VARCHAR(255), -- caminho para o corretor
    CONSTRAINT pk_correction_strategy PRIMARY KEY (ID_correction_strategy)
);

CREATE TABLE Files_Format_Correction_Strategy (
    files_format VARCHAR(10) NOT NULL,
    ID_correction_strategy NUMERIC(4) NOT NULL,
    CONSTRAINT pk_files_format_correction_strategy PRIMARY KEY (files_format, ID_correction_strategy)
);

CREATE TABLE Summary (
    ID_summary NUMERIC(4) NOT NULL,
    title VARCHAR(30) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    CONSTRAINT pk_summary PRIMARY KEY (ID_summary)
);

CREATE TABLE Prerequisite_Summary (
    content VARCHAR(500) NOT NULL,
    ID_summary NUMERIC(4) NOT NULL,
    CONSTRAINT pk_prerequisite_summary PRIMARY KEY (content, ID_summary)
);

CREATE TABLE Help_Tip (
    ID_help_tip NUMERIC(4) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content VARCHAR(10000) NOT NULL
);



-- RELACIONAMENTOS --

CREATE TABLE Question_Has_A_Tip (
    ID_question NUMERIC(4) NOT NULL,
    ID_tip NUMERIC(4) NOT NULL,
    CONSTRAINT pk_question_has_a_tip PRIMARY KEY (ID_question, ID_tip)
);

CREATE TABLE Tip_Is_Applied_To_Task (
    ID_tip NUMERIC(4) NOT NULL,
    ID_task NUMERIC(4) NOT NULL,
    CONSTRAINT pk_tip_is_applied_to_task PRIMARY KEY (ID_tip, ID_task)
);

CREATE TABLE Question_Historic_Has_A_CS (
    ID_question_historic NUMERIC(4) NOT NULL,
    ID_correction_strategy NUMERIC(4) NOT NULL,
    CONSTRAINT pk_question_historic_has_a_cs PRIMARY KEY (ID_question_historic, ID_correction_strategy)
);

CREATE TABLE Question_Historic_Is_Applied_To_Task (
    ID_question NUMERIC(4) NOT NULL,
    ID_task NUMERIC(4) NOT NULL,
    begin_date DATETIME,
    due_date DATETIME,
    CONSTRAINT pk_question_historic_is_applied_to_task PRIMARY KEY (ID_question, ID_task)
);

CREATE TABLE Applied_Question_Is_Solved_By (
    ID_question_historic NUMERIC(4) NOT NULL,
    ID_task NUMERIC(4) NOT NULL,
    ID_user NUMERIC(4) NOT NULL,
    best_attempt_flag TINYINT(1),
    question_score NUMERIC(2),
    sent_date DATETIME NOT NULL,
    code_sent VARCHAR(255),
    attempt NUMERIC(3) NOT NULL,
    is_pending TINYINT(1),
    selected_language VARCHAR(10) NOT NULL,
    CONSTRAINT pk_applied_question_is_solved_by PRIMARY KEY (ID_question_historic, ID_task, ID_user)
);

CREATE TABLE Task_Is_Solved_By (
    ID_task NUMERIC(4) NOT NULL,
    ID_user NUMERIC(4) NOT NULL,
    total_score NUMERIC(2) NOT NULL,
    CONSTRAINT pk_task_is_solved_by PRIMARY KEY (ID_task, ID_user)
);

CREATE TABLE Task_Is_Assigned_To_Classgroup (
    ID_task NUMERIC(4) NOT NULL,
    ID_classgroup NUMERIC(4) NOT NULL,
    begin_date DATETIME NOT NULL,
    due_date DATETIME NOT NULL,
    read_only_flag TINYINT(1), 
    CONSTRAINT pk_task_is_assigned_to_classgroup PRIMARY KEY (ID_task, ID_classgroup)
);

CREATE TABLE Task_Has_A_CS (
    ID_task NUMERIC(4) NOT NULL,
    ID_correction_strategy NUMERIC(4) NOT NULL,
    CONSTRAINT pk_task_has_a_cs PRIMARY KEY (ID_task, ID_correction_strategy)
);

CREATE TABLE Studies_At (
    ID_user NUMERIC(4) NOT NULL,
    ID_classgroup NUMERIC(4) NOT NULL,
    read_only_flag TINYINT(1) NOT NULL,
    CONSTRAINT pk_studies_at PRIMARY KEY (ID_user, ID_classgroup)
);

CREATE TABLE Classgroup_Has_A_CS (
    ID_classgroup NUMERIC(4) NOT NULL,
    ID_correction_strategy NUMERIC(4) NOT NULL,
    CONSTRAINT pk_classgroup_has_a_cs PRIMARY KEY (ID_classgroup, ID_correction_strategy)
);

CREATE TABLE Discipline_Has_A_CS (
    ID_discipline NUMERIC(4) NOT NULL,
    ID_correction_strategy NUMERIC(4) NOT NULL,
    CONSTRAINT pk_discipline_has_a_cs PRIMARY KEY (ID_discipline, ID_correction_strategy)
);



-- INSERTS --

-- INSERTS ENTIDADES E ATRIBUTOS COMPOSTOS

INSERT INTO Related_Topics
VALUES (0001, 'Conversão de entradas');

INSERT INTO Tags
VALUES (0001, 'Elástica');
INSERT INTO Tags
VALUES (0002, 'Queda livre');

INSERT INTO Field_Area
VALUES (0001, 'Engenharia Mecânica');

INSERT INTO Question
VALUES (0001, 'Questão 1', 1, 0001, 0001, 0001);
INSERT INTO Question
VALUES (0002, 'Questão 2', 1, 0001, 0002, 0001);

INSERT INTO Tip
VALUES (0001, 'Primeira entrega', 'Faça entregas no corretor automático após criar arquivos contendo os códigos-fonte fornecidos a seguir.');
INSERT INTO Tip
VALUES (0002, 'Conversão de entradas.', 'Se atente à conversão de entradas.');

INSERT INTO Question_Historic
VALUES (0001, 'Implemente um programa para calcular a aceleração de um corpo sendo puxado por uma mola, considerando como entrada a constante elástica da mola (k), a massa do corpo (m) e a extensão a partir da posição inicial (x).', 1, '/meus_jsons/variables/question1_variables.json', '/meus_json/criterion/question1_criterion.json', '2024-09-15 13:00:00', '2024-09-22 23:59:59', 0001);
INSERT INTO Question_Historic
VALUES (0002, 'Dado um objeto em queda livre, calcular a velocidade em um instante de tempo e a distância total percorrida desde o início da queda, tendo como a entrada do usuário o instante de tempo t.', 1, '/meus_jsons/variables/question2_variables.json', '/meus_json/criterion/question2_criterion.json', '2024-09-15 13:00:00', '2024-09-22 23:59:59', 0002);

INSERT INTO Prerequisite_Summary
VALUES ('Ler o primeiro capítulo do livro texto da disciplina.', 0001);
INSERT INTO Prerequisite_Summary
VALUES ('Assistir às aulas teóricas correspondentes.', 0001);

INSERT INTO Summary
VALUES (0001, 'Primeira tarefa', 'As duas questões desta atividade prática foram extraídas do Livro Texto da disciplina (Capítulo 1).');

INSERT INTO Task
VALUES (0001, 'Testando o Corretor Automático', 'ATENÇÃO: Esta atividade é apenas uma oportunidade de conhecer e testar o corretor automático.', 'testando-o-corretor-automatico', '/meus_pdfs/tarefa.pdf', 0001);


INSERT INTO Admin
VALUES (0001, 1); -- adm
INSERT INTO Admin
VALUES (0002, 2); -- professor, estagiário docente
INSERT INTO Admin
VALUES (0003, 3); -- tutor, monitor

INSERT INTO User
VALUES (0001, 'Kézia Brito', 'kezbrita@aluno.ufop.edu.br', '2024-09-15', '2024-09-16', NULL, NULL);
INSERT INTO User
VALUES (0002, 'Bruno Alves', 'alvesnobru@aluno.ufop.edu.br', '2024-08-01', '2024-08-24', NULL, NULL);
INSERT INTO User
VALUES (0003, 'Gabriel Saldanha', 'gabrielaçucardanha@aluno.ufop.edu.br', '2024-08-05', '2024-08-14', NULL, NULL);
INSERT INTO User
VALUES (0004, 'Vitor Oliveira', 'vitorlimoeiro@aluno.ufop.edu.br', '2024-09-01', '2024-09-2', NULL, NULL);
INSERT INTO User
VALUES (0005, 'Jéssica Machado', 'jessicamartelo@aluno.ufop.edu.br', '2024-08-01', '2024-08-24', NULL, NULL);

INSERT INTO Classgroup
VALUES (0001, '11', 1, 2022, 1, 0001);
INSERT INTO Classgroup
VALUES (0002, '12', 1, 2022, 1, 0002);

INSERT INTO Discipline
VALUES (0001, 'BCC323', 'Engenharia de Software II');
INSERT INTO Discipline
VALUES (0002, 'BCC321', 'Banco de Dados I');
INSERT INTO Discipline
VALUES (0003, 'BCC222', 'Programação Funcional');

INSERT INTO Files_Format_Correction_Strategy
VALUES ('.py', 0001);
INSERT INTO Files_Format_Correction_Strategy
VALUES ('.cpp', 0002);
INSERT INTO Files_Format_Correction_Strategy
VALUES ('.hpp', 0002);
INSERT INTO Files_Format_Correction_Strategy
VALUES ('.hs', 0003);

INSERT INTO Correction_Strategy
VALUES (0001, 'Python', '/minhas_estrategias/python.py');
INSERT INTO Correction_Strategy
VALUES (0002, 'C++', '/minhas_estrategias/cpp.py');
INSERT INTO Correction_Strategy
VALUES (0003, 'Haskell', '/minhas_estrategias/haskell.py');

INSERT INTO Help_Tip
VALUES (0001, 'Como enviar uma questão.', 'Para enviar um questão, vá em...');
INSERT INTO Help_Tip
VALUES (0002, 'Como se cadastrar em uma turma.', 'Para se cadastrar em uma turma...');

-- INSERT RELACIONAMENTOS

INSERT INTO Question_Has_A_Tip
VALUES (0001, 0002);
INSERT INTO Question_Has_A_Tip
VALUES (0002, 0002);

INSERT INTO Tip_Is_Applied_To_Task
VALUES (0001, 0001);

INSERT INTO Question_Historic_Has_A_CS
VALUES (0001, 0001);
INSERT INTO Question_Historic_Has_A_CS
VALUES (0002, 0002);

INSERT INTO Question_Historic_Is_Applied_To_Task
VALUES (0001, 0001, NULL, NULL);
INSERT INTO Question_Historic_Is_Applied_To_Task
VALUES (0002, 0001, NULL, NULL);

INSERT INTO Applied_Question_Is_Solved_By
VALUES (0001, 0001, 0001, 1, 10, '2024-08-01 13:10:01', '/tarefa1/questao1', 1, 0, 'Python');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0002, 0001, 0001, 1, 10, '2024-08-01 13:15:02', '/tarefa1/questao2', 1, 0, 'Python');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0001, 0001, 0005, 1, 10, '2024-08-01 13:38:51', '/tar1/quest1', 1, 0, 'Python');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0002, 0001, 0005, 1, 10, '2024-08-01 13:40:03', '/tar1/quest2', 1, 0, 'Python');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0001, 0001, 0002, 1, 10, '2024-08-02 05:05:06', '/trf1/qst1', 1, 0, 'C++');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0002, 0001, 0002, 1, 10, '2024-08-02 05:08:03', '/trf1/qst2', 1, 0, 'C++');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0001, 0001, 0003, 1, 1, '2024-08-02 09:28:47', '/t1/q1', 1, 0, 'C++');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0002, 0001, 0003, 1, 5, '2024-08-02 09:59:59', '/t1/q2', 1, 0, 'C++');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0001, 0001, 0004, 1, 8, '2024-08-01 15:28:47', '/task1/question1', 1, 0, 'C++');
INSERT INTO Applied_Question_Is_Solved_By
VALUES (0002, 0001, 0004, 1, 8, '2024-08-01 15:49:59', '/task1/question2', 1, 0, 'C++');

INSERT INTO Task_Is_Solved_By
VALUES (0001, 0001, 10);
INSERT INTO Task_Is_Solved_By
VALUES (0001, 0005, 10);
INSERT INTO Task_Is_Solved_By
VALUES (0001, 0002, 10);
INSERT INTO Task_Is_Solved_By
VALUES (0001, 0003, 3);
INSERT INTO Task_Is_Solved_By
VALUES (0001, 0004, 8);

INSERT INTO Task_Is_Assigned_To_Classgroup
VALUES (0001, 0001, '2024-08-01 13:00:00', '2024-08-10 23:59:59', 0);
INSERT INTO Task_Is_Assigned_To_Classgroup
VALUES (0001, 0002, '2024-08-01 13:00:00', '2024-08-10 23:59:59', 0);

INSERT INTO Task_Has_A_CS
VALUES (0001, 0001);
INSERT INTO Task_Has_A_CS
VALUES (0001, 0002);

INSERT INTO Studies_At
VALUES (0001, 0001, 0);
INSERT INTO Studies_At
VALUES (0005, 0001, 0);
INSERT INTO Studies_At
VALUES (0002, 0002, 0);
INSERT INTO Studies_At
VALUES (0003, 0002, 0);
INSERT INTO Studies_At
VALUES (0004, 0002, 0);

INSERT INTO Classgroup_Has_A_CS
VALUES (0001, 0001);
INSERT INTO Classgroup_Has_A_CS
VALUES (0002, 0002);

INSERT INTO Discipline_Has_A_CS
VALUES (0001, 0001);
INSERT INTO Discipline_Has_A_CS
VALUES (0002, 0002);
INSERT INTO Discipline_Has_A_CS
VALUES (0003, 0003);

-- CHAVES ESTRANGEIRAS --

ALTER TABLE Question
ADD CONSTRAINT fk_question_related_topics FOREIGN KEY (ID_related_topics) REFERENCES Related_Topics (ID_related_topics);
ALTER TABLE Question
ADD CONSTRAINT fk_question_tags FOREIGN KEY (ID_tags) REFERENCES Tags (ID_tags);
ALTER TABLE Question
ADD CONSTRAINT fk_question_field_area FOREIGN KEY (ID_field_area) REFERENCES Field_Area (ID_field_area);

ALTER TABLE Question_Historic
ADD CONSTRAINT fk_question_historic_question FOREIGN KEY (ID_question) REFERENCES Question (ID_question);

ALTER TABLE Files_Format_Correction_Strategy
ADD CONSTRAINT fk_files_format_correction_strategy FOREIGN KEY (ID_correction_strategy) REFERENCES Correction_Strategy (ID_correction_strategy) ON DELETE CASCADE;

ALTER TABLE Task
ADD CONSTRAINT fk_task_summary FOREIGN KEY (ID_summary) REFERENCES Summary (ID_summary);

ALTER TABLE User
ADD CONSTRAINT fk_user_admin FOREIGN KEY (ID_admin) REFERENCES Admin (ID_admin);

ALTER TABLE Classgroup
ADD CONSTRAINT fk_classgroup_discipine FOREIGN KEY (ID_discipline) REFERENCES Discipline (ID_discipline);

ALTER TABLE Prerequisite_Summary 
ADD CONSTRAINT fk_prerequisite_summary FOREIGN KEY (ID_summary) REFERENCES Summary (ID_summary) ON DELETE CASCADE;

ALTER TABLE Question_Has_A_Tip
ADD CONSTRAINT fk_question_has_a_tip_question FOREIGN KEY (ID_question) REFERENCES Question (ID_question) ON DELETE CASCADE;
ALTER TABLE Question_Has_A_Tip
ADD CONSTRAINT fk_question_has_a_tip_tip FOREIGN KEY (ID_tip) REFERENCES Tip (ID_tip) ON DELETE CASCADE;

ALTER TABLE Tip_Is_Applied_To_Task
ADD CONSTRAINT fk_tip_is_applied_to_task_tip FOREIGN KEY (ID_tip) REFERENCES Tip (ID_tip) ON DELETE CASCADE;
ALTER TABLE Tip_Is_Applied_To_Task
ADD CONSTRAINT fk_tip_is_applied_to_task_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task) ON DELETE CASCADE;

ALTER TABLE Question_Historic_Has_A_CS
ADD CONSTRAINT fk_question_historic_has_a_cs_question_historic FOREIGN KEY (ID_question_historic) REFERENCES Question_Historic (ID_question_historic) ON DELETE CASCADE;
ALTER TABLE Question_Historic_Has_A_CS
ADD CONSTRAINT fk_question_historic_has_a_cs_correction_strategy FOREIGN KEY (ID_correction_strategy) REFERENCES Correction_Strategy (ID_correction_strategy) ON DELETE CASCADE;

ALTER TABLE Question_Historic_Is_Applied_To_Task
ADD CONSTRAINT fk_question_historic_is_applied_to_task_question_historic FOREIGN KEY (ID_question) REFERENCES Question_Historic (ID_question_historic) ON DELETE CASCADE;
ALTER TABLE Question_Historic_Is_Applied_To_Task
ADD CONSTRAINT fk_question_historic_is_applied_to_task_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task) ON DELETE CASCADE;

ALTER TABLE Applied_Question_Is_Solved_By
ADD CONSTRAINT fk_applied_question_is_solved_by_question_historic FOREIGN KEY (ID_question_historic) REFERENCES Question_Historic (ID_question_historic);
ALTER TABLE Applied_Question_Is_Solved_By
ADD CONSTRAINT fk_applied_question_is_solved_by_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task);
ALTER TABLE Applied_Question_Is_Solved_By
ADD CONSTRAINT fk_applied_question_is_solved_by_user FOREIGN KEY (ID_user) REFERENCES User (ID_user);  

ALTER TABLE Task_Is_Solved_By
ADD CONSTRAINT fk_task_is_solved_by_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task);
ALTER TABLE Task_Is_Solved_By
ADD CONSTRAINT fk_task_is_solved_by_user FOREIGN KEY (ID_user) REFERENCES User (ID_user);

ALTER TABLE Task_Is_Assigned_To_Classgroup
ADD CONSTRAINT fK_task_is_assigned_to_classgroup_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task);
ALTER TABLE Task_Is_Assigned_To_Classgroup
ADD CONSTRAINT fK_task_is_assigned_to_classgroup_classgroup FOREIGN KEY (ID_classgroup) REFERENCES Classgroup (ID_classgroup); 

ALTER TABLE Task_Has_A_CS
ADD CONSTRAINT fk_task_has_a_cs_task FOREIGN KEY (ID_task) REFERENCES Task (ID_task) ON DELETE CASCADE;
ALTER TABLE Task_Has_A_CS
ADD CONSTRAINT fk_task_has_a_cs_correction_strategy FOREIGN KEY (ID_correction_strategy) REFERENCES Correction_Strategy (ID_correction_strategy) ON DELETE CASCADE;

ALTER TABLE Studies_At
ADD CONSTRAINT fk_studies_at_user FOREIGN KEY (ID_user) REFERENCES User (ID_user);
ALTER TABLE Studies_At
ADD CONSTRAINT fk_studies_at_classgroup FOREIGN KEY (ID_classgroup) REFERENCES Classgroup (ID_classgroup);

ALTER TABLE Classgroup_Has_A_CS
ADD CONSTRAINT fk_classgroup_has_a_cs_classgroup FOREIGN KEY (ID_classgroup) REFERENCES Classgroup (ID_classgroup) ON DELETE CASCADE;
ALTER TABLE Classgroup_Has_A_CS
ADD CONSTRAINT fk_classgroup_has_a_cs_correction_strategy FOREIGN KEY (ID_correction_strategy) REFERENCES Correction_Strategy (ID_correction_strategy) ON DELETE CASCADE;

ALTER TABLE Discipline_Has_A_CS
ADD CONSTRAINT fk_discipline_has_a_cs_discipline FOREIGN KEY (ID_discipline) REFERENCES Discipline (ID_discipline) ON DELETE CASCADE;
ALTER TABLE Discipline_Has_A_CS
ADD CONSTRAINT fk_discipline_has_a_cs_correction_strategy FOREIGN KEY (ID_correction_strategy) REFERENCES Correction_Strategy (ID_correction_strategy) ON DELETE CASCADE;
