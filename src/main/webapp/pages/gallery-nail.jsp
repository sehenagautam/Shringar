<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-detail-title gallery-detail-title--nail">
        <p class="page-kicker">Gallery</p>
        <h1>Nail Portfolio</h1>
        <p>See detailed nail artistry, polished finishes, and creative sets from the standalone Shringar nail showcase.</p>
    </section>

    <section class="gallery-detail-shell">
        <nav class="gallery-category-nav" aria-label="Gallery categories">
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/Gallery">All Categories</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/hair">Hair Gallery</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/makeup">Makeup Gallery</a>
            <a class="gallery-category-link active" href="${pageContext.request.contextPath}/pages/gallery/nail">Nail Gallery</a>
        </nav>

        <div class="gallery-detail-intro">
            <p>This page preserves the dedicated nail gallery experience and gives it a clear path back to services, booking, and the main gallery hub.</p>
        </div>

        <div class="gallery-detail-grid gallery-detail-grid--masonry">
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail1.png" alt="Nail gallery look 1">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail2.png" alt="Nail gallery look 2">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail4.png" alt="Nail gallery look 3">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail5.png" alt="Nail gallery look 4">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail6.png" alt="Nail gallery look 5">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail7.png" alt="Nail gallery look 6">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail8.png" alt="Nail gallery look 7">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail9.png" alt="Nail gallery look 8">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail10.png" alt="Nail gallery look 9">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Nail11.png" alt="Nail gallery look 10">
            </figure>
        </div>

        <div class="gallery-detail-actions">
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/Gallery">Back to Main Gallery</a>
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/nail">View Nail Services</a>
            <a class="gallery-detail-action is-primary" href="${pageContext.request.contextPath}/pages/appointment">Book Appointment</a>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
