<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Updatable Attribute</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="updatableAttr pageWidth">
    <jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>Sub Topics</h4>
    <ul>
      <li><a href="#issue">Update Issue</a></li>
      <li><a href="#solution">Update Issue Solution</a></li>
    </ul>
    <h4>Update class</h4>
    <pre>
public void update(){
    Session session = HibernateUtil.newSession();
    Student student = new Student();
    student.setID(2);
    student.setName("name2updated");
    session.beginTransaction();
    session.update(student);
    session.getTransaction().commit();
}
    </pre>
    <h4>Table Before update</h4>
    <pre>
SQL> select * from student;

 ID NAME            COURSE
--- --------------- ----------
  2 name2           course2
    </pre>
    <h4><a id="issue"/>Update Issue</h4>
    <ul>
      <li>Student pojo - course property updatable = true
        <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="STUDENT", schema="hibernate")
public class Student implements Serializable
{
  private String course;
  
  @Column(name="COURSE", length=256, nullable=true, updatable=true)
  public String getCourse()
  {
    return course;
  }
  public void setCourse(String pCourse)
  {
    course = pCourse;
  }
}
        </pre>
      </li>
      
      <li>Table after update, null updated to COURSE column.
      <pre>
SQL> select * from student;

 ID NAME            COURSE
--- --------------- ----------
  2 name2updated
      </pre>
      </li>
    </ul>
    <h4><a id="solution"/>Update Issue Solution</h4>
    <fieldset>
      <legend>Points to remember</legend>
      <ul>
      <li>Updatable=false will make column immutable.</li>
      <li>Put updatable=false, then make changes to that property then execute saveOrUpdate(). 
          Now update query will not be executed.</li>
      <li>By default updatable=true</li>
    </ul>
    </fieldset>
    <ul>
      <li>Student - Pojo with updatable = false
        <pre>
@Entity
@Table(name="STUDENT", schema="hibernate")
public class Student implements Serializable
{
  @Column(name="COURSE", length=256, nullable=true, updatable=false)
  public String getCourse()
  {
    return course;
  }
  public void setCourse(String pCourse)
  {
    course = pCourse;
  }
}
        </pre>
      </li>
      <li>Table after update
        <pre>
SQL> select * from student;

 ID NAME            COURSE
--- --------------- ----------
  2 name2updated    course2
        </pre>
      </li>
      <li>Execute following code having record shown above
      <pre>
public void save(){
    Student student = new Student();
    student.setID(2);
    student.setName("name2Updated");
    student.setCourse("course2Updated");
    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.saveOrUpdate(student);
    session.getTransaction().commit();
  }      
      </pre>
      </li>
      <li>Console output - no update query because we did changes to course property which 
      has updatable=false
      <pre>
Hibernate: select student_.ID, student_.NAME as NAME0_ from hibernate.STUDENT student_ 
where student_.ID=?      
      </pre>
      </li>
    </ul>
    <fieldset>
      <legend>Example</legend>
      <ul>
        <li>We can declare @Id property(Primary Key column) as update=false. Because @Id column will be generated
        using Sequences (or some generated classes) and generally we won't update primary key column once inserted</li>
      </ul>
    </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
