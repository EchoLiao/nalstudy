<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"><title>选报课程</title>
</head>
<jsp:useBean id="check" scope="page" class="checkEnrol">
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00" >
<p align="center"><font color="#00FF00" size="+3" face="方正舒体">您可以选报的课程为 </font></p>
<table border="1" align="center">
  <tr>
    <td width="54">课程号</td>
    <td width="54">课程名</td>
    <td width="57">预修课</td>
    <td width="58">系别</td>
    <td width="59">班级号</td>
    <td width="69">教室号</td>
    <td width="88">上课时间</td>
	 <td width="88">教师</td>
    <td width="83">选择</td>
  </tr>
  <p> 
    <%
String id = (String)session.getAttribute("id");
String cour_id,name,dep,prepare,class_id,room_id,cour_time;
String tea_name=null;
ResultSet rs=null;
rs=check.getCourse(id);
while(rs.next()){
cour_id=rs.getString("id");
name=rs.getString("name");
prepare=rs.getString("prepare");
dep=rs.getString("dep");
class_id=rs.getString("class_id");
room_id=rs.getString("room_id");
cour_time=rs.getString("cour_time");
tea_name=rs.getString("tea_name");
%>
  <tr>
    <td><%=cour_id%></td>
    <td><%=name%></td>
    <td><%=prepare%></td>
    <td><%=dep%></td>
    <td><%=class_id%></td>
    <td><%=room_id%></td>
    <td><%=cour_time%></td>
	<td><%=tea_name%></td>
    <td><a href="StudentLoginSvlt?action=enrol&id=<%=id%>&cour_id=<%=cour_id%>&class_id=<%=class_id%>&prepare=<%=prepare%>  ">注册</a> 
    </td>
  </tr>
  <%
}
%>
</table>
<p>&nbsp;</p>
<p><a href="student.jsp"></p> &lt;&lt;Back </a> </p>
</body>
</html>
