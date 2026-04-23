<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-title">
        <p class="page-kicker">Gallery</p>
        <h1>Explore Our Work</h1>
        <p>Choose a beauty category to browse Shringar's standalone makeup, hair, and nail portfolio pages.</p>
    </section>

    <section class="gallery-section">
        <div class="gallery-categories">
            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/makeup">
                <span class="gallery-card-placeholder makeup-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-label">Makeup</span>
                    <span class="gallery-card-subtitle">See the full beauty portfolio</span>
                </span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/hair">
                <span class="gallery-card-placeholder hair-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-label">Hair</span>
                    <span class="gallery-card-subtitle">Browse cuts, styling, and finish work</span>
                </span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/gallery/nail">
                <span class="gallery-card-placeholder nail-bg"></span>
                <span class="gallery-card-content">
                    <span class="gallery-card-label">Nails</span>
                    <span class="gallery-card-subtitle">Open the nail art showcase</span>
                </span>
            </a>
        </div>
    </section>

    <div class="gallery-page-links">
        <a class="gallery-page-link" href="${pageContext.request.contextPath}/pages/services">Explore Services</a>
        <a class="gallery-page-link is-primary" href="${pageContext.request.contextPath}/pages/appointment">Book Appointment</a>
    </div>
</main>

<%@ include file="../components/footer.jsp" %>
