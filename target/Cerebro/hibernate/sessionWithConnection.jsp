<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Session using Connection</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="sessionWithCon pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>Creating Session with Connection</h4>
    <ul>
      <li>cfg file - we dont have Driver, URL, username and password in cfg file. File name - hibernate.cfg2.xml
      <pre>
&lt;hibernate-configuration>
    &lt;session-factory>
        &lt;property name="hbm2ddl.auto"&gt;update&lt;/property&gt;
        &lt;property name="dialect"&gt;org.hibernate.dialect.OracleDialect&lt;/property&gt;
        &lt;property name="myeclipse.connection.profile"&gt;Oracle Thin Driver&lt;/property&gt;
        &lt;property name="show_sql"&gt;true&lt;/property&gt;
        &lt;property name="connection.pool_size"&gt;10&lt;/property&gt;
        &lt;mapping class="com.hibernate.pojo.Student"&gt;&lt;/mapping&gt;
    &lt;/session-factory&gt;

&lt;/hibernate-configuration&gt;
      </pre>
      </li>
      <li>Creating SessionFactory Object
        <pre>
public static SessionFactory getSessionFactory(String configFileName){
    Configuration configuration = new AnnotationConfiguration().configure(configFileName);
    return configuration.buildSessionFactory();
  }
        </pre>
      </li>
      <li>Test Class
        <pre>
public void save() throws ClassNotFoundException, SQLException{
    Class.forName(OracleDriver.class.getName());
    Connection connection = DriverManager.getConnection
            ("jdbc:oracle:thin:@localhost:1521:icp", "hibernate", "hibernate");
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory("hibernate.cfg2.xml");
    Session session = sessionFactory.openSession(connection);
    Student student = new Student();
    student.setID(10);
    student.setName("name10");
    student.setCourse("course10");
    session.beginTransaction();
    session.save(student);
    session.getTransaction().commit();
}
        </pre>
      </li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
