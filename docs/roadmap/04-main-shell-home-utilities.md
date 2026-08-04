# Phase 3 - Main Shell, Home and Utilities

## TASK-032 - Implement dynamic main navigation shell

**Mục tiêu:** Tạo shell và bottom navigation đổi theo BusinessType.

**Phụ thuộc:** TASK-019, TASK-021, TASK-031.

**File/Module liên quan:** `main_navigation_*`, `CShopBottomNavBar`.

**Đầu ra mong muốn:** 4 tab + central FAB hoạt động cho Retail/F&B/Service.

**Checklist hoàn thành:**

- [ ] Tab state được giữ hợp lý.
- [ ] Back behavior không thoát sai.
- [ ] Business type đổi thì nav đồng bộ.
- [ ] Widget test cho ba cấu hình.

**Độ ưu tiên:** P0.

---

## TASK-033 - Implement global action FAB

**Mục tiêu:** Port menu hành động nhanh theo từng business type.

**Phụ thuộc:** TASK-032.

**File/Module liên quan:** FAB overlay trong `MainNavigationPage`.

**Đầu ra mong muốn:** Action mở đúng typed route và overlay đóng đúng.

**Checklist hoàn thành:**

- [ ] Tap outside/back đóng overlay.
- [ ] Mỗi action có permission/availability rule.
- [ ] Không chứa navigation callback chuỗi rải rác.

**Độ ưu tiên:** P1.

---

## TASK-034 - Implement Home dashboard aggregation

**Mục tiêu:** Port dashboard dùng finance summary, sales overview, target, top product, tenant và recent transaction.

**Phụ thuộc:** TASK-024, TASK-032, TASK-046, TASK-053.

**File/Module liên quan:** `lib/ui/pages/home/home_cubit.dart`,
`home_state.dart`, các repository liên quan.

**Đầu ra mong muốn:** Dashboard hỗ trợ partial success thay vì fallback mock ngầm.

**Checklist hoàn thành:**

- [ ] Request độc lập chạy song song.
- [ ] Today/yesterday date theo timezone thống nhất.
- [ ] Lỗi từng card có retry/fallback rõ.
- [ ] Aggregation unit test.

**Độ ưu tiên:** P1.

---

## TASK-035 - Implement Home dashboard UI

**Mục tiêu:** Tái tạo KPI, revenue progress, inventory alert, top products và recent transactions.

**Phụ thuộc:** TASK-021, TASK-034.

**File/Module liên quan:** `home_page.dart`, `home_data.dart`.

**Đầu ra mong muốn:** Home không phụ thuộc dữ liệu seed và route action hoạt động.

**Checklist hoàn thành:**

- [ ] Loading/empty/error/partial states hiển thị đúng.
- [ ] Pull-to-refresh/reload event hoạt động.
- [ ] Golden test cho layout chính.

**Độ ưu tiên:** P1.

---

## TASK-036 - Implement global search

**Mục tiêu:** Tìm đồng thời product, order và customer với debounce và recent query local.

**Phụ thuộc:** TASK-015, TASK-040, TASK-046, TASK-055.

**File/Module liên quan:** `lib/ui/pages/global_search/`.

**Đầu ra mong muốn:** Kết quả nhóm theo tab và mở đúng detail route.

**Checklist hoàn thành:**

- [ ] Debounce/cancel request cũ.
- [ ] Recent search persist có giới hạn.
- [ ] Không search query quá ngắn.
- [ ] Cubit test race condition.

**Độ ưu tiên:** P2.

---

## TASK-037 - Implement notification local models và UI

**Mục tiêu:** Port notification list/filter/read state nhưng tách mock khỏi
production code.

**Phụ thuộc:** TASK-015, TASK-021, TASK-032.

**File/Module liên quan:** `notification_entity.dart`, `notification_cubit.dart`, `notification_data.dart`.

**Đầu ra mong muốn:** UI hoàn chỉnh với local/fake data source chỉ bật ở dev.

**Checklist hoàn thành:**

- [ ] Read/unread/filter/mark-all hoạt động.
- [ ] Production không tự hiển thị seed notification.
- [ ] Empty/error state có test.

**Độ ưu tiên:** P2.

---

## TASK-038 - Integrate Firebase push notification

**Mục tiêu:** Khởi tạo FCM, permission, token lifecycle và xử lý foreground/background/deep link.

**Phụ thuộc:** TASK-002, TASK-009, TASK-019, TASK-037.

**File/Module liên quan:** `notification_service.dart`, Android/iOS Firebase config.

**Đầu ra mong muốn:** Push mở đúng route và không đăng ký handler trùng.

**Checklist hoàn thành:**

- [ ] iOS permission/APNs config đúng.
- [ ] Android notification channel đúng.
- [ ] Token refresh có nơi sync backend hoặc ghi rõ blocked contract.
- [ ] Deep-link payload được validate.

**Độ ưu tiên:** P2.
