# Phase 7 - Stocktake and Documents

## TASK-064 - Implement stocktake creation/counting

**Mục tiêu:** Tạo phiếu kiểm kê, nhập số thực đếm và đồng bộ từng item.

**Phụ thuộc:** TASK-045, TASK-046.

**File/Module liên quan:** `lib/ui/pages/inventory/stocktake/`.

**Đầu ra mong muốn:** New/resume stocktake dùng dữ liệu backend.

**Checklist hoàn thành:**

- [ ] Phân biệt uncounted với counted=0.
- [ ] Count validation.
- [ ] Resume không tạo phiếu rác mới.
- [ ] Cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-065 - Implement stocktake draft/complete/cancel lifecycle

**Mục tiêu:** Lưu nháp, áp dụng và hủy kiểm kê an toàn.

**Phụ thuộc:** TASK-064.

**File/Module liên quan:** stocktake Cubit/page, stocktake endpoints.

**Đầu ra mong muốn:** Dirty state, confirm exit và final inventory update đúng.

**Checklist hoàn thành:**

- [ ] Pending counts được flush trước complete.
- [ ] Exit warning chỉ hiện khi có thay đổi chưa lưu.
- [ ] Chỉ hủy phiếu rác do phiên hiện tại tạo.
- [ ] Lifecycle integration test.

**Độ ưu tiên:** P1.

---

## TASK-066 - Implement stocktake history/detail

**Mục tiêu:** Tái tạo lịch sử, filter, resume draft và detail completed.

**Phụ thuộc:** TASK-065.

**File/Module liên quan:** `stocktake_history_*`, `stocktake_detail_page.dart`.

**Đầu ra mong muốn:** Status/action của từng phiếu đúng.

**Checklist hoàn thành:**

- [ ] Pagination/filter/search hoạt động.
- [ ] Draft mở resume; completed mở read-only.
- [ ] List refresh sau complete/cancel.
- [ ] Cubit/navigation tests.

**Độ ưu tiên:** P1.

---

## TASK-067 - Implement unified document/invoice list

**Mục tiêu:** Tổng hợp sales orders và stock imports thành danh sách chứng từ.

**Phụ thuộc:** TASK-052, TASK-061.

**File/Module liên quan:** `lib/ui/pages/inventory/invoice/`.

**Đầu ra mong muốn:** Filter loại/thời gian/search và detail route đúng loại chứng từ.

**Checklist hoàn thành:**

- [ ] Hai nguồn lỗi độc lập có partial state.
- [ ] Sort date thống nhất.
- [ ] ID/type không xung đột.
- [ ] Cubit tests.

**Độ ưu tiên:** P2.
