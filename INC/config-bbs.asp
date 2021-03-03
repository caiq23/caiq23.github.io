<%


call chk_webconfig()

'开始读取缓存里面的设置
Set objXML2 = Server.CreateObject("Msxml2.DOMDocument") 
objXML2.async = False
loadResult = objXML2.load(Server.MapPath(DB_folder&"cache/webconfig.xml")) 

if not loadResult then call del_cache2()

Set objNodes = objXML2.getElementsByTagName("bbsset") 
if objNodes.length>0 then
	bbsset_sitename=chk_nodes(objNodes(0).selectSingleNode("bbsset_sitename"))
	bbsset_boardpagesize=chk_nodes(objNodes(0).selectSingleNode("bbsset_boardpagesize"))
	bbsset_topicpagesize=chk_nodes(objNodes(0).selectSingleNode("bbsset_topicpagesize"))
	bbsset_topicpoststate=chk_nodes(objNodes(0).selectSingleNode("bbsset_topicpoststate"))
	bbsset_search_hotword=chk_nodes(objNodes(0).selectSingleNode("bbsset_search_hotword"))	
	bbsset_site_keyword=chk_nodes(objNodes(0).selectSingleNode("bbsset_site_keyword"))
	bbsset_site_description=chk_nodes(objNodes(0).selectSingleNode("bbsset_site_description"))
	bbsset_Filter_word=chk_nodes(objNodes(0).selectSingleNode("bbsset_Filter_word"))
	bbsset_open_reghy=chk_nodes(objNodes(0).selectSingleNode("bbsset_open_reghy"))
	bbsset_site_name2=chk_nodes(objNodes(0).selectSingleNode("bbsset_site_name2"))
	bbsset_site_name3=chk_nodes(objNodes(0).selectSingleNode("bbsset_site_name3"))
	bbsset_site_census=chk_nodes(objNodes(0).selectSingleNode("bbsset_site_census")) 
	bbsset_post_times1=chk_nodes(objNodes(0).selectSingleNode("bbsset_post_times1")) 
	bbsset_post_times2=chk_nodes(objNodes(0).selectSingleNode("bbsset_post_times2"))
	bbsset_post_times3=chk_nodes(objNodes(0).selectSingleNode("bbsset_post_times3")) 
	bbsset_post_mini1=chk_nodes(objNodes(0).selectSingleNode("bbsset_post_mini1")) 
	bbsset_post_mini2=chk_nodes(objNodes(0).selectSingleNode("bbsset_post_mini2")) 
	bbsset_open_wap=chk_nodes(objNodes(0).selectSingleNode("bbsset_open_wap")) 
	bbsset_html_open=chk_nodes(objNodes(0).selectSingleNode("bbsset_html_open")) 
	bbsset_msg_times=chk_nodes(objNodes(0).selectSingleNode("bbsset_msg_times")) 
	
	bbsset_tlogin_openid=chk_nodes(objNodes(0).selectSingleNode("bbsset_tlogin_openid"))
	bbsset_open_wxlogin=chk_nodes(objNodes(0).selectSingleNode("bbsset_open_wxlogin"))
	bbsset_open_qqlogin=chk_nodes(objNodes(0).selectSingleNode("bbsset_open_qqlogin"))
	
	bbsset_tpay_openid=chk_nodes(objNodes(0).selectSingleNode("bbsset_tpay_openid"))
	bbsset_open_pay=chk_nodes(objNodes(0).selectSingleNode("bbsset_open_pay"))
else
	call del_cache2()
end if
set objNodes = Nothing 
Set objXML = Nothing 





'检查网站配置文件是否存在，如果不存在就生成
sub chk_webconfig()
	if chkFile(DB_folder&"cache/webconfig.xml")="no" then
		call gotoFolder(DB_folder&"cache/")
		sql="select * from BBS_Setting"
		set rs=bbsconn.execute(sql)
		config_html="<?xml version=""1.0"" encoding=""gb2312""?><bbsset>"
		do while not rs.eof
			set_name=rs("set_name")
			set_value=rs("set_value")
			set_value="<![CDATA["& set_value &"]]>"
			config_html=config_html&"<"& set_name &">"& set_value &"</"& set_name &">"
		rs.movenext
		loop
		config_html=config_html&"</bbsset>"		
		call gotoFile(DB_folder&"cache/webconfig.xml",config_html)		
	end if
end sub

Function getHTTPPage(Path) 
t = GetBody(Path) 
getHTTPPage=BytesToBstr(t,"GB2312") 
End function 

Function BytesToBstr(body,Cset) 
dim objstream 
set objstream = Server.CreateObject("adodb.stream") 
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset = Cset 
BytesToBstr = objstream.ReadText 
objstream.Close 
set objstream = nothing 
End Function 

Function GetBody(url) 
'on error resume next 
Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
With Retrieval
.Open "Get", url, False, "", "" 
.Send 
GetBody = .ResponseBody 
End With 
Set Retrieval = Nothing 
End Function 


'生成html文件
sub gotoFile(path_html,path_asp)
	'path_asp=Server.MapPath(path_asp)
	'html=getHTTPPage(path_asp)
	html=path_asp
	if len(html)>0 then	
		Set fso=Server.CreateObject("Scripting.FileSystemObject")
		Set htmlwrite=fso.CreateTextFile(Server.MapPath(path_html),true,false)
		htmlwrite.WriteLine(html)
		htmlwrite.close()
	end if
end sub

'检查文件是否存在
function chkFile(path)
    chkFile="no"
    Set fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.FileExists(Server.MapPath(path)) then chkFile="yes"	
    set fso=Nothing
end function

'检查文件夹是否存在，如果不存在，则创建
sub gotoFolder(path)
    Set fso=Server.CreateObject("Scripting.FileSystemObject") 
	'On Error Resume Next	
	path2=Server.MapPath(path)	
	If fso.FolderExists(path2)=false Then	    	
		Set htmlwrite=fso.CreateFolder(path2)
		set htmlwrite=Nothing
	end if	
    set fso=Nothing
end sub

'检查节点是否存在
function chk_nodes(node_name)	
	if node_name Is Nothing Then	
		call del_cache2()
	else
		chk_nodes=node_name.Text
		if IsNumeric(chk_nodes) then chk_nodes=chk_num(chk_nodes)
	end if
end function

sub del_cache2()
	call del_cache()
	Response.write "<br>网站配置文件已更改，请重新刷新本页面加载！<br>如多次刷新失败，请到后台参数设置重新设置一次，再点击保存。" 
	Response.end 
end sub


%>