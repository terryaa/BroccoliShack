<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<a href="./" class="logo"><b>DASH<span>IO</span></b></a>
			<!--logo end-->
			<div class="nav notify-row" id="top_menu">
			</div>
			<div class="top-menu">
				<ul class="nav pull-right top-menu">
				</ul>
			</div>
		</header>
		<!--header end-->
		<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper site-min-height" style="background: black">
				<H1 style="font-size:60px;">
					<I CLASS="FA FA-ANGLE-RIGHT">회원가입을 축하드립니다.</I> 
				</H1>
				<br/><br/><br/><br/>
				<button class="btn btn-round btn-primary" id="mainbtn">메인으로 돌아가기</button>
			</section>
			 <!-- Modal -->
	        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
	          <div class="modal-dialog">
	            <div class="modal-content">
	              <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">Test</h4>
	              </div>
	              <div class="modal-body" id="modal-body">
	              
	              <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false" data-wrap="false">
		               <ol class="carousel-indicators">
		               </ol>
	               		<div id="imgtarget"></div>
		                <div class="carousel-inner">	
		                </div>

	              </div>
	              
	              </div>				
				  <div style="margin-left: 38%; margin-right: 30%">
				  <button id="hate" class="btn btn-round btn-primary" data-slide="next">다음</button>
	              <button id="like" class="btn btn-round btn-primary">좋아요</button>
	              </div>
	              <div class="modal-footer">
	                <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
	              </div>
	            </div>
	          </div>
	        </div>
        <!-- modal -->
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
	<!--script for this page-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function(){
			var title = $('.active').text();
			console.log(title);
			$('#imgtarget').html('<li><img scr=resources/img/'+title+'.jpg');
			$('#mainbtn').click(function(){
				location.replace('./');
			});
		});
		$('#rebtn').click(function() {
			$.getJSON('u_research/u_re.data',function(data){
				var html ='<div class="item active" style="margin-left:43%; margin-right:35%">시작 (다음버튼을 눌러주세요)</div>';
				var html1 ='<li data-target="#myCarousel" data-slide-to="0" class="active"></li>';
				var s = 1;
				let array =new Array();
				$.each(data,function(index,item){
					console.log(index+" "+item);
					console.log(item);
					html+='<div class="item" style="margin-left:43%; margin-right:35%">'+item+'</div>'
					html1+='<li data-target="#myCarousel" data-slide-to="'+s+'"></li>'
					s++;
				});
				$('.carousel-inner').html(html);
				$('.carousel-indicators').html(html1);
			});
			$('#hate').click(function() {
				$('#myCarousel').carousel('next');
			});
			$('#like').click(function(){
				var title = $('.active').text();
				$.ajax({
					url:"u_researchmovie?title="+title
				});
				$('#myCarousel').carousel('next');
			})
		});
	</script>
</body>

</html>