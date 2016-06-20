<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My Eclipse Preferences</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="icpHome">
    <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
      <h4>My Eclipse Preferences</h4>
    <ul>
      <li>Open the preferences window by choosing Window>Preferences from the MyEclipse menu bar.
          (On each of the following preference pages be sure to click Apply to save your changes, when all done click OK)
      </li>
      <li>
        Ensure that the preferences for Java - Code Style are set as follows:
        <img src="images/codeStyle.jpg" alt="Code Style"/>
      </li>
      <li>Open Java - Code Style - Code Templates. <br/>
          Click Import - import the file freya-root/config/codetemplates31.xml
        <img src="images/codeTemplate.jpg" alt="Code Template"/>
      </li>
      <li>Open preferences for Java - Code Style - Formatter<br/>
          Click Import - import the file freya-root/config/codeFormatter31.xml
        <img src="images/codeFormatter.jpg" alt="Code Formatter"/>
      </li>
      <li>Open preferences for General - Editors - Text Editors and set as follows:
        <img src="images/textEditor.jpg" alt="Text Editor"/>
      </li>
      <li>Open preferences for MyEclipse - Files and Editors - XML - XML Source and set as follows:
        <img src="images/xmlSource.jpg" alt="Xml Source"/>
      </li>
      <li>Open preferences for Java - Compiler and set as follows:
        <img src="images/compiler.jpg" alt="Compiler"/>
      </li>
      <li>Open preferences for Java - Installed JREs.
          If the JDK 1.7 is not listed click Add. and select your 1.7 JDK and make it the default JRE.<br/>
        <img src="images/jre.jpg" alt="JRE"/>
      </li>
      <li>Open preferences for MyEclipse - Servers - Jboss - Jboss 4.x and configure as follows: 
        (using the path to your MyEclipse Jboss instance)<br/>
        <img src="images/jboss.jpg" alt="JBoss"/>  
      </li>
      <li>Open preferences for MyEclipse - Servers - Jboss - Jboss 4.x - JDK and set as follows: 
      (using the path to your MyEclipse Jboss instance)<br/>
        <img src="images/jbossVMArgs.jpg" alt="Jboss VM Args"/>
      </li>
      <li>VM Arguments.<br/>
      NOTE: when cutting and pasting these values: If any of the dashes have been converted to Word hyphens, 
      you will get an error when starting JBoss from Eclipse that your min and max heap sizes are invalid. 
      The hyphen will appear slightly longer than the dash.  
      You may want to type over each of the dashes after you paste this into  the MyEclipse text field to ensure 
      that they are dashes and not Word hyphens.
        <pre>
JBoss JDK VM args:
-Xms512m -Xmx1024m -Xss2048k
-XX:MaxPermSize=256M
-Dorg.apache.tapestry.disable-caching=false
-Dhibernate.config=apollo.cfg.xml
-Djavax.net.ssl.trustStore=C:\Dev\jboss-apollo-4.0.3sp1-ME\server\apollo\conf\icp.keystore
-Djavax.net.ssl.trustStorePassword=ingenix1
----------------------------------------------------------
For running test cases:
-Dhibernate.standalone.config=apollo_standalone.cfg.xml
-Dlog4j.configuration=test/TestLogging.xml
-Dfreya.product=payer
        </pre>
      </li>
      <li>Open preferences for MyEclipse - Maven4MyEclipse and ensure that Maven4MyEclipse features are disabled.
        <img src="images/mavenForMyEclipse.jpg" alt="Maven For My Eclipse"/>
      </li>
      <li>Open preferences for MyEclipse - Validation.Click Disable All and uncheck the box for Allow projects to 
      override these preference settings.Click OK to complete your changes and exit the preferences window.
        <img src="images/validation.jpg" alt="Validation"/>
      </li>
    </ul>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
