package com.shringar.utils;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.shringar.model.Service;

public final class SalonMediaUtil {

    private static final Map<String, String> SERVICE_IMAGES = Map.ofEntries(
            Map.entry("Rapid Refresh Haircut", "/images/hair1.jpg"),
            Map.entry("Rose Reinvention Haircut", "/images/hair2.jpg"),
            Map.entry("Long Length Haircut & Style", "/images/hair3.jpg"),
            Map.entry("Curly Haircut", "/images/hair4.jpg"),
            Map.entry("Short Haircut", "/images/hair5.jpg"),
            Map.entry("Children's Haircut", "/images/hair6.jpg"),
            Map.entry("Bridal Makeup", "/images/makeup1.jpg"),
            Map.entry("Party Glam Makeup", "/images/makeup2.jpg"),
            Map.entry("Engagement Makeup", "/images/makeup3.jpg"),
            Map.entry("Natural Everyday Makeup", "/images/makeup4.jpg"),
            Map.entry("HD Makeup", "/images/makeup5.jpg"),
            Map.entry("Soft Glam Makeup", "/images/makeup6.jpg"),
            Map.entry("Gel Polish Nails", "/images/nail1.jpg"),
            Map.entry("Nail Art Design", "/images/nail2.jpg"),
            Map.entry("Acrylic Nail Extensions", "/images/nail3.jpg"),
            Map.entry("French Tip Nails", "/images/nail4.jpg"),
            Map.entry("Soft Gel / Natural Nude Nails", "/images/nail5.jpg"),
            Map.entry("Floral Nail Art Design", "/images/nail6.jpg"));

    private static final Map<String, String> CATEGORY_IMAGES = Map.of(
            "Hair", "/public/client_hair.png",
            "Makeup", "/public/client_makeup.png",
            "Nail", "/public/client_nails.png");

    private static final Map<String, String> STYLIST_IMAGES = Map.ofEntries(
            Map.entry("Shringar Hair Team", "/images/ojeswi.png?v=2"),
            Map.entry("Shringar Makeup Team", "/images/pratyusha.png?v=2"),
            Map.entry("Shringar Nail Team", "/public/nail_technician.jpg"),
            Map.entry("Shringar Beautician", "/images/sabya.png?v=2"),
            Map.entry("Shringar Beauty Team", "/images/sabya.png?v=2"));

    private SalonMediaUtil() {
    }

    public static String findServiceImage(Service service) {
        if (service == null) {
            return CATEGORY_IMAGES.get("Hair");
        }
        if (service.getImagePath() != null && !service.getImagePath().isBlank()) {
            String path = service.getImagePath();
            // Ensure path starts with / for context path prefixing
            if (!path.startsWith("/")) {
                path = "/" + path;
            }
            return path;
        }
        return findServiceImage(service.getServiceName(), service.getCategory());
    }

    public static String findServiceImage(String serviceName, String category) {
        if (serviceName != null) {
            String exact = SERVICE_IMAGES.get(serviceName.trim());
            if (exact != null) {
                return exact;
            }
        }
        if (category != null) {
            String fallback = CATEGORY_IMAGES.get(category.trim());
            if (fallback != null) {
                return fallback;
            }
        }
        return "/public/client_hair.png";
    }

    public static String findStylistImage(String stylistName, String category) {
        if (stylistName != null) {
            String exact = STYLIST_IMAGES.get(stylistName.trim());
            if (exact != null) {
                return exact;
            }
        }
        if (category != null) {
            if ("Makeup".equalsIgnoreCase(category.trim())) {
                return "/images/pratyusha.png?v=2";
            }
            if ("Nail".equalsIgnoreCase(category.trim())) {
                return "/public/nail_technician.jpg";
            }
        }
        return "/images/ojeswi.png?v=2";
    }

    public static Map<Integer, String> buildServiceImageMap(List<Service> services) {
        Map<Integer, String> imageMap = new LinkedHashMap<>();
        if (services == null) {
            return imageMap;
        }
        for (Service service : services) {
            if (service != null) {
                imageMap.put(service.getServiceId(), findServiceImage(service));
            }
        }
        return imageMap;
    }
}
