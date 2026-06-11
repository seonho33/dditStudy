2025-11-25-04)서브쿼리
 - 하나의 SQL문장안에 포함된 SELECT문
 - 서브쿼리는 알려지지않은 값을 조건으로 사용하는 경우 유용하다.
 - 서브쿼리는 '( )' 안에 기술함(단, INSERT 문과 CREATE문에 포함되는 서브쿼리는 '( )'를 사용하지 않음)
 - 기술되는 위치에 따라 일반 서브쿼리(SELECT절), IN-LINE 서브쿼리(FROM절), NESTED 서브쿼리(WHERE 절)
   로 구분
 - 메인쿼리와 JOIN 되면 연관성 서브쿼리 JOIN을 사용하지 않으면 비연관 서브쿼리라 함
 - WHERE절 등에서 조건문에 사용되는 서브쿼리의 결과가 복수개의 행으로 반환되는 경우
   일반 관계연산자를 사용할 수 없다.(다중행 연산자 IN,ANY,SOME,ALL,EXISTS 사용)
   
--사용예)
 1)사원테이블에서 평균급여보다 더 많은 급여를 받는 사원의 사원번호, 사원명, 급여를 조회하시오...

   SELECT   E.EMPLOYEE_ID AS 사원번호,
            E.EMP_NAME AS 사원명,
            E.SALARY AS 급여,
            ROUND(A.AVGS) AS 평균급여
   FROM     HR.EMPLOYEES E,
            (SELECT AVG(A.SALARY) AS AVGS
             FROM   HR.EMPLOYEES A) A
   WHERE    A.AVGS<E.SALARY
   ORDER BY 3;

    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            SALARY AS 급여,
            (SELECT ROUND(AVG(SALARY))
             FROM   HR.EMPLOYEES)
    FROM    HR.EMPLOYEES
    WHERE   SALARY>(SELECT  AVG(SALARY)
                    FROM    HR.EMPLOYEES)



 2)상품테이블에서 상품의 평균 판매가보다 큰 상품정보를 조회하시오...
   Alias는 상품번호, 상품명, 판매가

    SELECT  PROD_ID AS 상품번호,
            PROD_NAME AS 상품명,
            PROD_PRICE AS 판매가
    FROM    PROD
    WHERE   PROD_PRICE>(SELECT  AVG(PROD_PRICE)
                        FROM    PROD)
   
    SELECT  
        PROD_ID AS 상품번호,
        PROD_NAME AS 상품명,
        PROD_PRICE AS 판매가,
        ROUND(A.AVGP) AS "평균 판매가"
    FROM    
        PROD,
        (SELECT AVG(PROD_PRICE) AS AVGP
         FROM    PROD) A
    WHERE
        PROD_PRICE>A.AVGP
    ORDER BY
        1; 
 3) 2020년 거주지가 충남인 회원들의 평균 구매금액보다 더 많은 구매를 한 회원의 구매정보를 조회하시오
    Alias는 회원번호, 회원명, 구매금액
    
(서브쿼리)
    SELECT
        ROUND((SUM(C.CART_QTY*P.PROD_PRICE)/COUNT(DISTINCT(M.MEM_ID)))) AS 평균구매금액 
    FROM
        CART C,
        PROD P,
        MEMBER M
    WHERE
        SUBSTR(C.CART_NO,1,4)='2020'
    AND M.MEM_ADD1 LIKE '충남%'
    AND M.MEM_ID=C.MEM_ID
    AND C.PROD_ID=P.PROD_ID
-------------------------------------
    SELECT  M.MEM_ID AS 회원번호,
            M.MEM_NAME AS 회원명,
            B.BSUM AS 구매금액
    FROM    MEMBER M,
            (SELECT
                C.MEM_ID,
                SUM(C.CART_QTY*P.PROD_PRICE) AS BSUM
             FROM
                CART C,
                PROD P
             GROUP BY C.MEM_ID) B,
            (SELECT
                ROUND((SUM(C.CART_QTY*P.PROD_PRICE)/COUNT(DISTINCT(M.MEM_ID)))) AS AVGC 
             FROM
                CART C,
                PROD P,
                MEMBER M
             WHERE
             SUBSTR(C.CART_NO,1,4)='2020'
             AND M.MEM_ADD1 LIKE '충남%'
             AND M.MEM_ID=C.MEM_ID
             AND C.PROD_ID=P.PROD_ID ) A
    WHERE   B.MEM_ID = M.MEM_ID
    AND     B.BSUM>A.AVGC
    ORDER BY 1;
---------------------------------------------
    SELECT  회원번호, 회원명, 구매금액
    FROM    MEMBER M
    INNER JOIN CART C

-------------------------------------
    SELECT
        SUM(C.CART_QTY*P.PROD_PRICE) AS 구매금액,
        ROUND(SUM(C.CART_QTY*P.PROD_PRICE)/COUNT(M.MEM_ID)) AS 평균가
    FROM
        CART C,
        PROD P,
        MEMBER M
    WHERE
        SUBSTR(C.CART_NO,1,4)='2020'
    AND
        M.MEM_ADD1 LIKE '충남%'
    AND
        M.MEM_ID=C.MEM_ID
    AND
        C.PROD_ID=P.PROD_ID
-------------------------------------
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        (C.CART_QTY*P.PROD_PRICE) AS 구매금액
    FROM
        MEMBER M,
        CART C,
        PROD P
    WHERE  
        SUBSTR(C.CART_NO,1,4)='2020'
    AND
        M.MEM_ADD1 LIKE '충남%'
    AND    
        M.MEM_ID = C.MEM_ID
    AND
        P.PROD_ID = C.PROD_ID
----------------------------------------
    SELECT  C.MEM_ID AS MID,
            M.MEM_NAME AS MNAME,
            SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
    FROM    CART C, PROD P, MEMBER M
    WHERE   C.PROD_ID = P.PROD_ID
    AND     C.MEM_ID = M.MEM_ID
    AND     C.CART_NO LIKE '2020%'
    GROUP BY C.MEM_ID,M.MEM_NAME
-----------------------------------------
    SELECT MID

 4) 2020년 상반기 매입자료 중 매입수량이 가장 많은 상품의 상품번호, 상품명, 매입수량합계를 조회하시오...
    (ROWNUM 을 사용하라)
    SELECT
        B.PROD_ID AS 상품번호,
        P.PROD_NAME AS 상품명,
        SUM(B.BUY_QTY) AS 매입수량합계
    FROM
        BUYPROD B
    INNER JOIN PROD P
            ON(P.PROD_ID = B.PROD_ID)
    WHERE B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
    GROUP BY B.PROD_ID,P.PROD_NAME
    ORDER BY 3 DESC
    FETCH FIRST 1 ROW ONLY
    
 5) 2020년 전체 구매금액이 2000만원 이상인 고객을 비고란에 '우수고객'으로 지정하여 검색하시오...
    Alias는 회원번호, 회원명, 비고
    
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
--        SUM(C.CART_QTY*P.PROD_PRICE) AS 구매금액,
        '우수고객' AS 비고
    FROM
        CART C
    INNER JOIN MEMBER M
            ON (M.MEM_ID = C.MEM_ID AND C.CART_NO LIKE '2020%')
    INNER JOIN PROD P
            ON (P.PROD_ID = C.PROD_ID)
    GROUP BY M.MEM_ID,M.MEM_NAME
    HAVING SUM(C.CART_QTY*P.PROD_PRICE)>=20000000  --HAVING 절은 뒤에 집계함수가 와야함
--------------------------------------------------------------------
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        '우수회원' AS 비고
    FROM MEMBER M,
        (SELECT C.MEM_ID,
                SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
         FROM   CART C, PROD P
         WHERE  C.PROD_ID = P.PROD_ID
         AND    C.CART_NO LIKE '2020%'
         GROUP BY C.MEM_ID) A
    WHERE   M.MEM_ID = A.MEM_ID
    AND     A.ASUM>=20000000
--------------------------------------------------------------------
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        '우수고객' AS 비고
    FROM
        MEMBER M
    INNER JOIN (SELECT 
                    C.MEM_ID,
                    SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
                FROM
                    CART C,
                    PROD P
                WHERE
                    C.PROD_ID = P.PROD_ID
                AND    C.CART_NO LIKE '2020%'
                GROUP BY C.MEM_ID) A
            ON (A.MEM_ID = M.MEM_ID)
    WHERE A.ASUM>20000000
    ORDER BY 1;
--------------------------------------------------------------------
(EXISTS 연산자 사용)
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        '우수회원' AS 비고
    FROM
        MEMBER M
    WHERE EXISTS(SELECT 1
                 FROM
                    CART C
                 INNER JOIN PROD P
                         ON(C.PROD_ID = P.PROD_ID)
                 WHERE 
                        C.CART_NO LIKE '2020%'
                 AND    M.MEM_ID=C.MEM_ID
                 HAVING SUM(C.CART_QTY*P.PROD_PRICE)>=20000000)
                 
 6) 장바구니 테이블에서 4월과 6월에 모두 판매된 상품의 상품번호, 상품명을 출력하시오...
    (메인쿼리 : 4월에 판매된 상품의 ... 서브쿼리 : 6월에 판매된 상품 ...)
    SELECT 
        C.PROD_ID AS 상품번호,
        P.PROD_NAME AS 상품명
    FROM    CART C
    INNER JOIN PROD P
            ON(P.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202004%')
            
    SELECT DISTINCT
        C.PROD_ID   AS 상품번호,
        A.ANAME     AS 상품명
    FROM    CART C
    INNER JOIN (
    SELECT 
        C.PROD_ID AS AID,
        P.PROD_NAME AS ANAME
    FROM    CART C
    INNER JOIN PROD P
            ON(P.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202004%')
    ) A
            ON (A.AID = C.PROD_ID AND C.CART_NO LIKE '202006%')
    ORDER BY 1;
    
------------------------------------------------------------------------
EXISTS 사용
    SELECT  DISTINCT
            C.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명
    FROM    CART C
    INNER JOIN PROD P
            ON (P.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202004%')
    WHERE EXISTS(SELECT 1
                 FROM   CART B
                 WHERE  C.PROD_ID=B.PROD_ID
                 AND    B.CART_NO LIKE '202006%')
    ORDER BY 1; -----------------DISTINCT 쓰기전에 위의 식과 숫자가 달랐음...
    
 7) 사원테이블에서 부서별 평균급여를 구하고 본인이 속한 부서의 평균급여보다 더 많은 급여를 받는
    사원의 사원번호, 사원명, 부서명, 급여, 부서평균급여를 출력하시오...

(서브쿼리:부서별 평균 급여...)    
    SELECT
        D.DEPARTMENT_ID,
        D.DEPARTMENT_NAME AS NAME,
        ROUND(AVG(E.SALARY)) AS AVG
    FROM
        HR.EMPLOYEES E
    INNER JOIN HR.DEPARTMENTS D
            ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    GROUP BY D.DEPARTMENT_NAME
    
(ANSI 메인쿼리)
    SELECT
        E.EMPLOYEE_ID            AS 사원번호,
        E.EMP_NAME               AS 사원명,
        AVG_D.DEPARTMENT_ID      AS 부서코드,
        AVG_D.DEPARTMENT_NAME    AS 부서명,
        E.SALARY                 AS 급여,
        ROUND(AVG_D.AVGS)        AS 부서평균급여
    FROM     HR.EMPLOYEES E
    INNER JOIN (
    SELECT
        D.DEPARTMENT_ID,
        D.DEPARTMENT_NAME,
        AVG(E.SALARY) AS AVGS
    FROM     HR.EMPLOYEES E
    INNER JOIN HR.DEPARTMENTS D
            ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME
    ) AVG_D
            ON (AVG_D.DEPARTMENT_ID = E.DEPARTMENT_ID AND E.SALARY>AVG_D.AVGS)
    ORDER BY 3,5;

(일반조인)
    SELECT 
        E.EMPLOYEE_ID      AS 사원번호,
        E.EMP_NAME          AS 사원명,
        E.DEPARTMENT_ID     AS 부서번호,
        D.DEPARTMENT_NAME   AS 부서명,
        E.SALARY            AS 급여,
        ROUND(AVG_D.AVGD)   AS 부서평균급여
    FROM HR.EMPLOYEES E, HR.DEPARTMENTS D,
         (SELECT
            DEPARTMENT_ID,
            AVG(SALARY) AS AVGD
          FROM
            HR.EMPLOYEES
          GROUP BY DEPARTMENT_ID) AVG_D
    WHERE   AVG_D.DEPARTMENT_ID = E.DEPARTMENT_ID
    AND     E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND     E.SALARY>AVG_D.AVGD

9)  장바구니 테이블에서 2020년 5월 회원별 구매금액합계를 구하고 가장 많은 
    구매를 한 회원의 회원번호, 회원명, 직업, 구매금액 합계를 조회하시오...
(서브쿼리...회원별 구매금액합계)

    SELECT
        M.MEM_ID,
        M.MEM_NAME,
        M.MEM_JOB,
        SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
    FROM    CART C
    INNER JOIN MEMBER M
            ON(C.MEM_ID = M.MEM_ID AND C.CART_NO LIKE '202005%')
    INNER JOIN PROD P
            ON(P.PROD_ID = C.PROD_ID)
    GROUP BY M.MEM_ID,M.MEM_NAME,M.MEM_JOB
    ORDER BY 4 DESC
    FETCH FIRST 1 ROW ONLY
--- ROWNUM 쓸경우 서브쿼리 써야함...
(서브쿼리:5월 회원별 구매금액 합계...)
    SELECT
        C.MEM_ID,
        SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
    FROM    
        CART C,
        PROD P
    WHERE
        C.PROD_ID = P.PROD_ID
    AND C.CART_NO LIKE '202005%'
    GROUP BY C.MEM_ID
    ORDER BY 2 DESC
(메인쿼리)
    SELECT 
        A.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        M.MEM_JOB AS 직업,
        A.ASUM AS 구매금액
    FROM
        MEMBER M,
(   SELECT
        C.MEM_ID,
        SUM(C.CART_QTY*P.PROD_PRICE) AS ASUM
    FROM    
        CART C,
        PROD P
    WHERE
        C.PROD_ID = P.PROD_ID
    AND C.CART_NO LIKE '202005%'
    GROUP BY C.MEM_ID
    ORDER BY 2 DESC
    ) A
    WHERE
        A.MEM_ID = M.MEM_ID
    AND ROWNUM=1
        
    
10) 충남에 거주하는 회원이 주문한 모든 주문사항을 조회하시오.
    Alias는 회원번호, 회원명, 주문일자, 상품번호, 상품명, 주문수량
(서브쿼리 충남에 거주하는 회원...)

(서브쿼리)
    SELECT  
        MEM_ID,
        MEM_NAME
    FROM    MEMBER
    WHERE   MEM_ADD1 LIKE '충남%'
    
(메인쿼리)
    SELECT
        A.MEM_ID AS 회원번호,
        A.MEM_NAME AS 회원명,
        TO_DATE(SUBSTR(C.CART_NO,1,8),'YYYYMMDD') AS 주문일자,
        C.PROD_ID AS 상품번호,
        P.PROD_NAME AS 상품명,
        C.CART_QTY AS 주문수량
    FROM CART C,PROD P,
(   SELECT  
        MEM_ID,
        MEM_NAME
    FROM    MEMBER
    WHERE   MEM_ADD1 LIKE '충남%') A
    WHERE   A.MEM_ID = C.MEM_ID
    AND     C.PROD_ID = P.PROD_ID
    ORDER BY 1,2;
    
(메인쿼리 ANSI)
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        TO_DATE(SUBSTR(C.CART_NO,1,8),'YYYYMMDD') AS 주문일자,
        C.PROD_ID AS 상품번호,
        P.PROD_NAME AS 상품명,
        C.CART_QTY AS 주문수량
    FROM    CART C
    INNER JOIN PROD P
            ON(C.PROD_ID = P.PROD_ID)
    INNER JOIN MEMBER M
            ON(M.MEM_ID = C.MEM_ID AND M.MEM_ADD1 LIKE '충남%')
    ORDER BY 1,2
 
11) 평균 마일리지보다 많은 마일리지를 보유한 모든 회원들의 2020년 7월 구매현황을 조회하시오...
    Alias는 회원번호, 회원명, 구매액
    (메인쿼리:조건을 만족하는 2020년 7월 회원별 구매현황)
    (서브쿼리:평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호)
(서브쿼리)
    SELECT  MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            AVG(MEM_MILEAGE) AS 평균마일리지
    FROM    MEMBER,
            (SELECT AVG(MEM_MILEAGE) AS AVGA
             FROM MEMBER) A
    WHERE   MEM_MILEAGE>A.AVGA
    GROUP BY MEM_ID,MEM_NAME
(서브쿼리)
    SELECT  MEM_ID,
            MEM_NAME
    FROM    MEMBER,
            (SELECT AVG(MEM_MILEAGE) AS AVGA
             FROM MEMBER) A
    WHERE   MEM_MILEAGE>A.AVGA
    
(메인쿼리)
    SELECT  
        A.MEM_ID AS 회원번호,
        A.MEM_NAME AS 회원명,
        TO_CHAR(SUM(C.CART_QTY*P.PROD_PRICE),'999,999,999') AS 구매금액
    FROM    CART C, PROD P,
            (SELECT  MEM_ID,
                     MEM_NAME
            FROM    MEMBER,(SELECT AVG(MEM_MILEAGE) AS AVGA
                            FROM MEMBER) A
            WHERE   MEM_MILEAGE>A.AVGA
            )A
    WHERE   C.PROD_ID = P.PROD_ID
    AND     C.MEM_ID = A.MEM_ID
    AND     C.CART_NO LIKE '202007%' -- == SUBSTR(C.CART_NO,1,6)='202007'
    GROUP BY A.MEM_ID,A.MEM_NAME
    ORDER BY 1;
    
    

    SELECT  
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        TO_CHAR(SUM(C.CART_QTY*P.PROD_PRICE),'999,999,999') AS 구매금액
    FROM    CART C, PROD P, MEMBER M
    WHERE   C.PROD_ID = P.PROD_ID
    AND     C.MEM_ID = M.MEM_ID
    AND     C.CART_NO LIKE '202007%' -- == SUBSTR(C.CART_NO,1,6)='202007'
    AND     M.MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                           FROM MEMBER)
    GROUP BY M.MEM_ID,M.MEM_NAME
    ORDER BY 1;
    ----------------------------------------------------
(메인쿼리 ANSI)
    SELECT
        M.MEM_ID AS 회원번호,
        M.MEM_NAME AS 회원명,
        TO_CHAR(SUM(C.CART_QTY*P.PROD_PRICE),'999,999,999') AS 구매금액
    FROM    CART C, (SELECT AVG(MEM_MILEAGE) AS AVGA
                     FROM   MEMBER) A
    INNER JOIN PROD P
            ON (P.PROD_ID = C.PROD_ID AND C.CART_NO LIKE '202007%')
    INNER JOIN MEMBER M
            ON (M.MEM_ID = C.MEM_ID AND M.MEM_MILEAGE>A.AVGA)
    GROUP BY M.MEM_ID,M.MEM_NAME
    ORDER BY 1;

12)사원테이블에서 2020년 이전에 입사한 사원 중 급여가 많은 10명을 퇴직처리 하십시오...
