<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String storage = request.getParameter("storage");
	String color = request.getParameter("color");
	String cond = request.getParameter("cond");
	String pmodel = request.getParameter("model");
	String pbrand = request.getParameter("brand");
	String pqty = request.getParameter("pqty");
	ProductsBean pb = new ProductsBean();
	pb.setStorage(storage);
	pb.setColor(color);
	pb.setCond(cond);
	pb.setModel(pmodel);
	pb.setBrand(pbrand);
	
	ProductsDao pdao = ProductsDao.getInstance();
	int price = pdao.getPrice(pbrand, pmodel, storage, cond);
	int totalPrice = price * Integer.parseInt(pqty);
	int pnum = pdao.findPnum(pb);
	ProductsBean pb2 = pdao.getProductByPnum(String.valueOf(pnum));
	int sqty = pb2.getSqty();
%>
<script type = "text/javascript">
	location.href = "single_Product.jsp?storage=" + "<%=storage%>" + "&cond=" + "<%=cond%>"
	+ "&model=" + "<%=pmodel%>" + "&brand=" + "<%=pbrand%>" + "&pqty=" + "<%=pqty%>" + "&price=" + "<%=totalPrice %>" + "&color=" + "<%= color %>" + "&sqty=" + "<%= sqty %>";
</script>
	