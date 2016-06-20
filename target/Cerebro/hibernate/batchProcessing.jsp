<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Batch Processing</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="batchProcessing pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub-Topics</h4>
  <ul>
    <li><a href="#inserts">Batch Inserts</a></li>
    <li><a href="#updates">Batch Updates</a></li>
    <li><a href="#statelessSessions">Stateless sessions</a></li>
    <li>
    <a href="https://docs.jboss.org/hibernate/orm/4.0/devguide/en-US/html/ch04.html" target="_blank">more>></a>
    </li>
  </ul>
  <a id="inserts"/><h4>Batch Inserts</h4>
  <ul>
    <li><b>Why:</b>If we are inserting 1 million records in the database we might get OutOfMemoryException. 
    The reason is that Hibernate caches all the newly inserted Customer instances in the session-level cache.
    Use Batch Inserts to avoid this problem.</li>
    <li>Make following changes in cfg.xml file. We can give any integer based on our heap memory.
    <pre>
&lt;!-- To enable batch processing --&gt;
&lt;property name="jdbc.batch_size"&gt;100&lt;/property&gt;   
    </pre>
    </li>
    <li>Test method. When you make new objects persistent, use methods flush() and clear()
    to the session regularly, to control the size of the first-level cache.
    <pre>
public void test() {
  Session session = HibernateSessionFactory.openSession();
  Student student;
  session.beginTransaction();
  for (int i = 0; i < 100000; i++) {
      student = new Student();
      student.setName("name" + i);
      session.save(student);
      if (i % 100 == 0) {
    session.flush();
    session.clear();
      }
  }
  session.getTransaction().commit();
  session.close();
}    
    </pre>
    </li>
  </ul>
  <a id="updates"/><h4>Batch Updates</h4>
  <ul>
    <li>When you retriev and update data, flush() and clear() the session regularly. 
    In addition, use method scroll() to take advantage of server-side cursors for queries 
    that return many rows of data.</li>
    <li>
    <pre>
Session session = sessionFactory.openSession();
Transaction tx = session.beginTransaction();
   
ScrollableResults customers = session.getNamedQuery("GetCustomers")
    .setCacheMode(CacheMode.IGNORE)
    .scroll(ScrollMode.FORWARD_ONLY);
int count=0;
while ( customers.next() ) {
    Customer customer = (Customer) customers.get(0);
    customer.updateStuff(...);
    if ( ++count % 20 == 0 ) {
        //flush a batch of updates and release memory:
        session.flush();
        session.clear();
    }
}
   
tx.commit();
session.close();    
    </pre>
    </li>
  </ul>
  <a id="statelessSessions"/><h4>Stateless Sessions</h4>
  <fieldset>
    <legend>Definition</legend>
    StatelessSession is a command-oriented API provided by Hibernate. Use it to stream data 
    to and from the database in the form of detached objects. A StatelessSession has no persistence 
    context associated with it and does not provide many of the higher-level life cycle semantics. 
    Some of the things not provided by a StatelessSession include:
    <p>Features and behaviors not provided by StatelessSession</p>
    <ul>
      <li> first-level cache</li>
      <li>interaction with any second-level or query cache</li>
      <li>transactional write-behind or automatic dirty checking</li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>Limitations</legend>
    <ul>
      <li>Operations performed using a stateless session never cascade to associated instances.</li>
      <li>Collections are ignored by a stateless session.</li>
      <li>Operations performed via a stateless session bypass Hibernate's event model and interceptors.</li>
      <li>Due to the lack of a first-level cache, Stateless sessions are vulnerable to data aliasing effects.</li>
      <li>A stateless session is a lower-level abstraction that is much closer to the underlying JDBC.</li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>Note</legend>
    The insert(), update(), and delete() operations defined by the StatelessSession interface operate directly 
    on database rows. They cause the corresponding SQL operations to be executed immediately. 
    They have different semantics from the save(), saveOrUpdate(), and delete() operations defined by the 
    Session interface.
  </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
