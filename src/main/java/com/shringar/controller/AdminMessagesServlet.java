package com.shringar.controller;

import java.io.IOException;
import java.util.List;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/messages")
public class AdminMessagesServlet extends AdminBaseServlet {

    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }
        prepareAdminPage(req, "messages");
        req.setAttribute("messages", dao.listMessagesForAdmin());
        req.getRequestDispatcher("/admin/messages.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        List<String> errors = ValidationUtil.newErrorList();
        int messageId = parsePositiveInt(req.getParameter("messageId"), "Message", errors);
        if (!errors.isEmpty()) {
            req.setAttribute("messages", dao.listMessagesForAdmin());
            forwardWithErrors(req, res, "/admin/messages.jsp", "messages", errors);
            return;
        }

        if (dao.deleteMessage(messageId)) {
            redirectWithSuccess(req, res, "/admin/messages", "Contact message was removed successfully.");
        } else {
            redirectWithError(req, res, "/admin/messages", "Could not remove the contact message.");
        }
    }
}
