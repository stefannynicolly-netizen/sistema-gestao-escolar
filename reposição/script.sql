-- =========================================================================
-- AULA PRÁTICA: NORMALIZAÇÃO DE DADOS (1FN, 2FN e 3FN) E MAPEAMENTO DER->SQL
-- Contexto: Sistema de Gestão Escolar
-- =========================================================================

-- Remove o banco de dados se ele já existir para reiniciar os testes
DROP DATABASE IF EXISTS sistema_gestao_escolar;

-- Criação e seleção do banco de dados
CREATE DATABASE sistema_gestao_escolar;
USE sistema_gestao_escolar;


-- =========================================================================
-- CONCEITO DE NORMALIZAÇÃO DE DADOS
-- "A chave, toda a chave, e nada além da chave!"
-- =========================================================================


-- =========================================================================
-- 1. TABELA CURSO (Tabela Base para a estrutura acadêmica)
-- =========================================================================
CREATE TABLE curso (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL,
  carga_horaria_total INT NOT NULL
);


-- =========================================================================
-- 2. TABELA DISCIPLINA (Aplicando a 3FN - Dependência Transitiva)
--
-- APLICAÇÃO DA 3ª FORMA NORMAL (3FN):
-- Regra: Nenhum atributo não-chave deve depender de outro atributo não-chave.
--
-- VIOLAÇÃO DA 3FN (O QUE NÃO FAZER):
-- DISCIPLINA (id_disciplina, nome_disciplina, carga_horaria, id_curso, nome_curso)
-- Problema: id_disciplina determina id_curso, mas nome_curso depende de id_curso.
--
-- FORMA CORRETA (3FN APLICADA):
-- Mantemos apenas a chave estrangeira 'id_curso'. O nome e a carga horária 
-- do curso ficam isolados na tabela Curso.
-- =========================================================================
CREATE TABLE disciplina (
  id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
  nome_disciplina VARCHAR(100) NOT NULL,
  carga_horaria INT NOT NULL,
  id_curso INT NOT NULL,

  CONSTRAINT fk_disciplina_curso
    FOREIGN KEY (id_curso)
    REFERENCES curso(id_curso)
    ON DELETE CASCADE ON UPDATE CASCADE
);


-- =========================================================================
-- 3. TABELA PROFESSOR (Aplicando 1FN e 3FN)
--
-- APLICAÇÃO DA 1ª FORMA NORMAL (1FN - ATOMICIDADE):
-- Todos os atributos (nome, cpf, especialidade, email) são atômicos e indivisíveis.
-- =========================================================================
CREATE TABLE professor (
  id_professor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  especialidade VARCHAR(100),
  email VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================================================
-- 4. TABELA ALUNO (Aplicando 1FN e 3FN)
--
-- APLICAÇÃO DA 1ª FORMA NORMAL (1FN - ATOMICIDADE):
-- O aluno possui atributos atômicos: nome, cpf, data de nascimento e e-mail único.
-- =========================================================================
CREATE TABLE aluno (
  id_aluno INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  data_nascimento DATE NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================================================
-- 5. TABELA TURMA (Relacionamento entre Disciplina e Professor)
-- =========================================================================
CREATE TABLE turma (
  id_turma INT AUTO_INCREMENT PRIMARY KEY,
  semestre_ano VARCHAR(20) NOT NULL,
  horario VARCHAR(50) NOT NULL,
  id_disciplina INT NOT NULL,
  id_professor INT NOT NULL,

  CONSTRAINT fk_turma_disciplina
    FOREIGN KEY (id_disciplina)
    REFERENCES disciplina(id_disciplina)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_turma_professor
    FOREIGN KEY (id_professor)
    REFERENCES professor(id_professor)
    ON DELETE CASCADE ON UPDATE CASCADE
);


-- =========================================================================
-- 6. TABELA MATRICULA (Aplicando a 2ª FORMA NORMAL - 2FN)
--
-- CONCEITO: Relacionamento N:M entre Aluno e Turma com histórico de desempenho.
--
-- APLICAÇÃO DA 2ª FORMA NORMAL (2FN - DEPENDÊNCIA FUNCIONAL TOTAL):
-- Regra: Todos os atributos não-chave devem depender da totalidade do vínculo.
--
-- VIOLAÇÃO DA 2FN (O QUE NÃO FAZER):
-- MATRICULA (id_matricula, id_aluno, id_turma, nota_final, faltas, nome_aluno, nome_disciplina)
-- Problema: 'nome_aluno' depende apenas do aluno e 'nome_disciplina' apenas da turma/disciplina.
--
-- FORMA CORRETA (2FN APLICADA):
-- 'nota_final', 'faltas' e 'data_matricula' dependem do VÍNCULO entre o Aluno e a Turma.
-- Os dados de Aluno, Professor e Disciplina são buscados via JOIN.
-- =========================================================================
CREATE TABLE matricula (
  id_matricula INT AUTO_INCREMENT PRIMARY KEY,
  data_matricula DATE NOT NULL,
  nota_final DECIMAL(4,2),
  faltas INT DEFAULT 0,
  id_aluno INT NOT NULL,
  id_turma INT NOT NULL,

  CONSTRAINT fk_matricula_aluno
    FOREIGN KEY (id_aluno)
    REFERENCES aluno(id_aluno)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_matricula_turma
    FOREIGN KEY (id_turma)
    REFERENCES turma(id_turma)
    ON DELETE CASCADE ON UPDATE CASCADE
);


-- =========================================================================
-- 7. INSERÇÃO DE DADOS (DML) - POVOAMENTO DO BANCO DE DADOS
-- =========================================================================

-- Inserindo Cursos
INSERT INTO curso (nome_curso, carga_horaria_total) VALUES
('TÉCNICO EM INFORMÁTICA', 1200),
('TÉCNICO EM ADMINISTRAÇÃO', 1000);

-- Inserindo Disciplinas (3FN: FK id_curso)
INSERT INTO disciplina (nome_disciplina, carga_horaria, id_curso) VALUES
('BANCO DE DADOS', 80, 1),
('PROGRAMAÇÃO WEB', 120, 1),
('GESTÃO EMPRESARIAL', 60, 2);

-- Inserindo Professores
INSERT INTO professor (nome, cpf, especialidade, email) VALUES
('CARLOS SILVA', '111.222.333-44', 'BANCO DE DADOS', 'carlos.silva@escola.com'),
('MARIA FERNANDA', '555.666.777-88', 'ADMINISTRAÇÃO', 'maria.fernanda@escola.com');

-- Inserindo Alunos
INSERT INTO aluno (nome, cpf, data_nascimento, email) VALUES
('Carlos Eduardo Silva', '111.111.111-11', '2004-01-15', 'carlos.eduardo@email.com'),
('Maria Fernanda Oliveira', '222.222.222-22', '2005-03-20', 'maria.fernanda@email.com'),
('João Pedro Santos', '333.333.333-33', '2003-11-02', 'joao.pedro@email.com'),
('Juliana Mendes Castro', '888.888.888-88', '2004-07-10', 'juliana.mendes@email.com'); -- Aluno sem matrícula

-- Inserindo Turmas
INSERT INTO turma (semestre_ano, horario, id_disciplina, id_professor) VALUES
('2026/1', 'SEGUNDA 08:00 - 12:00', 1, 1),
('2026/1', 'TERÇA 13:30 - 17:30', 3, 2);

-- Inserindo Matrículas (2FN: Atributos dependem de id_aluno + id_turma)
INSERT INTO matricula (data_matricula, nota_final, faltas, id_aluno, id_turma) VALUES
('2026-02-01', 9.5, 2, 1, 1), -- Carlos na Turma 1
('2026-02-01', 8.0, 0, 2, 2), -- Maria na Turma 2
('2026-02-02', 7.5, 4, 3, 1), -- João na Turma 1
('2026-02-02', 9.0, 1, 3, 2); -- João na Turma 2


-- =========================================================================
-- 8. CONSULTAS DEMONSTRATIVAS DAS FORMAS NORMAIS (DQL)
-- =========================================================================

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO DA 2FN E 3FN (Reconstruindo as Informações via JOIN)
-- Exibe o histórico escolar completo juntando as tabelas sem redundância.
-- -------------------------------------------------------------------------
SELECT 
    m.id_matricula AS 'Nº Matrícula',
    a.nome AS 'Aluno',
    c.nome_curso AS 'Curso',
    d.nome_disciplina AS 'Disciplina',
    p.nome AS 'Professor',
    m.nota_final AS 'Nota Final',
    m.faltas AS 'Faltas'
FROM matricula m
INNER JOIN aluno a ON m.id_aluno = a.id_aluno
INNER JOIN turma t ON m.id_turma = t.id_turma
INNER JOIN disciplina d ON t.id_disciplina = d.id_disciplina
INNER JOIN curso c ON d.id_curso = c.id_curso
INNER JOIN professor p ON t.id_professor = p.id_professor
ORDER BY m.id_matricula;

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO COM LEFT JOIN (Exibe alunos mesmo sem matrícula cadastrada)
-- -------------------------------------------------------------------------
SELECT 
    a.id_aluno,
    a.nome AS 'Nome Aluno',
    m.id_matricula,
    m.nota_final
FROM aluno a
LEFT JOIN matricula m ON a.id_aluno = m.id_aluno;

-- -------------------------------------------------------------------------
-- DEMONSTRAÇÃO COM FILTROS E AGREGAÇÃO (GROUP BY, COUNT)
-- Exibe a quantidade total de disciplinas cursadas por aluno.
-- -------------------------------------------------------------------------
SELECT 
    a.nome AS 'Aluno',
    COUNT(m.id_matricula) AS 'Total de Matrículas'
FROM aluno a
LEFT JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.id_aluno, a.nome
ORDER BY `Total de Matrículas` DESC;
