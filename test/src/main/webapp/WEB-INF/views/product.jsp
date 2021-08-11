<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
   <title>product</title>
</head>
<body>
<jsp:include page="../views/menu/top.jsp"></jsp:include>
<P>  부품 관리 </P>
<div  class="table-responsive">
<!-- <button type="button" class="btn btn-default navbar-right center-block" onClick="addRowSave();">추가저장</button> -->
<!-- <input type="text" id ="datepicker1"/> -->
<input type="button" value="조회" id ="search" class="btn btn-default navbar-right" onClick ="search();">
	<table class="table">
		<tr>
			<td class ="search" style="padding-top: 1%;">부분</td>
			<td><input type="text" id="part" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">브랜드</td>
			<td><input type="text" id="brand" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">시리즈</td>
			<td><input type="text" id="series" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">바디</td>
			<td><input type="text" id="body" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">옵션</td>
			<td><input type="text" id="product_option" class="form-control" placeholder="" aria-describedby="sizing-addon3"></td>
			<td class ="search" style="padding-top: 1%;">부품코드</td>
			<td><input type="text" id="product_code" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">부품명</td>
			<td><input type="text" id="product_name" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">부품구분</td>
			<td><input type="text" id="product_part" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
		</tr>
		<tr>
			<td class ="search" style="padding-top: 1%;">사용구분</td>
			<td><input type="text" id="ust_yn" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">정품구분</td>
			<td><input type="text" id="gen_product" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">차고위치</td>
			<td><input type="text" id="garbage_name" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">비고</td>
			<td><input type="text" id="etc" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">조사일</td>
			<td><input type="text" id="inv_date" class="form-control datepicker1" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">등록일</td>
			<td><input type="text" id="reg_date" class="form-control datepicker1" placeholder="" aria-describedby="sizing-addon3" ></td>
		</tr>

		
		
	</table>
</div>



<button type="button" class="btn btn-default navbar-right center-block" onClick="getSelectedRow();">삭제</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="addRow();">추가</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="saveRow();">저장</button>

	<div id="myGrid" style="width:100%;height:calc(100vh - 330px);"></div>


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
     
var resizer;
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
	
	{id : "part", name :"부분", field : "part" , editor: Slick.Editors.Text ,width : 50 },
    {id : "brand", name :"브랜드", field : "brand" , editor: Slick.Editors.Text ,width : 80 },
    {id : "series", name :"시리즈", field : "series" , editor: Slick.Editors.Text ,width : 80 },
    {id : "body", name :"바디", field : "body" , editor: Slick.Editors.Text ,width : 80 },
    {id : "product_option", name :"옵션", field : "product_option" , editor: Slick.Editors.Text ,width : 100 },
    {id : "product_code", name :"부품코드", field : "product_code", editor: Slick.Editors.Text ,width : 120 },
    {id : "product_name", name :"부품명", field : "product_name", editor: Slick.Editors.Text ,width : 180 },
    {id : "product_part", name :"부품구분", field : "product_part", editor: Slick.Editors.Text ,width : 180 },
    {id : "pur_cost", name :"매입원가", field : "pur_cost" , editor: Slick.Editors.Text ,width : 100 },
    {id : "center_cost", name :"센터가격", field : "center_cost" , editor: Slick.Editors.Text ,width : 100 },
    {id : "job_cost", name :"작업가", field : "job_cost" , editor: Slick.Editors.Text ,width : 100 },
    {id : "pgc_cost", name :"PGC 가격", field : "pgc_cost" , editor: Slick.Editors.Text ,width : 100 },
    {id : "ust_yn", name :"사용구분", field : "ust_yn" , editor: Slick.Editors.Text ,width : 70 },
    {id : "gen_product", name :"정품구분", field : "gen_product" , editor: Slick.Editors.Text ,width : 70 },
    {id : "garbage_name", name :"창고위치", field : "garbage_name" , editor: Slick.Editors.Text ,width : 100 },
    {id : "product_count", name :"부품수량", field : "product_count", editor: Slick.Editors.Text ,width : 180 },
    {id : "etc", name :"비고", field : "etc", editor: Slick.Editors.Text ,width : 200},
    {id : "inv_date", name :"조사일", field : "inv_date", editor: Slick.Editors.Date ,width : 150},
    {id : "reg_date", name :"등록일", field : "reg_date" ,width : 150},
    {id : "num", name :"No", field : "num" ,width : 0, minWidth: 0, maxWidth: 0, cssClass: "reallyHidden", headerCssClass: "reallyHidden"  }
 
];
//초기화
function getList(checkBox) {
		
	  var modifiedCells = {}; 
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
	  obj.part = $("#part").val();	//부분
	  obj.brand = $("#brand").val();	// 브랜드
	  obj.series = $("#series").val();	// 시리즈
	  obj.body = $("#body").val();	//바디
	  obj.product_option = $("#product_option").val();	// 옵션
	  obj.product_code  = $("#product_code").val();	//부품 코드
	  obj.product_name  = $("#product_name").val();	// 부품명
	  obj.product_part = $("#product_part").val();	// 부품구분
	  obj.pur_cost = $("#pur_cost").val();	// 매입원가
	  obj.center_cost = $("#center_cost").val();	// 센터가격
	  obj.job_cost = $("#job_cost").val();	// 작업가
	  obj.pgc_cost = $("#pgc_cost").val();	// pgc 가격
	  obj.ust_yn = $("#ust_yn").val();		//사용구분
	  obj.gen_product = $("#gen_product").val();	// 정품구분
	  obj.garbage_name = $("#garbage_name").val();	// 창고위치
	  obj.etc  = $("#etc").val();	//비고
	  obj.inv_date  = $("#inv_date").val();	//조사일
	  obj.reg_date  = $("#reg_date").val();	// 등록일

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
	  $("#myGrid").css("height" , "calc(100vh - 330px)");
	  

	  

	  //row 변경시 호출
	  grid.onCellChange.subscribe(function(e, args) {
			console.log(args);
			console.log("cell ==" , args.cell);
			console.log("row ==" , args.row);
			for(var i =0; i<updatelist.length;i++){
				if(updatelist[i].num == args.item.num){
					updatelist.splice(i)
				}
			}
			
			if (!modifiedCells[args.row]) { 
		      modifiedCells[args.row] = {}; 
		     } 
			
			// 변경 확인이필요함
			/*
			console.log("modifiedCells[args.row] ==",modifiedCells[args.row]);
			console.log("this.getColumns() =-=" , this.getColumns()[0]);
			console.log("this.getColumns()[0].name ===" , this.getColumns()[0].name);
			console.log("this.getColumns()[0].id ===" , this.getColumns()[0].id);
			console.log("this.getColumns()[1].id ===" , this.getColumns()[1].id);
			*/
			//console.log("modifiedCells ==" ,modifiedCells[args.row][this.getColumns()[0].id]);
		     modifiedCells[args.row][this.getColumns()[args.cell].id] = "slick-cell-modified"; 
		     this.setCellCssStyles("modified", modifiedCells);
		     
		     grid.invalidate();
			updatelist.push(args.item)
		});
}


$(document).ready(function() {
	getList(true);
	$("#${menu}").addClass("active");
	
	$(window).resize(function () {
	    grid.resizeCanvas();
	    //grid.autosizeColumns();  //컬럼 자동 맞춤
	});
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
		  	grid.removeCellCssStyles("modified"); 
		    modifiedCells = {}; 
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


</body>

</html>