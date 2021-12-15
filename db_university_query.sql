
-- Selezionare tutti gli studenti nati nel 1990
select
	registration_number,
	name,
	surname,
	date_of_birth
from
	students s
where
	year(date_of_birth) = 1990;
	

-- Selezionare tutti i corsi che valgono più di 10 crediti
select
	*
from
	courses c
where
	cfu > 10;
	

-- Selezionare tutti gli studenti che hanno più di 30 anni
select
	*
from
	students s
where
	TIMESTAMPDIFF(year,
	date_of_birth,
	curdate()) > 30;
	

-- Selezionare tutti i corsi di laurea magistrale
select
	*
from
	degrees d
where
	d.`level` = 'magistrale';
	

-- Da quanti dipartimenti è composta l’università?
select
	count(d.id) as departments_number
from
	departments d;
	

-- Quanti sono gli insegnanti che non hanno un numero di telefono?
select
	count(t.id) as teachers_without_phone
from
	teachers t
where
	t.phone is null;
	

-- Contare quanti iscritti ci sono stati ogni anno
select
	year(s.enrolment_date),
	count(s.id) as subscribers
from
	students s
group by
	year(s.enrolment_date)
order by
	s.enrolment_date desc;
	

-- Calcolare la media dei voti di ogni appello d’esame
select
	es.exam_id,
	avg(es.vote) as vote_avg
from
	exam_student es
group by
	es.exam_id
order by
	es.exam_id desc;
	

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
select
	d.department_id,
	count(d.id) as degrees_number
from
	degrees d
group by
	d.department_id;
	

-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
select
	*
from
	students s
inner join `degrees` d on
	s.degree_id = d.id
having
	d.name = 'Corso di Laurea in Economia';
	

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
select
	*
from
	`degrees` d
inner join departments d2 on
	d.department_id = d2.id
having
	d2.name = 'Dipartimento di Neuroscienze'
	and d.`level` = 'magistrale';
	

-- Selezionare tutti i corsi in cui insegna Fulvio Amato
select
	t.surname,
	t.name,
	c.id,
	c.name
from
	teachers t
inner join course_teacher ct on
	t.id = ct.teacher_id
inner join courses c on
	c.id = ct.course_id
having
	t.name = 'Fulvio'
	and t.surname = 'Amato';
	

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, 
-- in ordine alfabetico per cognome e nome
select
	s.surname,
	s.name ,
	d.name ,
	d.`level` ,
	d.address ,
	d.email ,
	d.website ,
	d2.name
from
	students s
inner join `degrees` d on
	s.degree_id = d.id
inner join departments d2 on
	d.department_id = d2.id
order by
	s.surname,
	s.name;
	

-- Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
select
	s.surname ,
	s.name ,
	es.exam_id,
	count(es.exam_id) as number_of_try
from
	students s
inner join exam_student es on
	es.student_id = s.id
where
	es.vote <= 18
group by
	es.exam_id
order by
	s.surname ,
	s.name,
	es.exam_id asc;