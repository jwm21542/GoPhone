<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type = "text/javascript" src = "<%= request.getContextPath() %>/js/jquery.js"></script>
<script type = "text/javascript" src = "./script.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	String pimage = request.getParameter("pimage");
	String pimage2 = request.getParameter("pimage2");
%>
<title>GoPhone || 사진수정</title>
<%@ include file = "main_top.jsp"%>
	    <h1 class="h3 mb-0 text-gray-800" style = "margin-left: 15px;">수정하실 사진을 올려주세요</h1><br>
	    <p class="mb-4" style = "margin-left: 15px;"></p>
		<div class="col-lg-10" align = "center" style = "margin:auto;">
		  	<div class="card shadow mb-4">
				<div class="card-header py-3">
				    <h5 class="m-0 font-weight-bold text-primary">가격 정하기 (<%= brand %> <%= model %>)</h5>
				</div>
				
				<div class="card-body">
					<form action = "image_updateProc.jsp" method = "post" enctype = "multipart/form-data">
					<input type = "hidden" name = "brand" value = "<%= brand%>">
					<input type = "hidden" name = "model" value = "<%= model%>">
					<div class = "form-row" style = "margin-bottom: 20px;">
						<div class = "col-md-6">사진 1 (수정)</div>
						<div class = "col-md-6">사진 2 (수정)</div>
					<div class = "form-row" style = "margin: 30px 0px;">
				<div class = "form-group col-md-3">
					<img src = "<%= request.getContextPath()%>/images/<%= pimage%>" width = "100">						
					<input type="text" name="pimageold" value="<%= pimage%>" readonly>
				</div>
				<div class="form-group col-md-3">
						<label><span style = "font-size: 10px;"><br>가능하면 앞/뒤 사진 올려주세요</span></label>
						<input type = "file" id = "file1" class="form-control-file form-control-user" name = "pimage">
				</div>
				<div class = "form-group col-md-3">
					<img src = "<%= request.getContextPath()%>/images/<%= pimage2 %>" width = "100">						
					<input type="text" name="pimageold2" value="<%=pimage2%>" readonly>
				</div>			
				<div class="form-group col-md-3">
						<label><span style = "font-size: 10px;"><br>가능하면 여러 색상 보여주는 사진 올려주세요</span></label>
						<input type = "file" id = "file2" class="form-control-file form-control-user" name = "pimage2">
				</div>
			</div>
				<div class = "col-sm-6 mb-3 mb-sm-0">
		    		<input type="submit" class="form-control form-control-user" value= "사진 수정" onClick = "return photoCheck()">
				</div>
				<div class = "col-sm-6">
					<input type="button" class="form-control form-control-user" value="취소" onClick = "history.go(-1)">
				</div>
			</div>
					</form>
				</div>	
			</div>
		</div>
<%@ include file = "main_bottom.jsp"%>