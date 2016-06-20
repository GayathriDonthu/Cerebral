<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Caching</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="caching pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub-Topics</h4>
  <ul>
    <li><a href="#firstLevelCache">First Level Caching - Session Caching</a></li>
    <li><a href="#secondLevelCache">Second Level Caching - Global caching</a></li>
    <li><a href="#queryCache">Query Caching</a></li>
    <li>
    <a href="https://docs.jboss.org/hibernate/orm/4.0/devguide/en-US/html/ch06.html" target="_blank">more>></a>
    </li>
  </ul>
   <a id="firstLevelCache"/><h4>First Level Caching - Session Caching</h4>
   <ul>
    <li>Mandatory caching.</li>
    <li>Hibernate loads the object from db and caches it in current session.</li>
   </ul>
   <ul>
    <li>Data base table and records
      <pre>
SQL> select * from student;

   ID NAME
----- ----------
   11 Name1
   12 Name2
   13 Name3
   14 Name4
   15 Name5
   16 Name6
   17 Name7
   18 Name8
   19 Name9      
      </pre>
    </li>
    <li>Student.java
    <pre>
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "STUDENT", schema = "HIBERNATE")
public class Student implements Serializable{

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
    <li>Test method
    <pre>
public class FirstLevelCaching {

    public static void main(String[] args) {
  Session session = HibernateSessionFactory.getSession();

  /* first time - so hit the db and get data. */
  Student student1 = (Student) session.get(Student.class, 11);
  System.out.println(student1.getName());

  /*
   * second time - we are trying to load same object with same session, so
   * don't hit DB
   */
  Student student2 = (Student) session.get(Student.class, 11);
  System.out.println(student2.getName());
    }
}    
    </pre>
    </li>
    <li>Console output - Even though we are calling session.get() 2 times only 1 db hit is present because 
    we are getting same object in the same session. Since object already cached in session, no need to hit the db.
    <pre>
select student0_.ID as ID0_0_, student0_.NAME as NAME0_0_ from HIBERNATE.STUDENT student0_ where student0_.ID=?
Name1
Name1    
    </pre>
    </li>
   </ul>
   <a id="secondLevelCache"/><h4>Second Level Caching - Global caching</h4>
   <fieldset>
    <ul>
      <li>Second level cache is introduced in Hibernate 3.0</li>
      <li>When we are loading an object from database, hibernate will check for the object in local cache (first level 
      cache), if object not found hibernate will check in global cache(second level cache), even if object not found
      hibernate will hit the database and load the object</li>
      <li>Once object loaded fro database, hibernate will store the object in local cache(first level cache) and then in
      global cache(second level cache)</li>
      <li>When another session need to load the same object from database then hibernate copies object from global cache
      to local cache of that session</li>
      <li>Secondary Cache is SessionFactory level. Secondary Cache exists as long as session factory is alive.</li>
    </ul>
   </fieldset>
   <fieldset>
    <legend>Vendors</legend>
    <ul>
      <li>Easy Hibernate Cache (EHCache) -- from Hibernate</li>
      <li>Open Symphony Cache (OSCache) -- from Open Symphany</li>
      <li>Swarm Cache</li>
      <li>JBoss Tree Cache -- from JBoss</li>
    </ul>
   </fieldset>
   <h4>To disable second level caching, make following entry in cfg.xml file.</h4>
    <pre>
&lt;!-- To disable second level caching --&gt;
&lt;property name="cache.provider_class"&gt;org.hibernate.cache.NoCacheProvider&lt;/property&gt;    
    </pre>
    <h4>To enable second level caching - remember we are using Hibernate 4.1 version</h4>
    <ul>
      <li>Make following entries in cfg.xml file
      <pre>
&lt;!-- To enable second level caching --&gt;
&lt;property name="cache.use_second_level_cache"&gt;true&lt;/property&gt;
&lt;property name="cache.provider_class"&gt;org.hibernate.cache.EhCacheProvider&lt;/property&gt;
&lt;property name="hibernate.cache.region.factory_class"&gt;
    org.hibernate.cache.ehcache.EhCacheRegionFactory&lt;/property&gt;      
      </pre>
      </li>
      <li>Make the following changes to pojo (here Student.java)
      <pre>
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY)
@Entity
@Table(name = "STUDENT", schema = "HIBERNATE")
public class Student implements Serializable {
 // regular mappings.
}      
      </pre>
      </li>
      <li>write ehcache.xml file, make sure this file is in class path(better keep this file in same 
      folder of cfg.xml file).
      <pre>
&lt;?xml version="1.0"?&gt;
 
&lt;ehcache&gt;
 
&lt;defaultCache maxElementsInMemory="100" eternal="false" timeToIdleSeconds="120" timeToIdleSeconds="200" /&gt;
&lt;cache name="com.hibernate.pojos.Student" maxElementsInMemory="100" eternal="false" timeToIdleSeconds="5" 
  timeToLiveSeconds="200" /&gt;
&lt;/ehcache&gt;      
      </pre>
      </li>
    </ul>
    <h4>Properties in ehcache.xml file</h4>
    <ul>
      <li>If eternal=true, then we should not write timeToIdleSeconds, timeToIdleSeconds. Hibernate will take care
      of these values. If we want to give these values manually, then declare eternal=false.</li>
      <li><b>timeToIdealSeconds=&quot;seconds&quot;</b> means, if the object in the global chche is ideal, 
      means not using by any other class or object then it will be waited for some time we specified and 
      deleted from the global cache if time is exceeds more than timeToIdealSeconds value.</li>
      <li><b>timeToLiveSeconds=&quot;seconds&quot;</b> means, the other Session or class using this object or not, 
      i mean may be it is using by other sessions or may not, what ever the situation might be, 
      once it completed the time specified in timeToLiveSeconds, then it will be removed 
      from the global cache by hibernate.</li>
      <li>Actually &lt;defaultCache /&gt; will reflects to all the pojo classes in our application,  
      and we can also assign the ehcache values to specified pojo class by 
      &lt;cache name=&quot;your pojo class name &quot;/&gt;
    </ul>
    <h4>Test.java</h4>
    <ul>
    <li>test() method.
    <pre>
public void test() {
  Session session1 = HibernateSessionFactory.getSessionFactory()
    .openSession();

  // get student object with session1
  Student student1 = (Student) session1.get(Student.class, 11);
  System.out.println(student1.getName());

  // get one more session and get same student object. Now there should no
  // database hit because object already available in global cache.
  Session session2 = HibernateSessionFactory.getSessionFactory()
    .openSession();
  Student student2 = (Student) session2.get(Student.class, 11);
  System.out.println(student2.getName());

  // we gave timeToLiveSeconds for Student object to 5 seconds. so sleep
  // for 10 seconds and retry to load the object in another session.
  try {
      Thread.sleep(10000);
  } catch (InterruptedException e) {
      e.printStackTrace();
  }

//Since object removed from global session, hibernate will hit database to load object.
  Session session3 = HibernateSessionFactory.getSessionFactory()
    .openSession();
  Student student3 = (Student) session3.get(Student.class, 11);
  System.out.println(student3.getName());
}   
    </pre>
    </li>
    <li>Console output
    <pre>
select student0_.ID as ID0_0_, student0_.NAME as NAME0_0_ from HIBERNATE.STUDENT student0_ where student0_.ID=?
Name1
Name1
select student0_.ID as ID0_0_, student0_.NAME as NAME0_0_ from HIBERNATE.STUDENT student0_ where student0_.ID=?
Name1    
    </pre>
    </li>
    </ul>
    <h4>Concurrency Strategies</h4>
    <ul>
    <li>A concurrency strategy is a mediator which responsible for storing items of data in the cache and 
    retrieving them from the cache. If you are going to enable a second-level cache, you will have to decide, 
    for each persistent class and collection, which cache concurrency strategy to use.</li>
    <li><b>Transactional:</b> Use this strategy for read-mostly data where it is critical to prevent stale data in 
    concurrent transactions,in the rare case of an update.</li>
    <li><b>Read-write:</b>Again use this strategy for read-mostly data where it is critical to prevent stale data in 
    concurrent transactions,in the rare case of an update.</li>
    <li><b>Nonstrict-read-write:</b>This strategy makes no guarantee of consistency between the cache and the database. 
    Use this strategy if data hardly ever changes and a small likelihood of stale data is not of critical concern.</li>
    <li><b>Read-only:</b>A concurrency strategy suitable for data which never changes. Use it for reference data only.</li>
    </ul>
    <h4>We need ehcache-core-2.4.3.jar(version may differ) to implement second level caching.</h4>
    <p><img src="images/ehcache_jarfile.jpg" alt="EHCache jar file"/></p>
    <a id="queryCache"/><h4>Query Caching</h4>
    <ul>
      <li><b>Definition:</b>If we are executing same query with same parameters many times, then we can go
      with query caching.</li>
      <li>Make the following changes in cfg.xml file.
      <pre>
&lt;!-- Enable Query caching --&gt;
&lt;property name="cache.use_query_cache"&gt;true&lt;/property&gt;      
      </pre>
      </li>
      <li>Test.java
      <pre>
public void test() {
  Session session1 = HibernateSessionFactory.openSession();
  String queryStr = "FROM Student";
  Query query = session1.createQuery(queryStr);
  query.setCacheable(true);
  // even though we are calling query.list() two times, hibernate will hit
  // database only once because we are using query caching.
  List list1 = query.list();
  List list2 = query.list();
  System.out.println(list1.size());
  System.out.println(list2.size());
}      
      </pre>
      </li>
      <li>Console output
      <pre>
Hibernate: select student0_.ID as ID0_, student0_.NAME as NAME0_ from HIBERNATE.STUDENT student0_
10
10      
      </pre>
      </li>
    </ul>
    <fieldset>
      <legend>Caution on Query Caching</legend>
      Caching introduces overhead in the area of transactional processing. 
      For example, if you cache results of a query against an object, Hibernate needs to keep track of 
      whether any changes have been committed against the object, and invalidate the cache accordingly. 
      In addition, the benefit from caching query results is limited, and highly dependent on the usage 
      patterns of your application. For these reasons, Hibernate disables the query cache by default.
    </fieldset>    
   </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
