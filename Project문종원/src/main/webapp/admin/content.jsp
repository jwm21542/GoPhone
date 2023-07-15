<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.carousel-control-prev-icon {
 background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
}
.carousel-inner img { 
    max-width:100%;
    max-height:100%;
    width: auto; 
    height: auto; 
}
.fill {
    width: 100%;
    height: 100% !important;
}
.carousel-control-next-icon {
  background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
}
input[type='submit'], input[type='button']{
	 background-color: #4e73df;
	 color: white;
	 font-weight: strong;
}
</style>
<title>GoPhone || 상품정보</title>
<%
	boolean flag = false;
	String pmodel = request.getParameter("model");
	String pbrand = request.getParameter("brand");
	String pimage = request.getParameter("pimage");
	String pimage2 = request.getParameter("pimage2");
	String pnum = request.getParameter("pnum");
	String colorPick = "";
	ProductsDao pdao = ProductsDao.getInstance();
	ProductsBean pb = null;
	if(pnum != null){
		pb = pdao.getProductByPnum(pnum);
		flag = true;	
	}
	ArrayList<String> colorList = pdao.getModelColors(pmodel);
	ArrayList<String> storageList = pdao.getModelStorage(pmodel);
	Collections.sort(storageList);
	String[] conds = {"S", "A", "B"};
	String[] pdescTitle = {"운영체제", "출시일", "출고가 (베이스 모델)", "화면크기", "CPU", "램", "네트워크", "보안기능"};
	String imgPath1 = request.getContextPath() + "/images/"+ pimage;
	String imgPath2 = request.getContextPath() + "/images/"+ pimage2;
	DecimalFormat df = new DecimalFormat("###,###");
%>
<script type = "text/javascript">
	function check(){
		var color = document.querySelector('input[name="color"]:checked').value;
		var storage = document.querySelector('input[name="storage"]:checked').value;
		var cond = document.querySelector('input[name="conds"]:checked').value;
		var pmodel = document.querySelector('input[name="model"]').value;
		var pbrand = document.querySelector('input[name="brand"]').value;
		var count = 0;
		var colorTest = document.getElementsByName("color");
		for(i =0; i < colorTest.length; i++){
			if(colorTest[i].checked){
				count++;
			}
		}
		var storageTest = document.getElementsByName("storage");
		for(i =0; i < storageTest.length; i++){
			if(storageTest[i].checked){
				count++;
			}
		}
		var condsTest = document.getElementsByName("conds");
		for(i =0; i < condsTest.length; i++){
			if(condsTest[i].checked){
				count++;
			}
		}
		if(count == 3){
 			location.href = "contentProc.jsp?color=" + color + "&storage=" + storage + "&cond=" + cond
 					+ "&model=" + pmodel + "&brand=" + pbrand;
		}
	}
	var delPrompt = false;
	function deleteCheck(){
		delPrompt = confirm("해당되는 브랜드/모델 삭제하시겠습니까?");
		if(delPrompt){
			<%
			if(pb != null){ %>
				location.href='deleteProc.jsp?brand=' + '<%= pb.getBrand() %>' + '&model=' + '<%= pb.getModel() %>';
			<%}%>
		} 
	}
</script>
<%@ include file = "main_top.jsp"%>
<div class="container-fluid">

	<div class="d-sm-flex align-items-center justify-content-between mb-4">
	    <h1 class="h3 mb-0 text-gray-800">상세보기</h1>
	</div>
	
	<div class="card shadow mb-3" height = "70%">
	            <div class="card-header py-3">
	                <h6 class="m-0 font-weight-bold text-primary"><%= pbrand %> <%= pmodel %></h6>
	            </div>
	            <div class="card-body" style = "height: 900px">
	            	<div style = "display: flex; justify-content: space-evenly;">
		            	<div class = "col-md-4" style = "flex: 0 0 1000px;">
			                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" width = "40%">
								  <ol class="carousel-indicators">
								    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
								    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
								  </ol>
								  <div class="carousel-inner" role="listbox" style=" width:100%; height: 400px !important;">
								    <div class="carousel-item active" style = "height : 100%;">
								      <img class="d-block w-100" src="<%= imgPath1%>" alt="First slide">
								    </div>
								    <div class="carousel-item" style = "height : 100%;">
								      <img class="d-block w-100" src="<%= imgPath2 %>" alt="Second slide" >
								    </div>
								  </div>
								  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
								    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
								    <span class="sr-only">Previous</span>
								  </a>
								  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
								    <span class="carousel-control-next-icon" aria-hidden="true"></span>
								    <span class="sr-only">Next</span>
								  </a>
							</div>
						</div>
						<div class = "col-sm-3" style = "padding-top: 60px;">
						
							<form id = "myform" name = "myform" style = "display:flex; justify-content: space-evenly; align-items: center;" action = "updateProduct.jsp">
							<input type = "hidden" name = "model" value = "<%= pmodel %>">
							<input type = "hidden" name = "brand" value = "<%= pbrand %>">
							<input type = "hidden" name = "pnum" value = "<%= pnum %>">
								<div class="btn-group-vertical btn-group-toggle" data-toggle="buttons">
	  								<%for(int i = 0; i < colorList.size(); i++){ %>
								  <label class="btn btn-primary active" id = "optBtn">
								    <input type="radio" name="color" id="option<%= i+1 %>" autocomplete="off" onClick = "check()" value = "<%= colorList.get(i)%>"
								    <%if(flag && pb.getColor().equals(colorList.get(i))){%> checked <%} %>><%=colorList.get(i) %>
								  </label>
	  								<%} %>
								</div>
								<div class="btn-group-vertical btn-group-toggle" data-toggle="buttons">
	  								<%for(int i = 0; i < storageList.size(); i++){ %>
								  <label class="btn btn-success active">
								    <input type="radio" name="storage" id="option<%= i+1 %>" autocomplete="off" onClick = "check()" value = "<%= storageList.get(i)%>"
								    <%if(flag && pb.getStorage().equals(storageList.get(i))){%> checked <%} %>><%=storageList.get(i) %>
								  </label>
	  								<%} %>
								</div>
								<div class="btn-group-vertical btn-group-toggle" data-toggle="buttons">
	  								<%for(int i = 0; i < conds.length; i++){ %>
								  <label class="btn btn-warning active">
								    <input type="radio" name="conds" id="option<%= i+1 %>" autocomplete="off" onClick = "check()" value = "<%= conds[i]%>"
								    <%if(flag && pb.getCond().equals(conds[i])){%> checked <%} %>><%=conds[i]%>
								  </label>
	  								<%} %>
								</div>
							</form>
						</div>
						
	            	</div>
	            	<%if(pb != null){
	            		String pdesc = pb.getPdesc();
	            		String[] pdList = pdesc.split("/");
	            	%>
	            	
	            	
	            	<div class="" style = "text-align:center; width:65%; margin:auto; height:200px; margin-top:30px;">
	            		<ul class="list-group">
						  <li class="list-group-item"><%= pb.getBrand() %> <%= pb.getModel()%></li>
						  <li class="list-group-item">컨디션: <%= pb.getCond() %>등급 / 용량: <%= pb.getStorage() %> / 색상: <%= pb.getColor() %></li>
						  <li class="list-group-item">재고 수량: <%= pb.getSqty() %> / 가격: <%= df.format(pb.getPrice())%>원 / 적립: <%= pb.getPoint() %></li>
						  <li class="list-group-item">
						  <%for(int i =0; i< pdList.length; i++){ %>
						  	<div style = "display:flex; justify-content: space-around;"><span style = "width : 33%;"><%=pdescTitle[i]%></span><span style = "width : 33%;"><font color = "#4e73df"> - </font></span><span style = "width : 33%;"><%= pdList[i] %></span></div>
						  		<input type = "hidden" name = "<%=pdescTitle[i] %>" value = "<%= pdList[i]%>">
						  <%} %>
						  </li>
						</ul>
						<div class="form-group row" style = "margin-top: 30px;">
							<div class = "col-sm-3 mb-3 mb-sm-0">
					    		<input type="submit" class="form-control form-control-user" form = "myform" value= "정보 수정">
							</div>
							<div class = "col-sm-3 mb-3 mb-sm-0">
					    		<input type="button" class="form-control form-control-user" value= "가격 수정" onClick = "location.href = 'price_insertForm.jsp?brand=<%= pb.getBrand() %>&model=<%= pb.getModel() %>'">
							</div>
							<div class = "col-sm-3 mb-3 mb-sm-0">
					    		<input type="button" class="form-control form-control-user" value= "사진 수정" onClick = "location.href = 'image_updateForm.jsp?brand=<%= pb.getBrand() %>&model=<%= pb.getModel() %>&pimage=<%=pb.getPimage()%>&pimage2=<%= pb.getPimage2()%>'">
							</div>
							<div class = "col-sm-3">
								<input type="button" class="form-control form-control-user" value="삭제" onClick = "deleteCheck()">
							</div>
						</div>
	            	</div>
	            	<%} else{%>
	            	<div class = "card-body" style = "text-align:center; width:65%; margin:auto; height:200px; margin-top:100px;">

                            <div class="card mb-4 py-3 border-bottom-primary">
                                <div class="card-body">
                                    색상, 용량, 컨디션 등급 선택해주세요.
                                </div>
                            </div>
	            	</div>
	            	<%} %>
	            </div>
	</div>
</div>
<%@ include file = "main_bottom.jsp"%>
