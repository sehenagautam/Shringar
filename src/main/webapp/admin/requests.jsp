<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Requests | Shringar Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260425-1">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel">
                <div>
                    <p class="section-label">Service Requests</p>
                    <h2>Approve Requests</h2>
                    <p class="hero-copy">Review customer service requests, preferred dates, and notes before confirming whether the salon can accept them.</p>
                </div>
                <div class="hero-actions">
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/bookings">Create booking</a>
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
                        <p class="section-label">Customer Requests</p>
                        <h3>Pending and Completed Decisions</h3>
                    </div>
                    <span class="panel-note">Use approved requests as a guide before creating a booking.</span>
                </div>

                <div class="admin-table-wrap">
                    <table class="data-table admin-data-table">
                        <thead>
                            <tr>
                                <th>Customer</th>
                                <th>Service</th>
                                <th>Preferred Date</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty requests}">
                                    <c:forEach var="request" items="${requests}">
                                        <tr>
                                            <td>
                                                <strong><c:out value="${request.userName}"/></strong>
                                                <span class="muted-line"><c:out value="${request.userEmail}"/></span>
                                            </td>
                                            <td><c:out value="${request.serviceName}"/></td>
                                            <td><c:out value="${request.preferredDate}"/></td>
                                            <td><c:out value="${empty request.message ? 'No message' : request.message}"/></td>
                                            <td><span class="status-tag ${request.status}"><c:out value="${request.status}"/></span></td>
                                            <td><c:out value="${request.createdAtDisplay}"/></td>
                                            <td>
                                                <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/requests">
                                                    <input type="hidden" name="requestId" value="${request.requestId}">
                                                    <select name="status" aria-label="Request status">
                                                        <option value="PENDING" ${request.status eq 'PENDING' ? 'selected' : ''}>Pending</option>
                                                        <option value="APPROVED" ${request.status eq 'APPROVED' ? 'selected' : ''}>Approved</option>
                                                        <option value="REJECTED" ${request.status eq 'REJECTED' ? 'selected' : ''}>Rejected</option>
                                                    </select>
                                                    <button class="admin-button compact" type="submit">Save</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7">No service requests have been submitted yet.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
