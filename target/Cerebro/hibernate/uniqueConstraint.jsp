<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Unique Constraint</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body  id="hibernateHome" class="uniqueConstraint pageWidth">
    <jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
    <div class="examples">
      <h4>Sub Topics</h4>
      <ul>
        <li><a href="#singleColumn">On single column</a></li>
        <li><a href="#multiColumn">On multiple columns</a></li>
      </ul>
      
      <h4><a id="singleColumn"/>Unique Constraint on single column</h4>
      <ul>
        <li>Table
        <pre>
create table course
(
 id number(38,0)
,name varchar2(256) not null unique
,constraint course_pk primary key(id)
);        
        </pre>
        </li>
        <li>Pojo
        <pre>
@Entity
@Table(name = "COURSE", schema = "HIBERNATE")
public class Course implements Serializable
{

  private Integer id   = null;
  private String  name = null;
  
  public Course(Integer id, String name)
  {
    this.id = id;
    this.name = name;
  }

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 38, nullable = false, updatable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", length = 256, nullable = false, unique = true)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
}
        </pre>
        </li>
        <li>Test Method
        <pre>
public void columnUniqueTest()
  {
    // Save first object with 1, test
    Course course1 = new Course();
    course1.setId(1);
    course1.setName("test");
    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(course1);
    session.getTransaction().commit();

    // Save another object with name as test
    Course course2 = new Course();
    course2.setId(2);
    course2.setName("test");
    session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(course2);
    session.getTransaction().commit();
  }        
        </pre>
        </li>
        <li>Console output<br/>
        <img src="images/colLevelUnique.jpg" alt="ouput"/>
        </li>
      </ul>
      <h4><a id="multiColumn"/>Unique Constraint on multiple columns</h4>
      <ul>
        <li>Table
        <pre>
create table course
(
 id number(38,0)
,name varchar2(256) not null
,constraint course_pk primary key(id)
,constraint course_unq unique(id,name)
);        
        </pre>        
        </li>
        <li>Pojo
        <pre>
@Entity
@Table(name = "COURSE", schema = "HIBERNATE", uniqueConstraints =
{
  @UniqueConstraint(columnNames = {"id", "name"})
})
public class Course implements Serializable
{

  private Integer id   = null;
  private String  name = null;
  
  public Course(Integer id, String name)
  {
    this.id = id;
    this.name = name;
  }

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 38, nullable = false, updatable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", length = 256, nullable = false)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
}        
        </pre>
        </li>
        <li>Test Method
        <pre>
public void test()
  {
    Course course1 = new Course();
    course1.setId(1);
    course1.setName("test");
    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(course1);
    session.getTransaction().commit();
    // save course object with same values to both the columns
    Course course2 = new Course();
    course2.setId(1);
    course2.setName("test");
    session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(course2);
    session.getTransaction().commit();
  }
        
        </pre>
        </li>
        <li>Console output<br/>
        <img src="images/tableLevelUnique.jpg" alt="output"/>
        </li>
      </ul>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
