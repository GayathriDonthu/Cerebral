<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Function</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body  id="hibernateHome" class="callingFunc pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Create a function</h4>
  <pre>
CREATE SEQUENCE
SEQUENCE_NUMBER
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
CACHE 20
NOORDER;

CREATE OR REPLACE FUNCTION  SEQUENCE_NUMBER_NEXTVAL RETURN PLS_INTEGER
IS
  return_val      PLS_INTEGER;
BEGIN
     SELECT     SEQUENCE_NUMBER.NEXTVAL
     INTO     return_val
     FROM     dual;
     RETURN     return_val;
END SEQUENCE_NUMBER_NEXTVAL;
/  
  </pre>
  <h4>Test method to call function</h4>
  <pre>
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import com.test.hibernate.HibernateUtil;

public class CallingFunction
{

  public static void main(String[] args)
  {
    new CallingFunction().callFunction();
  }

  public void callFunction()
  {
    String query = "{? = call SEQUENCE_NUMBER_NEXTVAL()}";
    Connection connection = HibernateUtil.getConncetion();
    CallableStatement callableStatement;
    try
    {
      callableStatement = connection.prepareCall(query);
      callableStatement.registerOutParameter(1, Types.INTEGER);
      callableStatement.executeUpdate();
      Integer result = callableStatement.getInt(1);
      System.out.println(result);
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
  }
}  
  </pre>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
