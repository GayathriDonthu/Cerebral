<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Inheritance</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="inheritance pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Three types of inheritance</h4>
  <ul>
    <li><a href="#singleTablePerClass">One Table per class/Single Table per class</a></li>
    <li><a href="#oneTablePerSubclass">One Table per subclass/Joined Subclass</a></li>
    <li><a href="#oneTablePerConcreteClass">One Table per concrete class/Table per class</a></li>
    <li>Inherit properties from super class</li>
  </ul>
  <a id="singleTablePerClass"/><h4>One Table per class/Single Table per class</h4>
  <fieldset>
    <ul>
      <li>We will have 1 table for more than 1 pojos</li>
      <li>All the data will be stored in a single table</li>
      <li>We will differentiate the records using discriminator column</li>
      <li>In below example, We have 2 pojos. Person and Employee. Employee extends Person</li>
      <li>Data of both the pojo will be stored in a single table - PERSON</li>
    </ul>
  </fieldset>
  <ul>
    <li>PERSON Table
    <pre>
create table person
(
 id number(10)
,firstname varchar2(20)
,lastname varchar2(20)
,joining_date Date
,department_name varchar2(20)
,discriminator varchar2(20)
,constraint person_pk primary key(id)
);    
    </pre>
    </li>
    <li>Person.java
    <pre>
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "DISCRIMINATOR", discriminatorType = DiscriminatorType.STRING)
@DiscriminatorValue(value = "P")
public class Person implements Serializable
{
  private Integer id;
  private String  firstName;
  private String  lastName;

  @Id
  @GeneratedValue
  @Column(name = "ID")
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }
  public String getFirstName()
  {
    return firstName;
  }

  @Column(name = "FIRSTNAME")
  public void setFirstName(String pFirstName)
  {
    firstName = pFirstName;
  }

  @Column(name = "LASTNAME")
  public String getLastName()
  {
    return lastName;
  }
  public void setLastName(String pLastName)
  {
    lastName = pLastName;
  }
}    
    </pre>
    </li>
    <li>Employee.java.. Employee extends Person
    <pre>
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
@DiscriminatorValue(value = "E")
public class Employee extends Person
{

  private Date   joiningDate;
  private String deptName;

  @Column(name = "JOINING_DATE")
  public Date getJoiningDate()
  {
    return joiningDate;
  }
  public void setJoiningDate(Date pJoiningDate)
  {
    joiningDate = pJoiningDate;
  }

  @Column(name = "DEPARTMENT_NAME")
  public String getDeptName()
  {
    return deptName;
  }
  public void setDeptName(String pDeptName)
  {
    deptName = pDeptName;
  }
}    
    </pre>
    </li>
    <li>Test class
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    session.beginTransaction();

    Person person = new Person();
    person.setFirstName("Steve");
    person.setLastName("Jobs");
    session.save(person);

    Employee employee = new Employee();
    employee.setFirstName("Donthu");
    employee.setLastName("AvinashBabu");
    employee.setJoiningDate(new Date(2015, 07, 20));
    employee.setDeptName("R&D");
    session.save(employee);

    session.beginTransaction().commit();
  }    
    </pre>
    </li>
    <li>Console output
    <pre>
insert into HIBERNATE.PERSON (firstName, LASTNAME, DISCRIMINATOR, ID) values (?, ?, 'P', ?)
insert into HIBERNATE.PERSON (firstName, LASTNAME, DEPARTMENT_NAME, JOINING_DATE, DISCRIMINATOR, ID) 
values (?, ?, ?, ?, 'E', ?)    
    </pre>
    </li>
    <li>SQL records:
    <pre>
SQL> select * from person;

   ID FIRSTNAME  LASTNAME     JOINING_D DEPARTMENT DISCRIMINATOR
----- ---------- ------------ --------- ---------- --------------------
  323 Steve      Jobs                              P
  324 Donthu     AvinashBabu  20-AUG-15 R&D        E    
    </pre>    
    </li>
  </ul>
  <a id="oneTablePerSubclass"/><h4>One Table per subclass/Joined Subclass</h4>
  <fieldset>
    <ul>
      <li>Here for every sub-class, we will have one table</li>
      <li>We have 3 tables, PERSON, EMPLOYEE, OWNER</li>
      <li>We have 3 pojos, Person, Employee, Owner. Employee extends Person. Owner extends Person</li>
      <li>Each pojo data will be stored in respective tables</li>
    </ul>
  </fieldset>
  <ul>
    <li>PERSON Table
    <pre>
create table person
(
 person_id number(20)
,firstname varchar2(20)
,lastname varchar2(20)
,constraint person_pk primary key(person_id)
);    
    </pre>
    </li>
    <li>EMPLOYEE Table
    <pre>
create table employee
(
 person_id number(20)
,joining_date date
,department varchar2(20)
,constraint employee_pk primary key(person_id)
,constraint employee_fk foreign key(person_id) references person(person_id)
);    
    </pre>
    </li>
    <li>OWNER Table
    <pre>
create table owner
(
 person_id number(20)
,stocks number(10)
,property_value number(20)
,constraint owner_pk primary key(person_id)
,constraint owner_fk foreign key(person_id) references person(person_id)
);    
    </pre>
    </li>
    <li>Person.java
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
@Inheritance(strategy = InheritanceType.JOINED)
public class Person implements Serializable
{
  private Integer id;
  private String  firstName;
  private String  lastName;

  @Id
  @GeneratedValue
  @Column(name = "PERSON_ID")
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "FIRSTNAME")
  public String getFirstName()
  {
    return firstName;
  }
  public void setFirstName(String pFirstName)
  {
    firstName = pFirstName;
  }

  @Column(name = "LASTNAME")
  public String getLastName()
  {
    return lastName;
  }
  public void setLastName(String pLastName)
  {
    lastName = pLastName;
  }
}    
    </pre>
    </li>
    <li>Employee.java. Employee extends Person
    <pre>
@SuppressWarnings("serial")
@Entity
@Table(name = "EMPLOYEE", schema = "HIBERNATE")
@PrimaryKeyJoinColumn(name = "PERSON_ID", referencedColumnName = "PERSON_ID")
// name == column in EMPLOYEE table. referencedColumnName==column in PERSON table.
public class Employee extends Person
{

  private Date   joiningDate;
  private String department;

  @Column(name = "joining_date")
  public Date getJoiningDate()
  {
    return joiningDate;
  }
  public void setJoiningDate(Date pJoiningDate)
  {
    joiningDate = pJoiningDate;
  }

  @Column(name = "department")
  public String getDepartment()
  {
    return department;
  }
  public void setDepartment(String pDepartment)
  {
    department = pDepartment;
  }
}    
    </pre>
    </li>
    <li>Owner.java. Owner extends Person
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "OWNER", schema = "HIBERNATE")
@PrimaryKeyJoinColumn(name = "PERSON_ID", referencedColumnName = "PERSON_ID")
// name == column in EMPLOYEE table. referencedColumnName==column in PERSON table.
public class Owner extends Person
{
  private Integer stocks;
  private Integer propertyValue;
  
  @Column(name = "stocks")
  public Integer getStocks()
  {
    return stocks;
  }
  public void setStocks(Integer pStocks)
  {
    stocks = pStocks;
  }

  @Column(name = "property_value")
  public Integer getPropertyValue()
  {
    return propertyValue;
  }
  public void setPropertyValue(Integer pPropertyValue)
  {
    propertyValue = pPropertyValue;
  }
}    
    </pre>
    </li>
    <li>Test class
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    session.beginTransaction();

    Person person = new Person();
    person.setFirstName("steve");
    person.setLastName("jobs");
    session.save(person);

    Employee employee = new Employee();
    employee.setFirstName("Donthu");
    employee.setLastName("AvinashBabu");
    employee.setJoiningDate(new Date(2015, 07, 20));
    employee.setDepartment("R&D");
    session.save(employee);

    Owner owner = new Owner();
    owner.setFirstName("steve");
    owner.setLastName("jobs");
    owner.setStocks(100);
    owner.setPropertyValue(1000000000);
    session.save(owner);

    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Console output
    <pre>
insert into HIBERNATE.PERSON (FIRSTNAME, LASTNAME, PERSON_ID) values (?, ?, ?)
insert into HIBERNATE.PERSON (FIRSTNAME, LASTNAME, PERSON_ID) values (?, ?, ?)
insert into HIBERNATE.EMPLOYEE (department, joining_date, PERSON_ID) values (?, ?, ?)
insert into HIBERNATE.PERSON (FIRSTNAME, LASTNAME, PERSON_ID) values (?, ?, ?)
insert into HIBERNATE.OWNER (property_value, stocks, PERSON_ID) values (?, ?, ?)    
    </pre>
    </li>
    <li>Records in DB
    <pre>
SQL> select * from person;

PERSON_ID FIRSTNAME  LASTNAME
--------- ---------- ------------
      327 steve      jobs
      328 Donthu     AvinashBabu
      329 steve      jobs
      
SQL> select * from employee;

PERSON_ID JOINING_D DEPARTMENT
--------- --------- ----------
      328 20-AUG-15 R&D
          
SQL> select * from owner;

PERSON_ID   STOCKS PROPERTY_VALUE
--------- -------- --------------
      329      100     1000000000          
    </pre>
    </li>
  </ul>
  <a id="oneTablePerConcreteClass"/><h4>One Table per concrete class/Table per class</h4>
  <fieldset>
  <ul>
    <li>In this, we will have table for every class</li>
    <li>we have 3 tables, PERSON, EMPLOYEE, OWNER.</li>
    <li>We have 3 pojos, Person, Employee, Owner. Employee extends Person. Owner extends Person</li>
    <li>Here data related to 1 pojo will be stored in it's respective table itself</li>
    <li>That means, each table will have all columns of respective pojo. so EMPLOYEE table will have all 
    columns(columns)from PERSON table and columns from EMPLOYEE table.</li> 
  </ul>
  </fieldset>
  <fieldset>
  <legend>Advantages</legend>
  <ul>
    <li>Easy to implement</li>
  </ul>
  </fieldset>
  <fieldset>
  <legend>Dis Advantages</legend>
  <ul>
  <li>Duplication of parent data in multiple tables</li>
  <li>Changes to parent table structure, will reflect in all child tables</li>
  <li>Query to parent will result large set of select queries</li>
  <li>Not recommended in many cases</li>
  </ul>
  </fieldset>
  <ul>
  <li>PERSON Table
  <pre>
create table person
(
 person_id number(20)
,firstname varchar2(20)
,lastname varchar2(20)
,constraint person_pk primary key(person_id)
);  
  </pre>
  </li>
  <li>EMPLOYEE Table
  <pre>
create table employee
(
 person_id number(20)
,firstname varchar2(20)
,lastname varchar2(20)
,joining_date date
,department varchar2(20)
,constraint employee_pk primary key(person_id)
);  
  </pre>
  </li>
  <li>OWNER Table
  <pre>
create table owner
(
 person_id number(20)
,firstname varchar2(20)
,lastname varchar2(20)
,stocks number(20)
,property_value number(20)
,constraint owner_pk primary key(person_id)
);  
  </pre>
  </li>
  <li>Person.java
  <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class Person implements Serializable
{
  private Integer id;
  private String  firstName;
  private String  lastName;

  @Id
  @GeneratedValue
  @Column(name = "PERSON_ID")
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "FIRSTNAME")
  public String getFirstName()
  {
    return firstName;
  }
  public void setFirstName(String pFirstName)
  {
    firstName = pFirstName;
  }

  @Column(name = "LASTNAME")
  public String getLastName()
  {
    return lastName;
  }
  public void setLastName(String pLastName)
  {
    lastName = pLastName;
  }
}  
  </pre>
  </li>
  <li>Employee.java
  <pre>
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "EMPLOYEE", schema = "HIBERNATE")
@AttributeOverrides(
{
    @AttributeOverride(name = "firstName", column = @Column(name = "FIRSTNAME")),
    @AttributeOverride(name = "lastname", column = @Column(name = "LASTNAME"))
})
// firstname == property name in Person class. FIRSTNAME == column in EMPLOYEE table.
// lastname == property name in Person class. LASTNAME == column in EMPLOYEE table.
public class Employee extends Person
{

  private Date   joiningDate;
  private String department;

  @Column(name = "joining_date")
  public Date getJoiningDate()
  {
    return joiningDate;
  }
  public void setJoiningDate(Date pJoiningDate)
  {
    joiningDate = pJoiningDate;
  }

  @Column(name = "department")
  public String getDepartment()
  {
    return department;
  }
  public void setDepartment(String pDepartment)
  {
    department = pDepartment;
  }
}  
  </pre>
  </li>
  <li>Owner.java
  <pre>
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "OWNER", schema = "HIBERNATE")
@AttributeOverrides(
{
    @AttributeOverride(name = "firstName", column = @Column(name = "FIRSTNAME")),
    @AttributeOverride(name = "lastname", column = @Column(name = "LASTNAME"))
})
// firstname == property name in Person class. FIRSTNAME == column in OWNER table.
// lastname == property name in Person class. LASTNAME == column in OWNER table.
public class Owner extends Person
{
  private Integer stocks;
  private Integer propertyValue;
  
  @Column(name = "stocks")
  public Integer getStocks()
  {
    return stocks;
  }
  public void setStocks(Integer pStocks)
  {
    stocks = pStocks;
  }

  @Column(name = "property_value")
  public Integer getPropertyValue()
  {
    return propertyValue;
  }
  public void setPropertyValue(Integer pPropertyValue)
  {
    propertyValue = pPropertyValue;
  }
}  
  </pre>
  </li>
  <li>Test class
  <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    session.beginTransaction();

    Person person = new Person();
    person.setFirstName("steve");
    person.setLastName("jobs");
    session.save(person);

    Employee employee = new Employee();
    employee.setFirstName("Donthu");
    employee.setLastName("AvinashBabu");
    employee.setJoiningDate(new Date(2015, 07, 20));
    employee.setDepartment("R&D");
    session.save(employee);

    Owner owner = new Owner();
    owner.setFirstName("steve");
    owner.setLastName("jobs");
    owner.setStocks(100);
    owner.setPropertyValue(1000000000);
    session.save(owner);

    session.getTransaction().commit();
  }  
  </pre>
  </li>
  <li>Console output
  <pre>
insert into HIBERNATE.PERSON (FIRSTNAME, LASTNAME, PERSON_ID) values (?, ?, ?)
insert into HIBERNATE.EMPLOYEE (FIRSTNAME, LASTNAME, department, joining_date, PERSON_ID) values (?, ?, ?, ?, ?)
insert into HIBERNATE.OWNER (FIRSTNAME, LASTNAME, property_value, stocks, PERSON_ID) values (?, ?, ?, ?, ?)  
  </pre>
  </li>
  <li>Records in DB
  <pre>
SQL> select * from person;

PERSON_ID FIRSTNAME  LASTNAME
--------- ---------- ------------
      330 steve      jobs
      
SQL> select * from employee;

PERSON_ID FIRSTNAME  LASTNAME     JOINING_D DEPARTMENT
--------- ---------- ------------ --------- ----------
      331 Donthu     AvinashBabu  20-AUG-15 R&D


SQL> select * from owner;

PERSON_ID FIRSTNAME  LASTNAME       STOCKS PROPERTY_VALUE
--------- ---------- ------------ -------- --------------
      332 steve      jobs              100     1000000000        
  </pre>
  </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
