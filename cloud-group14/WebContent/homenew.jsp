<!DOCTYPE html>
<%@ page import="com.group14.*" %>
<html>
  <head>
    <title>Group14</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <!--  <link rel="stylesheet" href="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/bootstrapOne.css">
	<link rel="stylesheet" href="css/minimal.css">
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
        <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style> 
			*{margin:0;padding:0;} 
			.fa{width:720px;margin:0 auto;} 
			.top{margin:20px 0;} 
			.top input{width:25px;height:25px;border:1px solid #fff;border-radius:4px;background:rgba(146,168,209,0.2);} 
			.top .i1{background:#000000;} 
			.top .i2{background:#FF0000;} 
			.top .i3{background:#80FF00;} 
			.top .i4{background:#00FFFF;} 
			.top .i5{background:#808080;} 
			.top .i6{background:#FF8000;} 
			.top .i7{background:#408080;} 
			.top .i8{background:#8000FF;} 
			.top .i9{background:#CCCC00;} 
			#canvas{background:#eee;cursor:default;} 
			.font input{font-size:14px;} 
			.top .grea{background:rgb(146,168,209);} 
	</style> 
</head>
  <body class="modal-open" style="text-align:center;">
        <h1 class="text-center text-white" >Hand Writing Detection</h1>
		<div class="fa"> 
		<div class="top"> 
			 <div id="color" > 
				<input class="i1" type="button" value="" /> 
				<input class="i2" type="button" value="" /> 
				<input class="i3" type="button" value="" /> 
				<input class="i4" type="button" value="" /> 
				<input class="i5" type="button" value="" /> 
				<input class="i6" type="button" value="" /> 
				<input class="i7" type="button" value="" /> 
				<input class="i8" type="button" value="" /> 
				<input class="i9" type="button" value="" /> 
			</div> 
			<div class="font" id="font" style="display:inline;margin-right:50px;"> 
				<!--  <input type="button" value="thin" style="width:60px;" /> 
				<input type="button" value="middle" style="width:60px;" class="grea"/> -->
				<input type="button" value="thick" style="width:60px;"/> 
			</div>
			<div style="display:inline;">
				<input id="eraser" style="width:60px;" type="button" value="eraser" /> 
			</div> 
			<p></p>
			<div>
				<div style="display:inline;margin-right:70px;">
				<canvas id="canvas" width="320px" height="320px" ></canvas>
				</div>
				<div style="display:inline;">
					<textarea id="result" style="width:320px;height:320px;">
					</textarea>
				</div>
			</div> 
			<p></p>
			<input  id="clear" type="button" value="clear" style="width:60px;" /> 
			<input  id="imgurl" type="button" value="detect" style="width:60px;" /> 
		</div> 	
		</div> 
		
		<script language="javascript" type="text/javascript"> 
			(function(){ 
			var paint={ 
			init:function() 
			{ 
			this.load(); 
			}, 
			load:function() 
			{ 
			this.x=[];
			this.y=[];
			this.clickDrag=[]; 
			this.lock=false;
			this.isEraser=false; 
			this.storageColor="#000000"; 
			this.eraserRadius=15;
			this.color=["#000000","#FF0000","#80FF00","#00FFFF","#808080","#FF8000","#408080","#8000FF","#CCCC00"];
			this.fontWeight=[2,5,20]; 
			this.$=function(id){return typeof id=="string"?document.getElementById(id):id;}; 
			this.canvas=this.$("canvas"); 
			if (this.canvas.getContext) { 
			} else { 
			alert("your browser doesn't support canvas"); 
			return; 
			} 
			this.cxt=this.canvas.getContext('2d'); 
			this.cxt.lineJoin = "round";
			this.cxt.lineWidth = 20;
			this.iptClear=this.$("clear"); 
			this.imgurl=this.$("imgurl");
			this.w=this.canvas.width;
			this.h=this.canvas.height;
			this.touch =("createTouch" in document);
			this.StartEvent = this.touch ? "touchstart" : "mousedown";
			this.MoveEvent = this.touch ? "touchmove" : "mousemove"; 
			this.EndEvent = this.touch ? "touchend" : "mouseup"; 
			this.bind(); 
			}, 
			bind:function() 
			{ 
			var t=this; 
			this.iptClear.onclick=function() 
			{ 
			t.clear(); 
			}; 
			this.canvas['on'+t.StartEvent]=function(e) 
			{ 
			var touch=t.touch ? e.touches[0] : e; 
			var _x=touch.clientX - touch.target.offsetLeft;
			var _y=touch.clientY - touch.target.offsetTop;
			if(t.isEraser) 
			{ 
			
			t.resetEraser(_x,_y,touch); 
			}else 
			{ 
			t.movePoint(_x,_y);
			t.drawPoint();
			} 
			t.lock=true; 
			}; 
		
			this.canvas['on'+t.MoveEvent]=function(e) 
			{ 
			var touch=t.touch ? e.touches[0] : e; 
			if(t.lock)
			{ 
			var _x=touch.clientX - touch.target.offsetLeft;
			var _y=touch.clientY - touch.target.offsetTop;
			if(t.isEraser) 
			{ 
			
			t.resetEraser(_x,_y,touch); 
			
			} 
			else 
			{ 
			t.movePoint(_x,_y,true);
			t.drawPoint();
			} 
			} 
			}; 
			this.canvas['on'+t.EndEvent]=function(e) 
			{ 
			
			t.lock=false; 
			t.x=[]; 
			t.y=[]; 
			t.clickDrag=[]; 
			clearInterval(t.Timer); 
			t.Timer=null; 
			}; 
			this.changeColor(); 
			this.imgurl.onclick=function() 
			{ 
				t.getUrl(); 
			}; 
			
			this.$("eraser").onclick=function(e) 
			{ 
				t.isEraser=true; 
				t.$("error").style.color="red"; 
				t.$("error").innerHTML="You've used the eraser!"; 
				}; 
			}, 
			movePoint:function(x,y,dragging) 
			{ 
		
				this.x.push(x); 
				this.y.push(y); 
				this.clickDrag.push(y); 
			}, 
			drawPoint:function(x,y,radius) 
			{ 
			for(var i=0; i < this.x.length; i++)
			{ 
				this.cxt.beginPath();
				if(this.clickDrag[i] && i){
				this.cxt.moveTo(this.x[i-1], this.y[i-1]);
			}else{ 
				
			} 
			this.cxt.lineTo(this.x[i], this.y[i]);
			this.cxt.closePath();
			this.cxt.stroke();
			} 
			}, 
			clear:function() 
			{ 
			this.cxt.clearRect(0, 0, this.w, this.h);
			}, 
			redraw:function() 
			{ 
		
			this.cxt.restore(); 
			}, 
			preventDefault:function(e){ 
		
			var touch=this.touch ? e.touches[0] : e; 
			if(this.touch)touch.preventDefault(); 
			else window.event.returnValue = false; 
			}, 
			changeColor:function() 
			{ 
		
			var t=this,iptNum=this.$("color").getElementsByTagName("input"),fontIptNum=this.$("font").getElementsByTagName("input"); 
			for(var i=0,l=iptNum.length;i<l;i++) 
			{ 
			iptNum[i].index=i; 
			iptNum[i].onclick=function() 
			{ 
			t.cxt.save(); 
			t.cxt.strokeStyle = t.color[this.index]; 
			t.storageColor=t.color[this.index]; 
			t.$("error").style.color="#000"; 
			t.$("error").innerHTML="Please use eraser if there's error"; 
			t.cxt.strokeStyle = t.storageColor; 
			t.isEraser=false; 
			} 
			} 
			for(var i=0,l=fontIptNum.length;i<l;i++) 
			{ 
			t.cxt.save(); 
			fontIptNum[i].index=i; 
			fontIptNum[i].onclick=function() 
			{ 
				t.changeBackground(this.index); 
				t.cxt.lineWidth = t.fontWeight[this.index]; 
				t.$("error").style.color="#000"; 
				t.$("error").innerHTML="Please use eraser if there's error"; 
				t.isEraser=false; 
				t.cxt.strokeStyle = t.storageColor; 
			} 
			} 
			}, 
			changeBackground:function(num) 
			{ 
			
			var fontIptNum=this.$("font").getElementsByTagName("input"); 
			for(var j=0,m=fontIptNum.length;j<m;j++) 
			{ 
			fontIptNum[j].className=""; 
			if(j==num) fontIptNum[j].className="grea"; 
			} 
			}, 
			//save the image to sever
			getUrl:function() 
			{ 
				var image = this.canvas.toDataURL("image/png"); 
				
				$.ajax({
					type:"POST",
					url:'<%=request.getContextPath()%>/Detection.do',
					data:{picture:image},
					timeout:60000,
					success:function(data){
						document.getElementById("result").innerText = data;
					}
				});
				
			}, 
			resetEraser:function(_x,_y,touch) 
			{ 
			
				var t=this; 
				t.cxt.globalCompositeOperation = "destination-out"; 
				t.cxt.beginPath(); 
				t.cxt.arc(_x, _y, t.eraserRadius, 0, Math.PI * 2); 
				t.cxt.strokeStyle = "rgba(250,250,250,0)"; 
				t.cxt.fill(); 
				t.cxt.globalCompositeOperation = "source-over" 
			} 
			}; 
			paint.init(); 
			})(); 
		</script> 
    
 
  </body>
</html>