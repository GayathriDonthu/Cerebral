<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Questions</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="css/global.css"/>
  </head>
  <body id="questions">
  <jsp:include page="header.jsp"></jsp:include>
  <div class="examples">
    <h4>Hibernate</h4>
    <ul>
      <li>Where we need to use flush() method.
        <pre>If we want to use DDL in Hibernate like creating table. For DDLs commit() is not required. In this
        case we can use flush().</pre>
        <pre>
          In the case of Batch Inserts and Batch Updates we can see effective usage of flush() method.
        </pre>
      </li>
      <li>How Confiuration, SessionFactory, Session objects are managed</li>
      <li>How to assign property values of cfg programmetically</li>
      <li>Where Table Generator will be used in real time</li>
      <li>If procedure returns - Cursor, how to handle list of records in Hibernate</li>
      <li>If return type of procedure/function is list of user defined objects, how to assign them to list at java side</li>
    </ul>
  </div>
  <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>
