<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script  src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/libs/SlickGrid/slick.grid.css" type="text/css"/> 
<link rel="stylesheet" href="/resources/libs/SlickGrid/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css"/> 

<link rel="stylesheet" href="../../../resources/css/common.css" type ="text/css"/>


<script src="/resources/libs/SlickGrid/lib/jquery-1.7.min.js"></script> 
<script src="/resources/libs/SlickGrid/lib/jquery.event.drag-2.2.js"></script> 
<script src="/resources/libs/SlickGrid/slick.core.js"></script> 
<script src="/resources/libs/SlickGrid/slick.grid.js"></script>
<script src="/resources/libs/SlickGrid/slick.editors.js"></script>


<script src="/resources/libs/SlickGrid/lib/firebugx.js"></script>

<script src="/resources/libs/SlickGrid/lib/jquery-1.7.min.js"></script>
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
<head>
   <title>Home</title>
</head>
<body>

<P>  부품 입출관리  > 판매 관리 </P>
<div style ="width : 100%; height:10%">
	<table>
		<tr>
			<td>판매 No</td>
			<td><input type="text"></td>
			<td>판매 ID</td>
			<td><input type="text"></td>
			<td>판매처</td>
			<td><input type="text"></td>
			<td>견적 담당자</td>
			<td><input type="text"></td>
			<td>상태</td>
			<td><input type="text"></td>
			<td>부품 요약</td>
			<td><input type="text"></td>
			<td rowspan="2"><input type="button" value="조회" id ="search"></td>
		</tr>
		<tr>
			<td>등록일 (부터)</td>
			<td><input type="text"></td>
			<td>등록일 (까지)</td>
			<td><input type="text"></td>
			<td>상태일 (부터)</td>
			<td><input type="text"></td>
			<td>상태일 (까지)</td>
			<td><input type="text"></td>
			<td>차량(차대) 번호</td>
			<td><input type="text"></td>
			<td colspan="2"></td>

		</tr>
	</table>
</div>



<div id="myGrid" style="width:100%;height:calc(100vh - 250px);"></div>

<script>
// http://6pac.github.io/SlickGrid/examples/example4-model.html
$(document).ready(function() {
   var colums = [
         {id : "product_code", name :"부품코드", field : "product_code" , editor: Slick.Editors.Text ,width : 200 },
         {id : "product_location", name :"부품위치", field : "product_location", editor: Slick.Editors.Text ,width : 100 },
         {id : "product_name", name :"부품명", field : "product_name", editor: Slick.Editors.Text ,width : 200 },
         {id : "purchase_cost", name :"매입원가", field : "purchase_cost", editor: Slick.Editors.Text ,width : 100 },
         {id : "work_cost", name :"작업가", field : "work_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "tinting_cost", name :"썬팅가격", field : "tinting_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "sale_cost", name :"판매가", field : "sale_cost", editor: Slick.Editors.Text ,width : 100},
         {id : "profit_rate", name :"이익율", field : "profit_rate", editor: Slick.Editors.Text ,width : 100},
         {id : "sale_qu", name :"판매수량", field : "sale_qu", editor: Slick.Editors.Text ,width : 100},
         {id : "total", name :"합계", field : "total", editor: Slick.Editors.Text ,width : 100},
         {id : "status_day", name :"상태일", field : "status_day", editor: Slick.Editors.Date ,width : 150},
         {id : "etc", name :"비고", field : "etc", editor: Slick.Editors.Text ,width : 300},
         
         
         
   ];
   
   // 옵션
   var options = {
		   editable: true,
		   enableAddRow: true,
		   enableCellNavigation: true,
		   asyncEditorLoading: true,
		   forceFitColumns: false,
		   topPanelHeight: 25
         //enableColumnReorder : false
   };
   
   // 데이터(json)
   var data = [
      {product_code : 1, product_location : "Title 1", product_name : "Creator1"}
     
   ];
   
   //Slick Grid 생성
   var grid = new Slick.Grid("#myGrid", data, colums, options);
   
   
   $.ajax({ 
		  url: "test.do",
		  contentType : "application/json;charset=utf-8",
		  type: "POST",
		//  data: "전송할 데이터",
		  dataType: "json",
		  success: function(data){ //전송에 성공하면 실행될 코드; 
		  	console.log(data);
		  }, 
		  error: function(){ //전송에 실패하면 실행될 코드; 
		  } 
	  });
});   
</script>


</body>

</html>