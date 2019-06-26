var days = [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
				'Saturday', 'Sunday' ];
		var months = [ "January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November",
				"December" ];
		var date = new Date();
		var array = new Array();
		var year_selected=2009;
		var thisyear_manpower_cn=[];
		var pastyear_manpower_cn=[];
		var thisyear_manpower_nj=[];
		var pastyear_manpower_nj=[];
		var thisyear_manpower__cn_aggr;
		var thisyear_manpower__nj_aggr;
		var allyear_manpower_cn_byyear=[];
		var allyear_manpower_nj_byyear=[];
		var city_selected=0,measure_selected=0,period_selected=0;
		var thisyear_manpower_chart;
		var min_year;

function start() {
	window.onload=function(){
		loadData();
		
		$('#city a').on('click',function(e) {
			city_selected=$(this).data('value');
			
			RenderChart();
			$('#citybtn').html($(this).text() + "<span class='caret'></span>");

		});
		$('#measure a').on('click',function(e) {
			measure_selected=$(this).data('value');
			RenderChart();
			$('#measurebtn').html($(this).text() + "<span class='caret'></span>");

		});
		$('#period a').on('click',function(e) {

			period_selected=$(this).data('value');
			RenderChart();
			$('#periodbtn').html($(this).text() + "<span class='caret'></span>");

		});

		thisyear_manpower_chart=new CanvasJS.Chart("thisyear_manpower", {

			exportEnabled: true,
			animationEnabled : true,
			animationDuration : 1000,
			theme : "light2",
			title : {
				text : "필요한 인력 수(명)"
			},
			axisY : {
				includeZero : false
			},
			axisY2:{},
			legend:{},
			toolTip:{shared : true},
			
			data : [ {
				type : "column",
				dataPoints : thisyear_manpower_cn
			
			}]
		});
		thisyear_manpower_chart.render();
	}
};
function getSelect_Xaxis(selected){
	
}
function getManpower_Data(year_selected) {
	var manpower;
	 $.ajax({
       url: "/Project_Final/getManpower?year="+year_selected,
       success: function (data,status) {
       	manpower=data;
       },
       error:function(e){
           alert(e);
       },
       async:false
   });
	 return manpower;
};
function split_years(manpower){
	var thisyear=date.getFullYear();
	var count=0;
	var aggregate=0;
	for(var dict of manpower){
		
		count++;
		
		//천안
		if(dict["city"]=="cn"){
			//올해
			if( (dict["ym"]/100)>thisyear ){
				thisyear_manpower_cn.push({label:months[dict["ym"]%100-1], y:dict["manpower"]})
				pastyear_manpower_cn.push({label:dict["ym"]/100,y:dict["manpower"]})
			}
			//전년도
			else{
				pastyear_manpower_cn.push({label:dict["ym"]/100,y:dict["manpower"]})
			}
			aggregate+=dict["manpower"]
			if(count==12){
				allyear_manpower_cn_byyear.push({label:parseInt(dict["ym"]/100, 10),y:aggregate});
				aggregate=0;
				count=0;
			}
		}
		//나주
		else{
			//올해
			if( (dict["ym"]/100) >thisyear ){
				thisyear_manpower_nj.push({label:months[dict["ym"]%100-1], y:dict["manpower"]})
			}
			//전년도
			else{
				pastyear_manpower_nj.push({label:dict["ym"]/100,y:dict["manpower"]})
			}
			aggregate+=dict["manpower"]
			if(count==12){
				allyear_manpower_nj_byyear.push({label:parseInt(dict["ym"]/100, 10),y:aggregate});
				aggregate=0;
				count=0;
			}
		}
	}
}
function RenderChart(){
	//천안
	if(city_selected==0){
		//올해
		if(period_selected==0){
			//월별
			if(measure_selected==0){
				thisyear_manpower_chart.options.data[0].dataPoints=thisyear_manpower_cn;
			}
			//년별
			else{
				temp=new Array();
				temp.push(allyear_manpower_cn_byyear[allyear_manpower_cn_byyear.length-1]);
				thisyear_manpower_chart.options.data[0].dataPoints=temp;
			}
		//전년도
		}else{
			//월별
			if(measure_selected==0){
				thisyear_manpower_chart.options.data[0].dataPoints=pastyear_manpower_cn;
			}
			//년도별
			else{
				thisyear_manpower_chart.options.data[0].dataPoints=allyear_manpower_cn_byyear;
				}
			}
	//나주
	}else{
		//올해
		if(period_selected==0){
			//월별
			if(measure_selected==0){
				thisyear_manpower_chart.options.data[0].dataPoints=thisyear_manpower_nj;
			}
			//년도별
			else{
				temp=new Array();
				temp.push(allyear_manpower_nj_byyear[allyear_manpower_nj_byyear.length-1]);
				thisyear_manpower_chart.options.data[0].dataPoints=temp;
			}
		//전년도
		}else{
			//월별
			if(measure_selected==0){
				thisyear_manpower_chart.options.data[0].dataPoints=pastyear_manpower_nj;
			}
			//년도별
			else{
				thisyear_manpower_chart.options.data[0].dataPoints=allyear_manpower_nj_byyear;
			}
		}
	}
	thisyear_manpower_chart.options.animationEnabled = true;
    thisyear_manpower_chart.render();
}
function search(ele) {
    if(event.key === 'Enter') {
    	year_selected=ele.value;
    	loadData();
    	RenderChart();
    }
}
function loadData(){
	let manpower=getManpower_Data(year_selected);
	split_years(manpower);
}