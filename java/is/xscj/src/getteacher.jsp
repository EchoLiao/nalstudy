<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>
<jsp:useBean id="teacher" scope="page" class="teacher">
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
String id="",name="",title="",password="";
%>
<p align="center"><font color="#00FF00" size="+3" face="�����п�">���н�ʦ</font></p>
<p><a href="addteacher.jsp">������ʦ</a></p>

  <p>&nbsp;</p>
  <table width="75%"  border="1" align="center">
    <tr> 
      <td>��ʦ��</td>
      <td>����</td>
      <td>ְ��</td>
      <td>����</td>
      <td>ɾ��</td>
      <td>����</td>
    </tr>
    <%
ResultSet rs=teacher.getAll();
while(rs.next()) {
id=rs.getString("id");
name=rs.getString("name");
title=rs.getString("title");
password=rs.getString("password");

%>
    <tr>
      <td><%=id%></td>
      <td><%=name%></td>
      <td><%=title%></td>
      <td><%=password%></td>
      <td><a href="TeacherSvlt?action=delete&id=<%=id%>">ɾ��</a></td>
      <td><a href="updatetea.jsp?id=<%=id%> ">����</a></td>
    </tr>
    <%
 }
 %>
  </table>
<p><a href="admin.jsp">&lt;&lt;BackTo Admin</a></p>
</body>
</html>
