<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Sequence</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="uniqueConstraint pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <pre>
CREATE SEQUENCE
S_SAME_PROVIDER_DEFINITION
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
CACHE 20
NOORDER;
</pre>
</div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
