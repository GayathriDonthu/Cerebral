<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Create Table</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="createTable pageWidth">
    <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Different ways of creating table in Oracle</h4>
  <ul>
    <li>Simple table creation
      <pre>
CREATE TABLE STUDENT
(
 ID NUMBER(38,0)
,NAME VARCHAR2(256) NOT NULL
,DOB DATE NOT NULL
,COURSE VARCHAR2(256) NOT NULL
,CONSTRAINT STUDENT_PK PRIMARY KEY(ID)
);
</pre>
    </li>
    <li>Table with Primary key and Foreign key references
      <pre>
CREATE TABLE TECHNOLOGY_COURSE
(
 ID NUMBER(38,0)
,COURSE_NAME VARCHAR2(256) NOT NULL
,STUDENT_ID NUMBER(38,0)
,CONSTRAINT TECHNOLOGY_COURSE_PK PRIMARY KEY(ID)
,CONSTRAINT TECHNOLOGY_COURSE_FK FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(ID) ON DELETE CASCADE
);
      </pre>
    </li>
    <li>Table with primary key, foreign key and unique constraint
    <pre>
create table customer
 (
  id number(20)
 ,name varchar2(20)
 ,passport_fk number(20)
 ,constraint customer_pk primary key(id)
 ,constraint customer_fk foreign key(passport_fk) references passport(id)
 ,constraint custom_unq unique(passport_fk)
 );    
    </pre>
    </li>
  </ul>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
