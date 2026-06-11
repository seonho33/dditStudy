2025-1106-01)날짜자료
    - date, timestamp, timestamp with time zone, timestamp with local time zone
1) DATE
    - 기본 날짜타입(년,월,일,시,분,초)
    - 덧셈(다가올 날짜 반환)
      뺄셈(지나온 날짜 반환)
    - SYSDATE 함수로 날짜정보를 반환 받을 때 저장하는 타입
    
사용예)
    CREATE TABLE DATE_TBL(
        COL1 DATE,
        COL2 DATE,
        COL3 DATE
        );
    
    INSERT INTO DATE_TBL VALUES(SYSDATE, SYSDATE+10,SYSDATE-10);
    
    SELECT      TO_CHAR(COL1,'YYYY-MM-DD HH24 : MI : SS') AS "COL1",
                TO_CHAR(COL2,'YYYY-MM-DD HH24 : MI : SS') AS "COL2",
                TO_CHAR(COL3,'YYYY-MM-DD HH24 : MI : SS') AS "COL3"
    FROM DATE_TBL;
    
2) TIMESTAMP
    - 정교한 날짜타입(년,월,일,시,분,초) 초가 10^9분의 1초로 표현됨
    - SYSTIMESTAMP 함수로 자료를 반환하여 저장
    - TIME ZONE 정보는 표현하지 않음

사용예)
    CREATE TABLE TIMESTAMP_TBL(COL1 TIMESTAMP, COL2 TIMESTAMP);
    
    INSERT INTO TIMESTAMP_TBL VALUES(SYSDATE, SYSTIMESTAMP);
    
    SELECT*FROM TIMESTAMP_TBL;

3) TIMESTAMP WITH LOCAL TIME ZONE , TIMESTAMP WITH TIME ZONE
  - TIMESTAMP WITH LOCAL TIME ZONE : 서버와 클라이언트가 설치된 지역의
                                     시간 차이를 표현하며 같은 지역에 설치되어
                                     있으면 TIMESTAMP와 같은 결과 출력

  - TIMESTAMP WITH TIME ZONE : 클라이언트와 GMT(세계 표준시간) 과의 시간차이를 출력
  
사용예)
  CREATE TABLE STAMP_TBL (COL1 TIMESTAMP, COL2 TIMESTAMP WITH LOCAL TIME ZONE,
  COL3 TIMESTAMP WITH TIME ZONE);
  
  INSERT INTO STAMP_TBL VALUES(SYSTIMESTAMP,SYSTIMESTAMP,SYSTIMESTAMP);
  SELECT*FROM STAMP_TBL;
  
    SELECT*FROM 