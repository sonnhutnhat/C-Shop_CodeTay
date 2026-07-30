# Phase 2 - Authentication and Onboarding

## TASK-022 - Port auth domain models và repository contract

**Mục tiêu:** Tạo entity/session/token/auth repository ở domain, tách DTO/API mapper ở data.

**Phụ thuộc:** TASK-014, TASK-015.

**File/Module liên quan:** `models/dto/auth/`, `token_entity.dart`, `session_entity.dart`, `auth_repository.dart`.

**Đầu ra mong muốn:** Auth domain không import JSON/Dio/Flutter.

**Checklist hoàn thành:**

- [ ] DTO parse đủ response hiện hữu.
- [ ] Mapper xử lý field thiếu/null.
- [ ] Repository contract bao phủ OTP, login, register, password, tenant, device, logout.

**Độ ưu tiên:** P0.

---

## TASK-023 - Implement auth remote datasource

**Mục tiêu:** Port toàn bộ auth/tenant/device endpoint hiện có.

**Phụ thuộc:** TASK-016, TASK-017, TASK-022.

**File/Module liên quan:** `auth_api_service.dart`, `api_endpoints.dart`.

**Đầu ra mong muốn:** Datasource có request/response type rõ ràng cho từng endpoint.

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

## TASK-025 - Implement Splash feature

**Mục tiêu:** Tái tạo splash và kích hoạt session coordinator.

**Phụ thuộc:** TASK-020, TASK-021, TASK-024.

**File/Module liên quan:** `features/app_start/splash/`, `img_splash.png`.

**Đầu ra mong muốn:** Splash dẫn tới login, onboarding hoặc main shell đúng trạng thái.

**Checklist hoàn thành:**

- [ ] Không delay cứng nếu bootstrap đã hoàn thành.
- [ ] Không double navigation.
- [ ] Có widget/navigation test.

**Độ ưu tiên:** P0.

---

## TASK-026 - Implement Login feature

**Mục tiêu:** Tái tạo login UI, validation và gọi login use case.

**Phụ thuộc:** TASK-021, TASK-024, TASK-025.

**File/Module liên quan:** `features/auth/login/`, `login_cubit.dart`, `login_page.dart`.

**Đầu ra mong muốn:** Login thành công vào onboarding hoặc main shell; lỗi hiển thị đúng.

**Checklist hoàn thành:**

- [ ] Phone/password validation giữ convention.
- [ ] Loading chống submit lặp.
- [ ] Link register/forgot/privacy hoạt động.
- [ ] Cubit và widget test.

**Độ ưu tiên:** P0.

---

## TASK-027 - Implement Register OTP feature

**Mục tiêu:** Tái tạo yêu cầu OTP, resend timer và verify OTP cho đăng ký.

**Phụ thuộc:** TASK-021, TASK-024.

**File/Module liên quan:** `features/auth/register/`, `register_cubit.dart`, OTP widgets.

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

**File/Module liên quan:** register presentation, password strength widget, auth use case.

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

**File/Module liên quan:** `features/auth/forgot_password/`.

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

**File/Module liên quan:** `features/onboarding/`, `BusinessType`, `onboarding_data.dart`.

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

