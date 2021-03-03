    function unselectall(thisform){
        if(thisform.chkAll.checked){
            thisform.chkAll.checked = thisform.chkAll.checked&0;
        }   
    }
    function CheckAll(thisform){
        for (var i=0;i<thisform.elements.length;i++){
            var e = thisform.elements[i];
            if (e.Name != "chkAll"&&e.disabled!=true)
                e.checked = thisform.chkAll.checked;
        }
    }
	
	//ÑÕÉ«Ñ¡Ôñ
function Getcolor(img_val,input_val){
	var arr = showModalDialog("../images/selcolor.html?action=title", "", "dialogWidth:18.5em; dialogHeight:17.5em; status:0; help:0");
	if (arr != null){
		document.getElementById(input_val).value = arr;
		img_val.style.backgroundColor = arr;
		}
}

function myKeyDown()
{
    var    k=window.event.keyCode;   

    if ((k==46)||(k==8)||(k==189)||(k==109)||(k==190)||(k==110)|| (k>=48 && k<=57)||(k>=96 && k<=105)||(k>=37 && k<=40)) 
    {}
    else if(k==13){
         window.event.keyCode = 9;}
    else{
         window.event.returnValue = false;}
}