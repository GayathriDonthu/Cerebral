<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Oracle Workspace setup</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hibernateHome" class="workspaceSetup pageWidth">
    <jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
	<div class="examples">
	<h4>Hibernate Oracle Workspace setup</h4>
    	<ul>
    		<li>Open DB Browser in My Eclipse. Window - show view - other - type "DB Browser" - open "DB Browser"
    		<img src="images/workspaceSetup1.jpg"/>
    		</li>
    		<li>
    		Now right click in DB Browser - New - following window will be displayed.<br/>
    		Driver Template: select "Oracle(Thin driver)" from drop down.<br/>
			Driver Name: Any name<br/>
			Connection url - jdbc:oracle:thin:@localhost:1521:SID - 
			SID for Oracle express edition is "XE" by default. So I gave SID value as "XE" in above screen shot.<br/>
			user name: schema name<br/>
			password: schema password<br/>
    		Driver JARs: select "classes12.jar (or) ojdbc14.jar".Once we select this driver class name will be 
    		select automatically.
			<img src="images/workspaceSetup2.jpg"/>
    		</li>
    		<li>
    		Now click on "Test Driver" button. Then we should get an alert window as follows
    		<img src="images/workspaceSetup3.jpg"/>
    		</li>
    		<li>
    		Now create a Java Project - BasicHibernateTest. Create one more source folder named config.</li>
    		<li> Add 
    		Hibernate capabilities to the project.<br/>Right click on the project - MyEclipse - 
    		Add Hibernate capabilities. Following window will be displayed.
    		<img src="images/workspaceSetup4.jpg"/>
    		<li>click on Next - change the Configuration Folder to config by clicking on Browse button.
    		<img src="images/workspaceSetup5.jpg"/></li>
    		<li>click on "Next" - configure next window as follow:<br/>
    		DB Driver: select first created Database driver. Remaining fields will be filled automatically.<br/>
			Make sure to select Dialect: Oracle(any version)
    		<img src="images/workspaceSetup6.jpg"/>
    		</li>
    	</ul>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
