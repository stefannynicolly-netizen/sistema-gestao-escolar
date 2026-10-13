
# Sistema de Gestão Escolar

## 1. Descrição do Minimundo
Uma instituição de ensino necessita de um sistema informatizado para gerenciar centralizadamente seus processos acadêmicos, visando resolver problemáticas e desorganizações no controle de matrículas, alocação de turmas e acompanhamento do desempenho de seus discentes.

A instituição oferece diversos Cursos (como Informática e Administração), onde cada curso possui uma carga horária total e é composto por um conjunto de Disciplinas que compõem sua grade curricular. Cada disciplina tem um nome e carga horária própria, pertencendo obrigatoriamente a apenas um curso.

Para viabilizar as aulas a cada período letivo, são abertas Turmas para as disciplinas. Cada turma é uma oferta prática associada a uma única disciplina e possui definidos o ano/semestre letivo e seu horário de funcionamento. Além disso, cada turma conta com exatamente um Professor responsável alocado para ministrá-la. O sistema mantém os dados dos professores, tais como nome, CPF, e-mail e especialidade.

Os Alunos são cadastrados na instituição com informações essenciais como nome, CPF, data de nascimento e e-mail. Para cursar as disciplinas, o aluno efetua sua Matrícula nas turmas ofertadas. Uma matrícula vincula exclusivamente um aluno a uma determinada turma em uma data específica. Através do registro de matrícula, o sistema realiza o acompanhamento acadêmico do aluno, registrando sua nota final e o total de faltas na respectiva turma.


## 2. Contexto da Aplicação 
A aplicação atende a comunidade escolar, permitindo a administração do corpo docente e discente, a estruturação da grade curricular e o acompanhamento do desempenho acadêmico.

## 3. Processos Principais
* **Gestão de Pessoas:** Cadastro e atualização dos dados de alunos e professores.
* **Organização Acadêmica:** Estruturação de cursos, disciplinas e abertura de turmas para cada período letivo.
* **Matrícula:** Inscrição de alunos nas turmas disponíveis.
* **Acompanhamento Escolar:** Registro e consulta de notas e faltas dos alunos.

## 4. Regras de Negócio
1. **Cadastro de Alunos:** Todo aluno deve ter um cadastro ativo no sistema com dados pessoais válidos para realizar matrículas em turmas;
2. **Vínculo da Disciplina ao Curso:** Cada disciplina pertence a um único curso específico. Um curso pode ser composto por uma ou várias disciplinas;
3. **Oferta de Turmas:** Uma disciplina pode dar origem a nenhuma ou a várias turmas ao longo dos períodos letivos, mas cada turma pertence exclusivamente a uma única disciplina;
4. **Alocação Docente:** Cada turma é ministrada por exatamente um professor responsável. Um professor pode ministrar nenhuma ou várias turmas no período letivo;
5. **Vínculo de Matrícula:** Um aluno possui de 1 a N registros de matrícula no sistema, e cada registro de matrícula pertence exclusivamente a um único aluno;
6. **Composição da Turma:** Uma turma é composta por 1 a N matrículas de alunos. Cada matrícula vincula o aluno a apenas uma turma;
7. **Histórico Acadêmico:** O registro da matrícula na turma armazena a história acadêmica do aluno, registrando a data da matrícula, sua nota final e o total de faltas acumuladas.

## 5. Sistema de Gestão Escolar no MySQL Workbench

Modelagem e implementação de um banco de dados relacional para o gerenciamento escolar, desenvolvido no **MySQL Workbench**.

## Características do MySQL Workbench:

- **Database:** MySQL 8.0
- **SGBD GUI:** MySQL Workbench

## Modelo de Banco de Dados (DER)

Abaixo está a representação visual do Diagrama de Entidade e Relacionamento (EER) do sistema:

<img width="826" height="799" alt="diagrama_banco" src="https://github.com/user-attachments/assets/6cb7ae86-d0f0-4172-be08-542384a07d1e" />



## Estrutura das Tabelas

O banco de dados é composto por 6 tabelas interligadas:

1. **`curso`**: Armazena as informações dos cursos oferecidos.
2. **`disciplina`**: Disciplinas associadas a um curso específico.
3. **`professor`**: Cadastro de professores da instituição.
4. **`aluno`**: Cadastro de alunos matriculados.
5. **`turma`**: Vincula disciplinas a professores em um horário/semestre.
6. **`matricula`**: Relaciona os alunos às suas respectivas turmas, registrando notas e faltas.

## 6. Script SQL Completo (DDL e DML)

```sql


CREATE DATABASE IF NOT EXISTS sistema_gestao_escolar;
USE sistema_gestao_escolar;

-- Tabela Curso
CREATE TABLE IF NOT EXISTS curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    carga_horaria_total INT NOT NULL
);

-- Tabela Disciplina
CREATE TABLE IF NOT EXISTS disciplina (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela Professor
CREATE TABLE IF NOT EXISTS professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    especialidade VARCHAR(100),
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela Aluno
CREATE TABLE IF NOT EXISTS aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela Turma
CREATE TABLE IF NOT EXISTS turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    semestre_ano VARCHAR(20) NOT NULL,
    horario VARCHAR(50) NOT NULL,
    id_disciplina INT NOT NULL,
    id_professor INT NOT NULL,
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela Matrícula
CREATE TABLE IF NOT EXISTS matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    data_matricula DATE NOT NULL,
    nota_final DECIMAL(4, 2),
    faltas INT DEFAULT 0,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
        ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO curso (nome_curso, carga_horaria_total) VALUES
('TÉCNICO EM INFORMÁTICA', 1200),
('TÉCNICO EM ADMINISTRAÇÃO', 1000);

INSERT INTO disciplina (nome_disciplina, carga_horaria, id_curso) VALUES
('BANCO DE DADOS', 80, 1),
('PROGRAMAÇÃO WEB', 120, 1),
('GESTÃO EMPRESARIAL', 60, 2);

INSERT INTO professor (nome, cpf, especialidade, email) VALUES
('CARLOS SILVA', '111.222.333-44', 'BANCO DE DADOS', 'carlos.silva@escola.com'),
('MARIA FERNANDA', '555.666.777-88', 'ADMINISTRAÇÃO', 'maria.fernanda@escola.com');

INSERT INTO aluno (nome, cpf, data_nascimento, email) VALUES
('JOÃO PEDRO', '123.456.789-00', '2005-03-15', 'joao.pedro@email.com'),
('ANA BEATRIZ', '987.654.321-11', '2004-08-22', 'ana.beatriz@email.com');

INSERT INTO turma (semestre_ano, horario, id_disciplina, id_professor) VALUES
('2026/1', 'SEGUNDA 08:00 - 12:00', 1, 1),
('2026/1', 'TERÇA 13:30 - 17:30', 3, 2);

INSERT INTO matricula (data_matricula, nota_final, faltas, id_aluno, id_turma) VALUES
('2026-02-10', 9.5, 2, 1, 1),
('2026-02-11', 8.0, 0, 2, 2);
```

---

## 7.  Consulta de Relatório Geral (DQL)

```sql
SELECT 
    a.nome AS Aluno,
    c.nome_curso AS Curso,
    d.nome_disciplina AS Disciplina,
    p.nome AS Professor,
    m.nota_final AS Nota,
    m.faltas AS Faltas
FROM matricula m
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN turma t ON m.id_turma = t.id_turma
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
JOIN curso c ON d.id_curso = c.id_curso
JOIN professor p ON t.id_professor = p.id_professor;
```
