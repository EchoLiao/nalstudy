<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ӿγ�</title>

</head>
<jsp:useBean id="course" scope="session" class="course"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#66FF00">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");} 
String cour_name="",cour_id="";        
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="�����п�">�����γ�</font></p>
<form name="form1" method="post" action="CourseSvlt">
<input type="hidden" name="action" value="new">
  <p>&nbsp;</p>
  <div align="center"></div>
  <table width="37%"  border="1" align="center">
    <tr> 
      <td width="37%">�γ���</td>
      <td width="63%"><input name="name" type="text" id="name"></td>
    </tr>
    <tr> 
      <td>�γ̺�</td>
      <td><input name="id" type="text" id="id"></td>
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
cour_name=rs.getString("name");
cour_id=rs.getString("id");
%>
          <option value="<%=cour_id%>"><%=cour_name%></option>
<%
}
%>		  
        </select>
      </td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit2" value="ȷ��">
  </p>
  <p>&nbsp;</p>
</form>
<p><a href="getcourse.jsp">&lt;&lt;Back </a></p>
</body>
</html>
