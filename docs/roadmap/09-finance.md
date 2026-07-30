# Phase 8 - Finance

## TASK-068 - Implement finance data layer

**Mục tiêu:** Port summary, cashbook, entry, customer debt, supplier debt và revenue target.

**Phụ thuộc:** TASK-014, TASK-016.

**File/Module liên quan:** finance DTO/API/repository.

**Đầu ra mong muốn:** Finance repository domain contract bao phủ endpoint hiện hữu.

**Checklist hoàn thành:**

- [ ] Money/date/type/method/status map đủ.
- [ ] Pagination semantics của cashbook giữ đúng.
- [ ] Contract/repository tests.

**Độ ưu tiên:** P0.

---

## TASK-069 - Implement finance dashboard

**Mục tiêu:** Tái tạo summary theo period/custom range và breakdown tài chính.

**Phụ thuộc:** TASK-021, TASK-068.

**File/Module liên quan:** `features/finance/overview/`.

**Đầu ra mong muốn:** Revenue/expense/profit/debt hiển thị từ API, không fallback mock.

**Checklist hoàn thành:**

- [ ] Date range chính xác.
- [ ] Loading/error/empty states.
- [ ] Money calculation/format tests.

**Độ ưu tiên:** P1.

---

## TASK-070 - Implement revenue target configuration

**Mục tiêu:** Xem và cập nhật mục tiêu doanh thu.

**Phụ thuộc:** TASK-068.

**File/Module liên quan:** `revenue_config_page.dart`, revenue target use cases.

**Đầu ra mong muốn:** Target mới phản ánh ở Home và Finance.

**Checklist hoàn thành:**

- [ ] Amount validation.
- [ ] Shared refresh/invalidation event.
- [ ] Cubit test.

**Độ ưu tiên:** P1.

---

## TASK-071 - Implement cashbook list

**Mục tiêu:** Tái tạo sổ quỹ, filter loại và period/custom range.

**Phụ thuộc:** TASK-021, TASK-068.

**File/Module liên quan:** `features/finance/cashbook/`.

**Đầu ra mong muốn:** Opening/closing balance và transactions khớp backend.

**Checklist hoàn thành:**

- [ ] Pagination/filter state đúng.
- [ ] Income/expense style đúng.
- [ ] Custom range test.

**Độ ưu tiên:** P1.

---

## TASK-072 - Implement manual finance entry

**Mục tiêu:** Tạo phiếu thu hoặc chi thủ công.

**Phụ thuộc:** TASK-071.

**File/Module liên quan:** cashbook add transaction sheet, create-entry use case.

**Đầu ra mong muốn:** Entry mới xuất hiện và balance được refresh.

**Checklist hoàn thành:**

- [ ] Type/category/amount/method/date validation.
- [ ] Idempotent submit.
- [ ] Error không đóng form/mất input.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P1.

---

## TASK-073 - Implement customer debt collection

**Mục tiêu:** Hiển thị khoản phải thu và thu nợ toàn phần/một phần.

**Phụ thuộc:** TASK-055, TASK-068.

**File/Module liên quan:** `features/finance/debt/`, customer detail collect sheet.

**Đầu ra mong muốn:** Debt/customer/cashbook đồng bộ sau thu.

**Checklist hoàn thành:**

- [ ] Paid amount không vượt rule backend.
- [ ] Payment method map đúng.
- [ ] Shared invalidation cập nhật các màn.
- [ ] Unit/integration tests.

**Độ ưu tiên:** P1.

---

## TASK-074 - Implement supplier debt payment

**Mục tiêu:** Hiển thị phải trả nhà cung cấp và thanh toán nợ.

**Phụ thuộc:** TASK-049, TASK-068.

**File/Module liên quan:** debt Cubit, supplier pay debt/receipt sheets.

**Đầu ra mong muốn:** Supplier detail, finance debt và cashbook đồng bộ.

**Checklist hoàn thành:**

- [ ] Partial/full payment validate.
- [ ] Receipt detail mở đúng import liên quan.
- [ ] Idempotent submit.
- [ ] Integration tests.

**Độ ưu tiên:** P1.

---

## TASK-075 - Implement cashbook template UI boundary

**Mục tiêu:** Port màn cấu hình mẫu thu/chi hiện hữu và xác định rõ local hay backend.

**Phụ thuộc:** TASK-071.

**File/Module liên quan:** `cashbook_template_page.dart`, settings finance navigation.

**Đầu ra mong muốn:** Nếu chưa có API, dữ liệu local được ghi rõ và không giả vờ đã sync.

**Checklist hoàn thành:**

- [ ] Product decision về persistence được ghi.
- [ ] CRUD local có test hoặc feature được đánh dấu unavailable.
- [ ] Không seed production ngoài lựa chọn mặc định đã duyệt.

**Độ ưu tiên:** P3.

