<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>

<body bgcolor="#0099FF" text="#FFFFFF">
<%
String tea_id=request.getParameter("id");
session.setAttribute("id",String.valueOf(tea_id));
%>
<p align="center"><font color="#00FF00" size="+3" face="��������">���½�ʦ</font></p>
<p align="center">&nbsp;</p>
<form name="form1" method="get" action="TeacherSvlt">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="id" value="<%=tea_id%>">
  <table width="51%"  border="1" align="center">
    <tr> 
      <td width="33%">��ʦ����</td>
      <td width="67%"><input name="name" type="text" id="name"></td>
    </tr>
    <tr> 
      <td>����</td>
      <td><input name="password" type="password" id="password"></td>
    </tr>
    <tr> 
      <td>ְ��</td>
      <td><select name="title" size="1" id="title">
          <option>��ʦ</option>
          <option>����</option>
        </select></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit" value="�ύ">
  </p>
</form>
<p>&nbsp;</p>
<p><a href="getteacher.jsp">&lt;&lt;Back</a></p>
</body>
</html>
