<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>score</title>
</head>
<jsp:useBean id="deter" scope="page" class="determine"/>
<body bgcolor="#0099FF" text="#FFFFFF" link="#00FF00">

<div align="center"> 
  <p>&nbsp;</p>
  <p><font color="#00FF00" size="+3" face="��������">ѡ���ÿγ̵�ѧ����</font></p>
  <p>&nbsp;</p>
  <table width="75%" border="1">
    <tr> 
      <td>ѧ������</td>
      <td>����ϵ</td>
      <td>�Ա�</td>
      <td>ѧ��</td>
      <td>Email</td>
      <td>Tel</td>
      <td>�ɼ�</td>
    </tr>
    <%
String class_id=request.getParameter("class_id");
String name=null;
String dep=null;
String sex=null;
int mark=0;
String e_mail=null;
String tel=null;
ResultSet rs=deter.getStudents2(class_id);
String stu_id=null;
while(rs.next()){
stu_id=rs.getString("id");
name=rs.getString("name");
dep=rs.getString("department");
sex=rs.getString("sex");
mark=rs.getInt("mark");
e_mail=rs.getString("e_mail");
tel=rs.getString("tel");
%>
    <tr> 
      <td><%=name%></td>
      <td><%=dep%></td>
      <td><%=sex%></td>
      <td><%=mark%></td>
      <td><%=e_mail%></td>
      <td><%=tel%></td>
      <td><a href="marking.jsp?stu_id=<%=stu_id%>&class_id=<%=class_id%> ">score</a></td>
    </tr>
<%
}
%>	
  </table>
  <p>&nbsp;</p>
  <p align="left"><a href="choosestu.jsp">&lt;&lt;Back </a></p>
</div>
</body>
</html>