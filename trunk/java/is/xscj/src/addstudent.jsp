<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����ѧ��</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");}
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="�����п�">����ѧ��</font></p>
<form name="form1" method="post" action="StudentSvlt">
<input type="hidden" name="action" value="new">
  <p>&nbsp;</p>
  <table width="49%" height="50"  border="1" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="48%">ѧ����</td>
      <td width="52%"><input name="id" type="text" id="id" ></td>
    </tr>
    <tr> 
      <td>ѧ������</td>
      <td><input name="name" type="text" id="name" ></td>
    </tr>
    <tr> 
      <td>����</td>
      <td><input name="password" type="password" id="password" maxlength="10"></td>
    </tr>
    <tr> 
      <td>ѧ������ϵ</td>
      <td><select name="dep" size="1" id="dep">
          <option>�����</option>
          <option>��еϵ</option>
          <option>����ϵ</option>
          <option>����ϵ</option>
        </select></td>
    </tr>
    <tr> 
      <td>�Ա�</td>
      <td><select name="sex" size="1" id="sex">
          <option>��</option>
          <option>Ů</option>
        </select></td>
    </tr>
    <tr> 
      <td>����</td>
      <td><select name="jiguan" size="1" id="jiguan">
          <option>����</option>
          <option>����</option>
          <option>ɽ��</option>
          <option>���ɹ�</option>
          <option>�ӱ�</option>
          <option>����</option>
        </select></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p align="center"> 
    <input type="submit" name="Submit" value="ȷ��">
  </p>
</form>
<a href="getStudent.jsp">&lt;&lt;Back </a> 
</body>
</html>
