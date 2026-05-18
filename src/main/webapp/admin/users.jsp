<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | Shringar Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260425-1">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel">
                <div>
                    <p class="section-label">User Approval</p>
                    <h2>Manage User Accounts</h2>
                    <p class="hero-copy">Approve, reject, or hold customer accounts for review. Customer records are protected and cannot be deleted from the admin module.</p>
                </div>
                <div class="hero-actions">
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/dashboard">Back to overview</a>
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
                        <p class="section-label">Add Customer</p>
                        <h3>Create Customer Account</h3>
                    </div>
                    <span class="panel-note">Allowed for customer management. Customer accounts still cannot be deleted.</span>
                </div>

                <form class="admin-form" method="post" action="${pageContext.request.contextPath}/admin/users">
                    <input type="hidden" name="action" value="create">
                    <div class="admin-form-grid">
                        <label class="field">
                            <span>Customer name</span>
                            <input type="text" name="fullName" value="${customerForm.fullName}" required maxlength="120">
                        </label>
                        <label class="field">
                            <span>Email</span>
                            <input type="email" name="email" value="${customerForm.email}" required maxlength="150">
                        </label>
                        <label class="field">
                            <span>Phone</span>
                            <input type="text" name="phone" value="${customerForm.phone}" maxlength="32">
                        </label>
                        <label class="field">
                            <span>Membership</span>
                            <input type="text" name="membershipLevel" value="${customerForm.membershipLevel}" placeholder="Customer" maxlength="64">
                        </label>
                        <label class="field">
                            <span>Temporary password</span>
                            <input type="password" name="password" required minlength="8" autocomplete="new-password">
                        </label>
                        <label class="field">
                            <span>Status</span>
                            <select name="status" required>
                                <option value="APPROVED" ${empty customerForm.status || customerForm.status eq 'APPROVED' ? 'selected' : ''}>Approved</option>
                                <option value="PENDING" ${customerForm.status eq 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="REJECTED" ${customerForm.status eq 'REJECTED' ? 'selected' : ''}>Rejected</option>
                            </select>
                        </label>
                    </div>
                    <div class="form-actions">
                        <button class="admin-button" type="submit">Add customer</button>
                    </div>
                </form>
            </section>

            <section class="panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">Approval Queue</p>
                        <h3>Registered Customers</h3>
                    </div>
                    <span class="panel-note">Change account status only. No remove action is provided.</span>
                </div>

                <div class="admin-table-wrap">
                    <table class="data-table admin-data-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Membership</th>
                                <th>Status</th>
                                <th>Joined</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td><strong><c:out value="${user.name}"/></strong></td>
                                            <td><c:out value="${user.email}"/></td>
                                            <td><c:out value="${empty user.phone ? 'Not provided' : user.phone}"/></td>
                                            <td><c:out value="${empty user.membershipLevel ? 'Customer' : user.membershipLevel}"/></td>
                                            <td><span class="status-tag ${user.status}"><c:out value="${user.status}"/></span></td>
                                            <td><c:out value="${user.createdAtDisplay}"/></td>
                                            <td>
                                                <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/users">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <select name="status" aria-label="Account status for ${user.name}">
                                                        <option value="PENDING" ${user.status eq 'PENDING' ? 'selected' : ''}>Pending</option>
                                                        <option value="APPROVED" ${user.status eq 'APPROVED' ? 'selected' : ''}>Approved</option>
                                                        <option value="REJECTED" ${user.status eq 'REJECTED' ? 'selected' : ''}>Rejected</option>
                                                    </select>
                                                    <button class="admin-button compact" type="submit">Save</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7">No user accounts are available yet.</td>
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
