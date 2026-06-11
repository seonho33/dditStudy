-- (VO자동완성)컬럼명 -> 카멜케이스 변환
SELECT 
    ' private '||
    DECODE( DATA_TYPE , 'NUMBER', 'int ', 'String ' ) ||
    CASE 
        WHEN INSTR(column_name, '_') > 0 THEN
            REPLACE(LOWER(SUBSTR(column_name, 1, INSTR(column_name, '_') - 1)), '_', '') ||
            INITCAP(SUBSTR(column_name, INSTR(column_name, '_') + 1))
        ELSE
            LOWER(column_name)
    END
    ||';'
FROM COLS
WHERE TABLE_NAME = 'NOTICECOMMENT'
ORDER BY COLUMN_ID;

		select
			cmt_no,	bo_no,	cmt_writer, 
			cmt_content,	cmt_group,	cmt_ord, 
			cmt_depth,		cmt_date,	cmt_status,
			(select mem_profileimg from noticemember nm where	nc.cmt_writer = nm.mem_id) as mem_profileimg
		from	noticecomment nc
		where	bo_no = 17;
        
        select mem_id, mem_profileimg from noticemember nm;