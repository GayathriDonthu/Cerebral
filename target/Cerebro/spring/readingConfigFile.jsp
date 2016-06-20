<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>readingConfigFile.xhtml</title>
		<meta http-equiv="keywords" content="enter,your,keywords,here" />
		<meta http-equiv="description" content="A short description of this page." />
		<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
		<link href="../images/favicon.ico" rel="shortcut icon" />
		<link rel="stylesheet" type="text/css" href="../css/global.css"/>
	</head>
	
	<body id="springHome" class="readingConfigFile pageWidth">
	<jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
    <div class="examples">
		<ol>
			<li>BeanFactory</li>
			<li>ApplicationContext</li>
			<li>WebApplicationContext</li>
		</ol>
		<hr/>
		<img src="images/readingConfigFile.jpg" alt="Reading Spring Config file" title="Reading Spring Config file"/>
		<hr />
		<fieldset>
			<legend>Reading with BeanFactory</legend>
			<ul>
				<li>BeanFactory is light weight.</li>
				<li>Bean objects will not be created while reading the xml file. 
				Bean object will be created when we call getBean method.</li>
				<li>BeanFactory will not support I18N.</li>
			</ul>
		</fieldset>
		<fieldset>
			<legend>Reading with ApplicationContext</legend>
			<ul>
				<li>ApplicationContext is heavy weight.</li>
				<li>Objects will be created while reading an xml file.</li>
				<li>This supports I18N.</li>
				<li>To kill Spring Contained, we need to call close() method on context object.
				This method is not available in ApplicationContext. It is available in AbstractXMLApplicationContext.</li>
			</ul>
		</fieldset>
	</div>
	<jsp:include page="../footer.jsp" />
	</body>
</html>