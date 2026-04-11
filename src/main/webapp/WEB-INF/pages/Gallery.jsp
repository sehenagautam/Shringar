<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Shringar Beauty Salon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/gallery.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>

<!-- ===== TOP BAR ===== -->
<div class="top-bar">
    <div class="top-bar-left">
        <strong>9823603</strong>
        <span>213, Anjelina</span>
    </div>

    <div class="top-bar-center">
        <h1>Beauty Salon</h1>
        <p>Kamalpokhari, Kathmandu, Nepal</p>
    </div>

    <div class="top-bar-right">
        <a href="https://www.facebook.com" target="_blank" class="social-btn fb" title="Facebook">f</a>
        <a href="https://www.instagram.com" target="_blank" class="social-btn ig" title="Instagram">
            <!-- Instagram icon using unicode -->
            &#9711;
        </a>
    </div>
</div>

<!-- ===== NAVBAR ===== -->
<nav class="navbar">
    <div class="navbar-logo">
        <%-- Replace the div below with: <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo"> --%>
        <div class="logo-placeholder">श्रृंगार<br>BEAUTY<br>SALON</div>
    </div>

    <ul class="navbar-menu">
        <li><a href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>
        <li><a href="${pageContext.request.contextPath}/about.jsp">ABOUT US</a></li>
        <li><a href="${pageContext.request.contextPath}/services.jsp">SERVICES</a></li>
        <li><a href="${pageContext.request.contextPath}/gallery.jsp" class="active">GALLERY</a></li>
        <li class="dropdown">
            <a href="${pageContext.request.contextPath}/contact.jsp">
                CONTACT US <span class="dropdown-icon">&#9660;</span>
            </a>
        </li>
        <li><a href="${pageContext.request.contextPath}/appointment.jsp">APPOINTMENT</a></li>
        <li>
            <a href="${pageContext.request.contextPath}/login.jsp" class="navbar-login-btn">Log in</a>
        </li>
    </ul>
</nav>

<!-- ===== HERO BANNER ===== -->
<section class="gallery-hero">
    <%-- Replace the div below with an actual image: --%>
    <%-- <img src="${pageContext.request.contextPath}/images/gallery-hero.jpg" alt="Gallery Banner"> --%>
    <div class="gallery-hero-placeholder">
        <%-- Placeholder simulating the salon interior photo --%>
    </div>
    <div class="gallery-hero-overlay">
        <h2 class="gallery-hero-title">Gallery</h2>
    </div>
</section>

<!-- ===== GALLERY CATEGORIES SECTION ===== -->
<section class="gallery-section">
    <div class="gallery-categories">

        <!-- MAKEUP CARD -->
        <div class="gallery-card">
            <%-- Replace the div below with: <img src="${pageContext.request.contextPath}/images/gallery-makeup.jpg" alt="Makeup"> --%>
            <div class="gallery-card-placeholder makeup-bg">Makeup Image</div>
            <span class="gallery-card-label">Makeup</span>
        </div>

        <!-- HAIR CARD -->
        <div class="gallery-card">
            <%-- Replace the div below with: <img src="${pageContext.request.contextPath}/images/gallery-hair.jpg" alt="Hair"> --%>
            <div class="gallery-card-placeholder hair-bg">Hair Image</div>
            <span class="gallery-card-label">Hair</span>
        </div>

        <!-- NAIL CARD -->
        <div class="gallery-card">
            <%-- Replace the div below with: <img src="${pageContext.request.contextPath}/images/gallery-nail.jpg" alt="Nail"> --%>
            <div class="gallery-card-placeholder nail-bg">Nail Image</div>
            <span class="gallery-card-label">Nail</span>
        </div>

    </div>
</section>

<!-- ===== FOOTER ===== -->
<footer class="footer">
    <div class="footer-top">

        <!-- BRAND COLUMN -->
        <div class="footer-brand">
            <div class="footer-brand-header">
                <%-- Replace div below with: <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" style="height:65px;"> --%>
                <div class="footer-logo-placeholder">श्रृंगार<br>BEAUTY<br>SALON</div>
                <div>
                    <div class="footer-brand-name">SHRINGAR</div>
                    <div class="footer-brand-tagline">Beauty &amp; Wellness</div>
                </div>
            </div>
            <p class="footer-brand-desc">
                Your trusted beauty destination in the heart of Kamalpokhari, Kathmandu.
                We bring elegance and care to every visit.
            </p>
        </div>

        <!-- QUICK LINKS COLUMN -->
        <div class="footer-links">
            <h4>Quick Links</h4>
            <div class="footer-links-row">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/gallery.jsp">Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/appointment.jsp">Appointment</a></li>
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
                </ul>
                <!-- Facebook Followers Box -->
                <div class="footer-social-box">
                    <div class="footer-social-logo">श्रृंगार</div>
                    <div class="footer-social-box-name">SHRINGAR</div>
                    <div class="footer-social-box-followers">20K FOLLOWERS</div>
                    <button class="footer-follow-btn">&#9654; Follow Page</button>
                </div>
            </div>
        </div>

        <!-- CONTACT COLUMN -->
        <div class="footer-contact">
            <!-- Phone icon at top -->
            <div class="footer-contact-phone">
                <span class="footer-phone-icon">&#9742;</span>
            </div>
            <h4>Contact</h4>

            <div class="footer-contact-item">
                <span class="footer-contact-icon">&#9679;</span>
                <span>Kamalpokhari, Kathmandu, Nepal</span>
            </div>

            <div class="footer-contact-item">
                <span class="footer-contact-icon"></span>
                <span>+977-9820221306</span>
            </div>

            <div class="footer-contact-item">
                <span class="footer-contact-icon">&#9679;</span>
                <a href="http://www.shringarnepal.com" target="_blank">www.shringarnepal.com</a>
            </div>

            <div class="footer-opening">
                <strong>OPENING HOURS</strong>
                <span>Sunday - Saturday: 9:30 - 7PM</span>
            </div>
        </div>

    </div><!-- /footer-top -->

    <!-- FOOTER BOTTOM -->
    <div class="footer-bottom">
        <div class="footer-bottom-social">
            <a href="https://www.facebook.com" target="_blank" class="social-btn fb" title="Facebook">f</a>
            <a href="https://www.instagram.com" target="_blank" class="social-btn ig" title="Instagram">&#9711;</a>
        </div>
        <p class="footer-copyright">@ 2026 Shringar Salon. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
