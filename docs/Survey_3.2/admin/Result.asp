<!--#include file="inc/right.asp"--> 
<!--#include file="inc/conn.asp"-->
<!--#include file="../inc/config.asp"-->
<%
if Request("wor")="del" then
id=request("id")
idArr=split(id,",")
for i=0 to ubound(idArr)
sql="delete from Result where id="&trim(idArr(i))
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
 sql="select * from Result" 
 rs.open sql,conn,3,3
 else
sql="select * from Result where id="&id&"" 
 rs.open sql,conn,1,2
end if
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
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=sysConfig%></title>
<link href="images/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
    <td bgcolor="#FFFFFF">
	<%if action="list" then%><BR>
        <table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
        <tr align="center" bgcolor="#F2FDFF">
          <td colspan="10" class="optiontitle">�ʾ�����б�</td>
        </tr>	  
		<tr align="center" bgcolor="#ebf0f7">
		  <td width="40">ѡ��</td>
		  <td width="15%">�ʾ���</td>
		  <td width="25%">�ύ��ַ</td>
		  <td width="25%">�ύʱ��</td>
          <td width="20%" colspan="2">����</td>
		</tr>
<%
 sql="select * from Result order by id desc"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 IF Not rs.eof Then
 proCount=rs.recordcount
	rs.PageSize=15
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
	if rs.EOF then     
	Exit For 
	end if
%>
<form name="del" action="" method="post">
		<tr align="center" bgcolor='#FFFFFF' onmouseover='this.style.background="#F2FDFF"' onmouseout='this.style.background="#FFFFFF"'>
          <td><input type="checkbox" name="id" value="<%=rs("id")%>"></td>
		  <td> <%=rs("id")%></td>
          <td> <%=rs("addip")%></td>
          <td> <%=rs("addtime")%></td>
          <td align="center"><img src="images/view.gif" align="absmiddle"><a href="?action=edit&id=<%=rs("id")%>">�鿴</a></td>
          <td align="center"><img src="images/drop.gif" align="absmiddle"><a href="javascript:DoEmpty('?wor=del&id=<%=rs("id")%>&action=list&ToPage=<%=intCurPage%>')">ɾ��</a></td>
<%
rs.MoveNext 
next
%>
		</tr>
		<tr bgcolor="#F2FDFF">
		  <td colspan="12">&nbsp;&nbsp;
		   <input name="chkall" type="checkbox" id="chkall" value="select" onclick=CheckAll(this.form)> ȫѡ
		   <input name="wor" type="hidden" id="wor" value="del" />
		   <input type="submit" name="Submit3" value="ɾ����ѡ" onClick="{if(confirm('ȷ��Ҫɾ����¼��ɾ���󽫱��޷��ָ���')){return true;}return false;}" />
		  </td>
		</tr>
		</form>
		<tr align="center" bgcolor="#ebf0f7">
           <form name="form1" method="post" action="?action=list">
		   <td colspan="10">
                <span style="font-size: 9pt;"> �ܹ���<font color="#ff0000"><%=rs.PageCount%></font>ҳ, <font color="#ff0000"><%=proCount%></font>���ʾ�, ��ǰҳ��<font color="#ff0000"> <%=intCurPage%> </font>
                <% if intCurPage<>1 then%>
                <a href="?action=list&ToPage=1">��ҳ</a>|<a href="?action=list&ToPage=<%=intCurPage-1%>">��һҳ</a>|
                <% end if
                if intCurPage<>rs.PageCount then %>
                <a href="?action=list&ToPage=<%=intCurPage+1%>">��һҳ</a>|<a href="?action=list&ToPage=<%=rs.PageCount%>"> ���ҳ</a>|
                <% end if%>
                ��ת��
                <input name="topage" type="text" size="2" value="<%=intCurPage%>">
                <input type="submit" name="go" value="ת��">
                </span>
            </td>
		  </form>
		</tr>
<%
else
%>
          <tr align="center" bgcolor='#FFFFFF'>
            <td colspan="10">�Բ���Ŀǰ���л�û�е�����Ϣ��</td>
          </tr>
<%
end if
rs.close
set rs=nothing
%>
      </table> 
<%end if%>
<br>
<%if action="edit" then
set rs=server.createobject("adodb.recordset") 
sql="select * from Result where id="&Request("id")
Lastid=Request("id")-1
Nextid=Request("id")+1
rs.open sql,conn,1,1
if not rs.eof Then
%>
<table width="96%"  border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
      
  <tr bgcolor="#FFFFFF">
    <td colspan="5" class="optiontitle" align="center">��<%=rs("id")%>���ʾ���Ϣ</td>
  </tr>
  <tr bgcolor="#ebf0f7">
    <td width="20%"> �ύ��ַ��<%=rs("addip")%></td>
    <td> �ύʱ�䣺<%=rs("addtime")%></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td colspan="5" class="title">�ʾ���Ϣ</td>
  </tr>
<%

 sqlTopic="select * from Info order by id asc" 
 set rsTopic=server.createobject("adodb.recordset") 
 rsTopic.open sqlTopic,conn,1,1
 NumC=rsTopic.recordcount '��ʾ��Ŀ
 Do while not rsTopic.eof
 For i = 1 to NumC
%>
  <tr bgcolor="#FFFFFF">

    <td colspan="5" class="td_title"> 
     <%=i%>��<%=rsTopic("Topic")%> <font color="#FF0000"><%=rs("topic"&i)%></font> <%=rs("qt"&i)%> </td>
  </tr>  
<%
rsTopic.movenext 
Next
Loop
rsTopic.close
set rsTopic=nothing
%>
  <tr bgcolor="#FFFFFF">
    <td colspan="5" class="td_title">
	 <input type="button" name="Submit" value="��һ��" onClick="location.href='Result.asp?action=edit&id=<%=Lastid%>'">
	 <input type="button" name="Submit" value="��һ��" onClick="location.href='Result.asp?action=edit&id=<%=Nextid%>'">
     <input type="button" name="Submit2" value="����" onClick="location.href='Result.asp?action=list'"></td>
  </tr> 
  </table>
<%
rs.close
set rs=nothing
end if
end if
%> 
    </td>
  </tr>
</table>
</body>
</html>