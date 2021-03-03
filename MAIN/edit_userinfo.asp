<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/chk_session.asp" -->
<script src="inc/wdiii/index.js" type="text/javascript"></script>
<link rel="stylesheet" href="inc/wdiii/common.css">
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
%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
    <div class="reg_title">编辑资料</div>
    <div class="reg_content">
    	<form action="inc/chk_edit_userinfo.asp?mydo=modok" method="post" name="edit" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="30%">用户名：</td>
      <td  width="30%"><%=user_num%>
      </td>
      <td  width="40%">
      </td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">当前帐户余额：</td>
      <td  width="30%">
	  <font color="red"><%=chknum2(bbs_account_cash)%></font>
      <a href="<%=index_url%>e2.html" class="btn btn-success">充值</a> 
      <a href="<%=index_url%>e3.html" class="btn btn-info">记录</a>     
      </td>
      <td  width="40%">
      </td>
    </tr>

<%session("login_idcode")=remdon_num(4)%>
<%if bbsset_open_qqlogin=1 then%>
    <tr>
      <td style="text-align:right;" width="30%">QQ快捷登录：</td>
      <td colspan="2">
        <%if len(qq_OpenID)>0 then%>
        当前已绑定QQ快捷登录，您可以<a href="inc/chk_edit_userinfo.asp?mydo=cancel_qq" onClick="return makesure('是否取消绑定QQ快捷登录?\n下次需要重新绑定');" style="color:red;">解除QQ快捷登录</a>
        <%else%>
        您还未绑定QQ快捷登录，立即绑定            
            <a href="<%=display_tlogin(1)%>"><img src="img/qq_login.gif"></a>
        <%end if%>
      </td>
      </tr>
<%end if%>
<%if bbsset_open_wxlogin=1 then%>
    <tr>
      <td style="text-align:right;" width="30%">微信快捷登录：</td>
      <td colspan="2">
        <%if len(wx_OpenID)>0 then%>
        当前已绑定微信快捷登录，您可以<a href="inc/chk_edit_userinfo.asp?mydo=cancel_wx" onClick="return makesure('是否取消绑定微信快捷登录?\n下次需要重新绑定');" style="color:red;">解除微信快捷登录</a>
        <%else%>
        您还未绑定微信快捷登录，立即绑定           
            <a href="<%=display_tlogin(2)%>"><img src="img/wx_login.gif"></a>
        <%end if%>
      </td>
      </tr>
<%end if%>
    <tr>
      <td style="text-align:right;">头像：</td>
      <td class="user_logo" align="center">
      <img id="user_img" class="user_img" title="点击头像可以更换" onClick="document.getElementById('uploadpic_iframe').contentWindow.document.getElementById('file1').click();" <%=get_userimg(user_id)%>>
      
      
      </td>
      <td>
      <br><--点击头像可以更换，<br>&nbsp;&nbsp;&nbsp;&nbsp;建议像素为120*120<br>&nbsp;&nbsp;&nbsp;&nbsp;不超过500kb的图片
      <iframe id="uploadpic_iframe" name="uploadpic_iframe" src="main/upload_pic.asp?upload_type=2&pic_size=500&modid=<%=user_id%>" style="display:none"></iframe>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">昵称：</td>
      <td><input type="text" name="user_name" class="input_style" value="<%=user_name%>" msg="昵称必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">密码：</td>
      <td><input type="password" name="user_password" class="input_style" value="<%=user_password%>" msg="密码必须填写!" min="1" dataType="Limit">
      <input class="form-control" name="user_password_old" type="hidden" value="<%=user_password%>">
      </td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">确认密码：</td>
      <td><input type="password" name="user_password2" class="input_style" value="<%=user_password%>" msg="确认密码必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">联系电话：</td>
      <td><input type="text" name="user_tel" class="input_style" value="<%=user_tel%>"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">联系QQ：</td>
      <td><input type="text" name="user_qq" class="input_style" value="<%=user_qq%>"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">性别：</td>
      <td>
      <input type="radio" name="user_sex" value="1" <%if user_sex=1 then response.Write(" checked")%>>&nbsp;&nbsp;<img src="img/sex_1.gif"> 帅哥
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="user_sex" value="2" <%if user_sex=2 then response.Write(" checked")%>>&nbsp;&nbsp;<img src="img/sex_2.gif"> 美女
      </td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">个人签名：</td>
      <td>
      <textarea name="user_sign" class="input_style" style="height:150px;"><%=user_sign%></textarea>
      </td>
      <td>&nbsp;&nbsp;不超过120字</td>
    </tr>
    <tr>
      <td ></td>
      <td><input type="submit" class="submit_style" value="确定修改"></td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
</div>
