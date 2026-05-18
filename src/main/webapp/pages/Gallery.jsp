<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-title">
        <p class="page-kicker">Gallery</p>
        <h1>Explore Our Work</h1>
        <p>Choose a beauty category to explore radiant makeup, polished hair transformations, and detailed nail artistry created at Shringar.</p>
    </section>

    <section class="gallery-section">
        <div class="gallery-categories">
            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/makeup">
                <span class="gallery-card-placeholder makeup-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-subtitle">Soft glam, bridal radiance, and beautifully finished makeup looks</span>
                </span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/hair">
                <span class="gallery-card-placeholder hair-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-subtitle">Layered cuts, glossy styling, and elegant hair finishes</span>
                </span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/nail">
                <span class="gallery-card-placeholder nail-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-subtitle">Glossy sets, clean manicures, and delicate nail art details</span>
                </span>
            </a>
        </div>
    </section>

    <div class="gallery-page-links">
        <a class="gallery-page-link" href="${pageContext.request.contextPath}/pages/services">Explore Services</a>
        <a class="gallery-page-link is-primary" href="${pageContext.request.contextPath}/pages/services">View Services</a>
    </div>
</main>

<%@ include file="../components/footer.jsp" %>
