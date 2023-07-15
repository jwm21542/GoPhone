<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./../header.jsp"%>
<%@ include file = "./../headerBanner.jsp"%>
<style type = "text/css">
.input-group-text{
	 height: 33px;
	 font-size: 15px;
	 width: 100px;
	 text-align: center;
}
.form-select{
	width:50% !important;
	font-size: 15px;
}
#priceBlock{
	font-size:22px;
	color: black;
	margin-left: 14px;
}
</style>
<title>GoPhone || 판매신청</title>
   <div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-shield-home"></i>홈 페이지</a></li>
                                <li><%if(sid == null){ %>
                                        <a href="<%= conPath%>/login.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            계정관리
                                        </a>
                                    <%} else if(!sid.equals("admin")){%>
										<a href="<%= conPath%>/member/myaccount.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            <%= mb.getName() %>님
                                        </a>
                                    <%} else {%>
                                    	<a href="<%= conPath%>/admin/myaccount.jsp">
                                            <i class="zmdi zmdi-shield-security"></i>
                                            관리자 페이지
                                        </a>
                                    <%} %></li>
                                <li class="active">중고폰 판매 신청하기</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>	
<%
	ProductsDao pdao = ProductsDao.getInstance();
	if(mb == null){
		%>
			<script type = "text/javascript">
				alert("먼저 로그인해야 됩니다.")
				location.href = "<%= conPath%>" + "/login.jsp";
			</script>	
		<%
	}
	String brand = request.getParameter("brand");
	String pmodel = request.getParameter("model");
	String color2 = request.getParameter("color");
	String storage2 = request.getParameter("storage");
	String cond2 = request.getParameter("cond");
	ArrayList<String> storageList = null;
	ArrayList<String> colorList = null;
	ArrayList<String> modelList = null;
	if(brand != null) {
		modelList = pdao.getModelsByBrand(brand);
	}
	if(brand != null && pmodel != null){
		storageList = pdao.getStorages(brand, pmodel);
		colorList = pdao.getColors(brand, pmodel);
	}
	int purchasePrice = 0; boolean estCheck = false;
	if(brand != null && pmodel != null && color2 != null && storage2 != null && cond2 != null){
		ProductsBean pb = pdao.getProduct(brand, pmodel, cond2, storage2, color2);
		purchasePrice = pb.getPrice();
		estCheck = true;
	}
	String[] conds = {"S", "A", "B"};
%>

<script type= "text/javascript">
	function addModels(){
		var brand = $('select[name=brand] option:selected').val();
		if(brand != null){ 
			location.href = "requestProduct.jsp?brand=" + brand;
		}
		
	}
	
	function addStorageColor(){
		var brand = $('select[name=brand] option:selected').val();
		var model = $('select[name=model] option:selected').val();
		if(brand != "" && model != ""){
			location.href = "requestProduct.jsp?brand=" + brand + "&model=" + model;
		}
	}
	function estPrice(){
		var brand = $('select[name=brand] option:selected').val();
		var model = $('select[name=model] option:selected').val();
		var color = $('select[name=color] option:selected').val();
		var storage = $('select[name=storage] option:selected').val();
		var condition = $('select[name=cond] option:selected').val();
		var fimage = $('#fileinput1').val();
		var bimage = $('#fileinput2').val();
		if(brand == "" || model == "" || color == "" || storage == "" || condition == ""){
			alert("모든 옵션 선택해주세요");
		}
		location.href = "requestProduct.jsp?brand=" + brand + "&model=" + model + "&color=" + color + "&storage=" + storage + "&cond=" + condition;
	}
	
	function check(){
		var brand = $('select[name=brand] option:selected').val();
		var model = $('select[name=model] option:selected').val();
		var color = $('select[name=color] option:selected').val();
		var storage = $('select[name=storage] option:selected').val();
		var condition = $('select[name=cond] option:selected').val();
		var fimage = $('#fileinput1').val();
		var bimage = $('#fileinput2').val();
		if(brand == "" || model == "" || color == "" || storage == "" || condition == ""){
			alert("모든 옵션 선택해주세요");
			return false;
		} else if(fimage == "" || bimage == ""){
			alert("중고폰 앞/뒤 사진 올려주세요");
			return false;
		}
	}
	
</script>
            <!-- MESSAGE BOX SECTION START -->
            <div class="message-box-section mt-50 mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="message-box box-shadow white-bg">
                                <form id="myform" action="requestProductProc.jsp" method = "post" enctype = "multipart/form-data">
                                	<input type = "hidden" name = "memno" value = "<%= sno %>">
                                	<div class = "col-md-12" style = "display: flex;">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">판매 하고 싶은 스마트폰 신청하세요!</h4>
                                        </div>
                                        <div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect01">브랜드 : </label>
										  <select name = "brand" class="form-select" onChange = "addModels()" style = "height: 33px !important;">
												<option value = "">선택</option>
                                            	<option value = "삼성" <% if(brand != null && brand.equals("삼성")) { %> selected <%} %>>삼성</option>
                                            	<option value = "애플" <% if(brand != null && brand.equals("애플")) { %> selected <%} %>>애플</option>
                                            	<option value = "LG" <% if(brand != null && brand.equals("LG")) { %> selected <%} %>>LG</option>
										  </select>
										</div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect01">모델 : </label>
										  <select name = "model" class="form-select" onChange = "addStorageColor()" style = "height: 33px !important; width : 91%;">
                                            	<option value = "">선택</option>
                                            	<% if(modelList != null){
                                            			for(String model : modelList){%>
                                            				<option value = "<%= model %>" <% if(pmodel != null && pmodel.equals(model)) { %> selected <%} %>><%= model %></option>
                                            			<%}
                                            	}%>	
                                            </select>
										</div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect03">색상 : </label>
										  <select name = "color" class="form-select" onChange = "" class = "form-select" style = "height: 33px !important;">
                                            	<option value = "">선택</option>
                                            	<% if(colorList != null){
                                            			for(String color : colorList){%>
                                            				<option value = "<%= color %>" <%if(color.equals(color2)){ %> selected <%} %>><%= color %></option>
                                            			<%}
                                            	}%>
                                            </select>
										</div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect04">용량 : </label>
										  <select name = "storage" class="form-select" onChange = "" style = "height: 33px !important; width:91%;">
                                            	<option value = "">선택</option>
                                            	<% if(storageList != null){
                                            			for(String storage : storageList){%>
                                            				<option value = "<%= storage %>" <%if(storage.equals(storage2)){ %> selected <%} %>><%=storage %></option>
                                            			<%}
                                            	}%>
                                            </select>
										</div>
										<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect04">컨디션 등급 : </label>
										  <select name = "cond" class="form-select" onChange = "" style = "height: 33px !important; width:84%;">
                                            	<option value = "">선택</option>
                                            			<%for(String cond : conds){%>
                                            				<option value = "<%= cond %>" <%if(cond.equals(cond2)){ %> selected <%} %>><%=cond%></option>
                                            			<%}%>
                                            </select>
										</div>
											<div class="input-group mb-3">
											  <label class="input-group-text" style = "height: 50px !important;width: 120px !important;">중고폰 앞 사진</label>
											  <input type="file" class="form-control" id="fileinput1" name = "fimage" style = "height: 50px !important;">
											</div>
											<div class="input-group mb-3">
											  <label class="input-group-text" for="inputGroupFile01" style = "height: 50px !important; width: 120px !important;">중고폰 뒷 사진</label>
											  <input type="file" class="form-control" id="fileinput2" name = "bimage" style = "height: 50px !important;">
											</div>
                                        <div class="col-lg-12">
                                            <button class="submit-btn-1 mt-30 btn-hover-1" type="submit" onclick = "return check()">신청하기</button>
											<input type = "button" class =  "submit-btn-1 mt-30 btn-hover-1" id = "sellPrice" name = "sellPrice" value = "매입가 보기" onClick = "estPrice()">
											<input type = "hidden" name = "sellPrice" value = "<%= (int)(purchasePrice * 0.7) %>">
 											<span id = "priceBlock"><%if(estCheck == true){ %> &#8361;<%= df2.format((int)(purchasePrice * 0.7))%>원<%} %></span>
                                        </div>
                                    </div>
                                    <div class = "col-lg-5">
                                    	<img src = "<%= conPath%>/img/banner/banner6.jpg" style = "width: 90%; height:auto;margin-left: 40px; margin-top:46px;">
                                    </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<%@ include file = "./../footer.jsp"%>