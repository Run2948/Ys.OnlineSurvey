<%
set rs=server.createobject("adodb.recordset") 
sql="select * from config where id=1"
rs.open sql,conn,1,1
if not rs.eof Then
SiteName=rs("SiteName")
Ys=rs("Ys")
Description=rs("Description")
Copyright=rs("Copyright")
end if
rs.close
set rs=nothing
%>