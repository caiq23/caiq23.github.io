<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="inc/wap-fun.asp" -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
	<title><%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">        
        <link rel="stylesheet" href="inc/wap_css.css">
        <script type="text/javascript" src="inc/wap.js"></script> 
    <script type="text/javascript" src="inc/jquery.min.js" charset="GB2312"></script> 
        
        
	</head>
	<%bt_show=chk_num(trim_fun(request("bt_show")))%>
	<body>
	  
    <div class="html5_body" id="html5_body"><div class="load_gif"><img src="img/load.gif"></div></div>
    
    <div class="wap_bottom_bar" id="html5_end">
    	<a href="javascript:void(0);" onClick="bt_show(0);">
            <img src="img/bar/0-2.png">
            <p>首页f</p>
        </a>
        <a href="javascript:void(0);" onClick="bt_show(1);">
        	<img src="img/bar/1-1.png">
            <p>版块</p>
        </a>
        <a href="post.asp">
        	<img src="img/bar/2-1.png">
            <p>发表</p>
        </a>
        <a href="javascript:void(0);" onClick="bt_show(3);">
        	<img src="img/bar/3-1.png">
            <p>消息</p> 
        </a>
        <a href="javascript:void(0);" onClick="bt_show(4);">
			<img src="img/bar/4-1.png">
            <p>我的 </p>
        </a>
    </div>
    
    <div id="end_error_html"></div>
    
    
    
	</body>
    
<script>
bt_show(<%=bt_show%>);
function bt_show(num){
var li = document.getElementById('html5_end').children;
    for(var i=0, len=li.length; i<len; i++) {
		li[i].className='active_off';
		li[i].getElementsByTagName("img")[0].src='img/bar/'+i+'-1.png';
    }
li[num].className='active_on';
li[num].getElementsByTagName("img")[0].src='img/bar/'+num+'-2.png';	


	switch(num)
{
	case 0:
		iframe_url="main.asp";
		break;
	case 1:
		iframe_url="board.asp";
		break;
	case 2:
		iframe_url="post.asp";
		break;
	case 3:
		iframe_url="msg.asp";
		break;
	case 4:
		iframe_url="info.asp";
		break;
}

$.ajaxSetup({
    'beforeSend' : function(xhr) {
        xhr.overrideMimeType('text/plain; charset=gb2312');
    }
});
$('#html5_body').load(iframe_url);
}



</script>

</html>

