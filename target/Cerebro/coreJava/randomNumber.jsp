<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Random Number</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  <body id="coreJavaHome" class="randomNumber pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Generating Random Number</h4>
      <ul>
      <li>To generate Random number
        <pre>
public class RandomNumber
{
  public static void main(String[] args)
  {
    System.out.println(Math.random());
  }
}
      </pre>
      </li>
      <li>To generate random number between 0 to 4 - solution 1
        <pre>
public class RandomNumberWithInRange
{
  public static void main(String[] args)
  {
    // Math.random() * range_of_number
    // To generate random between 0 and 4
    System.out.println(Math.random() * 5);
  }
}
        </pre>
      </li>
      <li>To generate random number between 0 to 4 - solution 2.
      Refer java.util.Random class for different methods available.
        <pre>
import java.util.Random;

public class RandomNumberWithInRange2
{

  public static void main(String[] args)
  {
    System.out.println(new Random().nextInt(5));
  }
}
        </pre>
      </li>
      <li>Generate random number between 1 to 12(including 12)
      <pre>
public class RandomNumberWithInRange3
{
  public static void main(String[] args)
  {
    System.out.println((new Random().nextInt(12)) + 1);
  }
}
      </pre>
      </li>
      </ul>
    </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
