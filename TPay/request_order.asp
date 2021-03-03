<!-- #include file="../inc/conn-bbs.asp" -->
<%
	Response.CodePage = 65001
	tpaylog_out_trade_no2=trim_fun(request("tpaylog_out_trade_no2"))
	sql="select * from BBS_Pay_Log where tpaylog_out_trade_no2='"& tpaylog_out_trade_no2 &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	if not rs.eof then
		pay_money=rs("pay_money")
		html=html&"<pay_money>"& pay_money &"</pay_money>"
		pay_proname=rs("pay_proname")
		html=html&"<pay_proname>"& pay_proname &"</pay_proname>"
		pay_status=rs("pay_status")
		html=html&"<pay_status>"& pay_status &"</pay_status>"
	end if

html="<xml>"& html &"</xml>"
response.Write(html)
%>