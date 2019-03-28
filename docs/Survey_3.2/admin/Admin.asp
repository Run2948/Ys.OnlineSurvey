<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/md5.asp"-->
<script language=Javascript>
<!--
function DoEmpty(params)
{
if (confirm("真的要删除这条记录吗？删除后此记录里的所有内容都将被删除并且无法恢复！"))
window.location = params ;
}
//-->
</script>
<%
if Request("wor")="del" then
sql="delete from Admin where id="&Request("id")
Conn.execute(sql)
Response.Redirect "?action=list"
end if
%>
<%
action=Request("action")
id=Request("id")
Username=Request("Username")
Password=Request("Password1")
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
if id="" then
   set rsCheck = conn.execute("select Username from Admin where Username='" & trim(Request.Form("Username")) & "'")
    if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('" & trim(Request.Form("Username")) & "用户名称已存在！');history.back(-1);</script>"
      response.end
     end if
	 set rsCheck=nothing
   sql="select * from Admin" 
   rs.open sql,conn,3,3
   rs.addnew 		'添加记录到数据表末端 
else
   sql="select * from Admin where id="&id&"" 
   rs.open sql,conn,1,2  
end if
 rs("Username")=Username
 rs("Password")=md5(Password)
 rs.update 		'更新数据表记录
 rs.close
set rs=nothing
 Response.Redirect "?action=list"
end if
%>
<html>
<head>
<title><%=sysConfig%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="images/main.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function check()
{

  if (document.add.Username.value=="")
     {
      alert("请输入帐户名！")
      document.add.Username.focus()
      document.add.Username.select()
      return
     }
  if (document.add.Password1.value=="")
     {
      alert("请输入您的密码！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value.length<6)
     {
      alert("请填写管理员密码(字符数在6-16位之间)！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value.length>16)
     {
      alert("请填写管理员密码(字符数在6-16位之间)！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value!=document.add.Password2.value)
     {
      alert("您输入的两次密码不相同！")
      document.add.Password2.focus()
      document.add.Password2.select()		
      return
     }
     document.add.submit()
}
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
	<%if action="add" then%>
	<br>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="Admin.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="2"  class="optiontitle">添加用户</td>
        </tr>
        <tr align="center" bgcolor="#F2FDFF">
          <td width="10%" align="right">用户名：</td>
          <td align="left"><input name="Username" type="text" id="Username"></td>
        </tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 登陆密码：</td>
		  <td align='left'><input name="Password1" type="password" id="Password1"> <font color="red">*</font>6-16个字符</td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 密码确认：</td>
		  <td align='left'><input name="Password2" type="password" id="Password2"> <font color="red">*</font></td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td  colspan="2" >
		     <INPUT TYPE="hidden" name="action" value="yes">
            <input type="button" name="Submit" value="提交" onClick="check()">
          	<input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
        </tr>
		</form>
      </table> 
    <%end if%>
	<br>
     <%if action="list" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="5"  class="optiontitle">用户列表</td>
        </tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td width="10%">序号</td>
          <td width="20%">用户名</td>
          <td width="25%">用户密码</td>
          <td width="20%">执行操作</td>
        </tr>
<%
set rs=server.createobject("adodb.recordset") 
sql="select * from Admin" 
rs.open sql,conn,1,1
do while not rs.eof
%>
        <tr align='center' bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
		  <td><%=rs("id")%></td>
          <td><%=rs("Username")%></td>
          <td><%=rs("Password")%></td>
          <td><%if rs("id")=1 then%>
          <IMG src="images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">修改</a> <IMG src="images/drop.gif" align="absmiddle">删除
          <%else%>
          <IMG src="images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">修改</a>  <IMG src="images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>')">删除</a>
          <%end if%></td>
        </tr>
<%
rs.movenext
loop
rs.close
set rs=nothing
%>
        <tr align="right" bgcolor="#ebf0f7">
          <td colspan="5"><a href="admin.asp?action=add">添加用户</a></td>
        </tr>
      </table> 
<%
end if
if action="edit" then
set rs=server.createobject("adodb.recordset") 
sql="select * from Admin where id="&Request("id")
rs.open sql,conn,1,1
if not rs.eof Then
%>
<br>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="admin.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=2  class="optiontitle">修改用户</td>
		</tr>
		<tr align="center" bgcolor="#F2FDFF">
          <td width="10%" align="right">用户名：</td>
          <td align="left"><input name="Username" type="text" id="Username" value="<%=rs("Username")%>"></td>
        </tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 登陆密码：</td>
		  <td align='left'><input name="Password1" type="password" id="Password1"> 
		  <font color="red">*</font>6-16个字符</td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 密码确认：</td>
		  <td align='left'><input name="Password2" type="password" id="Password2"> 
		  <font color="red">*</font></td>
		</tr>
	    <tr align="center" bgcolor="#ebf0f7">
		  <td colspan="2">
		   <input type="hidden" name="action" value="yes"> <input type="button" name="Submit" value="提交" onClick="check()">
           <input type="button" name="Submit2"value="返回" onClick="history.back(-1)"> <input name="id" type="hidden" id="id" value="<%=rs("id")%>">
		 </td>
	   </tr>
  	 </form>
  	</table>
<%
end if
end if
%>
    </td>
  </tr>
</table>
</body>
</html>