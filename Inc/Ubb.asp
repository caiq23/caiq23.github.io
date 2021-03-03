<%
function UBB_flv(strText)
	dim strContent
	dim re,Test
	
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	strContent=strText
	re.Pattern="\[flv=*([0-9]*),*([0-9]*)\]"
	Test=re.Test(strContent)
	if Test then
		strContent=re.replace(strContent, chr(1) & "flv=$1,$2" & chr(2))
		re.Pattern="\[\/flv\]"
		Test=re.Test(strContent)
		if Test then
			strContent=re.replace(strContent, chr(1) & "/flv" & chr(2))
				re.Pattern="\x01flv=*([0-9]*),*([0-9]*)\x02(.[^\x01]*)\x01\/flv\x02"
				strContent=re.Replace(strContent,"<div style=""text-align:center;""><EMBED pluginspage=http://www.macromedia.com/go/getflashplayer src="&SitePath&"images/flvplayer.swf width=$1 height=$2 type=application/x-shockwave-flash allowfullscreen=true flashvars=""file=$3&amp;autostart=true"" quality=high play=true loop=true></div>")
			re.Pattern="\x02"
			strContent=re.replace(strContent, "]")
		end if
		re.Pattern="\x01"
		strContent=re.replace(strContent, "[")
	end if
	set re=Nothing
	UBB_flv=strContent
end function

function UBB_mp4(strText)
	dim strContent
	dim re,Test
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	strContent=strText
	re.Pattern="\[mp4=*([0-9]*),*([0-9]*)\]"
	Test=re.Test(strContent)
	if Test then
		strContent=re.replace(strContent, chr(1) & "mp4=$1,$2" & chr(2))
		re.Pattern="\[\/mp4\]"
		Test=re.Test(strContent)
		if Test then
			strContent=re.replace(strContent, chr(1) & "/mp4" & chr(2))
				re.Pattern="\x01mp4=*([0-9]*),*([0-9]*)\x02(.[^\x01]*)\x01\/mp4\x02"
				strContent=re.Replace(strContent,"<div id=""a2""></div><script type=""text/javascript""src="""&SitePath&"ckplayer/ckplayer.js""charset=""utf-8""></script><script type=""text/javascript"">var flashvars={f:'$3',c:0,i:'"&rs("images")&"',p:0,v:100,e:1,h:3};var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always',wmode:'transparent'};var video=['$3->video/mp4'];CKobject.embed('"&SitePath&"ckplayer/ckplayer.swf','a2','ckplayer_a1',$1,$2,false,flashvars,video,params);</script>")
			re.Pattern="\x02"
			strContent=re.replace(strContent, "]")
		end if
		re.Pattern="\x01"
		strContent=re.replace(strContent, "[")
	end if
	set re=Nothing
	UBB_mp4=strContent
end function

function UBB_mp3(strText)
	dim strContent
	dim re,Test
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	strContent=strText
	re.Pattern="\[mp3=*([0-9]*),*([0-9]*)\]"
	Test=re.Test(strContent)
	if Test then
		strContent=re.replace(strContent, chr(1) & "mp3=$1,$2" & chr(2))
		re.Pattern="\[\/mp3\]"
		Test=re.Test(strContent)
		if Test then
			strContent=re.replace(strContent, chr(1) & "/mp3" & chr(2))
				re.Pattern="\x01mp3=*([0-9]*),*([0-9]*)\x02(.[^\x01]*)\x01\/mp3\x02"
				strContent=re.Replace(strContent,"<script src="""&SitePath&"js/music/audiojs/audio.min.js?y='+Math.random()""></script><script>audiojs.events.ready(function(){audiojs.createAll()});</script><audio src=""$3"" preload=""auto""></audio>")
			re.Pattern="\x02"
			strContent=re.replace(strContent, "]")
		end if
		re.Pattern="\x01"
		strContent=re.replace(strContent, "[")
	end if
	set re=Nothing
	UBB_mp3=strContent
end function

Function UBBCode(strContent)
UBBCode=BbbImg(ReplaceKey(UBB_mp3(UBB_flv(strContent))))
End Function
%>