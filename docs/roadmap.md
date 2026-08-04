# C-Shop Mobile Roadmap

Roadmap chi tiết đã được tách theo phase để dễ theo dõi. Mỗi task vẫn giữ
nguyên ID, dependency, output, checklist và priority.

Toàn bộ phase dùng cấu trúc layer-first giống source C-Shop:
`models → network → repositories → ui`. Không tạo `lib/app/`, `lib/core/`
hoặc `lib/features/`; root providers nằm trong `lib/app.dart`.

## Trạng thái

Ký hiệu dưới đây áp dụng cho trạng thái phase tại mục lục. Trạng thái từng
task được xác định bằng checklist trong file phase tương ứng.

- `[ ]` Chưa bắt đầu
- `[-]` Đang thực hiện
- `[x]` Hoàn thành
- `[!]` Đang bị chặn

## Tổng quan

- [Phân tích source và nguyên tắc chung](roadmap/00-overview.md)
- [Milestone và Definition of Done](roadmap/14-milestones-definition-of-done.md)
- [Checklist code tay theo thứ tự thực thi](CODING_ROADMAP.md)

## Các phase

- [-] [Phase 0 — Project Setup](roadmap/01-project-setup.md) — TASK-001 → TASK-008
- [ ] [Phase 1 — Application Foundation](roadmap/02-application-foundation.md) — TASK-009 → TASK-021
- [-] [Phase 2 — Authentication & Onboarding](roadmap/03-authentication-onboarding.md) — TASK-022 → TASK-031
- [ ] [Phase 3 — Main Shell, Home & Utilities](roadmap/04-main-shell-home-utilities.md) — TASK-032 → TASK-038
- [ ] [Phase 4 — Catalog & Inventory Foundation](roadmap/05-catalog-inventory-foundation.md) — TASK-039 → TASK-048
- [ ] [Phase 5 — Supplier & Stock Import](roadmap/06-supplier-stock-import.md) — TASK-049 → TASK-052
- [ ] [Phase 6 — Sales, Orders & Customers](roadmap/07-sales-orders-customers.md) — TASK-053 → TASK-063
- [ ] [Phase 7 — Stocktake & Documents](roadmap/08-stocktake-documents.md) — TASK-064 → TASK-067
- [ ] [Phase 8 — Finance](roadmap/09-finance.md) — TASK-068 → TASK-075
- [ ] [Phase 9 — Management & Settings](roadmap/10-management-settings.md) — TASK-076 → TASK-084
- [ ] [Phase 10 — F&B](roadmap/11-fnb.md) — TASK-085 → TASK-091
- [ ] [Phase 11 — Service](roadmap/12-service.md) — TASK-092 → TASK-096
- [ ] [Phase 12 — Quality & Release](roadmap/13-quality-release.md) — TASK-097 → TASK-105

## Quy tắc cập nhật

Khi bắt đầu hoặc hoàn thành một task:

1. Cập nhật checklist trong file phase tương ứng.
2. Cập nhật trạng thái phase tại file mục lục này.
3. Commit riêng và dùng Task ID trong commit message.
