<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���пγ�</title>
</head>
<jsp:useBean id="course" scope="page" class="course"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<div align="center">
  <p>
<%
String id="",name="",prepare="",dep="";
int mark=0;
%>
    <font color="#00FF00" size="+3" face="��������">���пγ�</font> </p>
  <p>&nbsp;</p>
  <p align="left"><a href="Addcourse.jsp"><font size="+1" face="��������"><strong>�����γ�</strong></font></a></p>
</div>
<div align="center">
  <table width="75%"  border="1">
    <tr> 
      <td>�γ̺�</td>
      <td>�γ���</td>
      <td>ѧ��</td>
      <td>Ԥ�޿�</td>
      <td>����ϵ</td>
      <td>ɾ��</td>
      <td>����</td>
    </tr>
<%
ResultSet rs=course.getCourse();
while(rs.next()) {
id=rs.getString("id");
name=rs.getString("name");
mark=rs.getInt("mark");
prepare=rs.getString("prepare");
dep=rs.getString("dep");

%>	
	<tr><td><%=id%></td><td><%=name%></td><td><%=mark%></td><td><%=prepare%></td>
	<td><%=dep%></td>
        <td><a href="CourseSvlt?action=delete&id=<%=id%>">ɾ��</a></td>
	<td><a href="updatecour.jsp?id=<%=id%> ">����</a></td></tr>
<%
}
%>	
	
  </table>
 
  </div>

<p align="left"><a href="admin.jsp">&lt;&lt;BackTo Admin</a></p>
</body>
</html>
