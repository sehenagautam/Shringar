<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<div class="main-container">

    <div class="hair-title">
        <h1>Hair Cut Services</h1>
    </div>

    <div class="hair-container">

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair1.jpg" alt="Rapid Refresh Haircut">
            <div class="card-text">
                <h3>Rapid Refresh Haircut</h3>
                <p>Starting at Rs 1000</p>
                <p>A quick, no-styling haircut to keep your look clean and refreshed</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair2.jpg" alt="Rose Reinvention Haircut">
            <div class="card-text">
                <h3>Rose Reinvention Haircut</h3>
                <p>Starting at Rs 1500</p>
                <p>A full style transformation to refresh and redefine your look</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair3.jpg" alt="Long Length Haircut">
            <div class="card-text">
                <h3>Long Length Haircut &amp; Style</h3>
                <p>Starting at Rs 1700</p>
                <p>A cut for longer hair, keeping it healthy and looking its best..</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair4.jpg" alt="Curly Haircut">
            <div class="card-text">
                <h3>Curly Haircut</h3>
                <p>Starting at Rs 1600</p>
                <p>A haircut designed for natural curls</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair5.jpg" alt="Short Haircut">
            <div class="card-text">
                <h3>Short Haircut</h3>
                <p>Starting at Rs 1200</p>
                <p>Modern short haircut for a clean style</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <div class="card">
            <img src="${pageContext.request.contextPath}/images/hair6.jpg" alt="Children's Haircut">
            <div class="card-text">
                <h3>Children's Haircut</h3>
                <p>Starting at Rs 1000</p>
                <p>A fresh haircut made just for kids</p>
                <a class="card-book-btn" href="${pageContext.request.contextPath}/login">Book Appointment</a>
            </div>
        </div>

        <!-- Dynamically added services from the Admin Dashboard -->
        <c:forEach var="s" items="${services}">
            <c:set var="isStarter" value="false" />
            <c:if test="${s.serviceCode eq 'HAIR-REFRESH-01' || s.serviceCode eq 'HAIR-ROSE-02' || s.serviceCode eq 'HAIR-LONG-03' || s.serviceCode eq 'HAIR-CURL-04' || s.serviceCode eq 'HAIR-SHORT-05' || s.serviceCode eq 'HAIR-KIDS-06'}">
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