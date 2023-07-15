<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./../header.jsp"%>
<title>GoPhone || 회사소개</title>
<img class="d-block w-100" src="<%= conPath %>/img/banner/banner7.jpg" alt="First slide">
 <section id="page-content" class="page-wrapper section" style = "margin-top: 45px;">

            <!-- ABOUT SECTION START -->
            <div class="about-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="section-title text-start ">
                                <h2 class="uppercase">회사소개 || GoPhone</h2>
                                <h6 class="mb-40"><mark>스마트폰 전문 업체</mark></h6>
                            </div>
                        </div>
                    </div>                    
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="about-photo p-20 bg-img-1">
                                <img src="<%= conPath %>/img/banner/company.png" alt="">
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="about-description mt-50">
                            	<h4>국내 #1 중고폰 판매/구매 사이트 스마트폰 전문 업체 GoPhone입니다.</h4><br>
                            	<h4>요즘 점점 비싸지는 스파트폰 마켓 - 더 저렴한 옵션을 드립니다.</h4><br>
                            	<h4>국내 최고 매입가, 그리고 배송비 100% 보상</h4><br>
                            	<h4>제일 인기 있는 애플, 삼성, LG 스마트폰만 판매합니다.</h4><br>
                            	<h4>100% 정품.</h4><br>
                            	<h4>1년동안 무상보증 100% 약속드립니다.</h4><br>
                            	<h4>언제나 노력하는 GoPhone 되겠습니다.</h4><br>
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
                                <h3 class="text-white  text-uppercase">궁금하신거 있으세요?</h3>
                                <p class="text-white">저희 고객센터 사용해보세요!</p>
                            </div>
                        </div>
                        <div class="col-lg-4 text-end action-box-button">
                            <a class="button button-white mt-15" href="./shippingInfo.jsp">
                                <span>배송/연락 안내</span>
                            </a>
                            <a class="button button-black mt-15" href="./viewBoardList.jsp">
                                <span>게시판 보기</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
</section>
            <!-- ABOUT SECTION END --> 
<%@ include file = "./../footer.jsp"%>
