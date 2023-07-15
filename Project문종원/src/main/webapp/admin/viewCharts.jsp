<%@page import="myPkg.ProductsBean"%>
<%@page import="myPkg.ProductsDao"%>
<%@page import="myPkg.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myPkg.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>GoPhone 매출정보</title>
<%@ include file = "main_top.jsp"%>
<%
	String conPath = request.getContextPath();
	OrderDao odao = OrderDao.getInstance();
	ArrayList<OrderBean> olist = odao.getOrders();
	ArrayList<OrderBean> ssList = new ArrayList<OrderBean>();
	ArrayList<OrderBean> apList = new ArrayList<OrderBean>();
	ArrayList<OrderBean> lgList = new ArrayList<OrderBean>();
	ProductsDao pdao = ProductsDao.getInstance();
	for(OrderBean ob : olist){
		String pnum = String.valueOf(ob.getPnum());
		ProductsBean pb = pdao.getProductByPnum(pnum);
		if(pb.getBrand().equals("삼성")){
			ssList.add(ob);
		} else if (pb.getBrand().equals("애플")){
			apList.add(ob);
		} else if (pb.getBrand().equals("LG")) {
			lgList.add(ob);
		}
	}
	int ssqty = 0, apqty = 0, lgqty = 0;
	int ssrev = 0, aprev = 0, lgrev = 0;
	for(OrderBean ob : ssList){
		ssqty += ob.getQty();
		ssrev += ob.getTotalPrice();
	}
	for(OrderBean ob : apList){
		apqty += ob.getQty();
		aprev += ob.getTotalPrice();
	}
	for(OrderBean ob : lgList){
		lgqty += ob.getQty();
		lgrev += ob.getTotalPrice();
	}
	ssrev = ssrev / 10000;
	aprev = aprev / 10000;
	lgrev = lgrev / 10000;
%>
<script type = "text/javascript">
window.onload = function() {
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';
var ctx = document.getElementById("piechart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["삼성", "애플", "LG"],
    datasets: [{
      data: [<%= ssqty %>, <%= apqty %>, <%= lgqty %>],
      backgroundColor: ['#4374D9', '#1cc88a', '#ED006D'],
      hoverBackgroundColor: ['#1F50B5', '#17a673', '#DB005B'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: true,
      labels: {
          color: 'rgb(255, 99, 132)'
      }
    },
    cutoutPercentage: 80,
  },
});


function number_format(number, decimals, dec_point, thousands_sep) {
	  // *     example: number_format(1234.56, 2, ',', ' ');
	  // *     return: '1 234,56'
	  number = (number + '').replace(',', '').replace(' ', '');
	  var n = !isFinite(+number) ? 0 : +number,
	    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
	    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
	    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
	    s = '',
	    toFixedFix = function(n, prec) {
	      var k = Math.pow(10, prec);
	      return '' + Math.round(n * k) / k;
	    };
	  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
	  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	  if (s[0].length > 3) {
	    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	  }
	  if ((s[1] || '').length < prec) {
	    s[1] = s[1] || '';
	    s[1] += new Array(prec - s[1].length + 1).join('0');
	  }
	  return s.join(dec);
	}

	// Bar Chart Example
	var ctx = document.getElementById("myBarChart");
	var myBarChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
	    labels: ["삼성", "애플", "LG"],
	    datasets: [{
	      label: "매출",
	      backgroundColor: "#4e73df",
	      hoverBackgroundColor: "#2e59d9",
	      borderColor: "#4e73df",
	      data: [<%= ssrev %>, <%= aprev %>, <%= lgrev %>],
	    }],
	  },
	  options: {
	    maintainAspectRatio: false,
	    layout: {
	      padding: {
	        left: 10,
	        right: 25,
	        top: 25,
	        bottom: 0
	      }
	    },
	    scales: {
	      xAxes: [{
	        time: {
	          unit: '만원'
	        },
	        gridLines: {
	          display: false,
	          drawBorder: false
	        },
	        ticks: {
	          maxTicksLimit: 6
	        },
	        maxBarThickness: 25,
	      }],
	      yAxes: [{
	        ticks: {
	          min: 0,
	          max: 3000,
	          maxTicksLimit: 5,
	          padding: 10,
	          // Include a dollar sign in the ticks
	          callback: function(value, index, values) {
	            return '₩' + number_format(value);
	          }
	        },
	        gridLines: {
	          color: "rgb(234, 236, 244)",
	          zeroLineColor: "rgb(234, 236, 244)",
	          drawBorder: false,
	          borderDash: [2],
	          zeroLineBorderDash: [2]
	        }
	      }],
	    },
	    legend: {
	    	display: true,
	        labels: {
	            color: 'rgb(255, 99, 132)'
	        }
	    },
	    tooltips: {
	      titleMarginBottom: 10,
	      titleFontColor: '#6e707e',
	      titleFontSize: 14,
	      backgroundColor: "rgb(255,255,255)",
	      bodyFontColor: "#858796",
	      borderColor: '#dddfeb',
	      borderWidth: 1,
	      xPadding: 15,
	      yPadding: 15,
	      displayColors: false,
	      caretPadding: 10,
	      callbacks: {
	        label: function(tooltipItem, chart) {
	          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	          return datasetLabel + ': ₩' + number_format(tooltipItem.yLabel) + "만원";
	        }
	      }
	    },
	  }
	});

}
</script>
	<div class="container-fluid">
	<!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">매출 보기</h1>
                 
                 
		  <div class="row">
              <div class="col-xl-8 col-lg-7">

                  <!-- Bar Chart -->
                  <div class="card shadow mb-4">
                      <div class="card-header py-3">
                          <h6 class="m-0 font-weight-bold text-primary">매출 금액</h6>
                      </div>
                      <div class="card-body">
                          <div class="chart-bar">
                              <canvas id="myBarChart"></canvas>
                          </div>
                          <hr>
                          각 브랜드 총 매출금액
                      </div>
                  </div>
              </div>
              <!-- Donut Chart -->
              <div class="col-xl-4 col-lg-5">
                  <div class="card shadow mb-4">
                      <!-- Card Header - Dropdown -->
                      <div class="card-header py-3">
                          <h6 class="m-0 font-weight-bold text-primary">판매 수</h6>
                      </div>
                      <!-- Card Body -->
                      <div class="card-body">
                          <div class="chart-pie pt-4">
                              <canvas id="piechart"></canvas>
                          </div>
                          <hr>
                          각 브랜드 폰 총 판매 수
                          <code></code>
                      </div>
                  </div>
              </div>
          </div>
	</div>
<%@ include file = "main_bottom.jsp"%>