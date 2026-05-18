package com.shringar.utils;

import java.io.IOException;
import java.nio.file.Path;
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
        String extension = FileUploadUtil.getFileExtension(submittedName).toLowerCase();
        String contentType = part.getContentType();

        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new ServletException("Profile image must be a JPG, JPEG, or PNG file.");
        }
        if (!FileUploadUtil.isImage(part) || contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
            throw new ServletException("The selected file is not a supported image.");
        }
        if (part.getSize() > MAX_FILE_SIZE_BYTES) {
            throw new ServletException("Profile image must be 2 MB or smaller.");
        }

        String uploadDir = Path.of(rootPath, "uploads", "profiles").toString();
        String fileName = FileUploadUtil.buildFileName(UUID.randomUUID().toString(), extension);
        FileUploadUtil.saveFile(part, uploadDir, fileName);
        return "uploads/profiles/" + fileName;
    }
}
