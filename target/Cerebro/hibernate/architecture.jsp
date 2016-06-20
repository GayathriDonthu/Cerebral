<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Architecture</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="architecture pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>Architecture</h4>
    <img src="images/hibernateArchitecture.jpg" alt="Hibernate Architecture"/>
    <fieldset>
      <legend>SessionFactory</legend>
      SessionFactory is a singleton instance which implements Factory design pattern. 
      SessionFactory loads hibernate.cfg.xml file (Hibernate configuration file. More details in following section) 
      and with the help of TransactionFactory and ConnectionProvider implements all the configuration settings 
      on a database. A thread-safe, immutable cache of compiled mappings for a single database. 
      A factory for org.hibernate.Session instances. A client of org.hibernate.connection.ConnectionProvider.
      Optionally maintains a second level cache of data that is reusable between transactions at a process or cluster level.
    </fieldset>
    <fieldset>
      <legend>Session</legend>
      A single-threaded, short-lived object representing a conversation between the application and the persistent store. 
      Wraps a JDBC java.sql.Connection. Factory for org.hibernate.Transaction. 
      Maintains a first level cache of persistent the application persistent objects and collections.
      This cache is used when navigating the object graph or looking up objects by identifier.
    </fieldset>
    <fieldset>
      <legend>Persistent Object</legend>
      Short-lived, single threaded objects containing persistent state and business function.
      These can be ordinary JavaBeans/POJOs. They are associated with exactly one org.hibernate.Session. 
      Once the org.hibernate.Session is closed, they will be detached and free to use in any application layer 
      (for example, directly as data transfer objects to and from presentation)
    </fieldset>
    <fieldset>
      <legend>Transaction</legend>
      A single-threaded, short-lived object used by the application to specify atomic units of work.
      It abstracts the application from the underlying JDBC, JTA or CORBA transaction.
      A org.hibernate.Session might span several org.hibernate.Transactions in some cases.
    </fieldset>
    <fieldset>
      <legend>ConnectionProvider</legend>
      A factory for, and pool of, JDBC connections.
      It abstracts the application from underlying javax.sql.DataSource or java.sql.DriverManager.
      It is not exposed to application, but it can be extended and/or implemented by the developer.
    </fieldset>
    <fieldset>
      <legend>TransactionFactory</legend>
      A factory for org.hibernate.Transaction instances.
      It is not exposed to the application, but it can be extended and/or implemented by the developer.
    </fieldset>
    <h4>Object Life Cycle</h4>
    <img src="images/hibernateObjectLifecycle.jpg" alt="Object Lifecycle"/>
    <p/>
    <img src="images/object-states.jpg" alt="Object States"/>
    <fieldset>
      <legend>Transient Object</legend>
      An object is transient if it has just been instantiated using the new operator, and 
      it is not associated with a Hibernate Session. 
      It has no persistent representation in the database and no identifier value has been assigned.
    </fieldset>
    <fieldset>
      <legend>Persistence Object</legend>
      Object is associated with session, and it has persistent representation in database.
    </fieldset>
    <fieldset>
      <legend>Detached</legend>
      Object is not associated with Hibernate session, but persistent representation in database. 
    </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
