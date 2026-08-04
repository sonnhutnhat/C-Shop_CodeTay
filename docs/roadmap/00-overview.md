# C-Shop Flutter Mobile Rebuild Roadmap

## 1. Mục đích và phạm vi

Tài liệu này là kế hoạch xây dựng lại C-Shop Mobile dựa trên hành vi, giao
diện, API contract, cấu trúc thư mục và coding convention của source:

- Source tham chiếu: `/Users/nkson.ts/Documents/CmcProject/c-shop`
- Workspace đích: `/Users/nkson.ts/Documents/Nkson-Project/C-Shop_CodeTay`
- Chiến lược: giữ kiến trúc layer-first của source C-Shop.
- Cách làm: đọc source để hiểu và tự code lại từng phần, không copy nguyên file.

Mỗi task chỉ giải quyết một mục tiêu, có thể review và commit riêng. Không tự
chuyển sang Feature First hoặc tạo thêm `lib/app/`, `lib/core/`,
`lib/features/` nếu chưa có quyết định mới từ chủ dự án.

## 2. Stack và convention cần giữ

- Flutter/Dart, `flutter_bloc` với `Cubit` và immutable `State` dùng
  `Equatable`.
- `go_router` cho entry route; `AppNavigator` hoặc `MaterialPageRoute` cho
  navigation nội bộ khi source đang dùng cách đó.
- `dio`, `retrofit`, `json_serializable` cho networking và DTO.
- `flutter_secure_storage` cho token/session; `shared_preferences` cho
  preference và cấu hình cục bộ.
- `intl`/ARB cho localization.
- Widget dùng prefix `CShop`: button, field, card, badge, async view, sheet và
  navigation.
- Trạng thái tải dùng `LoadStatus`; lỗi hạ tầng được chuẩn hóa về
  `AppException`.
- Request mutating có `X-Idempotency-Key`; mọi request có `X-Request-ID`;
  request sau đăng nhập có `Authorization`, `X-Tenant-ID`, `X-Store-ID`.
- Business type dùng `BusinessType.retail`, `BusinessType.fnb`,
  `BusinessType.service`; API value tương ứng `RETAIL`,
  `FOOD_AND_BEVERAGE`, `SERVICE`.

## 3. Cấu trúc đích

Cấu trúc đích bám theo source C-Shop:

```text
lib/
├── common/          # Theme token, asset constant, navigation helper
├── configs/         # Environment và cấu hình toàn app
├── database/        # Secure storage và shared preferences
├── generated/       # Localization/code generated
├── global/          # Session/event dùng toàn tiến trình
├── global_blocs/    # Cubit dùng ở cấp ứng dụng
├── l10n/            # ARB/localization source
├── models/
│   ├── dto/         # Request/response DTO theo nghiệp vụ
│   ├── entities/    # Entity dùng trong app
│   ├── enums/
│   ├── params/
│   └── response/    # Response wrapper và pagination
├── network/         # Dio, interceptor, endpoint, API service/client
├── repositories/    # Repository contract và implementation
├── router/          # GoRouter configuration
├── services/        # Notification và service cấp ứng dụng
├── ui/
│   ├── pages/
│   │   └── <module>/
│   │       ├── <screen>_page.dart
│   │       ├── <screen>_cubit.dart
│   │       ├── <screen>_state.dart
│   │       └── widgets/
│   └── widgets/     # Widget dùng chung
├── utils/
├── app.dart         # MultiRepositoryProvider, MultiBlocProvider, MaterialApp
├── main.dart
├── main_dev.dart
└── main_prod.dart
```

Không tạo thư mục `lib/app/`: `app.dart` là file composition của ứng dụng.
Repository được đăng ký trực tiếp trong `MultiRepositoryProvider` tại
`app.dart`; global Cubit được đăng ký trong `MultiBlocProvider`.

## 4. Quy tắc phụ thuộc

- `ui` gọi Cubit; Cubit gọi repository contract.
- `repositories` phối hợp API service, storage và mapper/DTO cần thiết.
- `network` không import `ui`.
- `models` không import `ui`.
- Module trong `ui/pages` có thể dùng `ui/widgets`, `common`, `models` và
  repository contract; không import page khác chỉ để lấy business logic.
- Chỉ đăng ký repository/global Cubit trong `app.dart` khi task thực sự cần.
- Page-level Cubit đặt cạnh page và do `BlocProvider` gần page quản lý.
- Không tạo interface/use case/datasource chỉ để đủ mẫu Clean Architecture;
  chỉ tạo abstraction đang có giá trị hoặc bám theo source.

## 5. Luồng và module đã nhận diện

- App start: splash, kiểm tra token/session/onboarding, chọn route khởi động.
- Authentication: login, đăng ký qua OTP, quên/đặt lại mật khẩu, refresh token,
  logout và quản lý thiết bị.
- Onboarding: chọn ngành, phân ngành, thông tin hộ kinh doanh/cửa hàng.
- Shell động theo ngành:
  - Retail: Home, POS, Inventory, More.
  - F&B: Home, Table map, Order at table, More.
  - Service: Home, Appointment, Services, More.
- Retail: danh mục, sản phẩm, POS, payment, order, customer, supplier, nhập
  kho, tồn kho, điều chỉnh, kiểm kê và chứng từ.
- Finance: summary, cashbook, thu/chi, công nợ và mục tiêu doanh thu.
- Management/settings: hồ sơ cửa hàng, tài khoản ngân hàng, đổi mật khẩu,
  thiết bị đăng nhập, nhân viên và cấu hình.
- Utility: global search, notification, upload ảnh, speech-to-text, VietQR và
  Firebase Messaging.

## 6. Khoảng trống/rủi ro cần xử lý

- `ApiClient` Retrofit cũ tồn tại song song với các API service dùng Dio trực
  tiếp. Mỗi task phải xác định rõ cơ chế của module tham chiếu và không tạo
  client mẫu không được sử dụng.
- Refresh token chưa có single-flight rõ ràng và có thể không bảo toàn đầy đủ
  upload/progress/cancel khi retry.
- Router chỉ khai báo app-start route; phần lớn navigation nghiệp vụ nằm trong
  `MainNavigationPage`.
- Dev/staging/prod đang có nguy cơ dùng chung UAT URL.
- `UserRepository` của source còn trả mock.
- F&B, Service, notification, staff shift và một số settings chủ yếu là
  seed/local UI, chưa có API contract đầy đủ.
- Bank account đang lưu local; chưa có backend sync.
- Localization chưa phủ toàn bộ text.
- Không port mock vào production nếu không có nhãn `Mock`/`Fake` và giới hạn
  environment rõ ràng.

## 7. Quy ước thực thi roadmap

- Ưu tiên: `P0` chặn luồng chính; `P1` nghiệp vụ cốt lõi; `P2` hoàn thiện;
  `P3` phụ thuộc backend/sản phẩm.
- Làm theo thứ tự: model/DTO → network service → repository → Cubit/State →
  Page/Widget → đăng ký dependency cần thiết.
- Một task hoàn tất phải qua `dart format`, `flutter analyze` và test liên
  quan.
- File sinh tự động (`*.g.dart`) nằm cùng commit với source tạo ra nó.
- Dùng đường dẫn layer-first trong mọi task và commit.
- Với module chưa có backend contract, chỉ dựng UI/local behavior có gắn trạng
  thái rõ ràng; tích hợp API phải chờ contract.
