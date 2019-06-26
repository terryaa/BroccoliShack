<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword"
	content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>Dashio - Bootstrap Admin Template</title>

<!-- Favicons -->
<link href="img/favicon.png" rel="icon">
<link href="img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet">
<link href="css/style-responsive.css" rel="stylesheet">

<!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
</head>

<body>
	<section id="container">
		<!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
		<!--header start-->
		<header class="header black-bg">
      <!--logo start-->
      <a href="index.html" class="logo"><b>KKPS<span>LH</span></b></a>
      <!--logo end-->
      <div class="nav notify-row" id="top_menu">
        <!--  notification start -->
        <ul class="nav top-menu">
          <!-- settings start -->
          <li class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
              <i class="fa fa-bar-chart"></i>
              
              </a>
            <ul class="dropdown-menu extended tasks-bar">
							<div class="notify-arrow notify-arrow-green"></div>
							<li>
								<p class="green">Analysis</p>
							</li>
							<li><a href="analysis_map_of_the_year#">
									<div class="task-info">
										<div class="desc">Analysis Map of the Year</div>
									</div>
							</a></li>
							<li><a href="resultchart#">
									<div class="task-info">
										<div class="desc">Multiple Regression Analysis Chart</div>
									</div>
							</a></li>
							<li><a href="result_RNN_chart#">
									<div class="task-info">
										<div class="desc">RNN Chart</div>
									</div>

							</a></li>
						</ul></li>
          <!-- settings end -->
          <!-- inbox dropdown start-->
          <li id="header_inbox_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
              <i class="fa fa-user"></i>
              </a>
             <ul class="dropdown-menu extended tasks-bar">
              <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">Analysis</p>
              </li>
              <li>
                <a href="apply_list">
                  <div class="task-info">
                    <div class="desc">Apply List</div>
                  </div>
                </a>
              </li>
              <li>
                <a href="apply_list">
                  <div class="task-info">
                    <div class="desc">Apply Board</div>                  
                  </div>
                </a>
              </li>
              <li>
                <a href="apply_insert">
                  <div class="task-info">
                    <div class="desc">Apply Insert</div>
                  </div>

                </a>
              </li>
            </ul>
          </li>
          <!-- inbox dropdown end -->
          <!-- notification dropdown start-->
          <li id="header_notification_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
              <i class="fa fa-users"></i>
              </a>
             <ul class="dropdown-menu extended tasks-bar">
              <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">Recruit</p>
              </li>
              <li>
                <a href="recruit_list">
                  <div class="task-info">
                    <div class="desc">Recruit_list</div>
                  </div>
                </a>
              </li>
              <li>
                <a href="recruit_list">
                  <div class="task-info">
                    <div class="desc">Recruit Board</div>                  
                  </div>
                </a>
              </li>
              <li>
                <a href="recruit_insert">
                  <div class="task-info">
                    <div class="desc">Recruit Insert</div>
                  </div>
                </a>
              </li>
            </ul>
          </li>
          <!-- notification dropdown end -->
        </ul>
        <!--  notification end -->
      </div>
      <div class="top-menu">
      <c:choose>
      	<c:when test="${uid eq	null}">
      	<ul class="nav pull-right top-menu">
			<li><a class="logout" href="u_login">LogIn</a></li>
        </ul>
      	</c:when>
      	<c:when test="${uid ne null}">
      	<ul class="nav pull-right top-menu">
      		<li><a class = 'logout'>${uname}</a></li>
			<li><a class="logout" href="u_logout">LogOut</a></li>
        </ul>
      	</c:when>
      </c:choose>
        
      </div>
    </header>
		<!--header end-->
		<!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
		<!--sidebar start-->
		<aside>
			
		</aside>
		<!--sidebar end-->
		<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper site-min-height">
				<h3>
					<i class="fa fa-angle-right"></i>구인정보등록
				</h3>
				<div class="row mt">
					<div class="col-lg-12">

						<div class="form-panel">
							<div class="form">
								<form class="cmxform form-horizontal style-form" id="signupForm"
									method="post" action="recruit_insert">

									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">구인제목</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_title"
												name="recruit_title" type="text" placeholder="제목입력" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">구인모집인원</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_size"
												name="recruit_size" type="text" placeholder="5(명)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">구인자
											경력</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_career"
												name="recruit_career" type="text" placeholder="12(개월)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">구인자
											연령</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_age"
												name="recruit_age" type="text" placeholder="20-50(세)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">일급</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_salay"
												name="recruit_salay" type="text" placeholder="5(단위:만원/1일)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">구인내용</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_content"
												name="recruit_content" type="text" placeholder="12-2시 휴식" />
										</div>
									</div>
									<div class="form-group ">
										<label for="lastname" class="control-label col-lg-2">구인
											지역</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_area"
												name="recruit_area" type="text" placeholder="전라남도 나주시" />
										</div>
									</div>
									<div class="form-group ">
										<label for="password" class="control-label col-lg-2">구인
											마감일</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_deadline"
												name="recruit_deadline" type="text" placeholder="2019-11-28" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인
											모집 업종</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_businessType"
												name="recruit_businessType" type="text" placeholder="배" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">작업시작일</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_startworkDate"
												name="recruit_startworkDate" type="text"
												placeholder="2019-12-01" />
										</div>
									</div>
									<div class="form-group ">
										<label for="firstname" class="control-label col-lg-2">작업종료일</label>
										<div class="col-lg-10">
											<input class=" form-control" id="recruit_endworkDate"
												name="recruit_endworkDate" type="text"
												placeholder="2019-12-10" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인작업시작시간</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_startworkTime"
												name="recruit_startworkTime" type="text"
												placeholder="09(시간)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인작업종료시간</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_endworkTime"
												name="recruit_endworkTime" type="text" placeholder="18(시간)" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인
											지원 정보</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_info"
												name="recruit_info" type="text" placeholder="점심제공/차량운행" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인지
											주소</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_address"
												name="recruit_address" type="text" placeholder="전라남도 나주시" />
										</div>
									</div>
									<div class="form-group ">
										<label for="confirm_password" class="control-label col-lg-2">구인지
											면적</label>
										<div class="col-lg-10">
											<input class="form-control " id="recruit_wide"
												name="recruit_wide" type="text" placeholder="배 수확" />
										</div>
									</div>
									<div class="form-group " style="height: 60px;">
										<label for="agree" class="control-label col-lg-2 col-sm-3"
											style="width: 500px; position: absolute; right: 450px;">해당
											기간동안 정보가 공개 되는 것에 동의하십니까?</label>
										<div class="col-lg-10 col-sm-9">
											<input type="checkbox"
												style="width: 20px; position: absolute; right: 350px;"
												class="checkbox form-control" id="agree" name="agree" />
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-offset-2 col-lg-10" style="height: 40px;">
											<button class="btn btn-theme" type="submit"
												style="position: absolute; right: 100px;">저장</button>
											<a href="blank2-2.html" class="btn btn-theme04"
												style="position: absolute; right: 20px;">취소</a>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!-- /form-panel -->
					</div>
					<!-- /col-lg-12 -->
				</div>

			</section>
			<!-- /wrapper -->
		</section>
		<!-- /MAIN CONTENT -->
		<!--main content end-->
		<!--footer start-->
		<footer class="site-footer">
			<div class="text-center">
				<p>
					&copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
				</p>
				<div class="credits">
					<!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
					Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
				</div>
				<a href="blank.html#" class="go-top"> <i class="fa fa-angle-up"></i>
				</a>
			</div>
		</footer>
		<!--footer end-->
	</section>
	<!-- js placed at the end of the document so the pages load faster -->
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="lib/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="lib/jquery.ui.touch-punch.min.js"></script>
	<script class="include" type="text/javascript"
		src="lib/jquery.dcjqaccordion.2.7.js"></script>
	<script src="lib/jquery.scrollTo.min.js"></script>
	<script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
	<!--common script for all pages-->
	<script src="lib/common-scripts.js"></script>
	<!--script for this page-->

</body>

</html>
