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
	height: 450px;
	padding: 30px 30px;
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
	font-size: 16px;
	color: #3581b9;
	text-decoration: none;
}
.tpt-login div {
	position: relative;
	right: -225px;
}
</style>
<body>
	<div class="tpt-login" id="login">
	<h2>管 理 员 注  册</h2>
		<form onsubmit="return false">
			<input v-model="loginname" type="text" name="name" placeholder="请输入账号">
			<input v-model="password" type="password" name="password" placeholder="请输入密码">
			<input v-model="again" type="password" name="again" placeholder="确认密码">
			<button @click="check">注册</button>
		</form>
		<br/>
		<br/>
		<div><span>已有账户?</span><a href="${pageContext.request.contextPath}/login">立即登陆</a></div>
	</div>
</body>

<script src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="${pageContext.request.contextPath }/js/axios.min.js"></script>
<script>

	new Vue({
		el:"#login",
		data:{
			loginname:"",
			password:"",
			again:""
		},
		methods:{
			check(){
				if(this.loginname==""){
					alert("请输入账号")
					return;
				}else if(this.password==""){
					alert("请输入密码")
					return;
				}else if(this.again==""){
					alert("请确认密码")
					return;
				}else if(this.password!=this.again){
					alert("密码不一致")
					this.again=""
					return;
				}else{
					var _this=this;
					axios({
						url:'register',
						method:'post',
						data:{
							name:_this.loginname,
							password:_this.password
						}
					}).then(function(resp){
						alert(resp.data);
						if(resp.data=="注册成功"){
							window.location.href="login";
							return;
						}
						_this.password="";
					})
				}
			}
		}
	})
</script>
<script>
	function check(){
		if(document.login.name.value==""){
			alert("请输入账号")
			return false;
		}else if(document.login.password.value==""){
			alert("请输入密码")
			return false;
		}else if(document.login.again.value==""){
			alert("请确认密码")
			return false;
		}else if(document.login.again.value!=document.login.password.value){
			alert("密码不一致")
			document.login.again.value=""
			return false;
		}
		return true;
	}
	
	function load() {
		if("${msg}"!=""){
			alert("${msg}")
		}
	}
</script>
</html>