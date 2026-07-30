# C-Shop Flutter Mobile Rebuild Roadmap

## 1. Mục đích và phạm vi

Tài liệu này là kế hoạch xây dựng lại C-Shop Mobile từ một Flutter project rỗng, dựa trên hành vi, giao diện, API contract và coding convention của source:

- Source tham chiếu: `/Users/nkson.ts/Documents/CmcProject/c-shop`
- Workspace đích: `/Users/nkson.ts/Documents/Nkson-Project/C-Shop_CodeTay`
- Phạm vi hiện tại: chỉ phân tích và lập roadmap, chưa triển khai code.
- Chiến lược: Clean Architecture + Feature First, vẫn giữ cách đặt tên `CShop*`, Cubit/State, repository contract/implementation và các thuật ngữ nghiệp vụ đang có.

Mỗi task bên dưới chỉ giải quyết một mục tiêu, có thể review và commit riêng. Không gộp task chỉ vì chúng thuộc cùng một màn hình.

## 2. Kết quả phân tích source hiện tại

### 2.1 Stack và convention cần giữ

- Flutter/Dart, `flutter_bloc` với `Cubit` + immutable `State` dùng `Equatable`.
- `go_router` cho entry route; source hiện tại vẫn dùng `MaterialPageRoute` cho nhiều route nội bộ.
- `dio`, `retrofit`, `json_serializable` cho networking và DTO.
- `flutter_secure_storage` cho token/session; `shared_preferences` cho preference và cấu hình cục bộ.
- `intl`/ARB cho localization; source hiện có tiếng Việt và tiếng Anh nhưng phần lớn feature text vẫn hard-code tiếng Việt.
- Widget dùng prefix `CShop`: button, field, card, badge, async view, sheet, navigation.
- Trạng thái tải dùng `LoadStatus`; lỗi hạ tầng được chuẩn hóa về `AppException`.
- Request mutating có `X-Idempotency-Key`; mọi request có `X-Request-ID`; request sau đăng nhập có `Authorization`, `X-Tenant-ID`, `X-Store-ID`.
- Business type dùng enum `BusinessType.retail`, `BusinessType.fnb`, `BusinessType.service`; API value tương ứng `RETAIL`, `FOOD_AND_BEVERAGE`, `SERVICE`.

### 2.2 Luồng và module đã nhận diện

- App start: splash, kiểm tra token/session/onboarding, chọn route khởi động.
- Authentication: login; đăng ký qua OTP; quên/đặt lại mật khẩu; refresh token; logout; quản lý thiết bị.
- Onboarding: chọn ngành, phân ngành, thông tin hộ kinh doanh/cửa hàng.
- Shell động theo ngành:
  - Retail: Home, POS, Inventory, More.
  - F&B: Home, Table map, Order at table, More.
  - Service: Home, Appointment, Services, More.
- Retail: danh mục, sản phẩm, POS, payment, order, customer, supplier, nhập kho, tồn kho, điều chỉnh, kiểm kê, chứng từ.
- Finance: summary, cashbook, thu/chi, công nợ khách hàng, công nợ nhà cung cấp, mục tiêu doanh thu.
- Management/settings: hồ sơ cửa hàng, tài khoản ngân hàng, đổi mật khẩu, thiết bị đăng nhập, nhân viên và các trang cấu hình.
- Utility: global search, notification, upload ảnh, speech-to-text, VietQR, Firebase Messaging.

### 2.3 Khoảng trống/rủi ro của source cần xử lý trong bản rebuild

- Source đang là layer-first (`models`, `network`, `repositories`, `ui`) chứ chưa phải Feature First hoàn chỉnh. Bản rebuild sẽ di chuyển code theo feature nhưng giữ naming/coding style.
- `ApiClient` Retrofit cũ chỉ còn API mẫu và song song với các service Dio viết tay. Cần chọn một chuẩn thống nhất, không mang cả hai cơ chế dư thừa sang project mới.
- Refresh token hiện retry bằng một `Dio` riêng; chưa có single-flight refresh rõ ràng và chưa bảo toàn đầy đủ mọi kiểu request upload/progress/cancel.
- Router chỉ khai báo app-start route; phần lớn navigation nghiệp vụ nằm trong `MainNavigationPage`.
- DI hiện dùng `MultiRepositoryProvider`, chưa có composition root tách theo feature.
- Firebase packages đang nằm trong `dev_dependencies`, cần chuyển đúng nhóm dependency.
- Dev/staging/prod đang dùng chung một UAT URL; production/staging URL chưa được xác nhận.
- `UserRepository` vẫn trả mock.
- F&B, Service, notification, staff shift và một số settings subpage chủ yếu là seed/local UI, chưa có API contract tương ứng.
- Home có fallback/mock và bắt lỗi rỗng ở một số request phụ; cần định nghĩa partial failure rõ ràng.
- Bank account đang lưu local; chưa có backend sync.
- Localization chưa phủ toàn bộ text.
- Naming package hiện là `flutter_base`, cần chốt application id/package name mới trước khi scaffold.

## 3. Kiến trúc đích

```text
lib/
├── app/
│   ├── bootstrap/
│   ├── config/
│   ├── di/
│   ├── router/
│   └── theme/
├── core/
│   ├── error/
│   ├── extensions/
│   ├── localization/
│   ├── logging/
│   ├── network/
│   ├── storage/
│   ├── utils/
│   └── widgets/
├── features/
│   └── <feature>/
│       ├── data/
│       │   ├── datasources/
│       │   ├── dto/
│       │   ├── mappers/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
└── main_<flavor>.dart
```

Quy tắc phụ thuộc: `presentation -> domain <- data`; feature không import presentation của feature khác. Điều hướng liên feature đi qua router contract; dữ liệu liên feature đi qua domain contract hoặc app-level coordinator.

## 4. Quy ước thực thi roadmap

- Ưu tiên: `P0` bắt buộc/chặn luồng chính; `P1` nghiệp vụ cốt lõi; `P2` hoàn thiện; `P3` nâng cấp tùy backend/sản phẩm.
- Một task hoàn tất phải qua `dart format`, static analysis và test liên quan.
- File sinh tự động (`*.g.dart`) nằm cùng commit với source tạo ra nó.
- Không port dữ liệu mock vào production mà không gắn `Mock`/`Fake` rõ ràng và giới hạn theo environment.
- Với feature chưa có backend contract, task chỉ dựng domain/UI parity; task tích hợp API phải đợi contract riêng.

