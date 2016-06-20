<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>Collections</title>
		<meta http-equiv="keywords" content="enter,your,keywords,here" />
		<meta http-equiv="description" content="A short description of this page." />
		<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
		<link href="../images/favicon.ico" rel="shortcut icon" />
		<link rel="stylesheet" type="text/css" href="../css/global.css"/>
	</head>
	<body id="coreJavaHome" class="collections pageWidth">
	<jsp:include page="../header.jsp" />
	<jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Sub Topics</h4>
    <ul>
       <li><a href="#api">Collections API</a></li>
       <li><a href="#failFastIteration">Fail Fast Iteration</a></li>
      </ul>
      <h4><a id="api"/>Collections API</h4>
    	<img src="images/Collection_API.jpg" alt="Collections API"/>
    	<h4><a id="failFastIteration"/>Fail Fast Iteration</h4>
    	 <pre>
ConcurrentModificationException: This exception may be thrown by methods that have detected concurrent  
modification of an object when such modification is not permissible. For example, it is not generally 
permissible for one thread to modify a Collection when another thread is iterating over it.  
In general, the results of the iteration are undefined under these circumstances.  
Some Iterator implementations (including those of all the general purpose collection 
implementations  provided by the JRE) may choose to throw this exception if this behavior is  detected.
Iterators that do this are known as fail-fast iterators,  as they fail quickly and cleanly, rather than 
risking arbitrary,  non-deterministic behavior at an undetermined time in the future.
    	 </pre>
    </div>
    <jsp:include page="../footer.jsp" />
	</body>
</html>