# Phase 1 - Application Foundation

## TASK-009 - Xây dựng app bootstrap pipeline

**Mục tiêu:** Khởi tạo binding, environment, storage, Firebase, notification và dependency trước `runApp`.

**Phụ thuộc:** TASK-006, TASK-007.

**File/Module liên quan:** `lib/app/bootstrap/`, `main_<flavor>.dart`.

**Đầu ra mong muốn:** Bootstrap có error boundary và có thể test độc lập.

**Checklist hoàn thành:**

- [ ] Init theo thứ tự xác định.
- [ ] Lỗi init quan trọng được log và hiển thị fallback.
- [ ] Service tùy chọn không làm app crash.

**Độ ưu tiên:** P0.

---

## TASK-010 - Thiết lập dependency injection composition root

**Mục tiêu:** Đăng ký core service và feature dependency tại một composition root.

**Phụ thuộc:** TASK-006, TASK-009.

**File/Module liên quan:** `lib/app/di/`, root `MultiRepositoryProvider`, root `MultiBlocProvider`.

**Đầu ra mong muốn:** UI không tự tạo API service/repository; dependency có thể override trong test.

**Checklist hoàn thành:**

- [ ] Lifetime singleton/factory được ghi rõ.
- [ ] Feature registration tách module.
- [ ] Test có thể inject fake repository.

**Độ ưu tiên:** P0.

---

## TASK-011 - Port design tokens và app theme

**Mục tiêu:** Port `AppColors`, `AppDimens`, `AppTextStyles`, `AppShadows`, `AppThemes` vào core theme.

**Phụ thuộc:** TASK-008.

**File/Module liên quan:** source `lib/common/*`; target `lib/app/theme/`.

**Đầu ra mong muốn:** Light theme tái tạo đúng visual language C-Shop.

**Checklist hoàn thành:**

- [ ] Không dùng magic color/spacing trong widget nền tảng.
- [ ] Typography dùng đúng Inter/Roboto.
- [ ] Có theme smoke/golden test.

**Độ ưu tiên:** P0.

---

## TASK-012 - Thiết lập localization foundation

**Mục tiêu:** Port ARB vi/en và cơ chế đổi ngôn ngữ.

**Phụ thuộc:** TASK-004, TASK-006.

**File/Module liên quan:** `lib/core/localization/`, `l10n/*.arb`, `AppSettingCubit`.

**Đầu ra mong muốn:** Locale được persist và app rebuild đúng.

**Checklist hoàn thành:**

- [ ] vi/en generate thành công.
- [ ] Fallback locale được định nghĩa.
- [ ] Không commit sửa tay generated localization.

**Độ ưu tiên:** P1.

---

## TASK-013 - Thiết lập logger và redaction

**Mục tiêu:** Port logger nhưng bảo vệ token, OTP, password, thông tin cá nhân và tắt cURL nhạy cảm ở production.

**Phụ thuộc:** TASK-002, TASK-006.

**File/Module liên quan:** `lib/utils/logger.dart`, `ApiInterceptors`, `lib/core/logging/`.

**Đầu ra mong muốn:** Structured logger theo environment với redaction test.

**Checklist hoàn thành:**

- [ ] Không log Authorization/password/OTP.
- [ ] Production không in raw body/cURL.
- [ ] Request ID xuất hiện trong log lỗi.

**Độ ưu tiên:** P0.

---

## TASK-014 - Xây dựng error model chung

**Mục tiêu:** Chuẩn hóa Dio, API envelope, validation, connectivity và unknown error thành failure/domain error.

**Phụ thuộc:** TASK-006.

**File/Module liên quan:** `api_exception.dart`, `api_envelope.dart`, `base_repository.dart`, `lib/core/error/`.

**Đầu ra mong muốn:** Presentation không phụ thuộc `DioException`.

**Checklist hoàn thành:**

- [ ] Mapping error code hiện có được port.
- [ ] Validation field errors được giữ.
- [ ] Có unit test cho HTTP/error envelope chính.

**Độ ưu tiên:** P0.

---

## TASK-015 - Xây dựng storage abstraction

**Mục tiêu:** Tách secure storage và preferences thành interface testable.

**Phụ thuộc:** TASK-006, TASK-010.

**File/Module liên quan:** `secure_storage_helper.dart`, `share_preferences_helper.dart`, `lib/core/storage/`.

**Đầu ra mong muốn:** Token/session nằm secure storage; setting và local config nằm preferences.

**Checklist hoàn thành:**

- [ ] Async method đều được `await`.
- [ ] First-run/uninstall behavior được test.
- [ ] Có clear auth và clear user preference tách biệt.

**Độ ưu tiên:** P0.

---

## TASK-016 - Xây dựng networking client

**Mục tiêu:** Tạo Dio factory theo flavor với timeout, JSON headers, adapter và error handling.

**Phụ thuộc:** TASK-002, TASK-013, TASK-014.

**File/Module liên quan:** `api_util.dart`, `api_client.dart`, `lib/core/network/`.

**Đầu ra mong muốn:** Một networking stack thống nhất; bỏ Retrofit client mẫu `/login`, `/logout` không dùng.

**Checklist hoàn thành:**

- [ ] Base URL lấy từ environment.
- [ ] Timeout/cancel token được hỗ trợ.
- [ ] API service có thể mock trong test.

**Độ ưu tiên:** P0.

---

## TASK-017 - Xây dựng request context interceptor

**Mục tiêu:** Gắn request ID, idempotency key, token, tenant ID và store ID đúng điều kiện.

**Phụ thuộc:** TASK-015, TASK-016.

**File/Module liên quan:** `api_interceptors.dart`, `request_id.dart`.

**Đầu ra mong muốn:** Header contract tương thích API C-Shop.

**Checklist hoàn thành:**

- [ ] GET/HEAD không có idempotency key.
- [ ] Pre-auth request không bị ép context header.
- [ ] Header do request truyền vào không bị ghi đè.
- [ ] Có interceptor unit test.

**Độ ưu tiên:** P0.

---

## TASK-018 - Xây dựng refresh token single-flight

**Mục tiêu:** Chỉ refresh một lần khi nhiều request đồng thời nhận 401 rồi retry an toàn.

**Phụ thuộc:** TASK-015, TASK-016, TASK-017.

**File/Module liên quan:** `api_interceptors.dart`, auth token datasource.

**Đầu ra mong muốn:** Refresh/retry không deadlock, không loop, bảo toàn method/body/query/header.

**Checklist hoàn thành:**

- [ ] Concurrent 401 chỉ gọi một refresh.
- [ ] Refresh endpoint không tự refresh.
- [ ] Refresh thất bại clear auth và phát session-expired event.
- [ ] Upload/cancel/progress behavior được xác minh.

**Độ ưu tiên:** P0.

---

## TASK-019 - Xây dựng app router và route contracts

**Mục tiêu:** Khai báo toàn bộ route app-start và feature bằng GoRouter thay cho callback navigation rải rác.

**Phụ thuộc:** TASK-006, TASK-010.

**File/Module liên quan:** `route_config.dart`, `app_navigator.dart`, `MainNavigationPage`.

**Đầu ra mong muốn:** Typed route name/path/argument và root navigator key thống nhất.

**Checklist hoàn thành:**

- [ ] App-start route ngang hàng, không lộ Splash khi swipe back.
- [ ] Route argument không dùng entity data-layer.
- [ ] Deep-link invalid có fallback.
- [ ] Navigation test cho route chính.

**Độ ưu tiên:** P0.

---

## TASK-020 - Xây dựng auth guard và session coordinator

**Mục tiêu:** Quyết định redirect dựa trên token, session context và onboarding status.

**Phụ thuộc:** TASK-018, TASK-019.

**File/Module liên quan:** `splash_cubit.dart`, router redirect, session storage.

**Đầu ra mong muốn:** Một nguồn sự thật cho unauthenticated, needs-onboarding, authenticated và expired.

**Checklist hoàn thành:**

- [ ] Cold start với mọi trạng thái được test.
- [ ] Logout/401 dọn stack.
- [ ] Không gọi navigation trực tiếp từ interceptor.

**Độ ưu tiên:** P0.

---

## TASK-021 - Port shared CShop widgets

**Mục tiêu:** Port bộ widget nền tảng không chứa business logic.

**Phụ thuộc:** TASK-011, TASK-012.

**File/Module liên quan:** source `lib/ui/widgets/`; target `lib/core/widgets/`.

**Đầu ra mong muốn:** Button, field, card, badge, header, list, bottom sheet, dialog, loading, empty/error/async view dùng lại được.

**Checklist hoàn thành:**

- [ ] Giữ prefix `CShop`.
- [ ] Có disabled/loading/error semantics.
- [ ] Có accessibility label và tap target hợp lệ.
- [ ] Widget test cho control quan trọng.

**Độ ưu tiên:** P0.

