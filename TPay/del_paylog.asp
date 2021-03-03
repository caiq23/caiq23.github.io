<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<!-- #include file="../inc/chk_session.asp" -->
<title>删除订单</title>
</head>
<body>
<%


	user_id=session_user_id
	del_pay_id=chk_num(trim_fun(request("del_pay_id")))
	
	

	if InStr(LCase(Request.ServerVariables("HTTP_USER_AGENT")),"mobile")>0 then
		goto_url=BBS_folder&"tpay/pay_log_wap.asp"
		session("goto_url")=pay_logurl
		from_mobile=1
	else
		goto_url=index_url&"e3.html"
		from_mobile=0
	end if
	
  sql="select * from BBS_Pay_Log where pay_user_id="& user_id &" and id="& del_pay_id &""
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,3

  call dperror("",from_mobile,rs.eof,"读取支付记录出错，或者该记录不属于您",goto_url)
  

  
  chk_out_trade_no=rs("tpaylog_out_trade_no2")
  %><!-- #include file="inc_chkstatus.asp" --><%
  call dperror("",from_mobile,get_status_num=2,"删除失败！该订单已支付成功，请返回重新点击支付，即可确认成功",goto_url)  
    
  pay_status=chk_num(rs("pay_status"))
  call dperror("",from_mobile,pay_status=2,"该记录已经成功支付，不能删除",goto_url)
  rs.update
  rs.delete
  if from_mobile=1 then
  	call dperror(goto_url,from_mobile,true,"删除支付记录成功","")  	
  else
  	call dperror("",0,true,"删除支付记录成功",goto_url)
  end if
  

%>

</body>
</html>
