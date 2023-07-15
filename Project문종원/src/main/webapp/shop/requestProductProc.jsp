<%@page import="myPkg.RequestDao"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String configFolder = config.getServletContext().getRealPath("/images/");
	int maxSize = 1024*1024*5;
	String encoding = "UTF-8";
	MultipartRequest mr = new MultipartRequest(
			request,
			configFolder,
			maxSize, 
			encoding);
	ProductsDao pdao = ProductsDao.getInstance();
	String brand = mr.getParameter("brand");
	String model = mr.getParameter("model");
	String color = mr.getParameter("color");
	String storage = mr.getParameter("storage");
	String cond = mr.getParameter("cond");
	String memno = mr.getParameter("memno");
	ProductsBean pb = new ProductsBean();
	pb.setBrand(brand);
	pb.setModel(model);
	pb.setColor(color);
	pb.setStorage(storage);
	pb.setCond(cond);
	int pnum = pdao.findPnum(pb);
	RequestDao rdao = RequestDao.getInstance();
	int cnt = rdao.insertRequest(mr, pnum, Integer.parseInt(memno));
	if(cnt > -1){
		%>
			<script type = "text/javascript">
				alert("신청 등록 됬습니다");
				location.href = "<%= request.getContextPath() %>/main.jsp"
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("신청 실패했습니다");
			history.go(-1);
		</script>
	<%
	}
%>