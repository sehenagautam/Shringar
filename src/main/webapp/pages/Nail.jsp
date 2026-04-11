<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nail</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Nail.css">

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <div class="nav-top">
        <div>+977 9820221306</div>

        <div class="nav-brand">
            <div class="brand-name">Beauty Salon</div>
            <div class="brand-location">Kamalpokhari, Kathmandu</div>
        </div>

        <div class="nav-top-right">
            <a href="#">F</a>
            <a href="#">I</a>
        </div>
    </div>

    <div class="nav-main">
        <div>
            <img src="${pageContext.request.contextPath}/public/Logo.png" class="Logo-img">
        </div>

        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li class="active"><a href="gallery.jsp">Gallery</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>

        <a href="login.jsp" class="btn-login">Log in</a>
    </div>

</nav>

<!-- NAIL GALLERY -->
<section class="nail-section">

    <div class="nail-grid">

        <!-- BIG IMAGE -->
        <div class="grid-item big">
            <img src="${pageContext.request.contextPath}/public/Nail1.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail2.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail3.png">
        </div>

        <div class="grid-item tall">
            <img src="${pageContext.request.contextPath}/public/Nail4.png">
        </div>

        <div class="grid-item wide">
            <img src="${pageContext.request.contextPath}/public/Nail5.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail6.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail7.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail8.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail9.png">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Nail10.png">
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
                <li><a href="index.jsp">Home</a></li>
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