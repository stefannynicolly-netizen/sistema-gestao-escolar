-- =========================================================================
-- SISTEMA DE GESTÃO ESCOLAR - SCRIPT DML (Povoamento com Narrativa)
-- Execute APENAS depois do script-ddl.sql.
-- =========================================================================

USE sistema_gestao_escolar;

-- =========================================================================
-- Cenário 1: Estrutura da instituição (Cursos, Disciplinas e Salas)
--
-- Antes do início do ano letivo de 2026, a direção cadastrou os cinco
-- cursos técnicos oferecidos, montou a grade curricular de cada um e
-- registrou as salas e laboratórios disponíveis nos blocos da escola.
-- =========================================================================

INSERT INTO curso (nome_curso, carga_horaria_total, turno) VALUES
('TÉCNICO EM INFORMÁTICA', 1200, 'Integral'),
('TÉCNICO EM ADMINISTRAÇÃO', 1000, 'Vespertino'),
('TÉCNICO EM REDES DE COMPUTADORES', 1100, 'Matutino'),
('TÉCNICO EM CONTABILIDADE', 900, 'Noturno'),
('TÉCNICO EM LOGÍSTICA', 800, 'Noturno');

INSERT INTO disciplina (nome_disciplina, carga_horaria, id_curso) VALUES
('BANCO DE DADOS', 80, 1),
('PROGRAMAÇÃO WEB', 120, 1),
('LÓGICA DE PROGRAMAÇÃO', 60, 1),
('GESTÃO EMPRESARIAL', 60, 2),
('MARKETING', 40, 2),
('REDES DE COMPUTADORES I', 80, 3),
('CONTABILIDADE GERAL', 80, 4),
('GESTÃO DE ESTOQUES', 60, 5);

INSERT INTO sala (nome_sala, bloco, capacidade, tipo) VALUES
('LABORATÓRIO DE INFORMÁTICA 1', 'BLOCO A', 30, 'Laboratório'),
('LABORATÓRIO DE INFORMÁTICA 2', 'BLOCO A', 30, 'Laboratório'),
('SALA 101', 'BLOCO B', 40, 'Sala de aula'),
('SALA 102', 'BLOCO B', 40, 'Sala de aula'),
('AUDITÓRIO CENTRAL', 'BLOCO C', 120, 'Auditório');

-- =========================================================================
-- Cenário 2: Contratação do corpo docente
--
-- Com a grade pronta, a coordenação cadastrou os cinco professores que
-- ministrarão as disciplinas no primeiro semestre de 2026.
-- =========================================================================

INSERT INTO professor (nome, cpf, especialidade, email) VALUES
('CARLOS SILVA', '111.222.333-44', 'BANCO DE DADOS', 'carlos.silva@escola.com'),
('MARIA FERNANDA', '555.666.777-88', 'ADMINISTRAÇÃO', 'maria.fernanda@escola.com'),
('ROBERTO ALMEIDA', '222.333.444-55', 'REDES DE COMPUTADORES', 'roberto.almeida@escola.com'),
('PATRÍCIA LIMA', '333.444.555-66', 'CONTABILIDADE', 'patricia.lima@escola.com'),
('ANA PAULA RIBEIRO', '444.555.666-77', 'PROGRAMAÇÃO', 'ana.ribeiro@escola.com');

-- =========================================================================
-- Cenário 3: Abertura das turmas de 2026/1
--
-- A secretaria abriu seis turmas para o semestre 2026/1, definindo para
-- cada uma a disciplina, o professor responsável, a sala e o horário.
-- (As disciplinas de Marketing e Gestão de Estoques ainda não tiveram
-- turma aberta, o que é permitido pela cardinalidade 0,N.)
-- =========================================================================

INSERT INTO turma (semestre_ano, horario, id_disciplina, id_professor, id_sala) VALUES
('2026/1', 'SEGUNDA 08:00 - 12:00', 1, 1, 1),  -- Banco de Dados / Carlos / Lab 1
('2026/1', 'QUARTA 08:00 - 12:00',  2, 5, 2),  -- Programação Web / Ana Paula / Lab 2
('2026/1', 'SEXTA 08:00 - 12:00',   3, 5, 2),  -- Lógica de Programação / Ana Paula / Lab 2
('2026/1', 'TERÇA 13:30 - 17:30',   4, 2, 3),  -- Gestão Empresarial / Maria Fernanda / Sala 101
('2026/1', 'QUINTA 13:30 - 17:30',  6, 3, 1),  -- Redes I / Roberto / Lab 1
('2026/1', 'TERÇA 19:00 - 22:00',   7, 4, 4);  -- Contabilidade Geral / Patrícia / Sala 102

-- =========================================================================
-- Cenário 4: Cadastro dos alunos
--
-- Na semana de acolhimento, oito alunos realizaram o cadastro na
-- instituição com seus dados pessoais.
-- =========================================================================

INSERT INTO aluno (nome, cpf, data_nascimento, email) VALUES
('Carlos Eduardo Silva', '111.111.111-11', '2004-01-15', 'carlos.eduardo@email.com'),
('Maria Fernanda Oliveira', '222.222.222-22', '2005-03-20', 'maria.oliveira@email.com'),
('João Pedro Santos', '333.333.333-33', '2003-07-10', 'joao.pedro@email.com'),
('Ana Beatriz Costa', '444.444.444-44', '2004-11-05', 'ana.beatriz@email.com'),
('Lucas Gabriel Lima', '555.555.555-55', '2005-02-28', 'lucas.lima@email.com'),
('Mariana Alves Rocha', '666.666.666-66', '2003-09-14', 'mariana.rocha@email.com'),
('Rafael Henrique Souza', '777.777.777-77', '2004-05-18', 'rafael.souza@email.com'),
('Juliana Mendes Castro', '888.888.888-88', '2005-12-01', 'juliana.castro@email.com');

-- =========================================================================
-- Cenário 5: Período de matrículas (01 a 05/02/2026)
--
-- Os alunos escolheram as turmas em que queriam estudar. Cada matrícula
-- liga um aluno a uma turma. Nota final e faltas ainda não existem,
-- pois o semestre só estava começando (faltas iniciam em 0 por padrão).
-- =========================================================================

INSERT INTO matricula (data_matricula, id_aluno, id_turma) VALUES
('2026-02-01', 1, 1),  -- Carlos Eduardo   -> Banco de Dados
('2026-02-01', 1, 2),  -- Carlos Eduardo   -> Programação Web
('2026-02-02', 2, 4),  -- Maria Fernanda   -> Gestão Empresarial
('2026-02-02', 3, 1),  -- João Pedro       -> Banco de Dados
('2026-02-02', 3, 3),  -- João Pedro       -> Lógica de Programação
('2026-02-03', 4, 1),  -- Ana Beatriz      -> Banco de Dados
('2026-02-03', 4, 5),  -- Ana Beatriz      -> Redes I
('2026-02-03', 5, 2),  -- Lucas Gabriel    -> Programação Web
('2026-02-04', 5, 5),  -- Lucas Gabriel    -> Redes I
('2026-02-04', 6, 6),  -- Mariana Alves    -> Contabilidade Geral
('2026-02-04', 7, 1),  -- Rafael Henrique  -> Banco de Dados
('2026-02-05', 7, 3),  -- Rafael Henrique  -> Lógica de Programação
('2026-02-05', 8, 4),  -- Juliana Mendes   -> Gestão Empresarial
('2026-02-05', 8, 6),  -- Juliana Mendes   -> Contabilidade Geral
('2026-02-02', 2, 6);  -- Maria Fernanda   -> Contabilidade Geral

-- =========================================================================
-- Cenário 6: Avaliações ao longo do semestre
--
-- Em abril aconteceram as primeiras provas e em maio foram entregues os
-- trabalhos. Cada matrícula recebeu duas avaliações (id_matricula 1 a 15,
-- na mesma ordem do Cenário 5).
-- =========================================================================

INSERT INTO avaliacao (tipo, data_avaliacao, nota, id_matricula) VALUES
('Prova',    '2026-04-10', 8.00, 1),  ('Trabalho', '2026-05-20', 9.00, 1),
('Prova',    '2026-04-10', 9.00, 2),  ('Trabalho', '2026-05-20', 9.00, 2),
('Prova',    '2026-04-14', 7.50, 3),  ('Trabalho', '2026-05-22', 8.50, 3),
('Prova',    '2026-04-10', 6.00, 4),  ('Trabalho', '2026-05-20', 7.00, 4),
('Prova',    '2026-04-12', 7.00, 5),  ('Trabalho', '2026-05-21', 7.00, 5),
('Prova',    '2026-04-10', 9.00, 6),  ('Trabalho', '2026-05-20', 10.00, 6),
('Prova',    '2026-04-16', 10.00, 7), ('Trabalho', '2026-05-23', 9.00, 7),
('Prova',    '2026-04-10', 5.00, 8),  ('Trabalho', '2026-05-20', 6.00, 8),
('Prova',    '2026-04-16', 6.00, 9),  ('Trabalho', '2026-05-23', 6.00, 9),
('Prova',    '2026-04-14', 8.00, 10), ('Trabalho', '2026-05-22', 8.00, 10),
('Prova',    '2026-04-10', 9.00, 11), ('Trabalho', '2026-05-20', 9.00, 11),
('Prova',    '2026-04-12', 7.00, 12), ('Trabalho', '2026-05-21', 8.00, 12),
('Prova',    '2026-04-14', 8.50, 13), ('Trabalho', '2026-05-22', 9.50, 13),
('Seminário','2026-04-14', 7.50, 14), ('Trabalho', '2026-05-22', 8.50, 14),
('Prova',    '2026-04-14', 6.50, 15), ('Trabalho', '2026-05-22', 7.50, 15);

-- =========================================================================
-- Cenário 7: Encerramento do semestre
--
-- No fim de junho, o sistema calculou a nota final de cada matrícula
-- (média das avaliações) e a secretaria lançou o total de faltas dos
-- alunos que se ausentaram. Quem não aparece abaixo teve 0 faltas.
-- =========================================================================

UPDATE matricula
SET nota_final = (SELECT AVG(a.nota) FROM avaliacao a WHERE a.id_matricula = matricula.id_matricula)
WHERE id_matricula > 0;

UPDATE matricula
SET faltas = CASE id_matricula
    WHEN 1  THEN 2
    WHEN 3  THEN 4
    WHEN 4  THEN 6
    WHEN 5  THEN 2
    WHEN 8  THEN 8
    WHEN 9  THEN 4
    WHEN 12 THEN 1
    WHEN 15 THEN 3
    ELSE 0
END
WHERE id_matricula > 0;

-- =========================================================================
-- CONFERÊNCIA (opcional): contagem de registros por tabela (todas >= 5)
-- =========================================================================
SELECT 'curso' AS tabela, COUNT(*) AS total FROM curso
UNION ALL SELECT 'disciplina', COUNT(*) FROM disciplina
UNION ALL SELECT 'sala', COUNT(*) FROM sala
UNION ALL SELECT 'professor', COUNT(*) FROM professor
UNION ALL SELECT 'turma', COUNT(*) FROM turma
UNION ALL SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL SELECT 'avaliacao', COUNT(*) FROM avaliacao;
