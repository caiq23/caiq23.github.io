<!--#include file="../inc/conn.asp"-->
function KillError()
{
return false;
}
window.onerror=KillError;
var web_url="<%=SitePath%>";
function $(id){return document.getElementById(id);}
//运行文本域代码
function runCode(obj) {
        var winname = window.open('', "_blank", '');
        winname.document.open('text/html', 'replace');
	winname.opener = null // 防止代码对页面修改
        winname.document.write(obj.value);
        winname.document.close();
}
function saveCode(obj) {
        var winname = window.open('', '_blank', 'top=10000');
        winname.document.open('text/html', 'replace');
        winname.document.write(obj.value);
        winname.document.execCommand('saveas','','code.htm');
        winname.close();
}
function copycode(obj) {
	obj.select(); 
	js=obj.createTextRange(); 
	js.execCommand("Copy")
}

function insertTags(tagOpen, tagClose, sampleText) {
    var txtarea = document.getElementById("memContent");
	// IE
	if(document.selection) {
		var theSelection = document.selection.createRange().text;
		if(!theSelection) { theSelection=sampleText;}
		txtarea.focus();
		if(theSelection.charAt(theSelection.length - 1) == " "){
			theSelection = theSelection.substring(0, theSelection.length - 1);
			document.selection.createRange().text = tagOpen + theSelection + tagClose + " ";
		} else {
			document.selection.createRange().text = tagOpen + theSelection + tagClose;
		}
	// Mozilla
	} else if(txtarea.selectionStart || txtarea.selectionStart == '0') {
 		var startPos = txtarea.selectionStart;
		var endPos = txtarea.selectionEnd;
		var myText = (txtarea.value).substring(startPos, endPos);
		if(!myText) { myText=sampleText;}
		if(myText.charAt(myText.length - 1) == " "){ // exclude ending space char, if any
			subst = tagOpen + myText.substring(0, (myText.length - 1)) + tagClose + " "; 
		} else {
			subst = tagOpen + myText + tagClose; 
		}
		txtarea.value = txtarea.value.substring(0, startPos) + subst + txtarea.value.substring(endPos, txtarea.value.length);
		txtarea.focus();
		var cPos=startPos+(tagOpen.length+myText.length+tagClose.length);
		txtarea.selectionStart=cPos;
		txtarea.selectionEnd=cPos;
	// All others
	} else {
		tagOpen=tagOpen.replace(/\n/g,"");
		tagClose=tagClose.replace(/\n/g,"");
		document.infoform.infobox.value=tagOpen+sampleText+tagClose;
		txtarea.focus();
	}
	if (txtarea.createTextRange) txtarea.caretPos = document.selection.createRange().duplicate();
}

//图片缩放
function resizeimg(ImgD,iwidth,iheight) {
     var image=new Image();
     image.src=ImgD.src;
     if(image.width>0 && image.height>0){
        if(image.width/image.height>= iwidth/iheight){
           if(image.width>iwidth){
               ImgD.width=iwidth;
               ImgD.height=(image.height*iwidth)/image.width;
           }else{
                  ImgD.width=image.width;
                  ImgD.height=image.height;
                }
               ImgD.alt=image.width+"×"+image.height;
        }
        else{
                if(image.height>iheight){
                       ImgD.height=iheight;
                       ImgD.width=(image.width*iheight)/image.height;
                }else{
                        ImgD.width=image.width;
                        ImgD.height=image.height;
                     }
                ImgD.alt=image.width+"×"+image.height;
            }
　　　　　ImgD.style.cursor= "pointer"; //改变鼠标指针
　　　　　ImgD.onclick = function() { window.open(this.src);} //点击打开大图片
　　　　if (navigator.userAgent.toLowerCase().indexOf("ie") > -1) { //判断浏览器，如果是IE
　　　　　　ImgD.title = "请使用鼠标滚轮缩放图片!";
　　　　　　ImgD.onmousewheel = function img_zoom() //滚轮缩放
　　　　　 {
　　　　　　　　　　var zoom = parseInt(this.style.zoom, 10) || 100;
　　　　　　　　　　zoom += event.wheelDelta / 12;
　　　　　　　　　　if (zoom> 0)　this.style.zoom = zoom + "%";
　　　　　　　　　　return false;
　　　　　 }
　　　  } else { //如果不是IE
　　　　　　　     ImgD.title = "点击图片可在新窗口打开";
　　　　　　   }
    }
}

function Getcolor(img_val,input_val){
	var arr = showModalDialog("../images/selcolor.html?action=title", "", "dialogWidth:18.5em; dialogHeight:17.5em; status:0; help:0");
	if (arr != null){
		document.getElementById(input_val).value = arr;
		img_val.style.backgroundColor = arr;
		}
}

var flag=false;
function DrawImage(ImgD,w){
var image=new Image();
var iwidth = w;
var iheight = 1000; 
image.src=ImgD.src;
if(image.width>0 && image.height>0){
   flag=true;
   if(image.width/image.height>= iwidth/iheight){
    if(image.width>iwidth){ 
     ImgD.width=iwidth;
     ImgD.height=(image.height*iwidth)/image.width;
    }else{
     ImgD.width=image.width; 
     ImgD.height=image.height;
    }
   }else{
    if(image.height>iheight){ 
     ImgD.height=iheight;
     ImgD.width=(image.width*iheight)/image.height; 
    }else{
     ImgD.width=image.width; 
     ImgD.height=image.height;
    }
   }
}
}

//设为首页
function SetHome(obj,url){
          try{
                    obj.style.behavior='url(#default#homepage)';
                    obj.setHomePage(url);
          }catch(e){
                    if(window.netscape){
                              try{
                                        netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                              }catch(e){
                                        alert("抱歉，此操作被浏览器拒绝！\n\n请在浏览器地址栏输入'about:config'并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
                              }
                    }else{
                              alert("抱歉，您所使用的浏览器无法完成此操作。\n\n您需要手动将【"+url+"】设置为首页。");
                    }
          }
}

function addfavorite()
{
 if (document.all)
 {
 window.external.addFavorite('http://<%=SiteUrl%>','<%=SiteTitle%>');
 }
 else if (window.sidebar)
 {
 window.sidebar.addPanel('<%=SiteTitle%>', 'http://<%=SiteUrl%>', "");
 }
} 

function nTabs(thisObj,Num){
if(thisObj.className == "active")return;
var tabObj = thisObj.parentNode.id;
var tabList = document.getElementById(tabObj).getElementsByTagName("li");
for(i=0; i < tabList.length; i++)
{
  if (i == Num)
  {
   thisObj.className = "active"; 
      document.getElementById(tabObj+"_Content"+i).style.display = "block";
  }else{
   tabList[i].className = "normal"; 
   document.getElementById(tabObj+"_Content"+i).style.display = "none";
  }
} 
}

function displaySubMenu(li){
var subMenu = li.getElementsByTagName("div")[0];
subMenu.style.display = "block";}

function hideSubMenu(li){
var subMenu = li.getElementsByTagName("div")[0];
subMenu.style.display = "none";}

function uaredirect(f){try{if(document.getElementById("bdmark")!=null){return}var b=false;if(arguments[1]){var e=window.location.host;var a=window.location.href;if(isSubdomain(arguments[1],e)==1){f=f+"/#m/"+a;b=true}else{if(isSubdomain(arguments[1],e)==2){f=f+"/#m/"+a;b=true}else{f=a;b=false}}}else{b=true}if(b){var c=window.location.hash;if(!c.match("fromapp")){if((navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i))){location.replace(f)}}}}catch(d){}}function isSubdomain(c,d){this.getdomain=function(f){var e=f.indexOf("://");if(e>0){var h=f.substr(e+3)}else{var h=f}var g=/^www\./;if(g.test(h)){h=h.substr(4)}return h};if(c==d){return 1}else{var c=this.getdomain(c);var b=this.getdomain(d);if(c==b){return 1}else{c=c.replace(".","\\.");var a=new RegExp("\\."+c+"$");if(b.match(a)){return 2}else{return 0}}}};