resource "google_compute_global_address" "default" {
  name = "${var.lb_name}-address"
}

resource "google_compute_managed_ssl_certificate" "default" {
  provider = google-beta

  name = "${var.lb_name}-cert"
  managed {
    domains = ["${var.domain}"]
  }
}

# Cloud Armor Security Policy
resource "google_compute_security_policy" "policy" {
  name        = "cloud-armor-policy"
  description = "Strict security policy for Cloud Run service"
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]  # Match all source IP addresses
      }
    }
    description = "Default deny rule"
  }

  # Add more specific Cloud Armor rules - OWASP Top 10 rules
}

# Global Network Endpoint Group
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  provider              = google-beta
  name                  = "${var.lb_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.cloud_run_service_name
  }
}

# Backend Service
resource "google_compute_backend_service" "default" {
  name      = "${var.lb_name}-backend"

  protocol  = "HTTP"
  port_name = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }
  security_policy = google_compute_security_policy.policy.id
}


resource "google_compute_url_map" "default" {
  name            = "${var.lb_name}-urlmap"

  default_service = google_compute_backend_service.default.id
}


resource "google_compute_target_https_proxy" "default" {
  name   = "${var.lb_name}-https-proxy"

  url_map          = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default.id
  ]
}

resource "google_compute_global_forwarding_rule" "default" {
  name   = "${var.lb_name}-lb"

  target = google_compute_target_https_proxy.default.id
  port_range = "443"
  ip_address = google_compute_global_address.default.address
}

output "load_balancer_ip" {
  value = google_compute_global_address.default.address
}


resource "google_compute_url_map" "https_redirect" {
  name            = "${var.lb_name}-https-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "https_redirect" {
  name   = "${var.lb_name}-http-proxy"
  url_map          = google_compute_url_map.https_redirect.id
}

resource "google_compute_global_forwarding_rule" "https_redirect" {
  name   = "${var.lb_name}-lb-http"

  target = google_compute_target_http_proxy.https_redirect.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}