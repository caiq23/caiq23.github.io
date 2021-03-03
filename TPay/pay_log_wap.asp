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
        
        <link rel="stylesheet" href="../wap/inc/wap_css.css">
        <style>
			.pay_log_wap{ background-color:#fff; margin-top:5px;}
			.pay_log_wap li{ border-bottom:1px #eee solid;background-color:#fff; clear:both; padding:10px 20px 10px 20px;}
			.pay_log_wap li .right .money{font-size:1.5em;font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif;}
			.pay_log_wap li .right .status{font-size:12px; padding-top:0px;}			
			.pay_log_wap li .date{ color:#999; font-size:12px; padding-top:8px;}
		</style>
	</head>
<body>
   <%
   
   this_page="pay_log_wap"
  
   %> 
    <div class="pay_log_wap"> 
<%
  sql="select * from BBS_Pay_Log where pay_user_id="& session_user_id &" order by id desc"
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
do while not rs.eof
pay_id=rs("id")
pay_user_id=rs("pay_user_id")
pay_proname=rs("pay_proname")
pay_money=rs("pay_money")
pay_paytype=rs("pay_paytype")
pay_paytype_html=Get_paytype_name(pay_paytype)
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
		pay_url=pay_url&"&pay_idcode="&get_remdon_num()
		pay_url=pay_url&"&tpaylog_money="&pay_money
		pay_url="<a href="""& pay_url &""" class=""btn btn-warning"">支付</a>"
		pay_url=pay_url&" <a href="""& BBS_folder &"tpay/del_paylog.asp?del_pay_id="& pay_id &""" onClick=""return makesure('是否删除该记录?\n删除后可重新下单。');"" class=""btn btn-danger"">删除</a>"
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
    	<li onClick="window.location.href='pay_log_wap_detailed.asp?pay_id=<%=pay_id%>'">
            <div class="left">
				<%=pay_proname%>
                <div class="date"><%=howlong(pay_addtime)%></div>
            </div>
            <div class="right">				
                <div class="money"><%=chknum2(pay_money)%></div>
                <div class="status"><%=pay_status_html%></div>
            </div>
            <div class="clear_both"></div>
        </li>
<%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
%>
    </div>

    <!-- #include file="../wap/inc/end.asp" -->     
        
        
	</body>

</html>
