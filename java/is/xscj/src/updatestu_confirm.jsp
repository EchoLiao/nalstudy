<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>确认更新</title>
</head>
<jsp:useBean id="student" scope="page" class="student">
<jsp:setProperty name="student" property="*"/>
</jsp:useBean>
<body bgcolor="#0099FF" text="#FFFFFF" link="#66FF00">
<p align="center"> 
  <%
  try{
String id=(String )session.getAttribute("id");
student.setId(id);
String a = student.getSex();
String c=student.getName();
String d=student.getJiguan();
String e = student.getDep();
String f=student.getPassword();
if(c==null || c.equals("")) throw new Exception("错误，学生姓名不能为空！");
if(f==null || f.equals("")) throw new Exception("错误，学生密码不能为空！");
out.print("    Id 为"+id+"的学生<br>");
out.print("更改性别为： "+a+"<br>");
out.print("更改姓名为"+c+"<br>");
out.print("更改籍贯为 "+d);
student.updateStudent();
} catch(Exception e){out.print(e.toString());}
%>
</p>
<p>&nbsp;</p>
<p><a href="admin.jsp">&lt;&lt;Back</a></p>
</body>
</html>
