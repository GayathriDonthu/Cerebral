<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Methods</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="methods pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
  <ul>
    <li><a href="#evict">evict</a></li>
    <li><a href="#replicate">Replicate</a></li>
    <li><a href="#flush">flush</a></li>
    <li><a href="#refresh">Refresh</a></li>
    <li><a href="#clear">Clear</a></li>
    <li><a href="#contains">Contains</a></li>
    <li><a href="#disconnect">Disconnect</a></li>
    <li><a href="#reconnect">Reconnect</a></li>
    <li><a href="#getIdentifier">GetIdentifier</a></li>
    <li><a href="#isOpen">IsOpen</a></li>
  </ul>
  <h4><a id="evict"/>Evict</h4>
    <ul>
      <li>Changes the object from Persistent state to Detached state.</li>
      <li>evict() method will remove object from session so object will become detached.</li>
      <li>evict() will remove object from session. delete() will remove from session and DB</li>
    </ul>
  <ul>
    <li>Test Method. If we change any value in loaded object and commit then update query will be
        executed on that object. In below example since object is in detached state by calling evict()
        update query is not executed.
      <pre>
public void evict(){
 Session session = HibernateUtil.newSession();
 Student student = (Student) session.get(Student.class, 1);
 session.evict(student);
 session.beginTransaction();
 student.setName("nameUpdated");
 session.getTransaction().commit();
}
      </pre>
    </li>
    <li>Console output: No update query executed
    <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME 
as NAME0_0_ from hibernate.STUDENT student0_ where student0_.ID=?
    </pre>
    </li>
  </ul>
  <a id="replicate"/><fieldset>
    <legend>Replicate</legend>
    <ul>
    <li>Replicate is opposite to evict</li>
    <li>Replicate will make detached object state to persistent</li>
  </ul>
  </fieldset>
  
  <a id="flush"/><fieldset>
    <legend>Flush</legend>
    <ul>
      <li>Updates DB data with Session data. Synchronize db data with session data.</li>
      <li>flush will execute only update but not commit</li>
      <li>commit = flush() + commit()</li>
      <li>Example: If we have situation where we need to execute update query but commit is not needed. 
      Like if we want to perform DDL/DML queries then commit is not needed. Alter command does not need
      commit. In that case we can simply call flush() method.</li>
    </ul>
  </fieldset>
  <a id="refresh"/><fieldset>
    <legend>Refresh</legend>
    <ul>
      <li>Updates Session data with DB data</li>
      <li>Refresh will synchronize session data with db data</li>      
    </ul>
  </fieldset>
  <a id="clear"/><fieldset>
    <legend>Clear</legend>
    <ul>
      <li>Removes all objects from session.</li>
      <li>Evict will remove only one object from session where as clear() will remove all
      objects from session</li>
    </ul>
  </fieldset>
  <a id="contains"/><fieldset>
    <legend>Contains</legend>
    <ul>
      <li>If the object is in session then contains method will return true</li>
      <li>That means if object is in persistent state then contains method will return true</li>
    </ul>
  </fieldset>  
  <a id="disconnect"/><fieldset>
    <legend>Disconnect</legend>
    <ul>
    <li>Used to disconnect session from current JDBC Connection</li>
  </ul>
  </fieldset>  
  <a id="reconnect"/><fieldset>
    <legend>Reconnect</legend>
    <ul>
    <li>Used to reconnect session with existing connection</li>
    </ul>
  </fieldset>
  <a id="getIdentifier"/><fieldset>
    <legend>GetIdentifier</legend>
    <ul>
    <li>Used to get the identifier of a pojo</li>
    </ul>
  </fieldset>
  <a id="isOpen"/><fieldset>
    <legend>IsOpen</legend>
    <ul>
    <li>Used to check whether session is still open or closed</li>
  </ul>
  </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
