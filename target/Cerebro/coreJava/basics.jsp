<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Basics</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="basics pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <fieldset>
    <legend>Static Loading</legend>
    
  </fieldset>
  <fieldset>
    <legend>Dynamic Loading</legend>
    
  </fieldset>
  <fieldset>
    <legend>JDK</legend>
    
  </fieldset>
  <fieldset>
    <legend>JRE</legend>
      JVM + Library classes
  </fieldset>
  <fieldset>
    <legend>class</legend>
    
  </fieldset>
  <fieldset>
    <legend>object</legend>
    
  </fieldset>
  <fieldset>
    <legend>static polymorphism/overloading</legend>
    
  </fieldset>
  <fieldset>
    <legend>dynamic polymorphism/overriding</legend>
    
  </fieldset>
  <fieldset>
    <legend>method area</legend>
    
  </fieldset>
  <fieldset>
    <legend>context area</legend>
    
  </fieldset>
  <fieldset>
    <legend>path environment variable</legend>
    
  </fieldset>
  <fieldset>
    <legend>classpath environment variable</legend>
    
  </fieldset>
  <fieldset>
    <legend>constructor</legend>
    
  </fieldset>
  <fieldset>
    <legend>instance</legend>
    
  </fieldset>
  <fieldset>
    <legend>constructor overloading</legend>
    
  </fieldset>
  <fieldset>
    <legend>String</legend>
    
  </fieldset>
  <fieldset>
    <legend>StringBuffer</legend>
      Default size of StringBuffer is 16 characters
  </fieldset>
  <fieldset>
    <legend>StringBuilder</legend>
    
  </fieldset>
  <fieldset>
    <legend>Wrapper classes</legend>
    
  </fieldset>
  <fieldset>
    <legend>Boxing/Auto Boxing</legend>
    
  </fieldset>
  <fieldset>
    <legend>Unboxing/Auto Unboxing</legend>
    
  </fieldset>
  <fieldset>
    <legend>Inheritance</legend>
    
  </fieldset>
  <fieldset>
    <legend>super class</legend>
    
  </fieldset>
  <fieldset>
    <legend>sub class</legend>
    
  </fieldset>
  <fieldset>
    <legend>super keyword</legend>
    
  </fieldset>
  <fieldset>
    <legend>this keyword</legend>
    
  </fieldset>
  <fieldset>
    <legend>final keyword</legend>
    class, variable, method, block of statements
  </fieldset>
  <fieldset>
    <legend>interfaces, late binding, early binding</legend>
    
  </fieldset>
  <fieldset>
    <legend>abstract classes</legend>
    
  </fieldset>
  <fieldset>
    <legend>Access specifiers</legend>
    public, private, protected, default
  </fieldset>
  <fieldset>
    <legend>Generics</legend>
    
  </fieldset>
  <fieldset>
    <legend>Exception/Error classes</legend>
    Exception class, Error class, Checked Exception, Unchecked Exception
  </fieldset>
  <fieldset>
    <legend>Exception Handling</legend>
    try-catch-finally
    <img src="images/exception_classes_hierarchy.jpg" alt="Exception Hierarchy"/>
  </fieldset>
  <fieldset>
    <legend>Anonymous Inner classes</legend>
    
  </fieldset>
  <fieldset>
    <legend>throws keyword</legend>
    
  </fieldset>
  <fieldset>
    <legend>throw keyword</legend>
    
  </fieldset>
  <fieldset>
    <legend>User defined Exceptions</legend>
      <pre>
public class NotValidEmailException extends Exception {

 @Override
 public String toString() {
   return "Not valid email";
 }
}
      </pre>
  </fieldset>
  <fieldset>
    <legend>Multi-Threading</legend>
      <ul>
        <li>What is thread?</li>
        <li>What is process?</li>
      </ul>
  </fieldset>
  <fieldset>
    <legend>extends Thread</legend>
      Creating thread by extending Thread class. Creating object of thread while extending Thread.
  </fieldset>
  <fieldset>
    <legend>implements Runnable</legend>
      Creating thread by implementing Runnable interface. Creating object of thread while implementing Runnable.
  </fieldset>
  <fieldset>
    <legend>Controlling thread execution</legend>
      Thread.sleep();<br/>
      t.join();<br/>
      t.wait(); t.sleep(); t.notify(); t.notifyAll(); 
  </fieldset>
  <fieldset>
    <legend>IO Streams</legend>
    
  </fieldset>
  <fieldset>
    <legend>Reading data from console</legend>
    
  </fieldset>
  <fieldset>
    <legend>Writing data to console</legend>
    
  </fieldset>
  <fieldset>
    <legend>Reading file</legend>
    
  </fieldset>
  <fieldset>
    <legend>Writing to file</legend>
    
  </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
