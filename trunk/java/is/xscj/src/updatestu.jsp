<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF" link="#33FF00">
<jsp:useBean id="stu" scope="request" class="student"/>
<p>
  <%
String stu_id=request.getParameter("id");
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="��������">����ѧ��</font></p>
<p align="center">&nbsp;</p>
<form  method="post" action="StudentSvlt">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="id" value="<%=stu_id%>">
  <table width="49%" height="50"  border="1" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="48%">ѧ������</td>
      <td width="52%"><input name="name" type="text"  id="name" ></td>
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
      <td><select name="sex" size="1" id="select">
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
        </select></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit" value="�ύ">
  </p>
</form>
<p>&nbsp;</p>
<p><a href="getStudent.jsp">&lt;&lt;Back</a></p>
  </body>
</html>
