<%@page import="myPkg.WishDao"%>
<%@page import="myPkg.ReviewDao"%>
<%@page import="myPkg.ProductsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone</title>
<%@ include file = "header.jsp" %>
<% 
	ProductsDao pdao = ProductsDao.getInstance();
	ArrayList<ProductsBean> randList = pdao.getRandomBrandModels();
	String imgPath = request.getContextPath() + "/images/";
	DecimalFormat df = new DecimalFormat("###,###");
	ReviewDao rdao = ReviewDao.getInstance();
	WishDao wdao = WishDao.getInstance();
%>
<%@ include file = "headerBanner.jsp" %>
 <section id="page-content" class="page-wrapper section">

            <!-- FEATURED PRODUCT SECTION START -->
            <div class="video-section mb-80" style = "margin-top: 50px;">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-title text-center mb-40">
                                <h2 class="uppercase">요즘 트렌드는 중고폰!</h2>
                                <h6>중고폰에 대한 잘 모르시면 이런 영상들 한번 보세요</h6>
                            </div>
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-md-6">
                            <div class="single-video">
                                <h3 class="sc-sub-title"></h3>
                                <div class="embed-responsive ratio ratio-16x9">
                                    <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/8rEy3O09cB4?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="single-video">
                                <h3 class="sc-sub-title"></h3>
                                <div class="embed-responsive ratio ratio-16x9">
                                    <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/0wuwT6LKyxA?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                    </div>       
                </div>            
            </div>
   <!-- FEATURED PRODUCT SECTION START -->
            <div class="featured-product-section mb-50">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-title text-start mb-40">
                                <h2 class="uppercase">인기 상품들</h2>
                            </div>
                            <div class="featured-product">
                                <div class="active-featured-product slick-arrow-2">
                                <%for(ProductsBean pb : randList){ 
                                  					ArrayList<String> colorList = pdao.getColors(pb.getBrand(), pb.getModel());
                                            		int revCount = rdao.getReviewCountBrandModel(pb.getBrand(), pb.getModel());
                                            %>
                                            <div class="col-lg-4 col-md-6">
                                                <div class="product-item">
                                                    <div class="product-img">
                                                        <a href="./shop/single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>">
                                                            <img src="<%= imgPath %><%= pb.getPimage() %>" alt="사진 없습니다." style = "height : 300px !important"/>
                                                        </a>
                                                    </div>
                                                    <div class="product-info">
                                                        <h4 class="product-title">
                                                            <a href="./shop/single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel() %>"><%= pb.getBrand() %> <%= pb.getModel() %></a>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="theme-section theme-bg ptb-50 mtb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 text-start">
                            <div class="action-box">
                                <h3 class="text-white  text-uppercase">상품 더 보기</h3>
                                <p class="text-white">아니면 스마트폰을 판매 하고 싶나요?</p>
                            </div>
                        </div>
                        <div class="col-lg-4 text-end action-box-button">
                            <a class="button button-white mt-15" href="./shop/shop.jsp">
                                <span>상품 목록</span>
                            </a>
                            <a class="button button-black mt-15" href="./shop/requestProduct.jsp">
                                <span>판매 신청하기</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
</section>
            <!-- FEATURED PRODUCT SECTION END -->
<%@ include file = "footer.jsp" %>
