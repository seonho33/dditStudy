2025-11-12-02) 함수(FUNCTION)
LOWER,UPPER,INITCAP = 소문자, 대문자, 첫글자만 대문자
LENGTH 주어진 문자열 글자수

LTRIM(문자열[,제거문자열]) 
RTRIM(문자열[,제거문자열]) 왼쪽 혹은 오른쪽부터 제거할 문자열을 찾아 제거함 문자열이 없을경우 공백제거
TRIM( 주어진 문자열 왼쪽,오른쪽에있는 공백제거)

SUBSTR(문자열, 시작위치, [길이])
REPLACE(문자열,문자열1,문자열2)(주어진 문자열에서 문자열1 을 문자열2 로 대치함 
        문자열에 문자열1이 완벽하게 일치해야함
        문자열2가 생략되면 공백을 문자열1을 삭제 문자열 내부 공백 제거 가능

 -문자, 숫자, 날짜, 형변환, NULL 처리함수, 집계, 순위함수,..
-- 1. 문자열 함수
    -CONCAT, LOWER, UPPER, INITCAP,LENGTH,LPAD,RPAD,LTRIM,RTRIM,TRIM
     SUBSTR,REPLACE,INSTR ... 
--사용예
1)회원테이블에서 '충남'에 거주하는 회원 정보를 조회하시오(회원번호, 회원명, 주소).
  단 주소는 기본주소와 상세주소를 결합하여 줄력하되 한칸의 공백을 두 자료 사이에 추가하며, CONCAT 함수를 사용하시오.
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           CONCAT(MEM_ADD1,CONCAT(' ',MEM_ADD2)) 주소
    FROM    MEMBER
    WHERE   SUBSTR(MEM_ADD1,1,2)='충남'
    ORDER BY 1;

2) 상품테이블에서 분류코드 'P102'에 속하는 상품의 상품번호, 상품명, 판매가를 조회하시오.
    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 상품명,
           PROD_PRICE AS 판매가
    FROM   PROD
    WHERE  Lower(LPROD_GU) = 'p102'
    ORDER BY 1;

    SELECT FIRST_NAME||' '||LAST_NAME AS 사원명1,
           LOWER(FIRST_NAME||' '||LAST_NAME) AS 사원명2,
           INITCAP(LOWER(FIRST_NAME||' '||LAST_NAME)) AS 사원명3,
           EMP_NAME AS 사원명4
    FROM HR.EMPLOYEES
    ORDER BY 1;  

3) SELECT PROD_PRICE AS 판매가1,   
          LPAD(PROD_PRICE,10,'*') AS 판매가2, 
          RPAD(PROD_PRICE,10,'*') AS 판매가3,
          LPAD(PROD_COLOR,10) AS 상품색상1,
          RPAD(PROD_COLOR,10) AS 상품색상2
    FROM PROD;

4) SELECT LTRIM('BABBAABBBCBA','BA'),
        RTRIM('BABABBBAAC','AB'),
        LTRIM('   BABABBA  BAB'),
        RTRIM('    BABABA  BAB   '),
        TRIM('   A BAB BABB     ')AS A
         FROM DUAL;
         
5) 오늘이 2020년 7월 28일이라고 가정하고 장바구니 테이블을 생성하시오
    SELECT '20200728'||TRIM(TO_CHAR(TO_NUMBER(SUBSTR( MAX(CART_NO),9))+1,'00000')),
            MAX(CART_NO)+1
      FROM CART
     WHERE SUBSTR(CART_NO,1,8)='20200728'
  ORDER BY

6) 장바구니 테이블에서 6월에 판매된 정보를 출력하시오(일자, 상품번호, 수량이며 날짜순으로 출력할것)

    SELECT CART_NO AS 일자,
           SUBSTR(CART_NO,7,2) AS 일자2,
           PROD_ID AS 상품번호,
           CART_QTY AS 수량
    FROM   CART
    WHERE SUBSTR(CART_NO,1,6)='202006'
    ORDER BY 1;
           
7) 회원 테이블의 주민등록번호를 이용하여 나이를 계산하여 출력하시오
    (회원번호, 회원명, 주민등록번호, 나이)
    SELECT  MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            CONCAT(MEM_REGNO1,CONCAT('-',MEM_REGNO2))주민등록번호,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1)IN('1','2')THEN
                      EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(MEM_REGNO1,1,2)+1900)
                 ELSE EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(MEM_REGNO1,1,2)+2000) END AS 나이
    FROM    MEMBER
    ORDER BY 4;
   
        