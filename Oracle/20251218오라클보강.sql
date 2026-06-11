/* 입항 → 하선신고 → 보세구역 반입 → 수입신고 수리 → 반출
실무 프로젝트(SI)에서는 데이터 모델링 시 표준 용어 사전을 정의하고, 
이를 기반으로 **영문 약어(Abbreviation)**를 조합하여 물리 컬럼명을 짓는 것이 원칙입니다. 
학생들에게도 "실무에서는 MEM_NAME보다 USER_NM이나 CUST_NM처럼 표준 단어의 조합을 더 많이 쓴다"는 것을 
보여주기에 아주 좋은 예시가 될 것입니다.

요청하신 대로 관세행정 도메인 용어를 반영하여 표준 단축어(Abbreviation) 로 리팩토링한 최종 SQL 스크립트입니다.

[단어 표준화 예시]
그룹(Group) -> GRP
코드(Code) -> CD
신고인(Declarant) -> DCLR
화주/업체(Trader) -> TRDER
물품/상품(Goods) -> GDS
수입(Import) -> IMP
수출(Export) -> EXP

[유니패스(UNIPASS) 실습 데이터 생성 SQL] 
[데이터 생성 시나리오]
품목: 전자기기(스마트폰, TV), 의류, 화장품 (한국의 주력 수출입 품목)
거래: 원자재 수입(Import) -> 가공/재고 -> 완제품 수출(Export)
신고: 관세법인 소속 관세사가 대행 신고
*/

--[*******조인 시작]
/*
JOIN(조인) 예제들을 유니패스(UNIPASS) 관세행정 스키마(UNI_ 테이블)로 변환하였습니다.
이번 파트는 RDBMS의 꽃이라 불리는 JOIN입니다. 
관세행정 데이터에서도 "신고서(CART)에 있는 품목(PROD)의 
HS코드명(LPROD)과 화주명(BUYER)을 한 번에 조회"하는 등 조인은 필수적입니다.

기존의 쇼핑몰 조인 구조를 [수출신고 내역 상세 조회]와 
[통관 물품 상세 조회] 시나리오로 변환했습니다.
*/

/*
1. 3단 조인 (Oracle Join)시나리오: 
수출신고내역(UNI_CART)을 기준으로 품목정보(UNI_PROD)와 
신고인정보(UNI_MEMBER)를 한 번에 조회

  수출신고번호(C.EXP_DEC_NO), 품목코드(C.GDS_ID), 표준품명(P.STD_GDS_NM)
, 신고수량(C.EXP_QTY), 신고인부호(M.DCLR_ID), 관세사명(M.DCLR_NM)
사용테이블 : UNI_MEMBER M, UNI_CART C, UNI_PROD P
*/

SELECT  *
FROM    UNI_MEMBER M, UNI_CART C, UNI_PROD P;

SELECT  C.EXP_DEC_NO    AS 수출신고번호,
        C.GDS_ID        AS 품목코드,
        P.STD_GDS_NM    AS 표준품명,
        C.EXP_QTY       AS 신고수량,
        M.DCLR_ID       AS 신고인부호,
        M.DCLR_NM       AS 관세자명
        
FROM    UNI_CART C
INNER JOIN  UNI_MEMBER M
        ON  (M.DCLR_ID=C.DCLR_ID)
INNER JOIN  UNI_PROD P
        ON  (P.GDS_ID=C.GDS_ID)
ORDER BY 1;

SELECT  C.EXP_DEC_NO    AS 수출신고번호,
        C.GDS_ID        AS 품목코드,
        P.STD_GDS_NM    AS 표준품명,
        C.EXP_QTY       AS 신고수량,
        M.DCLR_ID       AS 신고인부호,
        M.DCLR_NM       AS 관세자명
        
FROM    UNI_CART C,
        UNI_MEMBER M,
        UNI_PROD P
WHERE   M.DCLR_ID=C.DCLR_ID
AND     P.GDS_ID=C.GDS_ID


SELECT  COUNT(C.GDS_ID) AS 품목코드1,
        C.GDS_ID        AS 품목코드,
        P.STD_GDS_NM    AS 표준품명
FROM    UNI_CART C,
        UNI_MEMBER M,
        UNI_PROD P
WHERE   M.DCLR_ID=C.DCLR_ID
AND     P.GDS_ID=C.GDS_ID
GROUP BY    C.GDS_ID, P.STD_GDS_NM
ORDER BY 1 DESC
OFFSET  0 ROWS
FETCH FIRST 1 ROW ONLY

/*
2단 조인 (ANSI Inner Join), 오라클 equi 조인
시나리오: 수출신고내역(UNI_CART)과 신고인(UNI_MEMBER) 정보만 연결

수출신고번호(EXP_DEC_NO), 품목코드(GDS_ID), 신고수량(EXP_QTY),
신고인부호(DCLR_ID), 관세사명(DCLR_NM)
*/

SELECT  C.EXP_DEC_NO   AS 수출신고번호,
        C.GDS_ID    AS 품목코드,
        C.EXP_QTY   AS 신고수량,
        M.DCLR_ID   AS 신고인부호,
        M.DCLR_NM   AS 관세사명
FROM    UNI_CART C, UNI_MEMBER M
WHERE   C.DCLR_ID=M.DCLR_ID --기본키 외래키 JOIN
ORDER BY 1;
        
--ANSI 표준
SELECT  C.EXP_DEC_NO   AS 수출신고번호,
        C.GDS_ID    AS 품목코드,
        C.EXP_QTY   AS 신고수량,
        M.DCLR_ID   AS 신고인부호,
        M.DCLR_NM   AS 관세사명
FROM    UNI_CART C
INNER JOIN  UNI_MEMBER M
        ON  (C.DCLR_ID=M.DCLR_ID)
ORDER BY 1;








