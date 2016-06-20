<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Oracle Error</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="sqlHome" class="error pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
    <div class="examples">
    <h4>Oracle Initializaion or shutdown in progress</h4>
    <pre>
SQL> Startup mount
ORA-01081: cannot start already-running ORACLE - shut it down first
SQL> shutdown abort
ORACLE instance shut down.
SQL>
SQL> startup mount
ORACLE instance started.

Total System Global Area 1904054272 bytes
Fixed Size                  2404024 bytes
Variable Size             570425672 bytes
Database Buffers         1325400064 bytes
Redo Buffers                5824512 bytes
Database mounted.
SQL> Show parameter control_files

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
control_files                        string      C:\APP\USER\ORADATA\ORACLEDB\C
                                                 ONTROL01.CTL, C:\APP\USER\FAST
                                                 _RECOVERY_AREA\ORACLEDB\CONTRO
                                                 L02.CTL
SQL> select a.member,a.group#,b.status from v$logfile a ,v$log b where a.group#=
b.group# and b.status='CURRENT'
  2
SQL> select a.member,a.group#,b.status from v$logfile a ,v$log b where a.group#=
b.group# and b.status='CURRENT';

MEMBER
--------------------------------------------------------------------------------

    GROUP# STATUS
---------- ----------------
C:\APP\USER\ORADATA\ORACLEDB\REDO03.LOG
         3 CURRENT


SQL> shutdown abort
ORACLE instance shut down.
SQL> startup mount
ORACLE instance started.

Total System Global Area 1904054272 bytes
Fixed Size                  2404024 bytes
Variable Size             570425672 bytes
Database Buffers         1325400064 bytes
Redo Buffers                5824512 bytes
Database mounted.
SQL> recover database using backup controlfile until cancel;
ORA-00279: change 4234808 generated at 01/21/2014 18:31:05 needed for thread 1
ORA-00289: suggestion :
C:\APP\USER\FAST_RECOVERY_AREA\ORACLEDB\ARCHIVELOG\2014_01_22\O1_MF_1_108_%U_.AR

C
ORA-00280: change 4234808 for thread 1 is in sequence #108


Specify log: {<RET>=suggested | filename | AUTO | CANCEL}
C:\APP\USER\ORADATA\ORACLEDB\REDO03.LOG
Log applied.
Media recovery complete.
SQL> alter database open resetlogs;

Database altered.
    </pre>
    </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
