<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	System.out.println(brand + " " + model);
	String[] price = request.getParameterValues("price");
	ProductsDao pdao = ProductsDao.getInstance();
	ArrayList<String> list = pdao.getStorages(brand, model);
	int cnt = pdao.setPrice(price, list, brand, model);
	if(cnt > -1){
	%>
		<script type = "text/javascript">
			alert("가격 등록 됬습니다");
			location.href = "main.jsp";
		</script>
		
	<%
	} else {
		%>
		<script type = "text/javascript">
			alert("가격 등록 실패했습니다");
			location.href = "price_insertForm.jsp?brand=" + "<%= brand %>" + "&model=" + "<%= model %>";
		</script>
		
	<%
	}
%>