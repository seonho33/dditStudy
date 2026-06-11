 2025-1105-02) 숫자 데이터 타입
    - NUMBER 로 정의
 사용형식)
    NUMBER[([*|P])[,S])]
        ,'*' : 전체 자리수를 시스템에게 위임
        ,'P'(PRECISION) : P>S 인 경우 전체 자리수로 1~38 사이의 정수 사용
               p<=S 인 경우 소숫점 이하의 유효숫자(0도 포함) 자리수
 
       ,'S' (SCALE) : 양의 정수이면 저장할 소수점 이하의 자리수(S+1번째 자리에서 반올림)
                      음의 정수이면 해당 정수부분에서 반올림
                      
 사용예)
    CREATE TABLE NUMBER_TBL(
        COL1 NUMBER,
        COL2 NUMBER(5),
        COL3 NUMBER(*,2),
        COL4 NUMBER(3,2),
        COL5 NUMBER(6,2),
        COL6 NUMBER(6,-2),
        COL7 NUMBER(3,4),
        COL8 NUMBER(2,4)
        );
        
        INSERT INTO NUMBER_TBL VALUES (654.189,654.189,654.189,4.189,1654.189,75620.123,0.00012345,0.00125);
        
        SELECT*FROM NUMBER_TBL;