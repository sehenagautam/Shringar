<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<div class="main-container">

    <div class="hair-title">
        <h1>Makeup Services</h1>
    </div>

    <div class="hair-container">

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup1.jpg" alt="Bridal Makeup">
            <div class="card-text">
                <h3>Bridal Makeup</h3>
                <p>Starting at Rs 8000</p>
                <p>Flawless and long-lasting bridal makeup that enhances your natural beauty, perfect for your special day.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup2.jpg" alt="Party Glam Makeup">
            <div class="card-text">
                <h3>Party Glam Makeup</h3>
                <p>Starting at Rs 3000</p>
                <p>A glamorous makeup look with bold eyes and glowing skin, perfect for parties and night outings.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup3.jpg" alt="Engagement Makeup">
            <div class="card-text">
                <h3>Engagement Makeup</h3>
                <p>Starting at Rs 5000</p>
                <p>Elegant and sophisticated makeup designed to give you a glowing look for your engagement day.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup4.jpg" alt="Natural Everyday Makeup">
            <div class="card-text">
                <h3>Natural Everyday Makeup</h3>
                <p>Starting at Rs 2000</p>
                <p>Light and breathable makeup for a clean and simple look, ideal for daily wear.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup5.jpg" alt="HD Makeup">
            <div class="card-text">
                <h3>HD Makeup</h3>
                <p>Starting at Rs 4500</p>
                <p>High-definition makeup that provides a smooth, flawless finish perfect for photoshoots.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/makeup6.jpg" alt="Soft Glam Makeup">
            <div class="card-text">
                <h3>Soft Glam Makeup</h3>
                <p>Starting at Rs 2500</p>
                <p>A subtle and natural glam look with soft tones, giving you a fresh and effortlessly beautiful appearance.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <!-- Dynamically added services from the Admin Dashboard -->
        <c:forEach var="s" items="${services}">
            <c:set var="isStarter" value="false" />
            <c:if test="${s.serviceCode eq 'MAKEUP-BRIDAL-01' || s.serviceCode eq 'MAKEUP-PARTY-02' || s.serviceCode eq 'MAKEUP-ENGAGE-03' || s.serviceCode eq 'MAKEUP-NATURAL-04' || s.serviceCode eq 'MAKEUP-HD-05' || s.serviceCode eq 'MAKEUP-SOFT-06'}">
                <c:set var="isStarter" value="true" />
            </c:if>
            <c:if test="${not isStarter}">
                <div class="card">
                    <c:set var="img" value="${serviceImageMap[s.serviceId]}"/>
                    <img src="${pageContext.request.contextPath}${img}" alt="${s.serviceName}">
                    <div class="card-text">
                        <h3><c:out value="${s.serviceName}"/></h3>
                        <p>Starting at Rs <c:out value="${s.price}"/></p>
                        <p><c:out value="${s.description}"/></p>
                        <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
                    </div>
                </div>
            </c:if>
        </c:forEach>

    </div>

</div>

<%@ include file="../components/footer.jsp" %>