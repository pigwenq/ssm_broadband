<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,pojo.Admin" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园宽带登录管理</title>
</head>
<style>
	#right{
		position:relative;
		width:100%;
		left:160px;
		top:52px;
		height: 100%;
		padding: 10px;
	}
	
	#head{
		background-color: #DCDCDC;
		position: relative;
		height: 100px;
		border-left:7px solid #339999; 
	}
	#head input{
		position:relative;
		top:30px;
		left:300px;
		width:180px;
		height: 30px;
		outline: none;
	}
	#head div button{
		left:305px;
		top:30px;
		width:60px;
	}
	#head button{
		position: relative;
		height: 35px;
		
		background-color: #339999;
		text-align: center;
		border: none;
		color: white;
		font-size: 16px;
	}
	#addbutton{
		left:705px;
		width: 140px;
		top:-5px;
	}
	#head button:hover {
		cursor: pointer;
	}
	#main{
		background-color: #DCDCDC;
		position: relative;
		height: auto;
		min-height:480px;
		padding: 10px;
		margin-top: 10px;
	}
	#main table{
		position: relative;
		margin:0 auto; 
		right: 100px;
		padding-left:100px;
		padding-right:100px;
		padding-top:20px;
		padding-bottom:20px;
		background-color: #F5F5F5;
		
	}
	tr{
		height: 40px;
		text-align: center;
	}
tr:hover{
		background-color: #DCDCDC;
	}
	th{
		border:none;
		border:1px solid gray;
		width: 230px;
		margin: 0px;
		height: 60px;
	}
	td{
		height: 80px;
	}
	
	#backg{
		width: 100%;
		height: 100%;
		background-color: red;
		position: fixed;
		margin: 0 auto;	
		top: 0%;	
		left: 0%;
		background-color: black;
		z-index:1001;
	 	display:none;
		opacity:.60;
		}
		
		#front {
			background-color: white;
			z-index:1002;
			width: 360px;
			height: 450px;
			padding: 30px 30px;
			background: #FFF;
			border-radius: 8px;
			margin: auto;
			position: fixed;
			top: 0;
			left: 0;
			bottom: 0;
			right: 0;
			display: none;
		}

#front input {
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
#front button {
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
#front p {
	font-size: 14px;
	color: #777;
}
#front a {
	font-size: 16px;
	color: #3581b9;
	text-decoration: none;
}
#front div {
	position: relative;
	right: -225px;
}
#front h2 {
	font-size: 28px;
	font-weight: 500;
	padding-bottom: 5px;
	text-align: center;
	color: #333;
}
#front div{
	position:absolute;
	right:10px;
	top:0px;
	font-size: 20px;
}
#front div:hover {
	cursor: pointer;
}

</style>

<script src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="${pageContext.request.contextPath }/js/axios.min.js"></script>
<body>
	<jsp:include page="left.jsp"/>
	<div id="right">
	<!-- 搜索框 -->
		<div id="head">
			<div>
				<input name="name" placeholder="请输入登录账号" value="${name}" v-model="search">
				<button @click="getLogin">查找</button>
			</div>
			<button id="addbutton"  @click="open1()">添加登录账号</button>
		</div>
		<!-- 表格 -->
		<div id="main">
			<table cellspacing="0" border="1">
			<tr>
				<th>序号</th>
				<th>登录账号</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
			<tr v-for="(admin,index) in admins">
				<td>{{index+1}}</td>
				<td>{{admin.name}} </td>
				<td v-if="admin.power==1">正常</td>
				<td v-if="admin.power==0">停用</td>
				<td v-if="admin.power==1">
					<button style="color: white;background-color: red;" @click="alterPower(admin.name)">禁用</button>
				</td>
				<td v-if="admin.power==0">
					<button style="color: white;background-color: blue;" @click="alterPower(admin.name)">启用</button>
				</td>
			</tr>
		</table>
			
		</div>
		<!-- 悬浮表单，点击展示 -->
		<div id="backg">
			
		</div>
		<div id="front">
			<h2>新增登录人</h2>
			<div @click="close1()">X</div>
			<form onsubmit="return false">
				<input v-model="adminForm.adminname" type="text" name="adminname" placeholder="请输入账号">
				<input v-model="adminForm.password"  type="password" name="password" placeholder="请输入密码">
				<input v-model="adminForm.again"  type="password" name="again" placeholder="确认密码">
				<button @click="check">添加</button>
			</form>
		</div>
	</div>
	
</body>

<script>
	new Vue({
		el:"#right",
		data:{
			admins:[],
			search:"",
			adminForm:{
				adminname:"",
				password:"",
				again:""
			}
		},
		methods:{
			//获取信息
			getLogin:function(){
				var _this=this;
				axios({
					url:'getLogin',
					method:'get',
					params:{
						name:_this.search
					}
				}).then(function(resp){
					_this.admins=resp.data;
				})
			},
			//修改状态
			alterPower:function(name){
				var _this=this;
				axios({
					url:'alterPower',
					method:'get',
					params:{
						name:name
					}
				}).then(function(resp){
					if(resp.data==true){
						
						_this.getLogin();
						alert("修改成功");
					}else{
						alert("修改失败");
					}
				})
			},
			//打开表单
			open1:function(){
				document.getElementById("front").style.display="inline-block";
				document.getElementById("backg").style.display="inline-block";
			},
			//关闭表单
			close1:function() {
				document.getElementById("front").style.display="none";
				document.getElementById("backg").style.display="none";
			},
			//提交表单
			check:function(){
				if(this.adminForm.adminname==""){
					alert("请输入账号")
					return;
				}else if(this.adminForm.password==""){
					alert("请输入密码")
					return;
				}else if(this.adminForm.again==""){
					alert("请确认密码")
					return;
				}else if(this.adminForm.password!=this.adminForm.again){
					alert("密码不一致")
					this.adminForm.again=""
					return;
				}else{
					var _this=this;
					axios({
						url:'addAdmin',
						method:'post',
						data:{
							name:this.adminForm.adminname,
							password:this.adminForm.password
						}
					}).then(function(resp){
						alert(resp.data);
						_this.adminForm.adminname="";
						_this.adminForm.password="";
						_this.adminForm.again="";
						_this.getLogin();
					})
				}
			}
		},
		mounted(){
			document.getElementById("loginleft").style.background="#339999";
			this.getLogin();
		}
	})

</script>
</html>

