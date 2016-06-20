<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Custom Annotations</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="customAnnotations pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <ul>
      <h4>Sub Topics</h4>
      <li><a href="#whatAnnotationHas">What Annotation will have</a></li>
      <li><a href="#customAnnotationExample">How to Write Custom Annotation</a></li>
    </ul>
      <a id="whatAnnotationHas"/><h4>What annotation will have</h4>
      <ul>
        <li>Type: Name of the Annotation</li>
        <li>Retention policy: Until what time annotation should exist
          <pre>
Refer java.lang.annotation.RetentionPolicy enum.
SOURCE:
Annotations are to be discarded by the compiler.

CLASS:
Annotations are to be recorded in the class file by the compiler but need not be retained by the 
VM at run time. This is the default behavior.

RUNTIME:
Annotations are to be recorded in the class file by the compiler and retained by the VM at run time, 
so they may be read reflectively.
          </pre>
        </li>
        <li>Target: To which element the annotation should be applied.
        <pre>
Refer java.lang.annotation.ElementType enum.
TYPE:Class, interface (including annotation type), or enum declaration

FIELD:Field declaration (includes enum constants)

METHOD:Method declaration

PARAMETER:Parameter declaration

CONSTRUCTOR:Constructor declaration

LOCAL_VARIABLE:Local variable declaration

ANNOTATION_TYPE:Annotation type declaration

PACKAGE:Package declaration
        </pre>
        </li>
      </ul>
      <a id="customAnnotationExample"/><h4>How to write Custom Annotation</h4>
      <ul>
        <li>Declare a custom annotation.
          <pre>
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface StudentAnnotation {

  int Id() default 0;
  String name() default "No Name";
  String course() default "No Course";
}
          </pre>
        </li>
        <li>Use the custom annotation.
        <pre>
public class UsingStudentAnnotation
{

  @StudentAnnotation(Id = 1, name = "lilly", course = "BTech")
  public void studentDetails()
  {
    // method code
  }
}
        </pre>
        </li>
        <li> Test Custom Annotation
          <pre>
import java.lang.reflect.Method;

public class StudentAnnotationTest
{
  public static void main(String[] args)
  {
    new StudentAnnotationTest().testStudentAnnotation();
  }
  public void testStudentAnnotation()
  {
    Method[] methods = UsingStudentAnnotation.class.getMethods();
    for (Method method : methods)
    {
      if (method.isAnnotationPresent(StudentAnnotation.class))
      {
        StudentAnnotation studentAnnotation = (StudentAnnotation) method
            .getAnnotation(StudentAnnotation.class);
        System.out.println(studentAnnotation.Id());
        System.out.println(studentAnnotation.name());
        System.out.println(studentAnnotation.course());
      }
    }
  }
}
          </pre>
        </li>
      </ul>
      <h4>Custom Annotation Console output</h4>
      <img src="images/customAnnotationConsoleOuput.jpg" alt="Custom Annotatin Console Output"/>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>
