2025-11-24-02)JOIN

--1. Cartesian Product(CROSS JOIN)
  - 조인조건이 없거나 잘못 기술된 경우
  - 결과는 조인에 참여한 모든 행은 곱한 행의 값을, 열은 더한 열의 값을 반환
  - 결과를 위해 반드시 필요한 경우에 한하여 사용해야함

--사용형식 - 일반조인)
    SELECT 컬럼LIST
    FROM 테이블1 [별칭1][,테이블2 [별칭2],...]
    [WHERE 조인조건
       AND 일반조건] 
    - '테이블1 [별칭1]' : 해당 테이블에 부여된 또 다른 이름(별칭)
    - 조인조건과 일반조건은 'AND'로 연결해야 하며, 기술 순서는 결과와 상관없음
    
--사용형식 - ANSI)
    SELECT 컬럼LIST
    FROM 테이블1 [별칭1]
    CROSS JOIN 테이블2 [별칭2] [ON 조인조건 [AND 일반조건]]
   [CROSS JOIN 테이블3 [별칭3] [ON 조인조건 [AND 일반조건]]]
                        :
   [WHERE 일반조건]
   -테이블1 과 테이블2가 조인되고, 그 결과와 테이블3이 조인됨
   -일반조건은 ON절과 WHERE 절에서 기술될 수 있음
   
 -- 사용예)
    SELECT 'CART' AS 테이블명, COUNT(*) AS "행의 수"
      FROM CART
    UNION ALL
    SELECT 'BUYPROD', COUNT(*) 
      FROM BUYPROD
    UNION ALL
    SELECT 'PROD', COUNT(*)
      FROM PROD;
      
  (Cartesian Product)
    SELECT COUNT(*)
    FROM CART A, BUYPROD B, PROD C;

  (Cross Join)
    SELECT COUNT(*)
      FROM CART A
     CROSS JOIN BUYPROD B
     CROSS JOIN PROD C;
     
--2. 내부조인
    -조인조건을 만족하는 자료만 출력(조인조건을 만족하지 않는 자료는 무시함)
    -조인조건에 사용하는 연산자에 따라 동등조인( '=' 연산자 사용),
     비동등조인('>,<,>=,<=,!=' 사용) 으로 구분함.
    -ANSI JOIN 은 INNER JOIN절로 구성
    -사용된 테이블이 N개 일때 조인조건은 반드시 N-1개 이상 이어야함
    -대부분의 조인문이 내부조인임
    
--사용형식
 SELECT 컬럼LIST
 FROM   테이블1 [별칭1][,테이블2 [별칭2],...]
 WHERE  조인조건
 [AND   조인조건, ...]
 [AND   일반조건]
 
 --사용형식(ANSI조인)
 SELECT 컬럼LIST
 FROM   테이블1 [별칭1]
 INNER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
[INNER JOIN 테이블명3 [별칭2] ON(조인조건2 [AND 일반조건2])
                        :
[WHERE 일반조건]
 -테이블1과 테이블2는 반드시 직접조인 되어야 함
 -테이블명3은 테이블1과 테이블2의 조인 결과와 조인
 -WHERE 일반조건은 모든 조인이 수행된 후 수행
 
--사용예)
 1)장바구니 테이블에서 2020년 7월 회원별 구매현황을 조회하시오..
   Alias는 회원번호, 회원명, 구매금액합계

 일반조인)
 SELECT A.MEM_ID AS 회원번호,
        B.MEM_NAME AS 회원명,
        SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계
 FROM  CART A, MEMBER B,PROD C
 WHERE A.MEM_ID=B.MEM_ID 
   AND A.PROD_ID=C.PROD_ID
   AND A.CART_NO LIKE '202007%'
 GROUP BY A.MEM_ID,B.MEM_NAME

 ANSI JOIN)
 SELECT A.MEM_ID AS 회원번호,
        B.MEM_NAME AS 회원명,
        TO_CHAR(SUM(A.CART_QTY*C.PROD_PRICE),'999,999,999') AS 구매금액합계
 FROM   MEMBER B
 INNER JOIN CART A ON(B.MEM_ID=A.MEM_ID AND A.CART_NO LIKE '202007%') --조인조건+일반조건한것
 INNER JOIN PROD C ON(A.PROD_ID=C.PROD_ID) --판매단가 추출...일반조인은 왜배우는거지?
 GROUP BY A.MEM_ID,B.MEM_NAME
        
 2)사원테이블에서 부서별 인원수를 조회하시오.
   Alias는 부서번호, 부서명, 인원수
일반조인)
    SELECT A.DEPARTMENT_ID AS 부서번호,
           B.DEPARTMENT_NAME AS 부서명,
           COUNT(A.EMPLOYEE_ID) AS 인원수
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
    GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;

 ANSI JOIN)
    SELECT A.DEPARTMENT_ID AS 부서번호,
           B.DEPARTMENT_NAME AS 부서명,
           COUNT(A.EMPLOYEE_ID) AS 인원수
           FROM HR.EMPLOYEES A
           INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
           GROUP BY A. DEPARTMENT_ID,B.DEPARTMENT_NAME
           ORDER BY 1;
   
 3)상품테이블에서 분류별 상품의 수를 조회하시오.
   Alias는 분류코드, 분류명, 상품의 수
   
   일반조인)
   SELECT  COALESCE(A.LPROD_GU,'전체') AS 분류코드,
           COALESCE(B.LPROD_NAME,'전체') AS 분류명,
           COUNT(*) AS 상품의수
   FROM     PROD A,LPROD B
   WHERE    A.LPROD_GU=B.LPROD_GU
   GROUP BY ROLLUP (A.LPROD_GU, B.LPROD_NAME)
   ORDER BY 1;
   
   ANSI JOIN)
   SELECT A.LPROD_GU AS 분류코드,
          B.LPROD_NAME AS 분류명,
          COUNT(*) AS "상품의 수"
   FROM   PROD A
   INNER JOIN LPROD B ON(A.LPROD_GU=B.LPROD_GU)
   GROUP BY A.LPROD_GU, B.LPROD_NAME
   ORDER BY 1;
   
 4)2020년 4월 거래처별 매입액을 조회하시오
   Alias는 거래처코드, 거래처명, 매입금액합계
   
   일반조인)
   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(C.BUY_QTY*B.PROD_COST) AS 매입금액합계
   FROM   BUYER A , PROD B , BUYPROD C
   WHERE  A.BUYER_ID = B.BUYER_ID
     AND  B.PROD_ID = C.PROD_ID 
     AND  TO_CHAR(C.BUY_DATE,'YYYYMM') LIKE '202004%'
GROUP BY  A.BUYER_ID, A.BUYER_NAME
   
   SELECT C.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(B.BUY_QTY*C.PROD_COST) AS "매입금액 합계"
    FROM  BUYER A, BUYPROD B, PROD C
    WHERE A.BUYER_ID=C.BUYER_ID -- 조인조건(거래처명 추출)
    AND   B.PROD_ID =C.PROD_ID -- 조인조건(매입단가, 거래처코드 추출)
    AND   B.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430') --일반조건(
 GROUP BY C.BUYER_ID, A.BUYER_NAME
 
   ANSI조인)
   SELECT   A.BUYER_ID AS 거래처코드,
            A.BUYER_NAME AS 거래처명,
            SUM(C.BUY_QTY*B.PROD_COST) AS 매입금액합계
   FROM     BUYER A
   INNER JOIN PROD B ON(A.BUYER_ID=B.BUYER_ID)
   INNER JOIN BUYPROD C ON(B.PROD_ID=C.PROD_ID AND C.BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401')))
   GROUP BY A.BUYER_ID,A.BUYER_NAME
   
 5) HR계정에서 미국 이외의 국가에 위치한 부서에 근무하는 사원들을 조회하시오.
    조회할 컬럼은 사원번호, 사원명, 부서명, 국가이며 미국의 국가코드는 'US'임
 
 일반조인)
 SELECT E.EMPLOYEE_ID AS 사원번호,
        E.EMP_NAME AS 사원명,
        D.DEPARTMENT_NAME AS 부서명,
        C.COUNTRY_NAME AS 국가
   FROM HR.EMPLOYEES E,
        HR.DEPARTMENTS D,
        HR.LOCATIONS L,
        HR.COUNTRIES C 
  WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND   D.LOCATION_ID = L.LOCATION_ID
  AND   L.COUNTRY_ID = C.COUNTRY_ID
  AND   C.COUNTRY_ID != 'US'
  ORDER BY D.DEPARTMENT_ID
 
 ANSI JOIN)
 
 SELECT E.EMPLOYEE_ID AS 사원번호,
        E.EMP_NAME AS 사원명,
        D.DEPARTMENT_NAME AS 부서명,
        C.COUNTRY_NAME AS 국가
 FROM   HR.EMPLOYEES E
        INNER JOIN HR.DEPARTMENTS D 
              ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
        INNER JOIN HR.LOCATIONS L 
              ON (D.LOCATION_ID = L.LOCATION_ID)
        INNER JOIN HR.COUNTRIES C 
              ON (C.COUNTRY_ID = L.COUNTRY_ID) -- AND C.COUNTRY_ID != 'US') 일반조건+
 WHERE  C.COUNTRY_ID != 'US'
 ORDER BY D.DEPARTMENT_NAME