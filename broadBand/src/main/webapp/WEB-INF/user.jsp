<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,pojo.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园宽带用户管理</title>
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
	#head form button{
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
		padding-left:50px;
		padding-right:50px;
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
		width: 160px;
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
		
		.front {
			background-color: white;
			z-index:1002;
			width: 360px;
			height: 490px;
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

.front input {
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
.front button {
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
.front p {
	font-size: 14px;
	color: #777;
}

.front a {
	font-size: 16px;
	color: #3581b9;
	text-decoration: none;
}
.front div {
	position: relative;
	right: -225px;
}
.front h2 {
	font-size: 28px;
	font-weight: 500;
	padding-bottom: 5px;
	text-align: center;
	color: #333;
}
.front div{
	position:absolute;
	right:10px;
	top:0px;
	font-size: 20px;
}
.front div:hover {
	cursor: pointer;
}

.front select{
	position:relative;
	width: 200px;
	height: 40px;
	right: -100px;
}
.recharge{
	height: 600px;
}

</style>
<script src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="${pageContext.request.contextPath }/js/axios.min.js"></script>


<body>
	<jsp:include page="left.jsp"/>
	<div id="right">
	<!-- 搜索框 -->
		<div id="head">
			<form onsubmit="return false">
				<input name="search" placeholder="请输入用户信息" v-model="search">
				<button @click="getUser">查找</button>
			</form>
			<button id="addbutton"  @click="open1(0);">办理宽带</button>
		</div>
		<!-- 表格 -->
		<div id="main">
			<table cellspacing="0" border="1">
				<tr>
					<th style="width: 70px;">序号</th>
					<th>学号</th>
					<th style="width: 100px;">姓名</th>
					<th style="width: 100px;">宿舍号</th>
					<th>开户日期</th>
					<th>到期日期</th>
					<th>类型</th>
					<th>操作</th>
				</tr>
				<tr v-for="(user,index) in users">
					<td>{{index+1}}</td>
					
					<td>{{user.userid}} </td>
					
					<td>{{user.username}} </td>
					
					<td>{{user.dorm}} </td>
					
					<td>{{user.opendate1}} </td>
					
					<td>{{user.endingdate1}} </td>
					
					
					<td v-if="user.type==1">按月缴费</td>
					<td v-if="user.type!=1">按年缴费</td>
					
					<td>
						<button @click="rechargeMsg(user.userid)">续费</button>
						<button style="background-color: blue;color: white;" @click="alterMsg(user.userid)">修改</button>
						<button style="background-color: red;color: white;" @click="del(user.userid)">删除</button>
						
					</td>
				</tr>
			</table>
		</div>
		
		<div id="backg"></div>
		<!-- 办理宽带 -->
		<div class="front">
			<h2 id="frontH2">办 理 宽 带</h2>
			<div @click="close1(0)">X</div>
			<form name="addForm" onsubmit="return false">
				<input type="text" name="userid" placeholder="请输入学号" v-model="addForm.userid">
				<input type="text" name="username" placeholder="请输入姓名" v-model="addForm.username">
				<input type="text" name="dorm" placeholder="请输入宿舍号" v-model="addForm.dorm">
				<select name="type" v-model="addForm.selectType">
					<option value="1">按月缴费</option>
					<option value="2">按年缴费</option>
				</select>
				<button @click="addcheck">添加</button>
			</form>
		</div>
		
		<!-- 修改宽带 -->
		<div class="front">
			<h2 id="frontH2">修 改 信 息</h2>
			<div @click="close1(1)">X</div>
			<form name="alterForm" onsubmit="return false">
				学号：<input readonly="readonly" type="text" name="userid" placeholder="请输入学号" v-model="alterForm.userid">
				姓名：<input type="text" name="username" placeholder="请输入姓名" v-model="alterForm.username">
				宿舍号：<input type="text" name="dorm" placeholder="请输入宿舍号" v-model="alterForm.dorm">
				类型：<select name="type" id="selectType" v-model="alterForm.selectType">
					<option value="1">按月缴费</option>
					<option value="2">按年缴费</option>
				</select>
				<button @click="altercheck">修改</button>
			</form>
		</div>
		
		<!-- 续费 -->
		<div class="front recharge">
			<h2 id="frontH2">续 费 单</h2>
			<div @click="close1(2)">X</div>
			<form>
				学号：{{rechargeForm.user.userid}}<br/><br/>
				姓名：{{rechargeForm.user.username}}<br/><br/>
				宿舍号：{{rechargeForm.user.dorm}}<br/><br/>
				类型：
				<span v-if="rechargeForm.user.type==1">
					按月缴费
				</span>
				<span v-if="rechargeForm.user.type==2">
					按年缴费
				</span><br/><br/>
				
				起始日期：{{rechargeForm.startdate1}}<br/><br/>
				到期日期：{{rechargeForm.user.endingdate1}}<br/><br/>
				
				经手人：{{rechargeForm.adminname}}<br/><br/>
				
				金额：<span style="color: red;font-size: 30px;">￥{{rechargeForm.cost}}<br/><br/></span>
			</form>
			<button @click="rechargecheck()">续费</button>
		</div>
	</div>

</body>

<script>
	new Vue({
		el:"#right",
		data:{
			users:[],
			search:"",
			addForm:{
				userid:"",
				username:"",
				dorm:"",
				selectType:"1"
			},
			alterForm:{
				userid:"",
				username:"",
				dorm:"",
				selectType:""
			},
			rechargeForm:{
				startdate:"",
				adminname:"",
				cost:"",
				startdate1:"",
				user:{
					userid:"",
					username:"",
					dorm:"",
					type:"",
					endingdate:"",
					endingdate1:""
				}
			}
		},
		methods:{
			getUser(){
				var _this =this;
				axios({
					url:'getuser',
					method:'get',
					params:{
						search:_this.search
					}
				}).then(function(resp){
					_this.users=resp.data;
					_this.users.forEach(function(user,index){
						user.opendate1=_this.formatStr(user.opendate);
						user.endingdate1=_this.formatStr(user.endingdate);
					})
				})
			},
			//日期转换
			formatStr:function(originVal) {
			      var time = new Date(originVal);
			      var y = time.getFullYear();
			      var m = time.getMonth()+1;
			      var d = time.getDate();
			      return y + '-' + m + '-' +d;
		   	},
		   	//添加用户
		   	addcheck(){
		   		if(this.addForm.userid==""){
					alert("请输入学号");
					return;
				}else if(this.addForm.username==""){
					alert("请输入姓名")
					return;
				}else if(this.addForm.dorm==""){
					alert("请输入宿舍号")
					return;
				}
				if(!confirm("确定办理吗?")){
					return;
				}
				
				var _this =this;
				axios({
					url:'addUser',
					method:'post',
					data:{
						userid:_this.addForm.userid,
						username:_this.addForm.username,
						dorm:_this.addForm.dorm,
						type:_this.addForm.selectType
					}
				}).then(function(resp){
					_this.addForm={
						userid:"",
						username:"",
						dorm:"",
						selectType:"1"
					};
					_this.getUser();
					_this.close1(0);
				})
				
		   	},
		   	alterMsg(id){
			   	//修改数据获取
			   	var _this= this;
		   		axios({
					url:'selectUser',
					method:'get',
					params:{
						userid:id
					}
				}).then(function(resp){
					_this.alterForm={
						userid:resp.data.userid,
						username:resp.data.username,
						dorm:resp.data.dorm,
						selectType:resp.data.type
					}
				})
		   		this.open1(1);
			},
			//修改提交检查
			altercheck(){
				if(this.alterForm.username==""){
					alert("请输入姓名")
					return;
				}else if(this.alterForm.dorm==""){
					alert("请输入宿舍号")
					return;
				}
				if(!confirm("确定修改吗?")){
					return;
				}
				var _this =this;
				axios({
					url:'alterUser',
					method:'post',
					data:{
						userid:_this.alterForm.userid,
						username:_this.alterForm.username,
						dorm:_this.alterForm.dorm,
						type:_this.alterForm.selectType
					}
				}).then(function(resp){
					alert(resp.data);
					_this.close1(1);
					_this.getUser();
				})
				
			},
			//删除
			del(id){
				if(confirm("你确定要删除吗?")){
					var _this =this;
					axios({
						url:'delUser',
						method:'get',
						params:{
							userid:id,
						}
					}).then(function(resp){
						alert(resp.data);
						_this.getUser();
					})
				}
			},
			//续费数据获取
			rechargeMsg(id){
				var _this = this;
				axios({
					url:'selectOrder',
					method:'get',
					params:{
						userid:id,
					}
				}).then(function(resp){
					_this.rechargeForm=resp.data;
					_this.rechargeForm.startdate1=_this.formatStr(_this.rechargeForm.startdate);
					_this.rechargeForm.user.endingdate1=_this.formatStr(_this.rechargeForm.user.endingdate);
					
				});
				this.open1(2);
			},
			//续费提交
			rechargecheck(){
				if(confirm("确定要续费吗?")){
					var _this =this;
					axios({
						url:'rechargeCommit',
						method:'post',
						data:{
							
							startdate:_this.rechargeForm.startdate,
							adminname:_this.rechargeForm.adminname,
							cost:_this.rechargeForm.cost,
							userid:_this.rechargeForm.user.userid,
							user:{
								userid:_this.rechargeForm.user.userid,
								username:_this.rechargeForm.user.username,
								dorm:_this.rechargeForm.user.dorm,
								type:_this.rechargeForm.user.type,
								endingdate:_this.rechargeForm.user.endingdate
							}
						}
					}).then(function(resp){
						alert(resp.data);
						_this.close1(2);
						_this.getUser();
					})
				}
			},
			//弹出弹窗
			open1(index){
				document.getElementsByClassName("front")[index].style.display="inline-block";
				document.getElementById("backg").style.display="inline-block";
			},
			//关闭弹窗
			close1(index) {
				document.getElementsByClassName("front")[index].style.display="none";
				document.getElementById("backg").style.display="none";
			}
		},
		created(){
			this.getUser();
			document.getElementById("userleft").style.background="#339999";
		}
	})

</script>

</html>