<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<script language="javascript" type="text/javascript" src="inc/main.js"></script>
<%
qq_OpenID=session("qq_OpenID")
wx_openid=session("wx_openid")
qq_UserName=session("qq_UserName")
%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
<%
call dperror("",0,bbsset_open_reghy=2,"本站已关闭注册会员功能，请与管理员联系","?")

if len(qq_OpenID)>0 or len(wx_openid) then
if len(qq_OpenID)>0 then session("reg_my_do")="qq_login"
if len(wx_openid)>0 then session("reg_my_do")="wx_login"

%>
    
    <div class="reg_title">
        绑定已有帐号  
    
    </div>
    <div class="reg_content">
    	<form action="inc/chk_reg.asp" method="post" name="login" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
  <%
if len(qq_OpenID)>0 then  %>
    <tr>
      <td style="text-align:right;" width="30%">当前已使用QQ快捷登录：</td>
      <td  width="30%">
      <a href="inc/logout.asp?myurl=r1.html" style="color:red;">清除QQ快捷登录信息</a>
      </td>
      <td  width="40%"></td>
    </tr>
<%else%>
    <tr>
      <td style="text-align:right;" width="30%">当前已使用微信快捷登录：</td>
      <td  width="30%">
      <a href="inc/logout.asp?myurl=r1.html" style="color:red;">清除微信快捷登录信息</a>
      </td>
      <td  width="40%"></td>
    </tr>
<%end if%>
    <tr>
      <td style="text-align:right;" width="30%">用户名：</td>
      <td  width="30%"><input type="text" name="user_num" placeholder="绑定用户名" class="input_style" msg="请输入4-12位字母或数字!" dataType="Limit" min="4"></td>
      <td  width="40%"></td>
    </tr>
    <tr>
      <td style="text-align:right;">密码：</td>
      <td><input type="password" name="user_password" class="input_style" placeholder="会员密码" msg="密码必须填写!" min="1" dataType="Limit"></td>
      <td></td>
    </tr>
    
      
    
    <tr style=" height:100px;">
      <td ></td>
      <td>
      <input type="submit" class="submit_style" value="绑定帐号">
      <a href="inc/logout.asp?myurl=r1.html">注册新账号</a>
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
    	
    <%else
	
	for i=1 to 100
		'随机生成6位数
		Randomize Timer 
		user_id = Int(899999 * Rnd + 100000)
		user_id=right("123456789"&user_id,6)
		sql="select id from BBS_User where user_id="& user_id &""
		set rs=bbsconn.execute(sql)
		if rs.eof then exit for
		call dperror("",0,i>=100,"系统分配用户ID出错，请稍候再重试","?r.html")
	next
	
	%>
    <div class="reg_title">
        立即注册
        <a href="javascript:void(0);" onClick="display_login_div();" title="登录">已有帐号？现在登录</a>    
    
    </div>
    <div class="reg_content">
    	<form action="inc/chk_reg.asp" method="post" name="login" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
      <tr>
      <td colspan="3" style="">
      必填内容
      </td>
      </tr>
    <tr>
      <td style="text-align:right;" width="30%">用户ID：</td>
      <td  width="30%"><b><%=user_id%></b><input  name="user_id" type="hidden" class="input_style" value="<%=user_id%>" readonly></td>
      <td  width="40%"></td>
    </tr>
    <tr>
      <td style="text-align:right;" width="30%">用户名：</td>
      <td  width="30%"><input type="text" name="user_num" placeholder="新会员用户名" class="input_style" msg="请输入4-12位字母或数字!" dataType="Limit" min="4" onBlur="document.getElementById('chk_use').src='inc/chk_user.asp?chk_type=hynumber&chk_value='+this.value;"></td>
      <td  width="40%"><span id="chk_hynumber" class="color_red">*</span>
      <iframe id="chk_use" name="chk_use" src="" style="display:none"></iframe>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">昵称：</td>
      <td><input type="text" name="user_name" class="input_style" placeholder="新会员昵称" msg="昵称必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">密码：</td>
      <td><input type="password" name="user_password" class="input_style" placeholder="新会员密码" msg="密码必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">确认密码：</td>
      <td><input type="password" name="user_password2" class="input_style" placeholder="确认密码" msg="确认密码必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
      <tr>
      <td colspan="3" style="">
      选填内容
      </td>
      </tr>
    <tr>
      <td style="text-align:right;">联系电话：</td>
      <td><input type="text" name="user_tel" class="input_style" placeholder="联系电话"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">联系QQ：</td>
      <td><input type="text" name="user_qq" class="input_style" placeholder="联系QQ"></td>
      <td></td>
    </tr>
    <tr>
      <td style="text-align:right;">性别：</td>
      <td>
      <input type="radio" name="user_sex" value="1" checked>&nbsp;&nbsp;<img src="img/sex_1.gif"> 帅哥
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="user_sex" value="2" >&nbsp;&nbsp;<img src="img/sex_2.gif"> 美女
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
    
    
    <tr style=" height:100px;">
      <td ></td>
      <td>
      <input type="submit" class="submit_style" value="立即注册">
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
    
<%end if%>
    
</div>
