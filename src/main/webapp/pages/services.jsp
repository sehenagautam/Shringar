<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title services-title">
        <p class="page-kicker">Services</p>
        <h1>Beauty Services</h1>
        <p>Choose from hair, makeup, and nail services crafted for polished, confident looks.</p>
        
        <form action="${pageContext.request.contextPath}/search" method="get" style="margin-top:30px; max-width:600px; margin-left:auto; margin-right:auto;">
            <div style="display:flex; gap:10px;">
                <input type="text" name="q" placeholder="Search for treatments (e.g. Haircut, Bridal)" 
                       style="flex:1; padding:12px 20px; border-radius:999px; border:1px solid #d9c4b8; outline:none; font-family:'Jost', sans-serif;">
                <button type="submit" style="padding:12px 28px; border-radius:999px; background:#2c2c2c; color:#ffffff; font-weight:600; border:none; cursor:pointer;">Search</button>
            </div>
        </form>

        <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap;margin-top:20px;">
            <a href="${pageContext.request.contextPath}/login" style="display:inline-block;padding:12px 22px;border-radius:999px;background:#d9c4b8;color:#3a2d28;font-weight:600;">Book Appointment</a>
        </div>
    </section>

    <section class="services-landing">
        <article class="service-tile">
            <a class="service-tile-image" href="${pageContext.request.contextPath}/pages/hair">
                <img src="${pageContext.request.contextPath}/images/hair1.jpg" alt="Hair services">
            </a>
            <div>
                <p>Hair</p>
                <h2>Hair Cut &amp; Styling</h2>
                <div class="service-tile-actions">
                    <a class="service-tile-link" href="${pageContext.request.contextPath}/pages/hair">View Services</a>
                    <a class="service-tile-book" href="${pageContext.request.contextPath}/login">Book Appointment</a>
                </div>
            </div>
        </article>

        <article class="service-tile">
            <a class="service-tile-image" href="${pageContext.request.contextPath}/pages/makeup">
                <img src="${pageContext.request.contextPath}/images/makeup1.jpg" alt="Makeup services">
            </a>
            <div>
                <p>Makeup</p>
                <h2>Makeup Services</h2>
                <div class="service-tile-actions">
                    <a class="service-tile-link" href="${pageContext.request.contextPath}/pages/makeup">View Services</a>
                    <a class="service-tile-book" href="${pageContext.request.contextPath}/login">Book Appointment</a>
                </div>
            </div>
        </article>

        <article class="service-tile">
            <a class="service-tile-image" href="${pageContext.request.contextPath}/pages/nail">
                <img src="${pageContext.request.contextPath}/images/nail1.jpg" alt="Nail services">
            </a>
            <div>
                <p>Nail</p>
                <h2>Nail Services</h2>
                <div class="service-tile-actions">
                    <a class="service-tile-link" href="${pageContext.request.contextPath}/pages/nail">View Services</a>
                    <a class="service-tile-book" href="${pageContext.request.contextPath}/login">Book Appointment</a>
                </div>
            </div>
        </article>
    </section>

    <section class="all-services-section" style="max-width: 1120px; margin: 0 auto; padding: 40px 40px 84px;">
        <div class="section-heading" style="text-align: center; margin-bottom: 40px;">
            <p class="section-tag page-kicker">All Services</p>
            <h2 style="font-family: var(--font-display); font-size: 2.4rem; color: var(--dark); margin-top: 10px;">Explore Our Full Menu</h2>
        </div>
        
        <div class="hair-container" style="padding: 0;">
            <c:choose>
                <c:when test="${not empty allServices}">
                    <c:forEach var="s" items="${allServices}">
                        <div class="card">
                            <c:set var="img" value="${serviceImageMap[s.serviceId]}"/>
                            <img src="${pageContext.request.contextPath}${img}" alt="${s.serviceName}">
                            <div class="card-text">
                                <h3><c:out value="${s.serviceName}"/></h3>
                                <p style="color: var(--gold); font-size: 0.82rem; font-weight: 600; margin-bottom: 8px;">Rs <c:out value="${s.price}"/> &bull; <c:out value="${s.durationMinutes}"/> mins</p>
                                <p style="color: var(--text-muted); font-size: 0.86rem; line-height: 1.7; flex: 1;"><c:out value="${s.description}"/></p>
                                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
