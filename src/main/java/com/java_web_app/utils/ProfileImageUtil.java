package com.java_web_app.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Set;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Part;

public final class ProfileImageUtil {

    private static final Set<String> ALLOWED_EXTENSIONS = Set.of(".jpg", ".jpeg", ".png");
    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of(
            "image/jpeg",
            "image/png");
    private static final long MAX_FILE_SIZE_BYTES = 2L * 1024L * 1024L;

    private ProfileImageUtil() {
    }

    public static String saveProfileImage(Part part, String rootPath) throws IOException, ServletException {
        if (part == null || part.getSize() <= 0) {
            return null;
        }

        String submittedName = part.getSubmittedFileName();
        String extension = extractExtension(submittedName);
        String contentType = part.getContentType();

        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new ServletException("Profile image must be a JPG, JPEG, or PNG file.");
        }
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
            throw new ServletException("The selected file is not a supported image.");
        }
        if (part.getSize() > MAX_FILE_SIZE_BYTES) {
            throw new ServletException("Profile image must be 2 MB or smaller.");
        }

        Path uploadDir = Path.of(rootPath, "uploads", "profiles");
        Files.createDirectories(uploadDir);

        String fileName = UUID.randomUUID() + extension;
        Path target = uploadDir.resolve(fileName);
        Files.copy(part.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        return "uploads/profiles/" + fileName;
    }

    private static String extractExtension(String fileName) {
        if (fileName == null) {
            return "";
        }
        int dot = fileName.lastIndexOf('.');
        if (dot < 0 || dot == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(dot).toLowerCase();
    }
}
