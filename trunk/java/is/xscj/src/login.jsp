<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
	<html>
	<head>
	<STYLE>A.menuitem {
    COLOR: menutext; TEXT-DECORATION: none
}
A.menuitem:hover {
    COLOR: highlighttext; BACKGROUND-COLOR: highlight
}
DIV.contextmenu {
    BORDER-RIGHT: 2px outset; BORDER-TOP: 2px outset; Z-INDEX: 999; VISIBILITY: hidden; BORDER-LEFT: 2px outset; BORDER-BOTTOM: 2px outset; POSITION: absolute; BACKGROUND-COLOR: buttonface
}

</STYLE>
<SCRIPT language=JavaScript>
function Year_Month(){ 
    var now = new Date(); 
    var yy = now.getYear(); 
    var mm = now.getMonth()+1; 
    var cl = '<font color="#0000df">'; 
    if (now.getDay() == 0) cl = '<font color="#c00000">'; 
    if (now.getDay() == 6) cl = '<font color="#00c000">'; 
    return(cl +  yy + '��' + mm + '��</font>'); }
 function Date_of_Today(){ 
    var now = new Date(); 
    var cl = '<font color="#ff0000">'; 
    if (now.getDay() == 0) cl = '<font color="#c00000">'; 
    if (now.getDay() == 6) cl = '<font color="#00c000">'; 
    return(cl +  now.getDate() + '</font>'); }
 function Day_of_Today(){ 
    var day = new Array(); 
    day[0] = "������"; 
    day[1] = "����һ"; 
    day[2] = "���ڶ�"; 
    day[3] = "������"; 
    day[4] = "������"; 
    day[5] = "������"; 
    day[6] = "������"; 
    var now = new Date(); 
    var cl = '<font color="#0000df">'; 
    if (now.getDay() == 0) cl = '<font color="#c00000">'; 
    if (now.getDay() == 6) cl = '<font color="#00c000">'; 
    return(cl +  day[now.getDay()] + '</font>'); }
 function CurentTime(){ 
    var now = new Date(); 
    var hh = now.getHours(); 
    var mm = now.getMinutes(); 
    var ss = now.getTime() % 60000; 
    ss = (ss - (ss % 1000)) / 1000; 
    var clock = hh+':'; 
    if (mm < 10) clock += '0'; 
    clock += mm+':'; 
    if (ss < 10) clock += '0'; 
    clock += ss; 
    return(clock); } 
function refreshCalendarClock(){ 
document.all.calendarClock1.innerHTML = Year_Month(); 
document.all.calendarClock2.innerHTML = Date_of_Today(); 
document.all.calendarClock3.innerHTML = Day_of_Today(); 
document.all.calendarClock4.innerHTML = CurentTime(); }
 var webUrl = webUrl; 
document.write('<table border="0" cellpadding="0" cellspacing="0"><tr><td>'); 
document.write('<table id="CalendarClockFreeCode" border="0" cellpadding="0" cellspacing="0" width="60" height="70" ');
document.write('style="position:absolute;visibility:hidden" bgcolor="#eeeeee">');
document.write('<tr><td align="center"><font ');
document.write('style="cursor:hand;color:#ff0000;font-family:����;font-size:14pt;line-height:120%" ');
if (webUrl != 'netflower'){ 
   document.write('</td></tr><tr><td align="center"><font ');
   document.write('style="cursor:hand;color:#2000ff;font-family:����;font-size:9pt;line-height:110%" ');
} 
document.write('</td></tr></table>'); 
document.write('<table border="0" cellpadding="0" cellspacing="0" width="61" bgcolor="#C0C0C0" height="70">');
document.write('<tr><td valign="top" width="100%" height="100%">');
document.write('<table border="1" cellpadding="0" cellspacing="0" width="58" bgcolor="#FEFEEF" height="67">');
document.write('<tr><td align="center" width="100%" height="100%" >');
document.write('<font id="calendarClock1" style="font-family:����;font-size:7pt;line-height:120%"> </font><br>');
document.write('<font id="calendarClock2" style="color:#ff0000;font-family:Arial;font-size:14pt;line-height:120%"> </font><br>');
document.write('<font id="calendarClock3" style="font-family:����;font-size:9pt;line-height:120%"> </font><br>');
document.write('<font id="calendarClock4" style="color:#100080;font-family:����;font-size:8pt;line-height:120%"><b> </b></font>');
document.write('</td></tr></table>');
document.write('</td></tr></table>'); 
document.write('</td></tr></table>'); 
setInterval('refreshCalendarClock()',1000);
</SCRIPT>
<script language="javascript">
<!--
function makearray(size)
{
this.length=size;
for(i=1;i<=size;i++)
{
this[i]=0
}
return this;
}
msg=new makearray(3)
msg[1]="��ã���ӭʹ��ѧ���μ�����ϵͳ������"
msg[2]="����ѡ���û����£�������ȷ���û��������룡��";
msg[3]="лл����ʹ�ã�����"
interval = 100;
seq = 0;
i=1;
function Scroll() {
document.tmForm.tmText.value = msg[i].substring(0, seq+1);
seq++;
if ( seq >= msg[i].length ) { seq = 0 ;i++;interval=900};
if(i>3){i=1};
window.setTimeout("Scroll();", interval );interval=100
} ;
//-->
</script>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312"; charset=gb2312">
	<title>��½</title>
 <SCRIPT Language = javascript>
 <!--
  //����ĸ�����ִ�����ϼ��
  function isValid()
  {	
  	//�����if�ж���佫����Ƿ������ʺ�����
  	if(frmLogin.id.value == "")
  	{	
  		window.alert("����������ʺŵ�����!"); 
  		//��ʾ������Ϣ
 		document.frmLogin.elements(0).focus();
  		//����������ʺ�������		
  		return  false;
  	}
  	
  	//�����if�ж���佫����Ƿ������ʺ�����
  	if(frmLogin.password.value == "")
  	{
  		window.alert("������������������!");
 		//��ʾ������Ϣ
  		document.frmLogin.elements(1).focus();
  		//�������������������
  		return  false;  //�뿪����
  	}
  
  	frmLogin.submit(); //�ͳ����е�����
 }
  -->
  </SCRIPT>		
<body bgcolor="#0099FF" OnLoad="Scroll()">
<form name="tmForm">
<input type="Text" name="tmText" size="40">
</form>
<p> 
  <%
 String getmessage = (String)	session.getAttribute("error");
 if (getmessage==null) {getmessage="";}           
 %>
  <p1><font color="red"><%=getmessage%></font></p1></p>
<p align="center"><font color="#33FF00" size="+4" face="�����п�">ѧ���μ�����ϵͳ</font></p>
<form name="frmLogin" method="post" action="http://localhost:8080/test/login_confirm" onSubmit="return isValid(this);">
  <p> 
  <div align="center"> 
    <table width="47%" height="232" border=1 align="center"  >
      <tr > 
        <td height="44" colspan="2">
<div align="center"><font color="#FFFFFF" size="+2" face="�����п�">��������</font></div></td>
      </tr>
      <tr > 
        <td><div align="center"><font color="#FFFFFF"><strong>�û�</strong></font><font color="#FFFFFF"><strong>��</strong></font></div></td>
        <td><input name="kind" type="radio" value="student" checked >
          <font color="#FFFFFF" size="+2" face="�����п�">ѧ�� </font> 
          <input type="radio" name="kind" value="teacher">
          <font color="#FFFFFF" size="+2" face="�����п�"> ��ʦ </font>
<input type="radio" name="kind" value="admin">
          <font color="#FFFFFF" size="+2" face="�����п�">����Ա</font></td>
      </tr>
      <tr > 
        <td width="27%"><div align="center"><strong><font color="#FFFFFF">��½��</font><font color="#FFFFFF">��</font></strong></div></td>
        <td width="73%"><input name="id" type="text" id="id" size="20" maxlength="20"></td>
      </tr>
      <tr> 
        <td><div align="center"><strong> <font color="#FFFFFF">���룺</font></strong></div></td>
        <td><input name="password" type="password" id="password" size="8" maxlength="8"></td>
      </tr>
      <tr > 
        <td colspan="2"><div align="center"> 
            <input type="submit" name="Submit" value="��½">
          </div></td>
      </tr>
    </table>
    <table>
    </table>    
  </div>
</form>
</body>
 	</html>
 	
 	