<!--#include file="inc/right.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>校无忧管理系统</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	background-color: #ecf4ff;
}
.dtree {
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #0000ff;
	white-space: nowrap;
}
.dtree img {
	border: 0px;
	vertical-align: middle;
}
.dtree a {
	color: #333;
	text-decoration: none;
}
.dtree a.node, .dtree a.nodeSel {
	white-space: nowrap;
	padding: 1px 2px 1px 2px;
}
.dtree a.node:hover, .dtree a.nodeSel:hover {
	color: #0000ff;
}
.dtree a.nodeSel {
	background-color: #AED0F4;
}
.dtree .clip {
	overflow: hidden;
}
-->
</style>
<link href="images/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="images/dtree.js"></script>
</head>
<body>
<table width="96%"  border="0" cellpadding="10" cellspacing="0" align=center >
  <tr>
   <td valign="top" >
   <div class=menu>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
     <tr>
      <td height=25><a href="javascript: d.openAll();"><img src="images/view_detailed.gif" width="15" height="15" border="0" align="absmiddle" alt="展开列表"></a> <a href="javascript: d.closeAll();"><img src="images/view_tree.gif" width="15" height="15" border="0" align="absmiddle" alt="收缩列表"></a> | <a href="main.asp" target="mainFrame">系统首页</a> | <a href="../" target="_blank">问卷首页</a></td>
     </tr>
     <tr>
      <td>
	  <script type="text/javascript">
	  <!--
	  d = new dTree('d');
	  d.config.target="mainFrame";
	  d.add(0,-1,' 网站内容管理');
      d.add(1, 0, ' 管理员管理', 'Admin.asp?action=list');
	  d.add(2, 0, ' 问卷信息设置', 'SiteConfig.asp');
	  d.add(3, 0, ' 打印问卷信息[商业]', 'Buy/2-1.jpg');
	  d.add(3, 0, ' 手机问卷信息[商业]', 'http://www.xiao5u.com/Demo/Survey/wap.asp');
	  d.add(4, 0, ' 调查结果管理', '');
	  d.add(41, 4, ' 查看问卷统计', 'ResultTopic.asp');
	  d.add(42, 4, ' 全部问卷信息', 'Result.asp?action=list');
	  d.add(44, 4, ' 导出统计信息[商业]', 'Buy/3-1.jpg');
	  d.add(45, 4, ' 打印统计信息[商业]', 'Buy/3-1.jpg');
	  d.add(5, 0, ' 调查信息管理', '');
	  d.add(51, 5, ' 问题列表', 'Info.asp?action=list');
	  d.add(52, 5, ' 添加问题', 'Info.asp?action=add')	
	  d.add(8, 0, ' 其它功能[商业]', '');
	  d.add(81, 8, ' 多套问卷', 'Buy/4-1.jpg');
	  d.add(82, 8, ' 登录调查', 'Buy/4-2.jpg');	
	  d.add(83, 8, ' 定制功能', 'Buy.asp');	
	  d.add(6, 0, ' 文件数据管理[商业]', '');
	  d.add(61, 6, ' 初始化评价表[商]', 'Buy/6-1.jpg');
	  d.add(61, 6, ' 系统占用空间[商]', 'Buy/6-2.jpg');
	  d.add(62, 6, ' 备份数据信息[商]', 'Buy/6-3.jpg');	
	  d.add(63, 6, ' 恢复数据信息[商]', 'Buy/6-4.jpg');	
	  d.add(64, 6, ' 压缩数据信息[商]', 'Buy/6-5.jpg');
	  d.add(7, 0, ' 技术支持', '');
	  d.add(71, 7, ' 网站：校无忧科技', 'http://www.xiao5u.com');
	  d.add(72, 7, ' QQ：94009759', 'tencent://message/?uin=94009759&Site=校无忧-Xiao5u.Com&Menu=yes');		
	  d.add(73, 7, ' KF@Xiao5u.Com', 'mailto:kf@Xiao5u.Com');			
	  document.write(d);
	  //-->
	  </script>
	  </td>
     </tr>
    </table>
   </div>
   </td>
  </tr>
</table>
</body>
</html>