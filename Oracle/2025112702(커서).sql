2025-11-27-03)커서(CURSOR)
-   넓은 의미의 커서 : SQL명령의 영향을 받은 행들의 집합
-   좁은 의미의 커서 : SELECT 문의 결과 집합
-   커서가 사용되어야하는 이유는 PL/SQL 실행영역에서 사용하는 SELECT문의 SELECT 절의 결과를
    INTO절의 변수가 할당해야하는데 복수개의값을 변수가 처리할수 없어서 CURSOR를 활용하여 이를 해결
-   묵시적 커서
     . 이름이 없는 커서
     . 커서가 항상 닫혀있어 커서 내부의 값을 참조할 수 없음
     . 커서 속성
--------------------------------------------------------------
    속성              내용
--------------------------------------------------------------
    SQL%ISOPEN      커서가 OPEN 상태이면 참을 닫혀있으면 거짓을 반환...
                    (묵시적 커서는 항상 거짓임)
    SQL%NOTFOUND    SQL명령의 결과 집합이 없으면 참, 있으면 거짓을 반환
    SQL%FOUND       SQL명령의 결과 집합이 있으면 참, 없으면 거짓을 반환
    SQL%ROWCOUNT    SQL명령의 결과 집합의 행의 수
    
    
-   명시적 커서    
    . 이름이 있는 커서
    . 커서를 사용하는 과정
      선언(선언영역) -> OPEN(실행영역 반복문 밖에서) -> FETCH(커서의 내용을 줄단위로 읽어 옴:반복문 내부)
      -> CLOSE(실행영역 반복문 밖에서)
      
--------------------------------------------------------------
    속성              내용
--------------------------------------------------------------
    커서명%ISOPEN      커서가 OPEN 상태이면 참을 닫혀있으면 거짓을 반환...
                      (묵시적 커서는 항상 거짓임)
    커서명%NOTFOUND    SQL명령의 결과 집합이 없으면 참, 있으면 거짓을 반환
    커서명%FOUND       SQL명령의 결과 집합이 있으면 참, 없으면 거짓을 반환
    커서명%ROWCOUNT    SQL명령의 결과 집합의 행의 수      

--  사용형식)
    CURSOR 커서명[(변수명 타입 [,...])] IS 
        SELECT 문;
- '변수명 타입' : 매개변수로, 타입만 기술해야함.(크기를 지정하면 오류)
                OPEN 문에서 값을 전달해줌
- OPEN
    . 커서를 사용하기 위해 수행...
      OPEN 커서명[(값,...)]
      - '(값,...)' : 커서 선언문의 매개변수에 전달할 값
- FETCH
    . 커서 내부의 자료를 행단위로 읽어 INTO절 뒤의 변수에 할당
      FETCH 커서명 INTO 변수명,...;
- CLOSE
    . 사용이 종료된 커서는 CLOSE 되어야 다시 OPEN 할 수 있음
      
    DECLARE
        L_PROD PROD%ROWTYPE;
        CURSOR CUR_PROD IS
            SELECT  *
            FROM    PROD
            WHERE   LPROD_GU='P201';
    BEGIN
        OPEN CUR_PROD;
        LOOP
            FETCH CUR_PROD INTO L_PROD;
            EXIT WHEN CUR_PROD%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('상품번호 : '||L_PROD.PROD_ID);
            DBMS_OUTPUT.PUT_LINE('상품명 : '||L_PROD.PROD_NAME);
            DBMS_OUTPUT.PUT_LINE('매입가 : '||L_PROD.PROD_COST);
            DBMS_OUTPUT.PUT_LINE('매출가 : '||L_PROD.PROD_PRICE);
            DBMS_OUTPUT.PUT_LINE('----------------------------------');
        END LOOP;
    END;    
