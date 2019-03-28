<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>提交调查信息</title>
<link href="images/xiao5u.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
   if Session("vote")="yes" or Option1="" then
      response.write "<div id='Notice'><div id='Noticeb'>错误：<p>请勿重复提交您的调查信息！<p><a href='javascript:history.go(-1)'>返回调查页面</a></div></div>"
   else
      Set rs = Server.CreateObject( "ADODB.Recordset" )
      sql = "select * from Result"
	  rs.open sql,conn,1,3
      rs.addnew
      '由题目序号逐一添加选项
      rsCount=request.form("rsCount")
      For i = 1 to rsCount
      if i=rsCount+1 then
      Exit For
      end if
      rs("topic"&i) = request.form("Option"&i)
      rs("qt"&i) = request.form("qt"&i)
      next
      '添加题目选项结束
      rs("addip")=request.ServerVariables("REMOTE_ADDR")
      rs("comment")=request.form("comment")
      rs.update
      rs.close
      Set rs=nothing
	  Session("vote")="yes"
      session.TimeOut=6
      response.write"<div id='Notice'><div id='Noticeb'>恭喜：<p>您的调查提交成功！<p><a href='javascript:window.close()'>关闭窗口</a></div></div>"
   end if
%>
</body>
</html>