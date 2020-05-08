
-- Types
WITH RECURSIVE cityCount(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM cityCount WHERE x<4)
insert into Types(type, kind)
select 'TECH_CITY'||cityCount.x, 'KIND_CIVIC' from cityCount;

-- Technologies
insert into Civics(CivicType, name, cost, description, eratype, UITreeRow, advisortype)
values ('TECH_CITY1', 'LOC_TECH_CITY1', 2, 'LOC_TECH_CITY1_DESCRIPTION', 'ERA_ANCIENT', -3,'ADVISOR_GENERIC'),
       ('TECH_CITY2', 'LOC_TECH_CITY2', 4, 'LOC_TECH_CITY2_DESCRIPTION', 'ERA_ANCIENT', -3,'ADVISOR_GENERIC'),
       ('TECH_CITY3', 'LOC_TECH_CITY3', 4, 'LOC_TECH_CITY3_DESCRIPTION', 'ERA_ANCIENT', -3,'ADVISOR_GENERIC'),
       ('TECH_CITY4', 'LOC_TECH_CITY4', 4, 'LOC_TECH_CITY4_DESCRIPTION', 'ERA_ANCIENT', -3,'ADVISOR_GENERIC');


-- -- TechnologyPrereqs
-- insert into TechnologyPrereqs(technology, prereqtech)
-- values ('TECH_CITY1', 'TECH_SAILING');
--
WITH RECURSIVE cityCount(x) AS (VALUES(2) UNION ALL SELECT x+1 FROM cityCount WHERE x<4)
insert into CivicPrereqs(Civic, PrereqCivic)
select 'TECH_CITY'||cityCount.x, 'TECH_CITY'||(cityCount.x-1) FROM cityCount;

-- Boosts
WITH RECURSIVE cityCount(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM cityCount WHERE x<4)
insert into Boosts(CivicType, Boost, TriggerDescription, TriggerLongDescription, BoostClass, NumItems)
select 'TECH_CITY'||cityCount.x, 100, 'LOC_BOOST_TRIGGER_CITY'||cityCount.x, 'LOC_TECH_CITY'||cityCount.x||'_DESCRIPTION', 'BOOST_TRIGGER_NUM_CITIES', cityCount.x from cityCount;


-- Modifiers
WITH yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into Modifiers(ModifierId,ModifierType)
SELECT 'CITY1_BOOST_'||yieldType.x||'_SCALING', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER' FROM yieldType;


WITH RECURSIVE cityCount(x) AS (VALUES(2) UNION ALL SELECT x+1 FROM cityCount WHERE x<4), -- initial value is 2, count up to including 4.
			yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into Modifiers(ModifierId,ModifierType)
SELECT 'CITY'||cityCount.x||'_BOOST_'||yieldType.x||'_SCALING_REVERSE', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER' FROM cityCount, yieldType;

-- ModifierArguments
WITH yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into ModifierArguments(ModifierId,Name,Value)
select 'CITY1_BOOST_'||yieldType.x||'_SCALING', 'Amount', 30 from yieldType;

WITH yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into ModifierArguments(ModifierId,Name,Value)
select 'CITY1_BOOST_'||yieldType.x||'_SCALING', 'YieldType', 'YIELD_'||yieldType.x from yieldType;

WITH RECURSIVE cityCount(x) AS (VALUES(2) UNION ALL SELECT x+1 FROM cityCount WHERE x<4),
               yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into ModifierArguments(ModifierId,Name,Value)
select 'CITY'||cityCount.x||'_BOOST_'||yieldType.x||'_SCALING_REVERSE', 'Amount', -10 FROM cityCount, yieldType;

WITH RECURSIVE cityCount(x) AS (VALUES(2) UNION ALL SELECT x+1 FROM cityCount WHERE x<4),
               yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into ModifierArguments(ModifierId,Name,Value)
select 'CITY'||cityCount.x||'_BOOST_'||yieldType.x||'_SCALING_REVERSE', 'YieldType', 'YIELD_'||yieldType.x FROM cityCount, yieldType;

-- TechnologyModifiers
-- WITH yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
-- insert into CivicModifiers(CivicType, modifierid)
-- select 'TECH_CITY1', 'CITY1_BOOST_'||yieldType.x||'_SCALING' from yieldType;

insert into CivicModifiers(CivicType, modifierid)
values ('TECH_CITY1', 'CIVIC_GOLD_THROUGH_CITIES');

WITH RECURSIVE cityCount(x) AS (VALUES(2) UNION ALL SELECT x+1 FROM cityCount WHERE x<4),
               yieldType(x) AS (VALUES('CULTURE'), ('SCIENCE'))
insert into CivicModifiers(CivicType, modifierid)
select 'TECH_CITY1', 'CITY'||cityCount.x||'_BOOST_'||yieldType.x||'_SCALING_REVERSE' from yieldType, cityCount;