<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Merge Issue</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="merge pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
  <ul>
    <li><a href="#issue">Merge Issue</a></li>
    <li><a href="#solution">Merge Solution</a></li>
  </ul>
  <h4><a id="issue"/>Issue</h4>
  <ul>
    <li>If we have object with identifier in session then if we try to update then we will get an exception</li>
    <li>Test class
      <pre>
public void merge(){
    Session session = HibernateUtil.newSession();
    Student student1 = (Student) session.get(Student.class, 1);
    Student student2 = new Student();
    student2.setID(1);
    student2.setName("name1Updated");
    session.beginTransaction();
    session.update(student2);
    session.getTransaction().commit();
}
      </pre>
    </li>
    <li>Console output
      <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
Exception in thread "main" org.hibernate.NonUniqueObjectException: 
a different object with the same identifier value was already associated with the session: 
[com.hibernate.pojo.Student#1]
at org.hibernate.engine.StatefulPersistenceContext.checkUniqueness(StatefulPersistenceContext.java:613)
at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.performUpdate(DefaultSaveOrUpdateEventListener)
at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.entityIsDetached(DefaultSaveOrUpdateEventListe)
at org.hibernate.event.def.DefaultUpdateEventListener.performSaveOrUpdate(DefaultUpdateEventListener)
at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.onSaveOrUpdate(DefaultSaveOrUpdateEventListe)
at org.hibernate.impl.SessionImpl.fireUpdate(SessionImpl.java:592)
at org.hibernate.impl.SessionImpl.update(SessionImpl.java:580)
at org.hibernate.impl.SessionImpl.update(SessionImpl.java:572)
at com.hibernate.test.Merge.merge(Merge.java:30)
at com.hibernate.test.Merge.main(Merge.java:20)
      </pre>
    </li>
  </ul>
  <h4><a id="solution"/>Solution</h4>
  <ul>
    <li>Call merge instead of save/update/saveOrUpdate methods</li>
    <li>Test class
      <pre>
public void merge(){
    Session session = HibernateUtil.newSession();
    Student student1 = (Student) session.get(Student.class, 1);
    Student student2 = new Student();
    student2.setID(1);
    student2.setName("name1Updated");
    session.beginTransaction();
    session.merge(student2);
    session.getTransaction().commit();
}
      </pre>
    </li>
    <li>Table before merge
      <pre>
SQL> select * from student;

 ID NAME            COURSE
--- --------------- ----------
  0 name0           course0
  1 name1           course1
  2 name2           course2
  3 name3           course3
  4 name4           course4
  5 name5           course5
  6 name6           course6
  7 name7           course7
  8 name8           course8
  9 name9           course9
 10 name10          course10
      </pre>
    </li>
    <li>Table after merge
      <pre>
SQL> select * from student;

 ID NAME            COURSE
--- --------------- ----------
  0 name0           course0
  1 name1Updated    course1
  2 name2           course2
  3 name3           course3
  4 name4           course4
  5 name5           course5
  6 name6           course6
  7 name7           course7
  8 name8           course8
  9 name9           course9
 10 name10          course10
      </pre>
    </li>
    <li>Console output
      <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
Hibernate: update hibernate.STUDENT set NAME=? where ID=?
      </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
