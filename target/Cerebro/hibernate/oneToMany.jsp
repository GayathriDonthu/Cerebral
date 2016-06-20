<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>One To Many</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="oneToMany pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
  <ul>
    <li><a href="#set">ManyToOne pojo is owner of relationship.</a></li>
    <li><a href="#setOneToManyOwner">OneToMany pojo is owner of relationship.</a></li>
  </ul>
  <a id="set"/><h4>ManyToOne pojo is owner of relationship.</h4>
  <ul>
    <li>Troop table. primary key == id.
    <pre>
 create table troop
 (
  id number(20)
 ,name varchar2(20)
 ,constraint troop_pk primary key(id)
 );    
    </pre>
    </li>
    <li>Soldiers table. Primary key == id, foreign key == troop_id.
    <pre>
create table soldiers
(
 id number(20)
,troop_id number(20)
,name varchar2(20)
,constraint soldiers_pk primary key(id)
,constraint soldiers_fk foreign key(troop_id) references troop(id)
);    
    </pre>
    </li>
    <li>Troop pojo. OneToMany annotation. mappedBy is used, so this pojo is not owner of relationship.
    <pre>
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "TROOP", schema = "HIBERNATE")
public class Troop implements Serializable
{
  private Integer id;
  private String  name;
  private Set&lt;Soldiers&gt; soldiers;

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

  @Column(name = "NAME", length = 20, nullable = true, updatable = true, unique = false)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }

  // troop is property name in Soldiers class
  @OneToMany(mappedBy = "troop")
  public Set&lt;Soldiers&gt; getSoldiers()
  {
    return soldiers;
  }
  public void setSoldiers(Set&lt;Soldiers&gt; pSoldiers)
  {
    soldiers = pSoldiers;
  }
}    
    </pre>
    </li>
    <li>Soldiers pojo. ManyToOne annotation. This pojo is owner of relationship.
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "SOLDIERS", schema = "HIBERNATE")
public class Soldiers implements Serializable
{
  private Integer id;
  private String  name;
  private Troop   troop;

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

  @ManyToOne
  @JoinColumn(name = "TROOP_ID", referencedColumnName = "ID")
  public Troop getTroop()
  {
    return troop;
  }
  public void setTroop(Troop pTroop)
  {
    troop = pTroop;
  }
}    
    </pre>
    </li>
    <li>Test method. This ManyToOne is owner, we need to save each Soldiers object after saving troop object.
    <pre>
public void test()
  {
    Set&lt;Soldiers&gt; set = new HashSet&lt;Soldiers&gt;();

    Troop troop = new Troop();
    troop.setName("avengers");

    Soldiers soldiers1 = new Soldiers();
    soldiers1.setName("abc");
    soldiers1.setTroop(troop);

    Soldiers soldiers2 = new Soldiers();
    soldiers2.setName("def");
    soldiers2.setTroop(troop);

    Soldiers soldiers3 = new Soldiers();
    soldiers3.setName("ghi");
    soldiers3.setTroop(troop);

    set.add(soldiers1);
    set.add(soldiers2);
    set.add(soldiers3);
    troop.setSoldiers(set);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(troop);
    session.save(soldiers1);
    session.save(soldiers2);
    session.save(soldiers3);
    session.getTransaction().commit();
  }    
    </pre>
    </li>
    <li>Table records
    <pre>
SQL> select * from troop;

        ID NAME
---------- --------------------
       275 avengers

SQL> select * from soldiers;

        ID   TROOP_ID NAME
---------- ---------- --------------------
       276        275 abc
       277        275 def
       278        275 ghi    
    </pre>
    </li>
  </ul>
  <a id="setOneToManyOwner"/><h4>OneToMany pojo is owner of relationship.</h4>
  <ul>
  <li>Troop pojo. OneToMany annotation. If we dont we cascade=CascadeType.ALL, we will get TransientObjectException
  while saving records.
  <pre>
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "TROOP", schema = "HIBERNATE")
public class Troop implements Serializable
{
  private Integer id;
  private String  name;
  private Set&lt;Soldiers&gt; soldiers;

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

  @Column(name = "NAME", length = 20, nullable = true, updatable = true, unique = false)
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }

  // If we dont declare cascade = CascadeType.ALL, then we will get TransientObjectException
  @OneToMany(cascade = CascadeType.ALL)
  @JoinColumn(name = "TROOP_ID", referencedColumnName = "ID")
  public Set&lt;Soldiers&gt; getSoldiers()
  {
    return soldiers;
  }
  public void setSoldiers(Set&lt;Soldiers&gt; pSoldiers)
  {
    soldiers = pSoldiers;
  }
}  
  </pre>
  </li>
  <li>Soldiers pojo. 
  <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "SOLDIERS", schema = "HIBERNATE")
public class Soldiers implements Serializable
{
  private Integer id;
  private String  name;
  private Troop   troop;

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

  @ManyToOne
  @JoinColumn(name = "TROOP_ID", referencedColumnName = "ID")
  public Troop getTroop()
  {
    return troop;
  }
  public void setTroop(Troop pTroop)
  {
    troop = pTroop;
  }

}  
  </pre>
  </li>
  <li>Test Method
  <pre>
public void test2()
  {
    Set<Soldiers> set = new HashSet<Soldiers>();

    Troop troop = new Troop();
    troop.setName("avengers");

    Soldiers soldiers1 = new Soldiers();
    soldiers1.setName("abc");
    soldiers1.setTroop(troop);

    Soldiers soldiers2 = new Soldiers();
    soldiers2.setName("def");
    soldiers2.setTroop(troop);

    Soldiers soldiers3 = new Soldiers();
    soldiers3.setName("ghi");
    soldiers3.setTroop(troop);

    set.add(soldiers1);
    set.add(soldiers2);
    set.add(soldiers3);
    troop.setSoldiers(set);

    Session session = HibernateUtil.newSession();
    session.beginTransaction();
    session.save(troop);
    session.getTransaction().commit();
  }  
  </pre>
  </li>
  <li>Table records
  <pre>
SQL> select * from troop;

        ID NAME
---------- --------------------
       281 avengers

SQL> select * from soldiers;

        ID   TROOP_ID NAME
---------- ---------- --------------------
       282        281 ghi
       283        281 def
       284        281 abc  
  </pre>
  </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
