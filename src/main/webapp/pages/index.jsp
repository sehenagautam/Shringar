<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shringar Beauty & Wellness</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?v=20260413-plain">
</head>
<body>
    <div class="page-shell">
        <!-- Public landing page navigation stays shared with the rest of the brochure pages. -->
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
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="logo-img">
                    </a>
                </div>

                <ul class="nav-links">
                    <li class="active"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/search">Search</a></li>
                </ul>

                <a href="${pageContext.request.contextPath}/login" class="btn-login">Log in</a>
            </div>
        </nav>

        <main>
            <!-- Hero starts with the main booking action instead of a marketing-only banner. -->
            <section class="home-banner" id="home">
                <img class="banner-image" src="${pageContext.request.contextPath}/public/mainhomepage.png" alt="Woman posing after salon styling">
                <div class="banner-copy">
                    <p class="section-tag">Beauty Salon</p>
                    <h1>
                        <span>Beauty begins the</span>
                        <span>moment you decide to be</span>
                        <span>yourself.</span>
                    </h1>
                    <p class="banner-text">
                        A refined space for hair, makeup, and nail artistry where every appointment
                        is designed to help you feel polished, confident, and celebrated.
                    </p>
                    <div class="banner-actions">
                        <a class="primary-button" href="${pageContext.request.contextPath}/login">Book Now</a>
                        <a class="secondary-button" href="${pageContext.request.contextPath}/pages/services">View Service</a>
                    </div>
                </div>
            </section>

            <!-- Intro is the short brand story before we move into services and proof. -->
            <section class="intro" id="about">
                <p class="section-tag">Welcome To Shringar</p>
                <h2>Elevating Hair, Makeup &amp; Nail Beauty</h2>
                <p>
                    At Shringar Makeup, Hair &amp; Nails, we celebrate beauty at its finest with
                    carefully delivered services in makeup, hairstyling, and nail care.
                </p>
                <p>
                    Whether you are planning for a photoshoot, wedding, festive event, or simply
                    want a refreshing self-care treatment, our team creates looks that feel elegant,
                    modern, and uniquely yours.
                </p>
            </section>

            <!-- Three feature cards explain the salon's value in a quick scan. -->
            <section class="feature-section">
                <img class="feature-background" src="${pageContext.request.contextPath}/public/boxtextbg.png" alt="Salon interior background">
                <div class="feature-overlay">
                    <article class="feature-card">
                        <span class="feature-icon">01</span>
                        <h3>Modern Techniques &amp; Trends</h3>
                        <p>
                            From classic looks to the latest trends in makeup, hair, and nails,
                            Shringar stays updated with current styles to deliver fresh and
                            professional results every time.
                        </p>
                    </article>

                    <article class="feature-card">
                        <span class="feature-icon">02</span>
                        <h3>Skilled Beauty Experts</h3>
                        <p>
                            At Shringar, services are delivered by experienced professionals who
                            understand modern beauty trends and techniques with a strong focus on
                            precision and creativity.
                        </p>
                    </article>

                    <article class="feature-card">
                        <span class="feature-icon">03</span>
                        <h3>Personalized Experience</h3>
                        <p>
                            Every client receives a tailored experience designed around personal
                            preferences, occasions, and style so each visit feels comfortable and
                            beautifully customized.
                        </p>
                    </article>
                </div>
            </section>

            <!-- Popular services act as visual shortcuts into the category pages. -->
            <section class="services" id="services">
                <div class="section-heading">
                    <p class="section-tag">Creative Works</p>
                    <h2>Popular Services</h2>
                </div>

                <div class="services-row">
                    <a class="service-card" href="${pageContext.request.contextPath}/pages/makeup">
                        <img src="${pageContext.request.contextPath}/public/makeup_popular_services.png" alt="Makeup service">
                    </a>

                    <a class="service-card" href="${pageContext.request.contextPath}/pages/hair">
                        <img src="${pageContext.request.contextPath}/public/hair_popular_services.png" alt="Hair service">
                    </a>

                    <a class="service-card" href="${pageContext.request.contextPath}/pages/nail">
                        <img src="${pageContext.request.contextPath}/public/nail.png" alt="Nail service">
                    </a>
                </div>
            </section>

            <!-- Social proof sits between services and the next booking prompt. -->
            <section class="reviews">
                <div class="section-heading">
                    <p class="section-tag">Reviews</p>
                    <h2>What Our Clients Say</h2>
                </div>

                <div class="reviews-list">
                    <article class="review-card">
                        <img class="review-avatar" src="${pageContext.request.contextPath}/public/client_makeup.png" alt="Portrait of Aakriti Shrestha">
                        <div class="review-content">
                            <h3>Aakriti Shrestha</h3>
                            <p>
                                I went to Shringar for a bridal and party look, and I honestly loved
                                the result. The makeup felt fresh, my hair looked beautiful, and the
                                team made me feel calm and cared for throughout.
                            </p>
                        </div>
                    </article>

                    <article class="review-card">
                        <img class="review-avatar" src="${pageContext.request.contextPath}/public/client_nails.png" alt="Portrait of Nisha Gurung">
                        <div class="review-content">
                            <h3>Nisha Gurung</h3>
                            <p>
                                Their hair and nail services are so detailed and relaxing. The staff
                                was gentle, the finish was neat, and I left the salon feeling polished
                                and confident.
                            </p>
                        </div>
                    </article>

                    <article class="review-card">
                        <img class="review-avatar" src="${pageContext.request.contextPath}/public/client_hair.png" alt="Portrait of Prakriti Karki">
                        <div class="review-content">
                            <h3>Prakriti Karki</h3>
                            <p>
                                I visited for a special event and I am obsessed with how natural yet
                                glamorous everything looked. They really understand face shape, skin
                                tone, and what suits you best.
                            </p>
                        </div>
                    </article>
                </div>
            </section>

            <!-- CTA gives the homepage a second clear booking moment lower in the scroll. -->
            <section class="cta-banner" id="appointment">
                <img class="cta-background" src="${pageContext.request.contextPath}/public/elevate_your_beauty_experience.png" alt="Salon chairs and mirrors">
                <div class="cta-content">
                    <h2>Want to elevate your beauty experience?</h2>
                    <p>
                        Discover expert makeup, hair, and nail services designed to bring out your
                        best look.
                    </p>
                    <a class="primary-button" href="${pageContext.request.contextPath}/login">Book Now!</a>
                </div>
            </section>

            <!-- Gallery preview keeps the full gallery page as a follow-up, not the first stop. -->
            <section class="gallery" id="gallery">
                <div class="section-heading">
                    <p class="section-tag">Gallery</p>
                    <h2>Our Portfolio</h2>
                </div>

                <div class="gallery-layout">
                    <div class="gallery-grid">
                        <figure class="gallery-card">
                            <img src="${pageContext.request.contextPath}/public/portfolio_three.png" alt="Makeup application with beauty brushes">
                        </figure>

                        <figure class="gallery-card">
                            <img src="${pageContext.request.contextPath}/public/portfolio_five.png" alt="Makeup artist applying eye makeup">
                        </figure>

                        <figure class="gallery-card">
                            <img src="${pageContext.request.contextPath}/public/portfolio_one.png" alt="Professional makeup application">
                        </figure>

                        <figure class="gallery-card">
                            <img src="${pageContext.request.contextPath}/public/portfolio_two.png" alt="Bridal makeup close-up">
                        </figure>
                    </div>

                    <a class="gallery-link" href="${pageContext.request.contextPath}/pages/Gallery">See All</a>
                </div>
            </section>
        </main>

        <!-- Footer repeats the main routes for long-scroll users. -->
        <footer class="footer" id="contact">
            <div class="footer-container">
                <div class="footer-brand">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" class="footer-logo">
                    <h3>SHRINGAR</h3>
                    <p class="footer-tagline">Beauty &amp; Wellness</p>
                    <p class="footer-desc">
                        Your trusted beauty destination in Kamalpokhari, Kathmandu.
                    </p>
                </div>

                <div class="footer-links">
                    <h4>QUICK LINKS</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a></li>
                        <li><a href="${pageContext.request.contextPath}/ContactUs">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/search">Search</a></li>
                        <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                    </ul>
                </div>

                <div class="footer-contact">
                    <h4>CONTACT</h4>
                    <p><span class="contact-label">Location</span> Kamalpokhari, Kathmandu</p>
                    <p><span class="contact-label">Phone</span> +977-9820221306</p>
                    <p><span class="contact-label">Web</span> www.shringarnepal.com</p>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2026 Shringar Salon. All Rights Reserved.</p>
            </div>
        </footer>
    </div>
</body>
</html>
