<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园宽带管理后台系统</title>
</head>
<style>
	#leftmain{
		position: fixed;
		width: 160px;
		height:100%;
		background: #444444;
		top:60px;
	}
	#tagul{
		list-style: none;
		width: 160px;
	}
	#tagul li{
		position:relative;
		left:-40px;
		border-bottom:1px solid white;
		width: 160px;
		color: white;
		text-align: center;
		height: 70px;
		font-size: 16px;
		
	}
	#tagul li:hover{
		font-size: 17px;
		cursor: pointer;
	}
	#tagul li span{
		position:absolute;
		color: white;
		bottom: 10px;
		font-size: 16px;
		left:10px;
	}
	#tagul img{
		position: absolute;
		width:140px;
		height:85px;
		top:10px;
		left:10px;
		border-radius: 50% 50% 50% 50%;
	}
	#tagul a{
	color: white;
	text-decoration: none;
	}
	#lefthead{
		background-color: #333333;
		height: 60px;
		width: 100%;
		position: fixed;
		z-index: 100;
		top: 0px;
	}
	#lefthead span{
		position:absolute;
		color: white;
		
	}
	#span1{
		font-size: 19px;
		top:18px;
		left:50px
	}
	#span2{
		font-size: 16px;
		top:18px;
		right:100px;
	}
	#span2 a{
		color: white;
		position: relative;
		text-decoration: none;
	}
	#scrolltext{
		width:280px;
		height:28px;
		color: white;
		font-size: 20px;
		scrolldelay:4000;
		border-radius:5px;
		background-color: #339999; 
		line-height: 28px;
		position: absolute;
		top: 50%;
		right: 10%;
		opacity:0.8;
		transform: translate(-50%,-50%);
	}
</style>
<body>
	<div id="left">
		<div id="lefthead">
			<span id="span1">校园宽带管理信息系统</span>
			<%if(session.getAttribute("tip")!=null&&session.getAttribute("tip")!="") {%>
			<div><marquee id="scrolltext" scrollamount=5>${tip }</marquee></div>
			<%} %>
			<span id="span2"><a href="logout">退出</a></span>
		</div>
		<div id="leftmain">
			<ul id="tagul">
				<li style="height: 150px;">
					<img src="${pageContext.request.contextPath}/img/logo.jpg">
					<br/>
					<span>你好!${loginName},欢迎登录</span><br/>
						
				</li>
				<!-- 用户管理权限 -->
				<%if((int)session.getAttribute("type")==1) {%>
					<li id="loginleft" style="line-height: 70px;" onclick="window.location.href='loginManage'"><a>登录管理</a></li>
				<%}%>
				<li id="userleft" style="line-height: 70px;"onclick="window.location.href='user'"><a>客户管理</a></li>
				<li id="orderleft" style="line-height: 70px;"onclick="window.location.href='order'"><a>订单管理</a></li>
			</ul>
		</div>
	</div>
</body>
</html>