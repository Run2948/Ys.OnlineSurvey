<!--#include file="inc/right.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=sysConfig%></title>
<link href="images/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td  bgcolor="#FFFFFF"><br>
	<table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	  <tr align="center" bgcolor="#F2FDFF">
        <td class="optiontitle" colspan="4">系统检测</td>	
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>后台操作管理员：</td>
        <td colspan="3"><%=session("admin_name")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="100">服务器名：</td>
        <td width="250"><%=Request.ServerVariables("SERVER_NAME")%></td>
        <td width="20%">服务器IP：</td>
        <td><%=Request.ServerVariables("LOCAL_ADDR")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>服务器端口：</td>
        <td><%=Request.ServerVariables("SERVER_PORT")%></td>
        <td>服务器时间：</td>
        <td><%=now%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>本文件绝对路径：</td>
        <td colspan="3"><%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>客户端IP：</td>
        <td><%=Request.ServerVariables("REMOTE_ADDR")%></td>
        <td>端口：</td>
        <td><%=Request.ServerVariables("REMOTE_PORT")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>浏览器版本：</td>
        <td colspan="3"><%=Request.ServerVariables("Http_User_Agent")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>脚本解释引擎：</td>
        <td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        <td>Jmail邮箱组件支持：</td>
        <td><%If IsObjInstalled("JMail.Message") Then%>
          Jmail4.3邮箱组件支持
            <%elseIf IsObjInstalled("JMail.SMTPMail") then%>
            Jmail4.2组件支持
            <%else%>
            不支持Jmail组件
          <%end if%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td bgcolor="#FFFFFF">FSO组件支持：</td>
        <td>
<%If IsObjInstalled("Scripting.FileSystemObject") then%>FSO支持
<%else%>不支持FSO组件
<%end if%>
<%Function IsObjInstalled(strClassString)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(strClassString)
If 0 = Err Then IsObjInstalled = true
Set xTestObj = Nothing
Err = 0
End Function
%></td>
        <td>CDONTS邮箱组件支持：</td>
        <td><%If IsObjInstalled("CDONTS.NewMail") then%>CDONTS邮箱组件支持
            <%else%>不支持CDONTS邮箱组件<%end if%></td>
      </tr>
    </table>
	<p>
    <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	  <tr align="center" bgcolor="#F2FDFF">
        <td class="optiontitle" colspan="2">系统信息</td>	
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="100"> 系统名称：</td>
        <td><%=sysConfig%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td > 程序版本：</td>
        <td>V3.2</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> 最新版本：</td>
        <td><!--请不要修改以下链接,可获取系统最新版本及通知--><script src="http://www.xiao5u.com/Notice/Survey.js"></script><!--请不要修改以上链接,可获取系统最新版本及通知--></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> 程序开发：</td>
        <td>校无忧科技</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> 官方网站：</td>
        <td><a href="http://www.xiao5u.com/" target="_blank">http://www.xiao5u.com/</a></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> 版权申明：</td>
        <td><a href="http://www.xiao5u.com/" target="_blank">1、本软件为试用软件，未经授权，不得向第三方提供用于商业使用；<br />
2、用户自由选择是否使用，在使用中出现问题和造成的损失校无忧将不承担任何责任；<br />
3、您可对本系统进行修改和美化，但必须保留完整的版权；<br />
4、本试用软件仅为测试所用，如需更多功能及技术服务，请购买商业版。 </a> <script src="http://s84.cnzz.com/stat.php?id=585346&web_id=585346" language="JavaScript"></script></td>
      </tr>
    </table>
	</td>
  </tr>
</table>
</body>
</html>