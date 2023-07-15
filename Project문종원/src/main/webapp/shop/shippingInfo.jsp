<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./../header.jsp"%>
<title>GoPhone || 배송주소/연락 안내</title>
<img class="d-block w-100" src="<%= conPath %>/img/banner/shippingbanner.jpg" alt="First slide">
<section>
<!-- GOOGLE MAP SECTION START -->
            <div class="google-map-section" style = "margin-bottom: 30px; margin-top: 30px;">
                <div class="container-fluid">
                    <div class="google-map plr-185">
                        <div id="googleMap"></div>
                    </div>
                </div>
            </div>
            <!-- GOOGLE MAP SECTION END -->
 <!-- ADDRESS SECTION START -->
            <div class="address-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="contact-address box-shadow">
                                <i class="zmdi zmdi-pin"></i>
                                <h6>서울 마포구 월드컵북로 21 풍성빌딩 2층</h6>
                                <h6>서교동 447-5</h6>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="contact-address box-shadow">
                                <i class="zmdi zmdi-phone"></i>
                                <h6><a href="tel:023368546">02-336-8546</a></h6>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="contact-address box-shadow">
                                <i class="zmdi zmdi-email"></i>
                                <h6>GoPhone@gp.com</h6>
                                <h6>GoPhoneCS@gp.com</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ADDRESS SECTION END -->


            <!-- MESSAGE BOX SECTION START -->
            <div class="message-box-section mt--50 mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="message-box box-shadow white-bg">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">질문있으시면 연락해주세요! (365일 09:00 ~ 18:00)</h4>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30"><a href = "viewBoardList.jsp" style = "color: #8041D9;">게시판</a>에 글작성하세요! GoPhone 커뮤니티가 도움드립니다.</h4>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">판매하시는 중고폰을 위에 있는 주소에 보낸후 입금처리 해드립니다.</h4>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <h4 class="blog-section-title border-left mb-30">배송비는 100% 보상해드립니다!</h4>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- MESSAGE BOX SECTION END -->
        </section>
<%@ include file = "./../footer.jsp"%>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCDacJcoyPCr-jdlP9HK93h3YKNyf710J0"></script>
<script src="<%= conPath %>/js/map.js"></script>
