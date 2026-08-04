# C-Shop Base

Base Flutter tự dựng theo kiến trúc **Clean Architecture + BLoC/Cubit**, dùng cho việc khởi tạo nhanh các dự án mới.
Đã setup sẵn: quản lý môi trường (flavors), network (Dio + Retrofit), localization (đa ngôn ngữ), routing (go_router),
storage (secure storage + shared preferences), design system (color/text/theme), bộ widget dùng chung và cơ chế refresh
token tự động khi gặp lỗi 401.

---

## 1. Tech stack & thư viện chính

| Nhóm             | Thư viện                                                                                |
| ---------------- | --------------------------------------------------------------------------------------- |
| State management | `flutter_bloc` ^9.1.1, `equatable`                                                      |
| Network          | `dio` ^5.7.0, `retrofit` ^4.4.1, `json_annotation`, `pretty_dio_logger`                 |
| Routing          | `go_router` ^17.3.0                                                                     |
| Storage          | `flutter_secure_storage` ^10.3.1, `shared_preferences`, `path_provider`                 |
| Localization     | `intl`, `intl_utils`, `flutter_localization`, `flutter_localizations`                   |
| UI/UX            | `cached_network_image`, `flutter_svg`, `shimmer`, `another_flushbar`, `loader_overlay`  |
| Tiện ích         | `logger`, `url_launcher`, `permission_handler`, `device_info_plus`, `package_info_plus` |
| Firebase         | `firebase_core`, `firebase_messaging`, `firebase_analytics`                             |
| Testing          | `mocktail`, `coverage`                                                                  |
| Codegen (dev)    | `build_runner`, `retrofit_generator`, `json_serializable`, `flutter_launcher_icons`     |

- Flutter SDK: `>=3.3.0 <4.0.0`
- Android: `minSdk 26`, `targetSdk 36`, `compileSdk 36`, Java 17 / Kotlin (namespace `vn.newwave.flutter_app`)

---

## 2. Getting Started

1. Cài [Flutter SDK](https://flutter.dev/docs/get-started/install) (>= 3.3.0).
2. (Tùy chọn) Cài plugin cho Android Studio / VS Code:
   - [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl)
   - [Bloc](https://plugins.jetbrains.com/plugin/12129-bloc)
3. Cài dependencies và generate code:

```bash
flutter pub get
flutter pub run intl_utils:generate                         # sinh file localization (S)
flutter pub run build_runner build --delete-conflicting-outputs   # sinh *.g.dart (retrofit + json)
```

Hoặc dùng script có sẵn:

```bash
sh build_start.sh      # clean + pub get + intl + build_runner
sh build_quality.sh    # như trên + dart format + flutter analyze
```

### Chạy theo môi trường (flavor)

Có 3 entry point, mỗi cái set `AppConfigs.env` trước khi `runApp`:

| File                 | Môi trường                    |
| -------------------- | ----------------------------- |
| `lib/main_dev.dart`  | `Environment.dev`             |
| `lib/main_prod.dart` | `Environment.prod`            |
| `lib/main.dart`      | `Environment.prod` (mặc định) |

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_prod.dart
```

> Base URL được lấy theo `Environment` qua extension `baseUrl` trong `lib/configs/app_env_config.dart`.

---

## 3. Cấu trúc thư mục

```
lib
├── main.dart / main_dev.dart / main_prod.dart   # entry point theo môi trường
├── app.dart                                      # MyApp: MultiRepositoryProvider + MultiBlocProvider + MaterialApp.router
│
├── configs/          # app_configs.dart (tên app, base url, paging...), app_env_config.dart (enum Environment)
├── common/           # design system: app_colors, app_dimens, app_text_styles, app_themes, app_shadows, app_images, app_svgs
├── network/          # api_client.dart (@RestApi), api_interceptors.dart (token + 401 refresh), api_util.dart (Dio + ApiClient)
├── database/         # secure_storage_helper.dart (token), share_preferences_helper.dart (flags + language)
├── models/
│   ├── entities/     # TokenEntity, UserEntity, NotificationEntity (@JsonSerializable)
│   ├── enums/        # LoadStatus, Language, MovieCategory, OnboardingStep, GenderType, ProfileMenu
│   ├── params/       # SignUpParam...
│   └── response/     # ArrayResponse<T> (list + paging), ObjectResponse<T> (object đơn)
├── repositories/     # AuthRepository, UserRepository (abstract + Impl)
├── global_blocs/     # state toàn cục: auth/ , user/ , setting/
├── global/           # GlobalData (singleton), GlobalEvent (stream onTokenExpired)
├── router/           # route_config.dart (GoRouter + AppRouter.navigationKey)
├── l10n/             # intl_en.arb, intl_vi.arb
├── generated/        # code sinh tự động (l10n.dart, intl/, *.g.dart)
├── ui/
│   ├── pages/        # splash, app_introduction, sign_in, home, main
│   └── widgets/      # appbar, buttons, common, divider, images, list, loading, picker, shimmer, tabs, text, text_field
└── utils/            # logger, app_validartor, utils, app_date_utils, permission_utils, file_utils
```

---

## 4. Kiến trúc & luồng dữ liệu

```
UI (Page / Widget)
      │  context.read<Cubit>()
      ▼
Cubit  ──emit──▶  State (Equatable, copyWith, LoadStatus)
      │  RepositoryProvider.of<Repository>(context)
      ▼
Repository (abstract + Impl)
      │
      ▼
Network (ApiClient/Dio)  +  Database (SecureStorage / SharedPreferences)
```

**Dependency Injection:** base **không dùng `get_it`**. Mọi dependency được cung cấp qua Provider trong `app.dart`:

- `MultiRepositoryProvider` → `AuthRepository`, `UserRepository`
- `MultiBlocProvider` → `AuthCubit`, `UserCubit`, `AppSettingCubit`

`MyApp` dùng `MaterialApp.router` (go_router), bọc trong `GlobalLoaderOverlay` (loading toàn màn hình) và `GestureDetector` để ẩn bàn phím khi tap ra ngoài. Khóa orientation `portraitUp`.

---

## 5. Các thành phần đã setup sẵn

### 5.1 Network (`lib/network/`)

- `ApiUtil`: khởi tạo singleton `Dio` (timeout 60s) + `ApiInterceptors` + `PrettyDioLogger`. Tạo sẵn 2 client:
  - `ApiUtil.apiClient` — API chính (base URL theo môi trường).
  - `ApiUtil.mocKyApiClient` — client mocky.io để test/giả lập.
- `ApiClient` (`@RestApi`, Retrofit): khai báo endpoint, hiện có `authLogin()`, `signOut()`.
- `ApiInterceptors` (`QueuedInterceptorsWrapper`):
  - **Request:** tự gắn `Bearer <accessToken>` từ SecureStorage.
  - **Error 401:** gọi `ApiUtil.onRefreshToken()`, clone lại request với token mới và retry; nếu fail → buộc đăng nhập lại.

### 5.2 Response wrappers (`lib/models/response/`)

- `ArrayResponse<T>` — wrapper cho danh sách có phân trang (`page`, `totalPages`, `totalResults`, `results`).
- `ObjectResponse<T>` — wrapper cho 1 object (`message`, `data`).

Cả hai dùng `genericArgumentFactories` để hỗ trợ generic khi parse JSON.

### 5.3 Storage (`lib/database/`)

- `SecureStorageHelper` — lưu/đọc/xóa `TokenEntity` (JSON-encoded) trong secure storage.
- `SharePreferencesHelper` — flag `isFirstRun`, `isOnboarded`, và ngôn ngữ hiện tại.

### 5.4 State toàn cục (`lib/global_blocs/`)

- `AuthCubit` — `signOut()` (gọi repo + xóa token), `deleteAccount()`. State: `signOutStatus`.
- `UserCubit` — `fetchUser()`, `updateUser()`, `removeUser()`. State: `user`, `fetchUserStatus`.
- `AppSettingCubit` — `getInitialSetting()`, `changeLanguage()`. State: `language` (mặc định English).

### 5.5 Localization (`lib/l10n/` + `generated/`)

- Hỗ trợ **English** và **Tiếng Việt** (`intl_en.arb`, `intl_vi.arb`).
- Class `S` (sinh bởi `intl_utils`). Đổi ngôn ngữ runtime qua `AppSettingCubit.changeLanguage()`.

### 5.6 Routing (`lib/router/route_config.dart`)

GoRouter với các route:

| Path                | Page              |
| ------------------- | ----------------- |
| `/`                 | Splash            |
| `/main`             | Main (bottom nav) |
| `/sign_in`          | Sign In           |
| `/app_introduction` | Onboarding        |

Điều hướng imperative qua `AppRouter.navigationKey`.

### 5.7 Design system (`lib/common/`)

- `AppColors`: primary `#173d7e`, secondary `#1E8AE7`, error `#EE3134`, gray scale, shadow, border...
- `AppDimens`: font size (10–18), button height 48, radius 4, padding 8/16/32, appbar 56.
- `AppTextStyles`: theo nhóm màu (`black*`, `white*`, `gray*`, `blue*`) × size (S10…S24) × weight (normal/medium/bold/w800).
- `AppThemes`: tạo `ThemeData` light/dark, primary/secondary tùy biến.
- `AppShadows`, `AppImages`, `AppSvgs`.

### 5.8 Bộ widget dùng chung (`lib/ui/widgets/`)

`AppButton` / `AppOutlineButton` / `AppTextButton` (có `isLoading`, `isEnabled`), `AppTextField` / `AppPasswordTextField` / `AppDateInput`, `AppCacheImage`, `AppCircleAvatar`, `AppDatePicker`, `AppDropdownPicker`, `AppShimmer`, `AppTabBar`, `AppDivider`, `AppCircularProgressIndicator`, `ListEmptyWidget` / `ListErrorWidget` / `ListLoadingWidget`, `LogoWidget`, `AppVersionWidget`, `AppLabel`, app bar widget.

### 5.9 Tiện ích (`lib/utils/`)

- `logger` — log có màu (`logger.d/i/e`).
- `AppValidator` — validate empty / password (8–12 ký tự, chữ + số) / confirm password / phone.
- `Utils` — mở phone/email/URL, regex `isEmail/isPassword/isPhoneNumber/isURL`, convert màu hex.
- `AppDateUtils` — parse/format ngày giờ, `startOfDay`/`endOfDay`.
- `permission_utils`, `file_utils`.

---

## 6. Các màn hình mẫu (`lib/ui/pages/`)

| Màn hình             | Mô tả                                                                                               |
| -------------------- | --------------------------------------------------------------------------------------------------- |
| **Splash**           | Delay 1s → load setting → check onboarding/first-run → check login → điều hướng.                    |
| **App Introduction** | Onboarding dạng PageView (carousel) + indicator + nút Login/Signup.                                 |
| **Sign In**          | Form đăng nhập, validate, hiện/ẩn mật khẩu; gọi `AuthRepository.signIn()` rồi cập nhật `UserCubit`. |
| **Home**             | Scaffold mẫu (placeholder cho nội dung chính).                                                      |
| **Main**             | Bottom navigation (Home / Notifications / Profile) + PageView.                                      |

> Lưu ý: `AuthRepository` và `UserRepository` hiện đang **mock** dữ liệu (delay 2s, trả token/profile giả) — thay bằng call API thật khi dùng cho dự án mới.

---

## 7. Hướng dẫn sử dụng (quy ước code)

### 7.1 Tạo một màn hình mới

Tất cả màn hình đặt trong `lib/ui/pages/<feature>/`, gồm 3 file:

**Logic — `movies_cubit.dart`**

```dart
class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository movieRepo;
  MoviesCubit({required this.movieRepo}) : super(const MoviesState());

  Future<void> fetchMovies() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final result = await movieRepo.getMovies();
      emit(state.copyWith(loadStatus: LoadStatus.success, movies: result.results));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
```

**State — `movies_state.dart`**

```dart
class MoviesState extends Equatable {
  final LoadStatus loadStatus;
  final List<MovieEntity> movies;

  const MoviesState({
    this.loadStatus = LoadStatus.initial,
    this.movies = const [],
  });

  @override
  List<Object?> get props => [loadStatus, movies];

  MoviesState copyWith({LoadStatus? loadStatus, List<MovieEntity>? movies}) {
    return MoviesState(
      loadStatus: loadStatus ?? this.loadStatus,
      movies: movies ?? this.movies,
    );
  }
}
```

**View — `movies_page.dart`**

```dart
class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit(
        movieRepo: context.read<MovieRepository>(),
      ),
      child: const MoviesChildPage(),
    );
  }
}

class MoviesChildPage extends StatefulWidget {
  const MoviesChildPage({super.key});
  @override
  State<MoviesChildPage> createState() => _MoviesChildPageState();
}

class _MoviesChildPageState extends State<MoviesChildPage> {
  late final MoviesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MoviesCubit>();
    _cubit.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) => const SizedBox(),
    );
  }
}
```

### 7.2 Thêm một API mới

1. Tạo entity trong `lib/models/entities/` với `@JsonSerializable()`:

```dart
import 'package:json_annotation/json_annotation.dart';
part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  String? title;
  MovieEntity({this.title});
  factory MovieEntity.fromJson(Map<String, dynamic> json) => _$MovieEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);
}
```

2. Khai báo endpoint trong `lib/network/api_client.dart`:

```dart
@GET("/3/discover/movie")
Future<ArrayResponse<MovieEntity>> getMovies(@Query('page') int page);
```

3. Chạy codegen:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Tạo repository trong `lib/repositories/`:

```dart
abstract class MovieRepository {
  Future<ArrayResponse<MovieEntity>> getMovies();
}

class MovieRepositoryImpl extends MovieRepository {
  final ApiClient apiClient;
  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<ArrayResponse<MovieEntity>> getMovies() => apiClient.getMovies(1);
}
```

5. Đăng ký repository (và cubit nếu cần) vào Provider tương ứng, rồi gọi trong Cubit.

### 7.3 Tiện ích thường dùng

```dart
// Logger
logger.d("debug");  logger.i("info");  logger.e("error");

// Loading toàn màn hình (loader_overlay)
context.loaderOverlay.show();
context.loaderOverlay.hide();

// Đổi ngôn ngữ
context.read<AppSettingCubit>().changeLanguage(Language.vietnamese);
```

---

## 8. Lint & build

- `analysis_options.yaml`: kế thừa `flutter_lints`, loại trừ các file generated (`*.g.dart`).
- Icon app sinh bằng `flutter_launcher_icons` (`assets/images/launcher_icon.png`).
- Font mặc định: **Roboto** (Thin → Black).

---

## 9. Ghi chú khi dùng làm base cho dự án mới

- [ ] Đổi `name`/`description` trong `pubspec.yaml`, namespace/applicationId Android & bundle id iOS.
- [ ] Cập nhật `baseUrl` theo từng `Environment` trong `app_env_config.dart`.
- [ ] Thay phần **mock** trong `AuthRepository`/`UserRepository` bằng API thật.
- [ ] Cấu hình Firebase (`firebase_core/messaging/analytics`) nếu cần push notification.
- [ ] Thêm `productFlavors` trong `android/app/build.gradle` nếu muốn tách build theo flavor (hiện chưa cấu hình).
- [ ] Bổ sung route/guard (redirect) trong `route_config.dart` theo nghiệp vụ.
