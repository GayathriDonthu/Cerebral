<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Projections</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="projections pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>About Projections</h4>
  <ul>
    <li>To specify columns in criteria</li>
    <li>To Execute aggregate functions</li>
    <li>If we are selecting specific column then list will contain Object array objects as HQL</li>
    <li>There are so many Projection classes, all those are <b>implementing Projection</b> interface</li>
    <li>Criteria extends Projection</li>
    <li>Expression extends Projection</li>
    <li>
      <table>
        <tr>
          <th>Projection class name</th>
          <th>Method name</th>
          <th>condition</th>
        </tr>
        <tr>
          <td>RowCountProjection</td>
          <td>rowCount</td>
          <td>count(*)</td>
        </tr>
        <tr>
          <td>CountProjection</td>
          <td>count - for count on any column</td>
          <td>count</td>
        </tr>
        <tr>
          <td>Distinct</td>
          <td>distinct</td>
          <td>distinct</td>
        </tr>
        <tr>
          <td>AggregateProjection</td>
          <td>max</td>
          <td>max</td>
        </tr>
        <tr>
          <td>AggregateProjection</td>
          <td>min</td>
          <td>min</td>
        </tr>
        <tr>
          <td>AggregateProjection</td>
          <td>sum</td>
          <td>sum</td>
        </tr>
        <tr>
          <td>AvgProjection</td>
          <td>avg</td>
          <td>avg</td>
        </tr>
        <tr>
          <td>SQLProjection</td>
          <td>sqlGroupProjection</td>
          <td>group</td>
        </tr>
        <tr>
          <td>IdentifierProjection</td>
          <td>id</td>
          <td>id column selection</td>
        </tr>
      </table>
    </li>
  </ul>
  <ul>
    <li>select id,name from Student
    <pre>
public void test6()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.property("ID"));
    projectionList.add(Projections.property("name"));
    criteria.setProjection(projectionList);
    List list = criteria.list();
    for (Object results : list)
    {
      Object[] object = (Object[]) results;
      for (Object obj : object)
        System.out.println(obj);
    }
  }    
    </pre>
    Console output
    <pre>
Hibernate: select this_.ID as y0_, this_.NAME as y1_ from hibernate.STUDENT this_    
    </pre>
    </li>
    <li>Select count(*) from Student
      <pre>
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
public void test()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.rowCount());
    criteria.setProjection(projectionList);
    List count = criteria.list();
    System.out.println(count.get(0));
  }      
      </pre>
    </li>
    Console output
    <pre>
Hibernate: select count(*) as y0_ from hibernate.STUDENT this_
49    
    </pre>
    <li>select count(id) from Student
      <pre>
public void test2()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);

    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.count("ID")); // ID is property name in Student pojo
    criteria.setProjection(projectionList);
    List idCount = criteria.list();
    System.out.println(idCount.get(0));
  }        
      </pre>
      Console output
      <pre>
Hibernate: select count(this_.ID) as y0_ from hibernate.STUDENT this_
49      
      </pre>
    </li>
    <li>select sum(id), max(id),min(id) avg(id) from Student
    <pre>
public void test3()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);

    ProjectionList projectionList = Projections.projectionList();

    // ID is property name
    projectionList.add(Projections.sum("ID"));
    projectionList.add(Projections.max("ID"));
    projectionList.add(Projections.min("ID"));
    projectionList.add(Projections.avg("ID"));

    criteria.setProjection(projectionList);
    List list = criteria.list();
    Object[] results = (Object[]) list.get(0);
    for (Object obj : results)
      System.out.println(obj);
  }    
    </pre>
    Console output
    <pre>
Hibernate: select sum(this_.ID) as y0_, max(this_.ID) as y1_, min(this_.ID) as y2_, 
avg(this_.ID) as y3_ from hibernate.STUDENT this_    
    </pre>
    </li>
    <li>select count(id), name from Student group by name
    <pre>
public void test4()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.count("ID"));
    projectionList.add(Projections.groupProperty("name"));
    criteria.setProjection(projectionList);
    List list = criteria.list();
    Object[] results = (Object[]) list.get(0);
    for (Object obj : results)
      System.out.println(obj);
  }    
    </pre>
    Console output
    <pre>
Hibernate: select count(this_.ID) as y0_, this_.NAME as y1_ from hibernate.STUDENT this_ 
group by this_.NAME    
    </pre>
    </li>
    <li>select distinct id from Student
    <pre>
public void test5()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.distinct(Projections.property("ID")));
    criteria.setProjection(projectionList);
    List list = criteria.list();
    System.out.println(list);
  }    
    </pre>
    Console output
    <pre>
Hibernate: select distinct this_.ID as y0_ from hibernate.STUDENT this_
    </pre>
    </li>
    <li>Select id from Student
    <pre>
public void test7()
  {
    Session session = HibernateUtil.newSession();
    Criteria criteria = session.createCriteria(Student.class);
    ProjectionList projectionList = Projections.projectionList();
    projectionList.add(Projections.id());
    criteria.setProjection(projectionList);
    List list = criteria.list();
    System.out.println(list.get(0));
  }    
    </pre>
    Console output
    <pre>
Hibernate: select this_.ID as y0_ from hibernate.STUDENT this_    
    </pre>
    </li>  
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
