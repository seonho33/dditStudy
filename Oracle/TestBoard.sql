CREATE TABLE "QNA" (
	"qna_id"	NUMBER		NOT NULL,
	"qna_title"	VARCHAR2(300)		NOT NULL,
	"qna_content"	VARCHAR2(500)		NOT NULL,
	"answer_content"	VARCHAR2(1000)		NULL,
	"status_yn"	VARCHAR2(20)		NOT NULL,
	"secret_yn"	CHAR(1)		NOT NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"answer_date"	TIMESTAMP		NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "QNA"."answer_content" IS '관리자답변내용';

COMMENT ON COLUMN "QNA"."status_yn" IS '상태(접수,완료)';

COMMENT ON COLUMN "QNA"."secret_yn" IS '비밀글여부(Y,N)';

COMMENT ON COLUMN "QNA"."create_date" IS '등록일자';

CREATE TABLE "USER_REVIEW" (
	"review_id"	number(19)		NOT NULL,
	"update_date"	TIMESTAMP		NOT NULL,
	"review"	varchar2(255)		NOT NULL,
	"review_picture"	varchar2(500)		NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"reserv_id"	NUMBER		NOT NULL,
	"pay_no"	number		NOT NULL
);

COMMENT ON COLUMN "USER_REVIEW"."pay_no" IS '결제고유번호';

CREATE TABLE "ROLE" (
	"role_key"	NUMBER		NOT NULL,
	"role_name"	VARCHAR(50)	DEFAULT '일반관리자'	NOT NULL
);

CREATE TABLE "DETAILED_FUNCTIONS" (
	"mapping_key"	NUMBER		NOT NULL,
	"can_manage_user"	VARCHAR2(50)		NOT NULL,
	"can_manage_blacklist"	VARCHAR2(50)		NOT NULL,
	"can_manage_community"	VARCHAR2(50)		NOT NULL,
	"can_manage_qna"	VARCHAR2(50)		NOT NULL,
	"can_manage_gs25"	VARCHAR2(50)		NOT NULL,
	"can_manage_chatbot"	VARCHAR2(50)		NOT NULL,
	"role_key"	NUMBER		NOT NULL
);

CREATE TABLE "STORE" (
	"store_id"	varchar2(50)		NOT NULL,
	"store_name"	varchar2(255)		NOT NULL,
	"store_addr"	varchar2(255)		NOT NULL,
	"store_picture"	varchar2(500)		NULL,
	"store_phone"	varchar2(20)		NOT NULL,
	"store_content"	varchar2(255)		NULL,
	"closed_day"	varchar2(255)		NULL,
	"operation_hours"	varchar2(255)		NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"rating"	NUMBER		NOT NULL,
	"dibs_count"	NUMBER		NOT NULL,
	"review_count"	NUMBER		NOT NULL,
	"status"	varchar2(255)		NOT NULL,
	"category"	varchar2(100)		NULL,
	"biz_no"	varchar2(20)		NOT NULL,
	"owner_email"	varchar2(100)		NOT NULL,
	"deposit"	NUMBER	DEFAULT 0	NOT NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "STORE"."store_content" IS '가게소개글';

CREATE TABLE "NOTICE" (
	"notice_no"	number		NOT NULL,
	"notice_title"	varchar2(200)		NOT NULL,
	"notice_coment"	VARCHAR2(500)		NULL,
	"notice_content"	VARCHAR2(1000)		NOT NULL,
	"hit_count"	NUMBER		NOT NULL,
	"top_yn"	CHAR(1)		NOT NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"update_date"	TIMESTAMP		NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "NOTICE"."notice_no" IS '공지사항 글번호';

COMMENT ON COLUMN "NOTICE"."notice_title" IS '공지사항 제목';

COMMENT ON COLUMN "NOTICE"."notice_coment" IS '공지사항 댓글';

COMMENT ON COLUMN "NOTICE"."notice_content" IS '공지사항 내용';

COMMENT ON COLUMN "NOTICE"."hit_count" IS '공지사항 조회수';

COMMENT ON COLUMN "NOTICE"."top_yn" IS '공지사항 상단고정여부(Y,N)';

COMMENT ON COLUMN "NOTICE"."create_date" IS '공지사항 작성일시';

COMMENT ON COLUMN "NOTICE"."update_date" IS '공지사항 수정일시';

CREATE TABLE "COUPON" (
	"coupon_id"	NUMBER		NOT NULL,
	"user_name"	varchar2(255)		NOT NULL,
	"coupon_content"	varchar2(255)		NULL,
	"deducted_price"	NUMBER		NOT NULL,
	"min_price"	NUMBER		NOT NULL,
	"create_date"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"expired_date"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"update_date"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"status"	varchar2(255)		NOT NULL,
	"store_id"	varchar2(50)		NOT NULL,
	"coupon_qty"	NUMBER		NULL
);

CREATE TABLE "USER_LIKES" (
	"user_id"	VARCHAR2(50)		NOT NULL,
	"store_id"	varchar(50)		NOT NULL,
	"status"	varchar(255)		NOT NULL
);

CREATE TABLE "USERS" (
	"user_id"	VARCHAR2(50)		NOT NULL,
	"password"	varchar2(255)		NOT NULL,
	"name"	varchar2(30)		NOT NULL,
	"division"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "USERS"."division" IS '일반회원,사장님,관리자';

CREATE TABLE "CEO_REVIEW" (
	"review_id"	number(19)		NOT NULL,
	"review"	varchar2(255)		NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"update_date"	TIMESTAMP		NOT NULL
);

CREATE TABLE "MEMBER" (
	"user_id"	VARCHAR2(50)		NOT NULL,
	"user_bir"	DATE		NULL,
	"user_mail"	varchar2(100)		NULL,
	"use_yn"	varchar2(1)		NOT NULL,
	"user_no"	varchar2(50)		NOT NULL,
	"block_yn"	varchar2(255)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."user_id" IS '이용자들 아이디';

COMMENT ON COLUMN "MEMBER"."user_bir" IS '이용자들 생년월일';

COMMENT ON COLUMN "MEMBER"."user_mail" IS '이용자들 이메일(비밀번호,ID찾기에 필요)';

COMMENT ON COLUMN "MEMBER"."use_yn" IS '탈퇴시,N으로표시';

COMMENT ON COLUMN "MEMBER"."user_no" IS '대덕사용자인지 확인용 기수번호';

COMMENT ON COLUMN "MEMBER"."block_yn" IS '차단된 사용자 여부(차단Y)';

CREATE TABLE "REFUND" (
	"refund_id"	NUMBER		NOT NULL,
	"refund_amount"	NUMBER		NOT NULL,
	"refund_reason"	VARCHAR2(500)		NULL,
	"refund_status"	VARCHAR2(20)		NOT NULL,
	"refund_date"	TIMESTAMP		NOT NULL,
	"pay_no"	number		NOT NULL
);

COMMENT ON COLUMN "REFUND"."pay_no" IS '결제고유번호';

CREATE TABLE "GS_PROMOTION" (
	"gs_id"	NUMBER		NOT NULL,
	"product_name"	VARCHAR2(200)		NOT NULL,
	"original_price"	NUMBER		NOT NULL,
	"discount_price"	NUMBER		NOT NULL,
	"discount_rate"	NUMBER		NULL,
	"product_image_url"	VARCHAR2(500)		NOT NULL,
	"product_content"	VARCHAR2(1000)		NULL,
	"end_time"	TIMESTAMP		NOT NULL,
	"stock_count"	NUMBER	DEFAULT 1	NOT NULL,
	"status_yn"	VARCHAR2(20)		NOT NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "GS_PROMOTION"."discount_rate" IS '할인율(계산값 저장)';

COMMENT ON COLUMN "GS_PROMOTION"."product_content" IS '상품 상세 설명';

COMMENT ON COLUMN "GS_PROMOTION"."end_time" IS '마감시간(할인 종료 일시)';

COMMENT ON COLUMN "GS_PROMOTION"."stock_count" IS '재고수량(기본값 1)';

COMMENT ON COLUMN "GS_PROMOTION"."status_yn" IS '상태(진행중Y, 마감N)';

CREATE TABLE "MENU" (
	"menu_id"	number		NOT NULL,
	"store_id"	varchar2(50)		NOT NULL,
	"menu_name"	varchar2(100)		NOT NULL,
	"menu_price"	number		NULL,
	"menu_picture"	varchar2(500)		NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"update_date"	TIMESTAMP		NOT NULL
);

CREATE TABLE "BLACKLIST" (
	"blacklist_id"	NUMBER		NOT NULL,
	"block_reason"	VARCHAR2(4000)		NOT NULL,
	"block_date"	TIMESTAMP		NOT NULL,
	"block_end_date"	TIMESTAMP		NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

CREATE TABLE "PAYMENT" (
	"pay_no"	number		NOT NULL,
	"reserv_no"	number		NOT NULL,
	"pay_method"	varchar2(20)		NOT NULL,
	"pay_amount"	number		NOT NULL,
	"pay_date"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"pay_update_date"	TIMESTAMP	DEFAULT SYSDATE	NULL,
	"pay_user_no"	number		NOT NULL,
	"refund_yn"	varchar2(1)	DEFAULT 'N'	NOT NULL,
	"pay_status"	varchar2(20)		NOT NULL
);

COMMENT ON COLUMN "PAYMENT"."pay_no" IS '결제고유번호';

COMMENT ON COLUMN "PAYMENT"."reserv_no" IS '예약번호';

COMMENT ON COLUMN "PAYMENT"."pay_method" IS '결제수단(카드,계좌이체등)';

COMMENT ON COLUMN "PAYMENT"."pay_amount" IS '결제금액';

COMMENT ON COLUMN "PAYMENT"."pay_date" IS '결제한 날짜';

COMMENT ON COLUMN "PAYMENT"."pay_update_date" IS '재결제한 날짜';

COMMENT ON COLUMN "PAYMENT"."pay_user_no" IS '결제회원번호';

COMMENT ON COLUMN "PAYMENT"."refund_yn" IS '환불여부(Y/N)';

COMMENT ON COLUMN "PAYMENT"."pay_status" IS '결제상태(결제완료,결제취소,결제중?등)';

CREATE TABLE "COUPONHAM" (
	"coupon_box_id"	NUMBER		NOT NULL,
	"use_yn"	VARCHAR2(10)		NOT NULL,
	"used_date"	TIMESTAMP		NULL,
	"issued_date"	TIMESTAMP		NOT NULL,
	"coupon_id"	NUMBER		NOT NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

CREATE TABLE "DIDS" (
	"user_id"	VARCHAR2(50)		NOT NULL,
	"store_id"	varchar(50)		NOT NULL,
	"create_date"	TIMESTAMP	DEFAULT SYSDATE	NOT NULL,
	"update_date"	TIMESTAMP		NOT NULL
);

CREATE TABLE "ADMIN" (
	"user_id"	VARCHAR2(50)		NOT NULL,
	"role_key"	VARCHAR2(50)	DEFAULT '일반관리자'	NOT NULL
);

COMMENT ON COLUMN "ADMIN"."role_key" IS '권한 별  키부여(일반관리자/상위관리자등급)';

CREATE TABLE "BOT" (
	"bot_id"	NUMBER		NOT NULL,
	"category_name"	VARCHAR2(100)		NOT NULL,
	"question_keyword"	VARCHAR2(300)		NOT NULL,
	"answer_content"	VARCHAR2(1000)		NOT NULL,
	"sort_order"	NUMBER		NOT NULL,
	"active_yn"	CHAR(1)		NOT NULL,
	"update_date"	TIMESTAMP		NOT NULL,
	"user_id"	VARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "BOT"."category_name" IS '질문카테고리';

COMMENT ON COLUMN "BOT"."question_keyword" IS '사용자에게 보여질 질문 문구';

COMMENT ON COLUMN "BOT"."answer_content" IS '봇의 자동 응답 내용';

COMMENT ON COLUMN "BOT"."sort_order" IS '추천/노출 순위(낮은 숫자 우선)';

COMMENT ON COLUMN "BOT"."active_yn" IS '활성화여부(Y,N)';

CREATE TABLE "RESERVATION" (
	"reserv_id"	NUMBER		NOT NULL,
	"guest_count"	NUMBER	DEFAULT 1	NOT NULL,
	"reserv_time"	TIMESTAMP		NOT NULL,
	"reserv_status"	varchar2(255)		NOT NULL,
	"note"	varchar2(500)		NULL,
	"create_date"	TIMESTAMP		NOT NULL,
	"user_id"	VARCHAR2(50)		NOT NULL,
	"store_id"	varchar2(50)		NOT NULL,
	"pay_no"	number		NOT NULL
);

COMMENT ON COLUMN "RESERVATION"."pay_no" IS '결제고유번호';

ALTER TABLE "QNA" ADD CONSTRAINT "PK_QNA" PRIMARY KEY (
	"qna_id"
);

ALTER TABLE "USER_REVIEW" ADD CONSTRAINT "PK_USER_REVIEW" PRIMARY KEY (
	"review_id"
);

ALTER TABLE "ROLE" ADD CONSTRAINT "PK_ROLE" PRIMARY KEY (
	"role_key"
);

ALTER TABLE "DETAILED_FUNCTIONS" ADD CONSTRAINT "PK_DETAILED_FUNCTIONS" PRIMARY KEY (
	"mapping_key"
);

ALTER TABLE "STORE" ADD CONSTRAINT "PK_STORE" PRIMARY KEY (
	"store_id"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY (
	"notice_no"
);

ALTER TABLE "COUPON" ADD CONSTRAINT "PK_COUPON" PRIMARY KEY (
	"coupon_id"
);

ALTER TABLE "USER_LIKES" ADD CONSTRAINT "PK_USER_LIKES" PRIMARY KEY (
	"user_id",
	"store_id"
);

ALTER TABLE "USERS" ADD CONSTRAINT "PK_USERS" PRIMARY KEY (
	"user_id"
);

ALTER TABLE "CEO_REVIEW" ADD CONSTRAINT "PK_CEO_REVIEW" PRIMARY KEY (
	"review_id"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"user_id"
);

ALTER TABLE "REFUND" ADD CONSTRAINT "PK_REFUND" PRIMARY KEY (
	"refund_id"
);

ALTER TABLE "GS_PROMOTION" ADD CONSTRAINT "PK_GS_PROMOTION" PRIMARY KEY (
	"gs_id"
);

ALTER TABLE "MENU" ADD CONSTRAINT "PK_MENU" PRIMARY KEY (
	"menu_id",
	"store_id"
);

ALTER TABLE "BLACKLIST" ADD CONSTRAINT "PK_BLACKLIST" PRIMARY KEY (
	"blacklist_id"
);

ALTER TABLE "PAYMENT" ADD CONSTRAINT "PK_PAYMENT" PRIMARY KEY (
	"pay_no"
);

ALTER TABLE "COUPONHAM" ADD CONSTRAINT "PK_COUPONHAM" PRIMARY KEY (
	"coupon_box_id"
);

ALTER TABLE "DIDS" ADD CONSTRAINT "PK_DIDS" PRIMARY KEY (
	"user_id",
	"store_id"
);

ALTER TABLE "ADMIN" ADD CONSTRAINT "PK_ADMIN" PRIMARY KEY (
	"user_id"
);

ALTER TABLE "BOT" ADD CONSTRAINT "PK_BOT" PRIMARY KEY (
	"bot_id"
);

ALTER TABLE "RESERVATION" ADD CONSTRAINT "PK_RESERVATION" PRIMARY KEY (
	"reserv_id"
);

ALTER TABLE "USER_LIKES" ADD CONSTRAINT "FK_MEMBER_TO_USER_LIKES_1" FOREIGN KEY (
	"user_id"
)
REFERENCES "MEMBER" (
	"user_id"
);

ALTER TABLE "USER_LIKES" ADD CONSTRAINT "FK_STORE_TO_USER_LIKES_1" FOREIGN KEY (
	"store_id"
)
REFERENCES "STORE" (
	"store_id"
);

ALTER TABLE "CEO_REVIEW" ADD CONSTRAINT "FK_USER_REVIEW_TO_CEO_REVIEW_1" FOREIGN KEY (
	"review_id"
)
REFERENCES "USER_REVIEW" (
	"review_id"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "FK_USERS_TO_MEMBER_1" FOREIGN KEY (
	"user_id"
)
REFERENCES "USERS" (
	"user_id"
);

ALTER TABLE "MENU" ADD CONSTRAINT "FK_STORE_TO_MENU_1" FOREIGN KEY (
	"store_id"
)
REFERENCES "STORE" (
	"store_id"
);

ALTER TABLE "DIDS" ADD CONSTRAINT "FK_MEMBER_TO_DIDS_1" FOREIGN KEY (
	"user_id"
)
REFERENCES "MEMBER" (
	"user_id"
);

ALTER TABLE "DIDS" ADD CONSTRAINT "FK_STORE_TO_DIDS_1" FOREIGN KEY (
	"store_id"
)
REFERENCES "STORE" (
	"store_id"
);

ALTER TABLE "ADMIN" ADD CONSTRAINT "FK_USERS_TO_ADMIN_1" FOREIGN KEY (
	"user_id"
)
REFERENCES "USERS" (
	"user_id"
);

