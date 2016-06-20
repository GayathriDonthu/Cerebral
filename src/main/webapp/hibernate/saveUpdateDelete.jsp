<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>Save/Update/Delete</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="saveUpdateDelete pageWidth">
    <jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
	<div class="examples">
	<h4>Sub Topics</h4>
	<ul>
	 <li><a href="#save">Save</a></li>
	 <li><a href="#persist">Persist</a></li>
	 <li><a href="#update">Update</a></li>
	 <li><a href="#saveOrUpdate">SaveOrUpdate</a></li>
	 <li><a href="#delete">Delete</a></li>
	</ul>
	<h4>STUDENT Table</h4>
    <pre>
SQL&gt;CREATE TABLE STUDENT(
 ID NUMBER(38,0)
,NAME VARCHAR2(256) NOT NULL
,COURSE VARCHAR2(256) NOT NULL
,CONSTRAINT STUDENT_PK PRIMARY KEY(ID)
);
    </pre>
    <h4>Student.java</h4>
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
  
  @Column(name="COURSE", length=256, nullable=true, updatable=false)
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
	<h4>Mapping pojo in cfg file</h4>
	<ul>
		<li>Make pojo entry in hibernate.cfg.xml file
		  <pre>
      &lt;mapping class="com.hibenate.examples.pojos.Student"/&gt;
		  </pre>
		</li>
	</ul>
	<h4><a id="save"/>Save</h4>
	<ul>
		<li>Save pojo
			<pre>
public void save(){
    Student student = new Student();
    student.setID(10);
    student.setName("name10");
    student.setCourse("course10");
    Session session = HibernateUtil.getSession();
    session.beginTransaction();
    session.save(student);
    session.getTransaction().commit();
}		
			</pre>
		</li>
		<li>Console output
		<pre>Hibernate: insert into hibernate.STUDENT (COURSE, NAME, ID) values (?, ?, ?)</pre>
		</li>
		<li>Table
		  <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME       COURSE
---- ---------- ----------
  10 name10     course10
		  </pre>
		</li>
	</ul>
	<h4><a id="persist"/>Persist</h4>
	<ul>
	 <li>Persist will save an object in DB same as Save</li>
	 <li>Save will return identifier(ID) value where as return type of persist() is void</li>
	</ul>
	<h4><a id="update"/>Update</h4>
	<ul>
	 <li>Update pojo
	   <pre>
public void update(){
    Session session = HibernateUtil.getSession();
    Student student = (Student)session.get(Student.class, 10);
    student.setName("name10updated");
    session.beginTransaction();
    session.update(student);
    session.getTransaction().commit();
}
	   </pre>
	 </li>
	 <li>Console ouput
	 <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME 
as NAME0_0_ from hibernate.STUDENT student0_ where student0_.ID=?

Hibernate: update hibernate.STUDENT set COURSE=?, NAME=? where ID=?
	 </pre>
	 </li>
	 <li>Table
	   <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME            COURSE
---- --------------- ----------
  10 name10updated   course10
	   </pre>
	 </li>
	</ul>
	<h4><a id="saveOrUpdate"/>SaveOrUpdate</h4>
	<ul>
	 <li>SaveOrUpdate
	   <pre>
public void saveOrUpdate(){
//    This will fire update query
    Student student = new Student();
    student.setID(10);
    student.setName("name10");
    student.setCourse("course10");
    Session session = HibernateUtil.getSession();
    session.beginTransaction();
    session.saveOrUpdate(student);
    session.getTransaction().commit();
    
//    This will fire Insert query
    Student student2 = new Student();
    student2.setID(2);
    student2.setName("name2");
    student2.setCourse("course2");
    Session session2 = HibernateUtil.getSession();
    session2.beginTransaction();
    session2.saveOrUpdate(student2);
    session2.getTransaction().commit();
}
	   </pre>
	 </li>
	 <li>Console output
	   <pre>
Hibernate: select student_.ID, student_.COURSE as COURSE0_, student_.NAME as NAME0_ from 
hibernate.STUDENT student_ where student_.ID=?
Hibernate: update hibernate.STUDENT set COURSE=?, NAME=? where ID=?

Hibernate: select student_.ID, student_.COURSE as COURSE0_, student_.NAME as NAME0_ from 
hibernate.STUDENT student_ where student_.ID=?
Hibernate: insert into hibernate.STUDENT (COURSE, NAME, ID) values (?, ?, ?)
	   </pre>
	 </li>
	 <li>Table
	   <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME            COURSE
---- --------------- ----------
   2 name2           course2
  10 name10          course10
	   </pre>
	 </li>
	</ul>
	<h4><a id="delete"/>Delete</h4>
	<ul>
	 <li>Delete
	   <pre>
public void delete(){
    Session session = HibernateUtil.getSession();
    session.beginTransaction();
    session.delete(session.get(Student.class, 10));
    session.getTransaction().commit();
}
	   </pre>
	 </li>
	 <li>Console output
	   <pre>
Hibernate: select student0_.ID as ID0_0_, student0_.COURSE as COURSE0_0_, student0_.NAME 
as NAME0_0_ from hibernate.STUDENT student0_ where student0_.ID=?
Hibernate: delete from hibernate.STUDENT where ID=?
	   </pre>
	 </li>
	 <li>Table before delete
	   <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME            COURSE
---- --------------- ----------
   2 name2           course2
  10 name10          course10
	   </pre>
	 </li>
	 <li>Table after delete
	   <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME            COURSE
---- --------------- ----------
   2 name2           course2
	   </pre>
	 </li>
	</ul>
	</div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
