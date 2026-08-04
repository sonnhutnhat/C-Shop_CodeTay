# C-Shop — Roadmap code tay

## Nguồn và mục tiêu

Source tham chiếu:

```text
/Users/nkson.ts/Documents/CmcProject/c-shop
```

Project thực hành:

```text
/Users/nkson.ts/Documents/Nkson-Project/C-Shop_CodeTay
```

Mục tiêu là tự code lại C-Shop theo hành vi và convention của source. Cấu trúc
project phải giữ dạng layer-first giống source, không chuyển sang Feature First.

## Cách dùng roadmap

- Làm từ trên xuống dưới.
- Mỗi checkbox là một task code nhỏ.
- Chỉ đọc source tham chiếu để hiểu flow, API, UI và convention.
- Không copy nguyên file từ source tham chiếu.
- Chỉ tạo file khi task hiện tại cần.
- Hoàn thành task nào thì đổi `[ ]` thành `[x]`.
- Cuối mỗi nhóm chạy `dart format`, `flutter analyze` và `flutter test`.
- Roadmap chi tiết theo Task ID nằm tại [roadmap.md](roadmap.md).

## Cấu trúc bắt buộc

```text
lib/
├── common/
├── configs/
├── database/
├── generated/
├── global/
├── global_blocs/
├── l10n/
├── models/
│   ├── dto/
│   ├── entities/
│   ├── enums/
│   ├── params/
│   └── response/
├── network/
├── repositories/
├── router/
├── services/
├── ui/
│   ├── pages/
│   └── widgets/
├── utils/
├── app.dart
├── main.dart
├── main_dev.dart
└── main_prod.dart
```

Quy tắc:

- Không tạo thư mục `lib/app/`, `lib/core/` hoặc `lib/features/`.
- `lib/app.dart` là nơi đăng ký root repository/global Cubit và chứa
  `MaterialApp.router`; không tạo provider rỗng khi chưa có dependency.
- `main*.dart` cấu hình environment/service rồi gọi `runApp(const MyApp())`.
- DTO/entity/enum/params nằm trong `lib/models/`.
- Dio, interceptor, endpoint và API service nằm trong `lib/network/`.
- Repository contract và implementation nằm cùng file hoặc cùng thư mục
  `lib/repositories/`, theo convention của source.
- Page, page-level Cubit/State và widget riêng của màn hình nằm trong
  `lib/ui/pages/<module>/`.
- Global Cubit nằm trong `lib/global_blocs/`.
- Widget dùng chung nằm trong `lib/ui/widgets/`.
- Không tạo use case, datasource hoặc mapper layer riêng nếu module tham chiếu
  không cần.

## Thứ tự code một module

Với mỗi module nghiệp vụ, làm theo thứ tự:

```text
models → network API service → repository → Cubit/State → Page/Widget
       → route/provider cần thiết → test
```

Không đăng ký repository rỗng trong `app.dart`. Chỉ thêm provider sau khi
repository đã có consumer.

---

# Chặng 1 — Rà và hoàn thiện base hiện có

## 1.1 Structure và app composition

- [x] Xác nhận không còn thư mục Feature First.
- [x] Giữ `MyApp` tại `lib/app.dart`.
- [x] Giữ environment bootstrap tại `main.dart`, `main_dev.dart`,
  `main_prod.dart`.
- [x] Không tạo `MultiRepositoryProvider` rỗng khi chưa có repository.
- [x] Dùng `MultiBlocProvider` cho global Cubit.
- [x] Không tạo `AppDependencies`.
- [x] Port `assets/images/img_splash.png` từ source tham chiếu.
- [x] Tạo `lib/ui/pages/app_start/splash/splash_page.dart`.
- [x] Cho route `/` render `SplashPage`.
- [x] Viết widget test xác nhận Splash render được.

## 1.2 AppException và BaseRepository

- [ ] Chuẩn hóa `lib/network/api_exception.dart`.
- [ ] Map lỗi Dio, timeout, validation, unauthorized, server và unknown.
- [ ] Message đưa lên UI phải an toàn.
- [ ] Giữ validation field errors nếu API trả về.
- [ ] Dùng `BaseRepository.guard` để chuẩn hóa lỗi.
- [ ] Viết test cho error mapping.
- [ ] Viết test cho `BaseRepository.guard`.

## 1.3 API response

- [ ] Rà `ObjectResponse<T>`.
- [ ] Rà `ArrayResponse<T>`.
- [ ] Rà `Paged<T>`.
- [ ] Chuẩn hóa parse callback cho generic type.
- [ ] Viết test parse object response.
- [ ] Viết test parse array response.
- [ ] Viết test parse paged response.

## 1.4 Dio và API service convention

- [ ] Tạo Dio từ `AppConfigs.baseUrl`.
- [ ] Cấu hình connect/receive/send timeout.
- [ ] Thêm JSON headers mặc định.
- [ ] Thêm `X-Request-ID`.
- [ ] Thêm `X-Idempotency-Key` cho request mutating.
- [ ] Không ghi đè header truyền trực tiếp.
- [ ] Che token, password và OTP trong log.
- [ ] Tắt raw body log ở production.
- [ ] Chốt module nào dùng Retrofit `ApiClient`.
- [ ] Chốt module nào dùng `*_api_service.dart` với Dio trực tiếp.
- [ ] Không giữ API client mẫu không có consumer.
- [ ] Viết interceptor test.

## 1.5 Storage helpers

- [ ] Rà `SecureStorageHelper`.
- [ ] Rà `SharedPreferencesHelper`.
- [ ] Lưu/đọc/xóa token.
- [ ] Lưu/đọc/xóa session.
- [ ] Lưu onboarding flag.
- [ ] Lưu language setting.
- [ ] Lưu business type.
- [ ] Mọi lời gọi async quan trọng đều được `await`.
- [ ] Có cách thay storage trong repository test.
- [ ] Viết test save/read/clear.

## 1.6 Session model

- [ ] Rà `TokenEntity`.
- [ ] Rà `SessionEntity`.
- [ ] Chuẩn hóa `fromJson`.
- [ ] Chuẩn hóa `toJson`.
- [ ] Thêm kiểm tra access token hết hạn nếu contract có expiry.
- [ ] Thêm kiểm tra refresh token hết hạn nếu contract có expiry.
- [ ] Viết test JSON.
- [ ] Viết test expiry.

### Quality gate chặng 1

- [ ] `dart format lib test`
- [ ] `flutter analyze`
- [ ] `flutter test`

---

# Chặng 2 — App start và đăng nhập

## 2.1 Auth DTO và API service

- [ ] Tạo DTO tại `lib/models/dto/auth/`.
- [ ] Tạo `LoginRequestDto`.
- [ ] Tạo `RefreshTokenRequestDto`.
- [ ] Tạo `AuthSessionDto`.
- [ ] Tạo `lib/network/auth_api_service.dart`.
- [ ] Khai báo endpoint login.
- [ ] Khai báo endpoint refresh token.
- [ ] Khai báo endpoint logout.
- [ ] Viết test parse DTO.

Endpoints tham chiếu:

```text
/api/v1/auth/login
/api/v1/auth/token/refresh
/api/v1/auth/logout
```

## 2.2 AuthRepository

- [ ] Tạo `lib/repositories/auth_repository.dart`.
- [ ] Khai báo `AuthRepository`.
- [ ] Viết `AuthRepositoryImpl`.
- [ ] Inject hoặc khởi tạo `AuthApiService` theo convention source.
- [ ] Lưu token/session sau login thành công.
- [ ] Đọc session đã lưu.
- [ ] Gọi logout server khi phù hợp.
- [ ] Luôn xóa local auth khi logout.
- [ ] Viết fake/mock repository cho Cubit test.
- [ ] Viết repository test.

## 2.3 Auth interceptor và refresh token

- [ ] Chỉ gắn Authorization khi có token.
- [ ] Bỏ qua Authorization ở pre-auth endpoints.
- [ ] Không ghi đè Authorization tùy chỉnh.
- [ ] Gắn tenant/store context khi cần.
- [ ] Nhận biết response 401.
- [ ] Không refresh chính endpoint refresh.
- [ ] Chặn vòng lặp retry.
- [ ] Chỉ chạy một refresh khi nhiều request cùng nhận 401.
- [ ] Lưu token mới rồi retry request cũ.
- [ ] Bảo toàn method, query, body và headers.
- [ ] Refresh thất bại thì clear auth.
- [ ] Phát session-expired event.
- [ ] Viết test concurrent 401.

## 2.4 Login Cubit/State

Vị trí:

```text
lib/ui/pages/auth/login/
├── login_cubit.dart
├── login_state.dart
└── login_page.dart
```

- [ ] Tạo `LoginStatus`.
- [ ] Tạo immutable `LoginState` dùng `Equatable`.
- [ ] Thêm contact/email/phone và password.
- [ ] Thêm password visibility.
- [ ] Thêm validation và failure message.
- [ ] Tạo `LoginCubit` nhận `AuthRepository`.
- [ ] Không submit khi form sai.
- [ ] Chống submit nhiều lần.
- [ ] Emit loading/success/failure đúng.
- [ ] Viết State/Cubit test.

## 2.5 Login UI

- [ ] Tái tạo logo/header từ source.
- [ ] Tạo contact field.
- [ ] Tạo password field.
- [ ] Tạo nút show/hide password.
- [ ] Disable nút khi form sai.
- [ ] Hiển thị loading/error an toàn.
- [ ] Thêm link đăng ký và quên mật khẩu.
- [ ] Xử lý keyboard/submit action.
- [ ] Viết widget test với fake `AuthRepository`.

## 2.6 Root provider

- [ ] Đăng ký `AuthRepository` trong `MultiRepositoryProvider` tại
  `lib/app.dart`.
- [ ] Không truyền `AppDependencies` vào `MyApp`.
- [ ] Không tạo AuthRepository trong LoginPage.
- [ ] Xác minh provider có thể được override trong widget test.

## 2.7 App start và Splash

Vị trí:

```text
lib/ui/pages/app_start/splash/
├── splash_cubit.dart
├── splash_state.dart
└── splash_page.dart
```

- [ ] Đọc token/session/onboarding.
- [ ] Xác định unauthenticated/needs-onboarding/authenticated.
- [ ] Token hết hạn thì thử refresh.
- [ ] Chọn route khởi động.
- [ ] Không để Splash quay lại bằng back gesture.
- [ ] Viết test cho từng trạng thái khởi động.

### Quality gate chặng 2

- [ ] `dart format lib test`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Smoke test dev entrypoint.

---

# Chặng 3 — Đăng ký, OTP và onboarding

## 3.1 Auth flow mở rộng

- [ ] Request register OTP.
- [ ] Request forgot-password OTP.
- [ ] Verify OTP.
- [ ] Resend OTP có cooldown.
- [ ] Setup password.
- [ ] Reset password.
- [ ] Không log OTP/password/verification token.
- [ ] Viết API/repository test.

## 3.2 Register và forgot-password UI

- [ ] Tạo page/Cubit/State dưới `lib/ui/pages/auth/register/`.
- [ ] Tạo page/Cubit/State dưới `lib/ui/pages/auth/forgot_password/`.
- [ ] Port OTP widgets dùng chung vào `lib/ui/widgets/` khi có từ hai consumer.
- [ ] Xử lý loading/error/resend countdown.
- [ ] Viết Cubit và widget test.

## 3.3 Tenant, store và onboarding

- [ ] Tạo DTO/entity cần thiết trong `lib/models/`.
- [ ] Thêm endpoint tenant/store vào auth API service phù hợp.
- [ ] Mở rộng `AuthRepository`.
- [ ] Tạo UI dưới `lib/ui/pages/onboarding/`.
- [ ] Chọn business type.
- [ ] Nhập thông tin tenant/store.
- [ ] Persist session và onboarding flag.
- [ ] Điều hướng vào main sau khi hoàn tất.
- [ ] Viết test flow onboarding.

---

# Chặng 4 — Main shell, home và tiện ích

## 4.1 MainNavigation

- [ ] Tạo module dưới `lib/ui/pages/main_navigation/`.
- [ ] Tạo `MainNavigationCubit/State`.
- [ ] Retail có Home/POS/Inventory/More.
- [ ] F&B có Home/Table/Order/More.
- [ ] Service có Home/Appointment/Services/More.
- [ ] Giữ tab state khi chuyển tab.
- [ ] Xử lý Android back.

## 4.2 Home

- [ ] Tạo home DTO/entity trong `lib/models/`.
- [ ] Tạo home API service trong `lib/network/`.
- [ ] Tạo/mở rộng repository trong `lib/repositories/`.
- [ ] Tạo `HomeCubit/State/Page` trong `lib/ui/pages/home/`.
- [ ] Hỗ trợ refresh và partial failure.
- [ ] Không đưa mock/fallback production mà không gắn nhãn.
- [ ] Viết repository/Cubit/widget test.

## 4.3 Shared UI và utility

- [ ] Port async/loading/empty/error widgets vào `lib/ui/widgets/`.
- [ ] Tạo global search trong `lib/ui/pages/global_search/`.
- [ ] Tạo notification trong `lib/ui/pages/notification/`.
- [ ] Tạo upload image service.
- [ ] Tạo speech-to-text utility khi đến đúng flow.

---

# Chặng 5 — Danh mục và sản phẩm

- [ ] Tạo category/product model và DTO.
- [ ] Tạo catalog API service.
- [ ] Tạo `CategoryRepository` và `ProductRepository`.
- [ ] Đăng ký repository trong `lib/app.dart` khi page cần.
- [ ] Tạo product list Cubit/State/Page.
- [ ] Tạo category management.
- [ ] Tạo create/edit product form.
- [ ] Tạo product detail.
- [ ] Tạo image upload/reorder/delete.
- [ ] Hỗ trợ pagination/search/filter.
- [ ] Viết repository/Cubit/widget test.

---

# Chặng 6 — Kho và nhà cung cấp

- [ ] Tạo inventory/supplier models và DTO.
- [ ] Tạo inventory/supplier API service.
- [ ] Tạo `InventoryRepository`, `StorageRepository`, `SupplierRepository`.
- [ ] Đăng ký repository trong `lib/app.dart` khi có consumer.
- [ ] Tạo inventory overview/list/detail.
- [ ] Tạo inventory adjustment.
- [ ] Tạo supplier list/create/edit/detail.
- [ ] Tạo stock import draft/submit/detail.
- [ ] Tạo stocktake draft/submit/detail.
- [ ] Viết repository/Cubit/widget test.

---

# Chặng 7 — POS và đơn hàng

- [ ] Tạo cart models và `CartCubit/State`.
- [ ] Tạo POS product browser.
- [ ] Tạo customer picker.
- [ ] Tạo checkout/payment.
- [ ] Chống double-submit bằng idempotency key.
- [ ] Tạo order API/repository.
- [ ] Tạo order history/detail.
- [ ] Hỗ trợ cancel/refund theo contract.
- [ ] Viết test tính tiền, làm tròn, discount và payment flow.

---

# Chặng 8 — Khách hàng và tài chính

- [ ] Tạo customer models/API/repository.
- [ ] Tạo customer list/form/detail.
- [ ] Tạo finance models/API/repository.
- [ ] Tạo finance summary.
- [ ] Tạo cashbook list và thu/chi.
- [ ] Tạo customer/supplier debt.
- [ ] Tạo revenue target.
- [ ] Viết repository/Cubit/widget test.

---

# Chặng 9 — Quản lý cửa hàng

- [ ] Tạo store profile.
- [ ] Tạo staff models/API/repository.
- [ ] Tạo staff list/form/detail/role.
- [ ] Tạo staff shift khi backend contract sẵn sàng.
- [ ] Tạo change-password.
- [ ] Tạo login devices/logout sessions.
- [ ] Tạo bank account local hoặc backend theo contract đã chốt.
- [ ] Tạo settings language/business type/logout.

---

# Chặng 10 — F&B

- [ ] Xác nhận backend contract trước khi tích hợp.
- [ ] Tạo table/zone models, API và repository.
- [ ] Tạo table map và table management.
- [ ] Tạo menu/category.
- [ ] Tạo order-at-table cart.
- [ ] Tạo kitchen tickets/status.
- [ ] Tái sử dụng payment/order repository.
- [ ] Không ship seed data trong production.

---

# Chặng 11 — Dịch vụ

- [ ] Xác nhận backend contract trước khi tích hợp.
- [ ] Tạo service models/API/repository.
- [ ] Tạo service list/form/detail.
- [ ] Tạo appointment models/API/repository.
- [ ] Tạo appointment calendar/list/form/detail.
- [ ] Tạo reminder/status transition.
- [ ] Không ship seed data trong production.

---

# Chặng 12 — Hoàn thiện

## 12.1 Chất lượng

- [ ] Loading/empty/error/refresh nhất quán.
- [ ] Không còn silent catch.
- [ ] Không còn fake repository trong production.
- [ ] Không log token/password/OTP/PII.
- [ ] Accessibility và text scaling đạt yêu cầu.
- [ ] Localization vi/en phủ các flow chính.

## 12.2 Flow test

- [ ] Login → main.
- [ ] Register → onboarding → main.
- [ ] Create product → inventory.
- [ ] Import stock.
- [ ] Create order → payment success.
- [ ] Customer debt collection.
- [ ] Logout → login.

## 12.3 Release readiness

- [ ] Production dùng đúng base URL.
- [ ] Signing không dùng debug key.
- [ ] Firebase đúng environment.
- [ ] `dart format --output=none --set-exit-if-changed lib test` pass.
- [ ] `flutter analyze` pass.
- [ ] `flutter test` pass.

---

# Bắt đầu ngay

Task đầu tiên là hoàn thiện structure và visual của màn hình đầu tiên:

```text
1.1 — Structure, app composition và visual Splash
```

Thứ tự thực hiện:

1. Xác nhận tree `lib/` khớp cấu trúc layer-first ở đầu tài liệu.
2. Port ảnh Splash và tạo `SplashPage`.
3. Thay `BasePage` tạm ở route `/`.
4. Chạy `dart format --output=none --set-exit-if-changed lib test`.
5. Chạy `flutter analyze`.
6. Chạy `flutter test`.
7. Khi baseline sạch, tiếp tục `1.2 AppException và BaseRepository`.
8. Chỉ bắt đầu `2.1 Auth DTO và API service` sau khi toàn bộ quality gate
   Chặng 1 pass.
