<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����Ա��½</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF" link="#66FF00">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");}         
%>
  <font color="#00FF00" size="+2" face="�����п�">���Ծ��ɹ�ͨ����֤! �����Ը����������ݣ�</font></p>
<p> </p> </p>
<table align="center" >
  <tr> 
    <td><a href="getStudent.jsp">ѧ��&gt;&gt;</a> </td>
    <td ><a href="getteacher.jsp">��ʦ&gt;&gt; </a></td>
    <td><a href="getcourse.jsp">�γ�&gt;&gt;</a></td>
    <td><a href="getClass.jsp">�༶&gt;&gt;</a></td>
  </tr>
</table>
    
<p>&nbsp;</p><p>&nbsp;</p>
<p><a href="login_confirm?action=logout">&lt;&lt;ע�� </a> </div> </p>
</body>
</html>
