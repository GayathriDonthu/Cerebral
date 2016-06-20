<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Inline List</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  <style>
   .examples > a {
      display: block;
      border: 1px solid;
      border-color: #aaa #000 #000 #aaa;
      width: 100px;
      background: #fc0;
      height: 30px;
      text-decoration: none;
      margin-left: 10px;
     }
   .examples > a:hover{
      position: relative;
      top: 1px;
      left: 1px;
      border-color: #000 #aaa #aaa #000;
    }
  </style>
  </head>

  <body id="htmlHome" class="pushButton pageWidth">
    <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <h4>Push Button - CSS</h4>
    <a href="#">Push Button</a>
    <pre>
      a {
      display: block;
      border: 1px solid;
      border-color: #aaa #000 #000 #aaa;
      width: 75px;
      background: #fc0;
      height: 30px;
      text-decoration: none;
     }
     a:hover{
      position: relative;
      top: 1px;
      left: 1px;
      border-color: #000 #aaa #aaa #000;
    }
    </pre>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
