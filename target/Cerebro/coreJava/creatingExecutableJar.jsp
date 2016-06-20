<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Creating Executable Jar</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="coreJavaHome" class="creatingJar pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    Creating an Executable jar File

In Java, it is common to combine several classes in one .jar ("java archive") file.  Library classes are stored that way.  Larger projects (such as the Case Study in the AP program) use jar files.  You can create your own jar file combining several classes, too. 

jar files are created using the jar.exe utility program from JDK.  You can make your jar file runnable by telling jar.exe which class has main.  To do that, you need to create a manifest file.  A manifest is a one-line text file with a "Main-Class" directive.  For example:

Main-Class: Craps
This line must end with a newline. 

A jar file created with a main class manifest can be used both as a library and a runnable jar.  If you use it as a library, you can edit and compile any of the classes included in the jar, and add it to your project.  Then it will override the one in the jar file.

You can create a manifest file in any text editor, or even by using the MS-DOS echo command.  You can give your manifest file any name, but it's better to use something standard, such as manifest.txt. 

Once you have a manifest and all your classes have been compiled, you need to run JDK's jar.exe utility.  It is located in the JDKs bin folder, the same place where javac.exe and java.exe are.  jar.exe takes command-line arguments; if you run it without any arguments, it will display the usage information and examples.  You need

C\mywork> jar cvfm MyJarName.jar manifest.txt *.class
cvfm means "create a jar; show verbose output; specify the output jar file name; specify the manifest file name."  This is followed by the name you wish to give to your jar file, the name of your manifest file, and the list of .class files that you want included in the jar.  *.class means all class files in the current directory.

Actually, if your manifest contains only the Main-Class directive, you can specify the main class directly on the jar.exe's command line, using the e switch, instead of m.  Then you do not need a separate manifest file; jar will add the required manifest to your jar file for you. For example:

C\mywork> jar cvfe MyJarName.jar MyMainClass *.class
Below is a reference for creating a jar file in Eclipse and the detailed steps for doing this in Command Prompt and in JCreator.

Creating a jar File in Eclipse

In Eclipse Help contents, expand "Java development user guide" ==> "Tasks" ==> "Creating JAR files."  Follow the instructions for "Creating a new JAR file" or "Creating a new runnable JAR file."
The JAR File and Runnable JAR File commands are for some reason located under the File menu: click on Export... and expand the Java node.

Creating a jar File in JCreator

You can configure a "tool" that will automate the jar creation process.  You only need to do it once.
Click on Configure/Options.
Click on Tools in the left column.
Click New, and choose Create Jar file.
Click on the newly created entry Create Jar File in the left column under Tools.
Edit the middle line labeled Arguments: it should have
cvfm $[PrjName].jar manifest.txt *.class
Click OK.
Now set up a project for your program, create a manifest file manifest.txt or copy and edit an existing one.  Place manifest.txt in the same folder where the .class files go.  Under View/Toolbars check the Tools toolbar.  Click on the corresponding tool button or press Ctrl-1 (or Ctrl-n if this is the n-th tool) to run the Create Jar File tool.

With Windows Explorer, go to the jar file that you just created and double click on it to run.

Creating a jar File in Command Prompt

Start Command Prompt.
Navigate to the folder that holds your class files:
C:\>cd \mywork
Set path to include JDK bin.  For example:
C:\mywork> path c:\Program Files\Java\jdk1.7.0_25\bin;%path%
Compile your class(es):
C:\mywork> javac *.java
Create a manifest file and your jar file:
C:\mywork> echo Main-Class: Craps >manifest.txt
C:\mywork> jar cvfm Craps.jar manifest.txt *.class
or
C:\mywork> jar cvfe Craps.jar Craps *.class
Test your jar:
C:\mywork> Craps.jar
or
C:\mywork> java -jar Craps.jar
<br/>
<a href="http://www.skylit.com/javamethods/faqs/createjar.html" target="_blank">External Link</a>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
  </body>
</html>
