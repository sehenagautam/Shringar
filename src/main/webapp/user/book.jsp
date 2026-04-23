<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Book appointment — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Jost:wght@300;400;500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<%@ include file="/user/site-header.jspf" %>

<div class="user-wrap">
    <h1 class="user-page-title">Book appointment</h1>
    <p class="user-page-intro">This will submit a request. The salon can approve or reject later.</p>

    <c:if test="${not empty errors}">
        <div class="msg-err">
            <ul>
                <c:forEach var="e" items="${errors}"><li><c:out value="${e}"/></li></c:forEach>
            </ul>
        </div>
    </c:if>

    <div class="form-card" style="margin-bottom:14px;">
        <h2 style="margin:0 0 8px;font-size:1.1rem;"><c:out value="${service.serviceName}"/></h2>
        <p class="user-page-intro" style="margin:0;">
            <c:out value="${service.category}"/> · <c:out value="${service.stylistName}"/>
            · ${service.price} · ${service.durationMinutes} min
        </p>
    </div>

    <form class="form-card form-stack" action="${pageContext.request.contextPath}/user/apply" method="post">
        <input type="hidden" name="serviceId" value="${service.serviceId}"/>

        <div class="field">
            <label>Preferred date</label>
            <input type="date" name="preferredDate" required/>
        </div>
        <div class="field">
            <label>Additional notes (optional)</label>
            <input type="text" name="message" maxlength="600" placeholder="e.g. short haircut, natural makeup"/>
        </div>

        <div class="inline-actions">
            <button type="submit" class="btn btn-primary">Submit request</button>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/search">Back to services</a>
        </div>
    </form>
</div>
<%@ include file="/user/site-footer.jspf" %>
</body>
</html>

