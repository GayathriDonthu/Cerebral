<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Reusable Code</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="reusableCode pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    
    
    <h3>How to create different objects</h3>
    <ul>
      <li>Creating Configuration object, if we are using hbm file:
        <pre>
Configuration configuration = new Configuration().configure();      
        </pre>
      </li>
      <li>Creating AnnotationConfiguration object, if we are using annotation:
        <pre>
AnnotationConfiguration configuration = new AnnotationConfiguration().configure();        
        </pre>
      </li>
      <li>We have 5 overloaded configure() methods:
      <p><img src="images/overloaded_configure_method.jpg" alt="Overloaded configure() method"/></p>
      </li>
      <li>Creating SessionFactory object
      <pre>
AnnotationConfiguration configuration = new AnnotationConfiguration().configure();
SessionFactory sessionFactory = configuration.buildSessionFactory();      
      </pre>
      </li>
      <li>Creating Session object
      <pre>
AnnotationConfiguration configuration = new AnnotationConfiguration().configure();
SessionFactory sessionFactory = configuration.buildSessionFactory();
Session session = sessionFactory.openSession();      
      </pre>
      </li>
      <li>How to close session object
      <pre>
session.close();      
      </pre>
      </li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
