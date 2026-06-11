create sequence yj_seq;

drop sequence yj_seq;


select yj_seq.nextval from dual;
select yj_seq.currval from dual;
commit