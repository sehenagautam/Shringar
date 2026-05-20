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
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
