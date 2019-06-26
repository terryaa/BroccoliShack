<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="kr">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<!-- style for map -->
<link rel="stylesheet"
	href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />
<script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>

<style>
.info {
	padding: 6px 8px;
	font: 14px/16px Arial, Helvetica, sans-serif;
	background: white;
	background: rgba(255, 255, 255, 0.8);
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
}

.info h4 {
	margin: 0 0 5px;
	color: #777;
}
</style>

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
				<h3>
					<i class="fa fa-angle-right"></i> Map Page
				</h3>
				 <div id="boardlist">

                </div>
				<div id="map" style="width: 1000px; height: 580px"></div>
				<div class="row mt">
					<div class="col-lg-12">
						<p>Place your content here.</p>
					</div>
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<!--script for this page-->
	<script src="lib/skorea_municipalities_geo_simple.js"></script>
	
	<script>
      $(document).ready(function(){
    	  var labor={};
    	  
    	 //estimated labor data 받아오기 
    			$.ajax({
			url:"map_analysis",
			success:function(data){
				$.each(data,function(idx,item) {
					$.each(item,function(k,v){
						labor[k]=v;
					})
				});	
		}
}); 
    	// Creating map options //나주 천안 중간지점인 익산시 좌표를 중간으로함
          var mapOptions = {
             center: [35.833402 , 127.140656 ],
             zoom: 8
             
          }
          // Creating a map object
          var map = new L.map('map', mapOptions);
          // Creating a Layer object
          var layer = new L.TileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');
          // Adding layer to the map
          layer.addTo(map)
          
          function getColor(d) {
              return d == 'Cheonansiseobukgu' ? '#3FB222' :
                     d == 'Cheonansidongnamgu' ? '#3FB222' :
                     d == 'Naju-si'   ? '#2280B2' :
                                '#D9E0D7';
          }
          
          // 행정경계선(feature)->white, 나주와 천안은(feature.properties.name_eng=> fillcolor로 구분
          function style(feature) {
              return {
                  fillColor: getColor(feature.properties.name_eng),
                  weight: 1,
                  opacity: 1,
                  color: 'white',
                  dashArray: '3',
                  fillOpacity: 0.7
              };
          }
          
         
          function highlightFeature(e) {
              var layer = e.target; 
              if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
                  layer.bringToFront();
              }
              if(e.target.feature.properties.name_eng == "Naju-si" || e.target.feature.properties.name_eng == "Cheonansiseobukgu" || e.target.feature.properties.name_eng == "Cheonansidongnamgu"){
//             	  info.update(layer.feature.properties, labor.CN, labor.RNNCCN);
//             	  info.update({"name":"천안시"}, labor.CN, labor.RNNCN);
			info.update({"name" : layer.feature.properties.name.substr(0, 3)}, labor.CN, labor.RNNCN);
					if (e.target.feature.properties.name_eng=="Naju-si"){
						info.update(layer.feature.properties, labor.NJ, labor.RNNNJ)
					}
		              layer.setStyle({
		                  weight: 1,
		                  color: '#666',
		                  dashArray: '',
		                  fillOpacity: 0.7
		              });
				}
              console.log(e.target.feature.properties.name_eng);
              
          }
          function resetHighlight(e) {
//         	  geojson.resetStyle(e.target);
              
              info.update();
              
              
          }
          function zoomToFeature(e) {
              map.fitBounds(e.target.getBounds());
          }
          function onEachFeature(feature, layer) {
              layer.on({
                  mouseover: highlightFeature,
                  mouseout: resetHighlight,
                  click: zoomToFeature
              });
          
          }            
          
          //geojson 정보 추가하기
          function startDataLayer(geojson) {
         	  geojson = L.geoJson(statesData,{
                 style: style,
                 onEachFeature: onEachFeature
             }).addTo(map);
          }
          
        var geojson;
        startDataLayer(geojson);

        var info = L.control();
        info.onAdd = function (map) {
            this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
            this.update();
            return this._div;
        };
        // method that we will use to update the control based on feature properties passed
        info.update = function (props,labor,rnnlabor){
            this._div.innerHTML = '<b>Estimated Yearly Pear Labor Based on BigData</b><br/>' +  
           (props ? '<b>' + props.name + '</b><br />' + labor+ '</b></br>'+rnnlabor : 'Hover over to Cheonan or Naju ');
        };
        info.addTo(map);
        startDataLayer();
     
      });

      </script>
</body>

</html>
