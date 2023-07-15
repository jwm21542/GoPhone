<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.RequestBean"%>
<%@page import="myPkg.MembersDao"%>
<%@page import="myPkg.RequestDao"%>
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
	String reqno = request.getParameter("reqno");
	ProductsDao pdao = ProductsDao.getInstance();
	RequestDao rdao = RequestDao.getInstance();
	MembersDao mdao = MembersDao.getInstance();
	RequestBean rb = rdao.getRequestByNo(Integer.parseInt(reqno));
	ProductsBean pb = pdao.getProductByPnum(String.valueOf(rb.getPnum()));
	MembersBean mb = mdao.getMemberByNo(rb.getMemno());
	DecimalFormat df = new DecimalFormat("###,###");
	String conPath = request.getContextPath();
	
%>
<%@ include file = "main_top.jsp"%>
<div class="container-fluid">

	    <h1 class="h3 mb-0 text-gray-800">판매신청</h1>
	    <% if(rb.getApprove().equals("미결정")){%>
   	    <p class="mb-4">사진 및 정보 검토하신후 판매 가능/불가능 결정해주세요.</p>
		<% } else { %>	    
   	    <p class="mb-4">결정 등록됬습니다.</p>
		
		<%} %>
	<div class="card shadow mb-3" height = "70%">
	            <div class="card-header py-3">
	                <h6 class="m-0 font-weight-bold text-primary"><%= pb.getBrand() %> <%= pb.getModel() %> - <%= pb.getColor() %> / <%= pb.getStorage() %> / <%= pb.getCond() %></h6>
	            </div>
	            <div class="card-body" style = "height: 800px">
	            	<div style = "display: flex; justify-content: space-evenly;">
		            	<div class = "col-md-6" style = "flex: 0 0 1000px;">
			                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" width = "40%">
								  <ol class="carousel-indicators">
								    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
								    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
								  </ol>
								  <div class="carousel-inner" role="listbox" style=" width:100%; height: 400px !important;">
								    <div class="carousel-item active" style = "height : 100%;">
								      <img class="d-block w-100" src="<%= conPath %>/images/<%= rb.getFimage() %>" alt="First slide">
								    </div>
								    <div class="carousel-item" style = "height : 100%;">
								      <img class="d-block w-100" src="<%= conPath %>/images/<%= rb.getBimage() %>" alt="Second slide" >
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
	            	</div>
	            	<div class="" style = "text-align:center; width:65%; margin:auto; height:200px; margin-top:30px;">
	            		<form id = "myform">
	            		<ul class="list-group">
						  <li class="list-group-item">상품 : <%= pb.getBrand() %> <%= pb.getModel() %> - <%= pb.getColor() %> / <%= pb.getStorage()%> / <%= pb.getCond() %>급</li>
						  <li class="list-group-item">회원정보 : <%= mb.getName() %> / <%= mb.getPhn1() + "-" + mb.getPhn2() + "-" + mb.getPhn3() %> / <%= mb.getEmail() %></li>
						  <li class="list-group-item">은행 계정 (신청 승인 후 입금): <%= mb.getBankName() %> - <%= mb.getBankNum() %></li>
						  <li class="list-group-item">매입가 : &#8361;<%= df.format(rb.getSellPrice()) %>원</li>
						  <li class="list-group-item">결정 : <%= rb.getApprove() %></li>
						</ul>
						</form>
						<% if(rb.getApprove().equals("미결정")){ %>
						<div class="form-group row" style = "margin-top: 30px;">
							<div class = "col-sm-4 mb-3 mb-sm-0">
					    		<input type="button" class="form-control form-control-user" value= "판매 가능" onClick = "location.href = 'finalizeRequest.jsp?reqno=<%= reqno %>&approve=approved'">
							</div>
							<div class = "col-sm-4 mb-3 mb-sm-0">
					    		<input type="button" class="form-control form-control-user" value= "판매 불가능" onClick = "location.href = 'finalizeRequest.jsp?reqno=<%= reqno %>&approve=unapproved'">
							</div>
							<div class = "col-sm-4">
								<input type="button" class="form-control form-control-user" value="돌아가기" onClick = "history.go(-1)">
							</div>
						</div>
						<% } %>
	            	</div>
	            </div>
	</div>
</div>
<%@ include file = "main_bottom.jsp"%>
