<%@page import="myPkg.WishDao"%>
<%@page import="myPkg.ReviewBean"%>
<%@page import="myPkg.ReviewDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String brand = request.getParameter("brand");
	String model = request.getParameter("model");
	ProductsDao pdao = ProductsDao.getInstance();
	WishDao wdao = WishDao.getInstance();
	ArrayList<String> colorList = pdao.getColors(brand, model);
	ArrayList<String> storageList = pdao.getStorages(brand, model);
	ArrayList<String> imageList = pdao.getImage(brand, model);
	String[] conds = {"S", "A", "B"};
	DecimalFormat df = new DecimalFormat("###,###");

	String price = request.getParameter("price");
	String color = request.getParameter("color");
	String cond = request.getParameter("cond");
	String storage = request.getParameter("storage");
	String pqty = request.getParameter("pqty");
    String pdesc = pdao.getItemDesc(brand, model);
    String[] pdList = pdesc.split("/");
    String[] pdTitles = {"운영체제", "출고일", "출고가", "화면크기", "CPU/프로세서", "램", "네트워크" , "보안기능"};
    String sqty = request.getParameter("sqty");
%>
<title>GoPhone || <%= brand %> <%= model %></title>
<script type = "text/javascript">
	var pqty = 0;
	function options(){
		var color = $('input[name=color]:checked').val();
		var storage = $('input[name=storage]:checked').val();
		var cond = $('input[name=conds]:checked').val();
		var pmodel = document.querySelector('input[name=model]').value;
		var pbrand = document.querySelector('input[name=brand]').value;
		var pqty = $('select[name=pqty] option').filter(':selected').val()

		var count = 0;
		var colorTest = document.getElementsByName("color");
		for(i =0; i < colorTest.length; i++){
			if(colorTest[i].checked){
				count++;
			}
		}
		var storageTest = document.getElementsByName("storage");
		for(i =0; i < storageTest.length; i++){
			if(storageTest[i].checked){
				count++;
			}
		}
		var condsTest = document.getElementsByName("conds");
		for(i =0; i < condsTest.length; i++){
			if(condsTest[i].checked){
				count++;
			}
		}
		if(count == 3 && pqty != ""){
 			location.href = "cartAddProc.jsp?color=" + color + "&storage=" + storage + "&cond=" + cond
 					+ "&model=" + pmodel + "&brand=" + pbrand + "&pqty=" + pqty + "&price=" + "<%= price %>" + "&sqty=" + "<%= sqty%>";
		} else{
			alert("색상, 용량, 등급 선택해주세요");
		}
	}
	
	function calculatePrice(){
		var color = $('input[name=color]:checked').val();
		var storage = $('input[name=storage]:checked').val();
		var cond = $('input[name=conds]:checked').val();
		var pmodel = document.querySelector('input[name=model]').value;
		var pbrand = document.querySelector('input[name=brand]').value;
		var pqty = $('select[name=pqty] option').filter(':selected').val()
		var count = 0;
		var colorTest = document.getElementsByName("color");
		for(i =0; i < colorTest.length; i++){
			if(colorTest[i].checked){
				count++;
			}
		}
		var storageTest = document.getElementsByName("storage");
		for(i =0; i < storageTest.length; i++){
			if(storageTest[i].checked){
				count++;
			}
		}
		var condsTest = document.getElementsByName("conds");
		for(i =0; i < condsTest.length; i++){
			if(condsTest[i].checked){
				count++;
			}
		}
		if(count == 3 && pqty != ""){
				location.href = "getTotalPrice.jsp?storage=" + storage + "&cond=" + cond
 					+ "&model=" + pmodel + "&brand=" + pbrand + "&pqty=" + pqty + "&color=" + color;
		}
	}
	function confirmDelete(){
		var delCheck = confirm("작성한 리뷰 삭제하시겠습니까?");
		if(delCheck){
			return true;
		} else {
			return false;
		}
	}
</script>
<%@ include file = "./../header.jsp"%>
<%
	String memName = "";
	if(sid != null){
		memName = mb.getName();
	}
%>
		   <div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-home"></i>홈 페이지</a></li>
                                <li><a href="<%= conPath %>/shop.jsp"><i class="zmdi zmdi-shopping-basket"></i>모든 상품 보기</a></li>
                                <li class="active"><%= brand %> <%= model %></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>	
        <!-- Start page content -->
        <section id="page-content" class="page-wrapper section">
        
            <!-- SHOP SECTION START -->
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- single-product-area start -->
                            <div class="single-product-area mb-80">
                                <div class="row">
                                    <!-- imgs-zoom-area start -->
                                    <div class="col-lg-5">
                                        <div class="imgs-zoom-area">
                                            <img id="zoom_03" src="<%= conPath %>/images/<%= imageList.get(0) %>" data-zoom-image="<%= conPath %>/images/<%= imageList.get(0) %>"
                                                alt="">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div id="gallery_01" class="carousel-btn slick-arrow-3 mt-30">
                                                        <div class="p-c">
                                                            <a href="#" data-image="<%= conPath %>/images/<%= imageList.get(0) %>"
                                                                data-zoom-image="<%= conPath %>/images/<%= imageList.get(0) %>">
                                                                <img class="zoom_03" src="<%= conPath %>/images/<%= imageList.get(0) %>" alt="">
                                                            </a>
                                                        </div>
                                                        <div class="p-c">
                                                            <a href="#" data-image="<%= conPath %>/images/<%= imageList.get(1) %>"
                                                                data-zoom-image="<%= conPath %>/images/<%= imageList.get(1) %>">
                                                                <img class="zoom_03" src="<%= conPath %>/images/<%= imageList.get(1) %>" alt="">
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- imgs-zoom-area end -->
                                    <!-- single-product-info start -->
                                    <div class="col-lg-7">
                                        <div class="single-product-info">
                                            <h3 class="text-black-1"><%= model %></h3>
                                            <h6 class="brand-name-2"><%= brand %></h6>
                                            <input type = "hidden" name = "model" value = "<%= model %>">
                                            <input type = "hidden" name = "brand" value = "<%= brand %>">
                                            <!--  hr -->
                                            <hr>
                                            <!-- single-pro-color-rating -->
                                            <div class="single-pro-color-rating clearfix">
                                                <div class="sin-pro-color f-left">
                                                    <p class="color-title f-left">색상</p>
                                                      <% for(int i = 0; i < colorList.size(); i++){ %>
                                                	<span style = "margin-right: 10px;"><input type = "radio" name = "color" value = "<%= colorList.get(i) %>" onClick = "calculatePrice()" <%if(color != null && colorList.get(i).equals(color)){%> checked <% } %>><%= colorList.get(i) %></span>
                                                <%} %>
                                                </div>
                                            </div>
                                            <!-- hr -->
                                            <hr>
                                                <div class="single-pro-color-rating clearfix">
                                                <div class="sin-pro-color f-left">
                                                    <p class="color-title f-left">용량</p>
                                                <% for(int i = 0; i < storageList.size(); i++){ %>
                                                	<span style = "margin-right: 10px;"><input type = "radio" name = "storage" value = "<%= storageList.get(i) %>" onClick = "calculatePrice()" <%if(storage != null && storageList.get(i).equals(storage)){%> checked <% } %>><%= storageList.get(i) %></span>
                                                <%} %>
                                                </div>
                                                </div>
                                                <hr>
                                                <div class="single-pro-color-rating clearfix">
                                                    <div class="sin-pro-color f-left">
                                                    	<p class="color-title f-left">등급</p>
                                                <% for(int i = 0; i < conds.length; i++){ %>
                                                	<span style = "margin-right: 10px;"><input type = "radio" name = "conds" value = "<%= conds[i]%>" onClick = "calculatePrice()" <%if(cond != null && conds[i].equals(cond)){%> checked <% } %>><%= conds[i] %></span>
                                                <%} %>
                                                </div>
                                                </div>
                                                <hr>
                                            <!-- plus-minus-pro-action -->
                                            <div class="single-pro-color-rating clearfix">
                                                <div class="sin-pro-color f-left">
                                                    <p class="color-title f-left">수량</p>
														<select name = "pqty" onChange = "calculatePrice()">
															<option value = "">선택</option>
															<option value = "1" <%if(pqty != null && pqty.equals("1")){%> selected <% } %>>1</option>
															<option value = "2" <%if(pqty != null && pqty.equals("2")){%> selected <% } %>>2</option>
															<option value = "3" <%if(pqty != null && pqty.equals("3")){%> selected <% } %>>3</option>
															<option value = "4" <%if(pqty != null && pqty.equals("4")){%> selected <% } %>>4</option>
															<option value = "5" <%if(pqty != null && pqty.equals("5")){%> selected <% } %>>5</option>
															<option value = "6" <%if(pqty != null && pqty.equals("6")){%> selected <% } %>>6</option>
															<option value = "7" <%if(pqty != null && pqty.equals("7")){%> selected <% } %>>7</option>
															<option value = "8" <%if(pqty != null && pqty.equals("8")){%> selected <% } %>>8</option>
															<option value = "9" <%if(pqty != null && pqty.equals("9")){%> selected <% } %>>9</option>
															<option value = "10" <%if(pqty != null && pqty.equals("10")){%> selected <% } %>>10</option>
														</select>
                                                </div>
                                                <div class = "sin-pro-action f-left" id = "stockqty" style = "color: black; margin-left:10px;">
                                                	<%if(sqty != null) { %>
                                                		재고수량 : <%= sqty %>개
                                                	<%} %>
                                                </div>
                                                <div class="sin-pro-action f-right">
                                                    <ul class="action-button">
                                                        <%if(sid != null){
                                                        		if(!wdao.wishContains(brand, model, sno)){
                                                        		%>
                                                        			<li>
                                                                    <a href="wishProc.jsp?brand=<%= brand %>&model=<%= model %>" title="Wishlist">
                                                                    <i class="zmdi zmdi-favorite"></i></a>
                                                                	</li>
                                                        	<%} else if(wdao.wishContains(brand, model, sno)){%>
                                                            		<li>
                                                                    <a href="wishRemoveProc.jsp?brand=<%= brand %>&model=<%= model%>" title="찜된 상품" style = "background-color: #8041D9;">
                                                                    <i class="zmdi zmdi-favorite"></i></a>
                                                                	</li>
                                                            <%}} %>
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- plus-minus-pro-action end -->
                                            <!-- hr -->
                                            <hr>
                                            <!-- single-product-price -->
                                            <h3 class="pro-price" id = "totalPrice">가격 : <%if(price != null){ %>&#8361;<%= df.format(Integer.parseInt(price)) %>원<%} %></h3>
                                            <!--  hr -->
                                            <hr>
                                            <div>
                                                <a href="#" class="button extra-small button-black" tabindex="-1">
                                                    <span class="text-uppercase" onClick = "options()">장바구니 담기</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- single-product-info end -->
                                </div>
                                <!-- single-product-tab -->
                                <div class="row">
                                    <div class="col-lg-12">
                                        <!-- hr -->
                                        <hr>
                                        <div class="single-product-tab reviews-tab">
                                            <ul class="nav mb-20">
                                                <li><a class="active" href="#description" data-bs-toggle="tab">상품 정보</a></li>
                                                <li><a href="#reviews" data-bs-toggle="tab">리뷰 읽기</a></li>
                                                <li><a href="#information" data-bs-toggle="tab">리뷰 쓰기</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div role="tabpanel" class="tab-pane active show" id="description">
                                                    <% for(int i = 0; i < pdList.length; i++){ %>
                                                    <p><b><%= pdTitles[i] %></b> : <%= pdList[i]%></p>
                                                    <%} %>
                                                </div>
                                                <div role="tabpanel" class="tab-pane" id="reviews">
                                                    <!-- reviews-tab-desc -->
                                                    <div class="reviews-tab-desc">
                                                    <%
                                                    	ReviewDao rdao = ReviewDao.getInstance();
                                                    	ArrayList<ReviewBean> rblist = rdao.getReviewByProduct(brand, model);
                                                    	
                                                    %>
                                                        <!-- single comments -->
                                                        <div class="media mt-30" style = "flex-direction : column;">
                                                        	<%if(rblist != null){ %>
                                                        		<%for(ReviewBean rb : rblist){ %>
		                                                            <div class="media-body" style = "margin-bottom: 20px;">
		                                                                <div class="clearfix">
		                                                                    <div class="name-commenter pull-left">
		                                                                        <h6 class="media-heading"><%= rb.getMemName() %>님
		                                                                        </h6>
		                                                                        <p class="mb-10"><%= rb.getRevDate() %></p>
		                                                                    </div>
		                                                                    <div class="pull-right">
		                                                                    	<%if(rb.getMemNo() == sno){ %>
		                                                                        <ul class="reply-delate">
		                                                                            <li><a href="deleteReviewProc.jsp?memNo=<%= rb.getMemNo() %>&brand=<%=brand%>&model=<%=model%>" onClick = "return confirmDelete()" style = "color: red !important; margin-right: 10px; margin-bottom: 10px;">삭제하기</a></li>
		                                                                        </ul>
		                                                                        <% } %>
		                                                                    </div>
		                                                                </div>
		                                                                <p class="mb-0" style = "border-bottom: 1px solid"><%= rb.getRevText() %></p>
		                                                            </div>
		                                                       <%} %>
                                                            <%} else{ %>
                                                            <div class="media-body">
                                                                <div class="clearfix">
                                                                    <div class="name-commenter pull-left">
                                                                    	<p>아직 작성된 리뷰 없습니다.</p>
                                                                    </div>
                                                                </div>
															</div>
															<%} %>
                                                        </div>
                                                    </div>
                                                </div>
                                              	<div role="tabpanel" class="tab-pane" id="information">
                                                	<form action = "reviewProc.jsp">
                                                			<input type = "hidden" name = "brand" value = "<%= brand %>"/>
                                                			<input type = "hidden" name = "model" value = "<%= model %>"/>
                                                		<% if(sid == null){ %>
                                                			<p>로그인한 후 리뷰 작성 가능합니다</p>
                                                			<input type = "button" class = "submit-btn-1 mt-20 btn-hover-1" value = "로그인" onClick = "location.href = '<%= conPath%>/login.jsp'">
                                                		<%} else { %>
                                                			<input type = "hidden" name = "memName" value = "<%= memName%>"/>
                                                			<input type = "hidden" name = "memNo" value = "<%= sno %>"/>
                                                			<p>리뷰 작성 (최대 길이 250문자)</p>
                                                			<p>작성자 : <%= memName %></p>
                                                			<p>상품 : <%= brand%> <%= model %></p>
                                                			<textarea cols="2" rows="5" maxlength = "250" name = "revText"></textarea>
                                                			<input type = "submit" class = "submit-btn-1 mt-20 btn-hover-1" value = "작성하기"">
                                                		<%} %>
                                                	</form>
                                                </div>
                                            </div>
                                        </div>
                                        <!--  hr -->
                                        <hr>
                                    </div>
                                </div>
                            </div>
                            <!-- single-product-area end -->
                          
                        </div>
                    </div>
                </div>
            </div>
            <!-- SHOP SECTION END -->
        
        </section>
        <!-- End page content -->
<%@ include file = "./../footer.jsp"%>
