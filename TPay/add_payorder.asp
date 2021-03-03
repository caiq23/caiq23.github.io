<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<!-- #include file="../inc/chk_session.asp" -->
<title>生成订单</title>
</head>
<body>
<%

	modid=session_user_id
	pay_user_num=""
	sql2="select * from BBS_User where user_id="& modid &""
	set rs2=bbsconn.execute(sql2)
	if not rs2.eof then pay_user_num=rs2("user_num")
	pay_proname="充值-"&pay_user_num
	tpaylog_money=chk_num(trim_fun(request("tpaylog_money")))	
	out_trade_no=trim_fun(request("out_trade_no"))
	pay_idcode=trim_fun(request("pay_idcode"))
	tpay_openid=bbsset_tpay_openid
	from_mobile=chk_num(trim_fun(request("from_mobile")))
	
	call dperror("",from_mobile,len(tpay_openid)=0 or isnull(tpay_openid),"支付授权码出错",goto_url)
	call dperror("",from_mobile,tpaylog_money<0.01,"支付金额不能小于0.01",goto_url)
	tpaylog_money=chknum2(tpaylog_money)
	'call dperror("",from_mobile,tpaylog_money<1,"支付金额必须大于等于1",goto_url)
	call dperror("",from_mobile,len(out_trade_no)<>14 or isnull(out_trade_no),"生成的订单必须是14位数",goto_url)
	'call dperror("",from_mobile,len(pay_idcode)<>4 or isnull(pay_idcode),"验证码必须是4位数",goto_url)
	
		
	sql="select * from BBS_Pay_Log where tpaylog_out_trade_no2='"& out_trade_no &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror("",from_mobile,not rs.eof,"重复的订单号",goto_url)
	if rs.eof then
		rs.addnew
		rs("pay_user_id")=modid
		rs("pay_money")=tpaylog_money
		rs("tpaylog_out_trade_no2")=out_trade_no
		rs("pay_status")=1
		rs("pay_function")=1
		rs("pay_addtime")=thistime
		rs("pay_proname")=pay_proname
		rs.update
	end if
	
	pay_url="http://www.tlu5.com/tlu5/api/tpay/?"
	pay_url=pay_url&"tpay_openid="&tpay_openid
	pay_url=pay_url&"&out_trade_no="&out_trade_no
	'pay_url=pay_url&"&pay_idcode="&pay_idcode
	pay_url=pay_url&"&tpaylog_money="&tpaylog_money
	'pay_url=pay_url&"&tpay_proname="&Server.UrlEncode(Server.UrlEncode(pay_proname))
	Response.CodePage = 65001
	%><meta charset="utf-8"><%
	pay_proname=Server.UrlEncode(pay_proname)
	pay_proname=Server.UrlEncode(pay_proname)
	pay_url=pay_url&"&tpay_proname="&pay_proname
	
	response.Redirect(pay_url)
	response.End()

%>


</body>
</html>