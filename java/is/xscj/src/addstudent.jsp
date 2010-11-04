<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>增加学生</title>
</head>
<body bgcolor="#0099FF" text="#FFFFFF">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");}
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="华文行楷">新增学生</font></p>
<form name="form1" method="post" action="StudentSvlt">
<input type="hidden" name="action" value="new">
  <p>&nbsp;</p>
  <table width="49%" height="50"  border="1" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="48%">学生号</td>
      <td width="52%"><input name="id" type="text" id="id" ></td>
    </tr>
    <tr> 
      <td>学生姓名</td>
      <td><input name="name" type="text" id="name" ></td>
    </tr>
    <tr> 
      <td>密码</td>
      <td><input name="password" type="password" id="password" maxlength="10"></td>
    </tr>
    <tr> 
      <td>学生所在系</td>
      <td><select name="dep" size="1" id="dep">
          <option>计算机</option>
          <option>机械系</option>
          <option>电子系</option>
          <option>数理系</option>
        </select></td>
    </tr>
    <tr> 
      <td>性别</td>
      <td><select name="sex" size="1" id="sex">
          <option>男</option>
          <option>女</option>
        </select></td>
    </tr>
    <tr> 
      <td>籍贯</td>
      <td><select name="jiguan" size="1" id="jiguan">
          <option>陕西</option>
          <option>河南</option>
          <option>山东</option>
          <option>内蒙古</option>
          <option>河北</option>
          <option>江苏</option>
        </select></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p align="center"> 
    <input type="submit" name="Submit" value="确定">
  </p>
</form>
<a href="getStudent.jsp">&lt;&lt;Back </a> 
</body>
</html>
