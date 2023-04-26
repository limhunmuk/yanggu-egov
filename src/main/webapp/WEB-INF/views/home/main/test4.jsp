<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 
<!DOCTYPE html PUBLIC "-// W3C // DTD XHTML Basic 1.1 // EN"
    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"> -->
<html>
<head>
<style>
#div1 {
  width: 100%;
  height: 600px;
  border: 1px solid #aaaaaa;  
} 
.drag{
	position:absolute;
	z-index: 100;
	cursor:hand; 
	width:100px;
	height:100px;
}

button{
	width:100px;
	height:100px;
	font-size: 1.5em;
}
.radio{
	width:50px;
	height:50px;
}
label{
	width:100px;
	height:100px;
	font-size: 2.5em;
}
p{
	font-size: 30px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.21/jquery-ui.min.js"></script>
<script type="text/javascript" src="http://cdn.rawgit.com/eligrey/FileSaver.js/5ed507ef8aa53d8ecfea96d96bc7214cd2476fd2/FileSaver.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script> 
<script src="//d3js.org/d3.v3.min.js"></script>
</head>
<body>

<div id="div1"></div><br>  
<br>
<canvas id="canvas" width="1920" height="1080" style="width:100%;height:600px;display:none"></canvas>
<div class="img_div">
	<div>	
		<p>이미지선택</p>
		<img name="drag_img_hue" src="/uploads/notice/20200515181939172_Mk7elT1.png" style="width:200px;height:200px;"> 
		<img name="drag_img_hue" src="/uploads/notice/20200515181939172_Mk7elT2.png" style="width:200px;height:200px;"> 
		<img name="drag_img_hue" src="/uploads/notice/20200515181939172_Mk7elT3.png" style="width:200px;height:200px;"> 
		<img name="drag_img_color" src="/uploads/notice/20200515181939172_Mk7elT4.svg" style="width:200px;height:200px;">
	</div>	
	
	<br>
	<p>이미지 색상조정</p>
	<button onclick="changeColor('20',1);">20</button>
	<button onclick="changeColor('50',1);">50</button>
	<button onclick="changeColor('90',1);">90</button>
	<button onclick="changeColor('150',1);">150</button>
	<p>컬러삽입</p>	
	<button onclick="changeColor('red',2);">red</button>
	<button onclick="changeColor('blue',2);">blue</button> 
	
	<br> 
	<input type="radio" name="radiokind" value="1" class="radio" id="radio1" checked/><label for="radio1">테두리 </label> 
	<input type="radio" name="radiokind" value="2" class="radio"  id="radio2"/><label  for="radio2">배경 </label>
	<br><br><br>
	<button id="save">저장</button>
	<button onclick="moveTag();">삭제</button> 
	
</div> 
<script>
var moveTagIndex = 0;
var selected_element = "";

$(function(){
	
	$("#save").click(function() { 
		var canvas = document.querySelector("canvas");
			context = canvas.getContext("2d");
		
		$("img[name='drag2']").each(function(index,item){
			var left = 0;
			var top = 0;
			
			if(item.style.left != ""){
				left = parseInt(item.style.left.substring(0,item.style.left.length-2));
			}
			if(item.style.top != ""){
				top = parseInt(item.style.top.substring(0,item.style.top.length-2));
			}
			
			
			context.drawImage(item, left, top, 200, 200);
				
			
		});	
	
		var svgs = d3.select("#div1").selectAll("svg"); 
		var doctype ='<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">';	
		
			if(svgs[0].length > 0){
				svgs[0].forEach(function(item,index){
					var left = 0;
					var top = 0;
					
					if(item.style.left != ""){
						left = parseInt(item.style.left.substring(0,item.style.left.length-2));
					}
					if(item.style.top != ""){
						top = parseInt(item.style.top.substring(0,item.style.top.length-2));
					}
					
					var source = (new XMLSerializer()).serializeToString(item);
					
					var blob =new Blob([ doctype + source], { type:'image/svg+xml' });
					var URL = window.URL || window.webkitURL;
					
					var url = URL.createObjectURL(blob);
						
					var image =new Image;
						image.src = url;
						image.onload = function(){
							context.drawImage(image, left, top, 200, 200);
							
							var doc = new jsPDF('p', 'mm', 'a4');
						  	var imgData = canvas.toDataURL('image/png');
							var position = 0;
							doc.addImage(imgData, 'PNG', 0, 0);
							doc.save('sample-file.pdf');
						}
						
				});
			}else{
				var doc = new jsPDF('p', 'mm', 'a4');
			  	var imgData = canvas.toDataURL('image/png');
				doc.addImage(imgData, 'PNG', 0, 0);
				doc.save('sample-file.pdf');
			}
    });
	
	
	$('img[name="drag_img_color"]').each(function() {
        var $img = $(this);
        var imgURL = $img.attr('src');
        var attributes = $img.prop("attributes");
		
        $.ajax({
        	type:"get",
        	url:imgURL,
        	async:false,
        	dataType:"xml"
        }).done(function(data){
        	var $svg = jQuery(data).find('svg');
        	$svg = $svg.removeAttr('xmlns:a');
			
	        $.each(attributes, function() {
	            $svg.attr(this.name, this.value);
	        });
	
	        $img.replaceWith($svg); 
        });
    });
	
	var dragMain = document.getElementById('div1'); 
	var assistance_hue_dragNames = document.getElementsByName('drag_img_hue'); //이미지 색상 조정용
	var assistance_color_dragNames = document.getElementsByName('drag_img_color'); //이미지 컬러 삽입용
	var assistance_dragNames = [];

		assistance_hue_dragNames.forEach(function(element){
			assistance_dragNames.push(element);
	    });
		assistance_color_dragNames.forEach(function(element){
			assistance_dragNames.push(element);
	    });
		
		//모든 이미지에 touchEvent 달아주기
		assistance_dragNames.forEach(function(element,index){
			if(element.addEventListener){
				element.addEventListener("touchend", function(event){assistance_dragNames_touchend(event,index);},false);
			}else{
				element.attachEvent("touchend", function(event){assistance_dragNames_touchend(event,index);}); //IE
			}
	    });
	
		
	function assistance_dragNames_touchend(event,index){
		event.preventDefault(); 
		var id = "moveTag"+moveTagIndex; 
		var moveTag = assistance_dragNames[index].cloneNode(true);  
			moveTag.setAttribute("name","drag2");
			moveTag.setAttribute("id",id);
			moveTag.classList.add("drag");
			
			if(moveTag.addEventListener){
				moveTag.addEventListener("touchmove", function(event){touchmove(event, id);},false);
			}else{
				moveTag.attachEvent("touchmove", function(event){touchmove(event, id);});
			}
			
			if(moveTag.addEventListener){
				moveTag.addEventListener("touchend", function(event){touchend(event, id);},false);
			}else{
				moveTag.attachEvent("touchend", function(event){touchend(event, id);});
			}
			 
			dragMain.appendChild(moveTag);
			selected_element =  moveTag; 
			moveTagIndex++;
	}

	function touchmove(event,id) {
		event.preventDefault();  
		
		var x = event.touches[0].clientX;
		var y = event.touches[0].clientY;
	   
	  	var max_x = dragMain.offsetWidth; 
	   	var max_y = dragMain.offsetHeight;

	   	var element = document.getElementById(id);
	   	if(x <= max_x - parseInt($(element).css("width").substring(0,$(element).css("width").length-2))){
	   		$(element).css("left",x); 
	   	}
	   
	   	if(y <= max_y - parseInt($(element).css("height").substring(0,$(element).css("width").length-2))){
	       	$(element).css("top",y);
	   	}
	}

	function touchend(event,id) {
		event.preventDefault(); 
		selected_element = document.getElementById(id);
	}
});


function changeColor(corlor,kind){
	if(kind == 1){
		$(selected_element).css({"-webkit-filter":"hue-rotate("+parseInt(corlor)+"deg)"});
	}else{
		if($("input[name='radiokind']:checked").val() == "1"){
			$(selected_element).children("g").children("g").children("path").css("fill",corlor);
		}else{
			$(selected_element).children("g").children("path").css("fill",corlor);
		}
		
	}
}

function moveTag(){
	if(selected_element != ""){
		$(selected_element).remove();
		selected_element = "";
	}
}
</script>
</body>
</html>

