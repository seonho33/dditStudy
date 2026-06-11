2025-1103-01 사용자 생성과 권한 부여

1) 사용자 생성
  - CREATE user 명령 사용
  (사용형식)
  create user 사용자명 IDENTIFIED BY 암호;
  
  ALTer SESSION SET "_ORACLE_SCRIPT"=TRUE;
  
  create user TestBoard IDENTIFIED BY java;
  
** 오라클 12ver부터 사용자 계정명 앞에 C##을 붙여야 함
   C##을 사용하지 않고 사용자를 생성하려면 SESSION 을 변경해야함
   즉, 사용자 생성 전에
   ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; 를 먼저 실행 해야함
   
    사용예
    ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
    
    CREATE USER DSH9603 IDENTIFIED BY java;

    
2) 권한부여
   - GRANT 명령으로 허용된 권한을 부여 + 권한명,롤
   - revoke 로 부여된 권한을 회수
   - 오라클 계정이 생성되면 자동으로 부여되는 DEFAULT 롤은 CONNECT,Resource,DBA
사용 형식
    GRANT 권한명|롤명,... to 계정명
    GRANT CONNECT,Resource,DBA to DSH9603
    
    GRANT CONNECT, RESOURCE, DBA TO TestBoard