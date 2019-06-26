<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="kr">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword"
	content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>KKPSLH</title>

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="css/zabuto_calendar.css">
  <link rel="stylesheet" type="text/css" href="lib/gritter/css/jquery.gritter.css" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet">
  <script src="lib/chart-master/Chart.js"></script>


<!-- map -->

<link rel="stylesheet"
	href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />
<script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>

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
			<li><a class="logout" href="u_logout">LogOut</a></li>
        </ul>
      	</c:when>
      </c:choose>
        
      </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <div class="row">
          <div class="col-lg-9 main-chart">
          
          <!-- Map Start -->
          <h3>Pear Labor Data Analysis Map of Cheonan and Naju</h3>
          <div id="map" style="width: 1000px; height: 580px"></div>
          
            <!--CUSTOM CHART START -->
            <div class="border-head">
              <h3>USER VISITS</h3>
            </div>
<!--             <div class="custom-bar-chart"> -->
<!--               <ul class="y-axis"> -->
<!--                 <li><span>10.000</span></li> -->
<!--                 <li><span>8.000</span></li> -->
<!--                 <li><span>6.000</span></li> -->
<!--                 <li><span>4.000</span></li> -->
<!--                 <li><span>2.000</span></li> -->
<!--                 <li><span>0</span></li> -->
<!--               </ul> -->
<!--               <div class="bar"> -->
<!--                 <div class="title">JAN</div> -->
<!--                 <div class="value tooltips" data-original-title="8.500" data-toggle="tooltip" data-placement="top">85%</div> -->
<!--               </div> -->
<!--               <div class="bar "> -->
<!--                 <div class="title">FEB</div> -->
<!--                 <div class="value tooltips" data-original-title="5.000" data-toggle="tooltip" data-placement="top">50%</div> -->
<!--               </div> -->
<!--               <div class="bar "> -->
<!--                 <div class="title">MAR</div> -->
<!--                 <div class="value tooltips" data-original-title="6.000" data-toggle="tooltip" data-placement="top">60%</div> -->
<!--               </div> -->
<!--               <div class="bar "> -->
<!--                 <div class="title">APR</div> -->
<!--                 <div class="value tooltips" data-original-title="4.500" data-toggle="tooltip" data-placement="top">45%</div> -->
<!--               </div> -->
<!--               <div class="bar"> -->
<!--                 <div class="title">MAY</div> -->
<!--                 <div class="value tooltips" data-original-title="3.200" data-toggle="tooltip" data-placement="top">32%</div> -->
<!--               </div> -->
<!--               <div class="bar "> -->
<!--                 <div class="title">JUN</div> -->
<!--                 <div class="value tooltips" data-original-title="6.200" data-toggle="tooltip" data-placement="top">62%</div> -->
<!--               </div> -->
<!--               <div class="bar"> -->
<!--                 <div class="title">JUL</div> -->
<!--                 <div class="value tooltips" data-original-title="7.500" data-toggle="tooltip" data-placement="top">75%</div> -->
<!--               </div> -->
<!--             </div> -->
<!--             custom chart end -->
<!--             <div class="row mt"> -->
<!--               SERVER STATUS PANELS -->
<!--               <div class="col-md-4 col-sm-4 mb"> -->
<!--                 <div class="grey-panel pn donut-chart"> -->
<!--                   <div class="grey-header"> -->
<!--                     <h5>SERVER LOAD</h5> -->
<!--                   </div> -->
<%--                   <canvas id="serverstatus01" height="120" width="120"></canvas> --%>
<!-- <!--                   <script> --> 
<!-- //                     var doughnutData = [{ -->
<!-- //                         value: 70, -->
<!-- //                         color: "#FF6B6B" -->
<!-- //                       }, -->
<!-- //                       { -->
<!-- //                         value: 30, -->
<!-- //                         color: "#fdfdfd" -->
<!-- //                       } -->
<!-- //                     ]; -->
<!-- //                     var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData); -->
<!-- <!--                   </script> --> 
<!--                   <div class="row"> -->
<!--                     <div class="col-sm-6 col-xs-6 goleft"> -->
<!--                       <p>Usage<br/>Increase:</p> -->
<!--                     </div> -->
<!--                     <div class="col-sm-6 col-xs-6"> -->
<!--                       <h2>21%</h2> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--                 /grey-panel -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--               <div class="col-md-4 col-sm-4 mb"> -->
<!--                 <div class="darkblue-panel pn"> -->
<!--                   <div class="darkblue-header"> -->
<!--                     <h5>DROPBOX STATICS</h5> -->
<!--                   </div> -->
<%--                   <canvas id="serverstatus02" height="120" width="120"></canvas> --%>
<!-- <!--                   <script> --> 
<!-- //                     var doughnutData = [{ -->
<!-- //                         value: 60, -->
<!-- //                         color: "#1c9ca7" -->
<!-- //                       }, -->
<!-- //                       { -->
<!-- //                         value: 40, -->
<!-- //                         color: "#f68275" -->
<!-- //                       } -->
<!-- //                     ]; -->
<!-- //                     var myDoughnut = new Chart(document.getElementById("serverstatus02").getContext("2d")).Doughnut(doughnutData); -->
<!-- <!--                   </script> --> 
<!--                   <p>April 17, 2014</p> -->
<!--                   <footer> -->
<!--                     <div class="pull-left"> -->
<!--                       <h5><i class="fa fa-hdd-o"></i> 17 GB</h5> -->
<!--                     </div> -->
<!--                     <div class="pull-right"> -->
<!--                       <h5>60% Used</h5> -->
<!--                     </div> -->
<!--                   </footer> -->
<!--                 </div> -->
<!--                  /darkblue panel -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--               <div class="col-md-4 col-sm-4 mb"> -->
<!--                 REVENUE PANEL -->
<!--                 <div class="green-panel pn"> -->
<!--                   <div class="green-header"> -->
<!--                     <h5>REVENUE</h5> -->
<!--                   </div> -->
<!--                   <div class="chart mt"> -->
<!--                     <div class="sparkline" data-type="line" data-resize="true" data-height="75" data-width="90%" data-line-width="1" data-line-color="#fff" data-spot-color="#fff" data-fill-color="" data-highlight-line-color="#fff" data-spot-radius="4" data-data="[200,135,667,333,526,996,564,123,890,464,655]"></div> -->
<!--                   </div> -->
<!--                   <p class="mt"><b>$ 17,980</b><br/>Month Income</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--             </div> -->
<!--             /row -->
<!--             <div class="row"> -->
<!--               WEATHER PANEL -->
<!--               <div class="col-md-4 mb"> -->
<!--                 <div class="weather pn"> -->
<!--                   <i class="fa fa-cloud fa-4x"></i> -->
<!--                   <h2>11ÃÂº C</h2> -->
<!--                   <h4>BUDAPEST</h4> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--               DIRECT MESSAGE PANEL -->
<!--               <div class="col-md-8 mb"> -->
<!--                 <div class="message-p pn"> -->
<!--                   <div class="message-header"> -->
<!--                     <h5>DIRECT MESSAGE</h5> -->
<!--                   </div> -->
<!--                   <div class="row"> -->
<!--                     <div class="col-md-3 centered hidden-sm hidden-xs"> -->
<!--                       <img src="img/ui-danro.jpg" class="img-circle" width="65"> -->
<!--                     </div> -->
<!--                     <div class="col-md-9"> -->
<!--                       <p> -->
<!--                         <name>Dan Rogers</name> -->
<!--                         sent you a message. -->
<!--                       </p> -->
<!--                       <p class="small">3 hours ago</p> -->
<!--                       <p class="message">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p> -->
<!--                       <form class="form-inline" role="form"> -->
<!--                         <div class="form-group"> -->
<!--                           <input type="text" class="form-control" id="exampleInputText" placeholder="Reply Dan"> -->
<!--                         </div> -->
<!--                         <button type="submit" class="btn btn-default">Send</button> -->
<!--                       </form> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--                 /Message Panel -->
<!--               </div> -->
<!--               /col-md-8  -->
<!--             </div> -->
<!--             <div class="row"> -->
<!--               TWITTER PANEL -->
<!--               <div class="col-md-4 mb"> -->
<!--                 <div class="twitter-panel pn"> -->
<!--                   <i class="fa fa-twitter fa-4x"></i> -->
<!--                   <p>Dashio is here! Take a look and enjoy this new Bootstrap Dashboard theme.</p> -->
<!--                   <p class="user">@Alvrz_is</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--               <div class="col-md-4 mb"> -->
<!--                 WHITE PANEL - TOP USER -->
<!--                 <div class="white-panel pn"> -->
<!--                   <div class="white-header"> -->
<!--                     <h5>TOP USER</h5> -->
<!--                   </div> -->
<!--                   <p><img src="img/ui-zac.jpg" class="img-circle" width="50"></p> -->
<!--                   <p><b>Zac Snider</b></p> -->
<!--                   <div class="row"> -->
<!--                     <div class="col-md-6"> -->
<!--                       <p class="small mt">MEMBER SINCE</p> -->
<!--                       <p>2012</p> -->
<!--                     </div> -->
<!--                     <div class="col-md-6"> -->
<!--                       <p class="small mt">TOTAL SPEND</p> -->
<!--                       <p>$ 47,60</p> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--               <div class="col-md-4 mb"> -->
<!--                 INSTAGRAM PANEL -->
<!--                 <div class="instagram-panel pn"> -->
<!--                   <i class="fa fa-instagram fa-4x"></i> -->
<!--                   <p>@THISISYOU<br/> 5 min. ago -->
<!--                   </p> -->
<!--                   <p><i class="fa fa-comment"></i> 18 | <i class="fa fa-heart"></i> 49</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--             </div> -->
<!--             /row -->
<!--             <div class="row"> -->
<!--               <div class="col-lg-4 col-md-4 col-sm-4 mb"> -->
<!--                 <div class="product-panel-2 pn"> -->
<!--                   <div class="badge badge-hot">HOT</div> -->
<!--                   <img src="img/product.jpg" width="200" alt=""> -->
<!--                   <h5 class="mt">Flat Pack Heritage</h5> -->
<!--                   <h6>TOTAL SALES: 1388</h6> -->
<!--                   <button class="btn btn-small btn-theme04">FULL REPORT</button> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--                PROFILE 02 PANEL -->
<!--               <div class="col-lg-4 col-md-4 col-sm-4 mb"> -->
<!--                 <div class="content-panel pn"> -->
<!--                   <div id="profile-02"> -->
<!--                     <div class="user"> -->
<!--                       <img src="img/friends/fr-06.jpg" class="img-circle" width="80"> -->
<!--                       <h4>DJ SHERMAN</h4> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                   <div class="pr2-social centered"> -->
<!--                     <a href="#"><i class="fa fa-twitter"></i></a> -->
<!--                     <a href="#"><i class="fa fa-facebook"></i></a> -->
<!--                     <a href="#"><i class="fa fa-dribbble"></i></a> -->
<!--                   </div> -->
<!--                 </div> -->
<!--                 /panel -->
<!--               </div> -->
<!--               / col-md-4 -->
<!--               <div class="col-md-4 col-sm-4 mb"> -->
<!--                 <div class="green-panel pn"> -->
<!--                   <div class="green-header"> -->
<!--                     <h5>DISK SPACE</h5> -->
<!--                   </div> -->
<%--                   <canvas id="serverstatus03" height="120" width="120"></canvas> --%>
<!-- <!--                   <script> --> 
<!-- //                     var doughnutData = [{ -->
<!-- //                         value: 60, -->
<!-- //                         color: "#2b2b2b" -->
<!-- //                       }, -->
<!-- //                       { -->
<!-- //                         value: 40, -->
<!-- //                         color: "#fffffd" -->
<!-- //                       } -->
<!-- //                     ]; -->
<!-- //                     var myDoughnut = new Chart(document.getElementById("serverstatus03").getContext("2d")).Doughnut(doughnutData); -->
<!-- <!--                   </script> --> 
<!--                   <h3>60% USED</h3> -->
<!--                 </div> -->
<!--               </div> -->
<!--               /col-md-4 -->
<!--             </div> -->
<!--             /row -->
          </div>
        </div>
<!--         /row -->
<!--       </section> -->
    </section>
<!--     main content end -->
<!--     footer start -->
<!--     <footer class="site-footer"> -->
<!--       <div class="text-center"> -->
<!--         <p> -->
<!--           &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved -->
<!--         </p> -->
<!--         <div class="credits"> -->
<!--          
<!--             You are NOT allowed to delete the credit link to TemplateMag with free version. -->
<!--             You can delete the credit link only if you bought the pro version. -->
<!--             Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/ -->
<!--             Licensing information: https://templatemag.com/license/ -->
<!--           --> -->
<!--           Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a> -->
<!--         </div> -->
<!--         <a href="index.html#" class="go-top"> -->
<!--           <i class="fa fa-angle-up"></i> -->
<!--           </a> -->
<!--       </div> -->
<!--     </footer> -->
<!--     footer end -->
  </section>
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="lib/jquery/jquery.min.js"></script>

  <script src="lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <script src="lib/jquery.sparkline.js"></script>
  <!--common script for all pages -->
  <script src="lib/common-scripts.js"></script>
  <script type="text/javascript" src="lib/gritter/js/jquery.gritter.js"></script>
  <script type="text/javascript" src="lib/gritter-conf.js"></script>
  <!--script for this page-->
  <script src="lib/sparkline-chart.js"></script>
  <script src="lib/zabuto_calendar.js"></script>
  <script type="application/javascript">
    $(document).ready(function() {
      $("#date-popover").popover({
        html: true,
        trigger: "manual"
      });
      $("#date-popover").hide();
      $("#date-popover").click(function(e) {
        $(this).hide();
      });

      $("#my-calendar").zabuto_calendar({
        action: function() {
          return myDateFunction(this.id, false);
        },
        action_nav: function() {
          return myNavFunction(this.id);
        },
        ajax: {
          url: "show_data.php?action=1",
          modal: true
        },
        legend: [{
            type: "text",
            label: "Special event",
            badge: "00"
          },
          {
            type: "block",
            label: "Regular event",
          }
        ]
      });
    });

    function myNavFunction(id) {
      $("#date-popover").hide();
      var nav = $("#" + id).data("navigation");
      var to = $("#" + id).data("to");
      console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
    }
  </script>
  
  
  <!-- script for Map -->
  <script src="lib/skorea_municipalities_geo_simple.js"></script>
	
	<script>
      $(document).ready(function(){
    	  var labor={};
    	  
    	 //estimated labor data 받아오기 
    			$.ajax({
			url:"index",
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
           //천안시 행정구역이 2개로 나누어져 있으므로 출력할때  천안시+ 00구에서 '00구' 를 잘라서 출력  
            	  info.update({"name":layer.feature.properties.name.substr(0,3)}, labor.CN, labor.RNNCN);
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
           (props ? '<b>' + props.name + '</b><br/> Regression : ' + labor+ '</b></br> RNN : '+rnnlabor : 'Hover over to Cheonan or Naju ');
        };
        info.addTo(map);
        startDataLayer();
     
      });

      </script>
</body>

</html>
