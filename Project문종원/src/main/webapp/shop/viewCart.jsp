<%@page import="myPkg.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone || 장바구니</title>
<%@ include file = "./../header.jsp"%>
<script type = "text/javascript">
	function applyPoints(totPoints){
		if(isNaN($('input[name=point]').val())){
			alert("숫자 형식으로 입력해주세요");
			return false;;
		} else if($('input[name=point]').val() == "") {
			alert("적용하실 포인트 수 입력해주세요");
			return false;
		} else if(parseInt($('input[name=point]').val()) > parseInt(totPoints)){
			alert("입력한 수는 계정에 가진 포인트보다 많습니다");
			return false;
		} else {
			location.href = "applyPoints.jsp";
		}
	}
	
	function updateCart(pnum){
		var sqty = $('input[name=sqty]').val();
		if(sqty == "" || parseInt(sqty) == 0){
			alert("수량을 확인해주세요");
			$('input[name=sqty]').focus();
		} else {
			location.href = "updateCart.jsp?pnum=" + pnum + "&sqty=" + sqty;
		}
	}
	
	function deleteCheck(){
		var delCheck = confirm("장바구니에 삭제하시겠습니까?");
		if(!delCheck){
			return false;
		}
	}
</script>
<%
	if(mb == null){
		%>
			<script type = "text/javascript">
				alert("먼저 로그인해야 됩니다.")
				location.href = "<%= conPath%>" + "/login.jsp";
			</script>	
		<%
	}
	Vector<ProductsBean> cartList = shopCart.getAllProducts();
	int deliveryFee = 0;
	if(totalPrice > 700000){
		deliveryFee = 0;
	} else {
		deliveryFee = 3000;
	}
	String point = request.getParameter("point");
%>
        <!-- Start page content -->
        <section id="page-content" class="page-wrapper section">
        <!-- BREADCRUMBS SETCTION END -->    
            
            <div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-shield-home"></i>홈 페이지</a></li>
                                <li><%if(sid == null){ %>
                                        <a href="<%= conPath%>/login.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            계정관리
                                        </a>
                                    <%} else if(!sid.equals("admin")){%>
										<a href="<%= conPath%>/member/myaccount.jsp">
                                            <i class="zmdi zmdi-account"></i>
                                            <%= mb.getName() %>님
                                        </a>
                                    <%} else {%>
                                    	<a href="<%= conPath%>/admin/myaccount.jsp">
                                            <i class="zmdi zmdi-shield-security"></i>
                                            관리자 페이지
                                        </a>
                                    <%} %></li>
                                <li class="active">장바구니 보기</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>
            <!-- SHOP SECTION START -->
         <section id="page-content" class="page-wrapper section">
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10">
                            <!-- Tab panes -->
                                <!-- shopping-cart start -->
                                <div class="tab-pane active" id="shopping-cart">
                                    <div class="shopping-cart-content">
                                            <div class="table-content table-responsive mb-50">
                                                <table class="text-center">
                                                    <thead>
                                                        <tr>
                                                            <th class="product-thumbnail">상품</th>
                                                            <th class="product-price">단가</th>
                                                            <th class="product-quantity">수량</th>
                                                            <th class="product-subtotal">금액</th>
                                                            <th class="product-remove">삭제</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- tr -->
                                                        <% if(cartList != null){ %>
                                                        	<% for(ProductsBean prod : cartList){ %>
	                                                        <tr>
	                                                            <td class="product-thumbnail">
	                                                                <div class="pro-thumbnail-img">
	                                                                    <img src="<%= conPath %>/images/<%=prod.getPimage() %>" alt="">
	                                                                </div>
	                                                                <div class="pro-thumbnail-info text-start">
	                                                                    <h6 class="product-title-2">
	                                                                        <a href="singleProduct.jsp?brand=<%= prod.getBrand()%>&model=<%= prod.getModel() %>"><%= prod.getBrand() %> <%= prod.getModel() %></a>
	                                                                    </h6>
	                                                                    <p>용량: <%= prod.getStorage() %></p>
	                                                                    <p>등급: <%= prod.getCond() %></p>
	                                                                    <p>색상: <%= prod.getColor() %></p>
	                                                                </div>
	                                                            </td>
	                                                            <td class="product-price">&#8361; <%= df2.format(prod.getPrice()) %></td>
	                                                            <td class="product-quantity" style = "padding : 20px 15px; width: 200px !important;">
	                                                                <div>
	                                                                    <input type="text" value="<%= prod.getSqty() %>" name="sqty" style = "width : 40%; padding: 0px; text-align:center" maxlength = "2">개
	                                                                    <input type = "button" class = "submit-btn-1 mt-20 btn-hover-1" value = "수정" style = "width : 40%; padding: 0px; text-align:center;" onClick = "updateCart('<%=prod.getPnum()%>')">
	                                                                </div> 
	                                                            </td>
	                                                            <td class="product-subtotal">&#8361; <%= df2.format(prod.getPrice()*prod.getSqty()) %></td>
	                                                            <td class="product-remove">
	                                                                <a href="deleteCart.jsp?pnum=<%= prod.getPnum()%>" onClick = "return deleteCheck()"><i class="zmdi zmdi-close"></i></a>
	                                                            </td>
	                                                        </tr>
                                                        		<%}
                                                       	 	} %>
                                                    </tbody>
                                                </table>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="coupon-discount box-shadow p-30 mb-50">
                                                        <h6 class="widget-title border-left mb-20">포인트 적용</h6>
                                                        <p>포인트 금액 : <%if(mb != null) { %><%= mb.getPoint() %>P <% }%></p>
                                                        <form>
	                                                        <input type="text" name="point" placeholder="사용하실 포인트 금액">
	                                                        <button class="submit-btn-1 black-bg btn-hover-2" type="submit" <% if(mb!= null){%>onClick = "return applyPoints('<%= mb.getPoint() %>')"<%} %>>적용하기</button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="payment-details box-shadow p-30 mb-50">
                                                        <h6 class="widget-title border-left mb-20">최종 결제 금액</h6>
                                                        <table>
                                                            <tr>
                                                                <td class="td-title-1">총 상품 가격</td>
                                                                <td class="td-title-2">&#8361; <%= df2.format(totalPrice) %>원</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="td-title-1">배송비 (70만원 이상 구매하시면 무료배송!)</td>
                                                                <td class="td-title-2">&#8361; <%= df2.format(deliveryFee) %>원</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="td-title-1">포인트</td>
                                                                <td class="td-title-2" id = "point"><%if(point != null){%>- <%= df2.format(Integer.parseInt(point))%>P<%} %></td>
                                                            </tr>
                                                            <tr>
                                                            <%
                                                            if(point != null){
                                                            	totalPrice -= Integer.parseInt(point);
                                                            }
                                                           	if(deliveryFee > 0) {
                                                           		totalPrice += deliveryFee;
                                                           	}
                                                            %>
                                                                <td class="order-total">최종 금액</td>
                                                                <td class="order-total-price">&#8361; <%= df2.format(totalPrice) %>원</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- form was here -->
                                        <form action = "orderProc.jsp" id = "myform">
                                        	<input type = "hidden" name = "pointsused" value = "<%= point%>">
                                        </form>
                                    </div>
                                </div>
                                <!-- shopping-cart end -->
                            </div>
                        </div>
                    </div>
                    <div align = "center">
                    <button class="submit-btn-1 large mt-20 btn-hover-1" type="submit" form = "myform" style = "margin-bottom: 50px;">주문하기</button>
					</div>
            <!-- SHOP SECTION END -->             

        </section>
        <!-- End page content -->
<%@ include file = "./../footer.jsp"%>