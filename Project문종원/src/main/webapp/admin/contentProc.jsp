<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.ProductsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String model = request.getParameter("model");
	String brand = request.getParameter("brand");
	String color = request.getParameter("color");
	String storage = request.getParameter("storage");
	String cond = request.getParameter("cond");
	ProductsBean pb = new ProductsBean();
	pb.setModel(model);
	pb.setBrand(brand);
	pb.setColor(color);
	pb.setStorage(storage);
	pb.setCond(cond);
	ProductsDao pdao = ProductsDao.getInstance();
	int pnum = pdao.findPnum(pb);
	ProductsBean pb2 = pdao.getProductByPnum(String.valueOf(pnum));
%>
<script>
	location.href = "content.jsp?model=<%=pb.getModel()%>&brand=<%=pb.getBrand()%>&pimage=<%= pb2.getPimage()%>&pimage2=<%= pb2.getPimage2()%>&pnum=<%= pnum%>";
</script>