<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=SiteName%>_校无忧科技_Www.Xiao5u.Com</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="author" content="校无忧科技_Www.Xiao5u.Com">
<meta name="description" content="校无忧问卷调查系统_Www.Xiao5u.Com" />
<link href="images/xiao5u.css" rel="stylesheet" type="text/css">
<!--#include file=images/ini.sys -->
<script src="inc/check.js"></script>
<script src="inc/setday.js"></script>
</head>
<body>
<%if Ys=1 then %>
<table cellSpacing=0 cellPadding=0 align=center width="960px">
  <tr>
    <td colSpan=3 id="banner"><%=SiteName%></td>
  </tr>
</table>
<table width="960px" align="center" bgcolor="#FAFAFA">
<form id="form1" name="fm" method="post" action="submit.asp" onsubmit="return checkForm(this)"> 
 <tr>
  <td id="info" colspan="6"><%=Description%></td>
 </tr>
 <tr>
  <td id="info2" colspan="6"></td>
 </tr>
<%
 sql="select * from Info order by id asc"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 k=rs.recordcount
 if not rs.eof then
 For m = 1 to k
%>
 <tr onMouseOver="this.bgColor='#F0F7FF'" onMouseOut="this.bgColor='#FAFAFA'">
  <td colspan="4"><table width="98%" cellpadding="0" cellspacing="5" align="center">
    <tr>
      <td><b><%=m%>、<%=rs("Topic")%></b></td>
    </tr>
    <tr>
      <td>
	  <%if rs("Y")=11 then%>
      <select name="Option<%=m%>">
       <%for n=1 to rs("TCount")%>
	   <option value="·<%=rs("Option"&n)%>√"><%=rs("Option"&n)%></option>
	   <%next%>
      </select>
	  <%end if
	  if rs("Y")=6 then%>
	  <input name="Option<%=m%>" type="text" id="Option<%=m%>" onKeyDown="next()" onClick="fPopCalendar(event,this,this)" onFocus="this.select()" readonly="readonly"/>
	  <%end if
	  if rs("Y")=10 then%>
	  <input name="Option<%=m%>" type="text" id="Option<%=m%>" />
	  <%end if
	  if rs("Y")=20 then%>
	  <textarea name="Option<%=m%>" cols="60" rows="3" id="Option<%=m%>"></textarea>
	  <%end if
	  if rs("Y")=1 then%>
	  <%for n=1 to rs("TCount")%>
	  <input type="radio" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~!" /> <%=rs("Option"&n)%> <BR>
	  <%next%>
	  <%end if
	  if rs("Y")=2 then%>
	  <%for n=1 to rs("TCount")%>
	  <input type="checkbox" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~min:1" /> <%=rs("Option"&n)%> <BR>
	  <%next%>
	  <%end if
	  if rs("Y")=3 then%>
	  <%for n=1 to rs("TCount")%>
	  <%if n<>rs("TCount") then%>
	  <input type="radio" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~!" /> <%=rs("Option"&n)%> <BR>
	  <%else%>
	  <input type="radio" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~!" onCLick="document.all.qt<%=m%>.disabled=false"/> <%=rs("Option"&n)%> <input type='text' maxlength='128'  name='qt<%=m%>' disabled="disabled"/>
	  <%end if
	  next%>
	  <%end if
	  if rs("Y")=4 then%>
	  <%for n=1 to rs("TCount")%>
	  <%if n<>rs("TCount") then%>
	  <input type="checkbox" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~min:1" /> <%=rs("Option"&n)%> <BR>
	  <%else%>
	  <input type="checkbox" name="Option<%=m%>" value="·<%=rs("Option"&n)%>√" title="请选择“第<%=m%>题”~min:1" onCLick="document.all.qt<%=m%>.disabled=false"/> <%=rs("Option"&n)%> <input type='text' maxlength='128'  name='qt<%=m%>' disabled="disabled"/>
	  <%end if
	  next
	  end if%>
	  </td>
    </tr>
   </table>
  </td>
 </tr>
<%
rs.movenext 
Next
%>
  <tr>
    <td colspan="5" align="right">
	<input type="submit" name="Submit" value=" 提 交 "/>
	<input name="rsCount" type="hidden" id="rsCount" value="<%=k%>" /></td>
  </tr>
<%else%>
  <tr>
    <td colspan="5" align="center">没有问卷信息，请先添加问卷信息。</td>
  </tr>
<%end if%>
</form>
</table>
<%
rs.close
set rs=nothing
conn.close
set conn=nothing
%>
<table cellSpacing=0 cellPadding=0 align=center background="images/botbj.jpg" width="960px">
  <tr>
    <td height=60 align="center"><a href="http://www.xiao5u.com/" target="_blank">校无忧</a> <%=Copyright%> <script src="http://s84.cnzz.com/stat.php?id=585346&web_id=585346" language="JavaScript"></script></td>
  </tr>
</table>
<%else%>
<div id='Notice'><div id='Noticeb'>校无忧科技友情提示：<p>问卷调查已关闭！<p><a href='javascript:window.close()'>关闭窗口</a></div></div>
<%end if%>
</body>
</html>