<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>Method Injection</title>
		<meta http-equiv="keywords" content="enter,your,keywords,here" />
		<meta http-equiv="description" content="A short description of this page." />
		<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
		<link href="../images/favicon.ico" rel="shortcut icon" />
		<link rel="stylesheet" type="text/css" href="../css/global.css"/>
	</head>
	
	<body id="springHome" class="methodInjection pageWidth">
	<jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
    <div class="examples">
		<h4>Method injection is used to inject non-singleton object to singleton object.</h4>
		<hr/>
		<ul>
			<li><h4>Write Service and Dao classes as follows.</h4>
				<p><img src="images/methodInjection1.jpg"/></p>
				<p><img src="images/methodInjection2.jpg"/></p>
			</li>
			<li><h4>spring-config.xml</h4>
				<p><img src="images/methodInjection3.jpg"/></p>
			</li>
			<li><h4>Write the test class</h4>
				<p><img src="images/methodInjection4.jpg"/></p>
			</li>
			<li><h4>Output</h4>
				<p><img src="images/methodInjection5.jpg"/></p>
			</li>
		</ul>
	</div>
	<jsp:include page="../footer.jsp" />
	</body>
</html>