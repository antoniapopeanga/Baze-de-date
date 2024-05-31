--1
select p.nume,p.prenume
from consultatie c
join pacient p on c.id_pacient=p.id_pacient
join prescriptie pr on c.id_consultatie=pr.id_consultatie
where id_medicament in (select m.id_medicament
                       from medicament m
                       where lower(m.nume)='ibuprofen'
                       );
--2

select id_doctor, nume, prenume, sectie, salariu, numar_consultatii
from (
    select d.id_doctor, d.nume, d.prenume, s.nume as sectie, d.salariu, count(c.id_consultatie) as numar_consultatii
    from doctor d
    join sectie s on d.id_sectie = s.id_sectie
    join consultatie c on d.id_doctor = c.id_doctor
    group by d.id_doctor, d.nume, d.prenume, s.nume, d.salariu
    having count(c.id_consultatie) >= 2
    order by d.salariu desc
    ) 
where rownum <=2
order by salariu desc, numar_consultatii asc;

--3
select 
    coalesce(d.nume, '-'),
    coalesce(d.prenume, '-'),
    coalesce(d.salariu, 0),
    s.nume as sectie
from 
    sectie s
    left join (
        select 
            id_sectie,nume,prenume, salariu
        from doctor d1
        where salariu =(
                select max(salariu)
                from doctor d2
                where d1.id_sectie = d2.id_sectie
            )
    ) d on s.id_sectie = d.id_sectie;

--4

select p.id_pacient, p.nume, p.prenume, s.id_sectie as id_sectie, s.nume as sectie
from pacient p
inner join sectie s on p.id_sectie = s.id_sectie
where s.id_sectie in (
  select s2.id_sectie
  from sectie s2
  inner join doctor d on s2.id_sectie = d.id_sectie
  inner join consultatie c on d.id_doctor = c.id_doctor
  group by s2.id_sectie
  having count(distinct c.id_consultatie) = (
    select min(cnt)
    from (
      select count(distinct c2.id_consultatie) as cnt
      from sectie s3
      inner join doctor d2 on s3.id_sectie = d2.id_sectie
      inner join consultatie c2 on d2.id_doctor = c2.id_doctor
      group by s3.id_sectie
    ) 
  )
)





