<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ȷ�ϸ���</title>
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
if(c==null || c.equals("")) throw new Exception("����ѧ����������Ϊ�գ�");
if(f==null || f.equals("")) throw new Exception("����ѧ�����벻��Ϊ�գ�");
out.print("    Id Ϊ"+id+"��ѧ��<br>");
out.print("�����Ա�Ϊ�� "+a+"<br>");
out.print("��������Ϊ"+c+"<br>");
out.print("���ļ���Ϊ "+d);
student.updateStudent();
} catch(Exception e){out.print(e.toString());}
%>
</p>
<p>&nbsp;</p>
<p><a href="admin.jsp">&lt;&lt;Back</a></p>
</body>
</html>
