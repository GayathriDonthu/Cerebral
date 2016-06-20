<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Advantages</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="advantages pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Advantages of Hibernate</h4>
  <ul>
    <li>Hibernate is ORM(Objecte Relation Mapping) tool</li>
    <li>Hibernate provides Connection Pooling</li>
    <li>Provides 2 types of caching - First Level Cache, Second Level Cache and Query Cache</li>
    <li>Database independent - No need to worry about underlying database</li>
    <li>No need to write SQL queries - We can query directly using objects for Example HQL. 
    We will build database queries for example Criteria</li>
    <li>Query Tuning is not needed. Hibernate criteria will generate good tuned queries</li>
    <li>Development is faster. Maintenance is easy</li>
    <li>Load objects on call using lazy concept</li>
    <li>Supports versioning. How many times changes are done on a record can be maintained using
    Hibernate versioning</li>
    <li>Supports Time stamping</li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
