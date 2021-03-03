<!--#include file="../Inc/Conn.asp"-->
<!--#include file="Admin_check.asp"-->
<!--#include file="../Inc/UploadClass.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Upload</title>

<style>
body {padding:0;margin:0;background:#F2F9E8;}
body,td {font-size:12px;}
</style>
<body>
<%
select case request("action")
case "logo":
call logo()
case "simg":
call simg()
case "simgedit":
call simgedit()
case "link":
call link()
case "ad":
call ad()
case "fileup":
call fileup()
end select
'============================================================上传附件
sub fileup()
if Request.QueryString("submit")="fileup" then
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
uploadsize="1024"
uploadtype="doc/xls/zip/rar/flv/ppt/pdf/mp4/mp3"
Set Uprequest=new UpLoadClass
	CreateFolder(uploadpath&"index.html")
    Uprequest.SavePath=uploadpath
    Uprequest.MaxSize=uploadsize*1024*50
    Uprequest.FileType=uploadtype
    Uprequest.AutoSave=0
    Uprequest.open
  if Uprequest.form("file_Err")<>0  then
  select case Uprequest.form("file_Err")
  case 1:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件最大"&Uprequest.MaxSize/1024/1024&"M [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  case 2:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>只允许上传"&uploadtype&" [<a href='javascript:history.go(-1)']>重新上传</a>]</font></div>"
  case 3:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件太大且格式不对 [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  end select
  Echo str
  else
  	If right(Uprequest.Form("file"),4)=".flv" then
	Echo "<script language=""javascript"">parent.editor.insertHtml('[flv=560,420]"&uploadpath&Uprequest.Form("file")&"[/flv]');</script>"
	elseIf right(Uprequest.Form("file"),4)=".mp3" then
	Echo "<script language=""javascript"">parent.editor.insertHtml('[mp3]"&uploadpath&Uprequest.Form("file")&"[/mp3]');</script>"
	elseIf right(Uprequest.Form("file"),4)=".mp4" then
	Echo "<script language=""javascript"">parent.editor.insertHtml('[mp4=576,324]"&uploadpath&Uprequest.Form("file")&"[/mp4]');</script>"
	else
  	Echo "<script language=""javascript"">parent.editor.insertHtml('附件：<a href="""&uploadpath&Uprequest.Form("file")&""">"&Uprequest.Form("file")&"</a><br>');</script>"
	end if
  Echo "<div style=""margin:10px 0;color:red"">上传成功![<a href='javascript:history.go(-1)'>继续上传</a>]</div>"
  conn.close
  set conn=nothing
  end if
  Response.End
Set Uprequest=nothing

end if

Echo "<form name=form action=?action=fileup&submit=fileup method=post enctype=multipart/form-data>"
Echo "<div style='text-align:left;'><input type=file name=file size=15  style=""width:150px;"">&nbsp;"
Echo "<input type=submit name=submit value=上传></div>"
Echo "</form>"
end sub
'============================================================上传logo图片
sub logo()
if Request.QueryString("submit")="logo" then
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
uploadsize="1024"
uploadtype="jpg/jpeg/gif/png/swf"
Set Uprequest=new UpLoadClass
	CreateFolder(uploadpath&"index.html")
    Uprequest.SavePath=uploadpath
    Uprequest.MaxSize=uploadsize*5000
    Uprequest.FileType=uploadtype
    AutoSave=true
    Uprequest.open
  if Uprequest.form("file_Err")<>0  then
  select case Uprequest.form("file_Err")
  case 1:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件最大500k [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  case 2:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件格式不对 [<a href='javascript:history.go(-1)']>重新上传</a>]</font></div>"
  case 3:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件太大且格式不对 [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  end select
  Echo str
  else
  Echo "<script language=""javascript"">parent.frm.oSiteLogo.value='"&uploadpath&""&Uprequest.Form("file")&"';</script>"
  Echo "<div style=""margin:10px 0;color:red"">上传成功!</div>"
  
  conn.close
  set conn=nothing
  end if
End if
Echo "<form name=form action=?action=logo&submit=logo method=post enctype=multipart/form-data>"
Echo "<div style='text-align:left;'><input type=file name=file size=15  style=""width:250px;"">&nbsp;"
Echo "<input type=submit name=submit value=上传></div>"
Echo "</form>"
end sub

'============================================================上传link图片
sub link()
if Request.QueryString("submit")="link" then
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
uploadsize="1024"
uploadtype="jpg/gif/png/bmp"
Set Uprequest=new UpLoadClass
	CreateFolder(uploadpath&"index.html")
    Uprequest.SavePath=uploadpath
    Uprequest.MaxSize=uploadsize*5000
    Uprequest.FileType=uploadtype
    AutoSave=true
    Uprequest.open
  if Uprequest.form("file_Err")<>0  then
  select case Uprequest.form("file_Err")
  case 1:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件最大500k [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  case 2:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件格式不对 [<a href='javascript:history.go(-1)']>重新上传</a>]</font></div>"
  case 3:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件太大且格式不对 [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  end select
  Echo str
  else
  Echo "<script language=""javascript"">parent.myform.LogoUrl.value='"&replace(uploadpath,"../","")&""&Uprequest.Form("file")&"';" 
  Echo "</script>"
  Echo "<div style=""margin:10px 0;color:red"">上传成功![<a href='javascript:history.go(-1)'>继续上传</a>]</div>"
  
  conn.close
  set conn=nothing
  end if
end if

Echo "<form name=form action=?action=link&submit=link method=post enctype=multipart/form-data>"
Echo "<div style='text-align:left;'><input type=file name=file size=15  style=""width:250px;"">&nbsp;"
Echo "<input type=submit name=submit value=上传></div>"
Echo "</form>"
end sub

'============================================================上传ad图片
sub ad()
if Request.QueryString("submit")="ad" then
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
uploadsize="1024"
uploadtype="jpg/gif/png/bmp"
Set Uprequest=new UpLoadClass
	CreateFolder(uploadpath&"index.html")
    Uprequest.SavePath=uploadpath
    Uprequest.MaxSize=uploadsize*5000
    Uprequest.FileType=uploadtype
    AutoSave=true
    Uprequest.open
  if Uprequest.form("file_Err")<>0  then
  select case Uprequest.form("file_Err")
  case 1:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件最大5000k [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  case 2:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件格式不对 [<a href='javascript:history.go(-1)']>重新上传</a>]</font></div>"
  case 3:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件太大且格式不对 [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  end select
  Echo str
  else
  Echo "<div style=""margin:10px 0;color:red"">上传成功![<a href='javascript:history.go(-1)'>继续上传</a>]</div>"
  Echo "<script language=""javascript"">parent.myform.Content.value=parent.myform.Content.value+'<a href=""http://"&SiteUrl&"""><img src="""&uploadpath&Uprequest.Form("file")&"""></a>';</script>" 
  Echo "<script language=""javascript"">parent.editor.insertHtml('<a href=""http://"&SiteUrl&"""><img src="""&uploadpath&Uprequest.Form("file")&"""></a>');</script>"
  conn.close
  set conn=nothing
  end if
end if

Echo "<form name=form action=?action=ad&submit=ad method=post enctype=multipart/form-data>"
Echo "<div style='text-align:left;'><input type=file name=file size=15  style=""width:250px;"">&nbsp;"
Echo "<input type=submit name=submit value=上传></div>"
Echo "</form>"
end sub

'============================================================上传内容图片
sub simg()
if Request.QueryString("submit")="simg" then
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
uploadsize="1024"
uploadtype="jpg/jpeg/gif/png/bmp"
Set Uprequest=new UpLoadClass
	CreateFolder(uploadpath&"index.html")
    Uprequest.SavePath=uploadpath
    Uprequest.MaxSize=uploadsize*5000
    Uprequest.FileType=uploadtype
    AutoSave=true
    Uprequest.open
  if Uprequest.form("file_Err")<>0  then
  select case Uprequest.form("file_Err")
  case 1:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件最大"&Uprequest.MaxSize/1024&"K [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  case 2:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件格式不对 [<a href='javascript:history.go(-1)']>重新上传</a>]</font></div>"
  case 3:str="<div style=""padding-top:5px;padding-bottom:5px;""> <font color=blue>文件太大且格式不对 [<a href='javascript:history.go(-1)'>重新上传</a>]</font></div>"
  end select
  Echo str
  else
  Echo "<script language=""javascript"">parent.myform.Images.value='"&uploadpath&Uprequest.Form("file")&"';</script>" 
  Echo "<script language=""javascript"">parent.myform.IsFlash.checked=true;</script>" 
  'Echo "<script language=""javascript"">parent.editor.insertHtml('<img src="""&uploadpath&Uprequest.Form("file")&""">');</script>"
  Echo "<div style=""margin:10px 0;color:red"">上传成功![<a href='javascript:history.go(-1)'>继续上传</a>]</div>"
  
  conn.close
  set conn=nothing
  end if

'Set Uprequest=nothing

'当不支持组件时不运行水印和缩图
If IsAspJpeg=1 then
Dim RV_img 
RV_img=uploadpath&Uprequest.Form("file")
Call laoy_draw(RV_img)
end if

end if

Echo "<form name=form action=?action=simg&submit=simg method=post enctype=multipart/form-data>"
Echo "<div style='text-align:left;'><input type=file name=file size=15  style=""width:250px;"">&nbsp;"
Echo "<input type=submit name=submit value=上传></div>"
Echo "</form>"
end sub

'============================================================编辑器上传内容图片
sub simgedit()
maxfile=5000 '上传文件大小限制:单位kb,1024就是1M
uploadtype="jpg/jpeg/gif/png/bmp"
uploadpath=SitePath&SiteUp&"/" & Year(Now) & right("0" & Month(Now), 2) & "/"
dim request2,fpath
dim upload,file,formName,filename,fileExt,id,imgTitle,imgWidth,imgHeight,imgBorder,ming,txt
set request2=New UpLoadClass
CreateFolder(uploadpath&"index.html")
request2.SavePath=uploadpath
request2.FileType=uploadtype
request2.AutoSave=2
request2.Open()
id=replace(trim(request2.form("id")),"'","")
imgTitle=replace(trim(request2.form("imgTitle")),"'","")
imgWidth=replace(trim(request2.form("imgWidth")),"'","")
imgHeight=replace(trim(request2.form("imgHeight")),"'","")
imgBorder=replace(trim(request2.form("imgBorder")),"'","")
fpath=trim(request2.form("imgFile"))

request2.MaxSize=1024*maxfile
if request2.Save("imgFile",0) then
	savefilename=request2.Form("imgFile")
	If IsAspJpeg=1 then
	Dim RV_img 
	RV_img=uploadpath&savefilename
	Call laoy_draw(RV_img)
	end if
	error1=0
else
	savefilename=""
	error1=1
	laoyerror=request2.Error
	Select case laoyerror
		case "1"
			message="图片最大为"&maxfile&"K!"
		case "2"
			message="文件类型不正确"
		case else
			message="上传不成功!"
	end select
end if
set request2=nothing

if savefilename<>"" then%>
  {"error":<%= error1 %>,"url":"<%= uploadpath&savefilename %>"}
<% Else %>
  {"error":<%= error1 %>,"message":"错误：<%= message %>"}
<% End If %>
<%
end sub
%> 
</body>
</html>