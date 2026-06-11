2025-11-26-01)서브쿼리와 DML명령
 1. INSERT 명령
  - 서브쿼리를 사용하는 INSERT 명령은 VALUES절이 생략되고 '( )'를 사용하지 않고
    서브쿼리를 기술함
 사용형식)
    INSERT INTO 테이블명[(컬럼명,...)]
        서브쿼리;
     -  '(컬럼명,...)'이 사용된 경우 서브쿼리의 SELECT절의 컬럼의 갯수, 순서와
        '(컬럼명,...)'의 갯수, 순서는 반드시 일치해야함
        
 사용예)
 1) HR계정에 사원번호, 부서코드, 직무코드, 입사일로 구성된 퇴직자 테이블을 생성하시오...
    CREATE TABLE HR.RETIRE AS
        SELECT  EMPLOYEE_ID,
                DEPARTMENT_ID,
                JOB_ID,
                HIRE_DATE
        FROM    HR.EMPLOYEES
        
    DELETE FROM HR.RETIRE
    COMMIT

1-1) HR계정의 TEMP_EMP 테이블에서 입사년도가 2013년 이전인 사원들을 퇴직처리 하십시오...
     퇴직 대상자는 RETIE 테이블에 저장하고, TEMP_EMP 테이블에서는 삭제하시오...
     (서브쿼리:입사년도가 2013년 이전인 사원들의 사원번호)
     SELECT EMPLOYEE_ID
     FROM   HR.TEMP_EMP
     WHERE EXTRACT(YEAR FROM HIRE_DATE)<=2013
     (메인쿼리:서브쿼리의 결과로 반환된 사원정보 INSERT)
     INSERT INTO HR.RETIRE(EMPLOYEE_ID,DEPARTMENT_ID,JOB_ID,HIRE_DATE)
        SELECT  EMPLOYEE_ID,DEPARTMENT_ID,JOB_ID,HIRE_DATE
        FROM    HR.TEMP_EMP
        WHERE EXTRACT(YEAR FROM HIRE_DATE)<=2013
 2) DELETE 명령
 - 서브쿼리를 삭제 조건으로 활용
    DELETE FROM 테이블명 WHERE 조건;
    
 사용예)HR계정의 TEMP_EMP 테이블에서 2013년도 이전 입사한 사원정보를 삭제하라...
    DELETE 
    FROM HR.TEMP_EMP
    WHERE EMPLOYEE_ID =ANY(SELECT
                            EMPLOYEE_ID
                           FROM HR.TEMP_EMP
                           WHERE EXTRACT(YEAR FROM HIRE_DATE)<=2013)
 3) UPDATE 명령
  - 서브쿼리를 SET절에 사용하여 복수개의 열을 일괄로 갱신
  - 서브쿼리를 WHERE 절의 조건으로 사용
  사용형식)
    UPDATE  테이블명[별칭]
    SET     (컬럼명,...)=서브쿼리
    [WHERE 조건]
    -SET절에 기술된 컬럼의 갯수 및 순서는 서브쿼리의 SELECT절의 컬럼의 갯수 및 순서와 일치해야함
    
 사용예)2020년 1~3월에 발생된 매입정보를 활용하여 재고수불테이블을 갱신하시오 
 (서브쿼리 : 2020년 1~3월에 상품별 매입수량..)
    SELECT
        PROD_ID,
        SUM(BUY_QTY) AS BSUM
    FROM    BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE(LAST_DAY('20200101'))
    GROUP BY PROD_ID
 (메인쿼리 : 재고수불테이블 갱신...)
    UPDATE  REMAIN A
    SET    (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE) =
(   SELECT
    (A.REMAIN_I+C.CSUM),(A.REMAIN_J_00+C.CSUM),TO_DATE('20200331')
    FROM
(       SELECT
            PROD_ID,
            SUM(BUY_QTY) AS CSUM
        FROM    BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE(LAST_DAY('20200301'))
        GROUP BY PROD_ID
    ) C
    WHERE   C.PROD_ID = A.PROD_ID)
    WHERE   A.PROD_ID IN (SELECT DISTINCT PROD_ID
                         FROM   BUYPROD
                         WHERE  BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'))
    
사용예) 오늘이 2020년 4월 1일이라고 가정하고 오늘 매출자료를 재고수불테이블에 반영하시오...
(서브쿼리)
    SELECT
        PROD_ID,
        SUM(CART_QTY) AS CSUM
    FROM    CART
    WHERE   SUBSTR(CART_NO,1,8)='20200401'
    GROUP BY    PROD_ID
(메인쿼리)
    UPDATE REMAIN A
    SET    (A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_O+SUM(CART_QTY),A.REMAIN_J_99-SUM(CART_QTY),TO_DATE('20200401')
         FROM   CART
         WHERE  CART_NO LIKE '20200401%'
         AND    A.PROD_ID = CART.PROD_ID)
    WHERE A.PROD_ID IN (SELECT  DISTINCT PROD_ID
                        FROM    CART
                        WHERE   CART_NO LIKE '20200401%')         
    