2025-11-11-01) 연산자
-- 산술연산자(+,-,/,*), 관계연산자(>,<,>=,<=,!=,!<,!>) 
사용예)
1) HR 계정의 EMPLOYEES 테이블에서 이번달에 지급할 급여를 다음 조건에 맞추어 계산하고
   출력하시오. 출력은 사원번호, 사원명, 기본급, 보너스, 세금, 지급액
   보너스 = 기본급(SALARY)*영업실적코드(COMMISSION_PCT)*0.5
   세금 = 기본급 + 보너스의 15%
   지급액 = 기본급 + 보너스 - 세금
   **모든 자료는 정수만 출력.
   
    SELECT EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명 ,
            SALARY AS 기본급,
            NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0) AS 보너스,
            TRUNC((SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0))*0.15) AS 세금,
            SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0)-TRUNC((SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0))*0.15) AS 지급액
            FROM HR.EMPLOYEES
            ORDER BY 지급액 DESC;
    
    SELECT EMPLOYEE_ID AS 사원번호,
          EMP_NAME AS 사원명,
          SALARY AS 기본급,
          NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0) AS 보너스,
          TRUNC((SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0))*0.15)  AS 세금,
          SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0)-
          TRUNC((SALARY+NVL(ROUND(SALARY*COMMISSION_PCT*0.5),0))*0.15) AS 지급액 
     FROM HR.EMPLOYEES
    ORDER BY 지급액 DESC; 
    
--    2. 관계연산자
     - 결과가 참과 거짓으로 반환
     - 조건식으로 사용되어 WHERE절, HAVING절, 표현식(CASE ~ WHEN THEN, DECODE)에 사용됨
     - >,<,=,>=,<=,!=(<>)
사용예)
1) 상품 테이블에서 판매가격이 100만원 이상인 상품을 조회하시오
    ALIAS는 상품번호, 상품명, 판매가격
    
    SELECT PROD_ID AS 상품번호, PROD_NAME AS 상품명, PROD_PRICE AS 판매가격 
    FROM PROD 
    WHERE PROD_PRICE>=1000000 
    ORDER BY 3 DESC;


2) 회원 테이블에서 마일리지가 2000 미만인 회원정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 직업, 마일리지
    
    SELECT  MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명, 
            MEM_JOB AS 직업, 
            MEM_MILEAGE 마일리지 
    FROM   MEMBER
    WHERE  MEM_MILEAGE<2000
    ORDER BY 4;

3) 서울에 거주하는 회원정보를 조회하시오
    ALIAS는 회원번호, 회원명, 주소

    SELECT  MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_ADD1||' '||MEM_ADD2 AS 주소
    FROM MEMBER
   -- WHERE SUBSTR(MEM_ADD1,1,2)='서울'
    WHERE MEM_ADD1 LIKE '서울%';


4) 2020년 6월에 구매하지 않은 회원들을 조회하시오
    ALIAS는 회원번호, 회원명, 성별, 마일리지
 --서브쿼리:2020년 6월 구매회원의 회원번호를 중복없이 조회
  SELECT DISTINCT MEM_ID
  FROM CART
  WHERE SUBSTR(CART_NO,1,6)='202006'

 --메인쿼리:회원번호, 회원명, 성별, 마일리지 2020년 6월 구매회원이 아닌 회원
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명, 
         CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남성회원'
              ELSE '여성회원' END AS 성별,
         MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_ID NOT IN (SELECT DISTINCT MEM_ID
                         FROM CART
                         WHERE SUBSTR(CART_NO,1,6)='202006')
    ORDER BY 1;