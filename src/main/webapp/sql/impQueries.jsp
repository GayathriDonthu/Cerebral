<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Imprtant Queries</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="impQueries pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Important Queries</h4>
  <ul>
    <li>To Save current session's sql commands to a file
      <pre>spool path\filename.extension</pre>
    </li>
    <li>Above file will be saved when we run following query
      <pre>spool off</pre>
    </li>
    <li>To append to the same file
      <pre>spool path\filename.extension append</pre>
    </li>
    <li>To format the number to display in sqlplus window
      <pre>column columnName FORMAT 999...9</pre>
    </li>
    <li>To format varchar to display in sqlplus window. Ax == where x is number of characters
      <pre>column columnName FORMAT A5</pre>
    </li>
    <li>To execute sql file
      <pre>@"path\filename".sql</pre>
    </li>
    <li>To get list of all tables present in current user
      <pre>SELECT OWNER, TABLE_NAME FROM DBA_TABLES;</pre>
    </li>
    <li>If we dont have access to DBA_TABLES, we can use below query
      <pre>SELECT OWNER, TABLE_NAME FROM ALL_TABLES;</pre>
    </li>
    <li>To get list of all user created tables
      <pre>SELECT TABLE_NAME FROM USER_TABLES;</pre>
    </li>
    <li>How to see existing schemas in database. Login as &quot;/ as sysdba&quot;. Password is not needed.
      <pre>SELECT USERNAME FROM ALL_USERS;</pre>
    </li>
    <li>How to change password of a schema. Login as &quot;/ as sysdba&quot;. Password is not needed.
      <pre>alter user &lt;schema-name&gt; identified by &lt;new-password&gt;</pre>
    </li>
    <li>How to add column to table
      <pre>alter table table_name add column_name column_data_type;</pre>
    </li>
    <li>How to drop column from table
      <pre>alter table table_name drop column column_name;</pre>
    </li>
    <li>How to check columns across the tables in a schema
      <pre>
select table_name, column_name, data_length from user_tab_columns where column_name like '%NAME%';      
      </pre>
    </li>
    <li>How to find different user objects information.
    <pre>
SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS

select distinct object_type from user_objects

SELECT COUNT(*) FROM USER_OBJECTS WHERE OBJECT_TYPE LIKE 'TABLE'

select count(*) from user_objects where object_type like 'SEQUENCE'

select count(*) From user_objects where object_type like 'VIEW'

select count(*) From user_objects where object_type like 'PROCEDURE'

select count(*) From user_objects where object_type like 'FUNCTION'

select count(*) From user_objects where object_type like 'JOB'    
    </pre>
    </li>
    <li>Row count in each table
    <pre>
select
table_name,
to_number(
extractvalue(
xmltype(
dbms_xmlgen.getxml('select count(*) c from '||table_name)
),'/ROWSET/ROW/C')) count
from user_tables order by 1;    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
