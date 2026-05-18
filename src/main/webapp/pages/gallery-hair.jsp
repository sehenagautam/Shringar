<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-detail-title gallery-detail-title--hair">
        <p class="page-kicker">Gallery</p>
        <h1>Hair Portfolio</h1>
        <p>Explore finished hair looks, polished styling, texture work, and refreshed silhouettes from Shringar's dedicated gallery collection.</p>
    </section>

    <section class="gallery-detail-shell">
        <nav class="gallery-category-nav" aria-label="Gallery categories">
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/Gallery">All Categories</a>
            <a class="gallery-category-link active" href="${pageContext.request.contextPath}/pages/gallery/hair">Hair Gallery</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/makeup">Makeup Gallery</a>
            <a class="gallery-category-link" href="${pageContext.request.contextPath}/pages/gallery/nail">Nail Gallery</a>
        </nav>

        <div class="gallery-detail-intro">
            <p>Discover soft layers, rich movement, glossy finish work, and styled looks that bring dimension, shape, and confidence to every hair moment.</p>
        </div>

        <div class="gallery-detail-grid gallery-detail-grid--masonry">
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair1.png" alt="Hair gallery look 1">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair2.png" alt="Hair gallery look 2">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair3.png" alt="Hair gallery look 3">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair4.png" alt="Hair gallery look 4">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair5.png" alt="Hair gallery look 5">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair6.png" alt="Hair gallery look 6">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair7.png" alt="Hair gallery look 7">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair8.png" alt="Hair gallery look 8">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair9.png" alt="Hair gallery look 9">
            </figure>
            <figure class="gallery-detail-item">
                <img src="${pageContext.request.contextPath}/public/Hair10.png" alt="Hair gallery look 10">
            </figure>
        </div>

        <div class="gallery-detail-actions">
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/Gallery">Back to Main Gallery</a>
            <a class="gallery-detail-action" href="${pageContext.request.contextPath}/pages/hair">View Hair Services</a>
            <a class="gallery-detail-action is-primary" href="${pageContext.request.contextPath}/pages/services">View Services</a>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
