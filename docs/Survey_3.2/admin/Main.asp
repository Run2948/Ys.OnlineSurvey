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
        <td class="optiontitle" colspan="4">ϵͳ���</td>	
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>��̨��������Ա��</td>
        <td colspan="3"><%=session("admin_name")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="100">����������</td>
        <td width="250"><%=Request.ServerVariables("SERVER_NAME")%></td>
        <td width="20%">������IP��</td>
        <td><%=Request.ServerVariables("LOCAL_ADDR")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>�������˿ڣ�</td>
        <td><%=Request.ServerVariables("SERVER_PORT")%></td>
        <td>������ʱ�䣺</td>
        <td><%=now%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>���ļ�����·����</td>
        <td colspan="3"><%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>�ͻ���IP��</td>
        <td><%=Request.ServerVariables("REMOTE_ADDR")%></td>
        <td>�˿ڣ�</td>
        <td><%=Request.ServerVariables("REMOTE_PORT")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>������汾��</td>
        <td colspan="3"><%=Request.ServerVariables("Http_User_Agent")%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td>�ű��������棺</td>
        <td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        <td>Jmail�������֧�֣�</td>
        <td><%If IsObjInstalled("JMail.Message") Then%>
          Jmail4.3�������֧��
            <%elseIf IsObjInstalled("JMail.SMTPMail") then%>
            Jmail4.2���֧��
            <%else%>
            ��֧��Jmail���
          <%end if%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td bgcolor="#FFFFFF">FSO���֧�֣�</td>
        <td>
<%If IsObjInstalled("Scripting.FileSystemObject") then%>FSO֧��
<%else%>��֧��FSO���
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
        <td>CDONTS�������֧�֣�</td>
        <td><%If IsObjInstalled("CDONTS.NewMail") then%>CDONTS�������֧��
            <%else%>��֧��CDONTS�������<%end if%></td>
      </tr>
    </table>
	<p>
    <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
	  <tr align="center" bgcolor="#F2FDFF">
        <td class="optiontitle" colspan="2">ϵͳ��Ϣ</td>	
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="100"> ϵͳ���ƣ�</td>
        <td><%=sysConfig%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td > ����汾��</td>
        <td>V3.2</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> ���°汾��</td>
        <td><!--�벻Ҫ�޸���������,�ɻ�ȡϵͳ���°汾��֪ͨ--><script src="http://www.xiao5u.com/Notice/Survey.js"></script><!--�벻Ҫ�޸���������,�ɻ�ȡϵͳ���°汾��֪ͨ--></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> ���򿪷���</td>
        <td>У���ǿƼ�</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> �ٷ���վ��</td>
        <td><a href="http://www.xiao5u.com/" target="_blank">http://www.xiao5u.com/</a></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td> ��Ȩ������</td>
        <td><a href="http://www.xiao5u.com/" target="_blank">1�������Ϊ���������δ����Ȩ��������������ṩ������ҵʹ�ã�<br />
2���û�����ѡ���Ƿ�ʹ�ã���ʹ���г����������ɵ���ʧУ���ǽ����е��κ����Σ�<br />
3�����ɶԱ�ϵͳ�����޸ĺ������������뱣�������İ�Ȩ��<br />
4�������������Ϊ�������ã�������๦�ܼ����������빺����ҵ�档 </a> <script src="http://s84.cnzz.com/stat.php?id=585346&web_id=585346" language="JavaScript"></script></td>
      </tr>
    </table>
	</td>
  </tr>
</table>
</body>
</html>