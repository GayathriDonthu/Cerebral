<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>pom.xml</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="mavenHome" class="pomFile pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Elements in pom.xml</h4>
    <ul>
      <li>Dependencies will be specified in &lt;dependencies&gt; tag in pom.xml</li>
      <li>Dependencies will be stored in repository servers</li>
      <li>&lt;repositories&gt; - For in house development, we cannot put our dependencies open in internet. In that case
      we can setup additional remote repositories containing artifacts of in-house development. This tag will be used to
      configure remote repositories</li>
    </ul>
    <h4>Maven Coordinates</h4>
    <ul>
      <li>Maven coordinates are tuple of values that uniquely identify artifact. They are group-id, artifact-id, version
      </li>
      <li>Group ID: The organization which responsible for producing artifact</li>
      <li>Artifact ID: The name of the actual artifact</li>
      <li>Version: A version number of the artifact. The supported format is in the form of mmm.nnn.bbb-qqqqqqq-dd , 
      where mmm is the major version number, nnn is the minor version number, and bbb is the bugfix level. 
      Optionally, either qqqqq (qualifier) or dd (build number) can also be added to the version number.</li>
      <li>Sample &lt;dependencies&gt; element - adding junit jar file for unit testing.
      <pre>
&lt;dependencies&gt;
  &lt;dependency&gt;
    &lt;groupId&gt;junit&lt;/groupId&gt;
    &lt;artifactId&gt;junit&lt;/artifactId&gt;
    &lt;version&gt;3.8.1&lt;/version&gt;
  &lt;/dependency&gt;
&lt;/dependencies&gt;
      </pre>
      </li>
    </ul>
    </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
