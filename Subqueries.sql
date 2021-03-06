SELECT d.name as Department, e.name as Employee, salary as Salary

    FROM
		
--Top Salaries table
(
    SELECT departmentId, name, salary,
		
    RANK() OVER (PARTITION BY departmentId ORDER BY Salary DESC) as r1
		
    FROM Employee
		
) AS e

INNER JOIN
  
-- Department selection table

    (SELECT  
	 	id,
						
		name

FROM
		Department
		
) AS d

ON e.departmentId = d.id

WHERE r1=1

GROUP BY d.name,
        e.name,
        salary;
				
-------------------------------

Query optimised for a database (>100000 rows)

--- Keyword searches per Category

SELECT  month_

        ,category_name

        ,se_keyword

        ,visitor_count

FROM    (
            SELECT  substr(ds,1,6) AS Month_
                    ,category_name AS Category_Name
                    ,se_keyword AS Keywords
                    ,COUNT(DISTINCT(visitor_id)) AS Visitor_Count
                    ,RANK() OVER  (PARTITION BY substr(ds,1,6), category_name ORDER BY COUNT(DISTINCT(visitor_id)) DESC) AS rank1
            FROM    (
                        SELECT  id,
		    
                                category_name
FROM    test_table

) AS A

JOIN 
	(SELECT id
               ,se_keyword
    	        ,visitor_id
               ,ds  
	 
FROM 	test_table  
	 
               WHERE date BETWEEN 20220101 AND 20220531 
               AND venture = 'PK'
) AS B
          
	ON    A.id = B.id  
	
	GROUP BY Month_
        ,category_name
        ,se_keyword
 ) 
 
WHERE   rank1 <= 20

GROUP BY 
        month_
					
         ,category_name
				 
         ,se_keyword
				 
         ,visitor_count

;
