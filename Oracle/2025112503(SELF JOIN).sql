2025-11-25-03) SELF JOIN
 - 한 테이블에 복수개의 별칭을 사용하여 마치 서로 다른테이블인 것처럼 수행하는 조인...
-- 사용예)
 1) 회원테이블에서 회원번호 'dOO1'회원의 마일리지보다 더 많은 마일리지를 보유한
    회원의 회원번호, 회원명, 마일리지를 조회하시오...
    
    SELECT  B.MEM_ID AS 회원번호,
            B.MEM_NAME AS 회원명,
            B.MEM_MILEAGE AS 마일리지
    FROM    MEMBER B,MEMBER D
    WHERE    D.MEM_ID= 'd001'
    AND      D.MEM_MILEAGE<B.MEM_MILEAGE
    ORDER BY 3;

    
 2) 2020년 입사한 사원 중 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의
    사원번호, 사원명, 입사일, 급여를 조회하시오...
   
    SELECT  MAX(SALARY)
    FROM    HR.EMPLOYEES
    WHERE   EXTRACT(YEAR FROM HIRE_DATE) = 2020
    
    SELECT  E.EMPLOYEE_ID AS 사원번호,
            E.EMP_NAME AS 사원명,
            E.HIRE_DATE AS 입사일,
            E.SALARY AS 급여
    FROM    HR.EMPLOYEES E,
            (SELECT  MAX(SALARY) AS MAXS
             FROM    HR.EMPLOYEES
             WHERE   EXTRACT(YEAR FROM HIRE_DATE) = 2020) B
    WHERE   E.SALARY>B.MAXS
    ORDER BY 4;
        