<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ϣ</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF">
<div align="center">
  <p>
    <%
String stu_id = (String)session.getAttribute("id");
if(stu_id==null){response.sendRedirect("login.jsp");} 
%>
    <font color="#00FF00" size="+3" face="��������">�������ĸ�����Ϣ </font></p>
  <p>&nbsp; </p>
</div>
<form name="form1" method="post" action="StudentLoginSvlt">
  <input type="hidden" name="action" value="update">
   <input type="hidden" name="id" value="<%=stu_id%>">
  <table width="55%"  border="1" align="center">
    <tr>
      <td>�����룺</td>
      <td><input name="password1" type="password" id="password1"></td>
    </tr>
    <tr> 
      <td width="42%">ȷ�ϣ�</td>
      <td width="58%"> <input name="password2" type="password" id="password2" > </td>
    </tr>
    <tr> 
      <td>�绰��</td>
      <td> <input name="tel" type="text" id="tel2"> </td>
    </tr>
    <tr> 
      <td>E_mail:</td>
      <td> <input name="e_mail" type="text" > </td>
    </tr>
  </table>
  <p align="center">
    <label></label>
  </p>
  <p align="center">&nbsp;</p>
  <p align="center">
    <input type="submit" name="Submit" value="�ύ">
  </p>
</form>
<a href="student.jsp">&lt;&lt;Back </a> 
</body>
</html>
