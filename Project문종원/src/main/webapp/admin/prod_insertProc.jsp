<%@page import="myPkg.ProductsDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	int cnt = pdao.insertProduct(mr);
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("등록 되었습니다.");
		</script>
		<%
	}
%>
<script type = "text/javascript">
	location.href = "price_insertForm.jsp?brand=" + "<%= mr.getParameter("brand") %>" + "&model=" + "<%= mr.getParameter("model") %>";
</script>