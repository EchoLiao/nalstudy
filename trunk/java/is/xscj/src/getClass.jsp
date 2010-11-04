<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>所有班级</title>
</head>
<jsp:useBean id="cla" scope="page" class="classp">
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
String id="",tea_id="",cour_id="",room_id="",cour_time="",cour_name="",tea_name="";
%>
<div align="center">
  <p><font color="#00FF00" size="+3" face="方正舒体">所有班级</font></p>
  <p align="left"><font color="#00FF00" size="+1" face="方正舒体"><a href="AddClass.jsp">新增班级</a></font></p>
  <table width="75%" border="1">
    <tr> 
      <td>班级号</td>
      <td>教师</td>
	  <td>教师号</td>
      <td>课程</td>
	  <td> 课程号 </td>
      <td>教室ID</td>
      <td>上课时间</td>
      <td>删除</td>
      <td>更新</td>
    </tr>
    
<%
ResultSet rs =cla.getClasses();
while(rs.next()){
id=rs.getString("id");
tea_id=rs.getString("tea_id");
cour_id=rs.getString("cour_id");
room_id=rs.getString("room_id");
cour_time=rs.getString("cour_time");
cour_name=rs.getString("cour_name");
tea_name=rs.getString("tea_name");
%>	
	<tr> 
      <td><%=id%></td>
      <td><%=tea_name%></td>
	  <td><%=tea_id%></td>
      <td><%=cour_name%></td>
	  <td> <%=cour_id%></td>
      <td><%=room_id%></td>
      <td><%=cour_time%></td>
      <td><a href="ClassSvlt?action=delete&id=<%=id%>">删除</a></td>
      <td><a href="updateClass.jsp?id=<%=id%>&tea_id0=<%=tea_id%>&cour_time0=<%=cour_time%> ">更新</a></td>
    </tr>
	<%
	}
	%>
  </table>
  <p align="left"><a href="admin.jsp">&lt;&lt;Back to Admin</a></p>
</div>
</body>
</html>
