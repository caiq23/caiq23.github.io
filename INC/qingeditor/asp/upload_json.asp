<!-- #include file="../../conn-bbs.asp" -->
<!--#include file="UpLoad_Class.asp"-->
<!--#include file="JSON_2.0.4.asp"-->
<%

' qingeditor ASP

'

user_id=session_user_id
if len(user_id)>0 then
	user_id=cdbl(user_id)
else
	user_id=0
end if
if user_id<=0 then 
	showError("读取用户ID出错，或者您登录已超时，请重新重新后再操作")
end if

Dim aspUrl, savePath, saveUrl, maxSize, fileName, fileExt, newFileName, filePath, fileUrl, dirName
Dim extStr, imageExtStr, flashExtStr, mediaExtStr, fileExtStr
Dim upload, file, fso, ranNum, hash, ymd, mm, dd, result

aspUrl = Request.ServerVariables("SCRIPT_NAME")
aspUrl = left(aspUrl, InStrRev(aspUrl, "/"))

'文件保存目录路径
savePath = "../../../UPLOAD/"
'文件保存目录URL
saveUrl = aspUrl & "../../../UPLOAD/"
'定义允许上传的文件扩展名
imageExtStr = "gif|jpg|jpeg|png|bmp"
flashExtStr = "swf|flv"
mediaExtStr = "swf|flv|mp3|wav|wma|wmv|mid|avi|mpg|asf|rm|rmvb"
fileExtStr = "doc|docx|xls|xlsx|ppt|htm|html|txt|zip|rar|gz|bz2"
'最大文件大小
maxSize = 5 * 1024 * 1024 '5M

Set fso = Server.CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

dirName = Request.QueryString("dir")
If isEmpty(dirName) Then
	dirName = "image"
End If
If instr(lcase("image,flash,media,file"), dirName) < 1 Then
	showError("目录名不正确。")
End If

Select Case dirName
	Case "flash" extStr = flashExtStr
	Case "media" extStr = mediaExtStr
	Case "file" extStr = fileExtStr
	Case Else  extStr = imageExtStr
End Select

set upload = new AnUpLoad
upload.Exe = extStr
upload.MaxSize = maxSize
upload.GetData()
if upload.ErrorID>0 then 
	showError(upload.Description)
end if

'创建文件夹
savePath = savePath & dirName & "/"
saveUrl = saveUrl & dirName & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

savePath = savePath & user_id & "/"
saveUrl = saveUrl & user_id & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

mm = month(now)
If mm < 10 Then
	mm = "0" & mm
End If
dd = day(now)
If dd < 10 Then
	dd = "0" & dd
End If
ymd = year(now) & mm & dd
savePath = savePath & ymd & "/"
saveUrl = saveUrl & ymd & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

set file = upload.files("imgFile")
if file is nothing then
	showError("请选择文件。")
end if

result = file.saveToFile(savePath, 0, true)
if result=flase then
	showError(file.Exception)
end if

filePath = Server.mappath(savePath & file.filename)
fileUrl = saveUrl & file.filename

Set upload = nothing
Set file = nothing

If Not fso.FileExists(filePath) Then
	showError("上传文件失败。")
End If

if isobjinstalled("persits.jpeg")=true then call OKbigpic(filePath)

Response.AddHeader "Content-Type", "text/html; charset=gb2312"
Set hash = jsObject()
hash("error") = 0
hash("url") = fileUrl
hash.Flush
Response.End


'检查空间是否支持ASPjpeg
function isobjinstalled(strclassstring)
    on error resume next
    isobjinstalled = false
    err = 0
    dim xtestobj
    set xtestobj = server.createobject(strclassstring)
    if 0 = err then isobjinstalled = true
    set xtestobj = nothing
    err = 0
end function



Function showError(message)
	Response.AddHeader "Content-Type", "text/html; charset=gb2312"
	Dim hash
	Set hash = jsObject()
	hash("error") = 1
	hash("message") = message
	hash.Flush
	Response.End
End Function


sub OKbigpic(FileName)
Dim bigpic,bigpicPath,fss
Set bigpic = Server.CreateObject("Persits.Jpeg")
set fss=createobject("scripting.filesystemobject")
' 设置图片质量
bigpic.Interpolation=2
bigpic.Quality=90
' 图片位置
if fss.fileExists(FileName) then
bigpic.Open FileName
'下面是按比例缩放
n_MaxWidth=1024
n_MaxHeight=768
'按比例取得缩略图宽度和高度
Dim n_OriginalWidth, n_OriginalHeight '原图片宽度、高度
Dim n_BuildWidth, n_BuildHeight '缩略图宽度、高度
Dim div1, div2
Dim n1, n2
'修改Jpeg
n_OriginalWidth = bigpic.Width
n_OriginalHeight = bigpic.Height
div1 = n_OriginalWidth / n_OriginalHeight
div2 = n_OriginalHeight / n_OriginalWidth
n1 = 0
n2 = 0
If n_OriginalWidth > n_MaxWidth Then
n1 = n_OriginalWidth / n_MaxWidth
Else
n_BuildWidth = n_OriginalWidth
End If
If n_OriginalHeight > n_MaxHeight Then
n2 = n_OriginalHeight / n_MaxHeight
Else
n_BuildHeight = n_OriginalHeight
End If
If n1 <> 0 Or n2 <> 0 Then
If n1 > n2 Then
n_BuildWidth = n_MaxWidth
n_BuildHeight = n_MaxWidth * div2
Else
n_BuildWidth = n_MaxHeight * div1
n_BuildHeight = n_MaxHeight
End If
End If
'指定宽度和高度生成
bigpic.Width = n_BuildWidth
bigpic.Height = n_BuildHeight
' 保存文件
bigpic.Save (FileName)
' 注销对象
Set bigpic = Nothing
end if
end sub
%>
