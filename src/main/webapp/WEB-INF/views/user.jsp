<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
   <title>유저관리</title>
</head>
<body>
<jsp:include page="../views/menu/top.jsp"></jsp:include>
<P>  유저 관리 </P>
<div  class="table-responsive">
	<table class="table">
		<tr>
			<td class ="search" style="padding-top: 1%;">구분 No</td>
			<td><input type="text" id="num" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">창고</td>
			<td><input type="text" id="garbage_name" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">부품코드</td>
			<td><input type="text" id="product_code" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">부품명</td>
			<td><input type="text" id="product_name" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">제조일</td>
			<td><input type="text" id="inv_date" class="form-control datepicker1" placeholder="" aria-describedby="sizing-addon3"></td>
			<td class ="search" style="padding-top: 1%;">비고</td>
			<td><input type="text" id="etc" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">등록일</td>
			<td><input type="text" id="reg_date" class="form-control datepicker2" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td><input type="button" value="조회" id ="search" class="btn btn-default" onClick ="search();"></td>
			<!-- rowspan="2" -->
		</tr>
		
	</table>
</div>



<button type="button" class="btn btn-default navbar-right center-block" onClick="getSelectedRow();">삭제</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="addRow();">추가</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="saveRow();">저장</button>


<div id="myGrid" style="width:100%;height:calc(100vh - 300px);"></div>

<script>
// http://6pac.github.io/SlickGrid/examples/example4-model.html
//console.log(${test});
$.datepicker.setDefaults({
        dateFormat: 'yy/mm/dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년',
    });
     $( ".datepicker1" ).datepicker();
     $( ".datepicker2" ).datepicker();
     
var grid;
var data = [];
var updatelist = [];
var accountList = [
	{
		product_code : "경기도",
		product_location : "성남시 중원구",
		product_name : "글로벌자동차유리(주)",
		purchase_cost : "글로벌자동차유리(주)",
		work_cost : "최고관리자"
	},
	{
		product_code : "서울시",
		product_location : "강남구",
		product_name : "자동차유리(주)",
		purchase_cost : "자동차유리(주)",
		work_cost : "최고관리자"
	},
];

var columns = [
 	 {id : "num", name :"No", field : "num" ,width : 0, minWidth: 0, maxWidth: 0, cssClass: "reallyHidden", headerCssClass: "reallyHidden"  },
   {id : "garbage_name", name :"창고", field : "garbage_name" , editor: Slick.Editors.Text ,width : 100 },
   {id : "product_code", name :"부품코드", field : "product_code", editor: Slick.Editors.Text ,width : 120 },
   {id : "product_name", name :"부품명", field : "product_name", editor: Slick.Editors.Text ,width : 180 },
   {id : "product_count", name :"수량", field : "product_count", editor: Slick.Editors.Text ,width : 180 },
   {id : "inv_date", name :"조사일", field : "inv_date", editor: Slick.Editors.Date ,width : 150},
   {id : "etc", name :"비고", field : "etc", editor: Slick.Editors.Text ,width : 200},
   {id : "reg_date", name :"등록일", field : "reg_date" ,width : 150},
 
];
//초기화
function getList(checkBox) {
		
	  data = [];
	  // 옵션
	  var options = {
			   editable: true,
			   enableCellNavigation: true,
			   asyncEditorLoading: true,
			   forceFitColumns: false,
			   headerRowHeight: 80
	        //enableColumnReorder : false
	  };
	  var obj = new Object();
	  obj.num  = $("#num").val();
	  obj.garbage_name  = $("#garbage_name").val();
	  obj.product_code  = $("#product_code").val();
	  obj.product_name  = $("#product_name").val();
	  obj.inv_date  = $("#inv_date").val();
	  obj.etc  = $("#etc").val();
	  obj.reg_date  = $("#reg_date").val();

	  var jsonData = JSON.stringify(obj);
	  console.log("jsonData==", jsonData);
	  
	  $.ajax({ 
			  url: "${pageContext.request.contextPath}/productList.do",
			  
			  type: "POST",
			  data: jsonData,
			  async: false,
			  dataType: "json",
			  contentType : "application/json;charset:UTF-8",
			  success: function(dataList){ //전송에 성공하면 실행될 코드; 
			  	console.log(dataList.result);
			  	for(var i=0;i<dataList.result.length;i++){
			  		data.push(dataList.result[i]);
			  	}
			  	//data = dataList.result;
			  }, 
			  error: function(){ //전송에 실패하면 실행될 코드;
				  console.log("에러");
			  } 
		  });
	  var checkboxSelector = new Slick.CheckboxSelectColumn({
		   cssClass: "slick-cell-checkboxsel" 
		   }); 
	  //checkBox 중복 방지
	  if(checkBox){
		  columns.splice(0, 0, checkboxSelector.getColumnDefinition())
	  }else{
		  columns.splice(0, 1, checkboxSelector.getColumnDefinition())
	  }
	  
	
	  
	  //Slick Grid 생성
	  grid = new Slick.Grid("#myGrid", data, columns, options);
	  grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false})); 
	  grid.registerPlugin(checkboxSelector);
	  $("#myGrid").css("height" , "calc(100vh - 220px)");
	  
		//row 변경시 호출
	  grid.onCellChange.subscribe(function(e, args) {
			console.log(args)
			for(var i =0; i<updatelist.length;i++){
				if(updatelist[i].num == args.item.num){
					updatelist.splice(i)
				}
			}
			updatelist.push(args.item)
		});
}


$(document).ready(function() {
	getList(true);
	$("#${menu}").addClass("active");
});   

function search() {
	getList(false);
}
/* 
//더하기
function addRow(){ 
	   var data = this.grid.getData(); 
	   data.splice(data.length,0,{product_code: null, product_location: null, product_name: null}); 
	   grid.invalidateRow(data.length); 
	   grid.updateRowCount(); 
	   grid.render(); 
	   grid.scrollRowIntoView(data.length-1) 
	   }
	   
	    */
	   
//저장
function saveRow(){
	
	console.log("updatelist ==", updatelist);
	$.ajax({
		  url: "${pageContext.request.contextPath}/productUpdate.do",
		  type: "POST",
		  data: JSON.stringify(updatelist),
		  dataType: "json",
		  contentType : "application/json;charset:UTF-8",
		  success: function(dataList){ //전송에 성공하면 실행될 코드; 
		  	console.log(dataList);
		  	updatelist = [];
		  	getList(false);
		  }, 
		  error: function(){ //전송에 실패하면 실행될 코드;
			  console.log("에러");
		  } 
	  });
	grid.render(); 
	
}
//삭제
function getSelectedRow(){
	var deleteList = [];
	var selectedIndexes = grid.getSelectedRows();
	console.log(selectedIndexes);
	for(var i=0;i<selectedIndexes.length;i++){
			console.log(data[selectedIndexes[i]])
			deleteList.push(data[selectedIndexes[i]].num)
	}
	
	console.log("deleteList ==" , deleteList);
	
	$.ajax({
		  url: "${pageContext.request.contextPath}/productDelete.do",
		  type: "POST",
		  data: JSON.stringify(deleteList),
		  dataType: "json",
		  contentType : "application/json;charset:UTF-8",
		  success: function(dataList){ //전송에 성공하면 실행될 코드; 
		  	console.log("dlete ==" ,dataList);
		  	//updatelist = [];
		  	
		  	
		  	getList(false);
		  }, 
		  error: function(){ //전송에 실패하면 실행될 코드;
			  console.log("에러");
		  } 
	  });
	}
	
	
// 추가저장
function addRow() {
	
	var num = parseInt(data[data.length-1].num) + 1
	var newData = {
			num : String(num)
	}

	console.log("newData ==" , newData);
	data.push(newData);
	/* \
	for(var i=0;i<data.length;i++){
		data[i].num = i+1
	}
	 */
	grid.setData(data);
	grid.render();
	
}

</script>