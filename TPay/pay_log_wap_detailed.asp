<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../wap/inc/wap-fun.asp" -->
<!-- #include file="../wap/inc/wap_session.asp" -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="gb2312">
        
<title>充值记录 - <%=bbsset_sitename%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
        <script src="../inc/wdiii/index.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../wap/inc/wap_css.css">
        <style>
			.news_list{ background-color:#fff; margin-top:0px;margin-bottom:0px;}
			.news_list li{ padding:20px; border-bottom:1px #eee solid; clear:both;}
			.news_list li .left{ color:#777;}
			.news_list li .title{ font-size:16px;}
			.news_list li .content{ color:#999;}
			.money_log_detail_num{background-color:#fff; width:100%; text-align:center; padding:50px 0px 10px 0px; font-size:26px;}
			.money_log_detail_num img{ width:120px; height:120px;}
			.money_log_detail_num p{ color:#999; font-size:12px;}
			.btn-warning,.btn-danger{ width:80%; margin-left:10%;margin-top:20px; background-color:#ff0000; height:40px; line-height:40px; text-align:center; display:inline-block; color:#fff;}
			.btn-danger{ background:none; color:#333; border:1px #ccc solid; margin-bottom:30px;}
			
		</style>
	</head>
<body>
   <%
   
   pay_id=chk_num(trim_fun(request("pay_id")))	
   this_page="pay_log_wap"
  
   %> 
   
<%
  sql="select * from BBS_Pay_Log where id="& pay_id &""
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,1
page_size=bbsset_boardpagesize
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '获取总页码 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '设置本页页码 
		allRecordCount=rs.RecordCount
	else
		%>
    	<li>
            <div class="left">暂无充值记录!</div>
        </li>
		<%
	end if
i=1
call mark_remdon_num(remdon_num(4))
pay_idcode=get_remdon_num()
do while not rs.eof
pay_id=rs("id")
pay_user_id=rs("pay_user_id")
pay_proname=rs("pay_proname")
pay_money=rs("pay_money")
pay_paytype=rs("pay_paytype")
pay_paytype_html="未知"
select case pay_paytype
	case 1
		pay_paytype_html="支付宝"
	case 2
		pay_paytype_html="微信"
end select
tpaylog_out_trade_no2=rs("tpaylog_out_trade_no2")
tpaylog_out_trade_no=rs("tpaylog_out_trade_no")
pay_status=chk_num(rs("pay_status"))
pay_status_html="未知"
pay_url=""
select case pay_status
	case 1
		pay_status_html="<font color=""red"">未支付</font>"
		pay_url="http://www.tlu5.com/tlu5/api/tpay/?"
		pay_url=pay_url&"tpay_openid="&bbsset_tpay_openid
		pay_url=pay_url&"&out_trade_no="&tpaylog_out_trade_no2
		pay_url=pay_url&"&pay_idcode="&pay_idcode
		pay_url=pay_url&"&tpaylog_money="&pay_money
		pay_url="<a href="""& pay_url &""" class=""btn btn-warning"">支付</a>"
		pay_url=pay_url&"<br><a href="""& BBS_folder &"tpay/del_paylog.asp?del_pay_id="& pay_id &""" onClick=""return makesure('是否删除该记录?\n删除后可重新下单。');"" class=""btn btn-danger"">删除</a>"
	case 2
		pay_status_html="<font color=""green"">支付成功</font>"
	case 3
		pay_status_html="<font color=""yellow"">支付失败</font>"
end select
pay_function=rs("pay_function")
pay_function_html="未知"
select case pay_function
	case 1
		pay_function_html="充值"
end select
pay_addtime=rs("pay_addtime")
pay_paytime=rs("pay_paytime")
pay_demo=rs("pay_demo")


pay_user_num=""
sql2="select * from BBS_User where user_id="& pay_user_id &""
set rs2=bbsconn.execute(sql2)
if not rs2.eof then pay_user_num=rs2("user_num")
%>
     <div class="money_log_detail_num">
     	<%=chknum2(pay_money)%>
        <p><%=howlong(pay_addtime)%></p>
     </div> 
<div class="news_list">  
    
    	<li>
            <div class="left">操作帐号</div> 
            <div class="right"><%=pay_user_num%></div>
            <div class="clear_both"></div>
        </li>
    	<li>
            <div class="left">操作类型</div> 
            <div class="right">会员充值</div>
            <div class="clear_both"></div>
        </li>
    	<li>
            <div class="left">操作余额</div> 
            <div class="right"><%=chknum2(pay_money)%></div>
            <div class="clear_both"></div>
        </li>
    	<li>
            <div class="left">操作时间</div> 
            <div class="right"><%=howlong(pay_addtime)%></div>
            <div class="clear_both"></div>
        </li>
    	<li>
            <div class="left">支付时间</div> 
            <div class="right"><%=howlong(pay_paytime)%></div>
            <div class="clear_both"></div>
        </li>
     	<li>
            <div class="left">支付状态</div> 
            <div class="right"><%=pay_status_html%></div>
            <div class="clear_both"></div>
        </li>
    	<li class="height_auto">
            <div class="left">备注</div> 
            <div class="right"><%=pay_demo%></div>
            <div class="clear_both"></div>
        </li>
        
	</div>
</div>
<%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
%>
    <%=pay_url%>

    <!-- #include file="../wap/inc/end.asp" -->     
        
        
	</body>

</html>
