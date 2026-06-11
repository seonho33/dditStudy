과제02 집계 함수 활용

 3) 상품테이블에서 상품의 수, 최대 판매가, 최소판매가를 구하시오
 SELECT COUNT(PROD_ID) AS "상품의 수",
        MAX(PROD_PRICE) AS "최대 판매가",
        MIN(PROD_PRICE) AS "최소 판매가"
 FROM PROD
 
 
 4) 2020년 4월 판매수량 합계를 구하시오.

 SELECT SUM(CART_QTY)AS"판매수량 합계"
 FROM CART
-- WHERE SUBSTR(CART_NO,1,6)=202004 (SUBSTR을 이용하는 방법)
 WHERE CART_NO LIKE '202004%'


 6)상품테이블에서 분류별 상품의 수, 평균 판매가를 조회하시오.
 
 SELECT LPROD_GU AS 분류,
        COUNT(*) AS"상품의 수",
        ROUND(AVG(PROD_PRICE)) AS"평균 판매가"
 FROM PROD
 GROUP BY LPROD_GU
 
  10)사원테이블에서 부서별,연도별,입사한 사원수를 조회하시오
 
 SELECT DEPARTMENT_ID AS 부서,
        HIRE_DATE 연도,
        COUNT(EMPLOYEE_ID)입사한사원수
 FROM HR.EMPLOYEES
 GROUP BY DEPARTMENT_ID,HIRE_DATE
 ORDER BY 1,2;


 16)회원테이블에서 거주지별 평균마일리지와 회원수를 조회하시오.

 SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지,
        ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
 FROM MEMBER
 GROUP BY SUBSTR(MEM_ADD1,1,2)
 ORDER BY 2 DESC;