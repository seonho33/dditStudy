2025-11-14-01) 날짜함수

 2)HR 계정의 사원테이블에서 사원들의 입사일을 모두 3년후로 변경하시오.
    UPDATE HR.EMPLOYEES
       SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,36);
    COMMIT;
    
 3)입사일이 변경된 사원테이블에서 근속년수가 7년 이상인 사원의 사원번호,사원명,입사일,부서번호
    근속기간을 조회하시오. 근속년수 XX년으로 근속기간은 XX년 XX개월 형식으로 출력하시오
    
    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            HIRE_DATE AS 입사일,
            DEPARTMENT_ID AS 부서번호,
            TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)||'년 '||
            ROUND(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),12))||'개월 ' AS 근속기간
    FROM    HR.EMPLOYEES
    WHERE   TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) >= 10
    ORDER BY 5 DESC;
    
4)매입 테이블에서 2020년 2월 상품별 매입현황을 조회하시오
  출력은 상품명, 매입수량, 매입금액
  
SELECT  A.PROD_NAME AS 상품명,
        SUM(B.BUY_QTY) AS 매입수량,
        SUM(B.BUY_QTY * A.PROD_COST) AS 매입금액
FROM    PROD A , BUYPROD B
WHERE   A.PROD_ID = B.PROD_ID 
        AND B.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP BY A.PROD_NAME;
            