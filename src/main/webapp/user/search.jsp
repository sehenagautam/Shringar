<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Search — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
</head>
<body>
<%@ include file="/user/nav.jspf" %>
<div class="user-wrap-wide">
    <h1 class="user-page-title">Services</h1>
    <p class="user-page-intro">Use filters to find services. You can save services to your wishlist, or send a request (apply) with a preferred date.</p>

    <c:if test="${not empty message}">
        <div class="msg-ok"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty flashError}">
        <div class="msg-err"><c:out value="${flashError}"/></div>
    </c:if>

    <div class="toolbar-row">
        <div class="muted" style="font-size:0.9rem;">Tip: If you don’t search, we show all available services.</div>
        <a href="${pageContext.request.contextPath}/user/search">Clear filters</a>
    </div>

    <c:if test="${not empty categories}">
        <div class="category-chips" aria-label="Browse by category">
            <c:forEach var="catChip" items="${categories}">
                <c:url var="catUrl" value="/user/search"><c:param name="category" value="${catChip}"/></c:url>
                <a href="${pageContext.request.contextPath}${catUrl}"><c:out value="${catChip}"/></a>
            </c:forEach>
        </div>
    </c:if>

    <form class="search-fields" method="get" action="${pageContext.request.contextPath}/user/search">
        <div class="field"><label>Stylist name</label><input type="text" name="stylist" value="${stylist}" placeholder="Name contains…"/></div>
        <div class="field"><label>Service code</label><input type="text" name="serviceCode" value="${serviceCode}" placeholder="Exact code" pattern="[A-Za-z0-9\\-]{3,40}" title="Use 3 to 40 letters, numbers, or hyphens."/></div>
        <div class="field"><label>Keyword (name/desc)</label><input type="text" name="q" value="${q}" placeholder="e.g. manicure"/></div>
        <div class="field"><label>Category</label><input type="text" name="category" value="${category}"/></div>
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
                </div>

                <form class="apply-mini" action="${pageContext.request.contextPath}/user/apply" method="post" style="margin-top:12px;padding-top:12px;border-top:1px solid var(--border);">
                    <input type="hidden" name="serviceId" value="${s.serviceId}"/>
                    <div class="apply-row">
                        <div class="field"><label>Preferred date</label><input type="date" name="preferredDate"/></div>
                        <div class="field"><label>Message</label><input type="text" name="message" placeholder="Optional" maxlength="600"/></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-small" style="margin-top:8px;">Apply / Request</button>
                </form>
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
<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('.search-fields');
    if (!form) return;

    const serviceCode = form.querySelector('input[name="serviceCode"]');
    const stylist = form.querySelector('input[name="stylist"]');
    const keyword = form.querySelector('input[name="q"]');
    const category = form.querySelector('input[name="category"]');

    form.addEventListener('submit', function () {
        if (serviceCode && serviceCode.value.trim()) {
            const codeOk = /^[A-Za-z0-9-]{3,40}$/.test(serviceCode.value.trim());
            serviceCode.setCustomValidity(codeOk ? '' : 'Service code must use 3 to 40 letters, numbers, or hyphens.');
        } else if (serviceCode) {
            serviceCode.setCustomValidity('');
        }

        const anyValue = [stylist, serviceCode, keyword, category].some(function (input) {
            return input && input.value.trim();
        });
        if (keyword) {
            keyword.setCustomValidity(anyValue ? '' : 'Enter at least one search value.');
        }
    });

    [stylist, serviceCode, keyword, category].forEach(function (input) {
        if (!input) return;
        input.addEventListener('input', function () {
            input.setCustomValidity('');
            if (keyword) {
                keyword.setCustomValidity('');
            }
        });
    });
});
</script>
</body>
</html>
