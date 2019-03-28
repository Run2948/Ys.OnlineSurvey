<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<%
if Request("wor")="del" then
id=request("id")
idArr=split(id,",")
for i=0 to ubound(idArr)
sql="delete from Info where id="&trim(idArr(i))
conn.execute(sql)
next
end if
%>
<%
action=Request("action")
id=Request("id")
if action="yes" Then
 set rs=server.createobject("adodb.recordset") 
if id="" then
   set rsCheck = conn.execute("select Topic from Info where Topic='" & trim(Request.Form("Topic")) & "'")
     if not (rsCheck.bof and rsCheck.eof) then
      response.write "<script language='javascript'>alert('题目 " & trim(Request.Form("Topic")) & " 已存在，请检查！');history.back(-1);</script>"
      response.end
     end if
   set rsCheck=nothing
   sql="select * from Info" 
   rs.open sql,conn,3,3
   rs.addnew  
else
   sql="select * from Info where id="&id&"" 
   rs.open sql,conn,1,2
end if
rs("Topic")=Request("Topic")
rs("TCount")=Request("TCount")
rs("Y") = Request("Y")
Tnum=Request("TCount")
For i = 1 to Tnum
if i=Tnum+1 then     
Exit For 
end if
rs("Option"&i) = request.form("Option"&i)
next
 rs.update
 rs.close
set rs=nothing
 Response.Redirect "?action=list"
end if
%>
<script language=JavaScript>
<!--
function DoEmpty(params)
{
if (confirm("确定要删除这条记录吗？删除后此记录将被无法恢复！"))
window.location = params ;
}
//-->
</script>
<script language=JavaScript type=text/JavaScript>
function CheckAll(form)
{for (var i=0;i<form.elements.length;i++){
var e = form.elements[i];
if (e.name != 'chkall') e.checked = form.chkall.checked;
}
}
</script>
<html>
<head>
<title><%=sysConfig%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="images/main.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function check()
{
  if (document.add.Topic.value=="")
     {
      alert("请填写题目内容！")
      document.add.Topic.focus()
      document.add.Topic.select()
      return
     }
 
  if (document.add.TCount.value=="")
     {
      alert("请填写选项个数！")
      document.add.TCount.focus()
      document.add.TCount.select()
      return
     }
	 
     document.add.submit()
}
</script>
<script language=javascript>
function onlyNum()
{
if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)||(event.keyCode==8)))
{event.returnValue=false;alert("请在英文状态下填写数字！")
}
}
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
<%if action="add" then	
TCount=int(request("TCount"))
if TCount=null or TCount=empty then
TCount=4
end if
%>
	<br>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <form name="add" method="post" action="Info.asp">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="2"  class="optiontitle">添加题目</td>
        </tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选项个数：</td>
		  <td align='left'><input name="TCount" type="text"  value="<%=TCount%>" size="6" maxlength="1" onChange="location.href='Info.asp?action=add&TCount='+add.TCount.value;" onMouseOut="if (value=='') {value='4'};if (value==' ') {value='4'};if(isNaN(this.value)){alert('只能输入数字！');this.value='4';}">  <input type="button" value="确 定" name="BY">默认为4</td>
		</tr>
        <tr align="center" bgcolor="#F2FDFF">
          <td width="10%" align="right">题目内容：</td>
          <td align="left"><textarea name="Topic" cols="60" rows="5" id="Topic" ></textarea></td>
        </tr>
		<%for i=1 to TCount%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选项<%=i%>：</td>
		  <td align='left'><input name="Option<%=i%>" type="text" id="Option<%=i%>" size="50"></td>
		</tr>
		<%next%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 图片上传：</td>
		  <td align='left'><input name="pic" type="text" id="pic" value="如题目或选项涉及图片，上传后复制到文本框" size="50" maxlength="100"> 
		  <iframe border=0 frameborder=0 framespacing=0 height=22 width=240 marginheight=0 marginwidth=0 name=new_pic noResize scrolling=no  src="upload.htm" vspale="0"></iframe></td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选择类型：</td>
		  <td align='left'>	
		    <input type="radio" name="Y" value="10"> 文本框
	        <input type="radio" name="Y" value="20"> 文本区域
			<input type="radio" name="Y" value="6"> 日期题<br>
		    <input type="radio" name="Y" value="1"> 单选题
	        <input type="radio" name="Y" value="2"> 多选题
	        <input type="radio" name="Y" value="11"> 列表菜单<br>
		    <input type="radio" name="Y" value="3"> 单选+其它(文本框)
	        <input type="radio" name="Y" value="4"> 多选+其它(文本框)
		  </td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td  colspan="2" >
		     <INPUT TYPE="hidden" name="action" value="yes">
            <input type="button" name="Submit" value="提交" onClick="check()">
          	<input type="button" name="Submit2" value="返回" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<%end if%>
<br>
<%if action="list" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="5"  class="optiontitle">题目列表</td>
        </tr>
        <tr align="center"  bgcolor="#ebf0f7">
		  <td width="40">选中</td>
          <td width="5%">序号</td>
          <td width="60%">题目标题</td>
          <td width="15%">题目类型</td>
          <td width="20%">执行操作</td>
        </tr>
		
<%
sql="select * from Info order by id desc"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 if not rs.eof then
 proCount=rs.recordcount
	rs.PageSize=20
     if not IsEmpty(Request("ToPage")) then
	    ToPage=CInt(Request("ToPage"))
		if ToPage>rs.PageCount then
		   rs.AbsolutePage=rs.PageCount
		   intCurPage=rs.PageCount
		elseif ToPage<=0 then
		   rs.AbsolutePage=1
		   intCurPage=1
		else
		   rs.AbsolutePage=ToPage
		   intCurPage=ToPage
		end if
	 else
		rs.AbsolutePage=1
		intCurPage=1
	 end if
	 intCurPage=CInt(intCurPage)
	 For i = 1 to rs.PageSize
	 if rs.eof then     
	 Exit For 
	 end if
%>
    <form name="del" action="" method="post">
		<tr align="center" bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
          <td><input type="checkbox" name="id" value="<%=rs("id")%>"></td>
		  <td width="5%"><%=rs("id")%></td>
          <td align='left' ><%=rs("Topic")%></td>
          <td align='center'>
          <%
          Dim Y
          Y=rs("Y")
          select case Y
           case "1"
             response.write("单选题")
           case "2" 
             response.write("多选题")
           case "11" 
             response.write("列表菜单")
           case "3" 
             response.write("单选+其它")
           case "4" 
             response.write("多选+其它")
           case "6" 
             response.write("日期题") 
           case else 
             response.write("文本区域")
          end select
          %>
		  </td>
          <td align='center'><img src="images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">修改</a> | <img src="images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">删除</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="12">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> 全选
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="删除所选" onClick="{if(confirm('确定要删除记录吗？删除后将被无法恢复！')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="5"> 总共：<font color="#ff0000"><%=rs.PageCount%></font>页, <font color="#ff0000"><%=proCount%></font>道题目, 当前页：<font color="#ff0000"><%=intCurPage%> </font><%if intCurPage<>1 then%><a href="?action=list">首页</a>|<a href="?action=list&ToPage=<%=intCurPage-1%>">上一页</a>|<% end if
if intCurPage<>rs.PageCount then %><a href="?action=list&ToPage=<%=intCurPage+1%>">下一页</a>|<a href="?action=list&ToPage=<%=rs.PageCount%>"> 最后页</a><% end if%></span></td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="5">对不起！目前数据库中还没有添加题目！</td>
        </tr>
<%
rs.close
set rs=nothing
end if
%>
      </table>
	  <br>
<%end if%>
<%if action="edit" then
set rs=server.createobject("adodb.recordset") 
Tid=Request("id")
sql="select * from Info where id="&Tid
rs.open sql,conn,1,1
if not rs.eof Then

TCount=int(request("TCount"))
if TCount=null or TCount=empty then
   TCount=rs("TCount")
end if
%>
<br>
	  <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
       <form name="add" method="post" action="Info.asp">
		<tr align="center" bgcolor="#F2FDFF">
		  <td colspan=2  class="optiontitle">修改题目</td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选项个数：</td>
		  <td align='left'><input name="TCount" type="text"  value="<%=TCount%>" size="6" maxlength="2" onChange="location.href='Info.asp?action=edit&id=<%=Tid%>&TCount='+add.TCount.value;" onKeyDown="onlyNum();">  <input type="button" value="确 定" name="BX"> <input name="OldCount" type="hidden" value="<%=rs("TCount")%>"></td>
		</tr>
		<tr align="center" bgcolor="#F2FDFF">
		  <td width="10%" align="right">题目内容：</td>
		  <td align="left"><textarea name="Topic" cols="60" rows="5" id="Topic"><%=rs("Topic")%></textarea></td>
		</tr>
		<%for i=1 to TCount%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选项<%=i%>：</td>
		  <td align='left'><input name="Option<%=i%>" type="text" id="Option<%=i%>" value="<%=rs("Option"&i)%>" size="50"></td>
		</tr>
		<%next%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 图片上传：</td>
		  <td align='left'><input name="pic" type="text" id="pic" value="如题目或选项涉及图片，上传后复制到文本框" size="50" maxlength="100"> 
		  <iframe border=0 frameborder=0 framespacing=0 height=22 width=240 marginheight=0 marginwidth=0 name=new_pic noResize scrolling=no  src="upload.htm" vspale="0"></iframe></td>
		</tr>
	    <tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> 选择类型：</td>
		  <td align='left'>
		  <input type="radio" name="Y" value="10" <% if rs("Y")="10" then response.Write("checked") end if%>> 文本框
	      <input type="radio" name="Y" value="20" <% if rs("Y")="20" then response.Write("checked") end if%>> 文本区域
		  <input type="radio" name="Y" value="6" <% if rs("Y")="6" then response.Write("checked") end if%>> 日期题<br>
          <input type="radio" name="Y" value="1" <% if rs("Y")="1" then response.Write("checked") end if%>> 单选题
	      <input type="radio" name="Y" value="2" <% if rs("Y")="2" then response.Write("checked") end if%>> 多选题
	      <input type="radio" name="Y" value="11" <% if rs("Y")="11" then response.Write("checked") end if%>> 列表菜单<br>
		  <input type="radio" name="Y" value="3" <% if rs("Y")="3" then response.Write("checked") end if%>> 单选+其它(文本框)
	      <input type="radio" name="Y" value="4" <% if rs("Y")="4" then response.Write("checked") end if%>> 多选+其它(文本框)
		  </td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="2">
		  <input type="hidden" name="action" value="yes">
          <input type="button" name="Submit2" value="提交" onClick="check()">
          <input type="button" name="Submit2" value="返回" onClick="history.back(-1)">
		  <input name="id" type="hidden" id="id" value="<%=rs("id")%>">
		  </td>
		</tr>
  		</FORM>
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