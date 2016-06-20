<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Many To One</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="manyToOne pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>SubTopics</h4>
  <ul>
  <li><a href="#targetEntity">TargetEntity attribute usage</a></li>
  </ul>
  <h4>ManyToOne relationship unidirectional</h4>
  <ul>
    <li>Company table. primary key == id
    <pre>
create table company
(
 id number(20)
,name varchar2(20)
,constraint company_pk primary key(id)
);    
    </pre>
    </li>
    <li>Flight table. Primary key == id, Foreign key,unique == Company_id.
    <pre>
create table flight
(
 id number(20)
,company_id number(20)
,name varchar2(20)
,constraint flight_pk primary key(id)
,constraint flight_fk foreign key(company_id) references company(id)
);    
    </pre>
    </li>
    <li>Company pojo
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "COMPANY", schema = "HIBERNATE")
public class Company implements Serializable
{

  private Integer id;
  private String  name;
  
  @Id
  @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="hibernate_seq")
  @SequenceGenerator(name="hibernate_seq", allocationSize=1)
  @Column(name="ID",length=20, nullable=false, updatable=false, unique=true)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }
  
  @Column(name="NAME", length=20, updatable=true, nullable=true, unique=false)
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
    <li>Flight pojo.
    <pre>
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "FLIGHT", schema = "HIBERNATE")
public class Flight implements Serializable
{
  private Integer id;
  private String  name;
  private Company company;

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_seq")
  @SequenceGenerator(name = "hibernate_seq")
  @Column(name = "ID", nullable = false, updatable = false, unique = true)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", nullable = true, updatable = true, unique = false)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
  
  @ManyToOne(cascade={CascadeType.ALL})
  @JoinColumn(name = "COMPANY_ID", referencedColumnName = "ID")
  public Company getCompany()
  {
    return company;
  }
  public void setCompany(Company pCompany)
  {
    company = pCompany;
  }
}    
    </pre>
    </li>
    <li>Test method.
    <pre>
public void test()
  {
    Company company = new Company();
    company.setName("aviation");

    Flight flight = new Flight();
    flight.setCompany(company);
    flight.setName("Sukhoi Su-30MKI");

    Flight flight2 = new Flight();
    flight2.setCompany(company);
    flight2.setName("HAL Tejas");

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(flight);
    session.save(flight2);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Records in table:
    <pre>
SQL> select * from company;

        ID NAME
---------- --------------------
       264 aviation

SQL> select * from flight;

        ID COMPANY_ID NAME
---------- ---------- --------------------
     13150        264 Sukhoi Su-30MKI
     13151        264 HAL Tejas    
    </pre>
    </li> 
  </ul>
  <a id="targetEntity">
  <h4>If return type of @ManyToOne annotation getter/setter is interface then we need to use targetEntity</h4></a>
  <ul>
  <li>Company Interface
  <pre>
public interface Company
{

  public Integer getId();
  public void setId(Integer pId);

  public String getName();
  public void setName(String pName);
}  
  </pre>
  </li>
  <li>CompanyImpl class
  <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "COMPANY", schema = "HIBERNATE")
public class CompanyImpl implements Company, Serializable
{

  private Integer id;
  private String  name;
  
  @Id
  @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="hibernate_seq")
  @SequenceGenerator(name="hibernate_seq", allocationSize=1)
  @Column(name="ID",length=20, nullable=false, updatable=false, unique=true)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }
  
  @Column(name="NAME", length=20, updatable=true, nullable=true, unique=false)
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
  <li>Flight class. In this we are using targetEntity attribute in ManyToOne annotation.
  <pre>
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "FLIGHT", schema = "HIBERNATE")
public class Flight implements Serializable
{
  private Integer id;
  private String  name;
  private Company company;

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_seq")
  @SequenceGenerator(name = "hibernate_seq")
  @Column(name = "ID", nullable = false, updatable = false, unique = true)
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
  }

  @Column(name = "NAME", nullable = true, updatable = true, unique = false)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
  
  @ManyToOne(cascade =
  {
    CascadeType.ALL
  }, targetEntity = CompanyImpl.class)
  @JoinColumn(name = "COMPANY_ID", referencedColumnName = "ID")
  public Company getCompany()
  {
    return company;
  }
  public void setCompany(Company pCompany)
  {
    company = pCompany;
  }
}  
  </pre>
  </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
