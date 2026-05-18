<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-detail-title gallery-detail-title--makeup">
        <p class="page-kicker">Gallery</p>
        <h1>Makeup Portfolio</h1>
        <p>Browse signature glam, soft elegance, and polished event-ready looks from Shringar's dedicated makeup gallery.</p>
    </section>

    <section class="gallery-detail-shell">
        <nav class="gallery-category-nav" aria-label="Gallery categories">
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/Gallery">All Categories</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/hair">Hair Gallery</a>
            <a class="gallery-category-link active" href="${pageContext.request.contextPath}/pages/gallery/makeup">Makeup Gallery</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/nail">Nail Gallery</a>
        </nav>

        <div class="gallery-detail-intro">
            <p>Explore glowing skin, refined eye looks, bridal elegance, and soft glam finishes designed to feel polished, graceful, and camera ready.</p>
        </div>

        <div class="gallery-detail-grid gallery-detail-grid--editorial">
            <figure class="gallery-detail-item gallery-detail-item--big">
                <img src="${pageContext.request.contextPath}/public/Makeup1.png" alt="Makeup gallery look 1">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup6.png" alt="Makeup gallery look 2">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup3.png" alt="Makeup gallery look 3">
            </figure>
            <figure class="gallery-detail-item gallery-detail-item--tall">
                <img src="${pageContext.request.contextPath}/public/Makeup8.png" alt="Makeup gallery look 4">
            </figure>
            <figure class="gallery-detail-item gallery-detail-item--wide">
                <img src="${pageContext.request.contextPath}/public/Makeup5.png" alt="Makeup gallery look 5">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup2.png" alt="Makeup gallery look 6">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup7.png" alt="Makeup gallery look 7">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup4.png" alt="Makeup gallery look 8">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup9.png" alt="Makeup gallery look 9">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Makeup10.png" alt="Makeup gallery look 10">
            </figure>
        </div>

        <div class="gallery-detail-actions">
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/Gallery">Back to Main Gallery</a>
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/makeup">View Makeup Services</a>
            <a class="gallery-detail-action is-primary" href="${pageContext.request.contextPath}/pages/services">View Services</a>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
