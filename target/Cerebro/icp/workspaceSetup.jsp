<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>ICP</title>
    <meta http-equiv="keywords" content="enter,your,keywords,here" />
    <meta http-equiv="description" content="A short description of this page." />
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
    <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="icpHome">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Sub Topics</h4>
    <ul>
      <li><a href="#licenses">ICP Licenses</a></li>
      <li><a href="#antScripts">Ant Scripts</a></li>
      <li><a href="#deployRules">Deploy Rules</a></li>
      <li><a href="#loadingKB">Loading KB</a></li>
    </ul>
    <a id="licenses"/><h4>ICP Licenses</h4>
    <table>
      <tr>
        <td>ICES - PE</td>
        <td>0899298632cdcfc7b11723f1</td>
      </tr>
      <tr>
        <td>ICES - FE</td>
        <td>08992986c48f817204c48f69</td>
      </tr>
      <tr>
        <td>ICES - ODS</td>
        <td>08992986c952410794146108</td>
      </tr>
      <tr>
        <td>ICES - PPS</td>
        <td>0899298632466e2000d18528</td>
      </tr>
      <tr>
        <td>CM - PE</td>
        <td>089929862032ae44cd17b78b</td>
      </tr>
      <tr>
        <td>CM - FE</td>
        <td>08992986ad29053044101828</td>
      </tr>
    </table>
    <a id="antScripts"/><h4>Ant Scripts</h4>
    <ul>
      <li>freya/config - ant clean package</li>
      <li>freya/api - ant</li>
      <li>freya/impl - ant</li>
      <li>freya/impl - ant deploy.jboss</li>
      <li>freya/config - ant prepJBoss</li>
      <li>freya/congig - ant</li>
      <li>freya/config - ant prepMyEclipse</li>
      <li>freya/config - ant refreshdb</li>
    </ul>
    <a id="deployRules"/><h4>Deploy Rules</h4>
    <ul>
      <li>Check column entry in PRODUCT_INFO table. 
          Check INFO_VALUE column value for below mentioned INFO_PATH, INFO_NAME columns. It should be as follows:<br/>
          INFO_PATH=/rules<br/>
          INFO_NAME=eclipsepath<br/>
          INFO_VALUE=\rules\studio\eclipse<br/>
          If entry is not like this change it and commit in DB.</li>
      <li>Start the server</li>
      <li>freya/config - ant build.rules.install</li>
      <li>Open the application: System Settings - Rules Install - 
      Browse (freya/rules/projects/freya-rules-install/build/dist/rulesdeploy/workspace.zip</li>
      <li>Click on "Load"</li>
      <li>Check mark the loaded extract - click on install</li>
      <li>Rules will be deployed - Install status should be "completed" in the UI</li>
    </ul>
    <a id="loadingKB"/><h4>Loading KB</h4>
    <ul>
      <li>Start Bifrost. Go to Dev\Source\freyatp\freya\bifrost in cmd. Run startbifrost.bat</li>
      <li>Start the server</li>
      <li>Open C:\Dev\Source\freyatp\freya\bifrost\build\refreshdb\services.properties. 
      Change kb.extract.dir value to path of KB file. Give until folder. No need to give file name.</li>
      <li>Open application. KnowledgeBase Utilities - SmartLoad Import. File has to be identified automatically.
      If not check C:\Dev\Source\freyatp\freya\bifrost\build\refreshdb\bifrostlog file for errors.</li>
    </ul>
    </div>
    <jsp:include page="../footer.jsp" />
  </body>
</html>