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
1. Todo aluno deve ter um cadastro ativo para realizar matrículas em turmas.
2. Cada disciplina pertence a um único curso.
3. Cada turma é associada a uma única disciplina e ministrada por apenas um professor responsável.
4. O histórico do aluno em cada turma registra sua nota final e total de faltas.
