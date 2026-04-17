<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title services-title">
        <p class="page-kicker">Services</p>
        <h1>Beauty Services</h1>
        <p>Choose from hair, makeup, and nail services crafted for polished, confident looks.</p>
    </section>

    <section class="services-landing">
        <a class="service-tile" href="${pageContext.request.contextPath}/pages/hair">
            <img src="${pageContext.request.contextPath}/images/hair1.jpg" alt="Hair services">
            <div>
                <p>Hair</p>
                <h2>Hair Cut &amp; Styling</h2>
                <span>View Services</span>
            </div>
        </a>

        <a class="service-tile" href="${pageContext.request.contextPath}/pages/makeup">
            <img src="${pageContext.request.contextPath}/images/makeup1.jpg" alt="Makeup services">
            <div>
                <p>Makeup</p>
                <h2>Makeup Services</h2>
                <span>View Services</span>
            </div>
        </a>

        <a class="service-tile" href="${pageContext.request.contextPath}/pages/nail">
            <img src="${pageContext.request.contextPath}/images/nail1.jpg" alt="Nail services">
            <div>
                <p>Nail</p>
                <h2>Nail Services</h2>
                <span>View Services</span>
            </div>
        </a>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
