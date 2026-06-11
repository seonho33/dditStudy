2025-11-12-01)기타연산자
  - BETWEEN, LIKE, IN, ANY, SOME, EXISTS 등이 제공됨
  
-- 1. BETWEEN 연산자
1)BETWEEN
 - 범위를 지정할 때 사용
 (사용형식)
    expr BETWEEN 값1 AND 값2
    -expr 값이 '값1'에서 '값2' 사이에 존재하면 참(TRUE)을 반환
    -AND 연산자로 바꾸어 사용할 수 있다.
-- 사용예
 1) 2020년 1월 매입자료를 조회하시오, 출력은 매입일자, 상품코드, 수량
SELECT BUY_DATE AS 매입일자,
       PROD_ID AS 상품코드,
       BUY_QTY AS 수량
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
 ORDER BY BUY_DATE
 
 2) 회원테이블에서 마일리지가 2000-4000사이의 회원정보를 조회하시오.
    출력은 회원번호, 회원명, 마일리지
    
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_MILEAGE AS 마일리지
FROM MEMBER
WHERE MEM_MILEAGE BETWEEN '2000' AND '4000'
ORDER BY 3 DESC;
    
 3) 회원테이블에서 나이가 20~29사이의 회원을 조회하시오
    출력은 회원번호, 회원명, 생년월일, 나이
SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_BIR AS 생년월일,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이
       
FROM MEMBER
WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) BETWEEN 20 AND 29
ORDER BY 4 ASC;

-- 2.LIKE 연산자
  - 문자열 패턴비교 연산자
  - 패턴문자열(와일드카드) '%', '_'를 사용
  1) '%'
       '%'가 사용된 이후의 모든 문자열과 대응
    ex)'김%' : 첫 글자가 '김'으로 시작되는 모든 문자열
       '%김' : '김'으로 끝나는 모든 문자열
       '%김%': '김'이 들어가는 모든 문자열
  
  2) '_'
       '_'가 사용된 이후 한 문자와 대응(NULL은 포함되지 않음)
   ex) '김_' : 2글자이며 첫 글자가 '김'으로 시작되는 문자열
       '_김' : 2글자이며 '김'으로 끝나는 문자열
       '_김_': 3글자로 구성되며 '김'이 포함된 문자열
--사용예
 1) 회원테이블에서 대전에 거주하는 회원들을 조회하시오.
    출력은 회원번호,회원명,주소
    
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_ADD1||''||MEM_ADD2 AS 주소
    FROM MEMBER 
    WHERE SUBSTR(MEM_ADD1,1,2)='대전' -- =(MEM_ADD1 LIKE '대전%')
    ORDER BY MEM_ADD1
       
 2) 장바구니테이블에서 2020년 6월 판매정보를 조회하시오.
    출력은 날짜, 상품코드, 수량
    
    SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜,
           PROD_ID AS 상품코드,
           CART_QTY AS 수량
    FROM CART
    WHERE CART_NO LIKE '202006%'
    ORDER BY 1;
    
 3) 매입 테이블에서 2020년 2월 매입정보를 조회하시오
    출력은 날짜, 상품코드, 수량
    
    SELECT BUY_DATE AS 날짜,
            PROD_ID AS 상품코드,
            BUY_QTY AS 수량
    FROM   BUYPROD
    WHERE  BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
    ORDER BY 1;  -- 날짜타입?이 있을땐 between 써야함
-- 3. IN
  - 주어진 복수개의 값 중 어느 하나와 일치하면 참을 반환
  - IN 내부에 '=' 기능이 포함되어 있음
  - 비교 연산자와 논리연산자 OR을 사용하여 복잡하게 쿼리문을 작성하지 않고
    훨씬 간단하게 표현
  - 불연속적이거나 불규칙적인 값을 비교하는 경우 사용
사용형식)
    컬럼 IN(값1,값2...)
    - '컬럼'의 값이 '값1'과 같거나 또는 '값2'와 같으면 참을 반환함
    
--사용예)
 1) 사원테이블에서 30,70,90번 부서에 속한 사원정보를 조회하시오.
    출력은 사원번호, 사원명,부서번호,급여 이다.
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(30,70,90)
    ORDER BY 3;
    
    ALTER TABLE HR.EMPLOYEES MODIFY(EMP_NAME VARCHAR2(45));
    COMMIT;
    UPDATE HR.EMPLOYEES
        SET EMP_NAME=TRIM(EMP_NAME);
  
  2) 사원수가 5명 이상인 부서정보를 조회하시오
     출력은 부서번호, 부서명, 관리사원번호
    SELECT DEPARTMENT_ID AS 부서번호,
           DEPARTMENT_NAME AS 부서명,
           MANAGER_ID AS 관리사원번호
           
    FROM HR.DEPARTMENTS
    WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                      FROM (SELECT DEPARTMENT_ID,
                            COUNT(*)
                            FROM HR.EMPLOYEES
                            GROUP BY DEPARTMENT_ID
                            HAVING COUNT(*)>=5))
    ORDER BY 1;
    
 3) 상품테이블에서 분류코드가 'P202','P401','P102','P403'에 속하는 상품 정보를 조회하시오
    출력은 상품번호, 상품명, 분류코드, 매입가격
    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 상품명,
           LPROD_GU AS 분류코드,
           PROD_COST AS 매입가격
    FROM PROD
    WHERE LPROD_GU IN('P202','P401','P102','P403')
    ORDER BY 3;
    
-- 4. ANY(SOME)
    -주어진 복수개의 값 중 어느 하나와 기술된 관계연산자를 만족하면 참을 반환
    -'=ANY'는 'IN'과 같음
  사용형식)
  컬럼 관계연산자ANY(값,...)
  
  --사용예)
  1) HR계정의 사원테이블에서 급여가 60번 부서의 최소급여보다 많은 사원의 사원번호,사원명,급여를 조회하시오
  
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         SALARY AS 급여
  FROM HR.EMPLOYEES
  WHERE SALARY >ANY(     SELECT (SALARY)
                        FROM HR.EMPLOYEES
                        WHERE DEPARTMENT_ID=60)
    ORDER BY 3;

-- 5.ALL
   -주어진 복수개의 값 모두와 기술된 관계연산자를 만족하면 참을 반환
   -'='은 사용할 수 없다
 사용형식)
    컬럼 ALL(값,...)
    
--사용예)
 1) 주어진 마일리지가 1000,2000,5000 일때 최대값인 5000보다 많은 마일리지를 보유한
    회원의 회원번호,회원명,마일리지를 조회하시오
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE >ALL(1000,2000,5000)
    ORDER BY 3 ASC;
    
 2) 비교를 위해 주어진 급여가 3000, 4500, 5000 일때 최소값인 3000 보다 적은 급여를
    수령하는 사원의(사원번호, 사원명, 급여)를 조회하시오
    
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           SALARY AS 급여
    FROM    HR.EMPLOYEES
    WHERE SALARY >ALL(3000,4500,5000)
    ORDER BY 3;