<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
    <style>
       .star {
    position: relative;
    font-size: 2rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    opacity: 0;
    cursor: pointer;
  }
  
  .star span {
    width: 0;
    position: absolute; 
    left: 0;
    color: red;
    overflow: hidden;
    pointer-events: none;
  }
    </style>
</head>
<body>
    <span class="star">
  	★★★★★
  	<span>★★★★★</span>
  <input type="range" id="starRating" oninput="drawStar(this)" value="0" step="0.5" min="0" max="5">
</span>

    <script>
    const drawStar = (target) => {
    	
    	const starSpan = document.querySelector('.star span');
        starSpan.style.width = target.value * 20 + '%';
        console.log(target.value);
      }
    
    
    const starRating = document.querySelector('.star');

    starRating.addEventListener('mouseenter', () => {
        starRating.addEventListener('mousemove', starRatingOnMouseMove);
    });

    starRating.addEventListener('mouseleave', () => {
        starRating.removeEventListener('mousemove', starRatingOnMouseMove);
    });
    
   	starRating.addEventListener('mouseleave',starRatingOnMouseLeave);
    

    function starRatingOnMouseMove(event) {
        const rect = starRating.getBoundingClientRect();
        const starWidth = rect.width / 10;
        const mouseX = event.clientX - rect.left;
        const rating = Math.min(10, Math.ceil(mouseX / starWidth) * 0.5);

        const starSpan = document.querySelector('.star span');
        starSpan.style.width = rating * 20 + '%';
       
        console.log(event.target.value);
    }
    
    function starRatingOnMouseLeave(event) {
    	let starRatingInput = document.getElementById('starRating');
    	let starSpan = document.querySelector('.star span');
    	let rating = starRatingInput.value * 20;
    	console.log("leave");
    	starSpan.style.width = rating + "%";
    }
    
    
    
    </script>
</body>
</html>