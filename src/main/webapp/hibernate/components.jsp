<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Components</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body  id="hibernateHome" class="components pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <fieldset>
    <legend>Components</legend>
    Components are for HAS-A relationship. Repeated columns of multiple tables can be created as objects and
    those objects we can use in other objects to store table's column information.
  </fieldset>
  <ul>
    <li>Table
    <pre>
create table person
 (
  id number(38,0)
 ,name varchar2(256)
 ,city varchar2(256)
 ,ssid number(38,0)
 ,country_name varchar2(256)
 ,constraint person_pk primary key(id)
 );  
    </pre>
    </li>
    <li>Address pojo
    <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@SuppressWarnings("serial")
@Embeddable
public class Address implements Serializable
{

  private String city;

  @Column(name = "CITY", length = 256, nullable = true, updatable = true)
  public String getCity()
  {
    return city;
  }

  public void setCity(String pCity)
  {
    city = pCity;
  }
}    
    </pre>
    </li>
    <li>Country pojo
    <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@SuppressWarnings("serial")
@Embeddable
public class Country implements Serializable
{
  
  private Integer ssid;
  private String countryName;

  @Column(name = "SSID", length = 38, nullable = true, updatable = true)
  public Integer getSsid()
  {
    return ssid;
  }
  public void setSsid(Integer pSsid)
  {
    ssid = pSsid;
  }

  @Column(name = "COUNTRYNAME", length = 256, nullable = true, updatable = true)
  public String getCountryName()
  {
    return countryName;
  }
  public void setCountryName(String pCountryName)
  {
    countryName = pCountryName;
  }
}
    </pre>
    </li>
    <li>Person pojo - In this pojo we will use Address, Country pojos to insert data in PERSON table
    <pre>
import java.io.Serializable;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
public class Person implements Serializable
{
  private Integer id;
  private String  name;
  private Address address;
  private Country bornIn;

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Column(name = "ID")
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
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
  @Embedded
  public Address getAddress()
  {
    return address;
  }
  public void setAddress(Address pAddress)
  {
    address = pAddress;
  }

  @Embedded
  @AttributeOverrides(
  {
    @AttributeOverride(name = "countryName", column = @Column(name = "COUNTRY_NAME"))
  })
  public Country getBornIn()
  {
    return bornIn;
  }
  public void setBornIn(Country pBornIn)
  {
    bornIn = pBornIn;
  }
}
    </pre>
    </li>
    <li>Method to insert record
    <pre>
public void componentTest()
  {
    Address address = new Address();
    address.setCity("Hyderabad");

    Country country = new Country();
    country.setSsid(1111);
    country.setCountryName("India");

    Person person = new Person();
    person.setName("Mike");
    person.setAddress(address);
    person.setBornIn(country);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(person);
    session.getTransaction().commit();
  }
    </pre>
    </li>
    <li>Table after insertion
    <pre>
SQL> select * from person;

  ID NAME       CITY        SSID COUNTRY_NA
---- ---------- ---------- ----- ----------
  41 Mike       Hyderabad   1111 India    
    </pre>
    </li>
  </ul>
  <h4>We can implement @AttributeOverriders using dotted notation also</h4>
  <ul>
    <li>Address2 object has Country pojo. Country pojo is same as above.
    <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Embedded;

@SuppressWarnings("serial")
@Embeddable
public class Address2 implements Serializable
{
  
  private String city;
  private Country nationality;

  @Column(name = "CITY", length = 256, nullable = true, updatable = true)
  public String getCity()
  {
    return city;
  }
  public void setCity(String pCity)
  {
    city = pCity;
  }

  @Embedded
  public Country getNationality()
  {
    return nationality;
  }
  public void setNationality(Country pNationality)
  {
    nationality = pNationality;
  }

}    
    </pre>
    </li>
    <li>Person pojo
    <pre>
import java.io.Serializable;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "PERSON", schema = "HIBERNATE")
public class Person2 implements Serializable
{
  private Integer id;
  private String  name;
  private Address2 address;

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Column(name = "ID")
  public Integer getId()
  {
    return id;
  }
  public void setId(Integer pId)
  {
    id = pId;
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

  @Embedded
  @AttributeOverrides(
  {
      @AttributeOverride(name = "nationality.countryName", column = @Column(
          name = "COUNTRY_NAME"))
  })
  public Address2 getAddress()
  {
    return address;
  }
  public void setAddress(Address2 pAddress)
  {
    address = pAddress;
  }
}    
    </pre>
    </li>
    <li>Method to insert record
    <pre>
public void savePerson()
  {
    Country country = new Country();
    country.setSsid(1112);
    country.setCountryName("USA");

    Address2 address2 = new Address2();
    address2.setCity("Salt-Lake");
    address2.setNationality(country);

    Person2 person2 = new Person2();
    person2.setName("abcd");
    person2.setAddress(address2);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.saveOrUpdate(person2);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Table after insertion
    <pre>
SQL> select * from person;

  ID NAME       CITY        SSID COUNTRY_NA
---- ---------- ---------- ----- ----------
  41 Mike       Hyderabad   1111 India
  42 abcd       Salt-Lake   1112 USA    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
