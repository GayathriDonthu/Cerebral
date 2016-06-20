<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Property lazy load</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="propertyLazyLoad pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <pre>
@Basic(fetch = FetchType.LAZY)
String getDetailedComment() { ... } // persistent property
  </pre>
  <pre>
To enable property level lazy fetching, your classes have to be instrumented: 
bytecode is added to the original class to enable such feature, 
please refer to the Hibernate reference documentation. If your classes are not instrumented, 
property level lazy loading is silently ignored.  
  </pre>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
