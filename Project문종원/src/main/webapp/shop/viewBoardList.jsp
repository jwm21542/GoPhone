<%@page import="myPkg.BoardBean"%>
<%@page import="myPkg.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>GoPhone || 게시판</title>
<%
	BoardDao bdao = BoardDao.getInstance();
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum"); //내가 선택한 페이지 번호.
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = bdao.getCount();
	ArrayList<BoardBean> board = null;
	if(count > 0) 
		board = bdao.getAllBoard(startRow, endRow);
	int number = count - (currentPage - 1) * pageSize; 
%>
<%@ include file = "./../header.jsp"%>
<%@ include file = "./../headerBanner.jsp"%>
<div class="breadcrumbs-section mb-80 section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb p-30">
                                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-home"></i>홈 페이지</a></li>
                                <li><i class="zmdi zmdi-comments">게시판 보기</i></li>
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
											<a class="button medium mb-20" href = "writeBoard.jsp" style = "padding: 10px;">글쓰기</a>                 			
                                            <div class="table-content table-responsive mb-50">
                                            	<% if(count == 0){ %>
													<table>
														<tr>
															<td align = "center" bgcolor = "">
																게시판에 작성된 글이 아직 없습니다.
															</td>
														</tr>
													</table>
                                            	<%} else { %>
                                                <table class="text-center table table-striped">
                                                    <thead>
                                                        <tr class="table-secondary">
                                                            <th class="product-thumbnail" style = "width:8%">글번호</th>
                                                            <th class="product-price" style = "width:40%;">제목</th>
                                                            <th class="product-quantity">작성자 아이디</th>
                                                            <th class="product-subtotal">작성일</th>
                                                            <th class="product-remove">조회 수</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%for(BoardBean bb : board){ 
                                                    	MembersBean mbean = mdao.getMemberByNo(bb.getMemno());
                                                    %>
	                                                        <tr>
	                                                        	<td><%= bb.getNo() %></td>
	                                                        	<td align = "left">
	                                                        	<%
																	int wid = 20;
																	if(bb.getRe_level() > 0){
																		wid = 20 * bb.getRe_level();
																	%>
																	<img src = "<%= conPath %>/img/icon/level.gif" width = "<%= wid %>">
																	<img src = "<%= conPath %>/img/icon/reply.gif">
																	<%} %>
	                                                        	<a href = "viewArticle.jsp?no=<%= bb.getNo() %>&pageNum=<%=pageNum%>"><%= bb.getTitle() %></a>
	                                                        	<%
																	if(bb.getReadCount() >= 20){
																		%>
																		<img src = "<%= conPath %>/img/icon/hot.gif">
																		<%
																	}
																%>
	                                                        	</td>
	                                                        	<td><%= mbean.getUserid() %></td>
	                                                        	<td><%= bb.getRegDate() %></td>
	                                                        	<td><%= bb.getReadCount() %></td>
	                                                        </tr>
													<% } %>
                                                    </tbody>
                                                </table>
                                                <%} 
	                                            	if(count > 0){
	                                            		int pageCount = count / pageSize + (count % pageSize == 0?0 : 1);
	                                            		int pageBlock = 3; 
	                                            		
	                                            		int startPage = ((currentPage - 1) / pageBlock * pageBlock) + 1;
	                                            		int endPage = startPage + pageBlock - 1;
	                                            		if(pageCount < endPage){
	                                            			endPage = pageCount;
	                                            		}
	                                            		if(startPage > 3){%>
	                                            			<a href = "viewBoardList.jsp?pageNum=<%=startPage-3%>">[이전]</a>
	                                            		<%}
	                                            		
	                                            		for(int i = startPage; i <= endPage; i++){%>
	                                            			<a href = "viewBoardList.jsp?pageNum=<%=i%>">[<%= i %>]</a>
	                                            		<%}
	                                            		
	                                            		if(endPage < pageCount){ %>
	                                            			<a href = "viewBoardList.jsp?pageNum=<%= endPage + 1 %>">[다음]</a>
	                                            		<%}
	                                            	}
	                                            	
	                                                %>
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
    