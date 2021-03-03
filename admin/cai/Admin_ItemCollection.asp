<!--#include file="inc/conn.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/clsCache.asp"-->
<%
Dim Action,ItemID,CollecType
Dim FoundErr,ErrMsg
Dim SqlItem,RsItem
Dim Arr_Item,Arr_Filters,Arr_Histrolys,myCache,CollecTest,Content_View
Dim CacheTemp
FoundErr=False

CacheTemp=Lcase(trim(request.ServerVariables("SCRIPT_NAME")))
CacheTemp=left(CacheTemp,instrrev(CacheTemp,"/"))
CacheTemp=replace(CacheTemp,"\","_")
CacheTemp=replace(CacheTemp,"/","_")
CacheTemp="ansir" & CacheTemp

'检察表单
Call DelNews()
Call CheckForm()
If FoundErr<>True Then
   Call SetCache()
   If FoundErr<>True Then
      'If CollecType=0 Then
         'ErrMsg= "<meta http-equiv=""refresh"" content=""3;url=Admin_ItemCollecSteady.asp?ItemNum=1&ListNum=1&ListSuccesNum=0&ListFalseNum=0&NewsNumAll=0"">"
      'ElseIf CollecType=1 Then
         ErrMsg="<meta http-equiv=""refresh"" content=""3;url=Admin_ItemCollecFast.asp?ItemNum=1&ListNum=1&NewsSuccesNum=0&NewsFalseNum=0&ImagesNumAll=0"">"
      'ElseIf CollecType=2 Then
         'ErrMsg="<meta http-equiv=""refresh"" content=""3;url=Admin_ItemCollecScreen.asp?Action=GetList"">"
      'End If
   End If
End If
If FoundErr=True Then
   Call WriteErrMsg(ErrMsg)
Else
   Call Main()
End If
'关闭数据库链接
Call CloseConn()
Call CloseConnItem()
%>

<%Sub Main%>
<html>
<head>
<title>采集系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../images/Admin_css.css">
</head>
<body>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="border" >
    <tr> 
      <td height="100" colspan="2" align=center>
      <br>
      <a href="http://www.laoy.net" title="老Y文章管理系统！" target="_blank"><img src="<%=sitelogo%>" border="0"></a>
      <br><br>
      欢迎使用老Y文章采集系统，正在初始化数据，请稍后...
      <br><br>
<%=ErrMsg%>
      </td>
    </tr>
</table>
<!--#include file="../Admin_Copy.asp"-->        
</body>         
</html>
<%End Sub

Sub CheckForm()

   '提取表单
   Action=trim(Request.Form("Action"))
   ItemID=Trim(Request.Form("ItemID"))
   CollecType=Trim(Request.Form("CollecType"))
   CollecTest=Trim(Request.Form("CollecTest"))
   Content_View=Trim(Request.Form("Content_View"))
   '检察表单
   If ItemID="" Then
      FoundErr=True
      ErrMsg=ErrMsg & "<br><li>请您选择项目!</li>"
   Else
      If Instr(ItemID,",")>0 Then
         ItemID=Replace(ItemID," ","")
      End If
   End If 
   If CollecTest="yes" Then
      CollecTest=True
   Else
      CollecTest=False
   End If
   If Content_View="yes" Then
      Content_View=True
   Else
      Content_View=False
   End If
End Sub
Sub SetCache()
   '项目信息
   SqlItem ="select * from Item where ItemID in(" & ItemID & ")"
   Set RsItem=Server.CreateObject("adodb.recordset")
   RsItem.Open SqlItem,ConnItem,1,1
   If Not RsItem.Eof Then
      Arr_Item=RsItem.GetRows()
   End If
   RsItem.Close
   Set RsItem=Nothing

   Set myCache=new clsCache
   myCache.name=CacheTemp & "items"
   Call myCache.clean()
   If IsArray(Arr_Item)=True Then
      myCache.add Arr_Item,Dateadd("n",1000,now)
   Else
      FoundErr=True
      ErrMsg=ErrMsg & "<br>发生意外错误！"
   End If

   '过滤信息
   SqlItem ="select * from Filters where Flag=True"
   Set RsItem=Server.CreateObject("adodb.recordset")
   RsItem.Open SqlItem,ConnItem,1,1
   If Not RsItem.Eof Then
      Arr_Filters=RsItem.GetRows()
   End If
   RsItem.Close
   Set Rsitem=Nothing

   myCache.name=CacheTemp & "filters"
   Call myCache.clean()
   If IsArray(Arr_Filters)=True Then
      myCache.add Arr_Filters,Dateadd("n",1000,now)
   End If

   '历史记录
   SqlItem ="select NewsUrl,Title,CollecDate,Result from Histroly"
   Set RsItem=Server.CreateObject("adodb.recordset")
   RsItem.Open SqlItem,ConnItem,1,1
   If Not RsItem.Eof Then
      Arr_Histrolys=RsItem.GetRows()
   End If
   RsItem.Close
   Set RsItem=Nothing

   myCache.name=CacheTemp & "histrolys"
   Call myCache.clean()
   If IsArray(Arr_Histrolys)=True Then
      myCache.add Arr_Histrolys,Dateadd("n",1000,now)
   End If

   '其它信息
   myCache.name=CacheTemp & "collectest"
   Call myCache.clean()
   myCache.add CollecTest,Dateadd("n",1000,now)

   myCache.name=CacheTemp & "contentview"
   Call myCache.clean()
   myCache.add Content_View,Dateadd("n",1000,now)

   set myCache=nothing
End Sub
Sub DelNews()
   ConnItem.execute("Delete From [NewsList]")
End Sub
%>



