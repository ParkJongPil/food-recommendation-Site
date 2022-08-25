<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

 <!-- Automatic Slideshow Images -->
<div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/m1.jpg" style="width:100%">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>Los Angeles</h3>
    <p><b>We had the best time playing at Venice Beach!</b></p>   
  </div>
</div>
<div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/m2.jpg" style="width:100%">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>New York</h3>
    <p><b>The atmosphere in New York is lorem ipsum.</b></p>    
  </div>
</div>
<div class="mySlides w3-display-container w3-center">
  <img src="${ctp}/images/m3.jpg" style="width:100%">
  <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
    <h3>Chicago</h3>
    <p><b>Thank you, Chicago - A night we won't forget.</b></p>    
  </div>
</div>

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