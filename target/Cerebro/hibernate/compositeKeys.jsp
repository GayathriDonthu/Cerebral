<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Composite Primary Key</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body  id="hibernateHome" class="compositePrimaryKey pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Steps to follow to declare composite primary key</h4>
  <ul>
    <li><b>Def:</b>If we use more than one column as primary key that is called as composite primary key</li>
    <li>Write a java class with properties mapped to composite primary key columns, declare it with @Embeddable annotation. 
    We will use this class in persistable java class with @Id or @EmbeddableId annotations</li>
  </ul>
  <h4>Sub-Topics</h4>
  <ul>
    <li><a href="#compositePrimaryKey">Composite Primary Key</a></li>
    <li><a href="#loadObject">load/get object</a></li>
    <li><a href="#compositeForeignKey">Composite Foreign Key</a></li>
  </ul>
  <a id="compositePrimaryKey"/><h4>Composite Primary Key</h4>
  <ul>
    <li>Employee table - (id, name) is composite primary key. 
    <pre>
SQL> create table Employee
(
id  number(38)
,name varchar2(50)
,designation varchar2(50)
,constraint employee_pk primary key(id,name)
);    
    </pre>
    </li>
    <li>EmployeeId.java - see @Embeddable annotation.
    We need to override hashcode() and equals() methods. Because hibernate will take the help of these methods to
    load/get the objects.
    <pre>
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class EmployeeId implements Serializable {

    private Integer id;
    private String name;

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
    public int hashCode() {
      return id.hashCode() + name.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
      boolean flag = false;
      EmployeeId employeeId = (EmployeeId) obj;
      if (this.id.equals(employeeId.id) && this.name.equals(employeeId.name)) {
        flag = true;
      }
      return flag;
    }
}    
    </pre>
    </li>
    <li>Employee.java - see @Id/@EmbeddedId annotations. We can use any one of the annotations.
    <pre>
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Id;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "EMPLOYEE")
public class Employee implements Serializable {

    private EmployeeId employeeId;
    private String designation;

    @EmbeddedId
    // @Id
    public EmployeeId getEmployeeId() {
      return employeeId;
    }

    public void setEmployeeId(EmployeeId pEmployeeId) {
      employeeId = pEmployeeId;
    }

    @Column(name = "DESIGNATION")
    public String getDesignation() {
      return designation;
    }

    public void setDesignation(String pDesignation) {
      designation = pDesignation;
    }

    @Override
    public String toString() {
      return this.employeeId.getId() + ":" + this.employeeId.getName() + ":"
      + this.designation;
    }

}    
    </pre>
    </li>
    <li>hibernate.cfg.xml - we don't need to map EmployeeId.java class
    <pre>
&lt;mapping class="com.hibernate.pojos.Employee"/&gt;    
    </pre>
    </li>
    <li>Test method. Write user-defined generator class to generate unique value for composite primary key
    and use it with @Id/@EmbeddedId annotation.
    <pre>
public void save() {
  Session session = HibernateSessionFactory.openSession();
  EmployeeId employeeId = new EmployeeId();
  employeeId.setId(1);
  employeeId.setName("googler");
  Employee employee = new Employee();
  employee.setEmployeeId(employeeId);
  employee.setDesignation("Software Engineer");
  session.beginTransaction();
  session.save(employee);
  session.getTransaction().commit();
}    
    </pre>
    </li>
    <li>Console output
    <pre>
Hibernate: insert into EMPLOYEE (DESIGNATION, ID, NAME) values (?, ?, ?)    
    </pre>
    </li>
  </ul>
  <a id="loadObject"/><h4>load/get object</h4>
  <ul>
    <li>load() method. Create @Embeddable object and pass it to load/get methods.
    <pre>
public void load() {
  Session session = HibernateSessionFactory.openSession();
  EmployeeId employeeId = new EmployeeId();
  employeeId.setId(1);
  employeeId.setName("googler");
  Employee employee = (Employee) session.load(Employee.class, employeeId);
  System.out.println(employee);
}    
    </pre>
    </li>
    <li>Console output
    <pre>
select employee0_.ID as ID3_0_, employee0_.NAME as NAME3_0_, employee0_.DESIGNATION as DESIGNAT3_3_0_ 
  from EMPLOYEE employee0_ where employee0_.ID=? and employee0_.NAME=?
  
1:googler:Software Engineer    
    </pre>
    </li>
  </ul>
  <a id="compositeForeignKey"/><h4>Composite Foreign Key</h4>
  <ul>
    <li>OneToMany relation between Parent and Child with composite primary key</li>
    <li>ParentPK.java. Create a @Embeddable class which we can use as composite primary key.
    <pre>
@Embeddable
public class ParentPk implements Serializable {
    String firstName;
    String lastName;
    ...
}    
    </pre>
    </li>
    <li>Parent.java. Use @JoinColumns annotation with @OneToMany annotation
    <pre>
@Entity
public class Parent implements Serializable {
    @Id
    public ParentPk id;
    public int age;

    @OneToMany(cascade=CascadeType.ALL)
    @JoinColumns ({
        @JoinColumn(name="parentCivility", referencedColumnName = "isMale"),
        @JoinColumn(name="parentLastName", referencedColumnName = "lastName"),
        @JoinColumn(name="parentFirstName", referencedColumnName = "firstName")
    })
    public Set&lt;Child&gt; children;
    ...
}       
    </pre>
    </li>
    <li>Child.java. Use @JoinColumns annotation with @ManyToOne annotation
    <pre>
@Entity
public class Child implements Serializable {
    @Id @GeneratedValue
    public Integer id;

    @ManyToOne
    @JoinColumns ({
        @JoinColumn(name="parentCivility", referencedColumnName = "isMale"),
        @JoinColumn(name="parentLastName", referencedColumnName = "lastName"),
        @JoinColumn(name="parentFirstName", referencedColumnName = "firstName")
    })
    public Parent parent;
}    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
