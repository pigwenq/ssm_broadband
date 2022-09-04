<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园宽带管理后台系统</title>
</head>
<style>
	body {
	background-color:#DCDCDC;
 background: url("${pageContext.request.contextPath}/img/main.jpg");
 background-size:100%;
 background-repeat:no-repeat ;
}
.tpt-login {
	width: 360px;
	height: 360px;
	padding: 20px 30px;
	background: #FFF;
	border-radius: 8px;
	margin: auto;
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
}
.tpt-login h2 {
	font-size: 28px;
	font-weight: 500;
	padding-bottom: 5px;
	text-align: center;
	color: #333;
}
.tpt-login input {
	width: 340px;
	padding: 0 10px;
	margin-bottom: 20px;
	height: 55px;
	line-height: 55px;
	border: 0;
	background: #f5f5f5;
	font-size: 16px;
	color: #666;
}
.tpt-login button {
	display: inline-block;
	height: 50px;
	line-height: 50px;
	width: 360px;
	background: #1e9fff;
	color: #fff;
	font-size: 16px;
	margin-top: 20px;
	border: none;
	border-radius: 2px;
	cursor: pointer;
}
.tpt-login p {
	font-size: 14px;
	color: #777;
}
.tpt-login a {
	position:absolute;
	font-size: 15px;
	color: #3581b9;
	right:30px;
	text-decoration: none;
}
.tpt-login span {
	position: relative;
	display: inline-block;
	width: 7px;
	height: 7px;
	border-radius: 100%;
	border: 1px solid #ff5722;
	padding: 4px;
	top: 4px;
	margin-right: 6px;
}
</style>
<script src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="${pageContext.request.contextPath }/js/axios.min.js"></script>
<body>
	<div class="tpt-login" id="login">
		<h2>登  陆</h2>
		<form onsubmit="return false">
			<input v-model="loginname" type="text" name="name" placeholder="请输入账号">
			<input v-model="password" type="password" name="password" placeholder="请输入密码">
			<button @click="check">立即登录</button>
		</form>
		<br/>
		<a href="${pageContext.request.contextPath}/register">立即注册</a>
	</div>
</body>


<script>
	new Vue({
		el:"#login",
		data:{
			loginname:"",
			password:""
		},
		methods:{
			check(){
				if(this.loginname==""){
					alert("请输入账号")
					return;
				}else if(this.password==""){
					alert("请输入密码")
					return;
				}else{
					var _this=this;
					axios({
						url:'login',
						method:'post',
						data:{
							name:_this.loginname,
							password:_this.password
						}
					}).then(function(resp){
						if(resp.data==true){
							window.location.href="main";
						}
						alert(resp.data);
						_this.password="";
					})
				}
			}
		}
	})
</script>
</html>