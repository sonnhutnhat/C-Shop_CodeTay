# Phase 11 - Service Variant

## TASK-092 - Define Service backend contracts

**Mục tiêu:** Chốt API cho service catalog, staff availability, appointment và service checkout.

**Phụ thuộc:** TASK-032, TASK-082.

**File/Module liên quan:** source `ui/pages/service/`; backend contract mới.

**Đầu ra mong muốn:** OpenAPI/ADR thay thế `ServicesData.seed` và lịch local.

**Checklist hoàn thành:**

- [ ] Appointment state machine được chốt.
- [ ] Timezone/duration/conflict rule được chốt.
- [ ] Mapping appointment sang order/payment được chốt.

**Độ ưu tiên:** P2.

---

## TASK-093 - Implement service catalog

**Mục tiêu:** Tái tạo list/category/search/active và CRUD dịch vụ.

**Phụ thuộc:** TASK-092.

**File/Module liên quan:** `service/services/`.

**Đầu ra mong muốn:** Service catalog chạy bằng API.

**Checklist hoàn thành:**

- [ ] Name/category/duration/price/status validation.
- [ ] Toggle active persist backend.
- [ ] Không dùng seed production.
- [ ] Repository/cubit/widget tests.

**Độ ưu tiên:** P2.

---

## TASK-094 - Implement appointment calendar

**Mục tiêu:** Tái tạo calendar theo ngày và staff filter.

**Phụ thuộc:** TASK-092, TASK-093.

**File/Module liên quan:** `service/appointment/`.

**Đầu ra mong muốn:** Appointment load theo date/staff từ API.

**Checklist hoàn thành:**

- [ ] Date navigation timezone đúng.
- [ ] Overlap được hiển thị/xử lý.
- [ ] Loading/empty/error.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P2.

---

## TASK-095 - Implement appointment mutations

**Mục tiêu:** Tạo/sửa/xác nhận/hủy/hoàn thành lịch hẹn.

**Phụ thuộc:** TASK-094.

**File/Module liên quan:** appointment form/detail và service repository.

**Đầu ra mong muốn:** Mutation tuân state machine và cập nhật calendar.

**Checklist hoàn thành:**

- [ ] Staff availability conflict.
- [ ] Customer/service/duration validation.
- [ ] Idempotent mutation.
- [ ] Integration tests.

**Độ ưu tiên:** P2.

---

## TASK-096 - Integrate service checkout

**Mục tiêu:** Chuyển appointment completed sang order/payment chung.

**Phụ thuộc:** TASK-057, TASK-059, TASK-095.

**File/Module liên quan:** appointment checkout coordinator, sales payment.

**Đầu ra mong muốn:** Payment tạo order dịch vụ và cập nhật appointment.

**Checklist hoàn thành:**

- [ ] Không complete appointment khi payment fail.
- [ ] Staff/service/customer context được giữ.
- [ ] Không duplicate payment.
- [ ] End-to-end test.

**Độ ưu tiên:** P2.
