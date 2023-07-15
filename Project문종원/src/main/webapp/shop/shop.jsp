<%@page import="myPkg.ReviewDao"%>
<%@page import="myPkg.WishDao"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<title>GoPhone || Shop</title>
<%
	ProductsDao pdao = ProductsDao.getInstance();
	int count = pdao.getCount();
	WishDao wdao = WishDao.getInstance();
	String color = request.getParameter("color");
	String brand = request.getParameter("brand");
	String order = request.getParameter("order");
	String pdesc = request.getParameter("pdesc");
	ArrayList<ProductsBean> products = null;
	
	
	String imgPath = request.getContextPath() + "/images/";
	DecimalFormat df = new DecimalFormat("###,###");
	ReviewDao rdao = ReviewDao.getInstance();
	int pageSize = 12;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int pageCount = count / pageSize + (count % pageSize == 0?0 : 1);
	int pageBlock = 3;
	int startPage = ((currentPage - 1)/ pageBlock * pageBlock) + 1;
	int endPage = startPage + pageBlock - 1;
	int startRow = (currentPage-1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	if(pageCount < endPage){
		endPage = pageCount;
	}
	if(color != null){
		if(brand == null){
			products = pdao.getBrandModelsByColor(color);
		} else if(brand != null){
			products = pdao.getBrandModelsByColorAndBrand(color, brand);
		}
	} else if(color == null){
		if(brand != null){
			products = pdao.getBrandModelsByBrand(brand);
		} else {
			if(pdesc != null){
				products = pdao.getBrandModelsByPdesc(pdesc);
			} else {
				if(order == null){
					products = pdao.getBrandModels(startRow, endRow);
				} else if (order.equals("priceAsc")){
					products = pdao.getBrandModelsMinPriceAsc(startRow, endRow);
				} else if (order.equals("priceDesc")){
					products = pdao.getBrandModelsMaxPriceDesc(startRow, endRow);
				} else if(order.equals("modelName")){
					products = pdao.getBrandModelsNameAsc(startRow, endRow);
				}
			}
		}
	}
	
%>
<script type = "text/javascript">
	function orderCheck(){
		var order = $('select[name=orderBy] option:selected').val();
		if(order != ""){
			location.href = "shop.jsp?order=" + order;
		}

	}
</script>
<%@ include file = "./../header.jsp"%>
        <!-- Start page content -->
        <div id="page-content" class="page-wrapper section">
            <!-- SHOP SECTION START -->
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
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
                                    <!-- sort-by -->
                                    <div class="short-by f-right text-end">
                                        <span>상품 순서 :</span>
                                        <select class = "orderProd" name = "orderBy" onChange = "orderCheck()">
                                            <option value="">선택</option>
                                            <option value="priceAsc" <%if(order != null && order.equals("priceAsc")){ %> selected <%} %>>낮은 가격순</option>
                                            <option value="priceDesc" <%if(order != null && order.equals("priceDesc")){ %> selected <%} %>>높은 가격순</option>
                                            <option value="modelName" <%if(order != null && order.equals("modelName")){ %> selected <%} %>>상품명</option>
                                        </select>
                                    </div> 
                                </div>
                                <!-- shop-option end -->
                                <!-- Tab Content start -->
                                <div class="tab-content">
                                    <!-- grid-view -->
                                    <div id="grid-view" class="tab-pane active show" role="tabpanel">
                                        <div class="row">
                                            <!-- product-item start -->
                                            <% for(ProductsBean pb : products){
                                            	ArrayList<String> colorList = pdao.getColors(pb.getBrand(), pb.getModel());
                                            	int revCount = rdao.getReviewCountBrandModel(pb.getBrand(), pb.getModel());
                                            %>
                                            <div class="col-lg-4 col-md-6">
                                                <div class="product-item">
                                                    <div class="product-img">
                                                        <a href="single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>">
                                                            <img src="<%= imgPath %><%= pb.getPimage() %>" alt="사진 없습니다." style = "height : 300px !important"/>
                                                        </a>
                                                    </div>
                                                    <div class="product-info">
                                                        <h4 class="product-title">
                                                            <a href="single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>"><%= pb.getBrand() %> <%= pb.getModel() %></a>
                                                        </h4>
                                                        <h5 class="pro-price"><%= df.format(pb.getMinPrice()) %>원 ~ <%= df.format(pb.getMaxPrice()) %>원</h5>
                                                        <h6 class="pro-price">리뷰 수 : <%= df.format(revCount) %>건</h6>
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
                                    <div id="list-view" class="tab-pane" role="tabpanel">
                                        <div class="row">
                                        <% for(ProductsBean pb : products){ 
                                            	ArrayList<String> colorList = pdao.getColors(pb.getBrand(), pb.getModel());
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
                                <% if(order != null || (brand == null && color == null && pdesc == null)){%>
                                <!-- shop-pagination start -->
                                <div  class = "row" style = "margin-top: 200px;">
                                <ul class="shop-pagination box-shadow text-center ptblr-10-30">
                                    <li><a href="shop.jsp?pageNum=<%= startPage - 3%><%if(order != null){ %>&order=<%= order %><%}%>"><i class="zmdi zmdi-chevron-left"></i></a></li>
                                    <%for(int j = startPage; j <= endPage; j++){ %>
                                    <li><a href = "shop.jsp?pageNum=<%= j %><%if(order != null){ %>&order=<%= order %><%}%>"><%= j %></a></li>
                                    <%} %>
                                    <li><a href="shop.jsp?pageNum=<%= endPage + 1%><%if(order != null){ %>&order=<%= order %><%}%>"><i class="zmdi zmdi-chevron-right"></i></a></li>
                                </ul>
                                </div>
                                <% } %>
                                <!-- shop-pagination end -->
                            </div>
                        </div>
                        <div class="col-lg-3 order-lg-1 order-2">
                            <!-- widget-categories -->
                            <aside class="widget widget-categories box-shadow mb-30">
                                <h6 class="widget-title border-left mb-20">브랜드</h6>
                                <div id="cat-treeview" class="product-cat">
                                    <ul>
                                        <li class="closed"><a href="shop.jsp" <%if(brand == null){ %>style = "border-bottom:2px solid #8041D9"<%}%>>모든 브랜드</a>
                                        <li class="closed"><a href="shop.jsp?brand=삼성<% if(color!=null){%>&color=<%=color%><%}%>" <%if(brand != null && brand.equals("삼성")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>삼성</a>
                                        <li class="closed"><a href="shop.jsp?brand=애플<% if(color!=null){%>&color=<%=color%><%}%>" <%if(brand != null && brand.equals("애플")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>애플</a>
                                        <li class="closed"><a href="shop.jsp?brand=LG<% if(color!=null){%>&color=<%=color%><%}%>" <%if(brand != null && brand.equals("LG")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>LG</a>
                                    </ul>
                                </div>
                            </aside>
                            <!-- shop-filter -->
                            <%
                            String[] allColors = {"", "Black", "White", "Gray", "Red", "Pink", "Blue", "Light-Blue", "Green", "Light-Green", "Yellow", "Orange", "Purple", "Gold", "Silver","Teal"};
                            
                            %>
                            <!-- widget-color -->
                            <aside class="widget widget-color box-shadow mb-30">
                                <h6 class="widget-title border-left mb-20">색상</h6>
                                <ul>
                                	<%for(int i = 1; i <= allColors.length -1; i++ ){ %>
                                    <li class="color-<%=i %>"><a href="shop.jsp?color=<%=allColors[i] %><% if(brand!=null){%>&brand=<%=brand%><%}%>" <%if(color != null && color.equals(allColors[i])){ %>style = "border-bottom:2px solid #8041D9"<%}%>><%= allColors[i] %></a></li>
                                    <%} %>
                                </ul>
                            </aside>
                            
                            <aside class="widget widget-categories box-shadow mb-30">
                                <h6 class="widget-title border-left mb-20">램 크기</h6>
                                <div id="cat-treeview" class="product-cat">
                                    <ul>
                                        <li class="closed"><a href="shop.jsp?pdesc=18GB"<%if(pdesc != null && pdesc.equals("18GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>18GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=16GB"<%if(pdesc != null && pdesc.equals("16GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>16GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=12GB"<%if(pdesc != null && pdesc.equals("12GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>12GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=8GB"<%if(pdesc != null && pdesc.equals("8GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>8GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=6GB"<%if(pdesc != null && pdesc.equals("6GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>6GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=4GB"<%if(pdesc != null && pdesc.equals("4GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>4GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=3GB"<%if(pdesc != null && pdesc.equals("3GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>3GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=2GB"<%if(pdesc != null && pdesc.equals("2GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>2GB</a>
                                        <li class="closed"><a href="shop.jsp?pdesc=1GB"<%if(pdesc != null && pdesc.equals("1GB")){ %>style = "border-bottom:2px solid #8041D9"<%}%>>1GB</a>
                                    </ul>
                                </div>
                            </aside>
                        </div>
                    </div>
                </div>
            </div>
            <!-- SHOP SECTION END -->             

        </div>
        <!-- End page content -->

<%@ include file = "./../footer.jsp"%>
    