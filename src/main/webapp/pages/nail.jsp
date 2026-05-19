<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<div class="main-container">

    <div class="hair-title">
        <h1>Nail Services</h1>
    </div>

    <div class="hair-container">

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail1.jpg" alt="Gel Polish Nails">
            <div class="card-text">
                <h3>Gel Polish Nails</h3>
                <p>Starting at Rs 1200</p>
                <p>Long-lasting gel polish that gives your nails a glossy finish and chip-free shine for weeks.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail2.jpg" alt="Nail Art Design">
            <div class="card-text">
                <h3>Nail Art Design</h3>
                <p>Starting at Rs 1500</p>
                <p>Creative and stylish nail art designs to express your personality and enhance your overall look.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail3.jpg" alt="Acrylic Nail Extensions">
            <div class="card-text">
                <h3>Acrylic Nail Extensions</h3>
                <p>Starting at Rs 2000</p>
                <p>Strong and durable nail extensions that add length and beauty to your natural nails.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail4.jpg" alt="French Tip Nails">
            <div class="card-text">
                <h3>French Tip Nails</h3>
                <p>Starting at Rs 1300</p>
                <p>A classic and timeless nail style with clean white tips for a sophisticated appearance.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail5.jpg" alt="Soft Gel Nails">
            <div class="card-text">
                <h3>Soft Gel / Natural Nude Nails</h3>
                <p>Starting at Rs 1400</p>
                <p>A soft and natural nail style with a glossy nude finish, perfect for an elegant and everyday look.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/nail6.jpg" alt="Floral Nail Art">
            <div class="card-text">
                <h3>Floral Nail Art Design</h3>
                <p>Starting at Rs 1800</p>
                <p>Beautiful floral nail designs that add a delicate and charming touch, perfect for special occasions.</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <!-- Dynamically added services from the Admin Dashboard -->
        <c:forEach var="s" items="${services}">
            <c:set var="isStarter" value="false" />
            <c:if test="${s.serviceCode eq 'NAIL-GEL-01' || s.serviceCode eq 'NAIL-ART-02' || s.serviceCode eq 'NAIL-ACRYLIC-03' || s.serviceCode eq 'NAIL-FRENCH-04' || s.serviceCode eq 'NAIL-NUDE-05' || s.serviceCode eq 'NAIL-FLORAL-06'}">
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