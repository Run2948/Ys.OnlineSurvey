<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"--> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=sysConfig%></title>
<link href="images/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {margin: 0px;}
td   {font-size:14px;color:#ffffff;font-family:  Helvetica, sans-serif, "����";}
</style>
</head>
<body>
<table width="100%"  border="0" cellpadding="8" cellspacing="0" align=center>
  <tr style="background-image:url(images/top_back.gif);">
    <td width="22%" valign="middle" style="font-size:30px;height:60px"><img src="images/logo.gif"></td>
    <td width="78%" valign="bottom" align="right">��ǰʱ�䣺<span id="time">
<script>
document.getElementById('time').innerHTML=new Date().toLocaleString()+' ����'+'��һ����������'.charAt(new Date().getDay());
setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString()+' ����'+'��һ����������'.charAt(new Date().getDay());",1000);
</script></span></td>
  </tr>
  <tr style="background-image:url(images/top_bg.gif); height:16px">    
    <td width="40%" style="color:#000000;">��ӭ��<b><%=session("admin_name")%></b>! �����ڵ�¼����<%=sysConfig%>! </td>
    <td width="60%" align="right" style="color:#000000;"><a href="http://www.xiao5u.cn/" target="_blank">У���ǿƼ�</a> <a href="http://www.xiao5u.com/" target="_blank">У�������</a> <a href="http://www.xiao5u.net/" target="_blank">У��������</a>  <a href="http://www.z5u.net/" target="_blank">վ����</a> <a href="logout.asp" target="_parent">�˳�ϵͳ</a></td>
  </tr>
</table>
</body>
</html>