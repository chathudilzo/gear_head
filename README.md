# 🏎️ GearHead AI: Your 3D Vehicle Co-Pilot

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Firebase AI](https://img.shields.io/badge/Backend-Firebase_AI_Logic-orange.svg)](https://firebase.google.com/docs/ai)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> "Why are car diagnostics just a list of boring error codes?"

I built **GearHead AI** to answer that. It's a 2026-ready automotive dashboard that turns raw sensor data into a conversation. Instead of a "Check Engine" light, you get a 3D Digital Twin and an AI mechanic that actually explains what's happening under the hood in plain English.

---

### Digital Twin Visualization

Using a high-poly **O3D/GLB** model of a Mustang GT, the app visualizes the car's state. When the sensors report a 115°C engine spike, the app doesn't just show a number—it creates a visual "tension" in the UI to match the car's vitals.

### Multi-Modal "Co-Pilot"

Drivers shouldn't type. I integrated **Speech-to-Text (STT)** and **Text-to-Speech (TTS)** so you can hold the mic, report a weird sound, and hear a personalized diagnosis back through your car's speakers.

### Real-Time Mission Control (Tracking)

The "Tracking" module goes beyond a static map. It’s designed as a real-time monitor for your vehicle:

- **Live Location Streams:** Uses the `geolocator` and `Maps_flutter` packages to track the Mustang's coordinates with sub-meter accuracy.
- **Smooth Marker Rotation:** Implemented custom math to rotate the car marker based on the vehicle's heading (bearing), making the tracking feel fluid and professional.
- **Geofencing Prep:** Architected the data layer to support virtual boundaries, allowing the AI to alert the user if the car leaves a designated safe zone.

### Context-Aware AI Diagnostics

Powered by **Gemini 2.5 Flash**, the AI doesn't just look at fault codes. It analyzes a full "Snapshot" of telemetry:

- **Active DTCs** (Fault Codes)
- **Live Thermal Indices**
- **Fluid & Oil Health**
- **Localized Advice** (Safety tips specifically for Sri Lankan climates and terrain).

---

## The 2026 Tech Stack

- **Frontend:** Flutter with **Riverpod** (AsyncNotifier) for reactive, non-blocking AI states.
- **AI Core:** **Firebase AI Logic SDK**. I chose this to keep API keys server-side and secure.
- **Model:** `gemini-2.5-flash-lite` for near-instant responses and high-token efficiency.
- **3D Engine:** `o3d` for rendering interactive GLB models.
- **State Management:** Riverpod ensures the UI stays "live" while the AI processes telemetry in the background.

---

## 📂 Repository Breakdown

- `lib/features/ai_chat`: The "brain" of the app. Handles the AI prompt engineering and chat states.
- `lib/features/remote`: Manages the 3D model interaction and "Digital Twin" state.
- `assets/data/scenarios.json`: A library of real-world automotive failure scenarios used to train and test the AI.

## Getting it Running

1. **Setup Firebase:** Run `flutterfire configure`.
2. **Enable AI:** Visit your Google Cloud Console and enable the `Firebase AI Logic` and `Vertex AI` APIs.
3. **Environment:** No API keys are hardcoded. Ensure you've initialized Firebase in your `main.dart`.
4. **Launch:** ```bash
   flutter pub get
   flutter run
