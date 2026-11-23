# Sistema de Gestão Escolar

## 1. Descrição do Minimundo
Uma instituição de ensino necessita de um sistema informatizado para gerenciar centralizadamente seus processos acadêmicos, visando resolver problemáticas e desorganizações no controle de matrículas, alocação de turmas e acompanhamento do desempenho de seus discentes.

A instituição oferece diversos Cursos (como Informática e Administração), onde cada curso possui uma carga horária total, um turno de funcionamento e é composto por um conjunto de Disciplinas que compõem sua grade curricular. Cada disciplina tem um nome e carga horária própria, pertencendo obrigatoriamente a apenas um curso.

Para viabilizar as aulas a cada período letivo, são abertas Turmas para as disciplinas. Cada turma é uma oferta prática associada a uma única disciplina e possui definidos o ano/semestre letivo e seu horário de funcionamento. Além disso, cada turma conta com exatamente um Professor responsável alocado para ministrá-la e acontece em uma Sala da instituição (sala de aula, laboratório ou auditório). O sistema mantém os dados dos professores, tais como nome, CPF, e-mail e especialidade.

Os Alunos são cadastrados na instituição com informações essenciais como nome, CPF, data de nascimento e e-mail. Para cursar as disciplinas, o aluno efetua sua Matrícula nas turmas ofertadas. Uma matrícula vincula exclusivamente um aluno a uma determinada turma em uma data específica. Através do registro de matrícula, o sistema realiza o acompanhamento acadêmico do aluno, registrando sua nota final e o total de faltas na respectiva turma. A nota final é resultado das Avaliações (provas, trabalhos e seminários) realizadas pelo aluno ao longo do semestre.

## 2. Contexto da Aplicação
A aplicação atende a comunidade escolar, permitindo a administração do corpo docente e discente, a estruturação da grade curricular, o controle dos espaços físicos e o acompanhamento do desempenho acadêmico.

## 3. Processos Principais
* **Gestão de Pessoas:** Cadastro e atualização dos dados de alunos e professores.
* **Organização Acadêmica:** Estruturação de cursos, disciplinas e abertura de turmas para cada período letivo, com definição de professor e sala.
* **Matrícula:** Inscrição de alunos nas turmas disponíveis.
* **Acompanhamento Escolar:** Registro e consulta de avaliações, notas finais e faltas dos alunos.

## 4. Regras de Negócio
1. **Cadastro de Alunos:** Todo aluno deve ter um cadastro ativo no sistema com dados pessoais válidos para realizar matrículas em turmas;
2. **Vínculo da Disciplina ao Curso:** Cada disciplina pertence a um único curso específico. Um curso pode ser composto por uma ou várias disciplinas;
3. **Oferta de Turmas:** Uma disciplina pode dar origem a nenhuma ou a várias turmas ao longo dos períodos letivos, mas cada turma pertence exclusivamente a uma única disciplina;
4. **Alocação Docente:** Cada turma é ministrada por exatamente um professor responsável. Um professor pode ministrar nenhuma ou várias turmas no período letivo;
5. **Vínculo de Matrícula:** Um aluno possui de 1 a N registros de matrícula no sistema, e cada registro de matrícula pertence exclusivamente a um único aluno;
6. **Composição da Turma:** Uma turma é composta por 1 a N matrículas de alunos. Cada matrícula vincula o aluno a apenas uma turma, e um aluno não pode se matricular duas vezes na mesma turma;
7. **Histórico Acadêmico:** O registro da matrícula na turma armazena a história acadêmica do aluno, registrando a data da matrícula, sua nota final e o total de faltas acumuladas;
8. **Alocação de Espaço:** Cada turma acontece em exatamente uma sala. Uma sala pode sediar nenhuma ou várias turmas;
9. **Avaliações:** Cada matrícula pode receber nenhuma ou várias avaliações (prova, trabalho ou seminário), e cada avaliação pertence a uma única matrícula. A nota final da matrícula é a média das suas avaliações.

## 5. Sistema de Gestão Escolar no MySQL Workbench

Modelagem e implementação de um banco de dados relacional para o gerenciamento escolar, desenvolvido no **MySQL Workbench**.

### Características

- **Database:** MySQL 8.0
- **SGBD GUI:** MySQL Workbench

### Modelo de Banco de Dados (DER)

Representação visual do Diagrama de Entidade e Relacionamento (EER) do sistema, com as 8 tabelas:


<img width="904" height="663" alt="diagrama_banco" src="https://github.com/user-attachments/assets/ad8f2416-2c74-4616-8425-b5f0a1b3623a" />


### Estrutura das Tabelas

O banco de dados é composto por **8 tabelas** interligadas:

1. **`curso`**: Informações dos cursos oferecidos (nome, carga horária total e turno).
2. **`sala`**: Salas, laboratórios e auditórios da instituição (bloco, capacidade e tipo).
3. **`professor`**: Cadastro de professores da instituição.
4. **`aluno`**: Cadastro de alunos.
5. **`disciplina`**: Disciplinas associadas a um curso específico.
6. **`turma`**: Oferta de uma disciplina em um semestre, com professor, sala e horário.
7. **`matricula`**: Relaciona os alunos às suas turmas, registrando nota final e faltas.
8. **`avaliacao`**: Provas, trabalhos e seminários de cada matrícula, que compõem a nota final.

## 6. Scripts SQL

Os scripts ficam na raiz do repositório:

| Arquivo | Conteúdo |
|---|---|
| [`script-ddl.sql`](script-ddl.sql) | Criação do banco e das 8 tabelas (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT e CHECK) |
| [`script-dml.sql`](script-dml.sql) | Povoamento com narrativa de dados, organizado em 7 cenários |

**Ordem de execução:** primeiro o `script-ddl.sql`, depois o `script-dml.sql`.

### Cenários do povoamento (DML)

1. **Estrutura da instituição:** cadastro de cursos, disciplinas e salas.
2. **Corpo docente:** cadastro dos professores.
3. **Abertura de turmas:** turmas de 2026/1 com disciplina, professor, sala e horário.
4. **Cadastro dos alunos:** oito alunos cadastrados na semana de acolhimento.
5. **Período de matrículas:** alunos escolhem suas turmas.
6. **Avaliações:** provas e trabalhos ao longo do semestre.
7. **Encerramento do semestre:** cálculo da nota final e lançamento das faltas.

## 7. Consulta de Relatório Geral (DQL)

```sql
SELECT
    a.nome AS Aluno,
    c.nome_curso AS Curso,
    d.nome_disciplina AS Disciplina,
    p.nome AS Professor,
    s.nome_sala AS Sala,
    m.nota_final AS Nota,
    m.faltas AS Faltas
FROM matricula m
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN turma t ON m.id_turma = t.id_turma
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
JOIN curso c ON d.id_curso = c.id_curso
JOIN professor p ON t.id_professor = p.id_professor
JOIN sala s ON t.id_sala = s.id_sala;
```
