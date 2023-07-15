<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.WishBean"%>
<%@page import="myPkg.WishDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone || 찜목록</title>
<%@ include file = "./../header.jsp" %>
<%@ include file = "./../headerBanner.jsp"%>
<%
	WishDao wdao = WishDao.getInstance();
	ArrayList<WishBean> wlist = wdao.getWish(sno);
	ProductsDao pdao = ProductsDao.getInstance();
	
%>
<div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-home"></i>홈 페이지</a></li>
                                <li><i class="zmdi zmdi-favorite">찜 상품 목록</i></li>
                            </ol>
                        </div>
                    </div>
                </div>
</div>	
            
  <!-- Start page content -->
    <section id="page-content" class="page-wrapper section">
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- Tab panes -->
                                <!-- shopping-cart start -->
                                        <div class="message-box box-shadow white-bg">
                                
                                            <div class="table-content table-responsive mb-50">
                                                <table class="text-center">
                                                    <thead>
                                                        <tr>
                                                            <th class="product-thumbnail" style = "width:50%">상품</th>
                                                            <th class="product-thumbnail" style = "width:30%">상품정보</th>
                                                            <th class="product-price" style = "width:20%;">찜 삭제</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%for(WishBean  wb : wlist){ 
                                                        String[] pdTitles = {"운영체제", "출고일", "출고가", "화면크기", "CPU/프로세서", "램", "네트워크" , "보안기능"};

                                                    	String brand = wb.getBrand();
                                                    	String model = wb.getModel();
                                                    	ArrayList<String> colorList = pdao.getColors(brand, model);
                                                    	String colors = "";
                                                    	for(String color : colorList){
                                                    		colors += color + "/";
                                                    	}
                                                    	colors = colors.substring(0, colors.length()-1);
                                                    	ArrayList<String> storageList = pdao.getStorages(brand, model);
                                                    	String storages = "";
                                                    	for(String storage : storageList){
                                                    		storages += storage + "/";
                                                    	}
                                                    	String pdesc = pdao.getItemDesc(brand, model);
                                                        String[] pdList = pdesc.split("/");
                                                    	storages = storages.substring(0, storages.length()-1);
                                                    	ArrayList<String> imgList = pdao.getImage(brand, model);
                                                    %>
	                                                        <tr>
	                                                        	<td class="product-thumbnail">
	                                                                <div class="pro-thumbnail-img">
	                                                                    <img src="<%= conPath %>/images/<%=imgList.get(0) %>" alt="">
	                                                                </div>
	                                                                <div class="pro-thumbnail-info text-start">
	                                                                    <h6 class="product-title-2" style = "color : #8041D9;">
	                                                                        <a href="singleProduct.jsp?brand=<%= wb.getBrand()%>&model=<%= wb.getModel() %>"><%= wb.getBrand() %> <%= wb.getModel() %></a>
	                                                                    </h6>
	                                                                    <p>용량: <%= storages %></p>
	                                                                    <p>색상: <%= colors %></p>
	                                                                </div>
	                                                            <td>
	                                                            <%for(int i = 0; i < pdList.length; i++){ %>    
	                                                            	<p><%= pdTitles[i] %> : <%= pdList[i] %> </p>
	                                                            <%} %>
	                                                            </td>
	                                                        	<td>
	                                                        		<a href = "wishRemoveProc.jsp?brand=<%= brand %>&model=<%= model %>">삭제</a>
	                                                        	</td>
	                                                        </tr>
	                                                <%} %>
                                                    </tbody>
                                                </table>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                                <!-- shopping-cart end -->
                            </div>
                        </div>
            <!-- SHOP SECTION END -->             
        </section>
<%@ include file = "./../footer.jsp"%>
    