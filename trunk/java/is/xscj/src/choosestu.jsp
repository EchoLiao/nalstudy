<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ѡ����ѧ��</title>
</head>
<jsp:useBean id="deter" scope="page" class="determine"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
String tea_id=(String)session.getAttribute("id");
%>
<div align="center">
  <p><font color="#00FF00" size="+3" face="��������">�������İ༶��ѧ�� </font></p>
  <p>&nbsp; </p>
  <table width="75%" border="1">
    <tr> 
      <td>�༶��</td>
      <td>�γ���</td>
      <td>ѡ��</td>
    </tr>
<%
String class_id=null;
String cour_name=null;
ResultSet rs=deter.getClass(tea_id);
while(rs.next()){
class_id=rs.getString("id");
cour_name=rs.getString("name");
%>	
    <tr> 
      <td><%=class_id%></td>
      <td><%=cour_name%></td>
      <td><a href="MarkSvlt?class_id=<%=class_id%>&cour_name=<%=cour_name%>&action=accept ">ѡ��</a></td>
    </tr>
<%
}
%>
  </table>
  <p>&nbsp;</p><p align="left"><a href="teacher.jsp">&lt;&lt;Back</a></p>
</div>
</body>
</html>
