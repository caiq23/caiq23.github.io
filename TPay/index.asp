<!-- #include file="../inc/conn-bbs.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>支付反馈</title>

<!-- #include file="../inc/chk_session.asp" -->
<%
tpaylog_out_trade_no=chk_num(trim_fun(request.QueryString("tpaylog_out_trade_no")))
tpaylog_out_trade_no2=chk_num(trim_fun(request.QueryString("tpaylog_out_trade_no2")))
'pay_idcode=chk_num(trim_fun(request.QueryString("pay_idcode")))
pay_status=chk_num(trim_fun(request.QueryString("pay_status")))
pay_paytype=chk_num(trim_fun(request.QueryString("pay_paytype")))



if InStr(LCase(Request.ServerVariables("HTTP_USER_AGENT")),"mobile")>0 then
	pay_logurl=BBS_folder&"tpay/pay_log_wap.asp"
	session("goto_url")=pay_logurl
	from_mobile=1
else
	pay_logurl=index_url&"e3.html"	
	from_mobile=0
end if


'session_pay_idcode=chk_num(get_remdon_num())

'call dperror(pay_logurl,from_mobile,pay_idcode<>session_pay_idcode,"支付失败！返回的验证码不正确",pay_logurl)

call dperror(pay_logurl,from_mobile,pay_status<=0,"支付失败，支付状态出错",pay_logurl)
call dperror(pay_logurl,from_mobile,pay_paytype<=0,"支付失败，支付类型出错",pay_logurl)
call dperror(pay_logurl,from_mobile,bbsset_open_pay=2,"支付失败，本站已关闭支付功能",pay_logurl)

	sql="select * from BBS_Pay_Log where tpaylog_out_trade_no2='"& tpaylog_out_trade_no2 &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(pay_logurl,from_mobile,rs.eof,"支付失败，找不到订单号",pay_logurl)
	
	call dperror(pay_logurl,from_mobile,pay_status<>2 and pay_status<>3,"支付失败！支付状态出错",pay_logurl)

	call dperror(pay_logurl,from_mobile,chk_num(rs("pay_status"))>1,"支付失败！该订单已重复支付，请勿刷新",pay_logurl)
	rs("pay_status")=pay_status
	rs("pay_paytype")=pay_paytype
	rs("tpaylog_out_trade_no")=tpaylog_out_trade_no	
	rs("pay_paytime")=thistime		
	
	pay_function=chk_num(rs("pay_function"))
	pay_money=chk_num(rs("pay_money"))
	call dperror(pay_logurl,from_mobile,pay_money<=0,"支付失败！金额必须大于0",pay_logurl)
	
	
	'检查支付状态是否成功
	chk_out_trade_no=tpaylog_out_trade_no2
	%><!-- #include file="inc_chkstatus.asp" --><%
	call dperror(pay_logurl,from_mobile,get_status_num<>2,"支付失败！该订单没有支付成功",pay_logurl)
	
	
	rs.update
	pay_user_id=rs("pay_user_id")
	if pay_status=2 then
		select case pay_function
			case 1
				'会员充值  
	  
				sql="select * from BBS_User where user_id="& pay_user_id &""
				set rs=server.CreateObject("adodb.recordset")
				rs.open sql,bbsconn,1,3
				if not rs.eof then
					bbs_account_cash=chk_num(rs("bbs_account_cash"))+pay_money
					rs("bbs_account_cash")=chknum2(bbs_account_cash)
					rs.update
				end if
				call dperror(pay_logurl,from_mobile,true,"支付成功！请返回查看会员余额",pay_logurl)		
		end select
	end if
%>


</head>
<body>
<%	

'Response.Redirect(goto_url)
response.end

%>
</body>
</html>

