# Recipe DevOps Lab

Bài thực hành môn **Triển khai và Quản trị Hệ thống Phần mềm**, Đề 29:
Website công thức nấu ăn (Flask + MySQL + phpMyAdmin) chạy bằng Docker Compose.

## Công nghệ
- Python Flask (web), MySQL 8 (database), phpMyAdmin (quản trị DB)
- Docker Compose

## Cách chạy
1. Cài Docker Desktop.
2. Sao chép file cấu hình: `copy .env.example .env`, rồi sửa mật khẩu trong `.env`.
3. Chạy: `docker compose up -d --build`
4. Truy cập:
   - Website: http://localhost:5000
   - phpMyAdmin: http://localhost:8080

## Tiến độ
- [x] Bước 1-2: Web + MySQL + phpMyAdmin
- [ ] Bước 3: Nginx + HTTPS
- [ ] Bước 4: Prometheus + Grafana
- [ ] Bước 5: Loki + Promtail
- [ ] Bước 6: Hardening