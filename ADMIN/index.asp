<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<%
	 dim rndnum,verifycode
	Randomize
	Do While Len(rndnum)<4
	num1=CStr(Chr((57-48)*rnd+48))
	rndnum=rndnum&num1
	loop
	session("gl_user")=""
%>
<head>
<meta charset="gb2312">
<title>管理员登录</title>
<style>
body{
	background-color:#252525;
	background-image:url(../img/login/gl/macbg.jpg);
	background-position:center;
	 background-repeat:no-repeat;
	 filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
	 -moz-background-size:100% 100%;
	 background-size:100% 100%;
	 min-height:600px;
	 text-align:center;	
	}
.login_input{ background:none; border:0px; height:30px; line-height:30px; width:190px; color:#bbb;}
</style>
<script language="JavaScript">
if (self != top) top.location.href = window.location.href
</script>
</head>
<body>
<form name="form1" action="chk_gluser.asp" method="post">
    <div style="background-image:url(../img/login/gl/login_input.png); width:400px; height:300px; margin:auto; margin-top:100px; position:relative;">
        <div style=" font-size:14px; position:absolute; top:30px; left:165px;">管理员登录</div>
        <div style="position:absolute; top:95px; left:115px;">
        <input name="user_num" id="user_num" type="text" class="login_input" placeholder="管理帐号">
        </div>
        <div style="position:absolute; top:133px; left:115px;">
        <input name="user_pw" class="login_input" type="password" placeholder="登录密码" value="">
        </div>
        <div style=" position:absolute; top:180px; left:115px;">
        <input name="user_rzm" class="login_input" type="text" placeholder="验证码" />
        <input name="user_rzm_2" type="hidden" value="<%=rndnum%>">
        </div>
        <div style="  position:absolute; top:235px; left:78px;">
        <input type="submit" class="login_input" style="width:250px; cursor:pointer;font-size:14px; color:#f1f1f1; " value="登 陆">
        </div>
        <div style=" font-size:24px; position:absolute; top:180px; left:235px;  width:70px; height:30px; line-height:30px;"><img src="../inc/checkcode.asp " alt="验证码" title="验证码,看不清楚?请点击刷新验证码" height="18" style="cursor : pointer;" onClick="this.src='../inc/checkcode.asp?t='+(new Date().getTime());" ></div>
    
    </div>
</form>
</body>
</html>