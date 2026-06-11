--create table board
create table board(
    board_no number(8) not null,
    title varchar(200) not null,
    content varchar2(4000) not null,
    writer varchar2(50) not null,
    reg_date date default sysdate null,
    constraint pk_board primary key(board_no)
    );
create sequence seq_board increment by 1 start with 1 nocache;

-- create table member
create table member(
    user_no number(8) not null,
    user_id varchar2(200) not null,
    user_pw varchar2(500) not null,
    user_name varchar2(100) not null,
    reg_date date default sysdate null,
    upd_date date default sysdate null,
    enabled varchar2(2) default '1' null,
    constraint pk_member primary key(user_no)
    );
create sequence seq_member increment by 1 start with 1 nocache;

-- create table member_auth
create table member_auth(
    user_no number(8) not null,
    auth varchar2(50) not null,
    constraint fk_member_auth_user_no foreign key(user_no)
    references member (user_no)
    );
