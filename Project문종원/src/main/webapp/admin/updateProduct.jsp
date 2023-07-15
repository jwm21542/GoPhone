	<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.ProductsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type = "text/javascript" src = "<%= request.getContextPath() %>/js/jquery.js"></script>
<script type = "text/javascript" src = "./script.js"></script>
<%	
	request.setCharacterEncoding("UTF-8");
	String model = request.getParameter("model");
	String brand = request.getParameter("brand");
	String conds = request.getParameter("conds");
	String[] storageList = {"16GB", "32GB", "64GB", "128GB", "256GB", "512GB", "1TB"};
	String storage = request.getParameter("storage");
	String[] colorList = {"Black", "White", "Gray", "Red", "Pink", "Blue", "Light-Blue",
			"Green", "Light-Green", "Yellow", "Orange", "Purple", "Gold", "Silver", "Teal"};
	String color = request.getParameter("color");
	String pnum = request.getParameter("pnum");
	ProductsDao pdao = ProductsDao.getInstance();
	ProductsBean pb = pdao.getProductByPnum(pnum);
	String pdesc = pb.getPdesc();
	String[] pdList = pdesc.split("/");
	String[] pdescTitle = {"운영체제", "출시일", "출고가 (베이스 모델)", "화면크기", "CPU", "램", "네트워크", "보안기능"};
	ArrayList<String> colors = pdao.getModelColors(model);
	ArrayList<String> storages = pdao.getModelStorage(model);
%>


<%@ include file = "main_top.jsp"%>
<div class="col-lg-10" align = "center" style = "margin:auto;">
  	<div class="card shadow mb-4">
		<div class="card-header py-3">
		    <h5 class="m-0 font-weight-bold text-primary">상품정보 수정하기: <%= brand %> <%= model %></h5>
		</div>
		<div class="card-body">
		<form action = "updateProdProc.jsp">
				<input type = "hidden" name = "brand" value = "<%= brand %>">
				<input type = "hidden" name = "model" value = "<%= model %>">
				<!-- 운영체제 -->
					<div class="form-group row" style = "display: flex; justify-content:space-around">
						<div class="form-group" style = "display: flex; justify-content:space-around" >
						    <label>운영체제<br><span style = "font-size: 10px; margin-right: 15px;">&#9안드로이드/iOS중 선택하세요</span></label>
							<div class="btn-group btn-group-toggle" data-toggle="buttons" style = "height:36px; margin-right: 10px;">
							  <label class="btn btn-primary">
							    <input type="radio" name="os" id="option1" autocomplete="off" value = "iOS" <%  %>>iOS
							  </label>
							  <label class="btn btn-primary">
							    <input type="radio" name="os" id="option2" autocomplete="off" value = "안드로이드" <% if(pdesc.contains("안드로이드")){ %> checked <% } %>>안드로이드
							  </label>
							</div>
							
							<div class = "form-group">
							<script type = "text/javascript">
								$(document).ready(function() {
									$('#osList').empty();
									$('#osList').append("<option value = ''>선택</option>")
									$('#cpuList').empty();
									$('#cpuList').append("<option value = ''>선택</option>")
								if($('input[name="os"]:checked').val() == "iOS"){
									$('#osList').append("<option value = 'iOS 15' <% if(pdesc.contains("iOS 15")){ %>selected<% } %>>iOS 15</option>");
									$('#osList').append("<option value = 'iOS 14' <% if(pdesc.contains("iOS 14")){ %>selected<% } %>>iOS 14</option>");
									$('#osList').append("<option value = 'iOS 13' <% if(pdesc.contains("iOS 13")){ %>selected<% } %>>iOS 13</option>");
									$('#osList').append("<option value = 'iOS 12' <% if(pdesc.contains("iOS 12")){ %>selected<% } %>>iOS 12</option>");
									$('#osList').append("<option value = 'iOS 11' <% if(pdesc.contains("iOS 11")){ %>selected<% } %>>iOS 11</option>");
									$('#osList').append("<option value = 'iOS 10' <% if(pdesc.contains("iOS 10")){ %>selected<% } %>>iOS 10</option>");
									$('#osList').append("<option value = 'iOS 9' <% if(pdesc.contains("iOS 9")){ %>selected<% } %>>iOS 9</option>");
									$('#osList').append("<option value = 'iOS 8' <% if(pdesc.contains("iOS 8")){ %>selected<% } %>>iOS 8</option>");
									$('#osList').append("<option value = 'iOS 7' <% if(pdesc.contains("iOS 7")){ %>selected<% } %>>iOS 7</option>");
									$('#cpuList').append("<option value = 'A16' <% if(pdesc.contains("A16")){ %>selected<% } %>>A16</option>");
									$('#cpuList').append("<option value = 'A15' <% if(pdesc.contains("A15")){ %>selected<% } %>>A15</option>");
									$('#cpuList').append("<option value = 'A14' <% if(pdesc.contains("A14")){ %>selected<% } %>>A14</option>");
									$('#cpuList').append("<option value = 'A13' <% if(pdesc.contains("A13")){ %>selected<% } %>>A13</option>");
									$('#cpuList').append("<option value = 'A12Z' <% if(pdesc.contains("A12Z")){ %>selected<% } %>>A12Z</option>");
									$('#cpuList').append("<option value = 'A12X' <% if(pdesc.contains("A12X")){ %>selected<% } %>>A12X</option>");
									$('#cpuList').append("<option value = 'A12' <% if(pdesc.contains("A12")){ %>selected<% } %>>A12</option>");
									$('#cpuList').append("<option value = 'A11' <% if(pdesc.contains("A11")){ %>selected<% } %>>A11</option>");
									$('#cpuList').append("<option value = 'A10' <% if(pdesc.contains("A10")){ %>selected<% } %>>A10</option>");
									$('#cpuList').append("<option value = 'A9X' <% if(pdesc.contains("A9X")){ %>selected<% } %>>A9X</option>");
									$('#cpuList').append("<option value = 'A9' <% if(pdesc.contains("A9")){ %>selected<% } %>>A9</option>");
									$('#cpuList').append("<option value = 'A8' <% if(pdesc.contains("A8")){ %>selected<% } %>>A8</option>");
									$('#cpuList').append("<option value = 'A7' <% if(pdesc.contains("A8")){ %>selected<% } %>>A7</option>");
								} else if($('input[name="os"]:checked').val() == "안드로이드"){
									$('#osList').append("<option value = '안드로이드 15' <% if(pdesc.contains("안드로이드 15")){ %>selected<% } %>>안드로이드 15</option>");
									$('#osList').append("<option value = '안드로이드 14' <% if(pdesc.contains("안드로이드 14")){ %>selected<% } %>>안드로이드 14</option>");
									$('#osList').append("<option value = '안드로이드 13' <% if(pdesc.contains("안드로이드 13")){ %>selected<% } %>>안드로이드 13</option>");
									$('#osList').append("<option value = '안드로이드 12' <% if(pdesc.contains("안드로이드 12")){ %>selected<% } %>>안드로이드 12</option>");
									$('#osList').append("<option value = '안드로이드 11' <% if(pdesc.contains("안드로이드 11")){ %>selected<% } %>>안드로이드 11</option>");
									$('#osList').append("<option value = '안드로이드 10' <% if(pdesc.contains("안드로이드 10")){ %>selected<% } %>>안드로이드 10</option>");
									$('#osList').append("<option value = '안드로이드 파이' <% if(pdesc.contains("안드로이드 파이")){ %>selected<% } %>>안드로이드 파이</option>");
									$('#osList').append("<option value = '안드로이드 오레오' <% if(pdesc.contains("안드로이드 오레오")){ %>selected<% } %>>안드로이드 오레오</option>");
									$('#osList').append("<option value = '안드로이드 마시멜로' <% if(pdesc.contains("안드로이드 마시멜로")){ %>selected<% } %>>안드로이드 마시멜로</option>");
									$('#cpuList').append("<option value = 'SD 8 Gen 2' <% if(pdesc.contains("SD 8 Gen 2")){ %>selected<% } %>>SD 8 Gen 2</option>");
									$('#cpuList').append("<option value = 'SD 8+ Gen 1' <% if(pdesc.contains("SD 8+ Gen 1")){ %>selected<% } %>>SD 8+ Gen 1</option>");
									$('#cpuList').append("<option value = 'SD 8 Gen 1' <% if(pdesc.contains("SD 8 Gen 1")){ %>selected<% } %>>SD 8 Gen 1</option>");
									$('#cpuList').append("<option value = 'SD 888+' <% if(pdesc.contains("SD 888+")){ %>selected<% } %>>SD 888+</option>");
									$('#cpuList').append("<option value = 'SD 888' <% if(pdesc.contains("SD 888")){ %>selected<% } %>>SD 888</option>");
									$('#cpuList').append("<option value = 'SD 865+' <% if(pdesc.contains("SD 865+")){ %>selected<% } %>>SD 865+</option>");
									$('#cpuList').append("<option value = 'SD 865' <% if(pdesc.contains("SD 865")){ %>selected<% } %>>SD 865</option>");
									$('#cpuList').append("<option value = 'SD 855+' <% if(pdesc.contains("SD 855+")){ %>selected<% } %>>SD 855+</option>");
									$('#cpuList').append("<option value = 'SD 855' <% if(pdesc.contains("SD 855")){ %>selected<% } %>>SD 855</option>");
									$('#cpuList').append("<option value = 'SD 845' <% if(pdesc.contains("SD 845")){ %>selected<% } %>>SD 845</option>");
									$('#cpuList').append("<option value = 'SD 835' <% if(pdesc.contains("SD 835")){ %>selected<% } %>>SD 835</option>");
									$('#cpuList').append("<option value = 'SD 821' <% if(pdesc.contains("SD 821")){ %>selected<% } %>>SD 821</option>");
									$('#cpuList').append("<option value = 'SD 820' <% if(pdesc.contains("SD 820")){ %>selected<% } %>>SD 820</option>");
									$('#cpuList').append("<option value = 'SD 778G' <% if(pdesc.contains("SD 778G")){ %>selected<% } %>>SD 778G</option>");
									$('#cpuList').append("<option value = 'SD 765G' <% if(pdesc.contains("SD 765G")){ %>selected<% } %>>SD 765G</option>");
									$('#cpuList').append("<option value = 'SD 750G' <% if(pdesc.contains("SD 750G")){ %>selected<% } %>>SD 750G</option>");
									$('#cpuList').append("<option value = 'SD 720G' <% if(pdesc.contains("SD 720G")){ %>selected<% } %>>SD 720G</option>");
								}});
								$('input[name="os"]').change(function(){
										$('#osList').empty();
										$('#osList').append("<option>선택</option>")
										$('#cpuList').empty();
										$('#cpuList').append("<option>선택</option>")
									if($('input[name="os"]:checked').val() == "iOS"){
										$('#osList').append("<option value = 'iOS 15'>iOS 15</option>");
										$('#osList').append("<option value = 'iOS 14'>iOS 14</option>");
										$('#osList').append("<option value = 'iOS 13'>iOS 13</option>");
										$('#osList').append("<option value = 'iOS 12'>iOS 12</option>");
										$('#osList').append("<option value = 'iOS 11'>iOS 11</option>");
										$('#osList').append("<option value = 'iOS 10'>iOS 10</option>");
										$('#osList').append("<option value = 'iOS 9'>iOS 9</option>");
										$('#osList').append("<option value = 'iOS 8'>iOS 8</option>");
										$('#osList').append("<option value = 'iOS 7'>iOS 7</option>");
										$('#cpuList').append("<option value = 'A16'>A16</option>");
										$('#cpuList').append("<option value = 'A15'>A15</option>");
										$('#cpuList').append("<option value = 'A14'>A14</option>");
										$('#cpuList').append("<option value = 'A13'>A13</option>");
										$('#cpuList').append("<option value = 'A12Z'>A12Z</option>");
										$('#cpuList').append("<option value = 'A12X'>A12X</option>");
										$('#cpuList').append("<option value = 'A12'>A12</option>");
										$('#cpuList').append("<option value = 'A11'>A11</option>");
										$('#cpuList').append("<option value = 'A10'>A10</option>");
										$('#cpuList').append("<option value = 'A9X'>A9X</option>");
										$('#cpuList').append("<option value = 'A9'>A9</option>");
										$('#cpuList').append("<option value = 'A8'>A8</option>");
										$('#cpuList').append("<option value = 'A7'>A7</option>");
									} else if($('input[name="os"]:checked').val() == "안드로이드"){
										$('#osList').append("<option value = '안드로이드 15'>안드로이드 15</option>");
										$('#osList').append("<option value = '안드로이드 14'>안드로이드 14</option>");
										$('#osList').append("<option value = '안드로이드 13'>안드로이드 13</option>");
										$('#osList').append("<option value = '안드로이드 12'>안드로이드 12</option>");
										$('#osList').append("<option value = '안드로이드 11'>안드로이드 11</option>");
										$('#osList').append("<option value = '안드로이드 10'>안드로이드 10</option>");
										$('#osList').append("<option value = '안드로이드 파이'>안드로이드 파이</option>");
										$('#osList').append("<option value = '안드로이드 오레오'>안드로이드 오레오</option>");
										$('#osList').append("<option value = '안드로이드 마시멜로'>안드로이드 마시멜로</option>");
										$('#cpuList').append("<option value = 'SD 8 Gen 2'>SD 8 Gen 2</option>");
										$('#cpuList').append("<option value = 'SD 8+ Gen 1'>SD 8+ Gen 1</option>");
										$('#cpuList').append("<option value = 'SD 8 Gen 1'>SD 8 Gen 1</option>");
										$('#cpuList').append("<option value = 'SD 888+'>SD 888+</option>");
										$('#cpuList').append("<option value = 'SD 888'>SD 888</option>");
										$('#cpuList').append("<option value = 'SD 865+'>SD 865+</option>");
										$('#cpuList').append("<option value = 'SD 865'>SD 865</option>");
										$('#cpuList').append("<option value = 'SD 855+'>SD 855+</option>");
										$('#cpuList').append("<option value = 'SD 855'>SD 855</option>");
										$('#cpuList').append("<option value = 'SD 845'>SD 845</option>");
										$('#cpuList').append("<option value = 'SD 835'>SD 835</option>");
										$('#cpuList').append("<option value = 'SD 821'>SD 821</option>");
										$('#cpuList').append("<option value = 'SD 820'>SD 820</option>");
										$('#cpuList').append("<option value = 'SD 778G'>SD 778G</option>");
										$('#cpuList').append("<option value = 'SD 765G'>SD 765G</option>");
										$('#cpuList').append("<option value = 'SD 750G'>SD 750G</option>");
										$('#cpuList').append("<option value = 'SD 720G'>SD 720G</option>");
									}
								});
							</script>
							<select class="form-control" name = "osList" id = "osList" style="width: 180px">
  								<option value = "">선택</option>
							</select>
							</div>
							</div>
						</div>
					
					<!-- 출시일/출고가 -->
					<div class="form-group " style = "display: flex; justify-content:space-around;" height = "110px;">
						<div class="form-group col-md-4">
						<label>출고일</label>							  
							<input type = "date" class = "form-control" name = "releaseDate" value = "<%= pdList[1] %>">
						</div>
						<div class="form-group col-md-4">
						    <label>출고가 (베이스 모델)<br></label>		
						    	<div style = "display:flex;">				  
						    	<div class="input-group-prepend">
							    <span class="input-group-text" style = "padding:18px; height:40px;">&#8361;</span>
							  </div>
							  <%
							  	String relPrice = pdList[2].replace("," , "");
							  	relPrice = relPrice.replace("원", "");
							  %>
							  <input type="text" name = "releasePrice"class="form-control" aria-label="Amount (to the nearest dollar)" style = "height:40px; text-align: right;" value = "<%= relPrice %>">
							  <div class="input-group-append">
							    <span class="input-group-text" style = "padding:18px; height:40px;">원</span>
							  </div>
							  </div>
							</div>
					</div>
					
					<!-- 화면크기.CPU.램. -->
					<div class="form-group row" style = "display: flex; justify-content:space-around;" height = "110px;">
						<label>화면크기</label>							  
						<div class="form-group" style = "display:flex">
							<input type = "text" class = "form-control" name = "screenSize" size = "4" value = "<%= pdList[3] %>">
							<span class="input-group-text" style = "padding:18px; height:40px;">인치</span>
						</div>
						<label>CPU</label>							  
						<div class="form-group" style = "display:flex">
							<select class="form-control" name = "cpuList" id = "cpuList" style="width: 180px" value = "<%= pdList[4] %>">
  								<option value = "">선택</option>
							</select>
						</div>
						<label>램</label>							  
						<div class="form-group" width = "200px" style = "display:flex; justify-content: space-around">
							<select class="form-control" name = "ram" id = "cpuList" style="width: 180px">
  								<option>선택</option>
  								<option value = "1GB" <% if(pdesc.contains("1GB")){ %>selected<% } %>>1GB</option>
  								<option value = "2GB" <% if(pdesc.contains("2GB")){ %>selected<% } %>>2GB</option>
  								<option value = "3GB" <% if(pdesc.contains("3GB")){ %>selected<% } %>>3GB</option>
  								<option value = "4GB" <% if(pdesc.contains("4GB")){ %>selected<% } %>>4GB</option>
  								<option value = "6GB" <% if(pdesc.contains("6GB")){ %>selected<% } %>>6GB</option>
  								<option value = "8GB" <% if(pdesc.contains("8GB")){ %>selected<% } %>>8GB</option>
  								<option value = "12GB" <% if(pdesc.contains("12GB")){ %>selected<% } %>>12GB</option>
  								<option value = "16GB" <% if(pdesc.contains("16GB")){ %>selected<% } %>>16GB</option>
  								<option value = "18GB" <% if(pdesc.contains("18GB")){ %>selected<% } %>>18GB</option>
							</select>							
						</div>
					</div>
					
					<!-- 넽워크. 보안기능. -->
					<div class="form-group row" style = "display: flex; justify-content:space-around;" height = "110px;">
						<label>네트워크</label>	
												  
						 <div class="form-check" align = "left">
					 		<div style = "display:flex; flex-direction: column;">
						    <input type="checkbox" class="form-check-input" name = "network" value = "LTE" <% if(pdesc.contains("LTE")){ %>checked<% } %>>
						    <label class="form-check-label">LTE</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "network" value = "5G" <% if(pdesc.contains("5G")){ %>checked<% } %>>
						    <label class="form-check-label">5G</label>
						    </div>
						  </div>
						<label>보안기능</label>							  
						<div class="form-group" align = "left">
							<div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "지문인식" <% if(pdesc.contains("지문인식")){ %>checked<% } %>>
						    <label class="form-check-label">지문인식</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "얼굴인식" <% if(pdesc.contains("얼굴인식")){ %>checked<% } %>>
						    <label class="form-check-label">얼굴인식</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "Face ID" <% if(pdesc.contains("Face ID")){ %>checked<% } %>>
						    <label class="form-check-label">Face ID</label>
						    </div>
						</div>
					</div>
					
			<div class="form-group row">
				<div class = "col-sm-6 mb-3 mb-sm-0">
		    		<input type="submit" class="form-control form-control-user" value="수정하기" onClick = "return check2()">
				</div>
				<div class = "col-sm-6">
					<input type="reset" class="form-control form-control-user" value="취소" onClick = "location.href = 'prod_list.jsp'">
				</div>
				
			</div>
		    </form>
		</div>
	</div>
</div>
<%@ include file = "main_bottom.jsp"%>