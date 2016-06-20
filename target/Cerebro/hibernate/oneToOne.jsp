<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>One To One</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="oneToOne pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
  <ul>
    <li><a href="#primaryKeyJoinColumn">Using PrimaryKeyJoinColumn annotation</a></li>
    <li><a href="#joinColumn">Using JoinColumn annotation</a></li>
    <li><a target="_blank" href="http://docs.jboss.org/hibernate/annotations/3.5/reference/en/html_single/#entity-mapping-association">
    Using association table/third table</a></li>
  </ul>
  <a id="primaryKeyJoinColumn"/><h4>@PrimaryKeyJoinColumn - If 2 tables share primary key. Means Relationship is between PK - (PK+FK).</h4>
  <ul>
  <li>Student Table
  <pre>
create table student
(
 id number(38,0)
,name varchar2(50)
,constraint student_pk primary key(id)
);
  </pre>
  </li>
  <li>Student Course Table
  <pre>
create table student_course
(
 id number(38,0)
,course_name varchar2(50)
,constraint student_course_pk primary key(id)
,constraint student_course_fk foreign key(id) references student(id) on delete cascade
);
  </pre>
  </li>
  <li>Student.java. OneToOne mapping on getStudentCouse().
  <pre>
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "STUDENT", schema = "HIBERNATE")
public class Student implements Serializable
{

  private Integer       id;
  private String        name;
  private StudentCourse studentCourse;

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 38, nullable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @OneToOne(mappedBy = "student", cascade = CascadeType.ALL)
  public StudentCourse getStudentCourse()
  {
    return studentCourse;
  }
  public void setStudentCourse(StudentCourse pStudentCourse)
  {
    studentCourse = pStudentCourse;
  }

  @Column(name = "NAME", length = 50, nullable = true, updatable = true)
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
  <li>StudentCourse.java. OneToOne mapping on getStudent(). GenericGenerator and strategy=foreign.
  <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@SuppressWarnings("serial")
@Entity
@Table(name = "STUDENT_COURSE", schema = "HIBERNATE")
public class StudentCourse implements Serializable
{

  private Integer id;
  private String  courseName;
  private Student student;

  @Id
  @GeneratedValue(generator = "generic")
  @GenericGenerator(name = "generic", strategy = "foreign", parameters = @Parameter(
      name = "property", value = "student"))
  @Column(name = "ID", length = 38, nullable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "COURSE_NAME", length = 50, nullable = true, updatable = true)
  public String getCourseName()
  {
    return courseName;
  }
  public void setCourseName(String pCourseName)
  {
    courseName = pCourseName;
  }

  @OneToOne
  @PrimaryKeyJoinColumn
  public Student getStudent()
  {
    return student;
  }
  public void setStudent(Student pStudent)
  {
    student = pStudent;
  }
}  
  </pre>
  </li>
  <li>Test method
  <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();

    Student student = new Student();
    student.setName("abc");

    StudentCourse studentCourse = new StudentCourse();
    studentCourse.setCourseName("BTech");

    student.setStudentCourse(studentCourse);
    studentCourse.setStudent(student);

    session.beginTransaction();
    session.save(studentCourse);
    session.beginTransaction().commit();
  }
  </pre>
  </li>
  <li>Console output
  <pre>
insert into HIBERNATE.STUDENT (NAME, ID) values (?, ?)
insert into HIBERNATE.STUDENT_COURSE (COURSE_NAME, ID) values (?, ?)  
  </pre>
  </li>
  <li>Records in DB
  <pre>
SQL> select * from student;

   ID NAME
----- --------------------------------------------------
  335 abc

SQL> select * from student_course;

   ID COURSE_NAME
----- --------------------------------------------------
  335 BTech  
  </pre>
  </li> 
  </ul>
  <a id="joinColumn"><h4>@JoinColumn - if 2 tables are mapped like PK - (FK+UNIQUE)</h4></a>
  <ul>
    <li>Passport table. Primary key == id
    <pre>
create table passport
(
 id number(20)
,constraint passport_pk primary key(id)
);    
    </pre>
    </li>
    <li>Custom table. Primary key == id, Foreign key == passport_fk, unique == passport_fk
    <pre>
create table customer
 (
  id number(20)
 ,name varchar2(20)
 ,passport_fk number(20)
 ,constraint customer_pk primary key(id)
 ,constraint customer_fk foreign key(passport_fk) references passport(id)
 ,constraint custom_unq unique(passport_fk)
 );    
    </pre>
    </li>
    <li>Customer pojo. Custom pojo is owner of relationship.
    <pre>
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "CUSTOMER", schema = "HIBERNATE")
public class Customer implements Serializable
{
  private Integer id;
  private String   name;
  private Passport passport;

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 20, nullable = false, updatable = false, unique = true)
  public Integer getId()
  {
    return id;
  }

  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", length = 20, nullable = true, updatable = true, unique = false)
  public String getName()
  {
    return name;
  }

  public void setName(String pName)
  {
    name = pName;
  }

  @OneToOne(cascade = CascadeType.ALL)
  @JoinColumn(name = "PASSPORT_FK", referencedColumnName = "ID")
  public Passport getPassport()
  {
    return passport;
  }

  public void setPassport(Passport pPassport)
  {
    passport = pPassport;
  }

  @Override
  public String toString()
  {
    return name;
  }
}    
    </pre>
    </li>
    <li>Passport pojo.
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PASSPORT", schema = "HIBERNATE")
public class Passport implements Serializable
{
  private Integer id;
  private Customer customer;

  @Id
  @GeneratedValue
  @Column(name = "ID", nullable = false, updatable = false, unique = true)
  public Integer getId()
  {
    return id;
  }

  public void setId(Integer pId)
  {
    id = pId;
  }

  @OneToOne(mappedBy = "passport")
  public Customer getCustomer()
  {
    return customer;
  }

  public void setCustomer(Customer pCustomer)
  {
    customer = pCustomer;
  }

  @Override
  public String toString()
  {
    return String.valueOf(id);
  }
}    
    </pre>
    </li>
    <li>Test method
    <pre>
public void test()
  {
    Customer customer = new Customer();
    customer.setName("def");

    Passport passport = new Passport();
    passport.setCustomer(customer);
    customer.setPassport(passport);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(customer);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Conditions to remember regarding referencedColumnName attribute used in Customer.java
    <pre>
    <ul>
      <li>referencedColumnName == column name of other table to which join column is mapped to.</li>
      <li>If referencedColumnName value is non primary key column then associated entity to this table should 
      be Serializable.</li>
       <li>referencedColumn value should be single column</li>
    </ul>
    </pre>
    </li>
    <li>Conditions for relationship
    <pre>
    <ul>
     <li>One side should be owner. Owner should be responsible for updating other table.</li>
     <li>To declare one side as non owener, use mappedBy attribute in @OneToOne annotation</li>
     <li>mappedBy refers to property name of the owner of the relationship</li>
    </ul>
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
