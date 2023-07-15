<%@page import="myPkg.WishDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <title>GoPhone || 검색결과</title>
    
<%
	String searchPhrase = request.getParameter("searchPhrase");
	searchPhrase = searchPhrase.toLowerCase();
	ArrayList<ProductsBean> resultList = new ArrayList<ProductsBean>();
	ProductsDao pdao = ProductsDao.getInstance();
	ArrayList<ProductsBean> pList = pdao.getBrandModels();
	for(ProductsBean pb : pList){
		boolean flag = false;
		ArrayList<String> colorList = pdao.getColors(pb.getBrand(), pb.getModel());
		ArrayList<String> storageList=  pdao.getStorages(pb.getBrand(), pb.getModel());
		String brand = pb.getBrand().toLowerCase();
		String model = pb.getModel().toLowerCase();
		if(searchPhrase.contains(brand) || searchPhrase.contains(model)){
			resultList.add(pb);
			continue;
		}
		for(String color : colorList){
			color = color.toLowerCase();
			if(searchPhrase.contains(color)){
				resultList.add(pb);
				flag = true;
				break;
			}
		}
		if(flag == true){
			continue;
		}
		for(String storage : storageList){
			storage = storage.toLowerCase();
			if(searchPhrase.contains(storage)){
				resultList.add(pb);
				flag = true;
				break;
			}
		}
		if(flag == true){
			continue;
		}
		String pdesc = pdao.getItemDesc(pb.getBrand(), pb.getModel());
		pdesc = pdesc.toLowerCase();
		String[] itemDesc = pdesc.split("[/ ]"); 
		for(String desc : itemDesc){
			if(desc != ""){
				if(searchPhrase.contains(desc)){
					resultList.add(pb);
					break;
				}
			}
		}
	}
	String imgPath = request.getContextPath() + "/images/";
	DecimalFormat df = new DecimalFormat("###,###");
	int pageSize = 12;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int count = resultList.size();
	int pageCount = count / pageSize + (count % pageSize == 0?0 : 1);
	int pageBlock = 3;
	int startPage = ((currentPage - 1)/ pageBlock * pageBlock) + 1;
	int endPage = startPage + pageBlock - 1;
	if(pageCount < endPage){
		endPage = pageCount;
	}
	WishDao wdao = WishDao.getInstance();
%>
<%@ include file = "./../header.jsp"%>
<%@ include file = "./../headerBanner.jsp"%>
		 <div class="breadcrumbs-section mb-80 section">
		                <div class="container">
		                    <div class="row">
		                        <div class="col-lg-12">
		                            <ol class="breadcrumb p-30">
		                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-shield-home"></i>홈 페이지</a></li>
		                                <li><%if(sid == null){ %>
		                                        <a href="<%= conPath%>/login.jsp">
		                                            <i class="zmdi zmdi-account"></i>
		                                            로그인/회원가입
		                                        </a>
		                                    <%} else if(!sid.equals("admin")){%>
												<a href="<%= conPath%>/member/myaccount.jsp">
		                                            <i class="zmdi zmdi-account"></i>
		                                            <%= mb.getName() %>님
		                                        </a>
		                                    <%} else {%>
		                                           
		                                    <%} %></li>
		                                 <li> <i class="zmdi zmdi-search"></i>
		                                            <mark>검색 결과: "<%= searchPhrase %>"</mark>
										 </li>
		                            </ol>
		                        </div>
		                    </div>
		                </div>
		            </div>
		 <!-- Start page content -->
        <div id="page-content" class="page-wrapper section">

            <!-- SHOP SECTION START -->
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row" style = "justify-content: center;">
                        <div class="col-lg-9 order-lg-2 order-1">
                            <div class="shop-content">
                                <!-- shop-option start -->
                                <div class="shop-option box-shadow mb-30 clearfix">
                                    <!-- Nav tabs -->
                                    <ul class="nav shop-tab f-left" role="tablist">
                                        <li>
                                            <a class="active" href="#grid-view" data-bs-toggle="tab"><i class="zmdi zmdi-view-module"></i></a>
                                        </li>
                                        <li>
                                            <a href="#list-view" data-bs-toggle="tab"><i class="zmdi zmdi-view-list-alt"></i></a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- shop-option end -->
                                <!-- Tab Content start -->
                                <div class="tab-content">
                                    <!-- grid-view -->
                                    <div id="grid-view" class="tab-pane active show" role="tabpanel">
                                        <div class="row">
                                            <!-- product-item start -->
                                            <% for(ProductsBean pb : resultList){ 
                                            	ArrayList<String> colorList = pdao.getModelColors(pb.getModel());
                                            %>
                                            <div class="col-lg-4 col-md-6">
                                                <div class="product-item">
                                                    <div class="product-img">
                                                        <a href="single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>">
                                                            <img src="<%= imgPath %><%= pb.getPimage() %>" alt="사진 없습니다." style = "height : 300px !important"/>
                                                        </a>
                                                    </div>
                                                    <div class="product-info">
                                                        <h6 class="product-title">
                                                            <a href="single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>"><%= pb.getBrand() %> <%= pb.getModel() %></a>
                                                        </h6>
                                                        <h3 class="pro-price"><%= df.format(pb.getMinPrice()) %>원 ~ <%= df.format(pb.getMaxPrice()) %>원</h3>
                                                         <div class="widget-color widget-categories box-shadow mb-30">
                                                        	<ul style = "display: flex; justify-content:space-evenly;">
                                                        	<%for(int i = 0; i < colorList.size(); i++){ %>
                                                        		<li class = "color-<%if(colorList.get(i).equals("Black")){%>1<%}
                                                        		else if(colorList.get(i).equals("White")){%>2<%}
                                                        		else if(colorList.get(i).equals("Gray")){%>3<%}
                                                        		else if(colorList.get(i).equals("Red")){%>4<%}
                                                        		else if(colorList.get(i).equals("Pink")){%>5<%}
                                                        		else if(colorList.get(i).equals("Blue")){%>6<%}
                                                        		else if(colorList.get(i).equals("Light-Blue")){%>7<%}
                                                        		else if(colorList.get(i).equals("Green")){%>8<%}
                                                        		else if(colorList.get(i).equals("Light-Green")){%>9<%}
                                                        		else if(colorList.get(i).equals("Yellow")){%>10<%}
                                                        		else if(colorList.get(i).equals("Orange")){%>11<%}
                                                        		else if(colorList.get(i).equals("Purple")){%>12<%}
                                                        		else if(colorList.get(i).equals("Gold")){%>13<%}
                                                        		else if(colorList.get(i).equals("Silver")){%>14<%}
                                                        		else if(colorList.get(i).equals("Teal")){%>15<%}%>" style = "margin-right: 9px;"></li>
                                                        	<% } %>
                                                        </ul>
                                                        </div>
                                                        <ul class="action-button">
                                                            <li>
                                                                <a href="#" title="Wishlist"><i class="zmdi zmdi-favorite"></i></a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <%} %>
                                            <!-- product-item end -->
                                        </div>                                        
                                    </div>
                                    <div id="list-view" class="tab-pane" role="tabpanel">
                                        <div class="row">
                                        <% for(ProductsBean pb : resultList){ 
                                            	ArrayList<String> colorList = pdao.getModelColors(pb.getModel());
                                         %>
                                            <!-- product-item start -->
                                            <div class="col-lg-12">
                                                <div class="shop-list product-item" >
                                                    <div class="product-img">
                                                        <a style = "font-weight: strong; font-size:large;"href="single-product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>">
                                                            <img src="<%= imgPath %><%= pb.getPimage() %>" alt="사진 없습니다." style = "height : 300px !important"/>
                                                        </a>
                                                    </div>
                                                    <div class="product-info" style = "display:flex; flex-direction: column; justify-content: space-evenly; height : 300px">
                                                        <div class="clearfix">
                                                            <h6 class="product-title f-left">
                                                           	 	<a href="single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>" style = "font-size: 26px;"><%= pb.getBrand() %> <%= pb.getModel() %></a>
                                                            </h6>
                                                        </div>
                                                        <h3 class="pro-price"><%= df.format(pb.getMinPrice()) %>원 ~ <%= df.format(pb.getMaxPrice()) %>원</h3>
                                                        <div class="widget-color widget-categories box-shadow mb-30">
                                                        	<ul style = "display: flex; justify-content:space-evenly;">
                                                        	<%for(int i = 0; i < colorList.size(); i++){ %>
                                                        		<li class = "color-<%if(colorList.get(i).equals("Black")){%>1<%}
                                                        		else if(colorList.get(i).equals("White")){%>2<%}
                                                        		else if(colorList.get(i).equals("Gray")){%>3<%}
                                                        		else if(colorList.get(i).equals("Red")){%>4<%}
                                                        		else if(colorList.get(i).equals("Pink")){%>5<%}
                                                        		else if(colorList.get(i).equals("Blue")){%>6<%}
                                                        		else if(colorList.get(i).equals("Light-Blue")){%>7<%}
                                                        		else if(colorList.get(i).equals("Green")){%>8<%}
                                                        		else if(colorList.get(i).equals("Light-Green")){%>9<%}
                                                        		else if(colorList.get(i).equals("Yellow")){%>10<%}
                                                        		else if(colorList.get(i).equals("Orange")){%>11<%}
                                                        		else if(colorList.get(i).equals("Purple")){%>12<%}
                                                        		else if(colorList.get(i).equals("Gold")){%>13<%}
                                                        		else if(colorList.get(i).equals("Silver")){%>14<%}
                                                        		else if(colorList.get(i).equals("Teal")){%>15<%}%>" style = "margin-right: 9px;"></li>
                                                        	<% } %>
                                                        </ul>
                                                        </div>
                                                        <ul class="action-button">
                                                            <%if(sid != null){
                                                        		if(!wdao.wishContains(pb.getBrand(), pb.getModel(), sno)){
                                                        		%>
                                                        			<li>
                                                                    <a href="wishProc.jsp?brand=<%= pb.getBrand() %>&model=<%= pb.getModel()%>" title="Wishlist">
                                                                    <i class="zmdi zmdi-favorite"></i></a>
                                                                	</li>
                                                        	<%} else if(wdao.wishContains(pb.getBrand(), pb.getModel(), sno)){%>
                                                            		<li>
                                                                    <a href="wishRemoveProc.jsp?brand=<%= pb.getBrand() %>&model=<%= pb.getModel()%>" title="찜된 상품" style = "background-color: #8041D9;">
                                                                    <i class="zmdi zmdi-favorite"></i></a>
                                                                	</li>
                                                            <%}} %>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <%} %>
                                            <!-- product-item end -->
                                            </div>
                                            </div>
                                            
                                </div>
                                <!-- Tab Content end -->
                                <!-- shop-pagination start -->
                                <div  class = "row" style = "margin-top: 200px;">
                                <ul class="shop-pagination box-shadow text-center ptblr-10-30">
                                    <li><a href="shop.jsp?pageNum=<%= startPage - 3%>"><i class="zmdi zmdi-chevron-left"></i></a></li>
                                    <%for(int j = startPage; j <= endPage; j++){ %>
                                    <li><a href = "shop.jsp?pageNum=<%= j %>"><%= j %></a></li>
                                    <%} %>
                                    <li class="active"><a href="shop.jsp?pageNum=<%= endPage + 1%>"><i class="zmdi zmdi-chevron-right"></i></a></li>
                                </ul>
                                </div>
                                <!-- shop-pagination end -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- SHOP SECTION END -->             

        </div>
        <!-- End page content -->

<%@ include file = "./../footer.jsp"%>
