<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	ProductsDao pdao = ProductsDao.getInstance();
	int cnt = pdao.deleteProducts(brand, model);
	if(cnt > 0){
		%>
		<script>
			alert("삭제 되었습니다");
			location.href = "prod_list.jsp";
		</script>
		<%
	}
%>