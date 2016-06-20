<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>JSF Life Cycle</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
	<link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="jsfHome" class="lifeCycle pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  	<h4>JSF Life Cycle</h4>
  	<p/>
  	<img src="images/jsfLifeCycle.gif" alt="JSF Life Cycle"/>
  	<fieldset>
			<legend>Restore View</legend>
			In this phase JSF builds view, build event handlers and validators to UI components and saves view in
			FacesContext instance.
		</fieldset>
		<fieldset>
			<legend>Apply Request Values</legend>
			In this phase Components <i>decode</i> method will be called to get values from Request parameters.
			Components store these values. If any conversion fails errorMessage is generated and queued in FacesContext.
			If any component calls renderResponse() method then control goes to Render Response phase. 
		</fieldset>
		<fieldset>
			<legend>Process Validations</legend>
			In this phase, components executes validators on the values stored in the components. If any validation
			fails errorMessage will be created and queued in FacesContext. FacesContext will display error messages
			in the same page.
		</fieldset>
		<fieldset>
			<legend>Update Model Values</legend>
			In this phase, Components update the values of Managed beans with the values stored locally in them.
		</fieldset>
		<fieldset>
			<legend>Invoke Application</legend>
			In this phase, application business logic will be executed like 
			<ul>
				<li>Form Submission</li>
				<li>Event Handling</li>
			</ul>
		</fieldset>
		<fieldset>
			<legend>Render Response</legend>
			In this phase, page will be rendered to user.
			<ul>
				<li>For initial request, components present in the page will be added to component tree 
				while rendering the page.</li>
				<li>If not initial request, component tree already contains component so no need to build again.</li>
			</ul>
		</fieldset>
  </div>
  <jsp:include page="../footer.jsp" /> 
  </body>
</html>
