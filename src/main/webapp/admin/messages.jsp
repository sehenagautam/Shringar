<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Enquiries | Shringar Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260423-admin">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel">
                <div>
                    <p class="section-label">Contact Form</p>
                    <h2>Salon Enquiries</h2>
                    <p class="hero-copy">Read messages submitted through the contact page and clear resolved enquiries from the admin list.</p>
                </div>
                <div class="hero-actions">
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/ContactUs.jsp">Open contact page</a>
                </div>
            </header>

            <c:if test="${not empty successMessage}">
                <div class="admin-feedback admin-feedback-success"><c:out value="${successMessage}"/></div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="admin-feedback admin-feedback-error"><c:out value="${errorMessage}"/></div>
            </c:if>
            <c:if test="${not empty errors}">
                <div class="admin-feedback admin-feedback-error">
                    <c:forEach var="error" items="${errors}">
                        <p><c:out value="${error}"/></p>
                    </c:forEach>
                </div>
            </c:if>

            <section class="panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">Messages</p>
                        <h3>Recent Customer Enquiries</h3>
                    </div>
                    <span class="panel-note">Contact data is stored in the database from the contact form.</span>
                </div>

                <div class="message-board">
                    <c:choose>
                        <c:when test="${not empty messages}">
                            <c:forEach var="message" items="${messages}">
                                <article class="message-card admin-message-card">
                                    <div class="message-head">
                                        <div>
                                            <strong><c:out value="${message.fullName}"/></strong>
                                            <p class="message-meta">
                                                <c:out value="${message.email}"/>
                                                <c:if test="${not empty message.phone}">
                                                    | <c:out value="${message.phone}"/>
                                                </c:if>
                                            </p>
                                        </div>
                                        <span><c:out value="${message.createdAtDisplay}"/></span>
                                    </div>
                                    <p class="message-body-full"><c:out value="${message.message}"/></p>
                                    <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/messages">
                                        <input type="hidden" name="messageId" value="${message.messageId}">
                                        <button class="admin-button compact danger" type="submit">Mark resolved</button>
                                    </form>
                                </article>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="admin-empty">No contact messages have been submitted yet.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
