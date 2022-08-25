<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>


 <!-- Automatic Slideshow Images -->
<%-- <div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/1.jpg" style="width:125%; height:600px;" class="w3-grayscale-min">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
  </div>
</div> --%>
<div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/2.jpg" style="width:125%; height:600px;" class="w3-grayscale-min">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">

  </div>
</div>
<%-- <div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/3.jpg" style="width:125%; height:600px;" class="w3-grayscale-min">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
  </div>
</div>   --%>

<script>
// Automatic Slideshow - change image every 4 seconds
var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 4000);    
}

// Used to toggle the menu on small screens when clicking on the menu button
function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}

// When the user clicks anywhere outside of the modal, close it
var modal = document.getElementById('ticketModal');
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>