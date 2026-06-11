2025-11-24-03)JOIN(2)
--3.외부조인
 -조인조건을 만족하지 않은 테이블(부족한 테이블)에 빈 행(NULL 값으로 채워진)을 
  삽입하여 수행하는 조인...
 -행의 수가 아니라 자료의 종류가 많고 적음의 기준
--사용형식
일반조인)
    SELECT 컬럼LIST
      FROM 테이블명1 [별칭1], 테이블명2 [별칭2],...
     WHERE 별칭1.컬럼명=별칭2.컬럼명(+) -- '(+)연산자는 자료가 부족한 쪽에 붙임'
       AND 
 - (+)연산자는 자료가 부족한쪽에 붙임
 - 양쪽 모두에 '(+)'연산자를 사용할 순 없다
 - 복수개의 조인조건이 모두 외부조인을 수행하는 경우 모든 조건에 '(+)'를 사용해야함
 - 세개이상의 테이블이 외부조인에 참여하는 경우 어느 한 테이블이 다른 두 테이블에 동시에
   외부조인 될 수 없다. 즉, A,B,C 테이블이 외부조인 되는 경우 
   WHERE A=B(+)
     AND C=B(+)는 허용되지 않는다.
 - 일반조건을 기술하면 외부조인 결과가 내부조인 결과로 변경됨
  (해결책으로 서브쿼리 사용 또는 ANSI 외부조인 사용)
  
ANSI 외부조인)
    SELECT 컬럼LIST
      FROM 테이블명1 [별칭1]
    [FULL|LEFT|RIGHT] OUTER JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건])
                            :
    [WHERE 일반조건]
    - 'FULL' : 테이블명1과 테이블명2가 모두 부족한 경우
    - 'LEFT' : FROM절쪽의 자료가 OUTER JOIN 절에 기술된 테이블의 자료보다 많은 경우
    - 'RIGHT' : OUTER JOIN절에 기술된 테이블의 자료가 FROM절의 자료보다 많은 경우 
    - 'WHERE 일반조건'을 사용하면 결과가 내부조인 결과로 변경됨...
    
--사용예)
 1) 모든 분류별 상품의 수를 조회하시오. 조회할 내용은 분류코드, 분류명, 상품의 수
    (상품에 사용된 분류코드(중복배제))
    일반 외부조인)
    SELECT L.LPROD_GU AS 분류코드,
           L.LPROD_NAME AS 분류명,
           COUNT(P.PROD_ID) AS "상품의 수" -- NULL도 세기때문에 COUNT(*) 쓰면 안됨...해당되는 테이블의 기본키를 쓸것...
      FROM PROD P, LPROD L
     WHERE L.LPROD_GU=P.LPROD_GU(+)
     GROUP BY L.LPROD_GU,L.LPROD_NAME
     ORDER BY 1;
     
    ANSI 외부조인)
    SELECT L.LPROD_GU AS 분류코드,
           L.LPROD_NAME AS 분류명,
           COUNT(P.PROD_ID) AS "상품의 수"
      FROM LPROD L
    LEFT OUTER JOIN PROD P
                 ON (L.LPROD_GU = P.LPROD_GU)
    GROUP BY L.LPROD_GU, L.LPROD_NAME
    ORDER BY 1;
    
 2) 2020년 4월 모든 회원별 매출액 집계를 조회하시오.
    조회할 값은 회원번호, 회원명, 구매금액합계이다.
    
    SELECT M.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           NVL(TO_CHAR(SUM(C.CART_QTY*P.PROD_PRICE),'999,999,999'),RPAD(0)) AS 구매금액합계
      FROM CART C, MEMBER M, PROD P
     WHERE M.MEM_ID =C.MEM_ID(+)
       AND C.PROD_ID(+) = P.PROD_ID
 --      AND C.CART_NO(+) LIKE '202004%'
       AND C.CART_NO(+) LIKE '202004%'
    GROUP BY M.MEM_ID,M.MEM_NAME
    ORDER BY 1;
    
    ANSI OUTER JOIN
    SELECT M.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           NVL(SUM(C.CART_QTY*P.PROD_PRICE),0) AS 구매금액합계
      FROM CART C
     RIGHT OUTER JOIN MEMBER M
                   ON(C.MEM_ID=M.MEM_ID AND SUBSTR(C.CART_NO,1,6)='202004')
      LEFT OUTER JOIN PROD P
                   ON(C.PROD_ID=P.PROD_ID)
    GROUP BY M.MEM_ID,
             M.MEM_NAME
    ORDER BY 1;
      
    SELECT M.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           NVL(SUM(C.CART_QTY*P.PROD_PRICE),LPAD(0,1)) AS 구매금액합계
      FROM CART C
     RIGHT OUTER JOIN MEMBER M
                   ON(C.MEM_ID=M.MEM_ID AND SUBSTR(C.CART_NO,1,6)='202004')
      LEFT OUTER JOIN PROD P
                   ON(C.PROD_ID=P.PROD_ID)
    GROUP BY M.MEM_ID,
             M.MEM_NAME
    ORDER BY 1;      
      
 (서브쿼리)
    SELECT M.MEM_ID AS 회원번호,
           M.MEM_NAME AS 회원명,
           NVL(C.CSUM,0) AS 구매금액합계
      FROM MEMBER M,
           (SELECT MEM_ID, SUM(C.CART_QTY*P.PROD_PRICE) AS CSUM
              FROM CART C, PROD P
             WHERE C.PROD_ID = P.PROD_ID
               AND SUBSTR(C.CART_NO,1,6)='202004'
             GROUP BY MEM_ID) C
     WHERE M.MEM_ID = C.MEM_ID(+)
     ORDER BY 1;
