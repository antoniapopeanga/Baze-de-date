--1
select m.denumire
  from magazin m
    join stoc s on m.id_magazin=s.cod_magazin
    join produs p on s.cod_produs=p.id_produs
  where lower(p.denumire)='nexus 7' and s.pret<=all(select s.pret
    from stoc s
     where s.cod_produs = p.id_produs);
--2
select c.denumire as categorie,p.denumire as produs, prod.service
from produs p
join categorie c on p.cod_categorie=c.id_categorie
join producator prod on p.cod_producator=prod.id_producator
where prod.service is not null;

--3
select prod.nume as nume_producator
  from producator prod
    join produs p on p.cod_producator=prod.id_producator
    join stoc s on p.id_produs=s.cod_produs
    join magazin m on s.cod_magazin=m.id_magazin
  where lower(m.oras)='bucuresti'
   and prod.nume
   not in(select distinct prod1.nume
    from producator prod1
    join produs p1 on prod1.id_producator=p1.cod_producator
    join stoc s1 on p1.id_produs=s1.cod_produs
    join magazin m1 on s1.cod_magazin=m1.id_magazin
   where lower(m1.oras)='iasi'
);

--4
select m.denumire as magazin, p.denumire as produs
    from produs p
        join stoc s on p.id_produs=s.cod_produs
        join magazin m on s.cod_magazin=m.id_magazin
          where s.cantitate>=all(select s1.cantitate
          from stoc s1
          where s1.cod_magazin=m.id_magazin);