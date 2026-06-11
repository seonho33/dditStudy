2025-11-13-01)
ROUND(N[,M]) M이 양의 수 = M+1번째 자리에서 반올림
             M이 음의 수 = M번째 자리에서 반올림(정수부분)
             M=0 OR NULL 일경우
WIDTH_BUCKET(하한값, 상한값, 구간의 수)
 하한~ 상한까지 구간의 수 만큼의 블록으로 나누었을때 '자료'가 속한 구간의 index
 
2. 숫자함수
    - 수학적 함수(ABS, SIGN, SQRT, POWER, ...), ROUND, TRUNC, MOD,
            REMAINDER, FLOOR, CEIL, WIDTH_BUCKET 등이 제공됨
사용예)
 1) SELECT ABS(-100), ABS(12.5), SIGN(12000),SIGN(0),SIGN(-0.0005)
 FROM DUAL; --SING 양수 음수 비교
    SELECT SQRT(36), POWER(2,4)
 FROM DUAL; --POWER 앞의 수의 N제곱
 2) HR 계정에서 입사년도별 사원들의 평균급여를 조회하시오.
 출력은 입사년도, 평균급여이고 평균급여는 소수 첫자리까지 출력
 
 SELECT EXTRACT(YEAR FROM HIRE_DATE) AS 입사년도,
        TO_CHAR(ROUND(AVG(SALARY),1),'999,999.0') 평균급여
 FROM HR.EMPLOYEES
 GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
 ORDER BY 1;
 
 3) 회원테이블에서 연령대별 평균 마일리지를 구하시오.출력은 연령대, 평균마일리지

     SELECT RPAD((TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10)||'대 ',6,' ') AS 연령대,
            COUNT(*)||'명' AS 인원수,
            ROUND(AVG(MEM_MILEAGE)) 평균마일리지
     FROM MEMBER
     GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)
     ORDER BY 1;
 4) 키보드로 년도를 입력받아 해당년도가 윤년인지 평년인지 판별하시오
    윤년은 (4의 배수이면서 100의 배수가 아니거나) (400의 배수가 되는 해)
    ACCEPT P_YEAR PROMPT '년도 입력 :'
    DECLARE
        L_RES VARCHAR2(100):=&P_YEAR;
    BEGIN
        IF(MOD(&P_YEAR,4)=0 AND MOD(&P_YEAR,100)!=0)OR (MOD(&P_YEAR,400)=0) THEN
           L_RES:=L_RES||'년은 윤년입니다!!';
           ELSE L_RES:=L_RES||'년은 평년입니다!!';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(L_RES);
    END;
    
  SELECT MOD(25,6), REMAINDER(25,6),
        MOD(28,6)  , REMAINDER(28,6)
        FROM DUAL;
 5) SELECT FLOOR(24.999), CEIL(24.999),FLOOR(-15.5), CEIL(-15.5)
    FROM DUAL;
    
-- 6) GREATEST(n1, n2,...) , LEAST(n1,n2,...)
   - 주어진 숫자(n1,n2,...) 중 최대값(GREATEST) 또는 최소값(LEAST)를 반환
   - (n1, n2,...)은 같은 타입이거나 자동 변환될 수 있는 타입이어야 함
   - GREATEST는 하나의 행에서 최대값을 반환하고, MAX는 하나의 열에서 최대값을 반환
   - LEAST는 하나의 행에서 최소값을 반환하고, MIN는 하나의 열에서 최소값을 반환
 사용예) 
    SELECT GREATEST(20,65,15), GREATEST('홍길동','홍길순','홍길남')
    FROM DUAL;
 사용예) 회원테이블에서 보유 마일리지가 1000미만인 회원의 마일리지를 1000으로 
       부여하고 1000이상인 회원들은 보유하고있는 마일리지 그대로 출력하시오 출력은 회원번호, 회원명, 보유마일리지,변경마일리지
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 보유마일리지,
           GREATEST(MEM_MILEAGE,1000) AS 변경마일리지
    FROM    MEMBER;
    
-- 날짜함수
- SYSDATE, SYSTIMESTAMP, ADD_MONTHS(DATE,N),NEXT_DAY(DATE,C),LAST_DAY(DATE),
  MONTH_BETWEEN(DATE1,DATE2),EXTRACT(fmt...YEAR...SECOND FROM DATE), ROUND/TRUNC 등이 제공됨
  
1. SYSDATE/ STSTIMESTAMP
 - 시스템이 제공하는 날짜 시간정보 제공
 - 날짜 + 숫자 : 숫자만큼의 일수가 더해진 날짜 반환
 - 날짜 - 숫자 : 숫자만큼의 일수가 빠진 날짜 반환
 - 날짜 - 날짜 : 경과된 일수를 반환

사용예)
 1) SELECT SYSDATE + 30, SYSDATE -30 
 FROM DUAL;
 
    SELECT CASE MOD((TRUNC(SYSDATE)-TO_DATE('00010101'))-1,7)
            WHEN 1 THEN '월요일'
            WHEN 2 THEN '화요일'
            WHEN 3 THEN '수요일'
            WHEN 4 THEN '목요일'
            WHEN 5 THEN '금요일'
            WHEN 6 THEN '토요일'
            ELSE '일요일' END 요일
    FROM DUAL;