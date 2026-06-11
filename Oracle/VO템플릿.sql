
/*-------------------------------------------------------------------------------*/
/*----  DB 컬럼정보를 활용하여 VO 필드 및 MyBatis  ResultMap 정보 생성하기 -----------*/
/*-------------------------------------------------------------------------------*/
SELECT A.COLUMN_NAME
, A.DATA_TYPE
, CASE WHEN A.DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(A.COLUMN_NAME) || ';' || ' /* ' || B.COMMENTS || ' */'
WHEN A.DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(A.COLUMN_NAME) || ';' || ' /* ' || B.COMMENTS || ' */'
WHEN A.DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(A.COLUMN_NAME) || ';' || ' /* ' || B.COMMENTS || ' */'
ELSE 'private String ' || FN_GETCAMEL(A.COLUMN_NAME) || ';' || ' /* ' || B.COMMENTS || ' */'
END AS JAVA_FIELD
, A.COLUMN_NAME || ',' as insert_columns
,'#{' || FN_GETCAMEL(A.COLUMN_NAME) || '},' as insert_values
, '<result property="'||FN_GETCAMEL(A.COLUMN_NAME)||'" column="'||A.COLUMN_NAME||'"/>' RESULTMAP
FROM USER_TAB_COLUMNS A LEFT OUTER JOIN USER_COL_COMMENTS B ON  A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
WHERE A.TABLE_NAME = 'ATCH_FILE';


		SELECT  *
		FROM    ATCH_FILE A, ATCH_FILE_DETAIL B
		WHERE	A.ATCH_FILE_ID = B.ATCH_FILE_ID
		AND 	A.ATCH_FILE_ID = 122

SELECT BANNER FROM V$VERSION;