<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ӽ�ʦ</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF" link="#66FF00">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");}         
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="�����п�">������ʦ</font></p>
<form name="form1" method="post" action="TeacherSvlt">
<input type="hidden" name="action" value="new">
  <p>&nbsp;</p>
  <div align="center">
    <table width="51%"  border="1">
      <tr> 
        <td width="33%">��ʦ����</td>
        <td width="67%"><input name="name" type="text" id="name"></td>
      </tr>
      <tr> 
        <td>��ʦ��</td>
        <td><input name="id" type="text" id="id"></td>
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
    <p>
      <input name="ȷ��" type="submit" id="ȷ��" value="�ύ">
    </p>
  </div>
  </form>

<p>&nbsp;</p>
<p><a href="getteacher.jsp">&lt;&lt;Back</a></p>


</body>
</html>
