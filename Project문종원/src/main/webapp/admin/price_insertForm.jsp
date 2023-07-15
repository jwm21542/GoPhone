<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type = "text/javascript" src = "<%= request.getContextPath() %>/js/jquery.js"></script>
<script type = "text/javascript" src = "./script.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String brand = request.getParameter("brand");
	String model = request.getParameter("model"); 
	ProductsDao pdao = ProductsDao.getInstance();
	ArrayList<String> list = pdao.getStorages(brand, model);
%>
<title>GoPhone || 가격등록</title>
<%@ include file = "main_top.jsp"%>
	    <h1 class="h3 mb-0 text-gray-800" style = "margin-left: 15px;">추가한 상품의 가격을 정해주세요.</h1><br>
	    <p class="mb-4" style = "margin-left: 15px;">S급은 기본가격의 120% 받고, A급은 100%, B급은 80% 받습니다. 포인트는 자동으로 상품 가격의 5% 입니다.</p>
		<div class="col-lg-10" align = "center" style = "margin:auto;">
		  	<div class="card shadow mb-4">
				<div class="card-header py-3">
				    <h5 class="m-0 font-weight-bold text-primary">가격 정하기 (<%= brand %> <%= model %>)</h5>
				</div>
				
				<div class="card-body">
					<form action = "price_insertProc.jsp" method = "post">
					<input type = "hidden" name = "brand" value = "<%= brand%>">
					<input type = "hidden" name = "model" value = "<%= model%>">
					<div class = "form-row" style = "margin-bottom: 20px;">
						<div class = "col-md-6">용량</div>
						<div class = "col-md-6">가격</div>
					</div>
					<%for(int i = 0; i < list.size(); i++){ %>
						<div class = "form-row" style = "margin-bottom: 20px;">
							<div class = "col-md-6"><%= list.get(i) %></div>
							<div class = "col-md-6" style = "display: flex;">
								<span class="input-group-text" style = "padding:18px; height:40px;">&#8361;</span>
								<input type="text" name = "price" class="form-control" aria-label="Amount (to the nearest dollar)" style = "height:40px; text-align: right;">
								<span class="input-group-text" style = "padding:18px; height:40px;">원</span>
							</div>					
						</div>
					<%} %>
					<div class="form-group row">
				<div class = "col-sm-6 mb-3 mb-sm-0">
		    		<input type="submit" class="form-control form-control-user" value= "가격 등록" onClick = "return priceCheck(<%= list.size()%>)">
				</div>
				<div class = "col-sm-6">
					<input type="reset" class="form-control form-control-user" value="초기화">
				</div>
			</div>
					</form>
				</div>	
			</div>
		</div>
<%@ include file = "main_bottom.jsp"%>