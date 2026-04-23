<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salon Services | Shringar</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css?v=20260413-plain">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public-search.css?v=20260423-1">
</head>
<body>
    <div class="page-shell">
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
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/search">Search</a></li>
                </ul>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-login">Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn-login">Log in</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <main class="search-page-main">
            <section class="search-hero">
                <div class="search-hero-copy">
                    <p class="section-tag">Salon Services</p>
                    <h1>Find the hair, makeup, or nail treatment that fits your look.</h1>
                    <p>
                        Choose by occasion, beauty goal, or category. Whether you want bridal glow,
                        fresh nails, a haircut, or a relaxing hair treatment, Shringar helps you narrow it down.
                    </p>
                </div>

                <div class="search-hero-card">
                    <h2>Choosing your look</h2>
                    <ul class="search-hero-list">
                        <li>Pick Nail, Hair, or Makeup first if you already know the beauty area.</li>
                        <li>Choose the treatment from the salon menu instead of remembering the exact name.</li>
                        <li>After logging in, you can request your appointment date for the chosen treatment.</li>
                    </ul>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a class="primary-button" href="${pageContext.request.contextPath}/user/search">Choose an appointment</a>
                        </c:when>
                        <c:otherwise>
                            <a class="primary-button" href="${pageContext.request.contextPath}/login">Log in to book</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <section class="search-panel-section">
                <div class="search-panel">
                    <div class="search-panel-head">
                        <div>
                            <p class="section-tag">Salon Menu</p>
                            <h2>Choose your beauty treatment</h2>
                        </div>
                        <a class="search-clear-link" href="${pageContext.request.contextPath}/search">Clear filters</a>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="search-message search-message-ok"><c:out value="${message}"/></div>
                    </c:if>
                    <c:if test="${not empty flashError}">
                        <div class="search-message search-message-err"><c:out value="${flashError}"/></div>
                    </c:if>

                    <form class="search-filter-form" method="get" action="${pageContext.request.contextPath}/search">
                        <div class="search-field">
                            <label for="searchCategory">Category</label>
                            <select id="searchCategory" name="category">
                                <option value="">All categories</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat}" <c:if test="${cat eq category}">selected</c:if>><c:out value="${cat}"/></option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="search-field search-field-wide">
                            <label for="searchKeyword">What are you looking for?</label>
                            <select id="searchKeyword" name="q">
                                <option value="">All salon treatments</option>
                                <c:forEach var="serviceOption" items="${serviceOptions}">
                                    <option value="${serviceOption.serviceName}" <c:if test="${serviceOption.serviceName eq q}">selected</c:if>>
                                        <c:out value="${serviceOption.serviceName}"/> - <c:out value="${serviceOption.category}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="search-field search-field-action">
                            <button type="submit" class="primary-button search-submit">Show salon matches</button>
                        </div>
                    </form>

                    <c:if test="${not empty categories}">
                        <div class="search-chip-row" aria-label="Browse categories">
                            <c:forEach var="catChip" items="${categories}">
                                <c:url var="categoryUrl" value="/search">
                                    <c:param name="category" value="${catChip}"/>
                                </c:url>
                                <c:set var="chipClass" value="search-chip"/>
                                <c:if test="${catChip eq category}">
                                    <c:set var="chipClass" value="search-chip search-chip-active"/>
                                </c:if>
                                <a class="${chipClass}" href="${categoryUrl}">
                                    <c:out value="${catChip}"/>
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>

                    <c:if test="${not empty searchHints}">
                        <ul class="search-hints">
                            <c:forEach var="hint" items="${searchHints}">
                            <li><c:out value="${hint}"/></li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </div>
            </section>

            <section class="search-results-section">
                <div class="search-results-head">
                    <div>
                        <p class="section-tag">Available Services</p>
                        <h2>Salon treatments that match your style</h2>
                    </div>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:url var="dashboardSearchUrl" value="/user/search">
                                <c:if test="${not empty q}">
                                    <c:param name="q" value="${q}"/>
                                </c:if>
                                <c:if test="${not empty category}">
                                    <c:param name="category" value="${category}"/>
                                </c:if>
                            </c:url>
                            <a class="secondary-button" href="${dashboardSearchUrl}">Continue to appointment request</a>
                        </c:when>
                        <c:otherwise>
                            <a class="secondary-button" href="${pageContext.request.contextPath}/login">Log in to request an appointment</a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${not empty results}">
                        <div class="search-results-grid">
                            <c:forEach var="service" items="${results}">
                                <article class="search-result-card">
                                    <div class="search-result-top">
                                        <span class="search-result-category"><c:out value="${service.category}"/></span>
                                        <span class="search-result-duration"><c:out value="${service.durationMinutes}"/> min</span>
                                    </div>

                                    <h3><c:out value="${service.serviceName}"/></h3>
                                    <p class="search-result-stylist">With <c:out value="${service.stylistName}"/></p>
                                    <p class="search-result-description"><c:out value="${service.description}"/></p>

                                    <div class="search-result-footer">
                                        <span class="search-result-price">NPR <c:out value="${service.price}"/></span>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user}">
                                                <a class="primary-button search-card-action" href="${pageContext.request.contextPath}/user/search">Request appointment</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="primary-button search-card-action" href="${pageContext.request.contextPath}/login">Log in to book</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="search-empty-state">
                            <h3>No salon treatments matched that look.</h3>
                            <p>Try a broader beauty idea, switch to another category, or search without a stylist name.</p>
                            <a class="primary-button" href="${pageContext.request.contextPath}/search">Show all salon services</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>

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
                    <p><span class="contact-label">Hours</span> Daily, 10 AM - 7 PM</p>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2026 Shringar Salon. All Rights Reserved.</p>
            </div>
        </footer>
    </div>
</body>
</html>
