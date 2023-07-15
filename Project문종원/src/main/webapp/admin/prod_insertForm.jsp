<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type = "text/javascript" src = "<%= request.getContextPath() %>/js/jquery.js"></script>
<script type = "text/javascript" src = "./script.js"></script>
<title>GoPhone || 상품등록</title>
<%@ include file = "main_top.jsp"%>
	    <h1 class="h3 mb-0 text-gray-800" style = "margin-left: 15px;">판매/구매 가능한 중고폰 추가해주세요</h1><br>
	    <p class="mb-4" style = "margin-left: 15px;">컨디션 등급은 자동으로 S급, A급, C급으로 추가됩니다 <br>상품 추가한 후 가격 등록 가능합니다 <br> S급은 기본가격의 120% 받고, A급은 100%, B급은 80% 받습니다</p>
<div class="col-lg-10" align = "center" style = "margin:auto;">
  	<div class="card shadow mb-4">
		<div class="card-header py-3">
		    <h5 class="m-0 font-weight-bold text-primary">상품 추가하기</h5>
		</div>
		<div class="card-body">
		<form action = "prod_insertProc.jsp" method = "post" enctype = "multipart/form-data">
			<div class = "form-row">
				<div class = "col-md-1"></div>
				<div class="form-group col-md-5" style = "margin-right: 34px; margin-bottom: 0px; vertical-align: middle;">
							<p style = "margin-bottom: 8px;">브랜드</p>
							<div class="btn-group btn-group-toggle" data-toggle="buttons" style = "height: 45px; width:50%; margin-right: 10px;">
							  <select class="form-control" name = "brand" size = "1">
							      <option value = "">선택</option>
							      <option value = "삼성">삼성</option>
							      <option value = "애플">애플</option>
							      <option value = "LG">LG</option>
							</select>	
							</div>				</div>
				<div class="form-group col-md-5">
						<label>모델</label>
						<input type = "text" class="form-control form-control-user" name = "model">
				</div>
				<div class = "col-md-1"></div>
			</div>
			<div class = "form-row">
				<div class = "col-md-1"></div>
				<div class="form-group col-md-5" style = "margin-right: 16px;">
				    <label>용량<br><span style = "font-size: 10px;">&#9CTRL키 누르시고 선택하시면 여러 용량 선택 가능합니다</span></label>
				    <select multiple class="form-control" id = "storage" name = "storage">
				      <option value = "16GB">16GB</option>
				      <option value = "32GB">32GB</option>
				      <option value = "64GB">64GB</option>
				      <option value = "128GB">128GB</option>
				      <option value = "256GB">256GB</option>
				      <option value = "512GB">512GB</option>
				      <option value = "1TB">1TB</option>
				    </select>
  				</div>
				<div class="form-group col-md-5" style = "margin-right: 16px;">
				    <label>색상<br><span style = "font-size: 10px;">&#9CTRL키 누르시고 선택하시면 여러 색상 선택 가능합니다</span></label>
				    <select multiple class="form-control" name = "color">
				      <option value = "Black">Black</option>
				      <option value = "White">White</option>
				      <option value = "Gray">Gray</option>
				      <option value = "Red">Red</option>
				      <option value = "Pink">Pink</option>
				      <option value = "Blue">Blue</option>
				      <option value = "Light-Blue">Light-Blue</option>
				      <option value = "Green">Green</option>
				      <option value = "Light-Green">Light-Green</option>
				      <option value = "Yellow">Yellow</option>
				      <option value = "Orange">Orange</option>
				      <option value = "Purple">Purple</option>
				      <option value = "Gold">Gold</option>
				      <option value = "Silver">Silver</option>
				      <option value = "Teal">Teal</option>
				    </select>
  				</div>
  				<div class = "col-md-1"></div>
  				
			</div>
			<div class = "form-row" style = "margin-bottom: 30px;">
				<div class = "col-md-2"></div>
				<div class="form-group row col-md-4" style = "margin-right: 60px;">
						<label>사진 1<span style = "font-size: 10px;">&#9가능하면 앞/뒤 사진 올려주세요</span></label>
						<input type = "file" class="form-control-file form-control-user" name = "pimage">
				</div>
				<div class="form-group row col-md-4">
						<label>사진 2<span style = "font-size: 10px;">&#9 가능하면 여러 색상 보여주는 사진 올려주세요</span></label>
						<input type = "file" class="form-control-file form-control-user" name = "pimage2">
				</div>
								<div class = "col-md-2"></div>
				
			</div>
			
				<!-- 운영체제 -->
					<div class="form-group row" style = "display: flex; justify-content:space-around">
						<div class="form-group" style = "display: flex; justify-content:space-around" >
						    <label>운영체제<br><span style = "font-size: 10px; margin-right: 15px;">&#9안드로이드/iOS중 선택하세요</span></label>
							<div class="btn-group btn-group-toggle" data-toggle="buttons" style = "height:36px; margin-right: 10px;">
							  <label class="btn btn-primary">
							    <input type="radio" name="os" id="option1" autocomplete="off" value = "iOS">iOS
							  </label>
							  <label class="btn btn-primary">
							    <input type="radio" name="os" id="option2" autocomplete="off" value = "안드로이드">안드로이드
							  </label>
							</div>
							
							<div class = "form-group">
							<script type = "text/javascript">
								$('input[name="os"]').change(function(){
										$('#osList').empty();
										$('#osList').append("<option value = ''>선택</option>")
										$('#cpuList').empty();
										$('#cpuList').append("<option value = ''>선택</option>")
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
					<div class="form-group row" style = "display: flex; justify-content:space-around;" height = "110px;">
						<label>출고일</label>							  
						<div class="form-group">
							<input type = "date" class = "form-control" name = "releaseDate">
						</div>
						    <label>출고가 (베이스 모델)</label>							  
						<div class="form-group" width = "200px" style = "display:flex; justify-content: space-around">
						    <div class="input-group-prepend">
							    <span class="input-group-text" style = "padding:18px; height:40px;">&#8361;</span>
							  </div>
							  <input type="text" name = "releasePrice"class="form-control" aria-label="Amount (to the nearest dollar)" style = "height:40px; text-align: right;">
							  <div class="input-group-append">
							    <span class="input-group-text" style = "padding:18px; height:40px;">원</span>
							  </div>
							</div>
					</div>
					
					<!-- 화면크기.CPU.램. -->
					<div class="form-group row" style = "display: flex; justify-content:space-around;" height = "110px;">
						<label>화면크기</label>							  
						<div class="form-group" style = "display:flex">
							<input type = "text" class = "form-control" name = "screenSize" size = "4">
							<span class="input-group-text" style = "padding:18px; height:40px;">인치</span>
						</div>
						<label>CPU</label>							  
						<div class="form-group" style = "display:flex">
							<select class="form-control" name = "cpuList" id = "cpuList" style="width: 180px">
  								<option>선택</option>
							</select>
						</div>
						<label>램</label>							  
						<div class="form-group" width = "200px" style = "display:flex; justify-content: space-around">
							<select class="form-control" name = "ram" id = "cpuList" style="width: 180px">
  								<option value = "">선택</option>
  								<option value = "1GB">1GB</option>
  								<option value = "2GB">2GB</option>
  								<option value = "3GB">3GB</option>
  								<option value = "4GB">4GB</option>
  								<option value = "6GB">6GB</option>
  								<option value = "8GB">8GB</option>
  								<option value = "12GB">12GB</option>
  								<option value = "16GB">16GB</option>
  								<option value = "18GB">18GB</option>
							</select>							
						</div>
					</div>
					
					<!-- 넽워크. 보안기능. -->
					<div class="form-group row" style = "display: flex; justify-content:space-around;" height = "110px;">
						<label>네트워크</label>	
												  
						 <div class="form-check" align = "left">
					 		<div style = "display:flex; flex-direction: column;">
						    <input type="checkbox" class="form-check-input" name = "network" value = "LTE">
						    <label class="form-check-label">LTE</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "network" value = "5G">
						    <label class="form-check-label">5G</label>
						    </div>
						  </div>
						<label>보안기능</label>							  
						<div class="form-group" align = "left">
							<div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "지문인식">
						    <label class="form-check-label">지문인식</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "얼굴인식">
						    <label class="form-check-label">얼굴인식</label>
						    </div>
						    <div>
						    <input type="checkbox" class="form-check-input" name = "security" value = "Face ID">
						    <label class="form-check-label">Face ID</label>
						    </div>
						</div>
					</div>
					
			<div class="form-group row">
				<div class = "col-sm-6 mb-3 mb-sm-0">
		    		<input type="submit" class="form-control form-control-user" value="상품 추가" onClick = "return check()">
				</div>
				<div class = "col-sm-6">
					<input type="reset" class="form-control form-control-user" value="취소">
				</div>
				
			</div>
		    </form>
		</div>
	</div>
</div>
<%@ include file = "main_bottom.jsp"%>