<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>
<jsp:useBean  id="update" scope="page" class="update">
<jsp:setProperty name="update" property="*"/>
</jsp:useBean>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">
<%
try {
String s = request.getParameter("password");
if(s==null || s.equals("")) throw new Exception("�������벻��Ϊ�գ���");
String stu_id = (String)session.getAttribute("id");
if(stu_id==null){response.sendRedirect("login.jsp");} 
update.setStu_id(stu_id);
update.update();
String d= update.getStu_id();
out.print("ѧ����:  "+d+"<br>");
String a = update.getPassword();
out.print("����������:  "+a+"<br>");
String b= update.getTel();
out.print("���ĵ绰:  "+b+"<br>");
String c= update.getE_mail();
out.print("E_mail:  "+c+"<br>");
%>
<p><a href="student.jsp">&lt;&lt;���Ѿ����³ɹ�,�뷵��</a> 
<p>
<%
}catch (Exception e){out.print(e.toString());}
%>
</body>

</html>
