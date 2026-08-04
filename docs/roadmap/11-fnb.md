# Phase 10 - F&B Variant

## TASK-085 - Define F&B backend contracts

**Mục tiêu:** Chốt API cho zone/table, menu/dish, table order, kitchen ticket và checkout.

**Phụ thuộc:** TASK-032, TASK-053.

**File/Module liên quan:** `lib/ui/pages/tables/`, F&B models, API service và
repository contract.

**Đầu ra mong muốn:** OpenAPI/ADR cho toàn vòng đời order tại bàn.

**Checklist hoàn thành:**

- [ ] Table/order/kitchen state machine được chốt.
- [ ] Concurrent edit/merge rule được chốt.
- [ ] Mapping F&B order sang order/payment chung được chốt.

**Độ ưu tiên:** P2.

---

## TASK-086 - Implement table map and filters

**Mục tiêu:** Tái tạo sơ đồ bàn theo zone/status qua repository contract.

**Phụ thuộc:** TASK-085.

**File/Module liên quan:** `table_management_*`, `tables_data.dart`.

**Đầu ra mong muốn:** Bàn hiển thị realtime/refresh từ API service hoặc
repository, không seed.

**Checklist hoàn thành:**

- [ ] Zone/status filter.
- [ ] Empty/loading/error state.
- [ ] Table action theo state.
- [ ] Cubit/widget tests.

**Độ ưu tiên:** P2.

---

## TASK-087 - Implement table configuration

**Mục tiêu:** Tạo/sửa/xóa bàn và zone.

**Phụ thuộc:** TASK-085, TASK-086.

**File/Module liên quan:** `table_config_*`.

**Đầu ra mong muốn:** Table config persist backend và refresh map.

**Checklist hoàn thành:**

- [ ] Unique name/code validation.
- [ ] Delete occupied table bị chặn.
- [ ] Mutation idempotent.
- [ ] Integration tests.

**Độ ưu tiên:** P2.

---

## TASK-088 - Implement F&B menu management

**Mục tiêu:** Tái tạo danh mục/món, availability và CRUD bằng API.

**Phụ thuộc:** TASK-085, TASK-044.

**File/Module liên quan:** `tables/menu/`.

**Đầu ra mong muốn:** Menu không dùng `MenuData.dishes`.

**Checklist hoàn thành:**

- [ ] Category/search/availability hoạt động.
- [ ] Create/update/image upload.
- [ ] Availability ảnh hưởng order screen.
- [ ] Tests.

**Độ ưu tiên:** P2.

---

## TASK-089 - Implement order at table

**Mục tiêu:** Chọn bàn/món, quantity/note và tạo/cập nhật order tại bàn.

**Phụ thuộc:** TASK-086, TASK-088.

**File/Module liên quan:** `order_at_table_*`.

**Đầu ra mong muốn:** Order draft persist backend và phản ánh table status.

**Checklist hoàn thành:**

- [ ] Quantity/total calculation.
- [ ] Note per order/item theo contract.
- [ ] Concurrent update conflict được xử lý.
- [ ] Integration tests.

**Độ ưu tiên:** P2.

---

## TASK-090 - Implement kitchen workflow

**Mục tiêu:** Port kitchen tickets và chuyển trạng thái nhận món/đang làm/sẵn sàng/đã phục vụ.

**Phụ thuộc:** TASK-085, TASK-089.

**File/Module liên quan:** `tables/kitchen/`.

**Đầu ra mong muốn:** Kitchen không dùng `_seed`; transition tuân state machine.

**Checklist hoàn thành:**

- [ ] Invalid transition bị chặn.
- [ ] Polling/realtime strategy được chốt.
- [ ] Ticket update idempotent.
- [ ] Cubit/integration tests.

**Độ ưu tiên:** P2.

---

## TASK-091 - Integrate F&B checkout

**Mục tiêu:** Chuyển table order sang payment/order chung và đóng bàn sau success.

**Phụ thuộc:** TASK-057, TASK-059, TASK-089.

**File/Module liên quan:** table checkout Cubit và sales payment pages.

**Đầu ra mong muốn:** Thanh toán thành công cập nhật order và table atomically theo backend contract.

**Checklist hoàn thành:**

- [ ] Không đóng bàn khi payment fail.
- [ ] Không tạo order duplicate.
- [ ] Split/merge bill được ghi rõ supported hay deferred.
- [ ] End-to-end test.

**Độ ưu tiên:** P2.
