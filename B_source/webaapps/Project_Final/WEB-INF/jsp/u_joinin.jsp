<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set value="${pageContext.request.contextPath}/resources/img"
	var="resImg" />
<!DOCTYPE html>
<html>
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
				<form class="form-login" method="post" action="u_memberjoin"
					id="memF" style="height: 800px;">
					<h2 class="form-login-heading">join in now</h2>
					<br />
					<p>
						<input class="form-control" name="member_id" id="member_id"
							placeholder="아이디" style="margin: auto; width: 70%">
						&nbsp; <input class="btn btn-theme btn-block" type="button"
							id="idChkBtn" value="중복확인" style="margin: auto; width: 70%;">
					</p>
					<p id="target" style="text-align: center;"></p>
					<br />
					<p>
						<input class="form-control" type="password" name="member_password"
							id="member_password" placeholder="Password"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="text" name="member_name"
							id="member_name" placeholder="Name"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="text" name="member_gender"
							id="member_gender" placeholder="남자/여자"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="email" name="member_email"
							id="member_email" placeholder="email"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
					<input class="form-control" type="text" name="member_job_search"
							id="member_job_search" placeholder="구인자/구직자"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="text" name="member_address"
							id="member_address" placeholder="주소"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="text" name="member_phonenumber"
							id="member_phonenumber" placeholder="전화번호"
							style="margin: auto; width: 70%">
					</p>
					<br />
					<p>
						<input class="form-control" type="number"
							name="member_searchcount" id="member_searchcount"
							placeholder="구인/구직 횟수" style="margin: auto; width: 70%" min=0>
					</p>
					<br />
					<p>
						<input class="btn btn-theme btn-block" id="jbtn" type="submit"
							value="회원가입" style="margin: auto; width: 70%;">
					</p>
				</form>
			</div>
		</div>
		<!-- /MAIN CONTENT -->
		<!--main content end-->

	</section>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		var preview;
		$(document).ready(
				function() {
					document.addEventListener('keydown', function(event) {
						if (event.keyCode === 13) {
							event.preventDefault();
						}
					}, true);
					$('#target').hide();
					$('#jbtn').prop("disabled", true);//기본적으로 중복체크없이 버튼을 누르지 못하도록 회원가입 버튼을 잠궈둔다.
					$('#idChkBtn').click(
							function() {
								if ($('#member_id').val() != '') {//아무값도 입력하지 않고 중복확인을 하면 무조건 사용가능하다는 표시가 나오므로 이를 방지하기 위해 공백일 경우를 제외한다.
									$.ajax({//아이디의 중복여부를 비동기식으로 처리
										url : "u_idcheck?member_id="
												+ $('#member_id').val(),
										success : function(data) {
											if (data == 0) {
												$('#target').show().css(
														"color", "blue").text(
														"사용가능");
												$('#jbtn').prop("disabled",
														false);//중복체크시 사용가능한 아이디이면 버튼의 잠금을 풀어준다.
											} else {
												$('#target').show().css(
														"color", "red").text(
														"사용중");
												$('#jbtn').prop("disabled",
														true);//사용자가 단순변심으로 다른 아이디를 중복확인할 경우를 대비
											}
										}
									});
								} else {
									$('#jbtn').prop("disabled", true);
									$('#target').hide();
									alert("아이디를 입력해주세요");
								}
							});
					$('#member_picture').on("change", preview);//사진을 올리기 전에 미리보기형태로 띄워주는 기능을 함
				});
		function preview(e) {
			var files = e.target.files;
			var filesarr = Array.prototype.slice.call(files);

			filesarr.forEach(function(f) {
				if (!f.type.match("image.*")) {
					alert('확장자는 이미지 확장자만 가능합니다.');
					return;
				}
				preview = f;

				var reader = new FileReader();
				reader.onload = function(e) {
					$('#uimg').attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
	</script>
	<script type="text/javascript" src="lib/jquery.backstretch.min.js"></script>
	<script>
		$.backstretch("img/login-bg.jpg", {
			speed : 500
		});
	</script>
	<script>
		
	</script>
</body>

</html>