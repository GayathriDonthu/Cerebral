<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Definitions</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../images/favicon.ico" rel="shortcut icon" />
  <link rel="stylesheet" type="text/css" href="../css/global.css"/>
  </head>
  
  <body id="hadoop" class="impPoints pageWidth">
  <jsp:include page="../header.jsp" />
  <jsp:include page="topics.jsp" />
  <div class="examples">
  <fieldset>
    <legend>What is Hadoop?</legend>
    <ul>
      <li>Hadoop is a frameowrk</li>
      <li>Hadoop framework is group of components/tools to perform computation on large data sets</li>
      <li>Open source data management framework</li>
      <li>Hadoop allows processing of distributed large data sets using simple programming model called MapReduce</li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>MapReduce</legend>
    <ul>
      <li>Programming model to perform computation on distributed file system</li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>Hadoop Core Components</legend>
    <ul>
      <li>Reliable shared storage by HDFS</li>
      <li>Analysis system by MapReduce</li>
    </ul>  
  </fieldset>
  <fieldset>
    <legend>Why not RDBS?</legend>
    <ul>
      <li>To get constant Seek Time, Throughput in MapReduce.</li>
      <li>RDBMS is for low-latency retrieval and updates. MapReduce/Hadoop for WORM.</li>
      <li>B+ Tree implementation is not enough for TBs of data present in Big Data</li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>Data locality</legend>
    Strategy of performing computation where data is located is known as data locality.
    <b>Adv:</b>By moving computation to data we can reduce unnecessary data transfers in the network. So high bandwidth is
    not needed to perform computation on large data sets.
  </fieldset>
  <fieldset>
    <legend>Seek Time</legend>
    Time taken by disk pointer to locate the data in storage disk to 
  </fieldset>
  <fieldset>
    <legend>Scale-out storage</legend>
      <p>Scale-out storage is a network-attached storage (NAS) architecture in which the total amount of disk space can be 
      expanded as needed, even if some of the new drives reside in other storage arrays. If and when a given array reaches 
      its storage limit, another array can be added to expand the system capacity.</p>
      
      <p>Scale-out storage differs conceptually from the older scale-up approach. In a scale-up system, the network storage 
      was confined to a single form factor, while in a scale-out system, new hardware can be added and configured as the 
      need arises. The main advantage of the scale-out approach is cost containment, along with more efficient use of 
      hardware resources.</p>

      <p>Before scale-out storage became popular, enterprises often purchased storage arrays much larger than needed, to 
      ensure that plenty of disk space would be available for future expansion. If that expansion never occurred or turned 
      out less than expected, much of the originally purchased disk space went to waste. With the scale-out architecture, 
      the initial investment can be more modest; if the storage requirement expands beyond expectations, new arrays can be 
      added as needed, without limit.</p>
  </fieldset>
  </div>
  <jsp:include page="../footer.jsp" />
  </body>
</html>
