# Phase 6 - Sales, Orders and Customers

## TASK-053 - Implement order models, API và repository

**Mục tiêu:** Port order, detail, recent transaction, sales overview và top product.

**Phụ thuộc:** TASK-014, TASK-016, TASK-039.

**File/Module liên quan:** order/sales DTO, `orders_api_service.dart`, repository.

**Đầu ra mong muốn:** Create/list/detail/cancel/analytics contract sạch.

**Checklist hoàn thành:**

- [ ] Money/status/payment/customer/line item map đủ.
- [ ] Pagination metadata giữ nguyên.
- [ ] Contract/repository tests.

**Độ ưu tiên:** P0.

---

## TASK-054 - Implement Retail POS catalog/cart

**Mục tiêu:** Tái tạo product grid, category/search, cart và stock constraint.

**Phụ thuộc:** TASK-021, TASK-039, TASK-046.

**File/Module liên quan:** `lib/ui/pages/sales/pos/`.

**Đầu ra mong muốn:** Cart calculation deterministic và không bán vượt rule cấu hình.

**Checklist hoàn thành:**

- [ ] Quantity/price/total unit test.
- [ ] Silent reload không xóa cart.
- [ ] Out-of-stock/product-disabled behavior đúng.
- [ ] UI state test.

**Độ ưu tiên:** P0.

---

## TASK-055 - Implement customer models, API, repository và list

**Mục tiêu:** Port customer list, search, create/update và customer orders.

**Phụ thuộc:** TASK-014, TASK-016, TASK-021, TASK-053.

**File/Module liên quan:** customer DTO/API/repository,
`lib/ui/pages/customers/`.

**Đầu ra mong muốn:** Customer list/detail dùng API, có lịch sử mua hàng.

**Checklist hoàn thành:**

- [ ] Customer fields/debt map đúng.
- [ ] Search/pagination hoạt động.
- [ ] Order query theo customer không trộn dữ liệu.
- [ ] Repository/cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-056 - Implement customer create/update

**Mục tiêu:** Tái tạo customer form dùng chung từ management và payment.

**Phụ thuộc:** TASK-055.

**File/Module liên quan:** `customer_form_sheet.dart`,
`lib/repositories/customer_repository.dart`.

**Đầu ra mong muốn:** Customer mới có thể chọn ngay trong luồng thanh toán.

**Checklist hoàn thành:**

- [ ] Phone/email validation.
- [ ] Form create/edit phân biệt rõ.
- [ ] Caller nhận customer ID sau create.
- [ ] Widget/cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-057 - Implement payment method and cash flow

**Mục tiêu:** Port tiền mặt, chuyển khoản và ghi nợ; tính tiền thừa và chọn khách.

**Phụ thuộc:** TASK-053, TASK-054, TASK-055.

**File/Module liên quan:** `lib/ui/pages/sales/payment/`.

**Đầu ra mong muốn:** Payment request hợp lệ cho từng method.

**Checklist hoàn thành:**

- [ ] Cash/change calculation unit test.
- [ ] Debt bắt buộc customer.
- [ ] Invalid amount bị chặn.
- [ ] Không tạo order trước khi confirm.

**Độ ưu tiên:** P0.

---

## TASK-058 - Implement VietQR bank payment

**Mục tiêu:** Tạo VietQR từ bank account được chọn và số tiền order.

**Phụ thuộc:** TASK-057, TASK-070.

**File/Module liên quan:** `viet_qr_builder.dart`, `bank_picker_field.dart`, payment page.

**Đầu ra mong muốn:** QR payload CRC hợp lệ và UI có fallback khi chưa cấu hình bank.

**Checklist hoàn thành:**

- [ ] QR payload unit test theo test vector.
- [ ] Account name/number không log.
- [ ] Đổi bank cập nhật QR.
- [ ] Missing config dẫn tới settings route.

**Độ ưu tiên:** P1.

---

## TASK-059 - Implement order creation orchestration

**Mục tiêu:** Chuyển cart/payment/customer thành create-order command và xử lý kết quả.

**Phụ thuộc:** TASK-053, TASK-057.

**File/Module liên quan:** payment Cubit và order repository.

**Đầu ra mong muốn:** Order chỉ tạo một lần; cart chỉ clear sau success.

**Checklist hoàn thành:**

- [ ] Idempotency key ổn định trong một lần retry.
- [ ] API error không làm mất cart.
- [ ] Order ID/code trả về payment success.
- [ ] Integration test.

**Độ ưu tiên:** P0.

---

## TASK-060 - Implement payment success

**Mục tiêu:** Tái tạo receipt summary và action tạo đơn mới/về home/xem detail.

**Phụ thuộc:** TASK-059.

**File/Module liên quan:** `payment_success_page.dart`.

**Đầu ra mong muốn:** Navigation stack và cart lifecycle đúng.

**Checklist hoàn thành:**

- [ ] Back không tạo/clear order lần hai.
- [ ] Dữ liệu hiển thị lấy từ create response.
- [ ] Navigation test cho ba action.

**Độ ưu tiên:** P1.

---

## TASK-061 - Implement order history

**Mục tiêu:** Tái tạo filter thời gian, custom range, search và pagination đơn hàng.

**Phụ thuộc:** TASK-053, TASK-021.

**File/Module liên quan:** `lib/ui/pages/sales/order_history/`.

**Đầu ra mong muốn:** List và tổng doanh thu phản ánh toàn bộ filter backend.

**Checklist hoàn thành:**

- [ ] Date range timezone đúng.
- [ ] Summary không chỉ tính page hiện tại.
- [ ] Search/filter reset pagination.
- [ ] Cubit tests.

**Độ ưu tiên:** P1.

---

## TASK-062 - Implement order detail and cancellation

**Mục tiêu:** Tái tạo detail line item/payment/customer và hủy đơn.

**Phụ thuộc:** TASK-053, TASK-061.

**File/Module liên quan:** `lib/ui/pages/sales/order_detail/`.

**Đầu ra mong muốn:** Detail tải theo ID; cancel cập nhật status và list nguồn.

**Checklist hoàn thành:**

- [ ] Invalid/null ID có empty state, không dùng mock.
- [ ] Cancel reason và confirmation đúng.
- [ ] Không cho hủy status không hợp lệ.
- [ ] Cubit/navigation tests.

**Độ ưu tiên:** P1.

---

## TASK-063 - Implement voice order parser

**Mục tiêu:** Port speech recognition và parser để thêm item vào POS bằng giọng nói.

**Phụ thuộc:** TASK-039, TASK-054.

**File/Module liên quan:** `voice_order_button.dart`, `voice_order_parser.dart`, permission utils.

**Đầu ra mong muốn:** Transcript được parse thành product/quantity có bước xác nhận.

**Checklist hoàn thành:**

- [ ] Permission/microphone lifecycle đúng.
- [ ] Parser unit test cho tiếng Việt và số lượng.
- [ ] Ambiguous/no-match không tự thêm sai.
- [ ] Không ghi âm/log nội dung ngoài nhu cầu.

**Độ ưu tiên:** P2.
