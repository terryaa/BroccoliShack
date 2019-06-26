<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword"
	content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<c:if test="${sessionScope.uid != null }">
<meta http-equiv='refresh' content='0;url=u_main'>
</c:if>

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
			<a href="./" class="logo"><b>KKPS<span>LH</span></b></a>
			<!--logo end-->
		</header>
		<!--header end-->
		<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
		<!--main content start-->
		<div id="login-page">
			<div class="container">
				<form class="form-login" action="u_loginProcess" method="post">
					<h2 class="form-login-heading">sign in now</h2>
					<div class="login-wrap">
						<input type="text" name="member_id"  id="member_id" class="form-control" placeholder="User ID" autofocus> <br> 
						<input type="password" name="member_password" id="member_password" class="form-control" placeholder="Password"> 
						<label class="checkbox"></label>
						
						<button class="btn btn-theme btn-block" type="submit">LOG IN</button>
						<hr>
						<div class="registration">
							Don't have an account yet?<br /> <a class="" href="u_joinin">
								Create an account </a>
						</div>
					</div>
					<!-- Modal -->
					<div aria-hidden="true" aria-labelledby="myModalLabel"
						role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title">Forgot Password ?</h4>
								</div>
								<div class="modal-body">
									<p>Enter your e-mail address below to reset your password.</p>
									<input type="text" name="email" placeholder="Email"
										autocomplete="off" class="form-control placeholder-no-fix">
								</div>
								<div class="modal-footer">
									<button data-dismiss="modal" class="btn btn-default"
										type="button">Cancel</button>
									<button class="btn btn-theme" type="button">Submit</button>
								</div>
							</div>
						</div>
					</div>
					<!-- modal -->
				</form>
			</div>
		</div>
		<!-- js placed at the end of the document so the pages load faster -->
		<script src="lib/jquery/jquery.min.js"></script>
		<script src="lib/bootstrap/js/bootstrap.min.js"></script>
		<!--BACKSTRETCH-->
		<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
		<script type="text/javascript" src="lib/jquery.backstretch.min.js"></script>
		<script>
			$.backstretch("img/login-bg.jpg", {
				speed : 500
			});
		</script>
</body>

</html>