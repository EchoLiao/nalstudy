<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>
<jsp:useBean id="classp" scope="page" class="classp"/>
<body bgcolor="#0099FF" text="#FFFFFF">
<p>
  <%
String admin_id = (String)session.getAttribute("id"); 
if(admin_id==null){response.sendRedirect("login.jsp");} 
String name="";
String id="";
%>
</p>
<p align="center"><font color="#00FF00" size="+3" face="�����п�">�����༶ </font></p>
<form name="form1" method="post" action="ClassSvlt">
<input type="hidden" name="action" value="new">
  <table width="38%"  border="1" align="center">
    <tr> 
      <td width="29%">�༶��</td>
      <td width="71%"><input name="id" type="text" id="id2"> </td>
    </tr>
    <tr> 
      <td>��ʦ</td>
      <td><select name="tea_id" size="1" id="tea_id">
          <%
ResultSet rs = classp.getTeachers();
while(rs.next()) {
id=rs.getString("id");
name=rs.getString("name");
%>
          <option value="<%=id%>"><%=name%></option>
          <%
}
%>
        </select></td>
    </tr>
    <tr> 
      <td>�γ�</td>
      <td><select name="cour_id" id="cour_id">
          <%
rs= classp.getCourses();
while(rs.next()){
id=rs.getString("id");
name=rs.getString("name");	
	%>
          <option value="<%=id%>"><%=name%></option>
          <%
	}
	%>
        </select></td>
    </tr>
    <tr> 
      <td>����ID</td>
      <td><select name="room_id" size="1" id="room_id">
          <option>101</option>
          <option>102</option>
          <option>103</option>
          <option>104</option>
          <option>105</option>
          <option>201</option>
          <option>202</option>
          <option>203</option>
          <option>204</option>
          <option>205</option>
          <option>301</option>
          <option>302</option>
          <option>303</option>
          <option>304</option>
          <option>305</option>
          <option>306</option>
        </select></td>
    </tr>
    <tr> 
      <td>�Ͽ�ʱ��</td>
      <td><select name="cour_time" size="1" id="cour_time">
          <option value="Mon_1">����һ/һ��</option>
          <option value="Mon_2">����һ/����</option>
          <option value="Mon_3">����һ/����</option>
          <option value="Tues_1">���ڶ�/һ��</option>
          <option value="Tues_2">���ڶ�/����</option>
          <option value="Tues_3">���ڶ�/����</option>
          <option value="Wed_1">������/һ��</option>
          <option value="Wed_2">������/����</option>
          <option value="Wed_3">������/����</option>
          <option value="Thurs_1">������/һ��</option>
          <option value="Thurs_2">������/����</option>
          <option value="Thurs_3">������/����</option>
          <option value="Fri_1">������/һ��</option>
          <option value="Fri_2">������/����</option>
          <option value="Fri_3">������/����</option>
        </select></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit" value="�ύ">
  </p>
  <p>&nbsp;</p>
</form>
<a href="getClass.jsp">&lt;&lt;Back </a> 
</body>
</html>
