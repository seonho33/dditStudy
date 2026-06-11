2025-11-14-02)형변환 함수
    - CAST, TO_CHAR, TO_NUMBER, TO_DATE 가 제공됨
    
1. TO_CHAR(char|num|date[,fmt])
  - 문자열자료, 숫자형 자료, 날짜형 자료를 문자열로 변환
  - 'fmt'는 변환 형식을 지정하는 문자열로 '날짜형'과 '숫자형'이 있음
  ------------------------ 날짜 형식 지정 문자열-------------------------
  -----------------------------------------------------------------------
    형식 문자열         의미                 사용예
  -----------------------------------------------------------------------
  AD, BC, CC       서기, 세기       SELECT TO_CHAR(SYSDATE,'BC CC')||'세기' FROM DUAL;        
      Q               분기         SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
   YYYY,YYY
    YY,Y              년도         SELECT TO_CHAR(SYSDATE,'YYYY YYY YY Y') FROM DUAL;
   MM,RM              월         
   MONTH,MON     '월' 문자열이 출력  SELECT TO_CHAR(SYSDATE, 'MM RM MON MONTH') FROM DUAL;
   DD,DDD,J           일           SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
                                         TO_CHAR(SYSDATE, 'YYYY-MM-DD DDD'),
                                        TO_CHAR(SYSDATE, 'YYYY-MM-J')
                                         FROM DUAL;
  AM,  PM,
  A.M, P.M        오전/오후         SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH24') FROM DUAL;
  HH,HH12,HH24       시간          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH HH12 HH24') FROM DUAL;
  MI                 분            SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI') FROM DUAL;
  SS,SSSSS           초            SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS SSSSS') FROM DUAL;
  "문자열"         사용자지정         SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') FROM DUAL;
  ---------------------------------------------------------------------------------------
  
  ----------------------------숫자형식지정 문자열-------------------------------------------
    형식 문자열              의미                               사용예
  ---------------------------------------------------------------------------------------
       9         출력형식의 자리수를 결정하며,         
                 유효숫자는 출력하고 무효의        
                 0은 공백을 출력함               SELECT TO_CHAR(1234,'99999') AS "COL1",
                                                     TO_CHAR(1234,'00000') AS "COL2" FROM DUAL;
       0         출력형식의 자리수를 결정하며,
                 유효숫자는 출력하고 무효도
                 0을 출력함

      $,L        유효숫자 왼쪽에 화폐기호를 출력    
                 (L은 달러 의외의 화폐기호를 출력하며,     
                 WINDOWS에서 정의한 화폐기호를 출력     SELECT TO_CHAR(1234,'$99,999') AS "COL1",
                                                          TO_CHAR(1234,'L99,999') AS "COL2"  FROM DUAL; 

      MI         음수를 숫자 오른쪽에 출력
                 양수는 영향이 없음(우측)                SELECT TO_CHAR(-1234,'99999MI') FROM DUAL;

      PR         음수를 '<>'로 묶어 출력
                 양수는 영향이 없음
                 주로 회계장표에서 사용(우측에)          SELECT TO_CHAR(-1111,'99999PR') FROM DUAL;

     .(dot)      소숫점으로 유일하게 숫자로 변환될수 있음  

     ,(comma)    3자리마다 자리점을 찍는다             SELECT TO_CHAR(1234.5678,'9,999.9') AS "COL1",
                                                         TO_CHAR(1234,'9,999.99') AS "COL2",
                                                         TO_CHAR(1234.567,'9999.9')+10 AS "COL3"   FROM DUAL;
------------------------------------------------------------------------------------------

2. TO_NUMBER(문자열데이터[,형식지정문자열])
  - '문자열데이터'자료를 숫자로 변환
  - '문자열데이터'자료가 자동으로 변환될 수 없이 편집된 자료인 경우 이 '문자열데이터'를
    편집할 때 사용한 형식지정 문자열을 기술하여 기본숫자 타입을 반환 받을 수 있다.
사용예) 
    SELECT TO_NUMBER('12345.67'),
           TO_NUMBER('12,345','99,999'),
           TO_NUMBER('<12,345>','00,000PR'),
           TO_NUMBER('$12,345.6','$999,999.9')
    FROM DUAL;  
    
3. TO_DATE(문자열데이터|숫자데이터 [,형식지정문자열])
  - '문자열데이터'나 '숫자데이터'자료를 날짜로 변환
  - '문자열데이터'나 '숫자데이터'자료는 반드시 날짜로 변환 가능한 요소를 포함해야함
    즉, 년월일 또는 년월일시분초 형식을 반드시 지켜야 함
  
  - '문자열데이터'나 '숫자데이터'자료가 자동으로 변환될수 없이 편집된 자료인 경우
    이 '문자열데이터'나 '숫자데이터' 자료를 편집할 때 사용한 형식지정 문자열을 
    기술하여 기본 날짜타입을 반환 받을 수 있다.
    
사용예) 
    SELECT TO_DATE('20200301123115','YYYYMMDDHHMISS'),
           TO_DATE('20200430 102035'),
           TO_DATE('2020/03/01'),
           TO_DATE('2020.03.01')
         --  TO_DATE('20200301121331')
    FROM DUAL;
    ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';
    
4. CAST(컬럼명 AS 타입)
  - '컬럼'의 타입을 뒤에 기술된 '타입'으로 변형
  - 형식지정문자열을 사용할 수 없음
  
사용예)
  SELECT CAST(PROD_COST AS VARCHAR2(10)) AS COL,
         TO_CHAR(PROD_PRICE, '9,999,999') AS COL2
  FROM  PROD
  WHERE LPROD_GU='P101';

    