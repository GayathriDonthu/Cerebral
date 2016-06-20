<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>HQL</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="hql pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h5>All examples in this screen are referring to Student pojo in 
  <a href="reusableCode.jsp" target="_blank">Reusable Codes</a> page</h5>
  <h4>Sub Topics</h4>
  <ul>
    <li><a href="#getList">Get List</a></li>
    <li><a href="#updateQuery">Update Query</a></li>
    <li><a href="#deleteQuery">Delete Query</a></li>
    <li><a href="#aggregateFunctions">Aggregate Functions</a></li>
    <li><a href="#uniqueResult">Unique Result</a></li>
  </ul>
  <h4>Advantages of HQL</h4>
  <ul>
    <li>In HQL, we need to give pojo name and property name instead of table name and column name.
    Pojo names and property names are case sensetive</li>
    <li>HQL queries are data base independent</li>
    <li>General insert queries we cannot execute in HQL.
    For example we cannot execute &quot;insert into student values(1,"name1", "course1");&quot;</li>
    <li>We can execute queries like &quot;insert into student select * from stu;&quot;</li>
    <li>We cannot perform ddl operation in HQL</li>
    <li>Directly we can get list objects from DB, no need to get ReturnResult object and iterate over to create
    list of objects.</li>
    <li>We can use named parameters in HQL queries. 
      <ul>
      <li>Positional parameters: update Student set studentName = ? where studentNo = ?; Maintenance of these
      queries is difficult.</li>
       <li>Named parameters: update Student set studentName = :name where studentNo = :no;
      </ul>
    </li>
  </ul>
  <fieldset>
    <legend>From clause</legend>
    <ul>
    <li>Selecting all columns
      <ul>
        <li>SQL--- select * from STUDENT;</li>
        <li>HQL--- From Student;</li>
      </ul>
    </li>
    <li>Specified columns
      <ul>
        <li>SQL--- SELECT STUDENT_NAME, COURSE FROM STUDENT;</li>
        <li>HQL--- Select student.studentName, student.course FROM Student student;</li>
      </ul>
    </li>
    <li>Where clause
      <ul>
        <li>SQL--- SELECT * FROM STUDENT WHERE STUDENT_NAME LIKE '%ABC%';</li>
        <li>HQL--- From Student where studentName like '%ABC%';</li>
      </ul>
    </li>  
    <li>Order by 
      <ul>
        <li>SQL--- SELECT * FROM STUDENT WHERE SNAME = ? ORDER BY SNO ACS;</li>
        <li>HQL--- From Student student where student.studentaName = :name order by student.studentNo asc;</li> 
      </ul>
    </li>
    <li>AND condition
      <ul>
        <li>SQL--- SELECT * FROM STUDENT WHERE (SNAME = ? AND SAGE = ?);</li>
        <li>HQL--- From Student student where student.studentName = :name and student.studentAge = :age;</li>
      </ul>
    </li>
    <li>OR condition
      <ul>
        <li>SQL-- SELECT * FROMS STUDENT WHERE (SNO = ? OR SNAME LIKE ?);</li>
        <li>HQL--- From Student student where student.studentNo = :no or student.studentName like :name;</li>
      </ul>
    </li>
    </ul>
  </fieldset>
  <a id="getList"/><h4>Get list of objects</h4>
  <ul>
    <li>Number of records in table.
    <pre>
SQL> select count(*) from student;

  COUNT(*)
----------
        50
  </pre>
    </li>
    <li>Method to get the list
    <pre>
public void getStudentList()
  {
    String queryStr = "From Student";
    Session session = HibernateUtil.newSession();
    Query query = session.createQuery(queryStr);

    @SuppressWarnings("unchecked")
    List&lt;Student&gt; studentList = query.list();
    System.out.println("Number of records:" + studentList.size());

    // If we want to iterate over, student list ther we can call following method.
    @SuppressWarnings("unchecked")
    Iterator&lt;Student&gt; studentIterator = query.iterate();
}  
    </pre>
    </li>
    <li>Console output
    <pre>
Hibernate: select student0_.ID as ID0_, student0_.COURSE as COURSE0_, student0_.NAME as NAME0_ 
from hibernate.STUDENT student0_
Number of records:50
Hibernate: select student0_.ID as col_0_0_ from hibernate.STUDENT student0_   
    </pre>
    </li>
  </ul>
  <fieldset>
    <legend>Note</legend>
    <ul>
      <li>If we are not giving column names or selecting all columns in query like above 
      we will get list of Student objects. List&lt;Student&gt;</li>
      <li>If we give specific columns then we will get list of Object array objects. List&lt;Object[]&gt;</li>
    </ul>
  </fieldset>
  <a id="updateQuery"/><h4>Update Query</h4>
  <ul>
    <li>Table before update
    <pre>
SQL> select * from student where id = 1;

  ID NAME            COURSE
---- --------------- ----------
   1 name1           course1</pre>
    </li>
    <li>Update method
    <pre>
import org.hibernate.Query;
import org.hibernate.Session;
import com.test.hibernate.HibernateUtil;
public void hqlUpdate()
  {
    String qryStr = "Update Student student set student.name = :name where student.ID = :id";
    Session session = HibernateUtil.newSession();
    Query query = session.createQuery(qryStr);
    query.setParameter("name", "nameUpdated");
    query.setParameter("id", 1);
    session.beginTransaction();
    query.executeUpdate();
    session.getTransaction().commit();
  }
    </pre>
    </li>
    <li>Table after update
      <pre>
SQL> select * from student where id = 1;

  ID NAME            COURSE
---- --------------- ----------
   1 nameUpdated     course1      
      </pre>
    </li>
  </ul>
  <a id="deleteQuery"/><h4>Delete Query</h4>
  <ul>
    <li>Table before delete
      <pre>
SQL> select * from student where id = 1;

  ID NAME            COURSE
---- --------------- ----------
   1 nameUpdated     course1      
      </pre>
    </li>
    <li>Delete method
    <pre>
import org.hibernate.Query;
import org.hibernate.Session;
public void delete()
  {
    String qryStr = "delete From Student student where student.ID = :id";
    Session session = HibernateUtil.newSession();
    Query query = session.createQuery(qryStr);
    query.setParameter("id", 1);
    session.beginTransaction();
    query.executeUpdate();
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Table after delete
    <pre>
SQL> select * from student where id = 1;

no rows selected    
    </pre>
    </li>
  </ul>
  <a id="aggregateFunctions"/><h4>Aggregate Functions</h4>
  <ul>
    <li>Method to execute aggregate functions
    <pre>
import org.hibernate.Query;
import org.hibernate.Session;
public void aggregateFunctions()
  {
//    here ID is property name
    String qryStr = "Select sum(ID), avg(ID), count(ID) from Student";
    Session session = HibernateUtil.newSession();
    Query query = session.createQuery(qryStr);
    List<Object[]> result = query.list();

    Object[] values = result.get(0);
    for (Object value : values)
    {
      System.out.println(value);
    }
  }    
    </pre>
    </li>
    <li>Console Output
    <pre>
Hibernate: select sum(student0_.ID) as col_0_0_, avg(student0_.ID) as col_1_0_, count(student0_.ID) 
as col_2_0_ from hibernate.STUDENT student0_
1224
24.979591836734695
49    
    </pre>
    </li>
  </ul>
  <a id="uniqueResult"/><h4>Unique Result</h4>
  <ul>
    <li>Unique Result method - If return result contains more than one object, we will get 
    NonUniqueResultException.
    <pre>
import org.hibernate.Query;
import org.hibernate.Session;
public void uniqueResult()
  {
    String qryStr = "From Student student where student.ID = :id";
    Session session = HibernateUtil.newSession();
    Query query = session.createQuery(qryStr);
    query.setParameter("id", 2);

    // If return restult is only one object then we can call uniqueResult() object.
    // If return result contains more than one object NonUniqueResultException will be
    // thrown.
    Object object = query.uniqueResult();
    System.out.println(((Student) object).getName());
  }    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
