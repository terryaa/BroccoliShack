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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
<script>
	/* Formating function for row details */
	function GetFormattedDate(d) {
		var todayTime = new Date(d);
		var month = todayTime.getMonth() + 1;
		var day = todayTime.getDate();
		var year = todayTime.getFullYear();
		return year + "/" + month + "/" + day;
	}

	$(document)
			.ready(
					function() {
						var para = document.location.href.split("=");
						var param = para[1];
						$
								.ajax({
									url : "/Project_Final/apply_board_view/"
											+ param,
									success : function(data) {
										console.log(data);
										$
												.each(
														data,
														function(idx, item) {
															$("#val1")
																	.text(
																			item.APPLY_POST_NUMBER);
															$("#val2")
																	.text(
																			item.MEMBER_ID);
															$("#val3")
																	.text(
																			item.APPLY_TITLE);
															$("#val4").text(
																	item.VIEWS);
															$("#val5")
																	.text(
																			GetFormattedDate(item.APPLY_REGISTRATIONDATE));
															$("#val6")
																	.text(
																			item.APPLY_AREA);
															$("#val7")
																	.text(
																			item.APPLY_CROPS);

															$("#val10")
																	.text(
																			item.APPLY_CAREER);
															$("#val11")
																	.text(
																			item.APPLY_SALAY);

															$("#val15")
																	.text(
																			item.APPLY_STARTWORKTIME);
															$("#val16")
																	.text(
																			item.APPLY_ENDWORKTIME);

															$("#val19")
																	.text(
																			item.APPLY_CONTENT);
														});

									}
								});

						$('#apply_submit').click(function() {
							var number = $("#val1").text();
							console.log(number)

							$.ajax({
								url : "apply_submit?apply_number=" + number,
								success : function(result) {
									alert("지원성공")
									location.href = "apply_list";
								},
								error : function(e) {
									console.log("ERROR : ", e);
								}
							});

						});

					});
</script>
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
					<li class="dropdown"><a data-toggle="dropdown"
						class="dropdown-toggle" href="index.html#"> <i
							class="fa fa-bar-chart"></i>

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
					<li id="header_inbox_bar" class="dropdown"><a
						data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
							<i class="fa fa-user"></i>
					</a>
						<ul class="dropdown-menu extended tasks-bar">
							<div class="notify-arrow notify-arrow-green"></div>
							<li>
								<p class="green">Analysis</p>
							</li>
							<li><a href="apply_list">
									<div class="task-info">
										<div class="desc">Apply List</div>
									</div>
							</a></li>
							<li><a href="apply_list">
									<div class="task-info">
										<div class="desc">Apply Board</div>
									</div>
							</a></li>
							<li><a href="apply_insert">
									<div class="task-info">
										<div class="desc">Apply Insert</div>
									</div>

							</a></li>
						</ul></li>
					<!-- inbox dropdown end -->
					<!-- notification dropdown start-->
					<li id="header_notification_bar" class="dropdown"><a
						data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
							<i class="fa fa-users"></i>
					</a>
						<ul class="dropdown-menu extended tasks-bar">
							<div class="notify-arrow notify-arrow-green"></div>
							<li>
								<p class="green">Recruit</p>
							</li>
							<li><a href="recruit_list">
									<div class="task-info">
										<div class="desc">Recruit_list</div>
									</div>
							</a></li>
							<li><a href="recruit_list">
									<div class="task-info">
										<div class="desc">Recruit Board</div>
									</div>
							</a></li>
							<li><a href="recruit_insert">
									<div class="task-info">
										<div class="desc">Recruit Insert</div>
									</div>
							</a></li>
						</ul></li>
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
							<li><a class='logout'>${uname}</a></li>
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

		<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper">

				<div class="col-lg-12 mt">
					<div class="row content-panel">

						<div class="col-lg-10 col-lg-offset-1">
							<div class="invoice-body">

								<div class="pull-left">
									<h1>구인</h1>
									<address>
										<strong> 게시판번호</strong> <br>
										<p id="val1">
											795850<br>
										</p>
										<strong> id</strong><br>
										<p id="val2">
											795850<br>
										</p>

									</address>
								</div>

								<!-- /pull-left -->
								<div class="pull-right" style="text-align: right">
									<h2 id="val3">나주시 배농장 급구</h2>
									<strong> 조회수</strong><br>
									<p id="val4">
										795850<br>
									</p>
									<strong> 등록일</strong><br>
									<p id="val5">
										795850<br>
									</p>
								</div>
								<!-- /pull-right -->
								<div class="clearfix"></div>
								<br> <br> <br>
								<div class="row">
									<div class="col-md-4 profile-text mt mb centered">
										<div class="right-divider hidden-sm hidden-xs">
											<br>
											<h4 id="val6">10</h4>
											<h6>모집지역</h6>
											<h4 id="val7">무관</h4>
											<h6>작물</h6>

										</div>
									</div>
									<div class="col-md-4 profile-text mt mb centered">
										<div class="right-divider hidden-sm hidden-xs">
											<h4 id="val10">2019-10-12</h4>
											<h6>경력</h6>
											<h4 id="val11">배</h4>
											<h6>일급</h6>


										</div>
									</div>
									<div class="col-md-4 profile-text mt mb centered"
										style="float: right;">
										<h4 id="val15">2019-05-06</h4>
										<h6>작업시작일</h6>
										<h4 id="val16">2019-05-20</h4>
										<h6>작업종료일</h6>


									</div>
								</div>

							</div>

							<div class="col-lg-12 detailed" style="text-align: center">

								<h4>내용</h4>

								<p id="val19">
									<val19> 아아아아ㅏ아아아아아아아아<br>
									얼른오세여<br>
									어ㅣㅏㅓㅏㅓ <br>
									러ㅣㅏ저;<br>
									이ㅏㅓ지ㅏㅓㅏㅣㅇㅌ<br>
									ㄷ어니ㅏㅌ처<br>
									</val19>
								</p>


							</div>

							<br> <br>
							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10" style="height: 40px;">
									<a href="apply_list.html" class="btn btn-theme02"
										style="position: absolute; right: 100px;">뒤로가기</a>
									<button class="btn btn-theme" type="submit"
										style="position: absolute; right: 20px;" id="apply_submit">지원</button>

								</div>
							</div>
						</div>
						<!--/col-lg-12 mt -->
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
