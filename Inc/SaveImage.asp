<% 
'远程图片保存类型
Const sFileExt="jpg|jpeg|gif|bmp|png"

'/////////////////////////////////////////////////////
'作 用：替换字符串中的远程文件为本地文件并保存远程文件
'参 数：
'      sHTML         : 要替换的字符串
'      sSavePath     : 保存文件的路径
'      sExt          : 执行替换的扩展名
Function ReplaceRemoteUrl(sHTML, sSaveFilePath, sFileExt)
     Dim s_Content
     s_Content = sHTML
     If IsObjInstalled(strobjectxmlhttp) = False then
         ReplaceRemoteUrl = s_Content
         Exit Function
     End If
     
     Dim re, RemoteFile, RemoteFileurl,SaveFileName,SaveFileType,arrSaveFileNameS,arrSaveFileName,sSaveFilePaths
     Set re = new RegExp
     re.IgnoreCase = True
     re.Global = True
	 re.pattern = "((http|https|ftp|rtsp|mms)://(.[^>]+?)\.(" & sFileExt & "))"
     Set RemoteFile = re.Execute(s_Content)
     For Each RemoteFileurl in RemoteFile
		 arrSaveFileName = Split(RemoteFileurl,".")
  		 SaveFileType=arrSaveFileName(UBound(arrSaveFileName))
		 RanNum=Int(900*Rnd)+100
         arrSaveFileName = Year(Now()) & Right("0" & Month(Now()),2)&  Right("0" & Day(Now()),2) & Right("0" & Hour(Now()),2) & Right("0" & Minute(Now()),2) & Right("0" & Second(Now()),2) &ranNum&"."&SaveFileType
  		CreateFolder sSaveFilePath&"index.html"
         SaveFileName = sSaveFilePath & arrSaveFileName
         Call SaveRemoteFile(SaveFileName, RemoteFileurl)

		If IsAspJpeg=1 then
		Dim RV_img 
		RV_img=SaveFileName
		Call laoy_draw(RV_img)
		end if
		 
     s_Content = Replace(s_Content,RemoteFileurl,SaveFileName)
     Next
     ReplaceRemoteUrl = s_Content
End Function

'////////////////////////////////////////
'作 用：保存远程的文件到本地
'参 数：LocalFileName ------ 本地文件名
'        RemoteFileUrl ------ 远程文件URL
'返回值：True ----成功
'  False ----失败
Sub SaveRemoteFile(s_LocalFileName,s_RemoteFileUrl)
     Dim Ads, Retrieval, GetRemoteData
     On Error Resume Next
     Set Retrieval = Server.CreateObject(strobjectxmlhttp)
     With Retrieval
         .Open "Get", s_RemoteFileUrl, False, "", ""
         .Send
         GetRemoteData = .ResponseBody
     End With
     Set Retrieval = Nothing
     Set Ads = Server.CreateObject(strobjectads)
     With Ads
         .Type = 1
         .Open
         .Write GetRemoteData
         .SaveToFile Server.MapPath(s_LocalFileName), 2
         .Cancel()
         .Close()
     End With
     Set Ads=nothing
End Sub

'////////////////////////////////////////
'作 用：检查组件是否已经安装
'参 数：strClassString ----组件名
'返回值：True ----已经安装
'      False ----没有安装
Function IsObjInstalled(s_ClassString)
     On Error Resume Next
     IsObjInstalled = False
     Err = 0
     Dim xTestObj
     Set xTestObj = Server.CreateObject(s_ClassString)
     If 0 = Err Then IsObjInstalled = True
     Set xTestObj = Nothing
     Err = 0
End Function
%>