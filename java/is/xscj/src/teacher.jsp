<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage" %>
<html>	
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
String tea_id=(String)session.getAttribute("id");
%>
<p><font color="#00FF00" size="+3" face="方正舒体">您已经成功登陆,请您选择以下功能：</font></p>
<p align="center"><a href="MarkSvlt?id=<%=tea_id%>&action=choosestu">挑选您的学生&gt;&gt;</a> 
  <a href="MarkSvlt?id=<%=tea_id%>&action=public">公布成绩&gt;&gt;</a> 
</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp; </p>
<p><a href="login_confirm?action=logout">&lt;&lt;注销 </a></p>
</body>
</html>
