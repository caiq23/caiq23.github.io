<!--#include file="../Inc/conn.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!--#include file="../Inc/Function_Page.asp"-->
<!--#include file="../Inc/ValidateClass.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=Sitekeywords%>" />
<meta name="description" content="<%=Sitedescription%>" />
<link href="<%=SitePath%>images/css<%=Css%>.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=SitePath%>js/main.asp"></script><%if request("action")="useredit" then%>
<script language="javascript" type="text/javascript" src="<%=SitePath%>js/setdate/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="<%=SitePath%>UbbEdit/js/AnPlus.js"></script>
<script language="javascript" type="text/javascript" src="<%=SitePath%>UbbEdit/js/AnUBBEditor.js"></script>
<script language="javascript" type="text/javascript">
var editor1=null;
_f.setButtonPath("<%=SitePath%>UbbEdit/editor_img/")
_.load(function(){
        editor1=new AnUBBEditor("qm",false); 
		editor1.removeButton("kz");editor1.removeButton("code");editor1.removeButton("quote");editor1.removeButton("image");
		editor1.removeButton("left");editor1.removeButton("center");editor1.removeButton("right");editor1.removeButton("removeformat");
});
</script><%End if:if (request("action")="add" or request("action")="edit") and useryn=1 then%>
<script language="JavaScript" src="../js/Jquery.js"></script>
<script charset="utf-8" src="../KindEditor/kindeditor.js"></script>
<script charset="utf-8" src="../KindEditor/lang/zh_CN.js"></script>
<script>
	KindEditor.ready(function(KE) {
		window.editor = KE.create('#Content', {
			width : 480,minHeight:300,allowFlashUpload:false,allowMediaUpload:false,allowFileUpload:false,
			allowImageUpload:<%=IIf(UserGroupInfo(LaoYdengji,5)=1,"true","false")%>,resizeType:1,
			cssPath : '../KindEditor/plugins/code/prettify.css',
			uploadJson : '<%=SitePath%>user/upfile.asp',
			afterBlur: function(){this.sync();}
		});
	});
</script><%End if%>

<title>会员管理-<%=SiteTitle%></title>
<style>
.usermenu {background:#CCCCCC;color:#333333;font-weight:bold;padding:5px;}
</style>
</head>
<body>
<div class="mwall">
<%=Head%>
<%=Menu%><div class="mw">
	<div class="dh">
		<%=search%>您现在的位置：<a href="<%=SitePath%>">首页</a> >> 会员控制面板
    </div>
<%
If IsUser<>1 then
Response.Redirect "UserLogin.asp"
else
%>
<script language=javascript>
    function unselectall(thisform){
        if(thisform.chkAll.checked){
            thisform.chkAll.checked = thisform.chkAll.checked&0;
        }   
    }
    function CheckAll(thisform){
        for (var i=0;i<thisform.elements.length;i++){
            var e = thisform.elements[i];
            if (e.Name != "chkAll"&&e.disabled!=true)
                e.checked = thisform.chkAll.checked;
        }
    }
function CheckForm()
{ 
  if (document.myform.Title.value==""){
	alert("请填写标题！");
	document.myform.Title.focus();
	return false;
  }
  if (document.myform.ClassID.value==""){
	alert("请选择分类！");
	document.myform.ClassID.focus();
	return false;
  }
  if (document.myform.ClassID.value=="-1"){
	alert("该类别不允许发表！");
	document.myform.ClassID.focus();
	return false;
  }
  if (document.myform.Author.value==""){
	alert("请填写作者！");
	document.myform.Author.focus();
	return false;
  }
  if (document.myform.Content.value==""){
	alert("请填写内容！");
	return false;
  }
return true;
}
</script>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:1px dashed #ccc">
      <tr>
        <td width="20%" height="400" valign="top" style="border-right:1px dashed #ccc">
		<div style="margin-top:20px;line-height:22px;">欢迎您，<font color=red><%=UserName%></font><br>您共发表了 <b><%=Mydb("Select Count([ID]) From ["&tbname&"_Article] Where UserName='"&UserName&"'",1)(0)%></b> 篇文章<br>其中 <font color=red><b><%=Mydb("Select Count([ID]) From ["&tbname&"_Article] Where yn = 1 and UserName='"&UserName&"'",1)(0)%></b></font> 篇文章没通过审核<br><%=moneyname%>：<%=mymoney%></div>
		<table width="100" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
          <tr>
            <td class="usermenu"><a href="UserAdd.asp?action=useredit">修改资料</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td class="usermenu"><a href="UserAdd.asp?action=List">我发表的文章</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td class="usermenu"><a href="UserAdd.asp?action=add">发表新文章</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td class="usermenu"><a href="UserAdd.asp?action=qq1">QQ绑定</a>/<a href="UserAdd.asp?action=qq2" onClick="JavaScript:return confirm('确认解除QQ绑定吗？解绑后就不能用QQ登录本站了哦！')">解绑</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
          <tr>
            <td class="usermenu"><a href="UserLogin.asp?action=logout">退出</a></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
        <td valign="top">
<%
	
	if request("action")="yn1" then
		call yn1()
	elseif request("action")="yn2" then
		call yn2()
	elseif request("action")="useredit" then
		call useredit()
	elseif request("action")="usersave" then
		call usersave()
	elseif request("action") = "add" then 
		call add()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="saveedit" then
		call saveedit()
	elseif request("action")="del" then
		call del()
	elseif request("action")="delAll" then
		call delAll()
	elseif request("action")="qq1" then
		call qq1()
	elseif request("action")="qq2" then
		call qq2()	
	else
		call List()
	end if

sub qq1()
	If userqqopenid<>"" then Call Alert ("您已经绑定了QQ，如果要绑定其它QQ请先解除当前QQ绑定!",-1)
	Session("islaoy")=1
	Response.Redirect "../api/qq/redirect_to_login.asp"
End sub

sub qq2()
	If userqqopenid="" then Call Alert ("您没有绑定QQ!",-1)
	Conn.execute("update "&tbname&"_user set qqopenid='' where username='" & username & "'")
	Call Alert ("解绑成功，请及时设置登陆密码,以后使用本站用户名和密码登陆!","UserAdd.asp?action=useredit")
End sub
	
sub List()
%>
<form name="myform" method="POST" action="?action=delAll">
<table width="98%" border="0"  align=center cellpadding="3" cellspacing="2" bgcolor="#FFFFFF" class="admintable">
    <tr bgcolor="#f1f3f5" style="font-weight:bold;">
    <td width="55%" align="center" class="ButtonList">标题</td>
    <td width="20%" height="30" align="center" class="ButtonList">发布时间</td>
    <td width="5%" height="30" align="center" class="ButtonList">浏览</td>
    <td height="30" align="center" class="ButtonList">管理</td>    
	</tr>
<%
	page=request("page")
	Set mypage=new xdownpage
	mypage.getconn=conn
	mysql="select * from "&tbname&"_Article where UserID= "& LaoYID &" order by id desc"
	mypage.getsql=mysql
	mypage.pagesize=20
	set rs=mypage.getrs()
	for i=1 to mypage.pagesize
		if not rs.eof then
%>
    <tr bgcolor="#f1f3f5" onMouseOver="this.style.backgroundColor='#B3CFEE';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
    <td style="padding:8px;text-align:left;"><%=i%>、<a href="<%=apath(rs("id"),0)%>" target="_blank"><%=rs("Title")%></a> <%if rs("IsTop")=1 then Response.Write("<font color=red>[顶]</font>") end if%><%if rs("IsHot")=1 then Response.Write("<font color=green>[荐]</font>") end if%><%if rs("Images")<>"" then Response.Write("<font color=blue>[图]</font>") end if%></td>
    <td align="center"><%=rs("DateAndTime")%></td>
    <td align="center"><%=rs("Hits")%></td>
    <td align="center"><%If rs("yn")=0 then Response.Write("已审") end if:If rs("yn")=1 then Response.Write("<font color=red>未审</font>") end if:If rs("yn")=2 then Response.Write("<font color=blue>私有</font>") end if%>|<a href="?action=edit&id=<%=rs("ID")%>">编辑</a>|<a href="?action=del&id=<%=rs("ID")%>" onClick="JavaScript:return confirm('确认删除吗？')">删除</a></td>    </tr>
<%
        rs.movenext
    else
         exit for
    end if
next
%>
  <tr><td bgcolor="f7f7f7" colspan="4">
<div id="page">
	<ul>
      <%=mypage.showpage()%>
    </ul>
    </div>
</td></tr></table>
</form>
<%
	rs.close
	set rs=nothing
end sub

sub add()
if useryn=0 then
Response.Write "<div style=""padding-top:50px;color:#ff0000;"">本站设置了会员审核机制，您还没有通过审核！</div>"
Response.End
End if
%>
		<form action="?action=savenew" method="post" name="myform" id="myform" onSubmit="return CheckForm();">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff">
            <tr>
              <td width="15%" height="30">标题：</td>
              <td width="85%" colspan="2" align="left"><input name="Title" type="text" class="borderall" id="Title" size="40" maxlength="30" /></td>
            </tr>
            <tr>
              <td height="30">类别：</td>
              <td colspan="2" align="left">
                <select id="ClassID" name="ClassID">
                  <%call Admin_ShowClass_Option()%>
                </select>
               <span style="color:#cccccc;">您只能选择蓝色字体栏目发表</span></td>
            </tr>
            <tr>
              <td height="30">来源：</td>
              <td colspan="2" align="left"><input name="CopyFrom" type="text" class="borderall" id="CopyFrom" value="原创" size="20" maxlength="20" /></td>
            </tr>
            <tr>
              <td height="30">录入：</td>
              <td colspan="2" align="left"><input name="UserName" type="text" class="borderall" id="UserName" value="<%=UserName%>" size="20" maxlength="20" readOnly /> <span style="color:#cccccc;">此项禁止更改</span></td>
            </tr>
            <tr>
              <td height="30">作者：</td>
              <td align="left"><input name="Author" type="text" class="borderall" id="Author" value="<%=UserName%>" size="20" maxlength="20" /></td>
              <td align="left">&nbsp;</td>
            </tr>
            <tr>
              <td height="30">内容：</td>
              <td colspan="2" rowspan="2" align="left"><textarea name="Content" style="width:100%;height:350px;" id="Content"></textarea>
                </td>
            </tr>
            <tr>
              <td valign="top"><p>&nbsp;</p> </td>
            </tr>
            <tr>
              <td height="30" align="center"><script src="<%=SitePath%>inc/ValidateClass.asp?act=showvalidatelaoy" type="text/javascript"></script></td>
              <td height="30" colspan="2" align="left"><input type="submit" name="Submit" value=" 发 布 " class="borderall" /></td>
            </tr>
          </table>
        </form>
<%
end sub

sub savenew()
if useryn=0 then
Response.Write "<div style=""padding-top:50px;color:#ff0000;"">本站设置了会员审核机制，您还没有通过审核！</div>"
Response.End
End if
	ValidateObj.checkValidate()
	dim Title,Content,ClassID,sqlmoney
	Title = LoseHtml(trim(request.form("Title")))
	ClassID = LaoYRequest(request.form("ClassID"))
	CopyFrom = LoseHtml(trim(request.form("CopyFrom")))
	Author = LoseHtml(trim(request.form("Author")))
	Content = request.form("Content")
	Content=Replace(Content,"<hr class=""ke-pagebreak"" />","[yao_page]")
	'myyn = LaoYRequest(request.form("myyn"))
	'mycode = LaoYRequest(request.form("code"))
	'if mycode<>Session("getcode") then
	'Call Alert("请输入正确的验证码！",-1)
	'end if
	If session("postarttime")<>"" then
		posttime8=DateDiff("s",session("postarttime"),Now())
  		if posttime8<yaopostgetime then
		posttime9=yaopostgetime-posttime8
		Call Alert ("话说的太快不好!"&posttime9&"秒后再发表。","-1")
  		end if
	end if
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Article"
	rs.open sql,conn,1,3
		If ClassID="-1" then
			Call Alert("该大类还有小类别，请选择一个小类！","-1")
		End if
		if Title="" or ClassID="" or Author="" or Content="" then
			Call Alert("请填写完整再提交！","-1")
		end if
		If Not Checkpost(True) Then Call Alert("禁止外部提交!","-1")
		rs.AddNew 
		rs("Title")				=Replace(Title,CHR(34),"&quot;")
		rs("ClassID")			=ClassID
		rs("Content")			=Content
		rs("Artdescription")	=left(LoseHtml(Content),250)
		rs("CopyFrom")			=CopyFrom
		rs("Author")			=Author
		rs("UserName")			=LaoYName
		rs("UserID")			=LaoYID
		rs("yn")				=UserGroupInfo(LaoYdengji,4)

		rs.update

			sqlmoney="Update "&tbname&"_User set UserMoney = UserMoney+"&money1&" where ID="&LaoYID&""
			conn.execute(sqlmoney)
		Session("postarttime")=Now()
		Call Alert ("恭喜你,发布成功!","?action=list")
		rs.close
		Set rs = nothing
end sub

sub edit()
if useryn=0 then
Response.Write "<div style=""padding-top:50px;color:#ff0000;"">本站设置了会员审核机制，您还没有通过审核！</div>"
Response.End
End if
id=LaoYRequest(request("id"))
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_Article where id="& id &" and UserID="&LaoYID&""
rs.open sql,conn,1,1
If rs.bof then
	Call Alert ("这样搞是不好的!","-1")
else
Content=Replace(server.htmlencode(rs("Content")),"[yao_page]","<hr class=""ke-pagebreak"" />")
%>
		<form action="?action=saveedit" method="post" name="myform" id="myform" onSubmit="return CheckForm();">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff">
            <tr>
              <td width="15%" height="30">标题：</td>
              <td width="85%" align="left"><input name="Title" type="text" class="borderall" id="Title" value="<%=rs("Title")%>" size="40" maxlength="30" /></td>
            </tr>
            <tr>
              <td height="30">类别：</td>
              <td align="left">
                <select ID="ClassID" name="ClassID">
   <%
   Set Rsp=server.CreateObject("adodb.recordset") 
   Sqlp ="select * from "&tbname&"_Class Where TopID = 0 And link<>1 order by num"   
   rsp.open sqlp,conn,1,1 
   Response.Write("<option value="""">请选择分类</option>") 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("<option value="""">请先添加分类</option>")
   Else
      Do while not Rsp.Eof   
         Response.Write("<option value")
		 If Yao_MyID(rsp("ID"))<>"0" then
		 Response.Write("=""-1"" style=""background:#f7f7f7;color:#ccc;""")
		 else
		 Response.Write("=" & """" & Rsp("ID") & """" & " style=""color:#0000ff;""")
		 End if
         If rs("ClassID")=Rsp("ID") Then
            Response.Write(" selected")
         End If
         Response.Write(">|-" & Rsp("ClassName") & "</option>")
		 
		 Sqlpp ="select * from "&tbname&"_Class Where TopID="&Rsp("ID")&" And link<>1 And IsUser=1 order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			Do while not Rspp.Eof 
				Response.Write("<option value=" & """" & Rspp("ID") & """" & "")
				If rs("ClassID")=Rspp("ID") Then
            	Response.Write(" selected")
         		End If
         		Response.Write(" style=""color:#0000ff;"">　|-" & Rspp("ClassName") & "")
				Response.Write("</option>" ) 
			Rspp.Movenext   
      		Loop
			rspp.close
			set rspp=nothing
      Rsp.Movenext   
      Loop   
   End if
   rsp.close
   set rsp=nothing
   %>
  </select> <span style="color:#cccccc;">您只能选择蓝色字体栏目发表</span></td>
            </tr>
            <tr>
              <td height="30">来源：</td>
              <td align="left"><input name="CopyFrom" type="text" class="borderall" id="CopyFrom" value="<%=rs("CopyFrom")%>" size="20" maxlength="20" /></td>
            </tr>
            <tr>
              <td height="30">录入：</td>
              <td align="left"><input name="UserName" type="text" class="borderall" id="UserName" value="<%=UserName%>" size="20" maxlength="20" readonly/></td>
            </tr>
            <tr>
              <td height="30">作者：</td>
              <td align="left"><input name="Author" type="text" class="borderall" id="Author" value="<%=rs("Author")%>" size="20" maxlength="20" /></td>
            </tr>
            <tr>
              <td height="30">内容：</td>
              <td rowspan="2" align="left"><textarea name="Content" style="width:100%;height:350px;" id="Content"><%=Content%></textarea></td>
            </tr>
            <tr>
              <td valign="top"></td>
            </tr>
            <tr>
              <td height="30" align="left"><input name="id" type="hidden" id="id" value="<%=ID%>" /></td>
              <td height="30" align="left"><input type="submit" name="Submit3" value=" 修 改 " class="borderall" /></td>
              <td height="30" align="left">&nbsp;</td>
            </tr>
          </table>
        </form>
<%
rs.close
set rs=nothing
End if
end sub

sub saveedit()
if useryn=0 then
Response.Write "<div style=""padding-top:50px;color:#ff0000;"">本站设置了会员审核机制，您还没有通过审核！</div>"
Response.End
End if
	dim Title,Content,ClassID
	ID = 		LaoYRequest(trim(request.form("ID")))
	Title = 	LoseHtml(trim(request.form("Title")))
	ClassID = 	LaoYRequest(trim(request.form("ClassID")))
	CopyFrom = 	LoseHtml(trim(request.form("CopyFrom")))
	Author = 	LoseHtml(trim(request.form("Author")))
	Content = 	request.form("Content")
	Content=Replace(Content,"<hr class=""ke-pagebreak"" />","[yao_page]")
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Article where ID="&id&" and UserID="&LaoYID&""
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		Call Alert("这样不对!难道你想改人家的?","?action=list")		
	else
		if Title="" or ClassID="" or Content="" then
			Call Alert("请填写完整再提交！","-1")
		end if
		If Not Checkpost(True) Then Call Alert("禁止外部提交!","-1")
		rs("Title")				=Replace(Title,CHR(34),"&quot;")
		rs("ClassID")			=ClassID
		rs("Content")			=Content
		rs("Artdescription")	=left(LoseHtml(Content),250)
		rs("CopyFrom")			=CopyFrom
		rs("Author")			=Author
		rs("yn")				=UserGroupInfo(LaoYdengji,4)
		rs.update
		Call Alert("恭喜你,修改成功！","?action=list")
	end if
		rs.close
		Set rs = nothing
end sub

sub useredit()
set rs = server.CreateObject ("adodb.recordset")
sql="select * from "&tbname&"_User where UserName='"& UserName &"'"
rs.open sql,conn,1,1
%>
<script language=javascript>
function CheckForm()
{ 
  if (document.UserReg.UserEmail.value==""){
	alert("请输入Email！");
	document.UserReg.UserEmail.focus();
	return false;
  }
  var UserEmailStr = document.UserReg.UserEmail.value;
  if ((UserEmailStr.indexOf("@")==-1)||(UserEmailStr.indexOf(".")==-1)||(UserEmailStr.length<6)){
	alert("Email格式不对！");
	document.UserReg.UserEmail.focus();
	return false;
  }
  if (document.UserReg.province.value==""){
	alert("请选择所在地区！");
	document.UserReg.province.focus();
	return false;
  }
  //if (document.UserReg.UserQQ.value==""){
	//alert("请输入QQ！");
	//document.UserReg.UserQQ.focus();
	//return false;
  //}
  //var filter=/^\s*[0-9]{5,11}\s*$/;
  //if (!filter.test(document.UserReg.UserQQ.value)) { 
	//alert("QQ填写不正确,请重新填写！"); 
	//document.UserReg.UserQQ.focus();
	//return false; 
 //}  	
}
</script>
		<form action="?action=usersave" method="post" name="UserReg" onSubmit="return CheckForm();">
		  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom:176px;">
            <tr>
              <td width="24%" height="30" align="left">用户名：</td>
              <td width="53%" align="left"><%=rs("UserName")%></td>
              <td width="23%" rowspan="6" align="center"><img id="userface" src="<%If rs("UserFace")<>"" then Response.Write(""&laoyface(rs("UserFace"))&"") else Response.Write(""&SitePath&"images/noface.gif") end if%>" width=100 height=100/></td>
            </tr>
            <tr>
              <td height="30" align="left">密码(至少6位)：<br />              </td>
              <td align="left"><input name="UserPassword" type="password"  class="borderall" size="18" maxlength="12" style="width:140px;" />
                *不修改请留空</td>
              </tr>
            <tr>
              <td height="30" align="left">确认密码(至少6位)：</td>
              <td align="left"><input name="PwdConfirm" type="password"  class="borderall" size="18" maxlength="12" style="width:140px;" /></td>
              </tr>
            <tr>
              <td height="30" align="left">性别：</td>
              <td align="left"><input name="UserSex" type="radio" value="1" <%If rs("sex")=1 then Response.Write("checked") end if%>/>
                男
                <input name="UserSex" type="radio" value="0" <%If rs("sex")=0 then Response.Write("checked") end if%>/>
                女</td>
              </tr>
            <tr>
              <td height="30" align="left">Email地址：</td>
              <td align="left"><input name="UserEmail"  class="borderall" value="<%=rs("Email")%>" size="30" maxlength="50" />
                  <font color="#FF0000">*</font> </td>
              </tr>
            <tr>
              <td height="30" align="left">出生日期：</td>
              <td align="left"><input name='Birthday' type='text' class="borderall" onFocus="WdatePicker({isShowClear:false,readOnly:true,startDate:'1960-01-01',minDate:'1960-01-01',maxDate:'1994-12-31',skin:'whyGreen'})" value="<%=rs("birthday")%>" style="width:140px;"/>              </td>
              </tr>
            <tr>
              <td height="30" align="left">籍贯(省/市)：</td>
              <td colspan="5" align="left"><select onChange="setcity();" name='province' style="width:90px;">
                  <option value=''>请选择省份</option>
                  <option value="广东">广东</option>
                  <option value="北京">北京</option>
                  <option value="重庆">重庆</option>
                  <option value="福建">福建</option>
                  <option value="甘肃">甘肃</option>
                  <option value="广西">广西</option>
                  <option value="贵州">贵州</option>
                  <option value="海南">海南</option>
                  <option value="河北">河北</option>
                  <option value="黑龙江">黑龙江</option>
                  <option value="河南">河南</option>
                  <option value="香港">香港</option>
                  <option value="湖北">湖北</option>
                  <option value="湖南">湖南</option>
                  <option value="江苏">江苏</option>
                  <option value="江西">江西</option>
                  <option value="吉林">吉林</option>
                  <option value="辽宁">辽宁</option>
                  <option value="澳门">澳门</option>
                  <option value="内蒙古">内蒙古</option>
                  <option value="宁夏">宁夏</option>
                  <option value="青海">青海</option>
                  <option value="山东">山东</option>
                  <option value="上海">上海</option>
                  <option value="山西">山西</option>
                  <option value="陕西">陕西</option>
                  <option value="四川">四川</option>
                  <option value="安徽">安徽</option>
                  <option value="台湾">台湾</option>
                  <option value="天津">天津</option>
                  <option value="新疆">新疆</option>
                  <option value="西藏">西藏</option>
                  <option value="云南">云南</option>
                  <option value="浙江">浙江</option>
                  <option value="海外">海外</option>
                </select>
                  <select name='city'  style="width:90px;">
                  </select>
                  <script src="<%=SitePath%>js/getcity.js"></script>
                  <script>initprovcity('<%=rs("province")%>','<%=rs("city")%>');</script>
                  <font color="#FF0000">*</font></td>
            </tr>
            <!--<tr>
              <td height="30" align="left">QQ号码：</td>
              <td colspan="2" align="left"><input name="UserQQ"  class="borderall" value="<%=rs("UserQQ")%>" size="30" maxlength="11" />
                  <font color="#FF0000">*</font></td>
            </tr>-->
            <tr>
              <td height="30" rowspan="2" align="left">头像：</td>
              <td colspan="2" align="left">
                  <iframe src="upload.asp?action=simg" width="400" height="25" frameborder="0" scrolling="No"></iframe></td>
            </tr>
            <tr>
              <td colspan="2" align="left"><span style="color:#ccc;">注：不管你的头像是多大尺寸，程序都会强制缩小为100X100</span></td>
            </tr>
            <tr>
              <td height="30" align="left">个性签名：<br />
                  <span style="color:#ccc;">200字内</span></td>
              <td colspan="2" align="left"><textarea name="qm" id="qm" style="width:350px;height:100px;"><%If rs("qm")<>"" then Response.Write(server.htmlencode(rs("qm"))) End if%></textarea></td>
            </tr>
            <tr align="middle">
              <td height="50" colspan="3"><input id="Action" type="hidden" value="SaveReg1" name="Action2" />
                  <input name="Submit2" type="submit"  class="borderall" value=" 修改 " /></td>
            </tr>
          </table>
		</form>
<%
rs.close
set rs=nothing
end sub

sub usersave()
PassWord1 = trim(request.form("UserPassWord"))
PassWord2 = trim(request.form("PwdConfirm"))
Sex = 		LaoYRequest(request.form("UserSex"))
Email = 	CheckStr(trim(request.form("UserEmail")))
QQ = 		LaoYRequest(trim(request.form("UserQQ")))
TrueName = 	CheckStr(trim(request.form("TrueName")))
Province = 	CheckStr(request.form("Province"))
City = 		CheckStr(request.form("City"))
birthday = 	CheckStr(request.form("birthday"))
qm = 		LoseHtml(request.form("qm"))

	If Not Checkpost(True) Then Call Alert("禁止外部提交!","-1")
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_user where UserName='"&UserName&"'"
	rs.open sql,conn,1,3
		if Email="" or City="" then
			Call Alert("请填写完整再提交","-1")
		end if
		If PassWord1<>PassWord2 then
			Call Alert("两次输入的密码不同","-1")
		End if
		
		If PassWord1<>"" then
		rs("PassWord")			=md5(PassWord1,16)
		end if
		rs("Sex")				=Sex
		rs("Email")				=Email
		'rs("UserQQ")			=QQ
		rs("Province")			=Province
		rs("City")				=City
		If birthday<>"" then
		rs("birthday")			=birthday
		end if
		rs("qm")				=left(qm,200)
		rs.update
		Call Alert("修改成功","?action=useredit")
		rs.close
		Set rs = nothing
end sub

sub del()
	id=LaoYRequest(request("id"))
	set rs = server.CreateObject ("adodb.recordset")
	sql="select * from "&tbname&"_Article where ID="&id&" and UserID="&LaoYID&""
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		Call Alert("ID错误!","?action=list")		
	else
	set rs=conn.execute("delete from "&tbname&"_Article where UserName='"&UserName&"' and id="&id)
	set rs=conn.execute("Update "&tbname&"_User set UserMoney = UserMoney-"&money2&" where ID="&LaoYID)
	Call Alert ("删除成功！","?action=list")	
	End If	
end sub
%>	
</td>
      </tr>
  </table>
<%
sub Admin_ShowClass_Option()
   Dim Sqlp,Rsp,TempStr
   Sqlp ="select * from "&tbname&"_Class Where TopID = 0 And link<>1 order by num"   
   Set Rsp=server.CreateObject("adodb.recordset")   
   rsp.open sqlp,conn,1,1 
   Response.Write("<option value="""">请选择分类</option>") 
   If Rsp.Eof and Rsp.Bof Then
      Response.Write("<option value="""">请先添加分类</option>")
   Else
      Do while not Rsp.Eof   
         Response.Write("<option value")
		 If Yao_MyID(rsp("ID"))<>"0" or rsp("IsUser")=0 then
		 Response.Write("=""-1"" style=""background:#f7f7f7;color:#ccc;""")
		 else
		 Response.Write("=" & """" & Rsp("ID") & """" & " style=""color:#0000ff;""")
		 End if
         Response.Write(">|-" & Rsp("ClassName") & "</option>")
		 
		    Sqlpp ="select * from "&tbname&"_Class Where TopID="&Rsp("ID")&" And link<>1 And IsUser=1 order by num"   
   			Set Rspp=server.CreateObject("adodb.recordset")   
   			rspp.open sqlpp,conn,1,1
			Do while not Rspp.Eof 
				Response.Write("<option value=" & """" & Rspp("ID") & """" & "")
         		Response.Write(" style=""color:#0000ff;"">　|-" & Rspp("ClassName") & "")
				Response.Write("</option>" ) 
			Rspp.Movenext   
      		Loop
			rspp.close
			set rspp=nothing
      Rsp.Movenext   
      Loop   
   End if
   rsp.close
   set rsp=nothing
end sub 
End if
%></div>
<%=Copy%>
</div>
</body>
</html>