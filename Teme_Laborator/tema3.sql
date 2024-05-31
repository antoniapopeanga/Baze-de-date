--1
select c.last_name,c.first_name,e.event_date,e.status
from orders o
join customers c on o.customer_id=c.customer_id
join events e on o.event_id=e.event_id
where extract (year from e.event_date)=2021 and
      extract(month from e.event_date)=12;
--2
select p.title as titlu_piesa, count(pa.actor_id) as numar_actori
from plays_actors pa
join actors a on pa.actor_id=a.actor_id
join plays p on pa.play_id=p.play_id
where pa.play_id in (
select id_piesa
from(
select a.actor_id as actor, p.play_id as id_piesa
              from plays_actors pa
              join actors a on pa.actor_id=a.actor_id
              join plays p on pa.play_id=p.play_id
              where lower(place_of_birth)<>'bucuresti'
intersect
select a.actor_id as actor,p.play_id as id_piesa
from plays_actors pa
join actors a on pa.actor_id=a.actor_id
join plays p on pa.play_id=p.play_id
where lower(p.genre)='drama'
)
)
group by p.title;
--3
with temp as(
select e.event_id as eveniment,p.title, sum(o.num_seats) as nr_spectatori
from orders o
join customers c on o.customer_id=c.customer_id
join events e on o.event_id=e.event_id
join plays p on e.play_id=p.play_id
group by e.event_id,p.title
)
select temp.title as piesa, avg(temp.nr_spectatori) as nr_spectatori_medie
from temp
group by title;
--4

with nr_evenimente_piesa as (
  select p.play_id, count(distinct e.event_id) as nr_evenimente
  from plays p
  join events e on p.play_id = e.play_id
  where extract(year from e.event_date) = 2021
  group by p.play_id
)
select p.title, count(distinct pa.actor_id) as nr_actori, nep.nr_evenimente
from plays p
join plays_actors pa on p.play_id = pa.play_id
join nr_evenimente_piesa nep on p.play_id = nep.play_id
where nep.nr_evenimente = (select max(nr_evenimente) from nr_evenimente_piesa)
group by p.title, nep.nr_evenimente;




            