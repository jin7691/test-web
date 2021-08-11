<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- <script  src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<link rel="stylesheet" href="/resources/libs/SlickGrid/slick.grid.css" type="text/css"/> 
<link rel="stylesheet" href="/resources/libs/SlickGrid/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css"/> 



<link rel="stylesheet" href="../../../resources/css/common.css" type ="text/css"/>


<script src="/resources/libs/SlickGrid/lib/jquery-1.7.min.js"></script> 
<script src="/resources/libs/SlickGrid/lib/jquery.event.drag-2.2.js"></script> 
<script src="/resources/libs/SlickGrid/slick.core.js"></script> 
<script src="/resources/libs/SlickGrid/slick.grid.js"></script>
<script src="/resources/libs/SlickGrid/slick.editors.js"></script>


<script src="/resources/libs/SlickGrid/lib/firebugx.js"></script>


<script src="/resources/libs/SlickGrid/lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="/resources/libs/SlickGrid/lib/jquery.event.drag-2.2.js"></script>

<script src="/resources/libs/SlickGrid/slick.core.js"></script>
<script src="/resources/libs/SlickGrid/slick.formatters.js"></script>
<script src="/resources/libs/SlickGrid/slick.editors.js"></script>
<script src="/resources/libs/SlickGrid/plugins/slick.rowselectionmodel.js"></script>
<script src="/resources/libs/SlickGrid/slick.grid.js"></script>
<script src="/resources/libs/SlickGrid/slick.dataview.js"></script>
<script src="/resources/libs/SlickGrid/controls/slick.pager.js"></script>
<script src="/resources/libs/SlickGrid/controls/slick.columnpicker.js"></script>
<script src="../../../resources/libs/SlickGrid/plugins/slick.checkboxselectcolumn.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<head>
   <title>Home</title>
</head>
<body>
<P>  부품 입출관리  > 판매 관리 </P>
<div  class="table-responsive">
	<table class="table">
		<tr>
			<td >판매 No</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="sel_no"></td>
			<td>판매 ID</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="sel_id"></td>
			<td>판매처</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="sel_pl"></td>
			<td>견적 담당자</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="estimate_user"></td>
			<td>상태</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="status"></td>
			<td>부품 요약</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="part"></td>
			<td rowspan="2"><input type="button" value="조회" id ="search" class="btn btn-default" onClick ="search();"></td>
		</tr>
		<tr>
			<td>등록일 (부터)</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="reg_date_start"></td>
			<td>등록일 (까지)</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="reg_date_end"></td>
			<td>상태일 (부터)</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="status_date_start"></td>
			<td>상태일 (까지)</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="status_date_end"></td>
			<td>차량(차대) 번호</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="car_no"></td>
			<td></td>
			<td></td>

		</tr>
	</table>
</div>



<button type="button" class="btn btn-default navbar-right center-block" onClick="getSelectedRow();">삭제</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="addRow();">추가</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="saveRow();">저장</button>


<div id="myGrid" style="width:100%;height:calc(100vh - 200px);"></div>

<script>
// http://6pac.github.io/SlickGrid/examples/example4-model.html

var grid
var data
var updatelist = []
$(document).ready(function() {
   var columns = [
	  	 {id : "num", name :"", field : "num" ,width : 20 },
         {id : "product_code", name :"견적날자(작업날자)", field : "product_code" , editor: Slick.Editors.Date ,width : 200 },
         {id : "product_location", name :"거주지", field : "product_location", editor: Slick.Editors.Text ,width : 100 },
         {id : "product_name", name :"시공지점", field : "product_name", editor: Slick.Editors.Text ,width : 200 },
         {id : "purchase_cost", name :"고객명", field : "purchase_cost", editor: Slick.Editors.Text ,width : 100 },
         {id : "work_cost", name :"차량", field : "work_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "tinting_cost", name :"유리품번", field : "tinting_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "sale_cost", name :"재고수량", field : "sale_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "profit_rate", name :"유리가격(원가)", field : "profit_rate", editor: Slick.Editors.Text ,width : 100},
         {id : "sale_qu", name :"작업가", field : "sale_qu", editor: Slick.Editors.Text ,width : 100},
         {id : "total", name :"썬팅종류", field : "total", editor: Slick.Editors.Text ,width : 100},
         {id : "status_day", name :"선팅가격", field : "status_day", editor: Slick.Editors.Text ,width : 150},
         {id : "etc", name :"합계(유리가격+썬팅가격)", field : "etc", editor: Slick.Editors.Text ,width : 300},
         
         
         
   ];
   
   // 옵션
   var options = {
		   editable: true,
		   enableAddRow: true,
		   enableCellNavigation: true,
		   asyncEditorLoading: true,
		   forceFitColumns: false,
		   headerRowHeight: 50
         //enableColumnReorder : false
   };
   
   // 데이터(json)
   data = [
      {num : "1", product_code : "21.7.13", product_location : "성남", product_name : "성남점", purchase_cost : "김삼훈", work_cost : "k5", tinting_cost : "1111-1111", sale_cost : "5장", profit_rate : "100원"
    	  , sale_qu : "300", total : "루마썬팅(gg)",status_day : "10원", etc : "330원" },
   	  {num : "2", product_code : "21.7.14", product_location : "성남", product_name : "강남점", purchase_cost : "김삼훈2", work_cost : "k4", tinting_cost : "2222-2222", sale_cost : "1장", profit_rate : "300원"
       	  , sale_qu : "400", total : "루마썬팅(aa)",status_day : "15원", etc : "430원" }
     
   ];
   
   var checkboxSelector = new Slick.CheckboxSelectColumn({
	   cssClass: "slick-cell-checkboxsel" 
	   }); 
   columns.splice(0, 0, checkboxSelector.getColumnDefinition())

   
   //Slick Grid 생성
   grid = new Slick.Grid("#myGrid", data, columns, options);
   grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false})); 
   grid.registerPlugin(checkboxSelector);

   
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
   
   //
});   

//더하기
function addRow(){ 
	   var data = this.grid.getData(); 
	   data.splice(data.length,0,{product_code: null, product_location: null, product_name: null}); 
	   grid.invalidateRow(data.length); 
	   grid.updateRowCount(); 
	   grid.render(); 
	   grid.scrollRowIntoView(data.length-1) 
	   }
	   
//저장
function saveRow(){
	
	for(var i=0; i<data.length; i++){
		for(var j=0;j<updatelist.length; j++){
			if(data[i].num == updatelist[j].num ){
				console.log("aaa")
				data[i] = updatelist[j]
			}
		}
		
	}
	grid.render(); 
	
}
//삭제
function getSelectedRow(){
	var selectedIndexes = grid.getSelectedRows();
	alert(selectedIndexes); 
	console.log(selectedIndexes);
	for(var i=0;i<selectedIndexes.length;i++){
		data.splice(selectedIndexes[i])
	}
	
	grid.setData(data);
	grid.render();
	}
	
	
// 조회
function search() {
	
	
	var selNo = $("#sel_no").val(); //판매 번호
	var selId = $("#sel_id").val(); // 판매 아이디
	var selPi = $("#sel_pl").val(); // 판매처
	var estimateUser = $("#estimate_user").val(); //견적자 
	var status = $("#status").val(); //상태
	var part = $("#part").val();  // 부품요약
	var reg_date_start  = $("#reg_date_start").val() // 등록일 (부터)
	var reg_date_end = $("#reg_date_end").val() // 등록일 (까지)
	var status_date_start = $("#status_date_start").val() //상태일(부터)
	var status_date_end = $("#status_date_end").val() // 상태일(까지)
	var car_no = $("#car_no").val(); //차량 번호
	
	var newData = []
	
	for(var i=0;i<data.length;i++){
		if(selNo == data[i].item.sel_no){
			
		}
		
		
	}
	
	console.log("selNo ==", selNo)
	console.log("selId ==", selId)
	
	
}

</script>


</body>

</html>