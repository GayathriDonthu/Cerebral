<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Native SQL</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="nativeSQL pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub-Topics</h4>
  <ul>
    <li><a href="#simpleNamedNativeQuery">Simple Named Native Query</a></li>
    <li><a href="#joinInNamedQuery">Join in Named Native Query</a></li>
  </ul>
  <a id="simpleNamedNativeQuery"/><h4>Simple Named Native Query</h4>
  <ul>
    <li>Student.java - see @NamedNativeQuery and @SqlResultSetMapping annotations.
    <pre>
@NamedNativeQuery(name = "nativeQuery", 
query = "select id as sid, name as sname from Student where name=:name", resultSetMapping = "nativeQueryMapping")
@SqlResultSetMapping(name = "nativeQueryMapping", 
  entities = { @EntityResult(entityClass = Student.class, fields = {
  @FieldResult(name = "id", column = "sid"),
  @FieldResult(name = "name", column = "sname") }) })
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
  Query query = session.getNamedQuery("nativeQuery");
  query.setParameter("name", "Name1");
  List list = query.list();
  System.out.println(list);
}    
    </pre>
    </li>
    <li>Console output
    <pre>
select id as sid, name as sname from Student where name=?
[Name1]    
    </pre>
    </li>
  </ul>
  <a id="joinInNamedQuery"/><h4>Join in Named Native Query</h4>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
