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


-- Modifiers
WITH yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO Modifiers(ModifierId, ModifierType)
SELECT 'CITY1_BOOST_' || yieldType.x || '_SCALING', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'
FROM yieldType;


WITH RECURSIVE cityCount(x) AS (VALUES (2) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4), -- initial value is 2, count up to including 4.
               yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId)
SELECT 'CITY' || cityCount.x || '_BOOST_' || yieldType.x || '_SCALING_REVERSE', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'PLAYER_IS_MAJOR_CIV'
FROM cityCount,
     yieldType;

-- ModifierArguments
WITH yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'CITY1_BOOST_' || yieldType.x || '_SCALING', 'Amount', 30
FROM yieldType;

WITH yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'CITY1_BOOST_' || yieldType.x || '_SCALING', 'YieldType', 'YIELD_' || yieldType.x
FROM yieldType;

WITH RECURSIVE cityCount(x) AS (VALUES (2) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4),
               yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'CITY' || cityCount.x || '_BOOST_' || yieldType.x || '_SCALING_REVERSE', 'Amount', -10
FROM cityCount,
     yieldType;

WITH RECURSIVE cityCount(x) AS (VALUES (2) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4),
               yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO ModifierArguments(ModifierId, Name, Value)
SELECT 'CITY' || cityCount.x || '_BOOST_' || yieldType.x || '_SCALING_REVERSE', 'YieldType', 'YIELD_' || yieldType.x
FROM cityCount,
     yieldType;


-- TechnologyModifiers
WITH yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO TechnologyModifiers(technologytype, modifierid)
SELECT 'TECH_CITY1', 'CITY1_BOOST_' || yieldType.x || '_SCALING'
FROM yieldType;

WITH RECURSIVE cityCount(x) AS (VALUES (2) UNION ALL SELECT x + 1 FROM cityCount WHERE x < 4),
               yieldType(x) AS (VALUES ('CULTURE'), ('SCIENCE'))
INSERT
INTO TechnologyModifiers(technologytype, modifierid)
SELECT 'TECH_CITY' || cityCount.x, 'CITY' || cityCount.x || '_BOOST_' || yieldType.x || '_SCALING_REVERSE'
FROM yieldType,
     cityCount;


DELETE
FROM GoodyHuts
WHERE GoodyHutType = 'GOODYHUT_SCIENCE';

DELETE
FROM GoodyHutSubTypes
WHERE GoodyHut = 'GOODYHUT_SCIENCE';