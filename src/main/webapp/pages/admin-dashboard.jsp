<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260423-3">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel overview-hero">
                <div>
                    <p class="section-label">Salon Overview</p>
                    <h2>Good to see you, <c:out value="${dashboard.adminDisplayName}"/></h2>
                    <p class="hero-copy">A calm snapshot of Shringar today: appointments, customers, beauty services, requests, and enquiries in one place.</p>
                    <span class="generated-pill">Updated <c:out value="${dashboard.generatedAtDisplay}"/></span>
                </div>

                <div class="overview-focus-card">
                    <span>Salon attention</span>
                    <strong><c:out value="${dashboard.pendingUsers + dashboard.pendingRequests}"/></strong>
                    <p>customer approvals and beauty requests waiting</p>
                </div>
            </header>

            <section class="stats-grid overview-stats" aria-label="Important admin statistics">
                <article class="stat-card stat-card-accent">
                    <p>Estimated Revenue</p>
                    <strong><c:out value="${dashboard.totalRevenueDisplay}"/></strong>
                    <span class="trend ${dashboard.revenueTrendDirection}"><c:out value="${dashboard.revenueTrendLabel}"/></span>
                </article>

                <article class="stat-card">
                    <p>Total Bookings</p>
                    <strong><c:out value="${dashboard.totalBookings}"/></strong>
                    <span class="trend ${dashboard.bookingTrendDirection}"><c:out value="${dashboard.bookingTrendLabel}"/></span>
                </article>

                <article class="stat-card">
                    <p>Registered Users</p>
                    <strong><c:out value="${dashboard.totalUsers}"/></strong>
                    <span><c:out value="${dashboard.pendingUsers}"/> waiting for approval</span>
                </article>

                <article class="stat-card">
                    <p>Active Services</p>
                    <strong><c:out value="${dashboard.totalServices}"/></strong>
                    <span><c:out value="${dashboard.distinctCategories}"/> beauty categories live</span>
                </article>
            </section>

            <section class="overview-grid">
                <article class="panel overview-report-panel">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Growth Report</p>
                            <h3>Monthly and Yearly Movement</h3>
                        </div>
                        <span class="panel-note">Generated from bookings, revenue, users, requests, and enquiries.</span>
                    </div>

                    <div class="report-summary-list">
                        <div class="report-summary-card ${dashboard.monthlyReport.direction}">
                            <span><c:out value="${dashboard.monthlyReport.comparisonLabel}"/></span>
                            <strong><c:out value="${dashboard.monthlyReport.title}"/></strong>
                            <p><c:out value="${dashboard.monthlyReport.summary}"/></p>
                        </div>
                        <div class="report-summary-card ${dashboard.yearlyReport.direction}">
                            <span><c:out value="${dashboard.yearlyReport.comparisonLabel}"/></span>
                            <strong><c:out value="${dashboard.yearlyReport.title}"/></strong>
                            <p><c:out value="${dashboard.yearlyReport.summary}"/></p>
                        </div>
                    </div>
                </article>

                <article class="panel queue-panel">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Work Queue</p>
                            <h3>Open Admin Tasks</h3>
                        </div>
                    </div>

                    <div class="queue-list">
                        <a class="queue-item" href="${pageContext.request.contextPath}/admin/users">
                            <span>User approvals</span>
                            <strong><c:out value="${dashboard.pendingUsers}"/></strong>
                        </a>
                        <a class="queue-item" href="${pageContext.request.contextPath}/admin/requests">
                            <span>Service requests</span>
                            <strong><c:out value="${dashboard.pendingRequests}"/></strong>
                        </a>
                        <a class="queue-item" href="${pageContext.request.contextPath}/admin/messages">
                            <span>Contact enquiries</span>
                            <strong><c:out value="${dashboard.totalMessages}"/></strong>
                        </a>
                        <a class="queue-item" href="${pageContext.request.contextPath}/admin/services">
                            <span>Service catalogue</span>
                            <strong><c:out value="${dashboard.totalServices}"/></strong>
                        </a>
                    </div>
                </article>
            </section>

            <section class="panel service-insight-panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">Service Insight</p>
                        <h3>Top Performing Services</h3>
                    </div>
                    <a class="secondary-link-button compact-link" href="${pageContext.request.contextPath}/admin/services">Manage services</a>
                </div>

                <div class="service-insight-grid">
                    <c:choose>
                        <c:when test="${not empty dashboard.topServices}">
                            <c:forEach var="service" items="${dashboard.topServices}" end="2">
                                <article class="service-insight-card">
                                    <span><c:out value="${service.category}"/></span>
                                    <strong><c:out value="${service.serviceName}"/></strong>
                                    <p><c:out value="${service.bookingsCount}"/> bookings</p>
                                    <small><c:out value="${service.revenueDisplay}"/></small>
                                </article>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="admin-empty">No service performance data yet. Once bookings are created, the strongest services will appear here.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
