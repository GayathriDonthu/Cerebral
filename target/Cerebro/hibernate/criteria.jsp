<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Criteria</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="criteria pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>About Criteria</h4>
  <ul>
    <li>In criteria we build queries. </li>
    <li>Use criteria for select queries. Use HQL for update, delete queries</li>
    <li>We use Restrictions/Expression classes to build queries. <b>Expression extends Restrictions.</b> So always use
        Expression to build queries.</li>
    <li>All Expression class methods will return different different Expression objects. All  <b>Expression classes
        implements Criterion</b> interface.</li>
    <li>
      <table>
        <tr>
          <th>Expression class</th>
          <th>Method name</th>
          <th>Condition</th>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>eq</td>
          <td>=</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>ne</td>
          <td>&lt;&gt;</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>like</td>
          <td>like</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>gt</td>
          <td>&gt;</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>lt</td>
          <td>&lt;</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>le</td>
          <td>&lt;=</td>
        </tr>
        <tr>
          <td>SimpleExpression</td>
          <td>ge</td>
          <td>&gt;=</td>
        </tr>
        <tr>
          <td>IdentifierEqExpression</td>
          <td>idEq</td>
          <td>=</td>
        </tr>
        <tr>
          <td>IlikeExpression</td>
          <td>ilike</td>
          <td>like(case in-sensetive)</td>
        </tr>
        <tr>
          <td>BetweenExpression</td>
          <td>between</td>
          <td>between ? and ?</td>
        </tr>
        <tr>
          <td>InExpression</td>
          <td>in</td>
          <td>in(x,y)</td>
        </tr>
        <tr>
          <td>NullExpression</td>
          <td>isNull</td>
          <td>is null</td>
        </tr>
        <tr>
          <td>NotNullExpression</td>
          <td>isNotNull</td>
          <td>is not null</td>
        </tr>
        <tr>
          <td>LogicalExpression</td>
          <td>and</td>
          <td>AND</td>
        </tr>
        <tr>
          <td>LogicalExpression</td>
          <td>or</td>
          <td>OR</td>
        </tr>
        <tr>
          <td>EmptyExpression</td>
          <td>isEmpty</td>
          <td>checks empry or not in query</td>
        </tr>
        <tr>
          <td>NotEmptyExpression</td>
          <td>isNotEmpty</td>
          <td>checks for not empty or not in query</td>
        </tr>
        <tr>
          <td>SizeExpression</td>
          <td>sizeEq</td>
          <td>=</td>
        </tr>
      </table>
    </li>
  </ul>
  <h4>Building queries</h4>
  <ul>
    <li>SQL - SELECT SNO, SNAME FROM STUDENT WHERE SNO = ?
      <pre>
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;      
public void test()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    Criterion criterion = Expression.idEq(2);
    criteria.add(criterion);
    List&lt;Student&gt; list = criteria.list();
    System.out.println(list.get(0));
  }      
      </pre>
      Console output
      <pre>
Hibernate: select this_.ID as ID0_0_, this_.COURSE as COURSE0_0_, this_.NAME as NAME0_0_ 
from hibernate.STUDENT this_ where this_.ID = ?
name2:course2
      </pre>
    </li>
    <li>SQL - SELECT SNO, SNAME FROM STUDENT WHERE SNAME = ?
      <pre>
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;
public void test()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    Criterion criterion = Expression.eq("name", "name0");
    criteria.add(criterion);
    List<Student> list = criteria.list();
    System.out.println(list.get(0));
  }      
      </pre>
      Console output
      <pre>
Hibernate: select this_.ID as ID0_0_, this_.COURSE as COURSE0_0_, this_.NAME as NAME0_0_ from 
hibernate.STUDENT this_ where this_.NAME=?
name0:course0       
      </pre>
    </li>
  </ul>
  <h4>Respective Where condition for Expression class method call</h4>
  <table>
    <tr>
      <th>Method call</th>
      <th>Where clause</th>    
    </tr>
    <tr>
      <td>Expression.ne("studentNo", 1L)</td>
      <td>SNO <> ?</td>
    </tr>
    <tr>
      <td>Expression.gt("studetnNo", 2L)</td>
      <td>SNO > ?</td>
    </tr>
    <tr>
      <td>Expression.like("studentName", "abc");</td>
      <td>SNAME like ?</td>
    </tr>
    <tr>
      <td>Expression.ilike("studentName" "abc");</td>
      <td>lower(SNAME) like ? -- <b>ilike is case-insensetive</b></td>
    </tr>
    <tr>
      <td>Expression.between("studentNo" 1L, 5L);</td>
      <td>SNO between ? and ?</td>
    </tr>
    <tr>
      <td>Expression.in("studentNo", new Object[]{1L, 2L, 3L}); <br/>or<br/>
        List list = new ArrayList(); list.add(1L); list.add(2L); list.add(3L);
        Expression.in("studentNo", list);
      </td>
      <td>SNO in (?,?,?)</td>
    </tr>
    <tr>
      <td>Expression.isNull("studentName")</td>
      <td>SNAME IS NULL</td>
    </tr>
    <tr>
      <td>Expression.isNotNull("studentName");</td>
      <td>SNAME IS NOT NULL</td>
    </tr>
  </table>
  <h4>Multiple where conditions</h4>
  <ul>
    <li>SNO = ? AND SNAME = ?
      <pre>
Criterion criterion1 = Expression.eq("studentNo", 1L);
Criterion criterion2 = Expression.eq("studentName", "nam1");
criteria.add(criterion1);
criteria.add(criterion1);        
      </pre>
      2nd way - if we pass map to allEq() method, bedefault AND condition will be added.
      <pre>
Map studentMap  = new HashMap();
studentMap.put("studentNo", 1L);
studentMap.put("studentName", "name1");
Criterion criterion = Expression.allEq(studentMap);
criteria.add(criterion);        
      </pre>
    </li>
    <li>select sno, sname from student where sno=? and (sname like ? or sname like ?);
    <b>Similarly we can build OR conditions also.</b>
    <pre>
public void test()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    Criterion criterion1 = Expression.eq("id", 2);
    Criterion criterion2 = Expression.eq("name", "name2");
    Criterion criterion3 = Expression.eq("name", "name1");

    Criterion criterion4 = Expression.or(criterion2, criterion3);
    Criterion criterion5 = Expression.and(criterion1, criterion4);
    criteria.add(criterion5);

    List&lt;Student&gt; list = criteria.list();
    System.out.println(list.get(0));
  }
    </pre>
    </li>
  </ul>
  <h4>SQL query in Criteria</h4>
  <ul>
    <li>SELECT SNO, SNAME FROM STUDENT WHERE SNAME LIKE 'name';
    <pre>
      List studentList = (session.createCriteria(Student.class).add(Expression
        .sqlRestriction("{alias}.SNAME LIKE 'name'"))).list();
    </pre>
    </li>
  </ul>
  <h4>Order by clause</h4>
  <pre>
    // ascending order
    Order order = Order.asc("name");
    criteria.addOrder(order);

    // descending order
    Order order = Order.desc("name");
    criteria.addOrder(order);
    criteria.setMaxResults(50);  
  </pre>
  <h4>Join Queries</h4>
  <ul>
  <li>Records in DB
  <pre>
SQL> select * from troop;

        ID NAME
---------- --------------------
       341 avengers

SQL> select * from soldiers;

        ID   TROOP_ID NAME
---------- ---------- --------------------
       342        341 abc
       343        341 def
       344        341 ghi  
  </pre>
  </li>
  <li>Troop.java
  <pre>
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
  private Integer       id;
  private String        name;
  private Set<Soldiers> soldiers;

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
  public Set<Soldiers> getSoldiers()
  {
    return soldiers;
  }
  public void setSoldiers(Set<Soldiers> pSoldiers)
  {
    soldiers = pSoldiers;
  }

  @Override
  public String toString()
  {
    return name;
  }
}  
  </pre>
  </li>
  <li>Soldiers.java
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

  @Override
  public String toString()
  {
    return name;
  }
}  
  </pre>
  </li>
  <li>Join between Troop and Soldiers
  <pre>
public void test1()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Troop.class);
    criteria.add(Expression.like("name", "a%"));
    criteria.createAlias("soldiers", "s"); // soldiers == property name in Troop class.
    criteria.add(Expression.like("s.name", "d%"));
    criteria.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
    List<Troop> list = criteria.list();
    System.out.println(list.get(0));
  }  
  </pre>
  </li>
  <li>Console output
  <pre>
select this_.ID as ID0_2_, this_.NAME as NAME0_2_, s1_.ID as ID1_0_, s1_.NAME as NAME1_0_, s1_.TROOP_ID as 
TROOP3_1_0_, troop4_.ID as ID0_1_, troop4_.NAME as NAME0_1_ 
from HIBERNATE.TROOP this_, HIBERNATE.SOLDIERS s1_, HIBERNATE.TROOP troop4_ where this_.ID=s1_.TROOP_ID and 
s1_.TROOP_ID=troop4_.ID(+) and this_.NAME like ? and s1_.NAME like ?
{s=def, this=avengers}  
  </pre>
  </li>
  </ul>
  <h4>Fetch Modes</h4>
  <ul>
  <li>FetchMode.LAZY
  <pre>
public void test2()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Troop.class);
    criteria.add(Expression.like("name", "a%"));
    criteria.setFetchMode("soldiers", FetchMode.LAZY);
    List<Troop> list = criteria.list();
    System.out.println(list);
    System.out.println(list.get(0).getSoldiers());
  }  
  </pre>
  </li>
  <li>Console output
  <pre>
select this_.ID as ID0_0_, this_.NAME as NAME0_0_ from HIBERNATE.TROOP this_ where this_.NAME like ?
[avengers]

select soldiers0_.TROOP_ID as TROOP3_1_, soldiers0_.ID as ID1_, soldiers0_.ID as ID1_0_, 
soldiers0_.NAME as NAME1_0_, soldiers0_.TROOP_ID as TROOP3_1_0_ from HIBERNATE.SOLDIERS soldiers0_ 
where soldiers0_.TROOP_ID=?
[def, abc, ghi]  
  </pre>
  </li>
  <li>FetchMode.EAGER
  <pre>
public void test2()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Troop.class);
    criteria.add(Expression.like("name", "a%"));
    criteria.setFetchMode("soldiers", FetchMode.EAGER);
    List<Troop> list = criteria.list();
    System.out.println(list);
    System.out.println(list.get(0).getSoldiers());
  }  
  </pre>
  </li>
  <li>Console output
  <pre>
select this_.ID as ID0_1_, this_.NAME as NAME0_1_, soldiers2_.TROOP_ID as TROOP3_3_, soldiers2_.ID as ID3_, 
soldiers2_.ID as ID1_0_, soldiers2_.NAME as NAME1_0_, soldiers2_.TROOP_ID as TROOP3_1_0_ 
from HIBERNATE.TROOP this_, HIBERNATE.SOLDIERS soldiers2_ 
where this_.ID=soldiers2_.TROOP_ID(+) and this_.NAME like ?

[avengers, avengers, avengers]
[def, abc, ghi]  
  </pre>
  </li>
  </ul>  
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
