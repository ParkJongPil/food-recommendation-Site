<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['방문날짜', '${legend}'],
        <%--
        ['${visitDates[6]}', ${visitCounts[6]}],
        ['${visitDates[5]}', ${visitCounts[5]}],
        ['${visitDates[4]}', ${visitCounts[4]}],
        ['${visitDates[3]}', ${visitCounts[3]}],
        ['${visitDates[2]}', ${visitCounts[2]}],
        ['${visitDates[1]}', ${visitCounts[1]}],
        ['${visitDates[0]}', ${visitCounts[0]}]
        --%>
        <c:forEach var="i" begin="0" end="6" varStatus="st">
				  ['${visitDates[6-i]}', ${visitCounts[6-i]}],
				</c:forEach>
      ]);

      var options = {
        chart: {
          title: '${title}',
          subtitle: '${subTitle}'
        }
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
</head>
<body>
  <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
</body>
</html>