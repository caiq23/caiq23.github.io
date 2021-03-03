<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/newfun_db.asp" -->
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<title>上传</title>
<script language="javascript" src="../inc/jquery.min.js"></script>
<script language="javascript" src="../inc/lrz_upload/lrz.bundle.js"></script>
</head>

<body>
<%
mydo=trim(request("mydo"))
modid=chk_num(trim(request("modid")))
upload_type=chk_num(trim(request("upload_type")))
pic_64=trim(request("pic_64"))


	
select case upload_type
	case 1
		'如果是帖子上传的图片
		img_max_width=700
		img_max_height=700
	case else
		'其他图片，如头像，或图标等
		img_max_width=120
		img_max_height=120
end select


call dperror_admin(modid<=0,"用户信息丢失，请重新登录之后再重试","")


if mydo="upload_ok" then

	picture=pic_64
	if len(picture)>0 then
		if instr(picture,";base64,")>0 then
			arr_t=split(picture,";base64,")
			picture=arr_t(1)
		end if
	end if	
	xmlstr="<data>"&picture&"</data>"
	Dim xml : Set xml=Server.CreateObject("MSXML2.DOMDocument")
	Dim stm : Set stm=Server.CreateObject("ADODB.Stream")
	xml.resolveExternals=False
	xml.loadxml(xmlstr)
	xml.documentElement.setAttribute "xmlns:dt","urn:schemas-microsoft-com:datatypes"
	xml.documentElement.dataType = "bin.base64"	
	stm.Type=1
	stm.Open
	stm.Write xml.documentElement.nodeTypedValue
	Set xml=Nothing
	
	file_type="jpg"
	
	dfile=BBS_folder&"upload"
	call gotoFolder(dfile)
	

	
select case upload_type
case 1

	time_num=dis_timenum()
	dfile=dfile&"/image/"
	call gotoFolder(dfile)
	dfile=dfile&modid&"/"
	call gotoFolder(dfile)
	dfile=dfile&time_num&"."&file_type
	'response.Write(Server.MapPath(dfile))
	stm.SaveToFile Server.MapPath(dfile)	
	set SubFile=nothing
	Set upload=nothing
	
	%>
	<script>
	
	parent.window.document.getElementById('post_upload_img_list').innerHTML=parent.window.document.getElementById('post_upload_img_list').innerHTML+'<br><img src="<%=dfile%>">';
	parent.window.document.getElementById('upload_img_list').value=parent.window.document.getElementById('upload_img_list').value+'<img src="<%=dfile%>">';
	
	
	</script>
	<%

case 2

	
	

	

	dfile=dfile&"/user_img/"
	call gotoFolder(dfile)
	dfile=dfile&left(modid,2)&"/"
	call gotoFolder(dfile)
	dfile=dfile&modid&"."&file_type
	call del_file(dfile)
	stm.SaveToFile Server.MapPath(dfile)
	
	
	'这里修改用户数据库的头像地址
	user_img=dfile
	if len(user_img)>0 then
		user_img=replace(user_img,"../","")
		sql="update BBS_User set user_img='"& user_img &"' where user_id="& modid &""
		set rs=bbsconn.execute(sql)
	end if
	
	%>
<script>
	parent.window.document.getElementById("user_img").src='<%=user_img%>?<%=thistime%>';
	alert("恭喜您，图片上传成功！");
	</script>
	<%
case 3

	dfile=dfile&"/board_img/"
	call gotoFolder(dfile)
	dfile=dfile&modid&"."&file_type
	call del_file(dfile)
	stm.SaveToFile Server.MapPath(dfile)	
	set SubFile=nothing
	Set upload=nothing
	
	
	
	'这里修改版块数据库中记录的图标
	user_img=dfile
	if len(user_img)>0 then
		user_img=replace(user_img,"../","")
		sql="update BBS_Board set board_img='"& user_img &"' where board_id="& modid &""
		set rs=bbsconn.execute(sql)
	end if
	%>
<script>
	parent.window.document.getElementById("board_img").src='<%=user_img%>?<%=thistime%>';
	alert("恭喜您，版块图标上传成功！");
	</script>
	<%
	
	
end select

	stm.Close
	Set stm=Nothing
end if
%>

<input type="file" name="file1" id="file1">
<button id="Up" class="btn btn-primary mt-2">上传</button>
<form name="up" action="?mydo=upload_ok&modid=<%=modid%>&upload_type=<%=upload_type%>" method="post">
<input type="text" name="pic_64" id="pic_64">
</form>


</body>
</html>

<script>


var oldfilesize,newfilesize;
var $file=$("#file1");
$file.on("change",function(){GetFile($file.get(0).files);});
//声明一个formdata 用来上传
var UForm=new FormData();
//$("#Up").on("click",function(){DoUp();});
  
var $this=$("#drop");
with($this){
    on("dragenter",function(){$this.addClass("drag_hover");});
    on("dragleave",function(){$this.removeClass("drag_hover");});
    on("dragover",function(e){
      e.originalEvent.dataTransfer.dragEffect = 'copy';
      e.preventDefault();
    });
    on("drop",function(e){
      e.preventDefault();
      var files = e.originalEvent.dataTransfer.files;
      $this.removeClass("drag_hover");
      if(files.length != 0){GetFile(files);};
    });
};
function GetFile(files){
	//var img_max_width='<%=img_max_width%>';
	//var img_max_height='<%=img_max_height%>';
  var file=files?files[0]:false;if(!file){return false;};
  if(file){
    oldfilesize=file.size;
	UForm.append("type",$.now()+"."+file.type);
    lrz(file,{
      width:<%=img_max_width%>,//设置压缩后的最大宽
      height:<%=img_max_height%>,
      quality:0.7,//图片压缩质量，取值 0 - 1，默认为0.7
      fieldName:"aijquery" //后端接收的字段名，默认：file,这个不用设置，我们在上传的时候，可以自己创建FormData,不用这里的
    }).then(function(rst){
      console.log(rst);
      newfilesize=rst.file.size;
      //alert("图片压缩成功，原为："+oldfilesize+",压缩后为："+newfilesize);
      //UForm.append("aijQueryUpImage",rst.file);
      ShowFile(rst.file);	  
    }).catch(function(err){
      console.log(err);
      alert("压缩图片时出错,请联系站长！");
      return false;
    });
  };
};
function ShowFile(file){
	var reader = new FileReader();
  	reader.onload = function(e) {
		var img=new Image();
      	img.src=e.target.result;
      	//$("#user_img").html(img);
		window.document.getElementById("pic_64").value=e.target.result;		
		document.forms['up'].submit();
		
    };
 	reader.onerror=function(e,b,c){
    	//error
 	};
  	reader.readAsDataURL(file);
}


</script>



