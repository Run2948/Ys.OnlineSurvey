<!--#include file="inc/conn.asp"-->
<!--#include file="inc/md5.asp"-->
<% 
dim verifycode,verifycode2
verifycode=Session("pSN")
verifycode2=trim(Request.Form("verifycode"))
if verifycode<>verifycode2 then
response.write"<SCRIPT language=JavaScript>alert('���������֤�벻��ȷ��ע�⣺���ִ�Сд \n \n У���ǿƼ�-Www.Xiao5u.Com-������ʾ');"
response.write"location.href='Login.asp'</SCRIPT>"
founderr=true
else
session("pSN")=""
if request("action")="login" then
   Username=trim(request("admin_name"))
   Password=trim(request("admin_pass"))
end if
If Instr(Username,"or")<>0 or Instr(Password,"or")<>0 or Instr(Username,"and")<>0 or Instr(Password,"and")<>0Then
   response.write "<br><br><br><br><font size=2><center>û�±���˼Һ�̨��лл��<br>����һ�к���Ը���<br>У����-Www.Xiao5u.Com</font>"
else
set rs=server.createobject("adodb.recordset")
sql="select * from admin where Username='"&replace(Username,"'","''")&"' and Password='"&replace(md5(Password),"'","''")&"'"
rs.open sql,conn,1,3
    if rs.eof then
        response.write"<SCRIPT language=JavaScript>alert('��������û������������󡣷�����������!\n \n У���ǿƼ�-Www.Xiao5u.Com-������ʾ');"
        response.write"location.href='Login.asp'</SCRIPT>"
    else
		rs("LastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
		rs("LastLoginTime")=now()
		rs.update
		session.timeout=60*12
        session("admin_name")=request("admin_name")
        response.redirect "index.asp"
	end if 
rs.close
set rs=nothing
conn.close
set conn=nothing
end if
end if
%>