<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Wishlist — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
</head>
<body>
<%@ include file="/user/nav.jspf" %>
<div class="user-wrap-wide">
    <h1 class="user-page-title">Wishlist</h1>
    <p class="user-page-intro">Your wishlist is saved in your session (temporary). Use it to keep services for later.</p>

    <div class="toolbar-row">
        <div class="muted" style="font-size:0.9rem;">You can remove items anytime.</div>
        <a href="${pageContext.request.contextPath}/user/search">Back to Services</a>
    </div>

    <c:if test="${not empty message}">
        <div class="msg-ok"><c:out value="${message}"/></div>
    </c:if>

    <c:choose>
        <c:when test="${empty wishlistServices}">
            <div class="empty-card">
                <p class="user-page-intro" style="margin-bottom:10px;">Nothing saved yet.</p>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/search">Browse services</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="results-grid">
                <c:forEach var="s" items="${wishlistServices}">
                    <div class="result-card">
                        <h2><c:out value="${s.serviceName}"/></h2>
                        <p class="user-page-intro"><c:out value="${s.stylistName}"/> · <c:out value="${s.category}"/></p>
                        <p style="font-size:0.9rem;margin-bottom:10px;">Code: <strong><c:out value="${s.serviceCode}"/></strong> · ${s.price} · ${s.durationMinutes} min</p>
                        <div class="inline-actions">
                            <form action="${pageContext.request.contextPath}/user/wishlist" method="post">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                            <button type="submit" class="btn btn-secondary btn-small">Remove</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/user/apply" method="post">
                                <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                                <button type="submit" class="btn btn-primary btn-small">Request now</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
