<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>JPS</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="javaProcesses pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <ul>
      <li><a href="#existingJavaProcesses">Existing java processes</a></li>
      <li><a href="#killingProcess">Killing Process</a>
      <li><a href="#example">Example</a></li>
    </ul>
    <h4><a id="existingJavaProcesses">Existing Java Processes</a></h4>
    <ul>
      <li>We can use sun.tools.jps.Jps tool</li>
      <li>run jps in command prompt</li>
    </ul>
    <img src="images/javaProcesses.jpg" alt="Processes"/>
    <h4><a id="killingProcess">Killing Process</a></h4>
    <ul>
      <li>Write a batch file with the following code</li>
      <li>
      <pre>
FOR /F "tokens=1,2 delims= " %%G IN ('jps -l') DO IF "%%H"=="class name with path" taskkill /F /PID %%G
      </pre>
      </li>
      <li>Run the above batch file will kill the named process</li>
    </ul>
    <h4>Kill any process with process id</h4>
    <pre>
    taskkill /F /PID &lt;pid&gt;
    </pre>
    <h4><a id="example">Example</a></h4>
    <ul>
      <li>Write Java class as follows
        <pre>
public class ProcessTest
{
  public static void main(String[] args)
  {
    System.out.println("inside main");
    try
    {
      Thread.sleep(300000);
    }
    catch (InterruptedException e)
    {
      e.printStackTrace();
    }
  }
}
        </pre>
      </li>
      <li>After executing above main() method, following are java processes
      <img src="images/jpsBeforekilling.jpg" alt="Java Prcess Before Killing"/>
      </li>
      <li>Now kill the process using the bath file created above
      <img src="images/jpsBeforekilling2.jpg" alt="Java Prcess Before Killing"/>
      </li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
