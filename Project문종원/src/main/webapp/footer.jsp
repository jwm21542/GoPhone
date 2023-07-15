<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <!-- START FOOTER AREA -->
        <footer id="footer" class="footer-area section">
            <div class="footer-top">
                <div class="container-fluid">
                    <div class="plr-185">
                        <div class="footer-top-inner gray-bg">
                            <div class="row"style = "justify-content:space-evenly;">
                                <div class="col-xl-4 col-lg-5 col-md-5">
                                    <div class="single-footer footer-about">
                                        <div class="footer-logo">
                                            <img src="<%= conPath %>/img/logo/logo.png" alt="">
                                        </div>
                                        <div class="footer-brief">
                                            <p>국내 최대 중고폰 수출업체 중 하나</p>
                                            <p>24시간 이내에 반드시 입금</p>
                                            <p>국내 최고가 매입 약속</p>
                                            <p>판매하는 폰 배송 100% 보상드립니다.</p>
                                            <p>소녀폰의 모든 폰 = 정품 및 제품 보증</p>
                                            <p>구매하신 기기는 기종별 최대 1년 무상 보증 및 고객님 과실로 인한 파손도 저렴하게 정품 수리가 가능합니다</p>
                                        </div>
                                        <ul class="footer-social">
                                            <li>
                                                <a class="facebook" href="" title="Facebook"><i
                                                        class="zmdi zmdi-facebook"></i></a>
                                            </li>
                                            <li>
                                                <a class="instagram" href="" title="Instagram"><i
                                                        class="zmdi zmdi-instagram"></i></a>
                                            </li>
                                            <li>
                                                <a class="twitter" href="" title="Twitter"><i class="zmdi zmdi-twitter"></i></a>
                                            </li>
                                            <li>
                                                <a class="rss" href="" title="RSS"><i class="zmdi zmdi-google"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-xl-2 d-block d-xl-block d-lg-none d-md-none">
                                    <div class="single-footer">
                                        <h4 class="footer-title border-left">바로 가기</h4>
                                        <ul class="footer-menu">
                                            <li>
                                                <a href="<%=conPath %>/shop/shop.jsp"><i class="zmdi zmdi-circle"></i><span>상품 보기</span></a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/requestProduct.jsp"><i class="zmdi zmdi-circle"></i><span>판매 신청</span></a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/viewBoardList.jsp"><i class="zmdi zmdi-circle"></i><span>게시판</span></a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/login.jsp"><i class="zmdi zmdi-circle"></i><span>로그인</a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/member/myaccount.jsp"><i class="zmdi zmdi-circle"></i><span>계정관리</span></a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/shippingInfo.jsp"><i class="zmdi zmdi-circle"></i><span>배송 안내 / 연락 소개</span></a>
                                            </li>
                                            <li>
                                                <a href="<%=conPath %>/shop/aboutUs.jsp"><i class="zmdi zmdi-circle"></i><span>About GoPhone</span></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- <div class="col-xl-2 col-lg-3 col-md-3">
                                    <div class="single-footer">
                                        <h4 class="footer-title border-left">my account</h4>
                                        <ul class="footer-menu">
                                            <li>
                                                <a href="my-account.html"><i class="zmdi zmdi-circle"></i><span>My
                                                        Account</span></a>
                                            </li>
                                            <li>
                                                <a href="wishlist.html"><i class="zmdi zmdi-circle"></i><span>My
                                                        Wishlist</span></a>
                                            </li>
                                            <li>
                                                <a href="cart.html"><i class="zmdi zmdi-circle"></i><span>My Cart</span></a>
                                            </li>
                                            <li>
                                                <a href="login.html"><i class="zmdi zmdi-circle"></i><span>Sign In</span></a>
                                            </li>
                                            <li>
                                                <a href="login.html"><i
                                                        class="zmdi zmdi-circle"></i><span>Registration</span></a>
                                            </li>
                                            <li>
                                                <a href="checkout.html"><i class="zmdi zmdi-circle"></i><span>Check
                                                        out</span></a>
                                            </li>
                                            <li>
                                                <a href="order.html"><i class="zmdi zmdi-circle"></i><span>Oder
                                                        Complete</span></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div> -->
                                <!-- 오른쪽 -->
                                <div class="col-xl-4 col-lg-4 col-md-4" style = "text-align:center;">
                                	<img src = "<%= conPath %>/img/banner/phoneBackground.png" style = "width : 80%;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom black-bg">
                <div class="container-fluid">
                    <div class="plr-185">
                        <div class="copyright">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="copyright-text">
                                        <p class="copy-text"> © 2023 <strong>GoPhone</strong>All Rights Reserved.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <ul class="footer-payment text-end">
                                        <li>
                                            <img src="<%= conPath%>/img/payment/payco.jpg" alt="">
                                        </li>
                                        <li>
                                            <img src="<%= conPath%>/img/payment/kakaopay.png" alt="">
                                        </li>
                                        <li>
                                            <img src="<%= conPath%>/img/payment/naverpay.png" alt="">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- END FOOTER AREA -->
   <!-- jquery latest version -->
    <script src="<%= conPath%>/js/vendor/jquery-3.6.0.min.js"></script>
    <script src="<%= conPath%>/js/vendor/jquery-migrate-3.3.2.min.js"></script>
    <!-- Bootstrap framework js -->
    <script src="<%= conPath%>/js/bootstrap.bundle.min.js"></script>
    <!-- jquery.nivo.slider js -->
    <script src="<%= conPath%>/lib/js/jquery.nivo.slider.js"></script>
    <!-- All js plugins included in this file. -->
    <script src="<%= conPath%>/js/plugins.js"></script>
    <!-- Main js file that contents all jQuery plugins activation. -->
    <script src="<%= conPath%>/js/main.js"></script>

</body>

</html>