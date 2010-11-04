<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>	
<html>
<jsp:useBean id="check"  scope="page" class="checkEnrol">
<body bgcolor="#0099FF" text="#FFFFFF">
<p align="center"><font color="#00FF00" size="+3" face="华文行楷">学生成绩</font></p>
<p>&nbsp;</p>
<table width="463" border="1" align="center">
  <tr>
    <td width="207" height="34">课程</td>
    <td width="85">学分</td><td width="149">成绩</td></tr>
<%
String stu_id = (String)session.getAttribute("id");
if(stu_id==null){response.sendRedirect("login.jsp");}
String score,name;
int mark=0;
ResultSet rs =(ResultSet) request.getAttribute("rs");
while(rs.next()) {
score=rs.getString("score");
name=rs.getString("name");
mark=rs.getInt("mark");
if(score.equals("0") )
 score="成绩未给出";
%>
<tr>
    <td height="34"><%=name%></td><td><%=mark%></td><td><%=score%></td></tr>
<%
}
%>
</table>
<%
String temp=check.getTotalMark(stu_id);
%>
您的总得分为：<%=temp%>
<p><a href="student.jsp">&lt;&lt;<strong>Back</strong></a></p>
</body>
</html>
