<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hair</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Hair.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <div class="nav-top">
        <div class="nav-top-left">
            <span>+977 9820221306</span>
        </div>

        <div class="nav-brand">
            <span class="brand-name">Shringar</span>
            <span class="brand-location">Kamalpokhari, Kathmandu</span>
        </div>

        <div class="nav-top-right">
            <a href="#">F</a>
            <a href="#">I</a>
        </div>
    </div>

    <div class="nav-main">
        <div class="nav-logo">
            <img src="${pageContext.request.contextPath}/public/Logo.png" class="logo-img">
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

<!-- HAIR GALLERY -->
<section class="hair-section">
    <div class="hair-grid">

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair1.png" alt="Hair 1">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair2.png" alt="Hair 2">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair3.png" alt="Hair 3">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair4.png" alt="Hair 4">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair5.png" alt="Hair 5">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair6.png" alt="Hair 6">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair7.png" alt="Hair 7">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair8.png" alt="Hair 8">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair9.png" alt="Hair 9">
        </div>

        <div class="grid-item">
            <img src="${pageContext.request.contextPath}/public/Hair10.png" alt="Hair 10">
        </div>

    </div>
</section>

<!-- FOOTER -->
<footer class="footer">

    <div class="footer-container">

        <div class="footer-brand">
            <img src="${pageContext.request.contextPath}/public/Logo.png" class="footer-logo">
            <h3>SHRINGAR</h3>
            <p class="footer-tagline">Beauty &amp; Wellness</p>
            <p class="footer-desc">
                Your trusted beauty destination in the heart of Kamalpokhari, Kathmandu.
                We bring elegance and care to every visit.
            </p>
            <div class="footer-socials">
                <a href="#">F</a>
                <a href="#">I</a>
            </div>
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
        &copy; 2026 Shringar Salon. All Rights Reserved.
    </div>

</footer>

</body>
</html>