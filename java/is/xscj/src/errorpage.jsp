<%@ page isErrorPage="true" contentType="text/html; charset=gb2312" language="java" import="java.io.*"  %>


<HTML>
<HEAD><TITLE>Output</TITLE><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></HEAD>

<BODY BGCOLOR="#0099FF" text="#FFFFFF" link="#00FF00">
<P align="center"><FONT COLOR="#660000" SIZE=2><B> 
  <%
	if (exception != null) {
		out.print(exception.toString());
	} else if (request.getAttribute("problem") != null) {
		String str =(String) request.getAttribute("problem");
		// byte[] tmpbyte=str.getBytes("ISO8859_1");
// str=new String(tmpbyte);
%>
  <%= str %> 
  <% } else { %>
  (No error code) 
  <% } %>
  </B></P>

<P><B>
<p> <a href="javascript:history.back();"> &lt;&lt;Back</a> </p>
</B></P>
</BODY>
</HTML>
