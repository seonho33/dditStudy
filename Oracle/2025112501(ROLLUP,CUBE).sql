2025-11-25-01) ROLLUP과 CUBE
 - GROUP BY 절 내부에서 사용되어 다양합 집계 결과를 반환함...
-- 1. ROLLUP
   -레벨별 집계 결과를 반환
--사용형식)
  GROUP BY [컬럼명,...,] ROLLUP(컬럼명1,컬럼명2,...,컬럼명n)[,컬럼명,...]
  - ROLLUP 안에 사용된 모든 컬럼을 기준으로 집계반환(레벨n)한 후 오른쪽에
    기술된 컬럼을 하나씩 제거한 컬럼들을 기준으로 집계반환
  - 맨 마지막에는 ROLLUP안에 모든 컬럼을 제거한(전체집계) 집계 반환
  - ROLLUP안에 사용된 컬럼의 수가 N개인 경우 N+1종류의 집계 반환
  - ROLLUP 왼쪽 또는 오른쪽에 컬럼이 기술되면 기술된 해당 컬럼은 제거되지 않으므로
    전체집계를 구할 수 없고 이를 부분 ROLLUP이라 함

--사용예)
 1) 장바구니 테이블에서 2020년 월별, 회원별, 상품별 구매수량 집계를 조회하시오...
    SELECT  SUBSTR(CART_NO,5,2) AS 월,
            MEM_ID AS 회원번호,
            PROD_ID AS 상품번호,
            SUM(CART_QTY) AS 구매수량집계
    FROM    CART
    WHERE   CART_NO LIKE '2020%'
    GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1;
    
    SELECT  CASE WHEN GROUPING(SUBSTR(CART_NO,5,2)) = 1 
                      THEN '전체'
                 ELSE SUBSTR(CART_NO,5,2)
                 END AS 월,
            CASE WHEN GROUPING(MEM_ID) = 1
                 THEN '전체'
            ELSE MEM_ID 
            END AS 회원번호,
            CASE WHEN GROUPING(PROD_ID) = 1
                 THEN '전체'
            ELSE PROD_ID
            END AS 상품번호,
            SUM(CART_QTY) AS 구매수량집계
    FROM    CART
    WHERE   CART_NO LIKE '2020%'
    GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1;    
    
-- 2. CUBE
 - 모든 조합 가능한 집계결과를 반환
 사용형식)
    GROUP BY [컬럼명,...,] CUBE(컬럼명1,컬럼명2,...,컬럼명N)[,컬럼명,...]
    - CUBE 안에 기술된 컬럼을 조합한 모든 경우의 집계를 반환
    - CUBE 안에 사용된 컬럼의 수가 N개인 경우 2^N종류의 집계 반환
    - CUBE 왼쪽 또는 오른쪼겡 컬럼이 기술되면 기술된 해당 컬럼은 제거되지 않으므로
      전체 집계를 구할 수 없고 이를 부분 CUBE라고 함...

    SELECT  SUBSTR(CART_NO,5,2) AS 월,
            MEM_ID AS 회원번호,
            PROD_ID AS 상품번호,
            SUM(CART_QTY) AS 구매수량집계
    FROM    CART
    WHERE   CART_NO LIKE '2020%'
    GROUP BY CUBE(SUBSTR(CART_NO,5,2),MEM_ID,PROD_ID)
    ORDER BY 1,2;