<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Search — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Jost:wght@300;400;500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<%@ include file="/user/site-header.jspf" %>
<div class="user-wrap-wide">
    <h1 class="user-page-title">Services</h1>
    <p class="user-page-intro">Find a service fast, then add to wishlist or book appointment.</p>
    <div class="inline-actions" style="margin:0 0 14px;">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/services">Book appointment</a>
    </div>

    <c:if test="${not empty message}">
        <div class="msg-ok"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty flashError}">
        <div class="msg-err"><c:out value="${flashError}"/></div>
    </c:if>

    <div class="toolbar-row">
        <div class="muted" style="font-size:0.9rem;">Showing all services when no filter is selected.</div>
        <div class="inline-actions" style="margin-top:0;">
            <a href="${pageContext.request.contextPath}/user/search">Clear all filters</a>
        </div>
    </div>

    <c:if test="${not empty categories}">
        <div class="category-chips" aria-label="Quick category filter">
            <c:forEach var="catChip" items="${categories}">
                <c:url var="catUrl" value="/user/search"><c:param name="category" value="${catChip}"/></c:url>
                <a href="${pageContext.request.contextPath}${catUrl}"><c:out value="${catChip}"/></a>
            </c:forEach>
        </div>
    </c:if>

    <div class="search-panel">
        <h2 class="search-panel-title">Search and filter</h2>
        <form class="search-fields" method="get" action="${pageContext.request.contextPath}/user/search">
            <div class="field"><label>Keyword</label><input type="text" name="q" value="${q}" placeholder="e.g. manicure, bridal"/></div>
            <div class="field"><label>Stylist name</label><input type="text" name="stylist" value="${stylist}" placeholder="e.g. Priya"/></div>
            <div class="field"><label>Service code</label><input type="text" name="serviceCode" value="${serviceCode}" placeholder="e.g. 100" pattern="[0-9]{3,6}" title="Use numbers only (3 to 6 digits)."/></div>
            <div class="field">
                <label>Category</label>
                <select name="category">
                    <option value="">All categories</option>
                    <c:forEach var="catOpt" items="${categories}">
                        <option value="${catOpt}" <c:if test="${catOpt eq category}">selected</c:if>><c:out value="${catOpt}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="field search-btn"><button type="submit" class="btn btn-primary">Apply filters</button></div>
        </form>
    </div>
    <c:if test="${not empty category or not empty q or not empty stylist or not empty serviceCode}">
        <div class="active-filters">
            <strong>Active filters:</strong>
            <c:if test="${not empty q}"><span>Keyword: <c:out value="${q}"/></span></c:if>
            <c:if test="${not empty stylist}"><span>Stylist: <c:out value="${stylist}"/></span></c:if>
            <c:if test="${not empty serviceCode}"><span>Code: <c:out value="${serviceCode}"/></span></c:if>
            <c:if test="${not empty category}"><span>Category: <c:out value="${category}"/></span></c:if>
        </div>
    </c:if>

    <c:if test="${not empty searchHints}">
        <div class="hint-list">
            <c:forEach var="h" items="${searchHints}"><p><c:out value="${h}"/></p></c:forEach>
        </div>
    </c:if>

    <h2 class="search-panel-title">Available services</h2>
    <div class="results-grid">
        <c:forEach var="s" items="${results}">
            <div class="result-card">
                <div class="service-img-placeholder" title="Service image placeholder">Image space</div>
                <h2><c:out value="${s.serviceName}"/></h2>
                <p class="user-page-intro" style="margin-bottom:6px;"><c:out value="${s.stylistName}"/> · <c:out value="${s.category}"/></p>
                <c:set var="displayCode" value="${s.serviceCode}"/>
                <c:if test="${fn:contains(s.serviceCode, '-')}">
                    <c:set var="codeParts" value="${fn:split(s.serviceCode, '-')}" />
                    <c:set var="displayCode" value="${codeParts[fn:length(codeParts)-1]}" />
                </c:if>
                <p style="font-size:0.9rem;margin-bottom:8px;">Code: <strong><c:out value="${displayCode}"/></strong> · ${s.price} · ${s.durationMinutes} min</p>
                <p style="font-size:0.9rem;"><c:out value="${s.description}"/></p>

                <c:set var="onWish" value="false"/>
                <c:forEach var="wid" items="${wishlistIds}">
                    <c:if test="${wid eq s.serviceId}"><c:set var="onWish" value="true"/></c:if>
                </c:forEach>

                <c:if test="${onWish}">
                    <div class="small-badge">Saved in wishlist</div>
                </c:if>

                <div class="inline-actions">
                    <form action="${pageContext.request.contextPath}/user/wishlist" method="post">
                        <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                        <input type="hidden" name="redirect" value="/user/search"/>
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
                    <c:url var="bookUrl" value="/user/book">
                        <c:param name="serviceId" value="${s.serviceId}"/>
                    </c:url>
                    <a class="btn btn-primary btn-small" href="${pageContext.request.contextPath}${bookUrl}">Book appointment</a>
                </div>

                <p class="user-page-intro" style="margin-top:10px;margin-bottom:0;">
                    To request this service, click <strong>Book appointment</strong>.
                </p>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty results}">
        <div class="empty-card">
            <p class="user-page-intro" style="margin-bottom:10px;">No services to show right now.</p>
            <p class="user-page-intro" style="margin-bottom:0;">If you searched, try different filters. If not, check that the <code>services</code> table has data.</p>
        </div>
    </c:if>
</div>
<%@ include file="/user/site-footer.jspf" %>
</body>
</html>
