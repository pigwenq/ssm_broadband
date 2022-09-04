<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园宽带订单管理</title>
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
		#statistics{
			position:relative;
			background-color: #339999;
			width: 200px;
			height: 80px;
			top:-30px;
			left:1100px;
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
				<input name="search" placeholder="请输入信息" v-model="search">
				
				<input name="startdate" type="date" v-model="startdate">
				<input name="endingdate" type="date" v-model="endingdate">
				
				
				<button @click="searchGo">查找</button>
			</div>
			<div id="statistics">
				
				<span style="color: white;font-size: 18px">总订单数：{{sum}}</span><br/>
				<br/>
				<span style="color: white;font-size: 18px">总金额：￥{{money}}</span>
			</div>
		</div>
		<!-- 表格 -->
		<div id="main">
			<table cellspacing="0" border="1">
				<tr>
					<th style="width: 50px;">序号</th>
					<th style="width: 200px;">订单号</th>
					<th>学号</th>
					<th style="width: 100px;">姓名</th>
					<th style="width: 70px;">宿舍号</th>
					<th style="width: 100px;">缴费日期</th>
					<th style="width: 100px;">费用</th>
					<th style="width: 100px;">备注</th>
					<th style="width: 100px;">经手人</th>
					<th style="width: 100px;">操作</th>
				</tr>
				
				
				<tr v-for="(order,index) in orders">
					<td>{{index+1}}</td>
					 <td>{{order.id}}</td>
					 <td>{{order.userid}}</td>
					 <td>{{order.user.username}}</td>
					 <td>{{order.user.dorm}}</td>
					 <td>{{order.startdate}}</td>
					 <td>{{order.cost}}</td>
					 <td>{{order.tip}}</td>
					 <td>{{order.adminname}}</td>
					<td><button style="background-color: red;color: white;"
							@click="delOrder(order.id)">删除</button></td>
				</tr>
			</table>
			
		</div>
	</div>
</body>

<script>
	new Vue({
		el:"#right",
		data:{
			orders:[],
			startdate:'',
			endingdate:'',
			search:'',
			sum:0,
			money:0
		},
		methods:{
			//获取数据
			getOrders:function(){
				var _this =this;
				axios({
					url:'order',
					method:'post',
					data:{
						username:_this.search,
						opendate:_this.startdate,
						endingdate:_this.endingdate
					}
				}).then(function(resp){
					_this.orders=resp.data;
					_this.money=0;
					(_this.orders).forEach(function(order,index){
						order.startdate=_this.formatStr(order.startdate);
						_this.money+=order.cost;
					})
					_this.sum=_this.orders.length;
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
		   searchGo:function(){
			   if(this.startdate>this.endingdate){
				   alert("开始时间大于结束时间");
			   }else{
				   this.getOrders();
			   }
				
			},
			delOrder:function(id){
				var _this =this;
				axios({
					url:'delOrder',
					method:'get',
					params:{
						id:id
					}
				}).then(function(resp){
					if(resp.data==true){
						alert("删除成功");
						_this.getOrders();
					}else{
						alert("删除失败");
					}
					
				})
			}
		},
			
		created(){
			document.getElementById("orderleft").style.background="#339999";
			this.getOrders();
		}
	})
</script>

</html>