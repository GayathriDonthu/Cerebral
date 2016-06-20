<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>Architecture</title>
    <link href="../images/favicon.ico" rel="shortcut icon" />
    <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="springHome" class="architecture pageWidth">
  <jsp:include page="../header.jsp" />
   <jsp:include page="topics.jsp" />
    <div class="examples">
    <img src="images/springArchitecture.png" alt="Spring Architecure"/>
    <fieldset>
      <legend>Core package</legend>
      <ul>
        <li>Core package is most fundamental part of the framework. Provides IOC and Dependency Injection features.</li>
        <li>We use BeanFactory to read the configuration file(applicationContext.xml). This is sophisticated 
        implementation of Factory pattern.</li>
        <li>Factory pattern removes the need for programmatic singletons, allows you decouple configurations
         and specification of dependencies from original logic.</li>
    </fieldset>
    <fieldset>
      <legend>DAO package</legend>
      <ul>
        <li>DAO package abstraction over JDBC layer.</li>
        <li>No need to do tedious jdbc coding and no need to parse database vendor specific errors.</li>
        <li>Provides programmatic as well as Declarative transaction management.</li>
        <li>Simplifies exception handling logic, transaction logic, resource closing logic, connection, statement,
        resultset creation logic.</li>
        <li>Here instead of dealing with JDBC connection etc objects, we need to use Spring-JDBC API. Spring is 
        providing so many interfaces which internally use polymorphism to provide connection etc objects.</li>
      </ul>
    </fieldset>
    <fieldset>
      <legend>ORM</legend>
      <ul>
        <li>ORM package is integration layer for popular ORM tools like JPA, Hibernate, IBatis, JDO etc.</li>
        <li>Using ORM package we can use all features of ORM along with Spring provided features like
         exception handling, declaration transaction management.</li>
         <li>Spring will not provide any ORM tools. We need to integration any ORM tool with Spring.</li>
      </ul>
    </fieldset>
    <fieldset>
      <legend>AOP - Aspect Oriented Programming</legend>
      <ul>
        <li>Allows to define method-interceptors, pointcuts for cleanly decouple implementing functionality that 
        should be logically seperated.</li>
        <li>Simplifies Exception handling, transaction logic for Spring JDBC and Spring ORM.</li>
        <li>Simplifies Security and logging.</li>
      </ul>
    </fieldset>
    <fieldset>
      <legend>MVC/Web</legend>
      <ul>
        <li>Spring MVC provides Model-View-Controller implementation for web applications.</li>
        <li>Allows for clean separation of web module.</li>
        <li>Spring MVC is completely based on dependency injection. we can integrate
         any MVC framework with Spring.</li>
      </ul>
    </fieldset>
    <fieldset>
      <legend>JEE</legend>
      <ul>
        <li>We can integrate Spring with EJB, RMI, JMS and Email etc.</li>
        <li>In spring we don't need to create stubs and skeletons, JNDI lookups etc.</li>
        <li>Spring simplifies remoting and ejb coding etc.</li>
      </ul>    
    </fieldset>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>