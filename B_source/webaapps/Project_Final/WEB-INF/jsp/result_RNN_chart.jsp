<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="kr">

<head>
 <meta charset="UTF-8">  
 
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
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
      <section class="wrapper site-min-height">
        <h3><i class="fa fa-angle-right"></i>RNN 분석 결과</h3>
         <div class="row mt">
          <div class="col-xs-12 col-md-8 col-md-offset-2 style="height: 700px;">
                <div class="grey-panel pn donut-chart">
                  <div class="grey-header">
                    <h5 id="title">천안-올해 예상치</h5>
                  </div>
                  <div id="thisyear_manpower"  style="height: 400px;"></div>
                  <div class="row">
                    <div class="col-sm-3 col-xs-3 goleft">
                      <p>RNN<br/></p>
                    </div>
                    <div class="col-sm-3 col-xs-3">
             
                    </div>
                    <div class="col-sm-6 col-xs-6">
                    	<p></p>
                    <div class="btn-group">
									<button type="button" class="btn btn-theme dropdown-toggle"
										data-toggle="dropdown" id="citybtn" style="float: left;">
										도시선택 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" id="city">
										<li><a href="#" data-value="0">천안</a></li>
										<li><a href="#" data-value="1">나주</a></li>
									</ul>
								</div>
                    <div class="btn-group">
									<button type="button" class="btn btn-theme02 dropdown-toggle"
										data-toggle="dropdown" id="measurebtn" style="float: left;">
										단위선택 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" id="measure">
										<li><a href="#" data-value="0">월별</a></li>
										<li><a href="#" data-value="1">년도별</a></li>
									</ul>
								</div>
					<div class="btn-group">
									<button type="button" class="btn btn-theme03 dropdown-toggle"
										data-toggle="dropdown" id="periodbtn" style="float: left;">
										기간선택 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" id="period">
										<li><a href="#" data-value="0">올해</a></li>
										<li><a href="#" data-value="1">전년도</a></li>
									</ul>
								</div>			
					<div>
						<input type="text" id="chartyear" placeholder="연도 입력후 엔터" onkeydown="search(this)">
					</div>
					</div>
                  </div>
                </div>
                <!-- /grey-panel -->
       
          </div>
          <!-- /col-md-6 -->
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
        <a href="blank.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
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
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <!--common script for all pages-->
  <script src="lib/common-scripts.js"></script>
  <!--script for this page-->
  <!-- canvasjs를 사용하기위한 스크립트 -->
  <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  <script src="lib/conf-canvasjs_for_RNN.js" type="text/javascript"></script>
<script>
	start();
</script>
  <!-- canvasjs를 사용하기위한 스크립트 끝 -->

</body>

</html>
