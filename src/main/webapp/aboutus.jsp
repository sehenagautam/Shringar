<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Shringar Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=20260413-plain">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutus.css?v=20260412-1200">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <div class="nav-top">
            <div class="nav-top-left">
                <span><span class="inline-icon">Phone</span> +977 9820221306</span>
            </div>
            <div class="nav-brand">
                <span class="brand-name">Beauty Salon</span>
                <span class="brand-location">Kamalpokhari, Kathmandu, Nepal</span>
            </div>
            <div class="nav-top-right">
                <a href="#">F</a>
                <a href="#">I</a>
            </div>
        </div>
        <div class="nav-main">
            <div class="nav-logo">
                <a href="${pageContext.request.contextPath}/" aria-label="Shringar home">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="logo-img"/>
                </a>
            </div>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/services">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a></li>
                <li><a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/appointment">Appointment</a></li>
            </ul>
            <a href="${pageContext.request.contextPath}/pages/user" class="btn-login">Log in</a>
        </div>
    </nav>

    <!-- ABOUT HERO -->
    <section class="about-hero">
        <h1>About Us</h1>
    </section>

    <!-- ABOUT MAIN -->
    <section class="about-section">
        <div class="about-container">

            <!-- Hero Banner Image -->
            <div class="about-banner">
                <img src="${pageContext.request.contextPath}/images/about.png" 
     alt="Shringar Beauty Salon Hero" 
     class="about-hero">
            </div>

            <!-- Introduction -->
            <div class="about-intro-block">
                <p class="intro-label">INTRODUCTION</p>
                <h2 class="intro-title">Shringar Salon of Hair, Beauty &amp; Makeup</h2>
                <div class="intro-cols">
                    <p>Shringar is a modern beauty salon committed to delivering exceptional beauty and wellness services. We aim to create a space where clients can relax, rejuvenate, and enhance their natural beauty. With a focus on quality, hygiene, and customer satisfaction, Shringar offers a wide range of services designed to meet the diverse needs of our clients.</p>
                    <p>Salon that provides a wide range of services to help clients look and feel their best. We offer hair care services such as haircuts, styling, coloring, and treatments, along with skincare services like facials and clean-ups. In addition, we provide makeup services, manicures, pedicures, and other grooming treatments.</p>
                </div>
                <div class="intro-quote">
                    <p>"Beauty begins the moment you decide to be yourself."</p>
                </div>
            </div>

            <!-- How It All Began -->
            <div class="about-began">
                <div class="section-divider-row">
                    <span class="divider-line"></span>
                    <p class="section-label-center">HOW IT ALL BEGAN !</p>
                    <span class="divider-line"></span>
                </div>
                <div class="began-content">
                    <div class="began-img">
                        <img src="${pageContext.request.contextPath}/images/makeup3.png" 
     alt="Shringar Beauty Salon Hero" 
     class="about-hero">
                    </div>
                    <div class="began-text">
                        <p>Our story began with a simple vision — to create a premium beauty destination dedicated to artistry and personal care. What started as a small salon has grown into a trusted name in beauty and wellness across Kathmandu.</p>
                    </div>
                </div>
            </div>

            <!-- Our Mission -->
            <div class="about-mission">
                <div class="section-divider-row">
                    <span class="divider-line"></span>
                    <p class="section-label-center">OUR MISSION</p>
                    <span class="divider-line"></span>
                </div>
                <div class="mission-content">
                    <div class="mission-text">
                        <p>At Shringar, our mission is to provide high-quality beauty and grooming services that enhance confidence and well-being. We are committed to delivering personalized care, maintaining the highest standards of hygiene, and creating a relaxing environment for every client.</p>
                    </div>
                    <div class="mission-img">
                        <img src="${pageContext.request.contextPath}/images/makeup2.png" 
     alt="Shringar Beauty Salon Hero" 
     class="about-hero">
                    </div>
                </div>
            </div>

            <div class="about-team">
    <p class="team-heading">SHRINGAR TEAM MEMBERS</p>

    <div class="team-list">

        <!-- Member 1 -->
        <div class="team-item">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/images/anjelina.png">
            </div>
            <div class="team-info">
                <h3>1. Salon Manager</h3>
                <p>Handles daily operations and ensures smooth service.</p>
            </div>
        </div>

        <!-- Member 2 -->
        <div class="team-item">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/images/ojeswi.png">
            </div>
            <div class="team-info">
                <h3>2. Hair Stylist</h3>
                <p>Expert in styling, coloring, and treatments.</p>
            </div>
        </div>

        <!-- Member 3 -->
        <div class="team-item">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/images/pratyusha.png">
            </div>
            <div class="team-info">
                <h3>3. Makeup Artist</h3>
                <p>Professional makeup for events and occasions.</p>
            </div>
        </div>

        <!-- Member 4 -->
        <div class="team-item">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/images/sabya.png">
            </div>
            <div class="team-info">
                <h3>4. Beautician</h3>
                <p>Facials, skincare, and beauty treatments.</p>
            </div>
        </div>

        <!-- Member 5 -->
        <div class="team-item">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/images/about.png">
            </div>
            <div class="team-info">
                <h3>5. Nail Technician</h3>
                <p>Manicure, pedicure, and nail art expert.</p>
            </div>
        </div>

    </div>
</div>
            <!-- CTA Banner -->
            <div class="about-cta">
                <div class="cta-overlay"></div>
                <img src="${pageContext.request.contextPath}/images/makeup.png" 
     alt="Shringar Beauty Salon Hero" 
     class="about-hero">
                <div class="cta-text">
                    <h2>Your beauty journey starts here. Join Shringar for your makeover.</h2>
                </div>
            </div>

        </div>
    </section>

    <!-- FOOTER -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="footer-logo"/>
                <h3>SHRINGAR</h3>
                <p class="footer-tagline">Beauty &amp; Wellness</p>
                <p class="footer-desc">Your trusted beauty destination in the heart of Kamalpokhari, Kathmandu. We bring elegance and care to every visit.</p>
                <div class="footer-socials">
                    <a href="#">F</a>
                    <a href="#">I</a>
                </div>
            </div>
            <div class="footer-links">
                <h4>QUICK LINKS</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/appointment">Appointment</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/user">Login</a></li>
                </ul>
            </div>
            <div class="footer-contact">
                <h4>CONTACT</h4>
                <p><span class="contact-label">Location</span> Kamalpokhari, Kathmandu, Nepal</p>
                <p><span class="contact-label">Phone</span> +977-9820221306</p>
                <p><span class="contact-label">Web</span> www.shringarnepal.com</p>
                <p class="opening-hours"><strong>OPENING HOURS</strong><br/>Sunday – Saturday: 9:30 – 7PM</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Shringar Salon. All Rights Reserved.</p>
        </div>
    </footer>

</body>
</html>
