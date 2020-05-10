-- Types
WITH RECURSIVE cityCount(x) AS (VALUES (1) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4)
INSERT
INTO Types(type, kind)
SELECT 'TECH_CITY' || cityCount.x, 'KIND_TECH'
FROM cityCount;

-- Technologies
INSERT INTO Technologies(technologytype, name, cost, description, eratype, UITreeRow, advisortype)
VALUES ('TECH_CITY1', 'LOC_TECH_CITY1', 2, 'LOC_TECH_CITY1_DESCRIPTION', 'ERA_ANCIENT', -2, 'ADVISOR_GENERIC'),
       ('TECH_CITY2', 'LOC_TECH_CITY2', 4, 'LOC_TECH_CITY2_DESCRIPTION', 'ERA_ANCIENT', -1, 'ADVISOR_GENERIC'),
       ('TECH_CITY3', 'LOC_TECH_CITY3', 4, 'LOC_TECH_CITY3_DESCRIPTION', 'ERA_ANCIENT', -2, 'ADVISOR_GENERIC'),
       ('TECH_CITY4', 'LOC_TECH_CITY4', 4, 'LOC_TECH_CITY4_DESCRIPTION', 'ERA_ANCIENT', -3, 'ADVISOR_GENERIC');


-- TechnologyPrereqs
WITH RECURSIVE cityCount(x) AS (VALUES (1) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4)
INSERT
INTO TechnologyPrereqs(technology, prereqtech)
SELECT 'TECH_CITY' || cityCount.x, 'TECH_FUTURE_TECH'
FROM cityCount;

DELETE
FROM GoodyHuts
WHERE GoodyHutType = 'GOODYHUT_SCIENCE';

DELETE
FROM GoodyHutSubTypes
WHERE GoodyHut = 'GOODYHUT_SCIENCE';