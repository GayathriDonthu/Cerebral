<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Unique Constraint</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="uniqueConstraint pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Sub Topics</h4>
  <ul class="subTopics">
    <li><a href="#columnLevel">Column level</a></li>
    <li><a href="#tableLevel">Table Level</a></li>
    <li><a href="#addingUnqToCol">Adding unique constraint if table is already created</a></li>
    <li><a href="#addingUnqToMulCol">Adding unique constraint to multiple columns if table is already created</a>
    <li><a href="#dropUnqConstraint">Drop unique constraint</a></li>
  </ul>
  <h4><a id="columnLevel"/>Unique constraint at column level</h4>
  <pre>
create table course
(
id number(38,0)
,course_name varchar2(256) not null unique
,constraint course_pk primary key(id)
);
    </pre>
  <h4><a id="tableLevel"/>Unique constraint at table level</h4>
  <pre>
create table course
(
 id number(38,0)
,name varchar2(256) not null
,constraint course_pk primary key(id)
,constraint course_unq unique(id,name)
);
  </pre>
  <h4><a id="addingUnqToCol"/>Adding unique constraint if table is already created</h4>
  <pre>
alter table course add constraint course_unq unique(id);
  </pre>
  <h4><a id="addingUnqToMulCol"/>Adding Unique constraint to multiple columns if table is already created</h4>
  <pre>
alter table course add constraint course_unq2 unique(id,name);
  </pre>
  <h4><a id="dropUnqConstraint"/>Drop unique constraint</h4>
  <pre>
alter table course drop constraint course_unq;
  </pre>  
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
