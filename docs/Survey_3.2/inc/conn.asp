<!--#include file="safe.asp"-->
<%
db="data/Xiao5u.mdb"
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "driver={Microsoft Access Driver (*.mdb)};pwd=xiao5u;dbq=" & Server.MapPath(db) 
%>