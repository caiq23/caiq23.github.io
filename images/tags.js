function delHtmlTag(str) 
{ 
   return str.replace(/<[^>]+>/g,"");//去掉所有的html标记 
}
function lastIndexDemo(a)
{
   var str = delHtmlTag(document.getElementById("title").value);//获取字符串
var keys = new Array;//词表存储序列
var titles = new Array;
var key = new Array;//关键词对象存储序列
var gotkey = new Array();//关键词对象
var name = new Array();//关键词name
var address = new Array();//关键词在词表中位置
var times = new Array();//关键词在本篇目中的出现次数
var tfx = new Array();//关键词tfx值
var stopkey = new Array();//关键词是否为停用词
var desc = new Array();//关键词排名
var strkey;// 声明变量预存关键字
var strl = str.length;//获取字符串长度
getkeywords(keys,titles);//初始化关键词表和标题序列
getkey(str,strkey,strl,keys,key,name,address,stopkey);//获取关键词，词表位置，是否停用
timesn(times,address);//获取n（出现多少次）
gettfx(times,tfx);
toobject(key,address,times,tfx,stopkey,name);
outresult(key,address,times,tfx,stopkey,name,str);
                     
}
function getkeywords(keys,titles){
var titl = 1;
var keyl = keylis.length;
var keyd = keydrop.length;
for(i=0;i<keyl;i++){
   keys[i] = keylis[i];
   }
for(i=0;i<keyd;i++){
   keys[i+keyl] = keydrop[i].childNodes[0].nodeValue;
   }
for(i=0;i<titl;i++){
   }

}
function timesn(times,address){
var k = 0;
for(i=0;i<address.length;i++)
   {
    for(j=0;j<address.length;j++)
     { 
      if(address[i] == address[j])
      { k = k+1;}
     }
    times.push(k);
    k = 0;
   }
}
function gettfx(times,tfx){
var k = Math.log(10);
var l;
var j;
var m;
var n;
for(i=0;i<times.length;i++)
{
   l = times[i]/1;
   j = Math.log(l);
   n = times[i]*j;
   tfx.push(n.toFixed(3));
}
}
function toobject(key,address,times,tfx,stopkey,name){
var gotdkey = new Array;
key["name"] = name;
key["address"] = address;
key["tfx"] = tfx;
key["stopkey"] = stopkey;
key["times"] = times;

}
function getkey(str,strkey,strl,keys,key,name,address,stopkey){
for(k=strl;k>0;k--){//控制循环次数

     label:
     for(j=6;j>0;j--)//通过最大关键字长度控制循环
     {
      var strkey = str.substr(k-j, j);
     
      //确定预检索字符串 strl-j 是位置 j是长度
      for(i=0;i<keys.length;i++)//通过关键字字库的数量确定循环次数
      {
       if(keys[i]==strkey){//如果现有关键字与字库匹配
        name.push(strkey);
        address.push(i);
        if(i>keylis.length){
        stopkey.push(false);
        }
        else{
        stopkey.push(true);
        }
        k-=j;
        k++;
        break label;
       }
      
      }
     } 
   }
}
function outresult(key,address,times,tfx,stopkey,name,str){
var outtags = document.getElementById("tags");
var indesc = "4"
var intfx = "0"
var outkeyarray = new Array();
var outkeyarray1 = new Array();
var outkeystoparray = new Array();
var outwordarray = new Array();
var outtfxarray = new Array();
var outtfxarray1 = new Array(); 
for(i=0;i<name.length;i++)
{
  
   if(key["stopkey"][i] == true)
   {outkeyarray.push(key["name"][i]);
   outtfxarray.push(key["tfx"][i]);}
   
}
for(i=0;i<outkeyarray.length;i++)
{
   for(j=outkeyarray.length;j>i;j--)
   {
    if(outkeyarray[i] == outkeyarray[j])
    {
     outkeyarray = outkeyarray.slice(0,j).concat(outkeyarray.slice(j+1,outkeyarray.length));
     outtfxarray = outtfxarray.slice(0,j).concat(outtfxarray.slice(j+1,outtfxarray.length));
    }
   }
}
//
for(i=0;i<name.length;i++)
{
  
   if(key["stopkey"][i] == false)
   {outkeystoparray.push(key["name"][i]);}
}
//
for(i=0;i<outkeyarray.length;i++)
{
  
   if(outtfxarray[i]>intfx)
   {outwordarray.push(outkeyarray[i]);
   outtfxarray1.push(outtfxarray[i])}
}
for(i=0;i<outwordarray.length;i++)
{ var k,l;
   for(j=i+1;j<outwordarray.length;j++)
   {
    if(outtfxarray1[i]<outtfxarray1[j])
    { k=outtfxarray1[i];outtfxarray1[i]=outtfxarray1[j];outtfxarray1[j]=k;
     l=outwordarray[i];outwordarray[i]=outwordarray[j];outwordarray[j]=l;
   
    }
   }

}
outwordarray = outwordarray.slice(0,indesc)
outtags.value = outwordarray.join(",");
}