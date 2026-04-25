<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Search — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css?v=20260425-1"/>
</head>
<body>
<%@ include file="/user/nav.jspf" %>
<div class="user-wrap-wide">
    <h1 class="user-page-title">Salon Services</h1>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p class="user-page-intro">Find the hair, makeup, or nail treatment you want, save favourites to your wishlist, or request a preferred appointment date.</p>
        </c:when>
        <c:otherwise>
            <p class="user-page-intro">Explore Shringar's hair, makeup, and nail treatments. Log in when you are ready to request an appointment.</p>
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty message}">
        <div class="msg-ok"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty flashError}">
        <div class="msg-err"><c:out value="${flashError}"/></div>
    </c:if>

    <div class="toolbar-row">
        <div class="muted" style="font-size:0.9rem;">Tip: Choose Nail, Hair, or Makeup first, then pick a treatment from the salon menu.</div>
        <a href="${pageContext.request.contextPath}${searchPath}">Clear filters</a>
    </div>

    <c:if test="${not empty categories}">
        <div class="category-chips" aria-label="Browse by category">
            <c:forEach var="catChip" items="${categories}">
                <c:url var="catUrl" value="${searchPath}"><c:param name="category" value="${catChip}"/></c:url>
                <a href="${catUrl}"><c:out value="${catChip}"/></a>
            </c:forEach>
        </div>
    </c:if>

    <form class="search-fields" method="get" action="${pageContext.request.contextPath}${searchPath}">
        <div class="field">
            <label>Category</label>
            <select name="category">
                <option value="">All categories</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat}" <c:if test="${cat eq category}">selected</c:if>><c:out value="${cat}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="field">
            <label>What are you looking for?</label>
            <select name="q">
                <option value="">All salon treatments</option>
                <c:forEach var="serviceOption" items="${serviceOptions}">
                    <option value="${serviceOption.serviceName}" <c:if test="${serviceOption.serviceName eq q}">selected</c:if>>
                        <c:out value="${serviceOption.serviceName}"/> - <c:out value="${serviceOption.category}"/>
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="field search-btn"><button type="submit" class="btn btn-primary">Search</button></div>
    </form>

    <c:if test="${not empty searchHints}">
        <ul class="hint-list">
            <c:forEach var="h" items="${searchHints}"><li><c:out value="${h}"/></li></c:forEach>
        </ul>
    </c:if>

    <div class="results-grid">
        <c:forEach var="s" items="${results}">
            <div class="result-card">
                <c:set var="serviceImage" value="${serviceImageMap[s.serviceId]}"/>
                <div class="result-card-media">
                    <img src="${pageContext.request.contextPath}${serviceImage}" alt="${s.serviceName}" class="result-card-photo"/>
                </div>
                <h2><c:out value="${s.serviceName}"/></h2>
                <p class="user-page-intro" style="margin-bottom:6px;"><c:out value="${s.stylistName}"/> · <c:out value="${s.category}"/></p>
                <p style="font-size:0.9rem;margin-bottom:8px;">Code: <strong><c:out value="${s.serviceCode}"/></strong> · ${s.price} · ${s.durationMinutes} min</p>
                <p style="font-size:0.9rem;"><c:out value="${s.description}"/></p>

                <c:set var="onWish" value="false"/>
                <c:forEach var="wid" items="${wishlistIds}">
                    <c:if test="${wid eq s.serviceId}"><c:set var="onWish" value="true"/></c:if>
                </c:forEach>

                <c:if test="${onWish}">
                    <div class="small-badge">Saved in wishlist</div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="inline-actions">
                            <form action="${pageContext.request.contextPath}/user/wishlist" method="post">
                                <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                                <input type="hidden" name="redirect" value="${searchPath}"/>
                                <c:choose>
                                    <c:when test="${onWish}">
                                        <input type="hidden" name="action" value="remove"/>
                                        <button type="submit" class="btn btn-secondary btn-small">Remove</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-secondary btn-small">Add to wishlist</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>

                        <form class="apply-mini" action="${pageContext.request.contextPath}/user/apply" method="post" style="margin-top:12px;padding-top:12px;border-top:1px solid var(--border);">
                            <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                            <div class="apply-row">
                                <div class="field"><label>Preferred date</label><input type="date" name="preferredDate"/></div>
                                <div class="field"><label>Message</label><input type="text" name="message" placeholder="Optional" maxlength="600"/></div>
                            </div>
                            <button type="submit" class="btn btn-primary btn-small" style="margin-top:8px;">Request appointment</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="inline-actions" style="margin-top:14px;">
                            <a class="btn btn-primary btn-small" href="${pageContext.request.contextPath}/login">Log in to book</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty results}">
        <div class="empty-card">
            <p class="user-page-intro" style="margin-bottom:10px;">No salon treatments matched that search.</p>
            <p class="user-page-intro" style="margin-bottom:0;">Try a broader beauty idea like bridal, haircut, manicure, hair spa, or glow makeup.</p>
        </div>
    </c:if>
</div>
</body>
</html>
