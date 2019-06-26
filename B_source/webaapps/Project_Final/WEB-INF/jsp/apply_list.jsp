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
<!-- <script src='{% static "js/jquery-1.11.3.min.js" %}'></script> -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
<script>
	var selected;
	function GetFormattedDate(d) {
		var todayTime = new Date(d);
		var month = todayTime.getMonth() + 1;
		var day = todayTime.getDate();
		var year = todayTime.getFullYear();
		return year + "/" + month + "/" + day;
	}

	$(document).ready(
			function() {
				$.ajax({
					url : "apply_list_view",
					success : function(data) {
						$.each(data, function(idx, item) {
							$('#boardlist').append(
									"<tr>" + "<td>" + item.APPLY_POST_NUMBER
											+ "</td>" + "<td>"
											+ item.APPLY_AREA + "</td>"
											+ "<td>" + item.APPLY_CROPS
											+ "</td>" + "<td>"
											+ item.APPLY_TITLE + "</td>"
											+ "<td>" + item.APPLY_CAREER
											+ "</td>" + "</tr>");
						});

					}

				});

				$(document.body).delegate('tr', 'click', function() {
					selected = $(this).children().eq(0).text();
					location.href = 'apply_board?num=' + selected;
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

		<!--sidebar end-->
		<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper">
				<h3>
					<i class="fa fa-angle-right"></i> 채용정보
				</h3>



				<div class="form-panel">
					<form action="#" class="form-horizontal style-form">
						<h4>구인</h4>
						<a href="apply_insert.html" class="btn btn-success"
							style="float: right;">글쓰기</a>

						<!-- page start-->

						<div class="content-panel">

							<table class="table" id="taginserttable">
								<thead>
									<tr>
										<th>게시판번호</th>
										<th>지역</th>
										<th>희망업종</th>
										<th>제목</th>
										<th>경력</th>
									</tr>
								</thead>
								<tbody id="boardlist">

								</tbody>
							</table>
						</div>

					</form>
					<br> <br>
				</div>


			</section>
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
