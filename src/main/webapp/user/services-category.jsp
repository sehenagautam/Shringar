<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title><c:out value="${pageTitle}"/> — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
</head>
<body>
<%@ include file="/user/nav.jspf" %>

<div class="user-wrap-wide">
    <div class="svc-hero">
        <div class="svc-hero-bg" style="background-image:url('${pageContext.request.contextPath}/images/${heroImage}');"></div>
        <div class="svc-hero-title"><c:out value="${pageTitle}"/></div>
    </div>

    <c:if test="${empty services}">
        <div class="empty-card">
            <p class="user-page-intro" style="margin-bottom:10px;">No services found in this category.</p>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/services">Back to Services</a>
        </div>
    </c:if>

    <div class="svc-grid">
        <c:forEach var="s" items="${services}">
            <div class="svc-card">
                <div class="svc-img" title="Image placeholder"></div>
                <div class="svc-body">
                    <h2><c:out value="${s.serviceName}"/></h2>
                    <p class="muted"><c:out value="${s.category}"/> · <c:out value="${s.stylistName}"/></p>
                    <p class="muted">Price: ${s.price} · Duration: ${s.durationMinutes} min</p>
                    <p class="svc-desc"><c:out value="${s.description}"/></p>

                    <c:url var="bookUrl" value="/user/book">
                        <c:param name="serviceId" value="${s.serviceId}"/>
                    </c:url>
                    <a class="btn btn-primary btn-block" href="${pageContext.request.contextPath}${bookUrl}">Book appointment</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>

