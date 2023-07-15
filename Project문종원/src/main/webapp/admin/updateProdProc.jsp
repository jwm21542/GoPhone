<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.File"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductsDao pdao = ProductsDao.getInstance();
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	String networkValue = "";
	String[] network = request.getParameterValues("network");
	for(int i = 0; i < network.length; i++){
		networkValue += network[i] + " ";
	}
	String[] security = request.getParameterValues("security");
	String securityValue = "";
	for(int i = 0; i < security.length; i++){
		securityValue += security[i] + " ";
	}
	int releasePrice = Integer.parseInt(request.getParameter("releasePrice"));
	DecimalFormat df = new DecimalFormat("###,###");
	String relPrice = df.format(releasePrice) + "원";
	String pdesc = request.getParameter("osList") + "/" + request.getParameter("releaseDate") + "/" + relPrice +
			"/" + request.getParameter("screenSize") + "/" + request.getParameter("cpuList") + "/" + request.getParameter("ram") + "/" + networkValue
			+ "/" + securityValue;
	int cnt = pdao.updateProdInfo(brand, model, pdesc);
	
	if(cnt > -1){
		%>
		<script type = "text/javascript">
			alert("수정 되었습니다.");
		</script>
		<%
	}
%>
<script type = "text/javascript">
	location.href = "prod_list.jsp";
</script>