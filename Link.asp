<!--#include file="Inc/conn.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=SiteTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=Sitekeywords%>" />
<meta name="description" content="<%=Sitedescription%>" />
<link href="<%=SitePath%>images/css<%=Css%>.css" type=text/css rel=stylesheet>

<script type="text/javascript" src="<%=SitePath%>js/main.asp"></script>
</head>
<body>
<div class="mwall">
<%=Head%>
<%=Menu%><div class="mw" style="margin-bottom:5px;height:500px;">
<div class="dh">
<%=search%>您现在的位置：<a href="<%=SitePath%>">首页</a> >> 友情链接列表
</div>
<div class="mw borderall" style="margin-top:5px;">
	<div class="link"><%Call Link(0,0,0,0)%>【<a href="javascript:void(0)" onClick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block';document.getElementById('fade').style.width = document.body.scrollWidth + 'px';document.getElementById('fade').style.height = document.body.scrollHeight + 'px';document.getElementById('light').style.left = (parseInt(document.body.scrollWidth) - 400) / 2 + 'px';">链接申请</a>】</div>
</div>
<div class="mw borderall" style="margin-top:5px;">
	<div class="link"><%Call Link(0,0,1,0)%></div>
</div>
</div>
<div id="light" class="white_content"> 
	<h5><span><a href="javascript:void(1)" onClick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img src="images/close.gif" /></a></span>链接申请</h5>
<iframe id="link" src="Reglink.asp" width="100%" height="170" SCROLLING="NO" FRAMEBORDER="0"></iframe>
</div> 
<div id="fade" class="black_overlay"></div> 
<%=Copy%>
</body>
</html>