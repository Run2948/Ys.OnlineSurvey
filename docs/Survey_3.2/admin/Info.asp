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
      response.write "<script language='javascript'>alert('��Ŀ " & trim(Request.Form("Topic")) & " �Ѵ��ڣ����飡');history.back(-1);</script>"
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
if (confirm("ȷ��Ҫɾ��������¼��ɾ����˼�¼�����޷��ָ���"))
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
      alert("����д��Ŀ���ݣ�")
      document.add.Topic.focus()
      document.add.Topic.select()
      return
     }
 
  if (document.add.TCount.value=="")
     {
      alert("����дѡ�������")
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
{event.returnValue=false;alert("����Ӣ��״̬����д���֣�")
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
          <td colspan="2"  class="optiontitle">�����Ŀ</td>
        </tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ�������</td>
		  <td align='left'><input name="TCount" type="text"  value="<%=TCount%>" size="6" maxlength="1" onChange="location.href='Info.asp?action=add&TCount='+add.TCount.value;" onMouseOut="if (value=='') {value='4'};if (value==' ') {value='4'};if(isNaN(this.value)){alert('ֻ���������֣�');this.value='4';}">  <input type="button" value="ȷ ��" name="BY">Ĭ��Ϊ4</td>
		</tr>
        <tr align="center" bgcolor="#F2FDFF">
          <td width="10%" align="right">��Ŀ���ݣ�</td>
          <td align="left"><textarea name="Topic" cols="60" rows="5" id="Topic" ></textarea></td>
        </tr>
		<%for i=1 to TCount%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ��<%=i%>��</td>
		  <td align='left'><input name="Option<%=i%>" type="text" id="Option<%=i%>" size="50"></td>
		</tr>
		<%next%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ͼƬ�ϴ���</td>
		  <td align='left'><input name="pic" type="text" id="pic" value="����Ŀ��ѡ���漰ͼƬ���ϴ����Ƶ��ı���" size="50" maxlength="100"> 
		  <iframe border=0 frameborder=0 framespacing=0 height=22 width=240 marginheight=0 marginwidth=0 name=new_pic noResize scrolling=no  src="upload.htm" vspale="0"></iframe></td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ�����ͣ�</td>
		  <td align='left'>	
		    <input type="radio" name="Y" value="10"> �ı���
	        <input type="radio" name="Y" value="20"> �ı�����
			<input type="radio" name="Y" value="6"> ������<br>
		    <input type="radio" name="Y" value="1"> ��ѡ��
	        <input type="radio" name="Y" value="2"> ��ѡ��
	        <input type="radio" name="Y" value="11"> �б�˵�<br>
		    <input type="radio" name="Y" value="3"> ��ѡ+����(�ı���)
	        <input type="radio" name="Y" value="4"> ��ѡ+����(�ı���)
		  </td>
		</tr>
        <tr align="center" bgcolor="#ebf0f7">
          <td  colspan="2" >
		     <INPUT TYPE="hidden" name="action" value="yes">
            <input type="button" name="Submit" value="�ύ" onClick="check()">
          	<input type="button" name="Submit2" value="����" onClick="history.back(-1)"></td>
        </tr>
		</FORM>
      </table> 
<%end if%>
<br>
<%if action="list" then%>
      <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="5"  class="optiontitle">��Ŀ�б�</td>
        </tr>
        <tr align="center"  bgcolor="#ebf0f7">
		  <td width="40">ѡ��</td>
          <td width="5%">���</td>
          <td width="60%">��Ŀ����</td>
          <td width="15%">��Ŀ����</td>
          <td width="20%">ִ�в���</td>
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
             response.write("��ѡ��")
           case "2" 
             response.write("��ѡ��")
           case "11" 
             response.write("�б�˵�")
           case "3" 
             response.write("��ѡ+����")
           case "4" 
             response.write("��ѡ+����")
           case "6" 
             response.write("������") 
           case else 
             response.write("�ı�����")
          end select
          %>
		  </td>
          <td align='center'><img src="images/edit.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">�޸�</a> | <img src="images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">ɾ��</a></td>
        </tr>
<%
rs.movenext 
next
%>
		<tr bgcolor="#F2FDFF">
		  <td colspan="12">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
        <tr align="center" bgcolor="#ebf0f7">
          <td colspan="5"> �ܹ���<font color="#ff0000"><%=rs.PageCount%></font>ҳ, <font color="#ff0000"><%=proCount%></font>����Ŀ, ��ǰҳ��<font color="#ff0000"><%=intCurPage%> </font><%if intCurPage<>1 then%><a href="?action=list">��ҳ</a>|<a href="?action=list&ToPage=<%=intCurPage-1%>">��һҳ</a>|<% end if
if intCurPage<>rs.PageCount then %><a href="?action=list&ToPage=<%=intCurPage+1%>">��һҳ</a>|<a href="?action=list&ToPage=<%=rs.PageCount%>"> ���ҳ</a><% end if%></span></td>
        </tr>
<%
else
%>
        <tr align="center" bgcolor="#ffffff">
          <td colspan="5">�Բ���Ŀǰ���ݿ��л�û�������Ŀ��</td>
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
		  <td colspan=2  class="optiontitle">�޸���Ŀ</td>
		</tr>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ�������</td>
		  <td align='left'><input name="TCount" type="text"  value="<%=TCount%>" size="6" maxlength="2" onChange="location.href='Info.asp?action=edit&id=<%=Tid%>&TCount='+add.TCount.value;" onKeyDown="onlyNum();">  <input type="button" value="ȷ ��" name="BX"> <input name="OldCount" type="hidden" value="<%=rs("TCount")%>"></td>
		</tr>
		<tr align="center" bgcolor="#F2FDFF">
		  <td width="10%" align="right">��Ŀ���ݣ�</td>
		  <td align="left"><textarea name="Topic" cols="60" rows="5" id="Topic"><%=rs("Topic")%></textarea></td>
		</tr>
		<%for i=1 to TCount%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ��<%=i%>��</td>
		  <td align='left'><input name="Option<%=i%>" type="text" id="Option<%=i%>" value="<%=rs("Option"&i)%>" size="50"></td>
		</tr>
		<%next%>
		<tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ͼƬ�ϴ���</td>
		  <td align='left'><input name="pic" type="text" id="pic" value="����Ŀ��ѡ���漰ͼƬ���ϴ����Ƶ��ı���" size="50" maxlength="100"> 
		  <iframe border=0 frameborder=0 framespacing=0 height=22 width=240 marginheight=0 marginwidth=0 name=new_pic noResize scrolling=no  src="upload.htm" vspale="0"></iframe></td>
		</tr>
	    <tr align='center' bgcolor='#FFFFFF'>
		  <td align='right' bgcolor="#FFFFFF"> ѡ�����ͣ�</td>
		  <td align='left'>
		  <input type="radio" name="Y" value="10" <% if rs("Y")="10" then response.Write("checked") end if%>> �ı���
	      <input type="radio" name="Y" value="20" <% if rs("Y")="20" then response.Write("checked") end if%>> �ı�����
		  <input type="radio" name="Y" value="6" <% if rs("Y")="6" then response.Write("checked") end if%>> ������<br>
          <input type="radio" name="Y" value="1" <% if rs("Y")="1" then response.Write("checked") end if%>> ��ѡ��
	      <input type="radio" name="Y" value="2" <% if rs("Y")="2" then response.Write("checked") end if%>> ��ѡ��
	      <input type="radio" name="Y" value="11" <% if rs("Y")="11" then response.Write("checked") end if%>> �б�˵�<br>
		  <input type="radio" name="Y" value="3" <% if rs("Y")="3" then response.Write("checked") end if%>> ��ѡ+����(�ı���)
	      <input type="radio" name="Y" value="4" <% if rs("Y")="4" then response.Write("checked") end if%>> ��ѡ+����(�ı���)
		  </td>
		</tr>
		<tr align="center" bgcolor="#ebf0f7">
		  <td colspan="2">
		  <input type="hidden" name="action" value="yes">
          <input type="button" name="Submit2" value="�ύ" onClick="check()">
          <input type="button" name="Submit2" value="����" onClick="history.back(-1)">
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