# Phase 0 - Discovery, Decisions and Project Scaffold

## TASK-001 - Chốt application identity và platform matrix

**Mục tiêu:** Chốt package name, Android applicationId, iOS bundle identifier, display name, min SDK và device support trước khi tạo project.

**Phụ thuộc:** Không.

**File/Module liên quan:** `pubspec.yaml`, `.metadata`, `android/app/build.gradle`, `ios/Runner.xcodeproj`, `ios/Runner/Info.plist`.

**Đầu ra mong muốn:** ADR ghi đầy đủ identity cho dev/staging/prod và danh sách nền tảng được hỗ trợ.

**Checklist hoàn thành:**

- [ ] Package name không còn là `flutter_base`.
- [ ] Bundle/application ID từng flavor được duyệt.
- [ ] Min Android SDK, iOS deployment target và portrait-only được chốt.

**Độ ưu tiên:** P0.

---

## TASK-002 - Chốt environment và endpoint contract

**Mục tiêu:** Xác nhận base URL, Firebase project và policy log cho dev/staging/prod.

**Phụ thuộc:** TASK-001.

**File/Module liên quan:** `lib/configs/app_env_config.dart`, `main_dev.dart`, `main_prod.dart`, Firebase config platform.

**Đầu ra mong muốn:** Environment matrix không dùng nhầm UAT cho production.

**Checklist hoàn thành:**

- [ ] Có owner xác nhận URL mỗi environment.
- [ ] Xác định secret/config nào được commit.
- [ ] Xác định Firebase app tương ứng từng flavor.

**Độ ưu tiên:** P0.

---

## TASK-003 - Scaffold Flutter project rỗng

**Mục tiêu:** Tạo project Flutter mới với identity đã chốt, không copy nguyên source cũ.

**Phụ thuộc:** TASK-001.

**File/Module liên quan:** project root, `android/`, `ios/`, `lib/`, `test/`.

**Đầu ra mong muốn:** App mặc định build và chạy được trên Android/iOS.

**Checklist hoàn thành:**

- [ ] Flutter SDK constraint được pin.
- [ ] Android debug build thành công.
- [ ] iOS simulator build thành công.
- [ ] Không có sample counter code.

**Độ ưu tiên:** P0.

---

## TASK-004 - Thiết lập dependency manifest

**Mục tiêu:** Khai báo đúng dependency runtime/dev theo stack đã phân tích.

**Phụ thuộc:** TASK-003.

**File/Module liên quan:** `pubspec.yaml`, `pubspec.lock`.

**Đầu ra mong muốn:** Dependency tối thiểu cho Bloc, router, network, storage, localization, Firebase, UI và test.

**Checklist hoàn thành:**

- [ ] Firebase nằm trong `dependencies`.
- [ ] Không giữ package không sử dụng.
- [ ] Version tương thích Flutter/Dart đã pin.
- [ ] `flutter pub get` thành công.

**Độ ưu tiên:** P0.

---

## TASK-005 - Thiết lập lint, format và code generation

**Mục tiêu:** Chuẩn hóa quality gate và lệnh generate.

**Phụ thuộc:** TASK-004.

**File/Module liên quan:** `analysis_options.yaml`, `build.yaml`, `build_quality.sh`.

**Đầu ra mong muốn:** Một bộ lệnh thống nhất cho format, analyze, test, build runner.

**Checklist hoàn thành:**

- [ ] Lint rule phản ánh style source hiện tại.
- [ ] Generated files được include/exclude đúng.
- [ ] Quality command trả exit code khác 0 khi lỗi.

**Độ ưu tiên:** P0.

---

## TASK-006 - Tạo package structure Feature First

**Mục tiêu:** Tạo skeleton `app`, `core`, `features` và quy tắc dependency Clean Architecture.

**Phụ thuộc:** TASK-003.

**File/Module liên quan:** `lib/app/`, `lib/core/`, `lib/features/`.

**Đầu ra mong muốn:** Cấu trúc đích có README/ADR giải thích vị trí của entity, DTO, mapper, repository, use case, Cubit và widget.

**Checklist hoàn thành:**

- [ ] Không tạo barrel file gây circular dependency.
- [ ] Có template cấu trúc cho feature mới.
- [ ] Có quy tắc import giữa các layer.

**Độ ưu tiên:** P0.

---

## TASK-007 - Thiết lập flavor entrypoints

**Mục tiêu:** Tạo bootstrap riêng cho dev, staging và production.

**Phụ thuộc:** TASK-002, TASK-003.

**File/Module liên quan:** `lib/main_dev.dart`, `lib/main_stg.dart`, `lib/main_prod.dart`, Android productFlavors, iOS schemes.

**Đầu ra mong muốn:** Mỗi flavor build với tên, identifier và config đúng.

**Checklist hoàn thành:**

- [ ] Không hard-code environment trong `main.dart`.
- [ ] Có launch configuration cho IDE.
- [ ] Smoke build từng flavor thành công.

**Độ ưu tiên:** P0.

---

## TASK-008 - Thiết lập asset và font pipeline

**Mục tiêu:** Port có chọn lọc Inter, Roboto, ảnh và SVG đang thực sự được dùng.

**Phụ thuộc:** TASK-004.

**File/Module liên quan:** `assets/fonts/`, `assets/images/`, `assets/vectors/`, `pubspec.yaml`, asset constants.

**Đầu ra mong muốn:** Asset constants có type-safe convention, không có file thừa hoặc đường dẫn chết.

**Checklist hoàn thành:**

- [ ] Font weight map đúng.
- [ ] Mọi asset constant resolve được.
- [ ] License/nguồn asset được ghi nhận.

**Độ ưu tiên:** P1.

