<%@page import="myPkg.ProductsDao"%>
<%@page import="java.io.File"%>
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
	String pimageold = mr.getParameter("pimageold");
	String pimage = mr.getFilesystemName("pimage");
	String img = null;
	if(pimageold == null){
		if(pimage != null){
			img = pimage;
		}
	} else if(pimageold != null){
		if(pimage == null){
			img = pimageold;
		} else {
			img = pimage;
			File delFile = new File(configFolder, pimageold);
			delFile.delete();
		} 
	}
	int cnt = pdao.updateImage(img, mr.getParameter("brand"), mr.getParameter("model"));
	String pimageold2 = mr.getParameter("pimageold2");
	String pimage2 = mr.getFilesystemName("pimage2");
	String img2 = null;
	if(pimageold2 == null){
		if(pimage2 != null){
			img2 = pimage2;
		}
	} else if(pimageold2 != null){
		if(pimage2 == null){
			img2 = pimageold2;
		} else {
			img2 = pimage2;
			File delFile2 = new File(configFolder, pimageold2);
			delFile2.delete();
		} 
	}
	cnt += pdao.updateImage2(img2, mr.getParameter("brand"), mr.getParameter("model"));
	if(cnt > 0){ 
		%>
			<script type = "text/javascript">
				alert("사진 수정됬습니다");
				location.href = "prod_list.jsp";
			</script>
		<%
	} else {
		%>
		<script type = "text/javascript">
			alert("사진수정 실패했습니다");
			location.href = "prod_list.jsp";
		</script>
	<%
	}
%>