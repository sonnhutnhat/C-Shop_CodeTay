# Phase 4 - Catalog and Inventory Foundation

## TASK-039 - Implement catalog domain/data layer

**Mục tiêu:** Port category/product entity, DTO, mapper, datasource và repository.

**Phụ thuộc:** TASK-014, TASK-016, TASK-017.

**File/Module liên quan:** `models/catalog/`, `catalog_api_service.dart`, category/product repositories.

**Đầu ra mong muốn:** CRUD category/product và pagination có domain contract sạch.

**Checklist hoàn thành:**

- [ ] Field SKU/barcode/unit/price/stock/image/supplier map đủ.
- [ ] Pagination map đúng.
- [ ] Contract/repository tests.

**Độ ưu tiên:** P0.

---

## TASK-040 - Implement product list

**Mục tiêu:** Tái tạo danh sách, search, category filter, load more và detail product.

**Phụ thuộc:** TASK-021, TASK-039.

**File/Module liên quan:** `features/catalog/products/`.

**Đầu ra mong muốn:** List có pagination ổn định và refresh sau mutation.

**Checklist hoàn thành:**

- [ ] Search debounce.
- [ ] Không duplicate page.
- [ ] Empty/error/load-more state đúng.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P0.

---

## TASK-041 - Implement product create

**Mục tiêu:** Tái tạo form tạo sản phẩm và auto-create category khi cần.

**Phụ thuộc:** TASK-039, TASK-040, TASK-044.

**File/Module liên quan:** `product_form_sheet.dart`, product/category use cases.

**Đầu ra mong muốn:** Product mới xuất hiện trong list với dữ liệu backend.

**Checklist hoàn thành:**

- [ ] Required field/numeric validation.
- [ ] Category ID thật được gửi.
- [ ] Upload ảnh hoàn tất trước create.
- [ ] Test duplicate/validation/API error.

**Độ ưu tiên:** P0.

---

## TASK-042 - Implement product update

**Mục tiêu:** Sửa các field product hiện có và giữ semantics nullable/unchanged.

**Phụ thuộc:** TASK-040, TASK-044.

**File/Module liên quan:** product form, update product use case.

**Đầu ra mong muốn:** Update payload chỉ chứa field thay đổi theo contract.

**Checklist hoàn thành:**

- [ ] Snapshot dirty-state hoạt động.
- [ ] Có confirm khi thoát form bẩn.
- [ ] Cache/list được cập nhật sau success.
- [ ] Cubit test.

**Độ ưu tiên:** P1.

---

## TASK-043 - Implement product delete

**Mục tiêu:** Xóa sản phẩm với confirmation và xử lý conflict nghiệp vụ.

**Phụ thuộc:** TASK-040.

**File/Module liên quan:** product repository/use case/list/detail.

**Đầu ra mong muốn:** Delete success cập nhật list; API conflict được diễn giải.

**Checklist hoàn thành:**

- [ ] Không optimistic delete không thể rollback.
- [ ] Chống double submit.
- [ ] Confirmation dùng shared dialog.
- [ ] Test success/conflict/failure.

**Độ ưu tiên:** P1.

---

## TASK-044 - Implement file upload

**Mục tiêu:** Port chọn ảnh, permission, validate file và upload ảnh product/store.

**Phụ thuộc:** TASK-016, TASK-021.

**File/Module liên quan:** `storage_api_service.dart`, `storage_repository.dart`, `file_utils.dart`, `permission_utils.dart`.

**Đầu ra mong muốn:** Upload trả URL, có progress/cancel/error.

**Checklist hoàn thành:**

- [ ] MIME/size/extension được kiểm tra.
- [ ] Permission denial có hướng dẫn.
- [ ] Multipart retry không làm hỏng file.
- [ ] Repository/widget test.

**Độ ưu tiên:** P0.

---

## TASK-045 - Implement inventory domain/data layer

**Mục tiêu:** Port overview, item, import, stocktake, adjustment DTO/repository.

**Phụ thuộc:** TASK-014, TASK-016, TASK-039.

**File/Module liên quan:** `models/inventory/`, `inventory_api_service.dart`, `inventory_repository.dart`.

**Đầu ra mong muốn:** Inventory contract bao phủ endpoint hiện có.

**Checklist hoàn thành:**

- [ ] Status/code/quantity/money map đúng.
- [ ] Stocktake detail/items parse đủ.
- [ ] Repository tests cho mọi mutation.

**Độ ưu tiên:** P0.

---

## TASK-046 - Implement inventory overview/list

**Mục tiêu:** Tái tạo KPI kho, all/low/out tabs, search và filter.

**Phụ thuộc:** TASK-021, TASK-039, TASK-045.

**File/Module liên quan:** `inventory_cubit.dart`, `inventory_page.dart`.

**Đầu ra mong muốn:** Mỗi catalog product có trạng thái kho đúng, kể cả chưa có inventory record.

**Checklist hoàn thành:**

- [ ] Category/supplier/store data load độc lập.
- [ ] Tab count khớp dữ liệu.
- [ ] Route return kích hoạt refresh đúng, không do đóng sheet.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P0.

---

## TASK-047 - Implement inventory adjustment

**Mục tiêu:** Tăng/giảm/đặt tồn với lý do và note theo API.

**Phụ thuộc:** TASK-045, TASK-046.

**File/Module liên quan:** `inventory_adjust_sheet.dart`, adjustment use case.

**Đầu ra mong muốn:** Điều chỉnh thành công làm mới item/overview.

**Checklist hoàn thành:**

- [ ] Không cho quantity invalid.
- [ ] Reason/action map đúng backend.
- [ ] Idempotency chống tạo movement trùng.
- [ ] Test mutation/error.

**Độ ưu tiên:** P0.

---

## TASK-048 - Implement inventory item configuration

**Mục tiêu:** Cập nhật min stock, location và stock-managed configuration.

**Phụ thuộc:** TASK-045, TASK-046.

**File/Module liên quan:** inventory detail/config sheet, update config endpoint.

**Đầu ra mong muốn:** Alert tồn kho phản ánh config mới.

**Checklist hoàn thành:**

- [ ] Min stock/location validation.
- [ ] State đồng bộ sau save.
- [ ] Unit test mapping payload.

**Độ ưu tiên:** P1.

