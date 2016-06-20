<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Calling Stored Procedure</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="callingStoredProc pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Stored Procedure</h4>
  <pre>
create or replace procedure insert_student(id in number, name in varchar, course in varchar)
as
begin
 insert into student(id,name,course) values (id, name, course);
 commit;
end insert_student;
/  
  </pre>
  <h4>Call Stored Procedure</h4>
  <ul>
    <li>Util method for getting Connection object - refer 
    <a href="reusableCode.jsp" target="_blank">Reusable code</a> for HibernateUtil 
    <pre>
import java.sql.Connection;
public static Connection getConncetion(){
    return newSession().connection();
}
  </pre>
    </li>
    <li>Test method 1 for calling stored procedure
    <pre>
public void execStoredProcedure() throws SQLException
  {
    String query = "{call insert_student(?,?,?)}";
    Connection connection = HibernateUtil.getConncetion();
    CallableStatement callableStatement = null;
    try
    {
      connection.setAutoCommit(false);
      callableStatement = connection.prepareCall(query);
      callableStatement.setLong(1, 100);
      callableStatement.setString(2, "name1");
      callableStatement.setString(3, "course1");
      callableStatement.executeUpdate();
    }
    finally
    {
      connection.close();
    }
}
    </pre>
    </li>
    <li>Test method 2 for calling stored procedure
    <pre>
public void executeProcedure()
  {
    String queryStr = "{call insert_student(:id,:name,:course)}";
    Query query = HibernateUtil.newSession().createSQLQuery(queryStr);
    query.setParameter("id", 2);
    query.setParameter("name", "name2");
    query.setParameter("course", "course2");
    System.out.println(query.executeUpdate());
  }    
    </pre>
    </li>
    <li>Student table before execution
    <pre>
SQL> select * from student;

no rows selected    
    </pre>
    </li>
    <li>Student table after executing stored procedure
    <pre>
SQL> select * from student;

  ID NAME       COURSE
---- ---------- ----------
 100 name1      course1
   2 name2      course2  
    </pre>
    </li>
  </ul>
  <h4>Calling stored procedure which returns cursor</h4>
  <pre>
create or replace procedure get_students(s_cur out sys_refcursor)
as
begin
open s_cur for
select * from student;
end;
  </pre>
  </div>
  <jsp:include page="../footer.jsp" />  
  </body>
</html>
