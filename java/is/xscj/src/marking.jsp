<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>	
<body bgcolor="#0099FF">
<%
String stu_id=request.getParameter("stu_id");
String class_id=request.getParameter("class_id");
%>
 <p>&nbsp;</p>
<p align="center"><font color="#00FF00" size="+3" face="��������">ѧ���ɼ�</font></p>
<form method="post" action="MarkSvlt">
  <input type="hidden" name="action" value="marking">
  <input type="hidden" name="id" value="<%=stu_id%>">
  <input type="hidden" name="class_id" value="<%=class_id%>">
  <table width="75%" border="1" align="center">
    <tr> 
      <td width="41%">ѧ����</td>
      <td width="59%">�ɼ�</td>
    </tr>
    <tr> 
      <td><%=stu_id%></td>
      <td><input name="score" type="text" id="score"></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <div align="center">
    <input type="submit" name="Submit" value="�ύ">
  </div>
</form>
</body>
</html>
