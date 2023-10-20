GRANT SELECT ON SCHEMA :: Person TO WilJo WITH GRANT OPTION;  

CREATE ROLE  WFAdmin_Execute

Select * from sysobjects where type ='P'

GRANT EXECUTE ON OBJECT::HumanResources.uspUpdateEmployeeHireInfo  
    TO WFAdmin_Execute;  

SELECT 
 Cast( ROUTINE_SCHEMA + '.' + ROUTINE_NAME  as varchar(100)) As StoredProc
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE'
AND ROUTINE_SCHEMA ='WFAdmin' 
order by ROUTINE_NAME ;