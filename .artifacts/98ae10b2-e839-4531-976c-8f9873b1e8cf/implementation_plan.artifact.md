# Implementation Plan: Website Performance Optimization

Address the slow loading times by optimizing the app initialization and rendering process.

## User Review Required

> [!IMPORTANT]
> - **Initialization Change**: I will move the cloud data sync to happen in the background. This means your website will open **instantly** using the data saved on the phone/laptop, and then update itself if there are changes in the cloud.
> - **Renderer Optimization**: I have identified the correct command to build a "Lite" version of your site that loads much faster on mobile data.

## Proposed Changes

### App Initialization

#### [MODIFY] [main.dart](file:///C:/Users/moham/StudioProjects/untitled/lib/main.dart)
- Remove `await` from `AdminService().syncFromCloud()`. This allows the app to start immediately without waiting for the database.

### Admin Service

#### [MODIFY] [services/admin_service.dart](file:///C:/Users/moham/StudioProjects/untitled/lib/services/admin_service.dart)
- Ensure `syncFromCloud` updates the UI or notifies the app if it finds new data after the app has already started.
- Add a `notifyListeners` mechanism if necessary (though current `ValueNotifier` for `isAdmin` is separate, the data itself is fetched via keys).
- Actually, since `getImageUrl` and `getText` are called during widget builds, I might need to trigger a rebuild after sync.

### Build Strategy

#### [UPDATE] Build Instructions
- Use the optimized build command: `flutter build web --release --dart-define=FLUTTER_WEB_RENDERER=html`.

---

## Step-by-Step Execution

1. **Optimize Main**: Change the startup sequence to be non-blocking.
2. **Re-Deploy**: Build and deploy using the new optimized command.

## Verification Plan

### Manual Verification
1. Open the website on a phone.
2. Measure the time from "Enter" to the first visual frame. It should be significantly lower (aiming for < 5 seconds on good 4G).
3. Verify that changes made in Admin mode on one device still eventually sync to others.
