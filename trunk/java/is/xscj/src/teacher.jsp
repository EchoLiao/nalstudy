<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage" %>
<html>	
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
String tea_id=(String)session.getAttribute("id");
%>
<p><font color="#00FF00" size="+3" face="��������">���Ѿ��ɹ���½,����ѡ�����¹��ܣ�</font></p>
<p align="center"><a href="MarkSvlt?id=<%=tea_id%>&action=choosestu">��ѡ����ѧ��&gt;&gt;</a> 
  <a href="MarkSvlt?id=<%=tea_id%>&action=public">�����ɼ�&gt;&gt;</a> 
</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp; </p>
<p><a href="login_confirm?action=logout">&lt;&lt;ע�� </a></p>
</body>
</html>
