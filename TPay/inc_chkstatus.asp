<%
	Path="http://www.tlu5.com/tlu5/api/tpay/chk_paystatus.asp?tpay_openid="& bbsset_tpay_openid &"&tpaylog_out_trade_no2="&chk_out_trade_no
	get_status_num=getHTTPPage(Path)
	if isnumeric(get_status_num) then
		get_status_num=chk_num(get_status_num)
	else
		get_status_num=0
	end if	
	
	Server.ScriptTimeOut=9999999
	Function getHTTPPage(Path)
		t = GetBody(Path)
		getHTTPPage=BytesToBstr(t,"GB2312")
	End function
	Function GetBody(chk_url)
		on error resume next
		Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
		With Retrieval 
		.Open "Get", chk_url, False, "", "" 
		.Send 
		GetBody = .ResponseBody
		End With 
		Set Retrieval = Nothing 
	End Function
	
	Function BytesToBstr(body,Cset)
		dim objstream
		set objstream = Server.CreateObject("adodb.stream")
		objstream.Type = 1
		objstream.Mode =3
		objstream.Open
		objstream.Write body
		objstream.Position = 0
		objstream.Type = 2
		objstream.Charset = Cset
		BytesToBstr = objstream.ReadText 
		objstream.Close
		set objstream = nothing
	End Function

%>