2025-11-26-05)SYNONYM (동의어)
-   오라클 객체에 부여된 또 다른 이름
-   복잡하고 긴 객체명에 사용하기 쉬운 이름을 추가로 부여함

--사용형식)
    CREATE [ OR REPLACE] SYNONYM 동의어 FOR 대상객체명;

사용예)HR계정의 EMPLOYEES 테이블과 DEPARTMENTS 테이블에 EMP 및 DEPT 동의어를 생성하시오..
    CREATE OR REPLACE SYNONYM HR.EMP FOR HR.EMPLOYEES
    CREATE OR REPLACE SYNONYM HR.DEPT FOR HR.DEPARTMENTS

    SELECT
        B.DEPARTMENT_ID AS 부서번호,
        B.DEPARTMENT_NAME AS 부서명,
        A.EMP_NAME AS 책임사원명
    FROM    HR.EMP A,
            HR.DEPT B
    WHERE   A.EMPLOYEE_ID = B.MANAGER_ID
    ORDER BY 1;
