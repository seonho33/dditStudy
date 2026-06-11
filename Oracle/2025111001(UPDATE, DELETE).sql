2025-1110-01) DML 명령
2. UPDATE
 - 저장된 컬럼의 값을 변경시킬때 사용

--사용형식
    UPDATE 테이블명 SET 컬럼명=값 [,]
                      컬럼명=값 [,]
                          :
                      컬럼명=값 [,]
    [WHERE 조건](조건이 없다면 전부)
    
--사용예
    1) CART테이블에서 주문번호'2024080600001'의 주문수량을 5로 변경하시오
    2) PROD테이블에서 상품'P102000005'의 판매가격을 1,200,000원으로 변경하시오
    3) HR 계정의 EMPLOYEES테이블에서 EMP_NAME컬럼에 FIRST_NAME컬럼의 값과 LAST_NAME
       컬럼의 값을 공백을 추가하여 결합한 후 입력하시오.
부분반품을 이용한 방법
        UPDATE DSH9603.CART 
        SET CART_QTY = CART_QTY-2 
        WHERE CART_NO = '2020051000002' AND PROD_ID ='P202000002';
        
        UPDATE DSH9603.PROD
        SET PROD_PRICE = 1200000
        WHERE PROD_ID = 'P102000005'
        
        ROLLBACK;
        COMMIT;
        SELECT*FROM HR.EMPLOYEES;
    2)UPDATE DSH9603.PROD SET
        
    3)UPDATE HR.EMPLOYEES SET EMP_NAME = FIRST_NAME||' '||LAST_NAME
    
    --DELETE
3) DELETE
  -테이블에 저장된 자료를 행단위로 삭제
  -부모테이블의 기본키를 자식테이블이 참조하고 있어면 해당부모테이블의 행은 삭제가 제한됨
--사용형식
    DELETE FROM 테이블명
    [WHERE 조건]
    'WHERE  조건' 은 삭제할 행을 결정하는 조건을 기술하며, 생략하면 모든 행을 삭제함
--사용예
1)회원 테이블의 'B001'회원자료를 삭제하시오
  DELETE FROM DSH9603.MEMBER WHERE MEM_ID = B001;
  장바구니 테이블의 장바구니번호가 '2020040100001' 자료를 삭제하시오
  
  DELETE FROM DSH9603.CART WHERE CART_NO='2020040100001';
  사용예)DSH9603계정의 EMPLOYEES 테이블의 모든 자료를 삭제하시오
  
  CREATE TABLE HR.TEMP_EMP AS SELECT*FROM HR.EMPLOYEES;
  DELETE FROM HR.TEMP_EMP;
    SELECT*FROM HR.TEMP_EMP;  
  COMMIT;

  사용예)HR 계정의 TEMP_EMP 테이블에서 입사일이 2013년 이전 사원들을 삭제하시오
  SELECT*FROM HR.TEMP_EMP WHERE HIRE_DATE<'20130101';
  DELETE FROM HR.TEMP_EMP WHERE HIRE_DATE<'20130101';