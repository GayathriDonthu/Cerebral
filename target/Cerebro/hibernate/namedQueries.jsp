<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Named Queries</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="namedQueries pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <fieldset>
    <legend>Named Queries</legend>
    <ul>
      <li>Named queries are pre-compiled by hibernate at startup time.</li>
      <li>We will write queries at class level using @NamedQuery annotation.</li>
      <li>These scope of the queries is global that is SessionFactory level.</li>
      </a>
    </ul>
  </fieldset>
  <h4>Simple query with where condition</h4>
  <ul>
    <li>Student.java - see @NamedQuery annotation. HQL query in the annotation.
    <pre>
@NamedQuery(name = "getStudents", query = "from Student where name=:name")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY)
@Entity
@Table(name = "STUDENT", schema = "HIBERNATE")
public class Student implements Serializable {

    private Integer id;
    private String name;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hib_seq")
    @SequenceGenerator(name = "hib_seq", allocationSize = 1)
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
    public String toString() {
  return name;
    }
}    
    </pre>
    </li>
    <li>test method
    <pre>
public void test1() {
  Session session = HibernateSessionFactory.openSession();
  Query query = session.getNamedQuery("getStudents");
  query.setParameter("name", "Name1");
  List list = query.list();
  System.out.println(list);
}    
    </pre>
    </li>
    <li>Console output
    <pre>
select student0_.ID as ID0_, student0_.NAME as NAME0_ from HIBERNATE.STUDENT student0_ where student0_.NAME=?
[Name1]    
    </pre>
    </li>
  </ul>
    <h4>Some attributes we can use in @NamedQuery annotation.</h4>
    <table>
      <tr>
        <th>Attribute name</th>
        <th>Description</th>
      </tr>
      <tr>
        <td>org.hibernate.cacheable</td>
        <td>Whether the query should interact with the second level cache (defualt to false)</td>
      </tr>
      <tr>
        <td>org.hibernate.cacheRegion</td>
        <td>Cache region name (default used otherwise)</td>
      </tr>
      <tr>
        <td>org.hibernate.timeout</td>
        <td>Query timeout</td>
      </tr>
      <tr>
        <td>org.hibernate.fetchSize</td>
        <td>resultset fetch size</td>
      </tr>
      <tr>
        <td>org.hibernate.flushMode</td>
        <td>Flush mode used for this query</td>
      </tr>
      <tr>
        <td>org.hibernate.cacheMode</td>
        <td>Cache mode used for this query</td>
      </tr>
      <tr>
        <td>org.hibernate.readOnly</td>
        <td>Entities loaded by this query should be in read only mode or not (default to false)</td>
      </tr>
      <tr>
        <td>org.hibernate.comment</td>
        <td>Query comment added to the generated SQL</td>
      </tr>
    </table>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
