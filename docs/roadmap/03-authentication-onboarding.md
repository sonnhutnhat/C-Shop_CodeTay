# Phase 2 - Authentication and Onboarding

## TASK-022 - Port auth models và repository contract

**Mục tiêu:** Tạo token/session entity trong `lib/models/entities`, auth DTO
trong `lib/models/dto/auth` và repository contract/implementation trong
`lib/repositories`.

**Phụ thuộc:** TASK-014, TASK-015.

**File/Module liên quan:** `models/dto/auth/`, `token_entity.dart`, `session_entity.dart`, `auth_repository.dart`.

**Đầu ra mong muốn:** Cubit/Page chỉ gọi `AuthRepository` và không phụ thuộc
trực tiếp vào Dio.

**Checklist hoàn thành:**

- [ ] DTO parse đủ response hiện hữu.
- [ ] Mapper xử lý field thiếu/null.
- [ ] Repository contract bao phủ OTP, login, register, password, tenant, device, logout.

**Độ ưu tiên:** P0.

---

## TASK-023 - Implement auth API service

**Mục tiêu:** Port toàn bộ auth/tenant/device endpoint hiện có.

**Phụ thuộc:** TASK-016, TASK-017, TASK-022.

**File/Module liên quan:** `auth_api_service.dart`, `api_endpoints.dart`.

**Đầu ra mong muốn:** `AuthApiService` có request/response type rõ ràng cho
từng endpoint.

**Checklist hoàn thành:**

- [ ] OTP/register/login/reset/change-password endpoint được port.
- [ ] Tenant/store summary/device/logout endpoint được port.
- [ ] Contract test xác minh path, method, body và header đặc biệt.

**Độ ưu tiên:** P0.

---

## TASK-024 - Implement auth repository persistence

**Mục tiêu:** Lưu token, tenant/store/user session, business type và onboarding flag sau auth.

**Phụ thuộc:** TASK-015, TASK-022, TASK-023.

**File/Module liên quan:** `auth_repository.dart`, secure/preferences storage.

**Đầu ra mong muốn:** Auth response được persist atomically và rollback hợp lý khi lỗi.

**Checklist hoàn thành:**

- [ ] `hasContext` quyết định onboarding.
- [ ] Business industry map đúng enum.
- [ ] Logout luôn clear local dù API logout lỗi.
- [ ] Repository unit test đầy đủ.

**Độ ưu tiên:** P0.

---

## TASK-025 - Implement Splash

**Mục tiêu:** Tái tạo visual Splash trước; kích hoạt session coordinator khi
AuthRepository và các route đích đã sẵn sàng.

**Phụ thuộc:** Visual phụ thuộc TASK-008, TASK-011; điều hướng session phụ
thuộc TASK-020, TASK-021, TASK-024.

**File/Module liên quan:** `lib/ui/pages/app_start/splash/`,
`assets/images/img_splash.png`.

**Đầu ra mong muốn:** Route `/` hiển thị đúng ảnh Splash C-Shop; sau khi hoàn
thiện auth, Splash dẫn tới login, onboarding hoặc main shell đúng trạng thái.

**Checklist hoàn thành:**

- [x] Ảnh Splash full-screen dùng `BoxFit.cover`.
- [x] Route `/` render `SplashPage`, không còn `BasePage` tạm.
- [ ] Không delay cứng nếu bootstrap đã hoàn thành.
- [ ] Không double navigation.
- [x] Có widget test cho visual Splash.
- [ ] Có navigation test khi session coordinator được nối.

**Độ ưu tiên:** P0.

---

## TASK-026 - Implement Login

**Mục tiêu:** Tái tạo login UI, validation và gọi `AuthRepository`.

**Phụ thuộc:** TASK-021, TASK-024, TASK-025.

**File/Module liên quan:** `lib/ui/pages/auth/login/login_cubit.dart`,
`login_state.dart`, `login_page.dart`.

**Đầu ra mong muốn:** Login thành công vào onboarding hoặc main shell; lỗi hiển thị đúng.

**Checklist hoàn thành:**

- [ ] Phone/password validation giữ convention.
- [ ] Loading chống submit lặp.
- [ ] Link register/forgot/privacy hoạt động.
- [ ] Cubit và widget test.

**Độ ưu tiên:** P0.

---

## TASK-027 - Implement Register OTP

**Mục tiêu:** Tái tạo yêu cầu OTP, resend timer và verify OTP cho đăng ký.

**Phụ thuộc:** TASK-021, TASK-024.

**File/Module liên quan:** `lib/ui/pages/auth/register/`,
`register_cubit.dart`, OTP widgets.

**Đầu ra mong muốn:** Multi-step register đi từ contact tới OTP verification.

**Checklist hoàn thành:**

- [ ] Email/phone capability bám contract backend thực tế.
- [ ] Timer không chạy trùng sau rebuild.
- [ ] Back giữ/xóa state đúng bước.
- [ ] Test send/resend/verify failure.

**Độ ưu tiên:** P0.

---

## TASK-028 - Implement Register password setup

**Mục tiêu:** Hoàn tất tên, mật khẩu và confirm password sau OTP.

**Phụ thuộc:** TASK-027.

**File/Module liên quan:** `lib/ui/pages/auth/register/`, password strength
widget, `AuthRepository`.

**Đầu ra mong muốn:** Session được lưu và điều hướng onboarding sau setup thành công.

**Checklist hoàn thành:**

- [ ] Password rule và confirm được validate.
- [ ] Verification token không lộ log.
- [ ] Submit idempotent.
- [ ] Cubit test success/error.

**Độ ưu tiên:** P0.

---

## TASK-029 - Implement Forgot Password flow

**Mục tiêu:** Tái tạo request OTP, verify và reset password.

**Phụ thuộc:** TASK-021, TASK-024.

**File/Module liên quan:** `lib/ui/pages/auth/forgot_password/`.

**Đầu ra mong muốn:** Reset thành công quay lại login với stack đúng.

**Checklist hoàn thành:**

- [ ] Resend/back behavior đúng.
- [ ] Password strength được dùng chung.
- [ ] Token verification được xóa sau complete/cancel.
- [ ] Cubit và navigation test.

**Độ ưu tiên:** P0.

---

## TASK-030 - Implement Onboarding business selection

**Mục tiêu:** Tái tạo bước chọn loại hình và phân ngành.

**Phụ thuộc:** TASK-021, TASK-024.

**File/Module liên quan:** `lib/ui/pages/onboarding/`, `BusinessType`,
`onboarding_data.dart`.

**Đầu ra mong muốn:** Lựa chọn map chính xác sang API business industry.

**Checklist hoàn thành:**

- [ ] Retail/F&B/Service map đúng.
- [ ] Multi-select phân ngành không mất khi back.
- [ ] State không chứa widget/context.

**Độ ưu tiên:** P0.

---

## TASK-031 - Implement Onboarding store registration

**Mục tiêu:** Gửi thông tin cửa hàng/hộ kinh doanh và hoàn thành onboarding.

**Phụ thuộc:** TASK-030.

**File/Module liên quan:** `onboarding_cubit.dart`, tenant update/register API.

**Đầu ra mong muốn:** Tenant/store/session được cập nhật trước khi vào app.

**Checklist hoàn thành:**

- [ ] Store name/phone/address/tax ID validate đúng.
- [ ] Không đánh dấu onboarded trước API success.
- [ ] Business type được persist.
- [ ] Integration test toàn onboarding.

**Độ ưu tiên:** P0.
