2025-11-17-02) NULL 처리 함수
 - NVL, NVL2, NULLIF, COALESEC 등이 제공됨
--1. IS NULL / IS NOT NULL 
 - 컬럼의 값이 NULL인지 판단하는 조건문에 사용하는 연산자는 '='을 사용할 수 없고
   IS NULL, IS NOT NULL 을 사용해야한다

사용예) 사원테이블에서 영업실적코드에 값이 없는 사원들의 사원번호, 사원명, 부서코드를 조회하시오
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서코드
FROM HR.EMPLOYEES
WHERE COMMISSION_PCT IS NULL
ORDER BY 3;

--2. NVL(COL,VALUE)
  -'COL'의 값이 NULL이면 'VALUE'를, NULL이 아니면 자기자신(COL)을 반환
  -'COL'과 'VALUE'는 동일 자료 타입이어야 함
사용예)
 1) 사원테이블에서 영업실적코드에 값이 없는 사원들은 비고란에 없음을 출력하고 영업실적코드에 값이 존재하면
    비고란에 영업실적을 출력하시오 조회할 자료는 사원번호,사원명,부서코드,비고다
SELECT  EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        DEPARTMENT_ID AS 부서코드,
        NVL(TO_CHAR(COMMISSION_PCT),'영업실적 없음') AS 비고
FROM HR.EMPLOYEES
ORDER BY 4;

 2) 사원테이블에서 영업실적 코드에 따른 보너스를 계산하고 지급액을 조회하시오
    (보너스 = 영업실적코드 * 급여50%, 지급액 = 보너스+급여. 단, 영업실적코드가 null 이면 0으로 계산할 것)
    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            NVL(TO_CHAR(COMMISSION_PCT),'영업실적없음') AS 영업실적코드,
            SALARY*NVL(COMMISSION_PCT*0.5,0) AS 보너스,
            SALARY+(SALARY*NVL(COMMISSION_PCT,0)*0.5) AS 지급액
    FROM HR.EMPLOYEES
    ORDER BY 5;
    
 3) 2020년 6월 모든 회원들의 구매현황을 조회하시오 출력은 회원번호, 회원명, 구매금액   
    SELECT  B.MEM_ID AS 회원번호,
            B.MEM_NAME AS 회원명,
            NVL(SUM(A.CART_QTY * C.PROD_PRICE),0) AS 구매금액
    FROM CART A
    RIGHT OUTER JOIN MEMBER B ON(A.MEM_ID=B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(A.PROD_ID=C.PROD_ID AND A.CART_NO LIKE '202006%')
    GROUP BY B.MEM_ID, B.MEM_NAME;
    
 4) 상품테이블에서 크기정보(PROD_SIZE)를 조회하되 그 값이 NULL이면 '크기정보없음'을 출력하시오
 SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        NVL(PROD_SIZE,'크기정보없음') AS 크기
 FROM PROD
 ORDER BY 3;
 
--3.NVL2(COL,VALUE1,VALUE2)
    COL의 값이 NULL 이면 VALUE2를 반환하고 NULL이 아니면 VALUE1을 반환함
    VALUE1과 VALUE2는 같은 타입이어야함...

사용예)
1) 사원테이블에서 영업실적코드에 값이 없는 사원들은 비고란에 없음을 출력하고 영업실적 코드에 값이 존재하면
   비고란에 영업실적을 출력하시오, 조회할 자료는 사원번호, 사원명, 부서코드, 비고이다.
   
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서코드,
       NVL2(TO_CHAR(COMMISSION_PCT),TO_CHAR(COMMISSION_PCT),'영업실적 없음') AS 비고
FROM HR.EMPLOYEES
ORDER BY 4;

2) 2020년 2월 모든 상품별 매입현황을 조회하시오. 출력은 상품코드, 상품명,매입금액이며 매입이 없는 상품은 '매입없음'을 출력하시오...

    SELECT      B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                NVL2(SUM(B.PROD_COST*A.BUY_QTY),TO_CHAR(SUM(B.PROD_COST*A.BUY_QTY),'99,999,999'),LPAD('매입없음',12)) AS 매입금액
    FROM        BUYPROD A, PROD B
    WHERE       A.BUY_DATE(+) BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
                AND A.PROD_ID(+)=B.PROD_ID
    GROUP BY    B.PROD_ID,B.PROD_NAME
    ORDER BY    1;

--4. NULLIF(COL1.COL2)
   COL1과 COL2가 같은 값이면 NULL을 반환하고 NULL이 아니면 COL1을 반환...
사용예)
1) 상품테이블에서 매입단가와 매출단가가 동일한 품목을 조회하여 비고란에 '단종예정상품'을 출력하고
   동일하지 않은 상품은 매입단가를 출력하시오...
   조회할 컬럼은 상품코드, 상품명, 분류코드, 비고이다...
   
    SELECT  PROD_ID AS 상품코드,
            PROD_NAME AS 상품명,
            LPROD_GU AS 분류코드,
            NVL(TO_CHAR(NULLIF(PROD_COST,PROD_PRICE),'99,999,999'),'단종예정상품') AS 비고
    FROM PROD
    ORDER BY 1;