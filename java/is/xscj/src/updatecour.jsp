<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ȷ���γ�</title>
</head>
<jsp:useBean id="course" scope="page" class="course"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#33FF00">
<p>
<%
String id="",name="";
id=request.getParameter("id");
%>
<form  method="post" action="CourseSvlt">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="id" value="<%=id%>">
</p>
<p align="center"><font color="#00FF00" size="+3" face="��������">���¿γ�</font></p>
<p align="center">&nbsp;</p>
  <table width="37%"  border="1" align="center">
    <tr> 
      <td width="37%">�γ���</td>
      <td width="63%"><input name="name" type="text" id="name"></td>
    </tr>
    <tr> 
      <td>ѧ��</td>
      <td><select name="mark" size="1" id="mark">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select></td>
    </tr>
    <tr> 
      <td>ϵ��</td>
      <td><select name="dep" size="1" id="dep">
          <option>public</option>
          <option>�����</option>
          <option>��еϵ</option>
          <option>����ϵ</option>
          <option>����ϵ</option>
        </select></td>
    </tr>
    <tr> 
      <td>Ԥ�޿�</td>
      <td><select name="prepare" size="1" id="prepare">
          <option value="0">��Ԥ�޿�</option>
          <%
ResultSet rs=course.getPrepares();
while(rs.next()) {
name=rs.getString("name");
id=rs.getString("id");
%>
          <option value="<%=id%>"><%=name%></option>
          
          <%
}
%>
        </select> </td>
    </tr>
  </table>
  <p>&nbsp;</p><p align="center"> 
    <input type="submit" name="Submit" value="�ύ">
  </p>
</form>
<p>&nbsp;</p>
<p><a href="getcourse.jsp">&lt;&lt;Back</a> </p>
</body>
</html>
