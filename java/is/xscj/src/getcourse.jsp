<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>所有课程</title>
</head>
<jsp:useBean id="course" scope="page" class="course"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<div align="center">
  <p>
<%
String id="",name="",prepare="",dep="";
int mark=0;
%>
    <font color="#00FF00" size="+3" face="方正舒体">所有课程</font> </p>
  <p>&nbsp;</p>
  <p align="left"><a href="Addcourse.jsp"><font size="+1" face="方正舒体"><strong>新增课程</strong></font></a></p>
</div>
<div align="center">
  <table width="75%"  border="1">
    <tr> 
      <td>课程号</td>
      <td>课程名</td>
      <td>学分</td>
      <td>预修课</td>
      <td>所在系</td>
      <td>删除</td>
      <td>更新</td>
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
        <td><a href="CourseSvlt?action=delete&id=<%=id%>">删除</a></td>
	<td><a href="updatecour.jsp?id=<%=id%> ">更新</a></td></tr>
<%
}
%>	
	
  </table>
 
  </div>

<p align="left"><a href="admin.jsp">&lt;&lt;BackTo Admin</a></p>
</body>
</html>
