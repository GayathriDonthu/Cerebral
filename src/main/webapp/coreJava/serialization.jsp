<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Serializable</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  <body id="coreJavaHome" class="serialization pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
    <ul>
      <li><a href="#sinletonSerializableIssue">Serializing Singleton object Issue</a></li>
      <li><a href="#sinletonSerializableSolution">Serializing Singleton object solution</a></li>
    </ul>
    <h4><a id="sinletonSerializableIssue"/>Serializing Singleton object Issue</h4>
    <ul>
      <li>If we serialize singleton object and deserialize it, new object will be created.
      If we deserialize multiple times, every time new object will be created. This should not be the case
      with Serialized object.
        <pre>
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class SingletonSerializableDefect implements Serializable
{
  private static SingletonSerializableDefect instance = new SingletonSerializableDefect();
  private int                                i;
  public static SingletonSerializableDefect getInstance()
  {
    return instance;
  }
  private SingletonSerializableDefect()
  {

  }

  public static void main(String[] args) throws Exception
  {
    SingletonSerializableDefect obj = SingletonSerializableDefect.getInstance();
    obj.i = 10;
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(baos);
    oos.writeObject(obj);
    oos.close();
    obj.i = 11;
    InputStream is = new ByteArrayInputStream(baos.toByteArray());
    ObjectInputStream ois = new ObjectInputStream(is);
    SingletonSerializableDefect deserialized = (SingletonSerializableDefect) ois.readObject();

    InputStream is2 = new ByteArrayInputStream(baos.toByteArray());
    ObjectInputStream ois2 = new ObjectInputStream(is2);
    SingletonSerializableDefect deserialized2 = (SingletonSerializableDefect) ois2
        .readObject();
    System.out.println(deserialized);
    System.out.println(deserialized2);
  }
}
        </pre>
      </li>
      <li>Console output</li>
    </ul>
    <img src="images/singletonSerializableIssue.jpg" alt="Serialization Issue console ouput"/>
    <h4><a id="sinletonSerializableSolution"/>Serializing Singleton object solution</h4>
    <ul>
      <li>Write readResolve() method in a serialized class
        <pre>
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class SingleTonSerializationSolution implements Serializable
{

  private static SingleTonSerializationSolution instance = new SingleTonSerializationSolution();
  private int                                   i;
  public static SingleTonSerializationSolution getInstance()
  {
    return instance;
  }
  private SingleTonSerializationSolution()
  {

  }

  private Object readResolve()
  {
    return instance;
  }

  public static void main(String[] args) throws Exception
  {
    SingleTonSerializationSolution obj = SingleTonSerializationSolution.getInstance();
    obj.i = 10;
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(baos);
    oos.writeObject(obj);
    oos.close();
    obj.i = 11;
    InputStream is = new ByteArrayInputStream(baos.toByteArray());
    ObjectInputStream ois = new ObjectInputStream(is);
    SingleTonSerializationSolution deserialized = (SingleTonSerializationSolution) ois
        .readObject();

    InputStream is2 = new ByteArrayInputStream(baos.toByteArray());
    ObjectInputStream ois2 = new ObjectInputStream(is2);
    SingleTonSerializationSolution deserialized2 = (SingleTonSerializationSolution) ois2
        .readObject();
    System.out.println(deserialized);
    System.out.println(deserialized2);
  }

}
        </pre>
      </li>
      <li>Console output</li>
    </ul>
    <img src="images/singletonSerializableSolution.jpg" alt="Serialization solution console ouput"/>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
