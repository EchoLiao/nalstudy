<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#0099FF" text="#00FF00" link="#CCFF00">  
<p>
  <%
String id = (String)session.getAttribute("id");

//if(stu_id==null){response.sendRedirect("login.jsp");}                                 
%>
  <font size="+2" face="�����п�">���Ѿ��ɹ�ͨ����֤! ������ʹ�����·���</font> </p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="58%"  border="0" align="center">
  <tr> 
    <td><a href="DisplayCourse.jsp">ѡ�޿γ�</a></td>
    <td><a href="StudentLoginSvlt?id=<%=id%>&action=checkmark">�쿴ѧ��</a></td>
    <td><a href="updateinformation.jsp">������Ϣ</a></td>
  </tr>
</table>
<p>&nbsp;</p><p>&nbsp;</p><p><a href="login_confirm?action=logout">&lt;&lt;ע�� </a></p>
</body>
</html>