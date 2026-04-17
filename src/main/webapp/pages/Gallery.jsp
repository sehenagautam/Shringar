<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<main class="main-container">
    <section class="page-title gallery-title">
        <p class="page-kicker">Gallery</p>
        <h1>Explore Our Work</h1>
        <p>Choose a beauty category to browse Shringar's makeup, hair, and nail artistry.</p>
    </section>

    <section class="gallery-section">
        <div class="gallery-categories">
            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/makeup">
                <span class="gallery-card-placeholder makeup-bg"></span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/hair">
                <span class="gallery-card-placeholder hair-bg"></span>
            </a>

            <a class="gallery-card" href="${pageContext.request.contextPath}/pages/nail">
                <span class="gallery-card-placeholder nail-bg"></span>
            </a>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jsp" %>
