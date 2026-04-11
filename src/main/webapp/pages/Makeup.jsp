<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Makeup</title>

<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Makeup.css">

<!-- GOOGLE FONTS (IMPORTANT for premium look) -->
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">

<!-- FONT AWESOME -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">
    <div class="nav-top">
        <div class="nav-top-left">
            <span><i class="fas fa-phone"></i> +977 9820221306</span>
        </div>

        <div class="nav-brand">
            <span class="brand-name">Beauty Salon</span>
            <span class="brand-location">Kamalpokhari, Kathmandu, Nepal</span>
        </div>

        <div class="nav-top-right">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
    </div>

    <div class="nav-main">
        <div class="nav-logo">
            <!-- FIXED CLASS NAME -->
            <img src="${pageContext.request.contextPath}/public/Logo.png" 
                 alt="Shringar Logo" class="logo-img"/>
        </div>

        <ul class="nav-links">
            <li><a href="home.jsp">HOME</a></li>
            <li><a href="about.jsp">ABOUT US</a></li>
            <li><a href="services.jsp">SERVICES</a></li>
            <li class="active"><a href="gallery.jsp">GALLERY</a></li>
            <li><a href="contact.jsp">CONTACT US</a></li>
            <li><a href="appointment.jsp">APPOINTMENT</a></li>
        </ul>

        <a href="login.jsp" class="btn-login">Log in</a>
    </div>
</nav>

<!-- MAKEUP GALLERY -->
<section class="makeup-section">
    <div class="makeup-grid">

        <div class="grid-item big">
            <img src="${pageContext.request.contextPath}/public/Makeup1.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup6.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup3.png">
        </div>

        <div class="grid-item tall">
            <img src="${pageContext.request.contextPath}/public/Makeup8.png">
        </div>

        <div class="grid-item wide">
            <img src="${pageContext.request.contextPath}/public/Makeup5.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup2.png">
        </div>
        
        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup7.png">
        </div>
        
        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup4.png">
        </div>
        
        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup9.png">
        </div>
        
        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Makeup10.png">
        </div>

    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-container">

        <div class="footer-brand">
            <img src="${pageContext.request.contextPath}/public/Logo.png" class="footer-logo">
            <h3>SHRINGAR</h3>
            <p class="footer-tagline">Beauty & Wellness</p>
            <p class="footer-desc">
                Your trusted beauty destination in the heart of Kamalpokhari, Kathmandu.
                We bring elegance and care to every visit.
            </p>
        </div>

        <div class="footer-links">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="gallery.jsp">Gallery</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>

        <div class="footer-contact">
            <h4>Contact</h4>
            <p>Kamalpokhari, Kathmandu, Nepal</p>
            <p>+977-9820221306</p>
            <p>www.shringarnepal.com</p>
        </div>

    </div>

    <div class="footer-bottom">
        © 2026 Shringar Salon. All Rights Reserved.
    </div>
</footer>

</body>
</html>