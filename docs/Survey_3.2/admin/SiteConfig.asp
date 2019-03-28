<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<%
action=Request("action")
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
 sql="select * from config where id=1" 
 rs.open sql,conn,1,2  
 rs("SiteName")=Request("SiteName")
 rs("Description")=Request("Description")
 rs("YS")=Request("YS")
 rs("Copyright")=Request("Copyright")&" 技术支持：校无忧"
 rs.update 
 rs.close
set rs=nothing
response.write"<script language=JavaScript>alert('操作成功！');"
response.write"location.href='?SiteConfig.asp'</script>"
end if
%>
<html>
<head>
<title><%=sysConfig%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script LANGUAGE="JavaScript">
function check()
{
  if (document.form.SiteName.value=="")
     {
      alert("请填写问卷调查名称！")
      document.form.SiteName.focus()
      document.form.SiteName.select()
      return
     }
 
  if (document.form.Description.value=="")
     {
      alert("请填写问卷调查描述！")
      document.form.Description.focus()
      document.form.Description.select()
      return
     }
 
  if (document.form.Copyright.value=="")
     {
      alert("请填写问卷调查版权！")
      document.form.Copyright.focus()
      document.form.Copyright.select()
      return
     }
	 
     document.form.submit()
}
</script>
<link href="images/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
set rs=server.createobject("adodb.recordset") 
sql="select * from config where id=1"
rs.open sql,conn,1,2
if not rs.eof Then
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF"><br>
     <form method="POST" action="SiteConfig.asp" id="form" name="form" onSubmit="return check();">
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
		<tr align="center" bgcolor="#F2FDFF">
          <td width="100%" class="optiontitle" colspan="2">基本信息设置</td>	
        </tr>
    <tr> 
      <td align="right" bgcolor="#FFFFFF">问卷调查名称：</td>
      <td bgcolor="#FFFFFF"><input name="SiteName" type="text" id="SiteName" value="<%=rs("SiteName")%>" size="40" maxlength="50" onKeyDown="next()"> <font color="red">*</font></td>
    </tr>
	<tr> 
      <td align="right" bgcolor="#FFFFFF">问卷调查开关：</td>
      <td bgcolor="#FFFFFF"><input name="Ys" type="radio" value="1"<%if rs("YS")=1 then Response.Write("checked") end if%>>开
      <input name="Ys" type="radio" value="0"<%if rs("YS")=0 then Response.Write("checked") end if%>> 关</td>
    </tr>
    <tr> 
      <td align="right" bgcolor="#FFFFFF">问卷信息说明：</td>
      <td bgcolor="#FFFFFF"><textarea name="Description" cols="60" rows="6" id="Description" onKeyDown="next()"><%=rs("Description")%></textarea></td>
    </tr>
    <tr> 
      <td align="right" bgcolor="#FFFFFF">版权信息：</td>
      <td bgcolor="#FFFFFF"><textarea name="Copyright" cols="60" rows="3" id="Copyright" onKeyDown="next()"><%=rs("Copyright")%></textarea></td>
    </tr>
    <tr> 
      <td colspan="2" align="center" bgcolor="#FFFFFF"> <input type="hidden" name="action" value="yes"> <input type="button" name="Submit" value="保存" onClick="check()"></td>
    </tr>
      </table>
</form>
    </td>
  </tr>
</table>
<%
end if
%>
</body>
</HTML>