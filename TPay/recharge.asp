<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>
<%
sql="select * from BBS_User where user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_name=rs("user_name")
	user_id=rs("user_id")
	user_state=rs("user_state")
	login_times=rs("login_times")
	user_password=rs("user_password")
	user_addtime=rs("user_addtime")	
	user_img=rs("user_img")
	user_tel=rs("user_tel")
	user_qq=rs("user_qq")
	user_sign=rs("user_sign")
	qq_OpenID=rs("qq_OpenID")
	wx_OpenID=rs("wx_OpenID")
	user_sex=chk_num(rs("user_sex"))
	bbs_account_cash=rs("bbs_account_cash")
end if
user_state=CHK_num(user_state)
user_sign=trim_fun_3(user_sign)
bbs_account_cash=chk_num(bbs_account_cash)


'call mark_remdon_num(remdon_num(4))
'pay_idcode=get_remdon_num()

%>
<div id="bbsreg_div">
    <div class="reg_title">会员充值</div>
    <div class="reg_content">
    	<form action="tpay/add_payorder.asp" method="post" name="pay">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="30%">充值用户名：</td>
      <td  width="30%"><%=user_num%>
           
      </td>
      <td  width="40%">
      </td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">用户姓名：</td>
      <td  width="30%"><%=user_name%>
           
      </td>
      <td  width="40%">
      </td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">当前帐户余额：</td>
      <td  width="30%">
	  <%=chknum2(bbs_account_cash)%>      
      </td>
      <td  width="40%">
      </td>
    </tr>

<input name="tpay_openid" type="hidden" value="<%=bbsset_tpay_openid%>" /> 
<input name="out_trade_no" type="hidden" value="<%=dis_timenum()%>" />
    <tr>
      <td style="text-align:right;" width="30%">充值金额：</td>
      <td colspan="2">
        <div class="recharge">
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='1.00'">1元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='10.00'">10元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='30.00'">30元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='50.00'">50元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='100.00'">100元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='200.00'">200元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='300.00'">300元</a>
          <a href="javascript:void(0);" onClick="window.document.getElementById('tpaylog_money').value='500.00'">500元</a>  
          <br>        
          <input name="tpaylog_money" id="tpaylog_money" value="" placeholder="1以上的整数" />
          </div>
      </td>
      </tr>

    <tr>
      <td ></td>
      <td>
      <input type="submit" class="submit_style" value="开始充值">
      <a href="javascript:void(0)" onClick="window.location.href='?e2.html'">重新充值</a>
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
</div>
