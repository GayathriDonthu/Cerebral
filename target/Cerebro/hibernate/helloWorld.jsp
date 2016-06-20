<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Hello World</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="helloWorld pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Files needed</h4>
  <ul>
    <li><b>Database table:</b>To which table we want to store the data</li>
    <li><b>pojo:</b> java class used to persist</li>
    <li><b>hibernate.cfg.xml file:</b> used to configure database details. To configure persistable entity</li>
    <li><b>Test class:</b>java class where we write the code to save pojo</li>
  </ul>
  <h4>Example</h4>
  <ul>
    <li>Student table
    <pre>
SQL>CREATE TABLE STUDENT(
 ID NUMBER(38,0)
,NAME VARCHAR2(256) NOT NULL
,CONSTRAINT STUDENT_PK PRIMARY KEY(ID)
);    
    </pre>
    </li>
    <li>Student.java - this object we will store into database
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "STUDENT", schema = "HIBERNATE")
public class Student implements Serializable {

    private Integer id;
    private String name;

    @Id
    @Column(name = "ID")
    public Integer getId() {
       return id;
    }

    public void setId(Integer pId) {
      id = pId;
    }

    @Column(name = "NAME")
    public String getName() {
      return name;
    }

    public void setName(String pName) {
      name = pName;
    }

    @Override
    public String toString() {
     return name;
    }
}    
    </pre>
    </li>
    <li>hibernate.cfg.xml file
    <pre>
&lt;hibernate-configuration&gt;
    &lt;session-factory&gt;
        &lt;property name="hbm2ddl.auto"&gt;update&lt;/property&gt;
        &lt;property name="dialect"&gt;org.hibernate.dialect.Oracle9Dialect&lt;/property&gt;
        &lt;property name="connection.url"&gt;jdbc:oracle:thin:@localhost:1521:icp&lt;/property&gt;
        &lt;property name="connection.username"&gt;hibernate&lt;/property&gt;
        &lt;property name="connection.password"&gt;hibernate&lt;/property&gt;
        &lt;property name="connection.driver_class"&gt;oracle.jdbc.driver.OracleDriver&lt;/property&gt;
        &lt;!-- Pojo mapping --&gt;
        &lt;mapping class="com.hibernate.pojos.Student"/&gt;
    &lt;/session-factory&gt;
&lt;/hibernate-configuration&gt;    
    </pre>
    </li>
    <li>Test method to save Student object
    <pre>
public void save(){
    Student student = new Student();
    student.setID(10);
    student.setName("name10");
    AnnotationConfiguration configuration = new AnnotationConfiguration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = sessionFactory.openSession();   
    session.beginTransaction();
    session.save(student);
    session.getTransaction().commit();
}    
    </pre>
    </li>
    <li>Console output
    <pre>
insert into hibernate.STUDENT (NAME, ID) values (?, ?)
    </pre>    
    </li>
    <li>Table after inserting record
    <pre>
SQL> SELECT * FROM STUDENT;

  ID NAME       
---- ---------- 
  10 name10     
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
