2025-11-27-01)INDEX객체
-  사용형식)
    CREATE [UNIQUE|BITMAP] INDEX 인덱스이름 ON 테이블명(컬럼명,...) [ASC|DESC]
    
1) 사원번호 150번 사원의 사원번호, 사원명, 입사일, 급여를 조회...
    SELECT
        EMPLOYEE_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
    FROM    TEMP_EMP
    WHERE   EMPLOYEE_ID = 150
    
2)  TEMP_EMP 테이블에서 사원번호 컬럼으로 인덱스를 구성하시오
    CREATE INDEX idx_emp02 ON TEMP_EMP(EMPLOYEE_ID)
    
3)  장바구니테이블에서 장바구니 번호 중 월을 추출하여 인덱스를 구성하시오...
    CREATE INDEX IDX_CART_NO ON CART(SUBSTR(CART_NO,5,2))
    
INDEX 재구성 :
ALTER INDEX idx_emp02 REBUILD... -- 인덱스파일 재구성