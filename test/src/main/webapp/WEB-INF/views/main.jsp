<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
   <title>main</title>
</head>
<body>
<jsp:include page="../views/menu/top.jsp"></jsp:include>
<P>  견적 관리 </P>

<div  class="table-responsive">
<!-- <button type="button" class="btn btn-default navbar-right center-block" onClick="addRowSave();">추가저장</button> -->
	<table class="table">
		<tr>
			<td class ="search" style="padding-top: 1%;">견적 ID</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">판매처</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">거래처</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="account"></td>
			<td class ="search" style="padding-top: 1%;">판매처</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">담당자</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">차량(차대) 번호</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">판매일</td>
			<td><input type="text" class="form-control datepicker1" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td rowspan ="2" class="text-center"><button type="button" class="btn btn-dark">search</button></td>
		</tr>
		<tr>
			
			<td class ="search" style="padding-top: 1%;">업체증감율</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">견적금액</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" id="estimate_pay"></td>
			<td class ="search" style="padding-top: 1%;">운송비</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">총견적금액</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">최종견적금액</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">상태</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
			<td class ="search" style="padding-top: 1%;">부품요약</td>
			<td><input type="text" class="form-control" placeholder="" aria-describedby="sizing-addon3" ></td>
		</tr>
	</table>
</div>



<button type="button" class="btn btn-default navbar-right center-block" onClick="getSelectedRow();">삭제</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="addRow();">추가</button>
<button type="button" class="btn btn-default navbar-right center-block" onClick="saveRow();">저장</button>

<div id="myGrid" style="width:100%;height:calc(100vh - 290px);"></div>

<script>
// http://6pac.github.io/SlickGrid/examples/example4-model.html


var grid
var data
var updatelist = []
var productList = []
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

$(document).ready(function() {
	$("#${menu}").addClass("active");
   var columns = [
	   
	   {id : "num", name :"", field : "num" ,width : 20 },
	   {id : "product_code", name :"도/시", field : "product_code" , editor: Slick.Editors.Date ,width : 100 },
       {id : "product_code", name :"도/시", field : "product_code" , editor: Slick.Editors.Date ,width : 100 },
       {id : "product_location", name :"시/군/구", field : "product_location", editor: Slick.Editors.Text ,width : 120 },
       {id : "product_name", name :"거래처", field : "product_name", editor: Slick.Editors.Text ,width : 180 },
       {id : "purchase_cost", name :"판매처", field : "purchase_cost", editor: Slick.Editors.Text ,width : 180 },
       {id : "work_cost", name :"담당자", field : "work_cost", editor: Slick.Editors.Text ,width : 90},
       {id : "tinting_cost", name :"차량(차대)번호", field : "tinting_cost", editor: Slick.Editors.Text ,width : 100},
       {id : "sale_cost", name :"업체증감율", field : "sale_cost", editor: Slick.Editors.Text ,width : 100},
       {id : "profit_rate", name :"견적금액", field : "profit_rate", editor: Slick.Editors.Text ,width : 100},
       {id : "sale_qu", name :"운송비", field : "sale_qu", editor: Slick.Editors.Text ,width : 100},
       {id : "total", name :"총견적금액", field : "total", editor: Slick.Editors.Text ,width : 100},
       {id : "status_day", name :"최종견적금액", field : "status_day", editor: Slick.Editors.Text ,width : 150},
       {id : "etc", name :"상태", field : "etc", editor: Slick.Editors.Text ,width : 80},
       {id : "etc1", name :"부품요약", field : "etc1", editor: Slick.Editors.Text ,width : 200},
       {id : "etc2", name :"비고", field : "etc2", editor: Slick.Editors.Text ,width : 200},
       {id : "etc3", name :"판매일", field : "etc3", editor: Slick.Editors.Date ,width : 80},
       {id : "etc4", name :"수정일", field : "etc4", editor: Slick.Editors.Date ,width : 80},
       {id : "etc5", name :"등록일", field : "etc5", editor: Slick.Editors.Date ,width : 80},
         
         
         
         
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
      {num : "1", product_code : "경기도", product_location : "성남시 중원구", product_name : "글로벌자동차유리(주)", purchase_cost : "글로벌자동차유리(주)", work_cost : "최고관리자", tinting_cost : "", sale_cost : "0", profit_rate : "0"
    	  , sale_qu : "0", total : "0",status_day : "0", etc : "판매전환", etc1 : "부품/부품/부품"  , etc2 : "", etc3 : "2021-07-13" , etc4 : "2021-07-13" , etc5 : "2021-07-13"},
   	  {num : "2", product_code : "서울시", product_location : "강남구", product_name : "자동차유리(주)", purchase_cost : "자동차유리(주)", work_cost : "최고관리자", tinting_cost : "", sale_cost : "0", profit_rate : "0"
       	  , sale_qu : "0", total : "0",status_day : "0", etc : "판매전환", etc1 : "부품/부품/부품"  , etc2 : "", etc3 : "2021-07-13" , etc4 : "2021-07-13" , etc5 : "2021-07-13"},
       	  
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
   
   //product list 정보 가져오기
   /*
   $.ajax({ 
		  url: "${pageContext.request.contextPath}/productList.do",
		  type: "POST",
		  data: {},
		  async: false,
		  dataType: "json",
		  contentType : "application/json;charset:UTF-8",
		  success: function(dataList){ //전송에 성공하면 실행될 코드; 
		  	console.log("dataList ==" , dataList.result);
		  	for(var i=0;i<dataList.result.length;i++){
		  		productList.push(dataList.result[i]);
		  	}
		  	//data = dataList.result;
		  }, 
		  error: function(){ //전송에 실패하면 실행될 코드;
			  console.log("에러");
		  } 
	  });
   */
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
	console.log(selectedIndexes);
	for(var i=0;i<selectedIndexes.length;i++){
			data.splice(selectedIndexes[i],1)	
	}
	
	grid.setData(data);
	grid.render();
	}
	
	
// 조회
function addRowSave() {
	
	/*
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
	*/
	var num = data.length+1
	var account = $("#account").val()
	var estimate_pay = $("#estimate_pay").val()
	var newData = {}
	for(var i=0;i<accountList.length;i++){
		if(accountList[i].product_name == account){
			newData = {
					num : num,
					product_code : accountList[i].product_code,
					product_location : accountList[i].product_location,
					purchase_cost : accountList[i].purchase_cost,
					product_name : account,
					status_day : estimate_pay
			}
		}
	}
	
	data.push(newData);
	
	for(var i=0;i<data.length;i++){
		data[i].num = i+1
	}
	
	grid.setData(data);
	grid.render();
	
}

</script>


</body>

</html>