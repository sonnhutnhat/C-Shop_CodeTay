# Phase 12 - Completion, Quality and Release

## TASK-097 - Complete localization coverage

**Mục tiêu:** Di chuyển toàn bộ user-facing text sang ARB.

**Phụ thuộc:** TASK-012, toàn bộ module đang được bật.

**File/Module liên quan:** mọi page/widget trong `lib/ui/`, `lib/l10n/*.arb`.

**Đầu ra mong muốn:** vi/en phủ 100% màn active.

**Checklist hoàn thành:**

- [ ] Không còn hard-coded user-facing text.
- [ ] Plural/date/money dùng locale.
- [ ] Missing-key check trong CI.

**Độ ưu tiên:** P2.

---

## TASK-098 - Accessibility and responsive audit

**Mục tiêu:** Đảm bảo semantics, text scale, contrast, keyboard và màn hình nhỏ.

**Phụ thuộc:** TASK-021, toàn bộ module đang được bật.

**File/Module liên quan:** `lib/ui/widgets/` và `lib/ui/pages/`.

**Đầu ra mong muốn:** Luồng P0/P1 dùng được với accessibility settings phổ biến.

**Checklist hoàn thành:**

- [ ] Tap target/semantic label đạt yêu cầu.
- [ ] Text scale không overflow.
- [ ] Keyboard/focus/form navigation đúng.
- [ ] Audit Android/iOS.

**Độ ưu tiên:** P2.

---

## TASK-099 - Build automated test pyramid

**Mục tiêu:** Hoàn thiện unit, widget, golden, integration và end-to-end suite.

**Phụ thuộc:** Các module tương ứng.

**File/Module liên quan:** `test/`, `integration_test/`, fixtures/fakes.

**Đầu ra mong muốn:** Test suite bảo vệ auth, POS, payment, inventory, finance và variant chính.

**Checklist hoàn thành:**

- [ ] DTO/entity mapping và repository có unit test.
- [ ] Cubit transition có unit test.
- [ ] Critical UI có widget/golden test.
- [ ] Critical journeys có integration test.

**Độ ưu tiên:** P0 xuyên suốt; task này là bước audit cuối.

---

## TASK-100 - Configure CI quality gates

**Mục tiêu:** Tự động format check, analyze, test, coverage và flavor build.

**Phụ thuộc:** TASK-005, TASK-099.

**File/Module liên quan:** CI workflow, quality scripts.

**Đầu ra mong muốn:** PR không thể merge khi quality gate quan trọng thất bại.

**Checklist hoàn thành:**

- [ ] Cache dependency an toàn.
- [ ] Generated code drift được phát hiện.
- [ ] Coverage threshold theo module được chốt.
- [ ] Android/iOS smoke build chạy.

**Độ ưu tiên:** P0.

---

## TASK-101 - Performance optimization

**Mục tiêu:** Đo và tối ưu startup, rebuild, list, image cache, network và memory.

**Phụ thuộc:** Module P0/P1 hoàn tất.

**File/Module liên quan:** app bootstrap, Home, POS, product/inventory/order lists.

**Đầu ra mong muốn:** Performance budget có số đo trước/sau.

**Checklist hoàn thành:**

- [ ] Không tối ưu dựa trên cảm tính.
- [ ] Long list dùng pagination/lazy build.
- [ ] Bloc rebuild scope được kiểm tra.
- [ ] Image/memory leak được profile.

**Độ ưu tiên:** P2.

---

## TASK-102 - Security and privacy audit

**Mục tiêu:** Rà soát storage, logs, transport, permissions, PII và auth lifecycle.

**Phụ thuộc:** Module P0/P1 hoàn tất.

**File/Module liên quan:** core network/storage/logging, Android/iOS manifests, auth/payment.

**Đầu ra mong muốn:** Security checklist có evidence và issue remediation.

**Checklist hoàn thành:**

- [ ] Token/PII không lộ log.
- [ ] Clear session và first-run behavior đúng.
- [ ] Permission tối thiểu.
- [ ] TLS/network security config production đúng.

**Độ ưu tiên:** P0.

---

## TASK-103 - Observability and crash reporting

**Mục tiêu:** Tích hợp crash/error reporting theo environment với user/session context đã ẩn danh.

**Phụ thuộc:** TASK-009, TASK-013, TASK-102.

**File/Module liên quan:** bootstrap, global error boundary, Firebase Crashlytics hoặc công cụ được chọn.

**Đầu ra mong muốn:** Lỗi production tra được theo version/flavor/request ID.

**Checklist hoàn thành:**

- [ ] PII redaction.
- [ ] Flutter/platform/async errors được capture.
- [ ] Dev/staging/prod tagging.
- [ ] Test crash được xác minh ngoài production.

**Độ ưu tiên:** P1.

---

## TASK-104 - Prepare release signing and store configuration

**Mục tiêu:** Cấu hình signing, versioning, icons, privacy description và release build.

**Phụ thuộc:** TASK-001, TASK-007, TASK-102.

**File/Module liên quan:** Android Gradle/signing, iOS Xcode/export options, launcher assets.

**Đầu ra mong muốn:** Signed artifact cho staging/UAT và production.

**Checklist hoàn thành:**

- [ ] Secret không commit.
- [ ] Version/build number strategy.
- [ ] Permission descriptions đúng mục đích.
- [ ] Release artifacts cài/chạy được.

**Độ ưu tiên:** P0.

---

## TASK-105 - Execute UAT and release readiness review

**Mục tiêu:** Xác minh acceptance criteria theo business type và quyết định
cờ bật/tắt cho module chưa có backend.

**Phụ thuộc:** TASK-097 đến TASK-104.

**File/Module liên quan:** UAT checklist, release notes, module flags.

**Đầu ra mong muốn:** Sign-off rõ cho Retail, F&B, Service và known limitations.

**Checklist hoàn thành:**

- [ ] Retail critical journey pass.
- [ ] F&B/Service chỉ bật khi backend contract đã hoàn tất.
- [ ] Migration/rollback/support plan được duyệt.
- [ ] Không còn P0 blocker.

**Độ ưu tiên:** P0.
