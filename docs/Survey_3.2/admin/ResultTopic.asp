<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=sysConfig%></title>
<link href="images/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
	<BR>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="3" class="optiontitle">问卷调查统计</td>
        </tr>
<%
 sqlTotal="select count(id) as TotalNum from Result"
 set rsTotal=server.createobject("adodb.recordset") 
 rsTotal.open sqlTotal,conn,1,1
 total=rsTotal("TotalNum")
 if total=0 then
%>	
		<tr>
          <td colspan="3" bgcolor="#ffffff">目前还没有问卷信息提交！</td>
        </tr>
<%
else
rsTotal.close
set rsTotal=nothing
%>
		<tr>
          <td colspan="3" bgcolor="#ffffff" align="right">有效答卷：<%=total%> 份</td>
        </tr>

<%
dim sqlInfo,rsInfo
sqlInfo="select * from Info order by id asc"
Set rsInfo= Server.CreateObject("ADODB.Recordset")
rsInfo.open sqlInfo,conn,1,1
if rsInfo.eof then
   response.Write("<tr align='center' bgcolor='#ffffff'><td  colspan='8'>还没有问卷信息，请先添加问卷信息。</td></tr>")
else
   For i = 1 to rsInfo.recordcount
   Cha="topic"&i
if rsInfo("Y")<>10 and rsInfo("Y")<>20 and rsInfo("Y")<>6 then
%>
		<tr bgcolor="#ebf0f7">
          <td colspan="3" class="title"><%=i%>、<%=rsInfo("Topic")%></td>
        </tr>
		<%for n=1 to rsInfo("TCount")%>	
		<tr bgcolor="#ffffff" onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
		  <td width="40%"> <%=rsInfo("Option"&n)%></td>
	      <td>
<%
 res="·"&rsInfo("Option"&n)&"√"
 sql="select count("&Cha&") as sum from Result where "&Cha&" like '%"&res&"%'"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 %>
           <font color="#ff0000"><%=rs("sum")%></font>票 （<%=FormatPercent(rs("sum")/total)%>）</td>
		  <td width="45%"><img src="images/vote.jpg" width=<%=rs("sum")%> height=10></td>
		</tr>
		<%next%>
		<%if rsInfo("Y")=3 or rsInfo("Y")=4 then%>	
		<tr bgcolor="#ffffff">
          <td colspan="3">
<b>商业版显示其它内容</b>
		  </td>
        </tr>
		<%end if%>	
<%
else if rsInfo("Y")=10 or rsInfo("Y")=20 or rsInfo("Y")=6 then
%>
		<tr bgcolor="#ebf0f7">
          <td colspan="3" class="title"><%=i%>、<%=rsInfo("Topic")%></td>
        </tr>
		<tr bgcolor="#ffffff">
          <td colspan="3">
<b>商业版显示详细内容</b>
		  </td>
        </tr>
<%
end if
end if
rsInfo.movenext
next
rsInfo.close
set rsInfo=nothing
rs.close
set rs=nothing
end if
end if
%>
      </table> 
    </td>
  </tr>
</table>
<br>
</body>
</html>