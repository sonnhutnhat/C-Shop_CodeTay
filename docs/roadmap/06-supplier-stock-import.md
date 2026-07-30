# Phase 5 - Supplier and Stock Import

## TASK-049 - Implement supplier data layer and list

**Mục tiêu:** Port supplier CRUD, pagination, search và detail.

**Phụ thuộc:** TASK-014, TASK-016, TASK-021.

**File/Module liên quan:** supplier DTO/API/repository, `features/suppliers/`.

**Đầu ra mong muốn:** Supplier list/detail chạy bằng API.

**Checklist hoàn thành:**

- [ ] Code/name/contact/tax/status map đủ.
- [ ] Search/pagination không duplicate.
- [ ] Contract/cubit/widget tests.

**Độ ưu tiên:** P1.

---

## TASK-050 - Implement supplier mutations

**Mục tiêu:** Tạo, sửa và xóa supplier trong các form/sheet hiện hữu.

**Phụ thuộc:** TASK-049.

**File/Module liên quan:** `suppliers_form_sheet.dart`, supplier use cases.

**Đầu ra mong muốn:** Mutation cập nhật list/detail nhất quán.

**Checklist hoàn thành:**

- [ ] Unique supplier code có rule rõ, không sinh tạm âm thầm.
- [ ] Dirty form confirmation.
- [ ] Delete conflict được hiển thị.
- [ ] Cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-051 - Implement stock import creation

**Mục tiêu:** Tái tạo chọn supplier, chọn item, quantity/price/discount/payment và submit phiếu nhập.

**Phụ thuộc:** TASK-045, TASK-049.

**File/Module liên quan:** `features/inventory/import_stock/`.

**Đầu ra mong muốn:** Phiếu nhập tạo qua API với tổng tiền và payment đúng.

**Checklist hoàn thành:**

- [ ] Next import code được lấy từ API.
- [ ] Money calculation có unit test.
- [ ] Partial/credit payment map đúng.
- [ ] Submit idempotent và refresh inventory.

**Độ ưu tiên:** P0.

---

## TASK-052 - Implement import history and detail

**Mục tiêu:** Tái tạo lịch sử nhập, filter/search và chi tiết phiếu.

**Phụ thuộc:** TASK-045, TASK-051.

**File/Module liên quan:** `import_history_*`, import detail UI.

**Đầu ra mong muốn:** Lịch sử phân trang và mở detail từ supplier/chứng từ.

**Checklist hoàn thành:**

- [ ] Status filter map API.
- [ ] Detail fetch theo ID.
- [ ] Navigation return không reload thừa.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P1.

