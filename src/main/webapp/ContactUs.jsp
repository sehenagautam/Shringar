<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Shringar User Portal</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactus.css">

    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="logo-img"/>
        </div>

       
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>
            <li><a href="${pageContext.request.contextPath}/aboutus.jsp">ABOUT US</a></li>
            <li><a href="${pageContext.request.contextPath}/search">SEARCH</a></li>
            <li><a href="${pageContext.request.contextPath}/wishlist">WISHLIST</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/ContactUs.jsp">CONTACT US</a></li>
            <li><a href="${pageContext.request.contextPath}/profile">PROFILE</a></li>
        </ul>

        <a href="${pageContext.request.contextPath}/login" class="btn-login">Log in</a>
    </div>
</nav>

<!-- HERO -->
<section class="contact-hero">
    <h1>Contact Us</h1>
</section>

<!-- CONTACT SECTION -->
<section class="contact-section">
    <div class="contact-container">

        <!-- LEFT INFO -->
        <div class="contact-info">

            <div class="location-block">
                <i class="fas fa-map-marker-alt"></i>
                <div>
                    <p>Kamalpokhari, Kathmandu, Nepal</p>
                    <p>+977 98000000000</p>
                </div>
            </div>

            <div class="location-block">
                <i class="fas fa-map-marker-alt"></i>
                <div>
                    <p>Jawalakhel, Lalitpur, Nepal</p>
                    <p>+977 9812121212</p>
                </div>
            </div>

            <div class="location-block">
                <i class="fas fa-globe"></i>
                <div>
                    <p>www.shringarnepal.com</p>
                </div>
            </div>

            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
            </div>

            <!-- MAP -->
            <div class="map-container">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.3!2d85.3193!3d27.7103!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190a74c0fbb3%3A0x9fd5c4d9b5c0e5a4!2sKamalpokhari%2C%20Kathmandu!5e0!3m2!1sen!2snp!4v1"
                    width="100%" height="220" style="border:0;" allowfullscreen="" loading="lazy">
                </iframe>
            </div>

        </div>

        <!-- RIGHT FORM -->
        <div class="contact-form-box">
            <p class="form-subtitle">GET IN TOUCH.</p>
            <h2 class="form-title">How can we help you?</h2>

            <form>
                <div class="form-row">
                    <div class="form-group">
                        <label>YOUR NAME</label>
                        <input type="text" placeholder="Your name" required>
                    </div>

                    <div class="form-group">
                        <label>EMAIL</label>
                        <input type="email" placeholder="Your email" required>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label>YOUR MESSAGE</label>
                    <textarea rows="6" placeholder="Write your message here..." required></textarea>
                </div>

                <button type="button" class="btn-send">Send</button>
            </form>
        </div>

    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-container">

        <div class="footer-brand">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" class="footer-logo"/>
            <h3>SHRINGAR</h3>
            <p class="footer-tagline">Beauty & Wellness</p>
            <p class="footer-desc">
                Your trusted beauty destination in Kamalpokhari, Kathmandu.
            </p>
        </div>

        <div class="footer-links">
            <h4>QUICK LINKS</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/aboutus.jsp">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/search">Search</a></li>
                <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                <li><a href="${pageContext.request.contextPath}/ContactUs.jsp">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
            </ul>
        </div>

        <div class="footer-contact">
            <h4>CONTACT</h4>
            <p><i class="fas fa-map-marker-alt"></i> Kamalpokhari, Kathmandu</p>
            <p><i class="fas fa-phone"></i> +977-9820221306</p>
            <p><i class="fas fa-globe"></i> www.shringarnepal.com</p>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; 2026 Shringar Salon. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
