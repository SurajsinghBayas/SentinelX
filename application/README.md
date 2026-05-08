# 📱 SentinelX — Flutter Android Application

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.3+-0175C2?style=for-the-badge&logo=dart)
![Android](https://img.shields.io/badge/Android-SDK%2024+-3DDC84?style=for-the-badge&logo=android)
![Riverpod](https://img.shields.io/badge/Riverpod-2.5-purple?style=for-the-badge)

**AI-Powered Real-Time Mobile Threat Detection**

</div>

---

## Overview

This Flutter application is the mobile client for the SentinelX AI threat detection platform.

**What it does:**
- Monitors incoming SMS messages and detects phishing/scam attempts
- Detects incoming calls and captures caller identity
- Monitors notifications from WhatsApp, Telegram, and banking apps
- Sends all intercepted data to the SentinelX backend for AI analysis
- Displays real-time threat alerts with risk scores and reasons
- Runs as a persistent foreground service — monitors 24/7 in background

**What it does NOT do:**
- Implement any AI or NLP logic (all intelligence is in the backend)
- Record or intercept call audio without user consent
- Store sensitive content beyond the local offline queue

---

## Architecture

```
lib/
├── main.dart                    # App entry point
├── firebase_options.dart        # FCM configuration (PLACEHOLDER)
│
├── core/
│   ├── config/api_config.dart   # ← ONE FILE to change backend URL
│   ├── constants/               # App-wide constants
│   ├── network/dio_client.dart  # Dio with auth + retry interceptors
│   ├── permissions/             # Centralized permission handling
│   ├── router/app_router.dart   # GoRouter with auth guards
│   ├── services/                # FCM, offline queue, channel bridge
│   ├── storage/hive_service.dart# Hive local storage
│   └── theme/app_theme.dart     # Dark cybersecurity theme
│
├── data/
│   ├── models/                  # Freezed models (mirror backend schemas)
│   ├── datasources/remote/      # Raw API calls via Dio
│   └── repositories/            # Business logic + offline fallback
│
├── features/
│   ├── auth/                    # Login + Register screens
│   ├── dashboard/               # KPI cards, chart, live feed
│   ├── alerts/                  # Alert list + detail screens
│   ├── threats/                 # Threat detail screen
│   ├── permissions/             # 3-step onboarding flow
│   ├── settings/                # App + monitoring settings
│   └── splash/                  # Animated splash screen
│
├── providers/
│   └── providers.dart           # All Riverpod providers
│
└── shared/
    └── widgets/                 # Reusable UI components
```

---

## Tech Stack

| Category | Library |
|----------|---------|
| Framework | Flutter 3.19+ |
| Architecture | Clean Architecture, Feature-first |
| State Management | Riverpod 2.5 |
| Navigation | GoRouter 13 |
| Networking | Dio 5 (+ retry + auth interceptors) |
| Local Storage | Hive Flutter |
| Push Notifications | Firebase Cloud Messaging |
| Serialization | Freezed + JSON Serializable |
| Animations | flutter_animate |
| Charts | fl_chart |
| Android Native | Kotlin (SMS, Calls, Notifications, Foreground Service) |

---

## Quick Start

### Prerequisites

- Flutter 3.19+ (`flutter --version`)
- Android SDK 34
- Android emulator or physical device (Android 7.0+, API 24+)
- SentinelX backend running (see `../backend/`)

### 1. Install Dependencies

```bash
cd application
flutter pub get
```

### 2. Configure Backend URL

Edit `lib/core/config/api_config.dart`:

```dart
// For Android emulator (connects to your machine's localhost):
static const ApiEnvironment activeEnvironment = ApiEnvironment.emulator;

// For a physical device on same Wi-Fi:
static const ApiEnvironment activeEnvironment = ApiEnvironment.lan;
static const String _lanUrl = 'http://YOUR_MACHINE_IP:8000';
```

### 3. Generate Freezed Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Configure Firebase (optional for FCM)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Connect to your Firebase project
flutterfire configure
```

> If you skip this step, the app works without push notifications. FCM errors are caught silently.

### 5. Run the App

```bash
# On emulator/device
flutter run

# With verbose logging
flutter run -v
```

### 6. Start Backend

```bash
# From repo root
docker-compose up --build
```

---

## Environment Switching

**To switch backend URL**, change ONE line in `lib/core/config/api_config.dart`:

```dart
// Emulator (default) — connects to localhost:8000 on your dev machine
static const ApiEnvironment activeEnvironment = ApiEnvironment.emulator;

// Physical device on LAN — update _lanUrl with your machine IP
static const ApiEnvironment activeEnvironment = ApiEnvironment.lan;

// Production
static const ApiEnvironment activeEnvironment = ApiEnvironment.production;
```

---

## Android Permissions

The app requests the following permissions at runtime:

| Permission | Purpose |
|-----------|---------|
| `RECEIVE_SMS` / `READ_SMS` | Detect incoming SMS messages |
| `READ_PHONE_STATE` | Detect incoming calls |
| `POST_NOTIFICATIONS` | Show threat alerts (Android 13+) |
| `FOREGROUND_SERVICE` | Background monitoring |
| `INTERNET` | Communicate with backend |
| Notification Listener | Monitor app notifications (WhatsApp, banking) |

---

## Monitoring Architecture

```
Android Device
│
├── SmsReceiver (BroadcastReceiver)
│   └── SMS_RECEIVED → MethodChannel → Flutter → ThreatRepository → Backend
│
├── CallStateReceiver (BroadcastReceiver)
│   └── PHONE_STATE → EventChannel → Flutter → MonitoringNotifier
│
├── SentinelNotificationListenerService (NotificationListenerService)
│   └── onNotificationPosted → EventChannel → Flutter → ThreatRepository → Backend
│
└── ForegroundMonitorService (Service, START_STICKY)
    └── Keeps all the above alive in background
```

---

## Offline Support

When the backend is unreachable:
1. Failed API calls are saved to Hive `offline_queue_box`
2. A background timer retries every 60 seconds
3. When connectivity is restored, queued items are sent automatically
4. Items are dropped after 5 failed retries

---

## Notification Channels

| Channel | Importance | Sound | Purpose |
|---------|-----------|-------|---------|
| `sentinelx_alerts` | MAX | Yes | Threat alerts (heads-up) |
| `sentinelx_monitoring` | LOW | No | Background service (silent) |

---

## Adding New Monitored Apps

Edit `AppConstants.monitoredPackages` in `lib/core/constants/app_constants.dart`:

```dart
static const List<String> monitoredPackages = [
  'com.whatsapp',
  'your.new.app',  // ← add here
  ...
];
```

The Kotlin `SentinelNotificationListenerService` reads this same list pattern.

---

## Future Roadmap

- [ ] Biometric authentication
- [ ] Audio call recording + Whisper transcription upload
- [ ] Threat history export (CSV/PDF)
- [ ] Multi-language support
- [ ] Enterprise MDM deployment
- [ ] WebSocket real-time dashboard updates

---

## License

MIT — See root `LICENSE` for details.
