<%
session.TimeOut=60
if session("admin_name")="" then
response.write "<script language=JavaScript>" & chr(13) & "alert('����δ��¼���߳�ʱ,���¼��');"&"window.location.href = 'login.asp'"&" </script>"
response.end
end if
sysConfig="У�����ʾ����ϵͳ"
%>