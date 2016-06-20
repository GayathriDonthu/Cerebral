<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Maven project structure</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="mavenHome" class="mavenPjtStructure pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Project Structure</h4>
    <img alt="Maven project structure" src="images/maven-structure.jpg"/>
    <h4>Operational model</h4>
    <img alt="Operational Model" src="images/operation_model.jpg"/>
    <fieldset>
      <legend>POM</legend>
      POM is used by maven to understand the project. Project strucutre will be provided by declarative description in 
      pom.xml. pom.xml forms a tree and each pom.xml inherits properties from parent. Maven provides super pom. Super pom
      sits at top level in project hierarchy and contains default common attributes and every pom.xml inherits from it.  
    </fieldset>
    <fieldset>
      <legend>Dependecies</legend>
      <ul>
        <li>Dependecies will be provided as part of pom.xml. Dependencies will be resolved using maven's dependency 
          management tool.</li>
        <li>Dependecies are called as artifacts in maven language.</li>
        <li>Maven looks at local and global repositories to resolve dependecies.
          <ul>
             <li><a href="#localRepository">Local Repository</a></li>
             <li><a target="_blank" href="http://search.maven.org/#browse">Global Repository </a></li>            
          </ul>
        </li>
        <li>Artificats resolved using remote(global) repositories will be downloaded to local repositories for ease of use
        in subsequent accesses</li>
        <li>Maven is intelligent enough to deal with transitive dependencies.
        <pre>Transitive dependency: Dependencies that your project dependecies depend on.</pre>
        </li>
      </ul>
    </fieldset>
    <a id="localRepository"/><h4>Local Repository</h4>
    <ul>
      <li>Maven local repository, to store dependencies and plug-ins in local machines.</li>
      <li>Maven local repository defaults to "C:\Users\{user-name}\.m2\repository" folder.</li>
      <li>This repository works as a high-performance local cache, storing any artifacts downloaded.</li>
      <li>We can change default location to any user defines location. Open {M2_HOME}\.m2\settings.xml, change 
      &lt;localRepository&gt; tag value to any folder. That's it local repository changed to that location.</li>
      <li><a href="http://maven.apache.org/settings.html" target="_blank">Information about settings.xml</a>
      <li>Sample local repository structure of JUnit 3.8.1 artifact.<br/>
      <img alt="Junit Local Repository" src="images/junit_local_repository.jpg"/>
      </li>
    </ul>
    </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
