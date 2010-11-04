<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>
<jsp:useBean  id="update" scope="page" class="update">
<jsp:setProperty name="update" property="*"/>
</jsp:useBean>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
try {
String s = request.getParameter("password");
if(s==null || s.equals("")) throw new Exception("错误，密码不能为空！！");
String stu_id = (String)session.getAttribute("id");
if(stu_id==null){response.sendRedirect("login.jsp");} 
update.setStu_id(stu_id);
update.update();
String d= update.getStu_id();
out.print("学生号:  "+d+"<br>");
String a = update.getPassword();
out.print("您的新密码:  "+a+"<br>");
String b= update.getTel();
out.print("您的电话:  "+b+"<br>");
String c= update.getE_mail();
out.print("E_mail:  "+c+"<br>");
%>
<p><a href="student.jsp">&lt;&lt;您已经更新成功,请返回</a> 
<p>
<%
}catch (Exception e){out.print(e.toString());}
%>
</body>

</html>
