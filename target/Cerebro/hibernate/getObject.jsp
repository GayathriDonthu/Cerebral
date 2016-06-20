<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Get Object from DB</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="getObject pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>Sub Topics</h4>
    <ul>
      <li><a href="#load">Get object using load method</a></li>
      <li><a href="#get">Get object using get method</a></li>
      <li><a href="#loadVsGet">Difference between load and get</a></li>
      <li><a href="#typeMissmatch">TypeMissmatchException</a></li>
    </ul>
    <ul>
    <h4>Examples</h4>
      <li>STUDENT table records.
        <pre>
SQL> SELECT * FROM STUDENT;

 ID NAME       COURSE
--- ---------- ----------
  0 name0      course0
  1 name1      course1
  2 name2      course2
  3 name3      course3
  4 name4      course4
  5 name5      course5
  6 name6      course6
  7 name7      course7
  8 name8      course8
  9 name9      course9

10 rows selected.
    </pre>
      </li>
      <li>Student Pojo
        <pre>
@Entity
@Table(name="STUDENT", schema="hibernate")
public class Student implements Serializable
{
  private static final long serialVersionUID = 6488349710736205351L;
  private Integer ID;
  private String name;
  private String course;
  
  @Id
  @Column(name="ID", length=38, nullable=false)
  public Integer getID()
  {
    return ID;
  }
  public void setID(Integer pID)
  {
    ID = pID;
  }
  
  @Column(name="NAME", length=256, nullable=true)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
  
  @Column(name="COURSE", length=256, nullable=true)
  public String getCourse()
  {
    return course;
  }
  public void setCourse(String pCourse)
  {
    course = pCourse;
  }
  
  public String toString()
  {
    return name+":"+course;
  }
}
        </pre>
      </li>
     </ul>
     <ul>
     <h4><a id="load"/>Get object using load method</h4>
      <li>
      <pre>
public class LoadTest
{
  public static void main(String[] args)
  {
     new LoadTest().loadData();
  }
  
  public void loadData(){
    Session session = HibernateUtil.getSession();
    Student student = (Student)session.load(Student.class, 1);
    System.out.println(student);
   }
}
      </pre>
      </li>
      <li>Console output
      <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
name1:course1
      </pre>
      </li>
      <li>Overloaded load() methods:
      <p><img src="images/overloaded_load_method.jpg" alt="Overloaded load() methods"/></p>
      </li>
    </ul>
    <h4><a id="get">Get object using get method</a></h4>
    <ul>
      <li>
      <pre>
public class GetTest
{
  public static void main(String[] args)
  {
    new GetTest().getData();
  }
  public void getData(){
    Session session = HibernateUtil.getSession();
    Student student = (Student)session.get(Student.class, 9);
    System.out.println(student);
  }
}
      </pre>
      </li>
      <li>Console output
      <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
name9:course9
      </pre>
      </li>
      <li>Overloaded get() methods:
      <p><img src="images/overloaded_get_method.jpg" alt="Overloaded get() methods"/></p>
      </li>
    </ul>
    <h4><a id="loadVsGet"/>Difference between load and get</h4>
    <ul>
      <li>load
        <ul>
        <li>By default lazy = true</li>
        <li>If object is not found in DB load method will throw ObjectNotFoundException
          <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
Exception in thread "main" org.hibernate.ObjectNotFoundException: No row with the given 
identifier exists: [com.hibernate.pojo.Student#11]
 at org.hibernate.impl.SessionFactoryImpl$2.handleEntityNotFound(SessionFactoryImpl.java:419)
 at org.hibernate.proxy.AbstractLazyInitializer.checkTargetState(AbstractLazyInitializer.java:154)
 at org.hibernate.proxy.AbstractLazyInitializer.initialize(AbstractLazyInitializer.java:143)
 at org.hibernate.proxy.AbstractLazyInitializer.getImplementation(AbstractLazyInitializer.java:174)
 at org.hibernate.proxy.pojo.javassist.JavassistLazyInitializer.invoke(JavassistLazyInitializer.java)
 at com.hibernate.pojo.Student_$$_javassist_0.toString(Student_$$_javassist_0.java)
 at java.lang.String.valueOf(String.java:2854)
 at java.io.PrintStream.println(PrintStream.java:821)
 at com.hibernate.test.LoadTest.loadData(LoadTest.java:25)
 at com.hibernate.test.LoadTest.main(LoadTest.java:19)
          </pre>
        </li>
        </ul>
      </li>
      <li>get
        <ul>
          <li>By default lazy = false</li>
          <li>If Object not found in DB get method will return null
            <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME as NAME0_0_ 
from hibernate.STUDENT student0_ where student0_.ID=?
null
            </pre>
          </li>
        </ul>
      </li>
    </ul>
    <h4><a id="typeMissmatch"/>TypeMissmatchException</h4>
    <ul>
      <li>If we pass wrong type of id to load/get methods then we will get TypeMissmatchException
      <li>
      <pre>
public void getData(){
Session session = HibernateUtil.getSession();
Student student = (Student)session.get(Student.class, "19");
System.out.println(student);
  }
      </pre>
      </li>
      <li>Console output
      <pre>
Exception in thread "main" org.hibernate.TypeMismatchException: Provided id of the wrong type for 
class com.hibernate.pojo.Student. Expected: class java.lang.Integer, got class java.lang.String
at org.hibernate.event.def.DefaultLoadEventListener.onLoad(DefaultLoadEventListener.java)
at org.hibernate.impl.SessionImpl.fireLoad(SessionImpl.java:906)
at org.hibernate.impl.SessionImpl.get(SessionImpl.java:843)
at org.hibernate.impl.SessionImpl.get(SessionImpl.java:836)
at com.hibernate.test.GetTest.getData(GetTest.java:23)
at com.hibernate.test.GetTest.main(GetTest.java:19)
      </pre>
      </li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
