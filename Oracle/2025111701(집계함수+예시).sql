2025-11-17-01)
-- 집계함수
 -SUM, AVG, COUNT, MAX,MIN
 사용예)
 1)회원 테이블에서 모든 회원들의 마일리지 합계와, 평균 마일리지, 인원수, 최대 마일리지, 최소마일리지를 구하시오.
 
 SELECT SUM(MEM_MILEAGE) AS "마일리지 합계",
        ROUND(AVG(MEM_MILEAGE)) AS "평균 마일리지",
        COUNT(*) 인원수,
        MAX(MEM_MILEAGE) AS 최대마일리지,
        MIN(MEM_MILEAGE) AS 최소마일리지
 FROM MEMBER;

 2) HR 계정에서 입사년도가 2020년인 사원들의 평균급여와 인원수,최대급여,최소급여를 출력하시오.
 
 SELECT ROUND(AVG(SALARY)) AS 평균급여,
        COUNT(*) AS 인원수,
        MAX(SALARY) AS 최대급여,
        MIN(SALARY) AS 최소급여
 FROM HR.EMPLOYEES
 WHERE EXTRACT(YEAR FROM HIRE_DATE)=2020;
 
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
 
 5)사원테이블에서 부서별 평균 급여와 인원수를 조회하시오
 SELECT DEPARTMENT_ID AS 부서코드,
        ROUND(AVG(SALARY)) AS 평균급여,
        COUNT(*) AS 인원수
 FROM HR.EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY 1 ASC
 
 6)상품테이블에서 분류별 상품의 수, 평균 판매가를 조회하시오.
 
 SELECT LPROD_GU AS 분류,
        COUNT(*) AS"상품의 수",
        ROUND(AVG(PROD_PRICE)) AS"평균 판매가"
 FROM PROD
 GROUP BY LPROD_GU

 7)매입테이블에서 2020년 월별 매입수량 합계를 조회하시오
 
 SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월,
        SUM(BUY_QTY) "매입수량 합계"
 FROM BUYPROD
 WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
 GROUP BY EXTRACT(MONTH FROM BUY_DATE)
 ORDER BY 1;
 
 8)매입테이블에서 2020년 상품별 매입수량합계를 조회하시오
 
 SELECT PROD_ID AS 상품,
        SUM(BUY_QTY) AS 매입수량합계
 FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
 GROUP BY PROD_ID
 ORDER BY 1;
 
 9)매출테이블에서 2020년 월별, 상품별 판매수량합계를 조회하시오
 
 SELECT SUBSTR(CART_NO,5,2) AS 월,
        PROD_ID AS 상품,
        SUM(CART_QTY) AS 판매수량합계
 FROM CART
 WHERE CART_NO LIKE '2020%'
 GROUP BY SUBSTR(CART_NO,5,2),PROD_ID
 ORDER BY 1,2;
 
 10)사원테이블에서 부서별,연도별,입사한 사원수를 조회하시오
 
 SELECT DEPARTMENT_ID AS 부서,
        HIRE_DATE 연도,
        COUNT(EMPLOYEE_ID)입사한사원수
 FROM HR.EMPLOYEES
 GROUP BY DEPARTMENT_ID,HIRE_DATE
 ORDER BY 1,2;
 
 11)2020년 5월 상품별 판매량을 조회하고 가장 많이 판매된 상품을 조회하시오

SELECT PROD_ID AS 상품코드,
        CSUM AS 판매수량
FROM(SELECT ROWNUM AS RN,CSUM,PROD_ID   
   FROM(SELECT PROD_ID,
        SUM(CART_QTY) AS CSUM
        FROM   CART
        WHERE  CART_NO LIKE '202005%'
        GROUP BY PROD_ID
        ORDER BY 2 DESC))
 WHERE RN BETWEEN 10 AND 14 ;
 
 
 --OFFSET 0~ ROWS
 --FETCH FIRST ~1 ROW ONLY == ROWNUM 1과 같다 (위의 방식과 같다)
 
 SELECT PROD_ID AS 상품코드,
        SUM(CART_QTY) AS 판매수량
        FROM CART
        WHERE CART_NO LIKE '202005%'
        GROUP BY PROD_ID
        ORDER BY 2 DESC
        OFFSET 0 ROWS --내가 시작하고싶은 위치 -1을 넣고 시작...
        FETCH FIRST 1 ROW ONLY
    
  12)2020년 5월 상품별 판매량을 조회하고 판매량이 많은 1-5위 상품을 조회하시오
  
  SELECT    PROD_ID AS 상품,
            SUM(CART_QTY) AS 판매량
  FROM      CART  
  WHERE     SUBSTR(CART_NO,5,2)=05
  GROUP BY  PROD_ID
  ORDER BY  2 DESC
  FETCH FIRST 5 ROWS ONLY
  
  13)2020년 5월 상품별 판매량을 조회하고 판매량이 많은 10-15위 상품을 조회하시오
  
    SELECT  PROD_ID AS 상품,
            SUM(CART_QTY) AS 판매량
    FROM    CART
    WHERE   CART_NO LIKE '202005%'
    GROUP BY PROD_ID
    ORDER BY 2 DESC
    OFFSET 9 ROWS
    FETCH FIRST 6 ROWS ONLY
    
 14)회원테이블에서 성별 평균 마일리지를 조회하시오.
 SELECT     CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN(1,3) THEN '남성'
                 ELSE '여성' END AS 구분,
            ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
 FROM       MEMBER
 GROUP BY   CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN(1,3) THEN '남성'
                 ELSE '여성' END
 
 15)회원테이블에서 연령대별 회원수와 평균마일리지를 조회하시오.
 SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10 AS 연령대,
        COUNT(*) AS 회원수,
        ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
 FROM       MEMBER
 GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10
 ORDER BY 1;
 
 16)회원테이블에서 거주지별 평균마일리지와 회원수를 조회하시오.
 SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지,
        ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
 FROM MEMBER
 GROUP BY SUBSTR(MEM_ADD1,1,2)
 ORDER BY 2 DESC;
 
 17)사원테이블에서 년도별 입사인원과 평균급여를 조회하되 인원수가 20명 이상인 자료만 출력하시오.
 SELECT EXTRACT(YEAR FROM HIRE_DATE) AS 연도,
        COUNT(EMPLOYEE_ID) AS 입사인원,
        ROUND(AVG(SALARY)) AS 평균급여
 FROM HR.EMPLOYEES
 GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
 HAVING COUNT(EMPLOYEE_ID)>=20
 ORDER BY 2 DESC;
 
 *** 상품테이블에서 분류코드 'P301'에 속한 상품들의 판매가를 매입가와 동일하게 변경하시오
     UPDATE PROD
        SET PROD_PRICE=PROD_COST
      WHERE LPROD_GU='P301';
      
      COMMIT;
 SELECT PROD_PRICE AS 판매가 FROM PROD
 
 
 **재고수불 테이블을 다음 조건으로 생성하시오
 1)테이블명 : REMAIN
 ------------------------------------------------------------------------------
  컬럼명          데이터타입         NULLABLE          DEFAULT        PK/FK
 ------------------------------------------------------------------------------
 REMAIN_YEAR     CHAR(4)                                            PK
 PROD_ID         VARCHAR2(10)                                       PK & FK
 REMAIN_J_00     NUMBER(5)          N                   
 (기초재고)
 REMAIN_I        NUMBER(5)                             0            
 (매입수량)
 REMAIN_O        NUMBER(5)                             0 
 (매출수량집계)
 REMAIN_J_99     NUMBER(5)                             0
 (현 재고량=기초재고+매입수량-매출수량)
 REMAIN_DATE     DATE                               SYSDATE
 (업데이트 된 날짜)
 ------------------------------------------------------------------------------
 
 **위의 REMAIN 테이블에 상품테이블의 모든 행을 입력시키되
   PROD_PROPERSTOCK의 값을 기초재고와 현 재고 값으로,
   갱신일자를 2019년 12월 31일로 입력하시오.
 --SELECT 절 그대로 INSERT INTO 하기
INSERT  INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE) 
        SELECT '2019',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20191231')
        FROM PROD;
        
        SELECT * FROM REMAIN