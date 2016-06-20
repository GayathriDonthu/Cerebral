<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Create Schema</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="createUser pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Create Schema and Grant Permissions to use the schema</h4>
      <ul>
        <li>Open SQL plus and log in as &quot;/ as sysdba&quot;. You need to have admin permissions for this.</li>
        <li>After log in
          <pre>
create user test_user identified by test;
grant resource, connect to test_user;
conn test_user/test
select user from dual;  
          </pre>
        </li>
        <li>See the screen shot below:
        <img src="images/createUser.jpg" alt="Create User"/>
        </li>
        <li>Drop schema - CASCADE is for deleting objects/tables present in that schema.
          <pre>
DROP USER TEST_USER CASCADE;
          </pre>
        </li>
      </ul>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
