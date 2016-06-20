<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Reading XML File</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  <body id="coreJavaHome"  class="readXml pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <ul>
      <h4>Sub Topics</h4>
      <li><a href="#jdom">Using JDOM</a></li>
      <li><a href="#saxBuilder">Using SAX Builder</a></li>
    </ul>
    <h4><a id="jdom"/>Using JDOM - Need jdom-2.0.4.jar file to read xml file.</h4>
    <ul>
      <li>employee.xml file
      <pre>
&lt;?xml version="1.0" encoding="UTF-8" standalone="no"?&gt;
&lt;employee infoType="Personal Info"&gt;
  &lt;name&gt;name1&lt;/name&gt;
  &lt;qualification&gt;BTech&lt;/qualification&gt;
  &lt;designation&gt;Software Engineer&lt;/designation&gt;
  &lt;salary&gt;100000&lt;/salary&gt;
&lt;/employee&gt;
  </pre>
      </li>
      <li>Pojo to store xml values
      <pre>
public class Employee implements Serializable
{
  private String name;
  private String qualification;
  private String salary;
  public String getName()
  {
    return name;
  }
  public void setName(String pName)
  {
    name = pName;
  }
  public String getQualification()
  {
    return qualification;
  }
  public void setQualification(String pQualification)
  {
    qualification = pQualification;
  }
  public String getSalary()
  {
    return salary;
  }
  public void setSalary(String pSalary)
  {
    salary = pSalary;
  }
}      
      </pre>
      </li>
      <li>class to convert xml to object
      <pre>
import java.io.IOException;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import com.core.java.pojo.Employee;

public class XMLToObject
{

  public static void main(String[] args)
  {
    new XMLToObject().converXmlToObject();
  }

  public void converXmlToObject()
  {
    SAXBuilder builder = new SAXBuilder();
    Document document = null;
    try
    {
      document = builder.build(XMLToObject.class.getClassLoader()
          .getResourceAsStream("employee.xml"));
    }
    catch (JDOMException e)
    {
      e.printStackTrace();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    Element rootElement = document.getRootElement();
    Employee employee = new Employee();
    employee.setName(rootElement.getChild("name").getValue());
    employee.setQualification(rootElement.getChild("qualification").getValue());
    employee.setSalary(rootElement.getChild("salary").getValue());
    System.out.println(employee.getName() + "-" + employee.getQualification() + "-"
        + employee.getSalary());
    System.out.println(rootElement.getChildText("name"));
    System.out.println(rootElement.getChildText("qualification"));
    System.out.println(rootElement.getChildText("salary"));
  }
}      
      </pre>
      </li>
      <li>Console output
      <pre>
name1-BTech-100000
name1
BTech
100000      
      </pre>
      </li>
    </ul>
    <h4><a id="saxBuilder"/>Using SAX Builder</h4>
    <ul>
      <li>
      <pre>SAX Builder</pre>
      </li>
    </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
