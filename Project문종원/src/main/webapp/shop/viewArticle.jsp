<%@page import="java.text.SimpleDateFormat"%>
<%@page import="myPkg.BoardBean"%>
<%@page import="myPkg.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./../header.jsp"%>
<style>
.title{
	background-color :#e2e3e5 !important;
	color : black;
	width : 25%;
}
</style>
<title>GoPhone || 글 보기</title>
<%	
	if(mb == null){
		%>
			<script type = "text/javascript">
				alert("먼저 로그인해야 됩니다.")
				location.href = "<%= conPath%>" + "/login.jsp";
			</script>	
		<%
	}
	request.setCharacterEncoding("UTF-8");
	BoardDao bdao = BoardDao.getInstance();
	int no = Integer.parseInt(request.getParameter("no"));
	BoardBean bb = bdao.getBoardByNo(no);
	String pageNum = request.getParameter("pageNum");
	String password = "";
	String memName = "";
	if(mb != null){ 
		password = mb.getPassword();
		memName = mb.getName();
	}
%>
<script type = "text/javascript">
	function deleteCheck(){
		var pw = prompt("글 삭제 : 비밀번호 입력하세요");
		if(pw == "<%= password%>"){
			location.href = "deleteArticleProc.jsp?no=<%= no %>&pageNum=<%= pageNum %>";
		} else {
			alert("비밀번호 틀렸습니다");
			return false;
		}
	}
</script>
<div class="breadcrumbs-section mb-80 section">
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12">
	            <ol class="breadcrumb p-30">
	                <li><a href="<%= conPath %>/main.jsp"><i class="zmdi zmdi-home"></i>홈 페이지</a></li>
	                <li><a href="<%= conPath %>/shop/viewBoardList.jsp"><i class="zmdi zmdi-comments">게시판 보기</i></a>
	                <li><i class="zmdi zmdi-collection-text">글 내용 보기</i></li>
	            </ol>
	        </div>
	    </div>
	</div>
</div>

<section id="page-content" class="page-wrapper section">
            <div class="shop-section mb-80">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <!-- Tab panes -->
                                <!-- shopping-cart start -->
                                 <div class="message-box box-shadow white-bg">
                                     <div class="table-content table-responsive mb-50">
                                     <table class="text-center table">
                                             <tbody>
                                                  <tr>
										<td class = "title">글번호</td>
										<td width = 25%><%= bb.getNo() %></td>
										<td class = "title">조회수</td>
										<td><%= bb.getReadCount() %></td>
									</tr>
									<tr>
										<td class = "title">작성자</td>
										<td width = 25%><%= memName %></td>
										<td class = "title">작성일</td>
										<td><%= bb.getRegDate() %></td>
									</tr>
									<tr>
										<td class = "title">글제목</td>
										<td colspan = "3"><%= bb.getTitle() %></td>
									</tr>
									<tr style = "height: 300px;">
										<td class = "title">글내용</td>
										<td colspan = "3" style = "text-align: left"><%= bb.getContent() %></td>
									</tr>
									<tr>
										<td id = "btn" colspan = "4" style = "text-align: right">
										<%if(bb.getMemno() == sno){ %>
											<a class="button medium mb-20" href = "updateArticle.jsp?no=<%= bb.getNo()%>&pageNum=<%=pageNum%>" style = "padding: 10px;">글수정</a>                 			
											<a class="button medium mb-20" href = "javascript:deleteCheck()" style = "padding: 10px;">글삭제</a>
										<%} bdao.updateReadCount(no);%>                 			
											<a class="button medium mb-20" href = "replyForm.jsp?ref=<%= bb.getRef()%>&re_step=<%= bb.getRe_step()%>&re_level=<%=bb.getRe_level()%>&pageNum=<%=pageNum%>" style = "padding: 10px;">답글쓰기</a>                 			
											<a class="button medium mb-20" href = "viewBoardList.jsp" style = "padding: 10px;">글목록</a>                 			
										</td>
									</tr>
                              </tbody>
                          </table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file = "./../footer.jsp"%>
