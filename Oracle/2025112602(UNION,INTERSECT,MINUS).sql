2025-11-26-02)집합연산자
 - 복수개의 SELECT문의 결과를 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)
   을 수행하는 연산자를 사용하여 결과를 반환
 - 집합연산 수행시 주의 사항
  . 각 SELECT 문의 컬럼의 갯수,타입은 일치해야 함
  . 컬럼의 별칭은 첫 번째 SELECT 문의 별칭이 적용됨(두 번째 SELECT문 부터 사용된 컬럼별칭은 무시)
  . ORDER BY 절은 맨 마지막 SELECT문에서만 가능
  . SELECT 절에 사용된 동일한 컬럼이라도 저장된 값이 다르면 서로 다른 컬럼으로 간주됨
  
--1.UNION(합집합), UNION ALL
   - UNION : 각 결과 집합에서 조회된 중복 값은 1번만 조회됨
   - UNION ALL : UNOIN과 동일하나 중복값도 모두 적음
   
사용예) 충남에 거주하는 인원이거나 주부인 인원을 조회하시오
    SELECT  MEM_ID      AS 회원번호,
            MEM_NAME    AS 회원명,
            MEM_MILEAGE AS 마일리지
    FROM    MEMBER
    WHERE   MEM_ADD1 LIKE '충남%'
    UNION ALL
    SELECT  MEM_ID,
            MEM_NAME,
            MEM_MILEAGE
    FROM    MEMBER
    WHERE   MEM_JOB='주부'
    ORDER BY 1;
2) UNION/UNION ALL 은 구조가 다른 복수개의 테이블을 하나의 테이블로 표현
    CREATE TABLE BUDGET(
        PERIOD CHAR(6),
        BUDGET_AMT NUMBER(6));
        
    CREATE TABLE RES(
        PERIOD CHAR(6),
        RES_AMT NUMBER(6));
        
    INSERT INTO BUDGET VALUES('202502',1000);    
    INSERT INTO BUDGET VALUES('202503',2500);    
    INSERT INTO BUDGET VALUES('202504',2000);    
    
    INSERT INTO RES VALUES('202501',1200);
    INSERT INTO RES VALUES('202502',1500);
    INSERT INTO RES VALUES('202503',2500);
    INSERT INTO RES VALUES('202504',3000);
    SELECT 
        PERIOD          AS 기간,
        SUM(BUDGET_AMT) AS 계획,
        SUM(RES_AMT)    AS 실적,
        LPAD(ROUND((SUM(RES_AMT)/SUM(BUDGET_AMT))*100) ||'%',6)  AS 달성률
    FROM
        (SELECT  PERIOD, BUDGET_AMT,0 AS RES_AMT
         FROM    BUDGET
         UNION
         SELECT  PERIOD,0,RES_AMT 
         FROM    RES)
    GROUP BY PERIOD
    ORDER BY 1;
    
    SELECT * FROM BUDGET, RES
    WHERE RES.PERIOD=BUDGET.PERIOD
    
--2. 교집합(INTERSECT)
  - 복수개의 결과 집합 중 공통부분을 반환
  - EXISTS 연산자로 구현 가능하다...
  
사용예) 장바구니 테이블에서 2020년 4월 판매된 상품으로 6월에도 판매된 상품의 상품번호, 상품명을
      조회하시오...
2020년 4월에 판매된 상품의 상품번호, 상품명     
    SELECT DISTINCT
        A.PROD_ID AS 상품번호,
        B.PROD_NAME AS 상품명
    FROM
        CART A
    INNER JOIN PROD B
            ON (B.PROD_ID = A.PROD_ID AND A.CART_NO LIKE '202004%')
    INTERSECT                                     --2020년 6월에 판매된 상품의 상품번호, 상품명
    SELECT DISTINCT
        A.PROD_ID,
        B.PROD_NAME
    FROM
        CART A
    INNER JOIN PROD B
            ON (B.PROD_ID = A.PROD_ID AND A.CART_NO LIKE '202006%')
    ORDER BY 1
    
(EXISTS 연산자 사용)
    SELECT DISTINCT
        A.PROD_ID AS 상품번호,
        B.PROD_NAME AS 상품명
    FROM
        CART A
    INNER JOIN PROD B
            ON (B.PROD_ID = A.PROD_ID AND A.CART_NO LIKE '202004%')
    WHERE EXISTS(SELECT 1
                 FROM   CART B
                 INNER JOIN PROD C
                         ON (C.PROD_ID = B.PROD_ID AND B.CART_NO LIKE '202006%')
                 WHERE  A.PROD_ID = B.PROD_ID)
                 
    SELECT DISTINCT
        A.PROD_ID AS 상품번호,
        B.PROD_NAME AS 상품명
    FROM
        CART A
    INNER JOIN PROD B
            ON (B.PROD_ID = A.PROD_ID AND A.CART_NO LIKE '202004%')
    INNER JOIN (SELECT B.PROD_ID
                 FROM   CART B
                 INNER JOIN PROD C
                         ON (C.PROD_ID = B.PROD_ID AND B.CART_NO LIKE '202006%')
                 ) C
            ON (C.PROD_ID = A.PROD_ID)

--3. 차집합(MINUS)
   - 선행 결과값에서 후행 결과값을 제외한 나머지를 반환
   - NOT EXISTS 연산자로 구현가능

사용예)HR계정의 사원테이블에서 80번 부서에 소속된 사원 중에 급여가 9000미만인 사원들을 조회하시오
      Alias는 사원번호, 사원명, 직책코드, 급여
(메인쿼리 : 80번 부서에 소속된 사원의 정보)
    MINUS
(서브쿼리 : 급여가 9000이상)

    SELECT  
        EMPLOYEE_ID AS 사원번호,
        EMP_NAME    AS 사원명,
        JOB_ID      AS 직무코드,
        SALARY      AS 급여
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = 80

    MINUS

    SELECT  
        EMPLOYEE_ID,
        EMP_NAME,
        JOB_ID,
        SALARY
    FROM    HR.EMPLOYEES
    WHERE   SALARY>=9000
    
(EXISTS 연산자)
    SELECT  
        A.EMPLOYEE_ID AS 사원번호,
        A.EMP_NAME    AS 사원명,
        A.JOB_ID      AS 직무코드,
        A.SALARY      AS 급여
    FROM    HR.EMPLOYEES A
    WHERE   A.DEPARTMENT_ID = 80
    AND NOT EXISTS( SELECT  1 
                    FROM    HR.EMPLOYEES B
                    WHERE   SALARY>=9000
                    AND     A.EMPLOYEE_ID = B.EMPLOYEE_ID)