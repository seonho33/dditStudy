2025-11-25-02) 외부조인 사용예
 1) 2020년 모든 상품별 매입집계를 조회하시오..
    Alias는 상품번호,상품명,매입수량
(편법)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            SUM(B.BUY_QTY) AS 매입수량
      FROM  BUYPROD B, PROD P
     WHERE  BUY_DATE(+) BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')    -- BUY_DATE(+) LIKE '2020%'
       AND  B.PROD_ID(+) = P.PROD_ID
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 1;
    
(서브쿼리)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            NVL(C.CUSM,0) AS 매입수량
      FROM  PROD P,
            (SELECT  B.PROD_ID AS BUY_PROD_ID,
                SUM (B.BUY_QTY) AS CUSM
               FROM BUYPROD B
              WHERE B.BUY_DATE LIKE '2020%'
             GROUP BY B.PROD_ID ) C
     WHERE  P.PROD_ID = C.BUY_PROD_ID(+)
     ORDER BY 1;
     
    
(ANSI OUTER JOIN)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            SUM(B.BUY_QTY) AS 매입수량
      FROM  PROD P
    LEFT OUTER JOIN BUYPROD B 
                 ON(P.PROD_ID = B.PROD_ID AND TO_CHAR(B.BUY_DATE) LIKE '2020%')
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 1;
    
    
 2) 2020년 모든 상품별 매출집계를 조회하시오...
    Alias는 상품번호, 상품명, 매출수량
(일반+편법)
    SELECT P.PROD_ID AS 상품번호,
           P.PROD_NAME AS 상품명,
           NVL(SUM(C.CART_QTY),0) AS 매출수량
      FROM CART C,PROD P
     WHERE P.PROD_ID = C.PROD_ID(+)
       AND C.CART_NO(+) LIKE '2020%'
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 3 ASC;
    
(서브쿼리)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            NVL(C.CUSM,0) AS 매출수량
    FROM    PROD P ,
            (SELECT C.PROD_ID AS CART_PROD_ID,
                    SUM(C.CART_QTY) AS CUSM
             FROM   CART C
             WHERE  C.CART_NO LIKE '2020%'
             GROUP BY C.PROD_ID) C
    WHERE C.CART_PROD_ID(+)=P.PROD_ID
    ORDER BY 3 ASC;

(ANSI OUTER JOIN)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            NVL(SUM(C.CART_QTY),0) AS 매출수량
      FROM CART C
    RIGHT OUTER JOIN PROD P
                  ON (P.PROD_ID=C.PROD_ID AND C.CART_NO LIKE '2020%')
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 1;

 3) 2020년 모든 상품별 매입/매출집계를 조회하시오...
    Alias는 상품번호, 상품명, 매입수량, 매출수량
(일반+편법)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            SUM(B.BUY_QTY) AS 매입수량,
            SUM(C.CART_QTY) AS 매출수량
    FROM    BUYPROD B,PROD P,CART C
    WHERE   P.PROD_ID = B.PROD_ID(+)
    AND     P.PROD_ID = C.PROD_ID(+)
    AND     C.CART_NO(+) LIKE '2020%'
    AND     B.BUY_DATE(+) BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 1;
(서브쿼리)
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            NVL(B.BSUM,0) AS 매입수량,
            NVL(C.CSUM,0) AS 매출수량
    FROM    PROD P,
            (SELECT PROD_ID,
                    SUM(C.CART_QTY) AS CSUM
             FROM   CART C
             WHERE  CART_NO LIKE '2020%'
             GROUP BY C.PROD_ID) C,
            (SELECT PROD_ID,
                    SUM(B.BUY_QTY) AS BSUM
             FROM   BUYPROD B
             WHERE  EXTRACT(YEAR FROM B.BUY_DATE)=2020
             GROUP BY B.PROD_ID) B
    WHERE   P.PROD_ID = B.PROD_ID(+)
    AND     P.PROD_ID = C.PROD_ID(+)
    ORDER BY 1;

(ANSI OUTER JOIN)]
    SELECT  P.PROD_ID AS 상품번호,
            P.PROD_NAME AS 상품명,
            SUM(B.BUY_QTY) AS 매입수량,
            SUM(C.CART_QTY) AS 매출수량
    FROM    PROD P
    LEFT OUTER JOIN BUYPROD B
                 ON (B.PROD_ID = P.PROD_ID AND TO_CHAR(B.BUY_DATE) LIKE '2020%')
    LEFT OUTER JOIN CART C
                 ON (C.PROD_ID = P.PROD_ID AND C.CART_NO LIKE '2020%')
    GROUP BY P.PROD_ID,P.PROD_NAME
    ORDER BY 1;
    
 4) HR계정에서 모든 부서별 인원수와 평균 급여를 조회하시오...
    Alias는 부서번호, 부서명, 사원수, 평균급여
(서브쿼리)
    SELECT  CASE WHEN D.DEPARTMENT_ID =NULL
                 THEN '프리랜서'
                 ELSE D.DEPARTMENT_ID
                 END AS 부서번호,
            D.DEPARTMENT_NAME AS 부서명,
            NVL(E.ECNT,0) AS 사원수,
            NVL(E.EAVG,0) AS 평균급여
    FROM    HR.DEPARTMENTS D
    FULL OUTER JOIN (SELECT E.DEPARTMENT_ID AS DEPARTMENT_ID,
                     TRUNC(AVG(E.SALARY)) AS EAVG,
                     COUNT(EMPLOYEE_ID) AS ECNT
                     FROM   HR.EMPLOYEES E
                     GROUP BY E.DEPARTMENT_ID) E
                 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    ORDER BY 1;
             
    
(ANSI OUTER JOIN)
    SELECT  D.DEPARTMENT_ID AS 부서번호,
            D.DEPARTMENT_NAME AS 부서명,
            COUNT(E.EMPLOYEE_ID) AS 사원수,
            NVL(ROUND(AVG(E.SALARY)),0) AS 평균급여
    FROM    HR.DEPARTMENTS D
    FULL OUTER JOIN HR.EMPLOYEES E
                 ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
    GROUP BY    D.DEPARTMENT_ID,
                D.DEPARTMENT_NAME
    ORDER BY 1;
    