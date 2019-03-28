<%
'session.timeout=6000
'Server.ScriptTimeOut=2000

dim conn,rs,sysConfig,db
db="../data/Xiao5u.mdb" '数据库文件位置
set conn=server.createobject("adodb.connection")
conn.open "driver={Microsoft Access Driver (*.mdb)};pwd=xiao5u;dbq=" &Server.MapPath(""&db&"")

Set rs = Server.CreateObject("ADODB.Recordset")
%>
