# Especificação Conceitual do Banco de Dados (Mer)

## 1. Entidades

* Aluno
* **Definição:** Representa a pessoa matriculada na instituição que cursa as disciplinas e possui registro de notas e frequência.
* Professor
* **Definição:** Representa o docente encarregado de ministrar as disciplinas e lançar as avaliações.
* Curso
* **Definição:** Representa o programa acadêmico (ex: Informática, Administração) que agrupa um conjunto de disciplinas.
* Disciplina
* **Definição:** Representa a matéria ou unidade curricular oferecida em determinado curso.
* Turma
* **Definição:** Representa a oferta prática de uma disciplina em um período específico com professor e horários vinculados.
* Matrícula
* **Definição:** Representa a associação e o histórico do aluno em uma turma específica, registrando nota final e faltas.

## 2. Relacionamentos e Cardinalidades

* **[Curso] (1,1) <possui> (1,N) [Disciplina]**
* **Explicação:** Um Curso possui 1 ou várias Disciplinas, mas cada Disciplina pertence a apenas 1 Curso específico.
* **[Disciplina] (1,1) <gera> (0,N) [Turma]**
* **Explicação:** Uma Disciplina pode dar origem a nenhuma ou várias Turmas, mas cada Turma pertence a apenas 1 Disciplina.
* **[Professor] (1,1) <leciona> (0,N) [Turma]**
* **Explicação:** Um Professor pode ministrar nenhuma ou várias Turmas, mas cada Turma tem exatamente 1 Professor responsável.
