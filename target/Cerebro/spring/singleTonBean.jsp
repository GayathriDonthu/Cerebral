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
	
	<body id="springHome" class="singleTonBean pageWidth">
	<jsp:include page="../header.jsp" />
    <jsp:include page="topics.jsp" />
    <div class="examples">
		<ol>
			<li>Making an object non singleton. Give singleton=false entry in bean tag.
			If we give singleton=true every time same object will be returned.</li>
		</ol> 
		<p><img src="images/singleton.jpg"/></p>
	</div>
	<jsp:include page="../footer.jsp" />
	</body>
</html>