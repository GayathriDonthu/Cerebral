<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Versioning</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="versioning pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub-Topics</h4>
  <ul>
    <li><a href="#versioning">Versioning</a></li>
    <li><a href="#timeStamp">TimeStamp</a></li>
  </ul>
  <a id="versioning"/><h4>Versioning</h4>
  <fieldset>
    <legend>Versioning</legend>
    <ol>
      <li>Versioning will be used to track updates on a record.</li>
      <li>Whenever we perform update query, hibernate will do +1 on version column.</li>
    </ol>
  </fieldset>
  <ul>
    <li>Table
      <pre>
create table version_demo
(
 id number(38) primary key
,name varchar2(100)
,optlock number(38)
);      
      </pre>
    </li>
    <li>Pojo - Version annotation on getOptlock() method.
      <pre>
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

@SuppressWarnings(value = "serial")
@Entity
@Table(name = "VERSION_DEMO", schema = "HIBERNATE")
public class VersionDemo implements Serializable
{

  private Integer ID;
  private String  name;
  private Integer optlock;

  @Id
  @Column(name = "ID")
  public Integer getID()
  {
    return ID;
  }
  public void setID(Integer pID)
  {
    ID = pID;
  }

  @Version
  @Column(name = "OPTLOCK")
  public Integer getOptlock()
  {
    return optlock;
  }
  public void setOptlock(Integer pOptlock)
  {
    optlock = pOptlock;
  }

  @Column(name = "NAME")
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
    <li>Test method - whenever we change the setName() value and run below code, update query
    will be executed. For each update OPTLOCK column value will be incremented by 1.
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    VersionDemo versionDemo = (VersionDemo) session.load(VersionDemo.class, 1);
    versionDemo.setName("name1");
    session.beginTransaction();
    session.saveOrUpdate(versionDemo);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Initial records in table
    <pre>
SQL> select * from version_demo;

   ID NAME            OPTLOCK
----- --------------- -------
    1 name1                 0    
    </pre>
    </li>
    <li>1st run - OPTLOCK value is incremented by 1
    <pre>
SQL> select * from version_demo;

   ID NAME            OPTLOCK
----- --------------- -------
    1 name2                 1    
    </pre>
    </li>
    <li>2nd run - OPTLOCK value is incremented by 1 again.
    <pre>
SQL> select * from version_demo;

   ID NAME            OPTLOCK
----- --------------- -------
    1 name3                 2    
    </pre>
    </li>
  </ul>
  <a id="timeStamp"/><h4>TimeStamp</h4>
  <ul>
    <li>Database table
    <pre>
SQL> desc timestamp
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                        NOT NULL NUMBER(38)
 NAME                                               VARCHAR2(50)
 CHANGES                                            DATE        
    </pre>    
    </li>
    <li>TimeStamp.java - @Version annotation on getChanges() method. 
    <br/>changes property type is java.sql.Timestamp 
    <pre>
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Version;

@Entity
@Table(name = "TIMESTAMP", schema = "HIBERNATE")
public class TimeStamp implements Serializable {

    private Integer id;
    private String name;
    private Timestamp changes;

    public TimeStamp(String name) {
  this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hib_seq")
    @SequenceGenerator(name = "hib_seq")
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

    @Version
    @Column(name = "CHANGES")
    public Timestamp getChanges() {
  return changes;
    }

    public void setChanges(Timestamp pChanges) {
  changes = pChanges;
    }
}    
    </pre>
    </li>
    <li>Test method
    <pre>
public void test() {
  TimeStamp timeStamp = new TimeStamp("user1");
  Session session = HibernateSessionFactory.openSession();
  session.beginTransaction();
  session.save(timeStamp);
  session.getTransaction().commit();
}    
    </pre>
    </li>
    <li>Run 1 - check the system date.
    <p><img src="images/run1.jpg" alt="Run1"/></p>
    <pre>
SQL> select * from timestamp;

ID   NAME    CHANGES
---- ------- ---------
1250 user1   08-JUL-14      
    </pre>
    </li>
    <li>Run 2 - check the system date.
    <p><img src="images/run2.jpg" alt="Run2"/></p>
    <pre>
SQL> select * from timestamp;

ID   NAME    CHANGES
---- ------- ---------
1250 user1   08-JUL-14
1300 user1   07-JUL-14    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
