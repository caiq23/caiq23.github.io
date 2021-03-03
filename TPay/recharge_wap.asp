<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../wap/inc/wap-fun.asp" -->
<!-- #include file="../wap/inc/wap_session.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>充值 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        
        <link rel="stylesheet" href="../wap/inc/wap_css.css">
        <style>
			.recharge_div{ background-color:#fff; padding-left:6%;}
			.recharge_div_0{padding-top:30px; text-align:right; padding-right:10%; margin-bottom:30px;}
			.recharge_div_0 a{ color:#333; font-size:14px;}
			.recharge_div_1{ padding-top:50px; color:#666;}
			.recharge_div_2{ padding-top:20px; padding-bottom:20px; line-height:50px;color:#333;font-size:26px;}
			.recharge_div_2 input{ height:50px; line-height:50px; width:80%; border:0px #eee solid; padding:10px; font-size:2em;font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif;}
		</style>
	</head>
<body>
<form action="add_payorder.asp" method="post" name="pay">
   <%
   
   this_page="recharge_wap"
  
   'call mark_remdon_num(remdon_num(4))
	'pay_idcode=get_remdon_num()
   %> 
    <div class="recharge_div">
    	
    	<div class="recharge_div_1">
        	充值金额
        </div>
        <div class="recharge_div_2">
        	￥<input name="tpaylog_money" id="tpaylog_money" value=""/>
            <input name="tpay_openid" type="hidden" value="<%=bbsset_tpay_openid%>" /> 
            <input name="out_trade_no" type="hidden" value="<%=dis_timenum()%>" />
            <input name="from_mobile" type="hidden" value="1" />
            
        </div>
    </div>
    <br>
    <input type="submit" class="submit_wap" value="下一步">
    <a href="javascript:void(0)" onClick="window.location.href='?'" class="pc_login">刷新重新支付</a>
	<div class="recharge_div_0">
        <a href="pay_log_wap.asp">充值记录</a>
    </div>
</form>
    <!-- #include file="../wap/inc/end.asp" -->     
        
        
	</body>

</html>
