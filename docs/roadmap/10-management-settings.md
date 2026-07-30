# Phase 9 - Management and Settings

## TASK-076 - Implement settings hub

**Mục tiêu:** Tái tạo danh sách settings động theo business type và capability.

**Phụ thuộc:** TASK-019, TASK-021, TASK-032.

**File/Module liên quan:** `features/settings/`, `settings_data.dart`.

**Đầu ra mong muốn:** Mọi item có typed route hoặc trạng thái unavailable rõ ràng.

**Checklist hoàn thành:**

- [ ] Không giữ commented-out navigation.
- [ ] Item theo role/business type có rule.
- [ ] Widget/navigation tests.

**Độ ưu tiên:** P1.

---

## TASK-077 - Implement store profile

**Mục tiêu:** Xem/sửa tenant-store profile và avatar.

**Phụ thuộc:** TASK-023, TASK-024, TASK-044, TASK-076.

**File/Module liên quan:** `store_profile_page.dart`, tenant repository/use case.

**Đầu ra mong muốn:** Store name/image cập nhật đồng thời session, shell và Home.

**Checklist hoàn thành:**

- [ ] Upload tạm chỉ commit URL khi save.
- [ ] Dirty-state confirmation.
- [ ] Session cache update atomically.
- [ ] Integration test.

**Độ ưu tiên:** P1.

---

## TASK-078 - Implement change password

**Mục tiêu:** Port change-password UI và API.

**Phụ thuộc:** TASK-023, TASK-076.

**File/Module liên quan:** `change_password_page.dart`.

**Đầu ra mong muốn:** Password đổi thành công với policy/feedback đúng.

**Checklist hoàn thành:**

- [ ] Current/new/confirm validation.
- [ ] Sensitive input được clear khi complete.
- [ ] Không log password.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P1.

---

## TASK-079 - Implement login device management

**Mục tiêu:** Liệt kê session/device và logout các session được chọn.

**Phụ thuộc:** TASK-023, TASK-076.

**File/Module liên quan:** `login_devices_page.dart`, device auth use cases.

**Đầu ra mong muốn:** Current device được phân biệt và không bị chọn logout nhầm.

**Checklist hoàn thành:**

- [ ] Device list loading/error/empty.
- [ ] Logout selection count khớp API response.
- [ ] Current session protection.
- [ ] Cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-080 - Implement local bank account management

**Mục tiêu:** Port danh sách, thêm, sửa, xóa và chọn tài khoản ngân hàng local.

**Phụ thuộc:** TASK-015, TASK-021, TASK-076.

**File/Module liên quan:** bank account DTO, bank config, bank setting/list pages.

**Đầu ra mong muốn:** Bank config persist local và cung cấp cho payment.

**Checklist hoàn thành:**

- [ ] Bank/account validation.
- [ ] Xóa selected bank chọn fallback đúng.
- [ ] Dữ liệu nhạy cảm không log.
- [ ] Storage/cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-081 - Define bank account backend synchronization

**Mục tiêu:** Chốt API contract và migration từ local bank account sang server nếu sản phẩm yêu cầu đa thiết bị.

**Phụ thuộc:** TASK-080.

**File/Module liên quan:** bank account feature/data migration.

**Đầu ra mong muốn:** ADR + backend contract hoặc quyết định chính thức giữ local-only.

**Checklist hoàn thành:**

- [ ] Source of truth được chốt.
- [ ] Conflict/offline/migration rule được chốt.
- [ ] Không implement sync khi chưa có contract.

**Độ ưu tiên:** P3.

---

## TASK-082 - Implement staff data layer and management

**Mục tiêu:** Port staff list/create/update/delete.

**Phụ thuộc:** TASK-014, TASK-016, TASK-021, TASK-076.

**File/Module liên quan:** staff DTO/API/repository, `staff_management_*`.

**Đầu ra mong muốn:** Staff management chạy bằng API.

**Checklist hoàn thành:**

- [ ] Owner/current staff được phân biệt.
- [ ] Role code map có domain enum/value object.
- [ ] Không cho xóa owner/current user sai rule.
- [ ] Repository/cubit/widget tests.

**Độ ưu tiên:** P1.

---

## TASK-083 - Define and implement staff shift contract

**Mục tiêu:** Thay dữ liệu mock ca làm bằng API sau khi contract được duyệt.

**Phụ thuộc:** TASK-082.

**File/Module liên quan:** `staff_shift_*`, backend shift/attendance contract mới.

**Đầu ra mong muốn:** Check-in/check-out và lịch ca có server source of truth.

**Checklist hoàn thành:**

- [ ] Timezone/server time rule được chốt.
- [ ] API contract có idempotency/audit.
- [ ] Mock chỉ dùng test/dev.
- [ ] Integration tests.

**Độ ưu tiên:** P3.

---

## TASK-084 - Product decision for remaining settings pages

**Mục tiêu:** Phân loại About, business hours, two-factor, app notifications và printer thành active/deferred/removed.

**Phụ thuộc:** TASK-076.

**File/Module liên quan:** `settings/subpages/`.

**Đầu ra mong muốn:** Scope và API/hardware dependency của từng trang được duyệt.

**Checklist hoàn thành:**

- [ ] Không ship màn giả hoạt động.
- [ ] Mỗi active page có task/contract tiếp theo.
- [ ] Deferred item ẩn hoặc ghi unavailable rõ.

**Độ ưu tiên:** P2.

