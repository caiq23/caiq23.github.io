<!--#include file="../Inc/conn.asp"-->
<!--#include file="Admin_check.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<style type="text/css">
<!--
body,td,th,div,a,h3,textarea,input{
	font-family: "宋体", "Times New Roman", "Courier New";
	font-size: 12px;
	color: #333333;
}
html{
	overflow-x:hidden;
	overflow-y:hidden;
}
.menuHtml{
	overflow-y:auto;
}
body {
	background-color: #FFFFFF;
	margin: 0px;
}
img{
	border: none;
}
form{
	margin: 0px;
	padding: 0px;
}
input{
	color: #000000;
	height: 22px;
	vertical-align: middle;
}
textarea{
	width: 80%;
	font-weight: normal;
	color: #000000;
}
a{
	text-decoration: underline;
	color: #666666;
}
a:hover{
	text-decoration: none;
}
.menuDiv,.menuDiv1{
	background-color: #FFFFFF;
}
.menuDiv1{
	postion:relative;bottom:0px;top:50;
}
.menuDiv h3,.menuDiv1 h3{
	font:bold 14px "Microsoft Yahei",sans-serif;color:#4B8303;
	padding-top: 5px;
	padding-right: 5px;
	padding-bottom: 5px;
	padding-left: 10px;
	background:url(images/tab_05.gif);
	margin: 0px;cursor:pointer;
}
.menuDiv1 h3 {color:#ff0000;}
.menuDiv ul,.menuDiv1 ul{
	margin: 0px;
	padding: 0px;
	list-style-type: none;
}
.menuDiv ul li,.menuDiv1 ul li{
	color: #666666;
	background:url(images/arrow_082.gif) 14px 6px no-repeat;background-color:#EEFCDD;
	padding: 5px 5px 5px 30px;
	font-size: 12px;
	height: 16px;border-bottom:1px solid #fff;
}
.menuDiv ul li a,.menuDiv1 ul li a{
	color: #666666;
	text-decoration: none;
}
.menuDiv ul li a:hover,.menuDiv1 ul li a:hover{	
	color: #ff0000;text-decoration: underline;
}
.red{
	color:#FF0000;
}
-->
</style>
<script language="javascript" src="js/menuswitch.js"></script>
</head>

<body>
<table width="177" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed">
      <tr>
        <td height="28"><img src="images/main_21.gif" border="0" usemap="#Map" /></td>
      </tr>
      <tr>
        <td style="background:url(images/main_23.gif) left top repeat-x;height:80px"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="45"><div align="center"><a href="Admin_Setting.asp" target="main"><img src="images/main_26.gif" name="Image1" width="40" height="40" border="0" /></a></div></td>
            <td><div align="center"><a href="Admin_User.asp" target="main"><img src="images/main_28.gif" name="Image2" width="40" height="40" border="0" id="Image2" /></a></div></td>
            <td><div align="center"><a href="http://www.laoy.net" target="_blank"><img src="images/main_31.gif" name="Image3" width="40" height="40" border="0" id="Image3" /></a></div></td>
          </tr>
          <tr>
            <td height="25"><div align="center" class="STYLE2"><a href="Admin_Setting.asp" target="main">网站配置</a></div></td>
            <td><div align="center" class="STYLE2"><a href="Admin_User.asp" target="main">用户管理</a></div></td>
            <td><div align="center" class="STYLE2"><a href="Admin_Guestbook.asp" target="main">留言管理</a></div></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td style="border-top:1px solid #B0D561;">
	<div class="menuDiv"> 
	  <h3>基本管理</h3> 	  
	  <ul> 	    
		<li><a href="Admin_Setting.asp" target="main">网站配置</a> | <a href="Admin_Admin.asp" target="main">管 理 员</a></li>
		<li><a href="Admin_Css.asp" target="main">风格管理</a> | <a href="admin_js.asp" target="main">外部调用</a></li>
		<li><a href="Admin_Label.asp" target="main">标签管理</a> | <a href="Admin_Ad.asp" target="main">广告管理</a></li>
	  </ul>
	</div>

	<div class="menuDiv"> 
	  <h3>文章管理</h3> 
	  <ul> 	    
		<li><a href="Admin_Class.asp" target="main">栏目管理</a> | <a href="Admin_Class.asp?action=add" target="main">添加</a></li>
		<li><a href="Admin_Article.asp" target="main">文章管理</a> | <a href="Admin_Article.asp?action=add" target="main">添加</a></li>
	  </ul>
	</div>

	<div class="menuDiv"> 
	  <h3>采集管理</h3> 
	  <ul> 	    
		<li><a href="Cai/Admin_ItemStart.asp" target="main">采集首页</a> | <a href="http://www.laoy.net/class_1.html" target="_blank">教程</a></li>
		<li><a href="Cai/Admin_ItemManage.asp" target="main">项目管理</a> | <a href="Cai/Admin_ItemAddNew.asp" target="main">添加</a></li>
		<li><a href="Cai/Admin_ItemFilters.asp" target="main">过滤管理</a> | <a href="Cai/Admin_ItemFilterAdd.asp" target="main">添加</a></li>
		<li><a href="Cai/Admin_ItemHistroly.asp" target="main">历史记录</a> | <a href="http://www.laoy.net/class_1.html" target="_blank">帮助</a></li>
		<li><a href="Cai/Admin_Itemlaoy.asp?action=LoadThis" target="main">规则导入</a> | <a href="Cai/Admin_Itemlaoy.asp" target="main">规则导出</a></li>
	  </ul>
	</div>
    <div class="menuDiv"> 
	  <h3>会员管理</h3> 
	  <ul> 	    
		<li><a href="Admin_User.asp" target="main">会员管理</a> | <a href="Admin_Group.Asp" target="main">等级管理</a></li>
	  </ul>
	</div>
    <div class="menuDiv"> 
	  <h3>辅助功能</h3> 
	  <ul> 
		<li><a href="Admin_Guestbook.asp" target="main">留言管理</a> | <a href="Admin_Pl.asp" target="main">评论管理</a></li>
        <li><a href="Admin_Link.asp" target="main">链接管理</a> | <a href="Admin_LinkClass.asp" target="main">链接栏目</a></li>
        <li><a href="Admin_Vote.asp" target="main">投票管理</a> | <a href="Admin_Vote.asp?action=add" target="main">投票添加</a></li>
        <li><a href="Admin_Key.asp" target="main">内链关键字管理</a> | <a href="Admin_Key.asp?action=add" target="main">添加</a></li>    
		<li><a href="Admin_xml.asp?action=google" target="main">生成sitemaps</a></li><%If laoyvip then%>
		<li><a href="Admin_Diypage.asp" target="main">单页管理</a> | <a href="Admin_Diypage.asp?action=add" target="main">添加</a></li><%End if%>
	  </ul>
	</div>
    <div class="menuDiv"> 
	  <h3>数据库管理</h3> 
	  <ul> 	    
		<li><a href="Admin_data.asp?action=SpaceSize" target="main">空间占用查看</a></li>
        <li><a href="Admin_data.asp?action=BackupData" target="main">数据库备份</a> | <a href="Admin_data.asp?action=RestoreData" target="main">恢复</a></li>
        <li><a href="Admin_data.asp?action=CompressData" target="main">数据库压缩</a></li>
	  </ul>
	</div>
    <div class="menuDiv"> 
	  <h3>插件管理</h3> 
	  <ul> 	    
        <!--#include file="Plug.asp"-->
	  </ul>
	</div>
    <div class="menuDiv1"> 
	  <h3>版权信息</h3> 
	  <ul> 	    
		<li>老y文章 版权所有</li>
		<li>官方网站:<a href="http://www.laoy.net" target="_blank">www.laoy.net</a></li>
		<li>联系QQ:22862559</li>
	  </ul>
	</div>
          </td>
      </tr>
    </table></td>
  </tr>
</table>


<map name="Map" id="Map">
<area shape="rect" coords="26,5,91,22" href="main.Asp?Sub=Main" target="main" alt="后台首页" />
<area shape="rect" coords="94,5,157,24" href="main.Asp?Sub=Logout" target="_top" alt="安全退出" />
</map><script language="javascript">
	var mSwitch = new MenuSwitch("menuDiv");
	mSwitch.setDefault(1);
	mSwitch.setPrevious(false);
	mSwitch.init();
</script><script src="http://my.laoy.net/app.asp?domain=<%=Request.ServerVariables("HTTP_HOST")&sitepath%>&version=<%=version%>"></script>
</body>
</html>