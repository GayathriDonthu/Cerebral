<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Table and Pojo Creation</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="icpHome">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>Table Creation</h4>
    <ul>
      <li>Put Create table scripts, Sequence scripts in coderepository_xxx.sql files for Both Oracle and SQL Server</li>
      <li>Make entries in populate_testing_metadata.sql for Oracle/SQL Server. If table has check constrain
      we need to make some more entries. Refer end of the file, you will understand.</li>
      <li>To insert test data while runnint refreshdb in the new table, make entry in populate_kb_testdata.sql file</li>
    </ul>
    <h4>Pojo Creation</h4>
    <ul>
      <li>Create an Interface</li>
      <li>Create respective Impl class</li>
      <li>Create HibernateTest class</li>
      <li>Make entry in respective Factory class</li>
      <li>Make entry in apollo.cfg.xml</li>
      <li>Make entry in apollo_standalone.cfg.xml</li>
      <li>Make entry in framework.factory.properties file</li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
