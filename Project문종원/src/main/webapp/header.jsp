<%@page import="java.util.Vector"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="myPkg.ProductsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.MembersBean"%>
<%@page import="myPkg.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
<jsp:useBean id = "shopCart" class = "myPkg.CartBean" scope = "session"/>
<%
	request.setCharacterEncoding("UTF-8");
	String conPath = request.getContextPath();
	String sid = (String)session.getAttribute("sid");
	int sno = 0;
	MembersDao mdao = MembersDao.getInstance();
	String name = "";
	MembersBean mb = null;
	if(sid != null){
		sno = (Integer)session.getAttribute("sno");
		mb = mdao.getMemberByNo(sno);
	}
	Vector<ProductsBean> plist = shopCart.getAllProducts();
	DecimalFormat df2 = new DecimalFormat("###,###");
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="<%= conPath%>/img/icon/favicon.png">

    <!-- All CSS Files -->
    <!-- Bootstrap fremwork main css -->
    <link rel="stylesheet" href="<%= conPath%>/css/bootstrap.min.css">
    <!-- Nivo-slider css -->
    <link rel="stylesheet" href="<%= conPath%>/lib/css/nivo-slider.css">
    <!-- This core.css file contents all plugings css file. -->
    <link rel="stylesheet" href="<%= conPath%>/css/core.css">
    <!-- Theme shortcodes/elements style -->
    <link rel="stylesheet" href="<%= conPath%>/css/shortcode/shortcodes.css">
    <!-- Theme main style -->
    <link rel="stylesheet" href="<%= conPath%>/style.css">
    <!-- Responsive css -->
    <link rel="stylesheet" href="<%= conPath%>/css/responsive.css">
    <!-- User style -->
    <link rel="stylesheet" href="<%= conPath%>/css/custom.css">
    
    <!-- Style customizer (Remove these two lines please) -->
    <link rel="stylesheet" href="<%= conPath%>/css/style-customizer.css">
    <link href="#" data-style="styles" rel="stylesheet">

    <!-- Modernizr JS -->
</head>

<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->  

    <!-- Body main wrapper start -->
    <div class="wrapper">

        <!-- START HEADER AREA -->
        <header class="header-area header-wrapper">
            <!-- header-top-bar -->
            <div class="header-top-bar plr-185">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 d-none d-md-block">
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="top-link clearfix">
                                <ul class="link f-right">
                                    <li>
                                        <%if(sid == null){ %>
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
                                    <%} %>
                                    </li>
                                    <li>
                                        <a href="<%= conPath %>/shop/viewWishlist.jsp">
                                            <i class="zmdi zmdi-favorite"></i>
                                            찜 목록
                                        </a>
                                    </li>
                                    <li>
                                    <%if(sid == null){ %>
                                        <a href="<%= conPath%>/login.jsp">
                                            <i class="zmdi zmdi-lock"></i>
                                            로그인
                                        </a>
                                    <%} else {%>
                                    	<a href="<%= conPath%>/logout.jsp">
                                            <i class="zmdi zmdi-lock"></i>
                                            로그아웃
                                        </a>
                                    <%}%>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- header-middle-area -->
            <div id="sticky-header" class="header-middle-area plr-185">
                <div class="container-fluid">
                    <div class="full-width-mega-dropdown">
                        <div class="row">
                            <!-- logo -->
                            <div class="col-lg-2 col-md-4">
                                <div class="logo">
                                    <a href="<%= conPath%>/main.jsp">
                                        <img src="<%= conPath%>/img/logo/logo.png" alt="main logo">
                                    </a>
                                </div>
                            </div>
                            <!-- primary-menu -->
                            <div class="col-lg-8 d-none d-lg-block">
                                <nav id="primary-menu">
                                    <ul class="main-menu text-center">
                                        <li><a href="<%= conPath%>/main.jsp">Home</a></li>
                                        <li><a href="<%=conPath%>/shop/shop.jsp">내폰사기</a>
                                        	  <ul class="dropdwn">
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp">모든 상품보기</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=삼성">삼성</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=애플">애플</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=LG">LG</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li><a href="<%=conPath%>/shop/requestProduct.jsp">내폰팔기</a>
                                            <ul class="dropdwn">
                                                <li>
                                                    <a href="<%=conPath%>/shop/requestProduct.jsp">신청하기</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath %>/shop/viewRequests.jsp">신청 조회</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li><a href="<%=conPath %>/shop/shippingInfo.jsp">고객센터</a>
                                            <ul class="dropdwn">
                                                <li>
                                                	<a href="<%=conPath %>/shop/shippingInfo.jsp">배송주소/연락 안내</a>
                                                </li>
                                                <li>
                                                    <a href="<%= conPath%>/shop/viewBoardList.jsp">GoPhone 게시판</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="<%=conPath %>/shop/aboutUs.jsp">회사 소개</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                            <!-- header-search & total-cart -->
                            <div class="col-lg-2 col-md-8">
                                <div class="search-top-cart  f-right">
                                    <!-- header-search -->
                                    <div class="header-search f-left">
                                        <div class="header-search-inner">
                                            <button class="search-toggle">
                                                <i class="zmdi zmdi-search"></i>
                                            </button>
                                            
                                            <!-- 여기에 SEARCH 되느것! -->
                                            <form action="<%= conPath %>/shop/searchProc.jsp">
                                                <div class="top-search-box">
                                                    <input type="text" name = "searchPhrase" placeholder="상품 검색하세요...">
                                                    <button type="submit">
                                                        <i class="zmdi zmdi-search"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <!-- 장바구니 시작 -->
                                    <div class="total-cart f-left">
                                        <div class="total-cart-in">
                                            <div class="cart-toggler">
                                                <a href="<%=conPath %>/shop/viewCart.jsp">
                                                    <span class="cart-quantity"><%= plist.size() %></span><br>  <!-- 장바구니 상품 갯수 -->
                                                    <span class="cart-icon">
                                                        <i class="zmdi zmdi-shopping-cart-plus"></i>
                                                    </span>
                                                </a>
                                            </div>
                                            <ul>
                                                <li>
                                                    <div class="top-cart-inner your-cart">
                                                        <h5 class="text-capitalize">장바구니</h5>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="total-cart-pro">
                                                        <!-- 장바구니 한상품!! 반복문으로 추가하기 -->
                                                        <div class="single-cart clearfix">
                                                            <%for(ProductsBean pb : plist){ %>
                                                            <div class="cart-img f-left">
                                                                <a href="<%=conPath %>/shop/single_Product.jsp?brand=<%= pb.getBrand()%>&model=<%= pb.getModel()%>">
                                                                    <img src="<%= conPath%>/images/<%= pb.getPimage() %>" alt="Cart Product" style = "height :111px"/>
                                                                </a>
                                                                <div class="del-icon">
                                                                    <a href="<%=conPath %>/shop/deleteCart.jsp?pnum=<%=pb.getPnum()%>">
                                                                        <i class="zmdi zmdi-close"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <!-- cartItem -->
                                                            <div class="cart-info f-left">
                                                                <h6 class="text-capitalize">
                                                                    <a href="#"><%= pb.getBrand() %> <%= pb.getModel() %></a>
                                                                </h6>
                                                                <p>
                                                                    <span>용량 <strong>:</strong></span><%= pb.getStorage() %>
                                                                </p>
                                                                <p>
                                                                    <span>등급 <strong>:</strong></span><%= pb.getCond() %>
                                                                </p>
                                                                <p>
                                                                    <span>색상 <strong>:</strong></span><%= pb.getColor() %>
                                                                </p>
                                                                <p>
                                                                    <span>수량 <strong>:</strong></span><%= pb.getSqty() %>
                                                                </p>
                                                            </div>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="top-cart-inner subtotal">
                                                        <h4 class="text-uppercase g-font-2">
                                                            Total =
                                                            <%
                                                            int totalPrice = 0;
                                                            for(ProductsBean pb : plist){ 
                                                            	totalPrice += pb.getPrice() * pb.getSqty();
                                                            %>
                                                           
                                                            <%} %>
                                                            <span> &#8361;<%= df2.format(totalPrice) %>원</span>
                                                        </h4>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="top-cart-inner view-cart">
                                                        <h4 class="text-uppercase">
                                                            <a href="<%=conPath %>/shop/viewCart.jsp">장바구니 보기</a>
                                                        </h4>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- CAROUSEL AREA -->
            
            
        </header>
        <!-- END HEADER AREA -->
        
        <!-- START MOBILE MENU AREA -->
        <div class="mobile-menu-area d-block d-lg-none section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="mobile-menu">
                            <nav id="dropdown">
                                <ul>
                                    <li><a href="<%= conPath%>/main.jsp">Home</a>
                                                                         </li>
                                    <li>
                                        <a href="<%=conPath%>/shop/shop.jsp">내폰사기</a>
                                        <ul>
                                             <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp">모든 상품보기</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=삼성">삼성</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=애플">애플</a>
                                                </li>
                                                <li>
                                                    <a href="<%=conPath%>/shop/shop.jsp?brand=LG">LG</a>
                                                </li>
                                        </ul>
                                    </li>
                                    <li><a href="<%=conPath%>/shop/requestProduct.jsp">내폰팔기</a>
                                        <ul>
                                            <li>
                                                <a  href = "<%=conPath%>/shop/requestProduct.jsp">신청하기</a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/viewRequests.jsp">신청 조회</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="<%=conPath %>/shop/shippingInfo.jsp">고객센터</a>
                                        <ul>
                                            <li>
                                                <a href="<%=conPath %>/shop/shippingInfo.jsp">배송주소/연락 안내</a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/viewBoardList.jsp">GoPhone 게시판</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="<%=conPath %>/shop/aboutUs.jsp">회사 소개</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END MOBILE MENU AREA -->