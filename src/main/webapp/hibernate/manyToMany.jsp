<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Many To Many</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="manyToMany pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <fieldset>
    <legend>Many to Many condition</legend>
    <ul>
      <li>If 2 tables have many to many relationship, then we will use 3rd table for relation. This is called 
      Tertiary relationship.</li>
      <li>In below example, EMPLOYER, EMPLOYEE tables have many to many relationship. Relationship is maintained by
      3rd table EMPER_EMP.
    </ul>
  </fieldset>
  <ul>
    <li>EMPLOYER table
    <pre>
create table employer
(
 id number(20)
,name varchar2(20)
,constraint employer_pk primary key(id)
);    
    </pre>
    </li>
    <li>EMPLOYEE table
    <pre>
create table employee
(
 id number(20)
,name varchar2(20)
,constraint employee_pk primary key(id)
);    
    </pre>
    </li>
    <li>EMPER_EMP table
    <pre>
create table emper_emp
(
 emper_id number(20)
,emp_id number(20)
,constraint emper_fk foreign key(emper_id) references employer(id)
,constraint emp_fk foreign key(emp_id) references employee(id)
);    
    </pre>
    </li>
    <li>Employer pojo. This pojo is owner of the relationship. ManyToMany annotation on getEmployees() method.
    <pre>
import java.util.Collection;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "EMPLOYER", schema = "HIBERNATE")
public class Employer implements Serializable
{
  private Integer      id;
  private String       name;
  Collection&lt;Employee&gt; employees;

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 20, unique = true, nullable = false, updatable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", length = 20, unique = false, nullable = true, updatable = true)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }

  @ManyToMany(targetEntity = Employee.class, cascade = CascadeType.ALL)
  @JoinTable(name = "EMPER_EMP", joinColumns = @JoinColumn(name = "EMPER_ID"),
      inverseJoinColumns = @JoinColumn(name = "EMP_ID"))
  public Collection&lt;Employee&gt; getEmployees()
  {
    return employees;
  }
  public void setEmployees(Collection&lt;Employee&gt; pEmployees)
  {
    employees = pEmployees;
  }
}    
    </pre>
    </li>
    <li>Employee pojo. ManyToMany annotation on getEmployers() method.
    <pre>
import java.util.Collection;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "EMPLOYEE", schema = "HIBERNATE")
public class Employee implements Serializable
{
  private Integer              id;
  private String               name;
  private Collection&lt;Employee&gt; employers;

  @Id
  @GeneratedValue
  @Column(name = "ID", length = 20, unique = true, nullable = false, updatable = false)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", length = 20, unique = false, nullable = true, updatable = true)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }

  @ManyToMany(targetEntity = Employer.class, cascade = CascadeType.ALL, mappedBy = "employees")
  public Collection&lt;Employee&gt; getEmployers()
  {
    return employers;
  }
  public void setEmployers(Collection&lt;Employee&gt; pEmployers)
  {
    employers = pEmployers;
  }
}
    </pre>
    </li>
    <li>Test method
    <pre>
public void test1()
  {
    Set&lt;Employee&gt; employees = new HashSet&lt;Employee&gt;();

    Employer employer1 = new Employer();
    employer1.setName("abc");

    Employee employee1 = new Employee();
    employee1.setName("jkl");

    Employee employee2 = new Employee();
    employee2.setName("mno");

    Employee employee3 = new Employee();
    employee3.setName("pqr");
    
    employees.add(employee1);
    employees.add(employee2);
    employees.add(employee3);

    employer1.setEmployees(employees);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(employer1);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Table records.
    <pre>
SQL> select * from employer;

        ID NAME
---------- --------------------
       307 abc

SQL> select * from employee;

        ID NAME
---------- --------------------
       308 pqr
       309 mno
       310 jkl

SQL> select * from emper_emp;

  EMPER_ID     EMP_ID
---------- ----------
       307        308
       307        309
       307        310    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
