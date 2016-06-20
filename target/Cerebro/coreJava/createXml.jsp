<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Create XML File</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="createXml pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>We are generating following xml named file.xml at the end of the example</h4>
  <pre>
&lt;?xml version="1.0" encoding="UTF-8" standalone="no"?&gt;
&lt;employee infoType="Personal Info"&gt;
  &lt;name&gt;name1&lt;/name&gt;
  &lt;qualification&gt;BTech&lt;/qualification&gt;
  &lt;designation&gt;Software Engineer&lt;/designation&gt;
  &lt;salary&gt;100000&lt;/salary&gt;
&lt;/employee&gt;
  </pre>
  <h4>Java class to create xml file</h4>
  <pre>
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class GenerateEmployeeXml
{

  public static void main(String[] args)
  {
    try
    {
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder documentBuilder = factory.newDocumentBuilder();
      Document document = documentBuilder.newDocument();

      // add employee root element
      Element rootElement = document.createElement("employee");
      rootElement.setAttribute("infoType", "Personal Info");
      document.appendChild(rootElement);

      // name element
      Element name = document.createElement("name");
      name.appendChild(document.createTextNode("name1"));
      rootElement.appendChild(name);

      // qualification element
      Element qualification = document.createElement("qualification");
      qualification.appendChild(document.createTextNode("BTech"));
      rootElement.appendChild(qualification);

      // designation element
      Element designation = document.createElement("designation");
      designation.appendChild(document.createTextNode("Software Engineer"));
      rootElement.appendChild(designation);

      // salary element
      Element salary = document.createElement("salary");
      salary.appendChild(document.createTextNode("100000"));
      rootElement.appendChild(salary);

      // write the content to xml file
      TransformerFactory transformerFactory = TransformerFactory.newInstance();
      Transformer transformer = transformerFactory.newTransformer();
      DOMSource source = new DOMSource(document);
      StreamResult result = new StreamResult(new File("C:\\employee.xml"));

      // to output to console
      // StreamResult result = new StreamResult(System.out);

      transformer.transform(source, result);

      System.out.println("File Saved..");

    }
    catch (ParserConfigurationException e)
    {
      e.printStackTrace();
    }
    catch (TransformerConfigurationException e)
    {
      e.printStackTrace();
    }
    catch (TransformerException e)
    {
      e.printStackTrace();
    }

  }

}  
  </pre>
  <h4>To get xml into console</h4>
  <pre>
  // instead of giving file name, render to console
  StreamResult result = new StreamResult(System.out);  
  </pre>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
