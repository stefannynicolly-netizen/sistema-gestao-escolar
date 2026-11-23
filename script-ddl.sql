-- =========================================================================
-- SISTEMA DE GESTÃO ESCOLAR - SCRIPT DDL (Definição de Estrutura)
-- SGBD: MySQL 8.0 (MySQL Workbench)
--
-- Evolução em relação à versão anterior (6 tabelas):
--   + Nova tabela SALA      -> onde cada turma acontece (turma.id_sala)
--   + Nova tabela AVALIACAO -> provas/trabalhos que compõem a nota final
--   + Coluna 'turno' em CURSO (para a tabela ter 4 colunas)
-- =========================================================================

DROP DATABASE IF EXISTS sistema_gestao_escolar;
CREATE DATABASE sistema_gestao_escolar;
USE sistema_gestao_escolar;

-- =========================================================================
-- TABELAS PAI (não dependem de nenhuma outra)
-- =========================================================================

-- 1. CURSO
CREATE TABLE curso (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL UNIQUE,
  carga_horaria_total INT NOT NULL,
  turno VARCHAR(20) NOT NULL DEFAULT 'Integral',

  CONSTRAINT ck_curso_carga CHECK (carga_horaria_total > 0),
  CONSTRAINT ck_curso_turno CHECK (turno IN ('Matutino', 'Vespertino', 'Noturno', 'Integral'))
);

-- 2. SALA
CREATE TABLE sala (
  id_sala INT AUTO_INCREMENT PRIMARY KEY,
  nome_sala VARCHAR(50) NOT NULL UNIQUE,
  bloco VARCHAR(20) NOT NULL,
  capacidade INT NOT NULL,
  tipo VARCHAR(30) NOT NULL DEFAULT 'Sala de aula',

  CONSTRAINT ck_sala_capacidade CHECK (capacidade > 0),
  CONSTRAINT ck_sala_tipo CHECK (tipo IN ('Sala de aula', 'Laboratório', 'Auditório'))
);

-- 3. PROFESSOR
CREATE TABLE professor (
  id_professor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  especialidade VARCHAR(100),
  email VARCHAR(100) NOT NULL UNIQUE
);

-- 4. ALUNO
CREATE TABLE aluno (
  id_aluno INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  data_nascimento DATE NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

-- =========================================================================
-- TABELAS FILHAS (dependem das tabelas acima)
-- =========================================================================

-- 5. DISCIPLINA (depende de CURSO)
CREATE TABLE disciplina (
  id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
  nome_disciplina VARCHAR(100) NOT NULL,
  carga_horaria INT NOT NULL,
  id_curso INT NOT NULL,

  CONSTRAINT ck_disciplina_carga CHECK (carga_horaria > 0),

  CONSTRAINT fk_disciplina_curso
    FOREIGN KEY (id_curso)
    REFERENCES curso(id_curso)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. TURMA (depende de DISCIPLINA, PROFESSOR e SALA)
CREATE TABLE turma (
  id_turma INT AUTO_INCREMENT PRIMARY KEY,
  semestre_ano VARCHAR(20) NOT NULL,
  horario VARCHAR(50) NOT NULL,
  id_disciplina INT NOT NULL,
  id_professor INT NOT NULL,
  id_sala INT NOT NULL,

  CONSTRAINT ck_turma_semestre CHECK (semestre_ano REGEXP '^[0-9]{4}/[12]$'),

  CONSTRAINT fk_turma_disciplina
    FOREIGN KEY (id_disciplina)
    REFERENCES disciplina(id_disciplina)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_turma_professor
    FOREIGN KEY (id_professor)
    REFERENCES professor(id_professor)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_turma_sala
    FOREIGN KEY (id_sala)
    REFERENCES sala(id_sala)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 7. MATRICULA (depende de ALUNO e TURMA)
CREATE TABLE matricula (
  id_matricula INT AUTO_INCREMENT PRIMARY KEY,
  data_matricula DATE NOT NULL DEFAULT (CURRENT_DATE),
  nota_final DECIMAL(4,2),
  faltas INT NOT NULL DEFAULT 0,
  id_aluno INT NOT NULL,
  id_turma INT NOT NULL,

  CONSTRAINT ck_matricula_nota CHECK (nota_final BETWEEN 0 AND 10),
  CONSTRAINT ck_matricula_faltas CHECK (faltas >= 0),

  -- Um aluno não pode se matricular duas vezes na mesma turma
  CONSTRAINT uq_matricula_aluno_turma UNIQUE (id_aluno, id_turma),

  CONSTRAINT fk_matricula_aluno
    FOREIGN KEY (id_aluno)
    REFERENCES aluno(id_aluno)
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT fk_matricula_turma
    FOREIGN KEY (id_turma)
    REFERENCES turma(id_turma)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- 8. AVALIACAO (depende de MATRICULA)
CREATE TABLE avaliacao (
  id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
  tipo VARCHAR(30) NOT NULL,
  data_avaliacao DATE NOT NULL,
  nota DECIMAL(4,2) NOT NULL,
  id_matricula INT NOT NULL,

  CONSTRAINT ck_avaliacao_tipo CHECK (tipo IN ('Prova', 'Trabalho', 'Seminário')),
  CONSTRAINT ck_avaliacao_nota CHECK (nota BETWEEN 0 AND 10),

  CONSTRAINT fk_avaliacao_matricula
    FOREIGN KEY (id_matricula)
    REFERENCES matricula(id_matricula)
    ON DELETE CASCADE ON UPDATE CASCADE
);
