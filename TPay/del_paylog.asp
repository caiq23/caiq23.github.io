<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<html>
<head>
<meta charset="gb2312">
<!-- #include file="../inc/chk_session.asp" -->
<title>ɾ������</title>
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

  call dperror("",from_mobile,rs.eof,"��ȡ֧����¼�������߸ü�¼��������",goto_url)
  

  
  chk_out_trade_no=rs("tpaylog_out_trade_no2")
  %><!-- #include file="inc_chkstatus.asp" --><%
  call dperror("",from_mobile,get_status_num=2,"ɾ��ʧ�ܣ��ö�����֧���ɹ����뷵�����µ��֧��������ȷ�ϳɹ�",goto_url)  
    
  pay_status=chk_num(rs("pay_status"))
  call dperror("",from_mobile,pay_status=2,"�ü�¼�Ѿ��ɹ�֧��������ɾ��",goto_url)
  rs.update
  rs.delete
  if from_mobile=1 then
  	call dperror(goto_url,from_mobile,true,"ɾ��֧����¼�ɹ�","")  	
  else
  	call dperror("",0,true,"ɾ��֧����¼�ɹ�",goto_url)
  end if
  

%>

</body>
</html>
