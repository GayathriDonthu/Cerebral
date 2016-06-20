<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Immutable Objects</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="immutableObjects pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <pre>
The following rules define a simple strategy for creating immutable objects. 
Not all classes documented as "immutable" follow these rules. 
This does not necessarily mean the creators of these classes were sloppy — 
they may have good reason for believing that instances of their classes never change after construction. 
However, such strategies require sophisticated analysis and are not for beginners.

Don't provide "setter" methods — methods that modify fields or objects referred to by fields.
Make all fields final and private.
Don't allow subclasses to override methods. The simplest way to do this is to declare the class as final. 
A more sophisticated approach is to make the constructor private and construct instances in factory methods.
If the instance fields include references to mutable objects, don't allow those objects to be changed:
Don't provide methods that modify the mutable objects.
Don't share references to the mutable objects. Never store references to external, 
mutable objects passed to the constructor; if necessary, create copies, and store references to the copies. 
Similarly, create copies of your internal mutable objects when necessary to avoid returning the originals in your methods.  
  </pre>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
