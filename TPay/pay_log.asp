<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>
<link rel="stylesheet" href="inc/wdiii/common.css">

    <div class="Board_table paylog_table">
    	
    <table>
     <thead>
         <tr>
          <th>��</th>
          <th>������</th>
          <th>�û���</th>
          <th>���</th>          
          <th>����</th>
          <th>����ʱ��</th>
          <th>֧��ʱ��</th>
          <th>��ʽ</th>
          <th>��Ʒ����</th>
          <th>��ע</th>
          <th>״̬</th>
          <th>����</th>
        </tr>
     </thead>
  <tbody>
<%
  sql="select * from BBS_Pay_Log where pay_user_id="& session_user_id &" order by id desc"
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,1
page_size=bbsset_boardpagesize
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '��ȡ��ҳ�� 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
		allRecordCount=rs.RecordCount
	else
		%>
		
		    <tr>
      <td colspan="12">���޳�ֵ��¼!</td>
      </tr>
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
'response.Write("pay_paytype="&pay_paytype&"<br>")
pay_paytype_html=Get_paytype_name(pay_paytype)
tpaylog_out_trade_no2=rs("tpaylog_out_trade_no2")
tpaylog_out_trade_no=rs("tpaylog_out_trade_no")
pay_status=chk_num(rs("pay_status"))
pay_status_html="δ֪"
pay_url=""
select case pay_status
	case 1
		pay_status_html="<font color=""red"">δ֧��</font>"
		pay_url="http://www.tlu5.com/tlu5/api/tpay/?"
		pay_url=pay_url&"tpay_openid="&bbsset_tpay_openid
		pay_url=pay_url&"&out_trade_no="&tpaylog_out_trade_no2
		pay_url=pay_url&"&pay_idcode="&pay_idcode
		pay_url=pay_url&"&tpaylog_money="&pay_money
		pay_url="<a href="""& pay_url &""" class=""btn btn-warning"">֧��</a>"
		pay_url=pay_url&" <a href="""& BBS_folder &"tpay/del_paylog.asp?del_pay_id="& pay_id &""" onClick=""return makesure('�Ƿ�ɾ���ü�¼?\nɾ����������µ���');"" class=""btn btn-danger"">ɾ��</a>"
	case 2
		pay_status_html="<font color=""green"">֧���ɹ�</font>"
	case 3
		pay_status_html="<font color=""yellow"">֧��ʧ��</font>"
end select
pay_function=rs("pay_function")
pay_function_html="δ֪"
select case pay_function
	case 1
		pay_function_html="��ֵ"
end select
pay_addtime=rs("pay_addtime")
pay_paytime=rs("pay_paytime")
pay_demo=rs("pay_demo")


pay_user_num=""
sql2="select * from BBS_User where user_id="& pay_user_id &""
set rs2=bbsconn.execute(sql2)
if not rs2.eof then pay_user_num=rs2("user_num")
%>
    <tr>
      <td><%=i%></td>
      <td><%=tpaylog_out_trade_no2%></td>
      <td><%=pay_user_num%></td>
      <td><%=chknum2(pay_money)%></td>      
      <td><%=pay_function_html%></td>
      <td><%=howlong(pay_addtime)%></td>
      <td><%=howlong(pay_paytime)%></td>
      <td><%=pay_paytype_html%></td>
      <td><%=pay_proname%></td>
      <td><%=pay_demo%></td>
      <td><%=pay_status_html%></td>
      <td>
          <%=pay_url%>
         
      </td>
    </tr>
<%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
%>
    <tr>
      <td colspan="12"><ul class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></ul></td>
      </tr>
  </tbody>
</table> 
</div>
<div style="clear:both;"></div>
