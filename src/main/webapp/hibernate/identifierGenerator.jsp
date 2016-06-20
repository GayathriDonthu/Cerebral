<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Generator Classes</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="generatorClasses pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Types of Generator Classes</h4>
  <ul>
    <li>Most commonly used
      <ul>
        <li>Sequence</li>
        <li>Assigned</li>
        <li>User Defined Generator classes</li>
        <li>Foreign</li>
        <li>Table Generator</li>
      </ul>
    </li>
    <li>Other types of generator classes
      <ul>
        <li>UUID</li>
        <li>GUID</li>
        <li>Identity</li>
        <li>hilo</li>
        <li>Sequence-hilo</li>
        <li>Native</li>
        <li>Select</li>
        <li>Increment</li>
      </ul>
    </li>
  </ul>
  <h4>Table</h4>
  <pre>
create table sequence_id_generation
(
 id number(38,0)
,name varchar2(256)
,constraint id_pk primary key(id)
);  
  </pre>
  <h4>Sequence</h4>
  <pre>
create sequence seq_id
start with 1
increment by 1
nominvalue
nomaxvalue
cache 20
noorder;  
  </pre>
  <h4>Identifier generation strategies</h4>
  <ul>
    <li>AUTO - Either Identity column, sequence, table depending on the underlying DB</li>
    <li>TABLE - table holding the id</li>
    <li>IDENTITY - identity column</li>
    <li>SEQUENCE - using sequence</li>
    <li>Identity Copy - the identity is copied from other entity</li>
  </ul>
  <h4>Assigned Generator</h4>
  <ul>
    <li>Pojo - if we dont specify @GeneratedValue annotation then Assigned is default generation type.
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "sequence_id_generation", schema = "HIBERNATE")
public class AssignedGenerator implements Serializable
{
  private Integer ID;
  private String  name;

  @Id
  @Column(name = "ID", length = 38, nullable = false, updatable = false)
  public Integer getID()
  {
    return ID;
  }
  public void setID(Integer pID)
  {
    ID = pID;
  }

  @Column(name = "NAME", length = 256, nullable = true, updatable = true)
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
    <li>hibernate.cfg.xml file
      <pre>
&lt;mapping class="com.hibernate.pojo.AssignedGenerator"/&gt;      
      </pre>
    </li>
    <li>Test method
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    AssignedGenerator assignedGenerator = new AssignedGenerator();
    assignedGenerator.setID(1);
    assignedGenerator.setName("name1");
    session.beginTransaction();
    session.save(assignedGenerator);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Console output
    <pre>
Hibernate: insert into HIBERNATE.sequence_id_generation (NAME, ID) values (?, ?)    
    </pre>
    </li>
  </ul>
  <h4>Sequence Generator</h4>
  <ul>
    <li>Pojo - we can declare @SequenceGenerator annotation at getter or table level.
    Default value for allocationSize attribute in @SequenceGenerator is 50. If we don't set to 1, value 
    will be incremented by 50 for each insert.
    <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
// @SequenceGenerator(name = "sequence_name", sequenceName = "seq_id")
@Table(name = "sequence_id_generation", schema = "HIBERNATE")
public class SequenceIdGeneration implements Serializable
{
  private Integer ID;
  private String  name;

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequence_name")
  @SequenceGenerator(name = "sequence_name", sequenceName = "seq_id", allocationSize = 1)
  @Column(name = "ID", length = 38, nullable = false, updatable = false)
  public Integer getID()
  {
    return ID;
  }
  public void setID(Integer pID)
  {
    ID = pID;
  }

  @Column(name = "NAME", length = 256, nullable = true, updatable = true)
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
    <li>hibernate.cfg.xml
    <pre>
&lt;mapping class="com.hibernate.pojo.SequenceIdGeneration"/&gt;    
    </pre>
    </li>
    <li>Method to save pojo
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    SequenceIdGeneration sequenceIdGeneration = new SequenceIdGeneration();
    sequenceIdGeneration.setName("name1");
    session.beginTransaction();
    session.save(sequenceIdGeneration);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Console output
    <pre>
Hibernate: select seq_id.nextval from dual
Hibernate: insert into HIBERNATE.sequence_id_generation (NAME, ID) values (?, ?)
    </pre>
    </li>
  </ul>
  <h4>Use of allocationSize attribute in @SequenceGenerator annotation</h4>
  <pre>
I have application that runs on 2 nodes. Table uses sequence.
When hibernate runs out of ids it gets next value from sequence and multiplies it by allocation size, 
then uses that "id pool" until it runs out again. 
So, for example when we have 2 nodes and nextval = 1:
let's say node_A requested nextval first
node_A_id_pool = ids from 1 to 4
node_B_id_pool = ids from 4 to 8
  </pre>
  <h4>If we sepecify @GeneratedValue annotation</h4>
  <ul>
    <li>Pojo
    <pre>
@Id
@GeneratedValue
@Column(name = "ID", length = 38, nullable = false, updatable = false)
public Integer getID()
{
  return ID;
}
public void setID(Integer pID)
{
    ID = pID;
}    
    </pre>
    </li>
    <li>This will be cosidered as AUTO and id will be generated based on underlying data base.
    For Oracle default hibernate sequence will be used.
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    SequenceIdGeneration sequenceIdGeneration = new SequenceIdGeneration();
    sequenceIdGeneration.setName("name1");
    session.beginTransaction();
    session.save(sequenceIdGeneration);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Console output
    <pre>
Hibernate: select hibernate_sequence.nextval from dual
Hibernate: insert into HIBERNATE.sequence_id_generation (NAME, ID) values (?, ?)    
    </pre>
    </li>
  </ul>
  <h4>Table Generator</h4>
  <ul>
    <li>Create a table for key generation
    <pre>
create table generator_table
(
  key varchar2(50),
  hi number(38)
);    
    </pre>
    </li>
    <li>Pojo which is using above table generator
    <pre>
import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

@Entity
@Table(name="STUDENT", schema="hibernate")
public class StudentWithTableGenerator implements Serializable
{
  private static final long serialVersionUID = 6488349710736205351L;
  private Integer ID;
  private String name;
  private String course;
  
  @Id
  @GeneratedValue(strategy = GenerationType.TABLE, generator = "STUDENT_GENERATOR")
  @TableGenerator(name = "STUDENT_GENERATOR", table = "generator_table", pkColumnName = "KEY",
      valueColumnName = "HI", pkColumnValue = "EMP", allocationSize = 1)
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

  @Basic(fetch = FetchType.LAZY)
  @Column(name = "COURSE", length = 256, nullable = true, updatable = false)
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
    <li>Test method to insert into Student table
    <pre>
public void test()
  {
    StudentWithTableGenerator student = new StudentWithTableGenerator();
    student.setName("name1");
    student.setCourse("course1");
    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(student);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>generator_table
    <pre>
SQL> select * from generator_table;

KEY                 HI
---------- -----------
EMP                 62   
    </pre>
    </li>
    <li>1st insert into STUDENT table
    <pre>
SQL> select * from student;

     ID NAME       COURSE
------- ---------- ----------
     62 name1      course1
    </pre>
    </li>
    <li>GENERATOR_TABLE table after insertion - value is incremented
    <pre>
SQL> select * from generator_table;

KEY                 HI
---------- -----------
EMP                 63   
    </pre>
    </li>
    <li>2nd insert into STUDENT table
    <pre>
SQL> select * from student;

     ID NAME       COURSE
------- ---------- ----------
     62 name1      course1
     63 name1      course1    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
