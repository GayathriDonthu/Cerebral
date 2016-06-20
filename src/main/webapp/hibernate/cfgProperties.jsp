<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>cfg file properties</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="cfgProperties pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Different ways to configure properties</h4>
  <ul>
    <li>hibernate.cfg.xml</li>
    <li>hibernate.properties</li>
    <li>Programming way
      <pre>
sessionFactory = new AnnotationConfiguration()
                .addPackage("test.animals") //the fully qualified package name
                .addAnnotatedClass(Flight.class)
                .addAnnotatedClass(Sky.class)
                .addAnnotatedClass(Person.class)
                .addAnnotatedClass(Dog.class)
                .addResource("test/animals/orm.xml")
                .configure()
                .buildSessionFactory();
      </pre>
    </li>
  </ul>
  <h4>hibernate.cfg.xml file</h4>
  <ul>
    <li>cfg file will be converted into org.hibernate.cfg.Configuration using dom4j parsers.</li>
    <li>Configuration class uses Environment class for the properties in cfg fle.</li>
  </ul>
    <pre>
&lt;hibernate-configuration&gt;
 &lt;session-factory&gt;
    &lt;property name="hbm2ddl.auto"&gt;update&lt;/property&gt;
    &lt;property name="dialect"&gt;org.hibernate.dialect.OracleDialect&lt;/property&gt;
    &lt;property name="connection.url"&gt;jdbc:oracle:thin:@localhost:1521:icp&lt;/property&gt;
    &lt;property name="connection.username"&gt;hibernate&lt;/property&gt;
    &lt;property name="connection.password"&gt;hibernate&lt;/property&gt;
    &lt;property name="connection.driver_class"&gt;oracle.jdbc.driver.OracleDriver&lt;/property&gt;
    &lt;property name="myeclipse.connection.profile"&gt;Oracle Thin Driver&lt;/property&gt;
    &lt;property name="show_sql"&gt;true&lt;/property&gt;
    &lt;property name="connection.pool_size"&gt;10&lt;/property&gt;
    &lt;property name="hibernate.id.new_generator_mappings"&gt;true&lt;/property&gt;
    
    &lt;!-- To enable second level caching --&gt;
    &lt;property name="cache.use_second_level_cache"&gt;true&lt;/property&gt;
    &lt;property name="cache.provider_class"&gt;org.hibernate.cache.EhCacheProvider&lt;/property&gt;
    &lt;property name="hibernate.cache.region.factory_class"&gt;
      org.hibernate.cache.ehcache.EhCacheRegionFactory&lt;/property&gt;
    
    &lt;!-- Enable Query caching --&gt;
    &lt;property name="cache.use_query_cache"&gt;true&lt;/property&gt;
    
    &lt;!-- To enable batch processing --&gt;
    &lt;property name="jdbc.batch_size"&gt;100&lt;/property&gt;
    
    &lt;mapping class="com.hibernate.pojo.Student"&gt;&lt;/mapping&gt;
 &lt;/session-factory&gt;
&lt;hibernate-configuration&gt;
    </pre>
    <h4>cfg file properties - Refer org.hibernate.cfg.Environment class for the properties in cfg file.</h4>
    <table>
      <tr>
        <td>hbm2ddl.auto</td>
        <td>If value is create then every time hibernate will drop and recreate the table. Hibernate
        will recreate the table when we are reading the configuration file. If value
        is update then hibenate will check whether table existed or not. If table does not exist then
        hibernate will create the table.</td>
      </tr>
      <tr>
        <td>dialect</td>
        <td>dialect is used to identify to which data base we are trying to connect</td>
      </tr>
      <tr>
        <td>connection.url</td>
        <td>Url to connect to DB</td>
      </tr>
      <tr>
        <td>connection.username</td>
        <td>Username of schema to which we want to connect</td>
      </tr>
      <tr>
        <td>connection.password</td>
        <td>Password of schema</td>
      </tr>
      <tr>
        <td>connection.driver_class</td>
        <td>Driver class name</td>
      </tr>
      <tr>
        <td>show_sql</td>
        <td>To see queries in console or log4j</td>
      </tr>
      <tr>
        <td>connection.pool_size</td>
        <td>Used to specify pool size. Whenever SessionFactory is created it will 
        be ready with some pool of session objects.</td>
      </tr>
      <tr>
        <td>hibernate.id.new_generator_mappings</td>
        <td>true or false. Setting which indicates whether or not the new IdentifierGenerator 
        implementations are used for AUTO, TABLE and SEQUENCE. Default to false to keep backward compatibility.
        </td>
      </tr>
      <tr>
        <td>cache.use_second_level_cache</td>
        <td>To enable second level caching. If we set false then second level cache will be disabled</td>
      </tr>
      <tr>
        <td>cache.provider_class</td>
        <td>Provider Class which provides caching</td>
      </tr>
      <tr>
        <td>hibernate.cache.region.factory_class</td>
        <td>A factory class for initializing and terminating second level caching. It has start() and stop() method.
        <p>
        <b>start():</b>Lifecycle callback to perform necessary initialization of the underlying cache implementation(s).
        </p>
        <p>
        <b>stop():</b>Lifecycle callback to perform any necessary cleanup of the underlying cache implementation(s).
        </p>
        </td>
      </tr>
      <tr>
        <td>cache.use_query_cache</td>
        <td>To enable query caching</td>
      </tr>
      <tr>
        <td>jdbc.batch_size</td>
        <td>While doing batch processing, these many objects will be flushed to database at a time and then 
        session will be cleared. Refer 
        <a href="batchProcessing.jsp">Batch Processing</a> for example.
        </td>
      </tr>
      <tr>
        <td>mapping class</td>
        <td>Used to map class/pojo which we use as Entity or used to store in DB.</td>
      </tr>
    </table>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
