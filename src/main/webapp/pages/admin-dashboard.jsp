<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260425-1">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="panel dashboard-header">
                <div class="dashboard-header-copy">
                    <p class="section-label">Control Room</p>
                    <h2>Admin dashboard</h2>
                    <p class="hero-copy">Track salon appointments, customer approvals, service demand, and contact volume from one clean admin space.</p>
                </div>

                <div class="dashboard-header-actions">
                    <div class="dashboard-stamp">
                        <span>Last refresh</span>
                        <strong><c:out value="${dashboard.generatedAtDisplay}"/></strong>
                    </div>
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/">Salon home</a>
                    <a class="primary-link-button" href="${pageContext.request.contextPath}/logout">Sign out</a>
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
                    <span><c:out value="${dashboard.userTrendLabel}"/></span>
                </article>

                <article class="stat-card">
                    <p>Active Services</p>
                    <strong><c:out value="${dashboard.totalServices}"/></strong>
                    <span><c:out value="${dashboard.distinctCategories}"/> beauty categories live</span>
                </article>
            </section>

            <c:if test="${not empty successMessage}">
                <div class="admin-feedback admin-feedback-success"><c:out value="${successMessage}"/></div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="admin-feedback admin-feedback-error"><c:out value="${errorMessage}"/></div>
            </c:if>

            <section class="dashboard-grid">
                <article class="panel dashboard-panel-wide">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Movement Snapshot</p>
                            <h3>Monthly and Yearly Reports</h3>
                        </div>
                        <span class="panel-note">Built from bookings, revenue, customer growth, requests, and enquiries.</span>
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

                    <div class="mini-metrics-grid">
                        <div class="mini-metric">
                            <span>Approved customers</span>
                            <strong><c:out value="${dashboard.approvedUsers}"/></strong>
                            <small>ready for appointment booking</small>
                        </div>
                        <div class="mini-metric">
                            <span>Pending approvals</span>
                            <strong><c:out value="${dashboard.pendingUsers}"/></strong>
                            <small>customer accounts awaiting review</small>
                        </div>
                        <div class="mini-metric">
                            <span>Contact enquiries</span>
                            <strong><c:out value="${dashboard.totalMessages}"/></strong>
                            <small><c:out value="${dashboard.messageTrendLabel}"/></small>
                        </div>
                        <div class="mini-metric">
                            <span>Service requests</span>
                            <strong><c:out value="${dashboard.pendingRequests}"/></strong>
                            <small><c:out value="${dashboard.requestTrendLabel}"/></small>
                        </div>
                    </div>
                </article>

                <article class="panel queue-panel">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Work Queue</p>
                            <h3>Priority Items</h3>
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

                    <div class="attention-strip">
                        <span>Needs review</span>
                        <strong><c:out value="${dashboard.pendingUsers + dashboard.pendingRequests}"/></strong>
                        <p>Customer approvals and beauty requests waiting for action.</p>
                    </div>
                </article>
            </section>

            <section class="dashboard-grid">
                <article class="panel">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Service Performance</p>
                            <h3>Top Salon Services</h3>
                        </div>
                        <a class="secondary-link-button compact-link" href="${pageContext.request.contextPath}/admin/services">Manage services</a>
                    </div>

                    <div class="service-list">
                        <c:choose>
                            <c:when test="${not empty dashboard.topServices}">
                                <c:forEach var="service" items="${dashboard.topServices}" end="3">
                                    <article class="service-list-item">
                                        <div>
                                            <span><c:out value="${service.category}"/></span>
                                            <strong><c:out value="${service.serviceName}"/></strong>
                                        </div>
                                        <div class="service-list-meta">
                                            <b><c:out value="${service.bookingsCount}"/> bookings</b>
                                            <small><c:out value="${service.revenueDisplay}"/></small>
                                        </div>
                                    </article>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="admin-empty">Top services will appear here once appointment records start building up.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </article>

                <article class="panel">
                    <div class="panel-head">
                        <div>
                            <p class="section-label">Salon Pulse</p>
                            <h3>Operations At A Glance</h3>
                        </div>
                    </div>

                    <div class="snapshot-list">
                        <div class="snapshot-item">
                            <span>Live beauty categories</span>
                            <strong><c:out value="${dashboard.distinctCategories}"/></strong>
                        </div>
                        <div class="snapshot-item">
                            <span>Approved customer accounts</span>
                            <strong><c:out value="${dashboard.approvedUsers}"/></strong>
                        </div>
                        <div class="snapshot-item">
                            <span>Pending customer approvals</span>
                            <strong><c:out value="${dashboard.pendingUsers}"/></strong>
                        </div>
                        <div class="snapshot-item">
                            <span>Total contact enquiries</span>
                            <strong><c:out value="${dashboard.totalMessages}"/></strong>
                        </div>
                    </div>
                </article>
            </section>
        </main>
    </div>
</body>
</html>
