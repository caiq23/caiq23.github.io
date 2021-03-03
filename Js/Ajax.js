function CheckName() {
    var laoy8 = UserReg.UserName.value.toLowerCase();
	if(document.UserReg.UserName.value.length<2)
	{
		enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>用户名不得小于2个字符</font>";
	return false;
	}
	else if(document.UserReg.UserName.value.length>12)
	{
		enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>用户名不得多于12个字符</font>";
	return false;
	}
	else if (!/[\u4e00-\u9fa5]/g.test(document.UserReg.UserName.value) && document.UserReg.UserName.value.length<4)
	{
		enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>英文用户名不得少于4个字符</font>";
	return false;
	}
	else if (!/[\u4e00-\u9fa5]/g.test(document.UserReg.UserName.value) && document.UserReg.UserName.value.length>15)
	{
		enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>英文用户名不得大于15个字符</font>";
	return false;
	}
	else{
		enter_name.innerHTML = "&nbsp;<font color='#008000'>检测中...</font>";

var oBao;
try {
oBao = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {
try {
oBao = new ActiveXObject("Microsoft.XMLHTTP");
} catch (e) {
oBao = new XMLHttpRequest();
}
}
		
		//var oBao = new ActiveXObject("Microsoft.XMLHTTP");
		oBao.open("post","CheckRegName.asp?UserName=" + laoy8,false);
		oBao.send();
		
		var text = unescape(oBao.responseText);
		if(text=="WordErr")
		{
			enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>你要注册的用户名中含有本站禁止注册的字符</font>";
			return false;
		}
		if(text=="True")
		{
			enter_name.innerHTML = "<img src='../images/check_right.gif' height='13' width='13'>&nbsp;<font color='#2F5FA1'>允许注册</font>";
			return true;
		}
		else{
			enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>用户名已经存在</font>";
		}
	}
}
function UserPassword_enter()
{
	if(document.UserReg.UserPassword.value.length<1)
	{
		enter_pwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>登录密码必须填写</font>";
	}
	if(document.UserReg.UserPassword.value.length<5)
	{
		enter_pwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>登录密码不得少于六位</font>";
	}
	if(document.UserReg.UserPassword.value.length>5)
	{
		enter_pwd.innerHTML = "<img src='../images/check_right.gif' height='13' width='13'>&nbsp;<font color='#2F5FA1'>符合要求</font>";
	}
}
function PwdConfirm_enter()
{
	if(document.UserReg.PwdConfirm.value != document.UserReg.UserPassword.value)
	{
		enter_repwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>两次密码输入不一致</font>";
	}
	else
	{
		if (document.UserReg.PwdConfirm.value.length<1)
		{
			enter_repwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>确认密码不能为空</font>";
		}
		else
		{
			enter_repwd.innerHTML = "<img src='../images/check_right.gif' height='13' width='13'>&nbsp;<font color='#2F5FA1'>符合要求</font>";
		}
	}
}
function UserEmail_enter()
{
	mail_text = document.UserReg.UserEmail.value
	var myreg = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(!myreg.test(mail_text))
	{
		enter_mail.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<font color='#FF0000'>电子邮箱地址不正确</font>";
	}
	else
	{
		enter_mail.innerHTML = "<img src='../images/check_right.gif' height='13' width='13'>&nbsp;<font color='#2F5FA1'>符合要求</font>";
	}

}

function user_from()
{
	if(!/[\u4e00-\u9fa5]/g.test(document.UserReg.UserName.value) && document.UserReg.UserName.value.length<4)
	{
		enter_name.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<strong><font color='#ff0000'>英文用户名4-15字符,中文用户名2-8字符</font></strong>";
		document.UserReg.UserName.focus();
		return false;
	}
	if(document.UserReg.UserPassword.value.length<1)
	{
		enter_pwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<strong><font color='#ff0000'>登录密码必须填写</font></strong>";
		document.UserReg.UserPassword.focus();
		return false;
	}
	if(document.UserReg.UserPassword.value.length<5)
	{
		enter_pwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<strong><font color='#ff0000'>登录密码不得少于六位</font></strong>";
		document.UserReg.UserPassword.focus();
		return false;
	}
	if(document.UserReg.PwdConfirm.value != document.UserReg.UserPassword.value)
	{
		enter_repwd.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<strong><font color='#ff0000'>两次密码输入不一致</font></strong>";
		document.UserReg.PwdConfirm.focus();
		return false;
	}
	mail_text = document.UserReg.UserEmail.value
	var myreg = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(!myreg.test(mail_text))
	{
		enter_mail.innerHTML = "<img src='../images/check_err.gif' height='13' width='13'>&nbsp;<strong><font color='#ff0000'>电子邮箱地址不正确</font></strong>";
		document.UserReg.UserEmail.focus();
		return false;
	}
return true;
}
function writeOption(varFrom,varTo)
{
	for(var i=varFrom;i<=varTo;i++)
	{
		document.write("<option VALUE="+i+">"+i+"</option>");
	}
}
