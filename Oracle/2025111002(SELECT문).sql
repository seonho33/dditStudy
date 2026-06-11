2025-1110-02)SELECT 문
 - 자료 검색을 위한 명령으로 RDB에서가장많이 사용
 
 사용형식)
 SELECT*|[DISTINCT]
        [컬럼명 [AS별칭],]
            :
        컬럼명[AS별칭]]
    FROM 테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명[,컬럼명,...,컬럼명]] HAVING 조건]
    [ORDER BY 컬럼명|컬럼인덱스[ASC|DESC][,컬럼명|컬럼인덱스[ASC|DESC],...]]
    
    -SELECT 문의 필수절은 SELECT절과 FROM이다.
    -실행순서는 FROM 절 -> WHERE 절 -> GROUP BY 절 -> HAVING절 -> SELECT절->ORDER BY절
    -DISTINCT는 중복값을 배제할 때 사용
    -'별칭'은 출력시 컬럼의 제목으로 사용되며 서브쿼리 사용시 해당 컬럼의 참조에 사용
    -'별칭'에 특수문자가 포함된 경우 ""로 묶어야함
    -GROUP BY 절은 그룹으로 나누어 집계처리 시 사용
    -HAVING 절은 그룹함수(SUM,AVG,COUNT,MAX,MIN)에 조건이 부여될 때 사용
    -ORDER BY 절은 결과를 정렬시킬때 사용됨
    -ORDER BY 절의 컬림인덱스는 SELECT 절에 기술된 컬럼의 순번이며 1부터 시작함
    -기본 정렬방식은 오름차순(ASC)이며 생략가능함
    
--사용예
  1)쇼핑몰 데이터베이스의 분류테이블(LPROD)의 모든 자료를 검색하시오
    SELECT*FROM LPROD
    ORDER BY LPROD_NAME ASC;
    
  2) HR계정의 부서테이블(DEPARTMENTS)의 모든 자료를 조회 하시오.
    SELECT*FROM HR.DEPARTMENTS;
    
  3) PRACTICE 계정의 고객테이블(CUSTOMERS)의 모든 고객정보를 조회하시오
    SELECT*FROM PRACTICE.CUSTOMERS;
  
  4) 쇼핑몰데이터베이스의 상품테이블(PROD)에 사용된 분류코드를 중복없이 조회하시오
    SELECT DISTINCT*FROM PROD ;
  
  5) 쇼핑몰데이터베이스의 회원테이블(MEMBER)에서 여성회원의 회원번호, 회원명, 주소, 마일리지를
     조회하되 마일리지가 많은 회원부터 출력하시오
     SELECT MEM_ID,MEM_NAME,MEM_ADD1,MEM_ADD2,MEM_MILEAGE FROM MEMBER WHERE SUBSTR(MEM_REGNO2,1,1)=2 OR SUBSTR(MEM_REGNO2,1,1)=4 ORDER BY MEM_MILEAGE DESC;
     SELECT*FROM MEMBER WHERE MEM_REGENO02 ORDER BY MEM_ID;
