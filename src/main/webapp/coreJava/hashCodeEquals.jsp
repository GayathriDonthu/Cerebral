<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>HashCode and Equals</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="hashCodeEquals pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
    <h4>equals() method</h4>
    <ul>
      <li>equals() method is used to check the equality of two objects.</li>
      <li>equals() method should be
        <ul>
          <li>Reflexive: x.equals(x) should always return true</li>
          <li>Symmetric: if x.equals(y) returns true then y.equals(x) should return true</li>
          <li>Transitive: if x.equals(y) return true and y.equals(z) returns true then x.equals(z) should return true</li>
          <li>Consistent: multiple invocations of x.equals(y) should consistently return true</li>
          <li>For non null value of x, x.equals(null) should always return false</li> 
        </ul>
      </li>
      <li>We can choose which properties to consider to verify whether 2 objects are equal or not.
      For example for Student object if studentNo, studentName and studentClass for two objects are same then we can say
      those two objects are equal.
      <pre>
public class EqualsDemo {

    public class Student {
  private Integer studentNo;
  private String studentName;
  private String studentClass;

  Student(Integer studentNo, String studentName, String studentClass) {
      this.studentNo = studentNo;
      this.studentName = studentName;
      this.studentClass = studentClass;
  }

  public Integer getStudentNo() {
      return studentNo;
  }

  public void setStudentNo(Integer pStudentNo) {
      studentNo = pStudentNo;
  }

  public String getStudentName() {
      return studentName;
  }

  public void setStudentName(String pStudentName) {
      studentName = pStudentName;
  }

  public String getStudentClass() {
      return studentClass;
  }

  public void setStudentClass(String pStudentClass) {
      studentClass = pStudentClass;
  }

  @Override
  public boolean equals(Object pObj) {
      boolean result = false;
      Student student = (Student) pObj;
      if (this == null || pObj == null)
    result = false;
      if (this.studentNo.equals(student.getStudentNo())
        && this.studentName.equals(student.getStudentName())
        && this.studentClass.equals(student.getStudentClass()))
    result = true;
      return result;
  }

  @Override
  public int hashCode() {
      return studentNo + studentName.hashCode() + studentClass.hashCode();
  }
    }

    public static void main(String[] args) {
  new EqualsDemo().test();
    }

    public void test() {
  Student student1 = new Student(1, "abc", "class1");
  Student student2 = new Student(1, "abc", "class1");
  Student student3 = new Student(1, "def", "class1");
  System.out.println(student1.equals(student2));
  System.out.println(student1.equals(student3));
    }
}        
      </pre>
      <pre>Console output
true
false
      </pre>
      </li>
      <li>In the above example we are overriding one more method hashCode().</li>
    </ul>
    <h4>Contract between hashCode() and equals() method.</h4>
    <pre>
      If two objects are equal, that is object1.equals(object2) returns true then those two objects must return same 
      hashCode(). So whenever we override equals() , we need to override hashCode() to make sure equal objects return 
      same hashCode().
    </pre>
   <ul>
    <li>hashCode()
    <p>
    <img alt="hashCode" src="images/hashCode.jpg"/>
    </p>
    </li>
    <li>equals()
    <p>
    <img alt="equals" src="images/equals.jpg">
    </p>
    </li>
   </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
