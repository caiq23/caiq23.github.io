<!--#include file="../Inc/conn.asp"-->
<!--#include file="Admin_check.asp"-->
<!--#Include File="Class_Setting.Asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equtv="Content-Type" content="text/html; charset=gb2312" />
<title>网站后台管理</title>
<link href="images/Admin_css.css" type=text/css rel=stylesheet>
<style>
td {font-size:13px;}
</style>
<script src="js/admin.js"></script>
<script src="../js/main.asp"></script>
</head>
<body>
<%
Call chkAdmin(1)
Dim U
Set U = New Cls_Setting

Dim JumpUrl
JumpUrl = "Admin_Setting.Asp"
If Request("Act") = "UpDate" Then
	If Not U.Update() Then Alert "填写错误!",JumpUrl Else Alert "修改成功!",JumpUrl
Else
	Call Main_Guide()
End If
If IsObject(Conn) Then Conn.Close : Set Conn = Nothing

Sub Main_Guide()
	%>
<form name='frm' method='post' action='Admin_Setting.Asp?Act=UpDate'>
<div class="nTableft admintable">
      	<div class="TabTitleleft">
      		<ul id="myTab1">
					<li class="active" onClick="nTabs(this,0);">网站整体配置</li>
        			<li class="normal" onClick="nTabs(this,1);">首页配置</li>
                    <li class="normal" onClick="nTabs(this,2);">内容页配置</li><%If laoyvip then%>
                    <li class="normal" onClick="nTabs(this,3);">加强版留言本配置</li><%end if%>
      		</ul>
    	</div>
        <%For ii=0 to 3%>
		<div id="myTab1_Content<%=ii%>" <%If ii<>0 then Response.Write("class='none'")%> style="clear:both;">
<table width="100%" border="0"  align=center cellpadding="3" cellspacing="1" style="margin:5px 0;background:#FFF">
	<%
	Dim Rs,i,j,Tmp,Tv,Tn,Formset
	set rs=server.createobject("ADODB.Recordset")
	sql="Select [Title],[Name],[Value],[Values],[Data],[Form],[Description],[IsType] From ["&tbname&"_Config] Where IsType = "&ii+1&" Order by [Order] Asc"
	rs.open sql,conn,1,3
	Do While Not Rs.Eof
	j = j + 1
	formset = split(Rs(5) & ",,,,,",",")
	%>
		<tr onMouseOver="this.style.backgroundColor='#EEFCDD';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
			<td width="40%" align="left"><%=Rs(0)%>：<%=Rs(1)%>
				<div id='h<%=Rs(1)%>' style="color:#ccc;letter-spacing: 0px;font-size:12px;"><%=Rs(6)%></div>
		  	</td>
			<td width="60%" align="left">
				<%
				Select Case LCase(formset(0))
				Case "input"
				If Rs(1)="Color1" Then
				Response.Write("<input name=""oColor1"" type=""text"" id=""oColor1"" value="""&Rs(2)&""" class=""color {adjust:false,pickerPosition:'left'}"">")
				ElseIf Rs(1)="Color2" Then
				Response.Write("<input name=""oColor2"" type=""text"" id=""oColor2"" value="""&Rs(2)&""" class=""color {adjust:false,pickerPosition:'left'}"">")
				ElseIf Rs(1)="css" Then
				%>
				<select class='css_select' name="o<%=Rs(1)%>" type="text" id="o<%=Rs(1)%>" onFocus="h<%=Rs(1)%>.style.color='blue';" onBlur="h<%=Rs(1)%>.style.color='#ccc';" style="width:150px;">
                <%Call Web_Style%>
                </select>
                <%
				ElseIf Rs(1)="SiteUrl" Then
				Response.Write("<input name=""oSiteUrl"" type=""text"" id=""oSiteUrl"" value="""&Request.ServerVariables("HTTP_HOST")&""" style=""width:300px;"">")
				ElseIf Rs(1)="SiteLogo" Then
				%>
                <input name="oSiteLogo" type="text" id="oSiteLogo" onFocus="hSiteLogo.style.color='blue';" onBlur="hSiteLogo.style.color='#ccc';" value="<%=Server.HtmlEnCode(Rs(2) & "")%>" style="width:300px;"><br><iframe src="upload.asp?action=logo" width="400" height="25" frameborder="0" scrolling="no"></iframe>
                <%
				Else
				%>
				<input name="o<%=Rs(1)%>" type="text" id="o<%=Rs(1)%>" onFocus="h<%=Rs(1)%>.style.color='blue';" onBlur="h<%=Rs(1)%>.style.color='#ccc';" value="<%=Server.HtmlEnCode(Rs(2) & "")%>" style="width:<%=IIF(Rs(4)="int","30px","300px")%>;"<%If Rs(4)="int" then%>onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onpaste="return false"<%End if%>>
				<%
				End if
				Case "textarea"
				If Rs(1)="BadWord1" Then
				%>
<textarea class='css_textarea' name="o<%=Rs(1)%>" type="text" id="o<%=Rs(1)%>" onFocus="h<%=Rs(1)%>.style.color='blue';" onBlur="h<%=Rs(1)%>.style.color='#ccc';" cols="50" rows="5" ><%=Replace(Server.HtmlEnCode(Rs(2)),"|||",CHR(10))%></textarea>                 
                <%
				Else
				%>
<textarea class='css_textarea' name="o<%=Rs(1)%>" type="text" id="o<%=Rs(1)%>" onFocus="h<%=Rs(1)%>.style.color='blue';" onBlur="h<%=Rs(1)%>.style.color='#ccc';" cols="50" rows="5" ><%=Server.HtmlEnCode(Rs(2) & "")%></textarea>      
				<%
				End if
				Case "select"
				If Rs(1)="IsAspJpeg" Then
					Response.Write("<select class='css_select' name=""oIsAspJpeg"" type=""text"" id=""oIsAspJpeg"" onFocus=""hIsAspJpeg.style.color='blue';"" onBlur=""hIsAspJpeg.style.color='#ccc';"" style=""width:150px;"">")
					If IsObjInstalled("Persits.Jpeg") Then
						If IsAspJpeg=1 then
						Response.Write("<option value=""1"" selected>开</option><option value=""0"">关</option></select>")
						Else
						Response.Write("<option value=""1"">开</option><option value=""0"" selected>关</option></select>")
						End if
					Else
					Response.Write("<option value=""0"" selected>关</option></select>")
					End if
					If IsObjInstalled("Persits.Jpeg") Then Response.Write "<font color=red><b>√</b>支持!</font>" Else Response.Write "<b>×</b>空间不支持!请联系官方购买专用空间,300M120/年,联系ＱＱ:22862559"
				Else
				%>
				<select class='css_select' name="o<%=Rs(1)%>" type="text" id="o<%=Rs(1)%>" onFocus="h<%=Rs(1)%>.style.color='blue';" onBlur="h<%=Rs(1)%>.style.color='#ccc';" style="width:150px;">
					<%
					If Len(Rs(3)) > 0 Then
						Tmp = Split(Rs(3),"|||")
						For i= 0 To UBound(Tmp)
							If Instr(Tmp(i),"=>") > 0 Then
								Tv = Split(Tmp(i),"=>")(0) : Tn = Split(Tmp(i),"=>")(1)
							Else
								Tv = Tmp(i) : Tn = Tmp(i)
							End If
							Response.Write "<option value=""" & Tv & """"
							If LCase(Tv) = LCase(Rs(2)) Then Response.Write " selected "
							Response.Write ">" & Tn & "</option>"
						Next
					End If
					%>
				</select>
				<%
				End if
				End Select
				%>
		  </td>
	  </tr>
	<%
	Rs.MoveNext
	Loop
	Rs.CLose : Set Rs = Nothing
	%>
		<tr class=css_page_list>
			<td height="30" colspan=2 align="center">
		  <input name='Submit' type='submit' class="bnt" value=' 修 改 '></td>
		</tr>
</table>
   		</div>
        <%Next%>
</div>
</form>
<%
End Sub
%>
<!--#include file="Admin_copy.asp"-->
<script language="javascript" src="../js/jscolor/jscolor.js"></script>
</body>
</html>