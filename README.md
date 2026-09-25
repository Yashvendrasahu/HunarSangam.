# HunarSangam (हुनर संगम) - Smart India Hackathon (SIH)

A cross-platform **Flutter & Dart** application designed for Indian artisan collectives, craft makers, and bulk enterprise buyers. Empowering rural artisans with AI-powered craft storytelling, voice-first onboarding, dynamic fair-pricing calculator, and seamless direct B2B bulk orders.

---

## 🌟 Key Features

1. **Artisan Hub & Vernacular Onboarding**:
   - Multi-language support (Hindi, English, etc.)
   - Voice-guided profile creation & audio recording
   - Craft selection (Blue Pottery, Madhubani, Pashmina, Brassware, Woodcarving, etc.)
   - Digital visiting card generation & collective management

2. **Enterprise Bulk Buyer Portal**:
   - Multi-step buyer onboarding (Business entity, GST, annual sourcing budget, craft categories)
   - Discovery suite & featured artisan stories
   - Voice requirement intake & AI-powered artisan matching
   - Direct sample requests, live order tracking & escrow payment flow

3. **Multilingual Real-Time Chat**:
   - Voice-note transmission & automatic speech-to-speech / audio playback
   - Real-time messaging between buyers and artisans
   - Order timeline & production stage updates

4. **Hardware & Sensors Integration**:
   - Device camera & gallery image picker for catalog & identity verification
   - Hardware TTS (Text-to-Speech) & STT (Speech-to-Text) support

---

## 📱 Platforms Supported

- **Android (APK & App Bundle)**: Native Android app with Material 3 design, hardware camera, microphone, text-to-speech, and speech-to-text.

---

## 🏗️ Architecture

The HunarSangam Android application runs as a fully standalone mobile client communicating directly with:

1. **Supabase (Backend-as-a-Service)**:
   - Official `supabase_flutter` SDK
   - Row-Level Security (RLS) with `SUPABASE_ANON_KEY`
   - Profiles, Artisans, Products, Orders, Order Requests, Collaborations, and Storage Buckets
   - Offline fallback cache and mock data for instant preview

2. **Google Gemini API (Direct Cloud AI)**:
   - Direct HTTPS calls to `generativelanguage.googleapis.com`
   - Multilingual Craft Storytelling (Hindi & English)
   - Dynamic Fair-Price Breakdown Engine
   - Vernacular Audio/Text Buyer Sourcing Requirement Parser
   - Conversational Craft Assistant & Cluster Matching
   - Zero dependency on FastAPI, localhost, or local proxies

---

## 🚀 How to Run & Build the Android APK

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.0.0`)
- [Android Studio / Android SDK](https://developer.android.com/studio) (for Android APK build)

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run on Android Device / Emulator
Ensure an Android device or emulator is connected:
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key \
  --dart-define=GEMINI_API_KEY=your-gemini-key
```

### 3. Build Release APK
```bash
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key \
  --dart-define=GEMINI_API_KEY=your-gemini-key
```
*(The output APK will be located at `build/app/outputs/flutter-apk/app-release.apk`)*

---

## 📁 Project Structure

```text
.
├── android/            # Native Android project configuration, manifests, & Gradle scripts
├── assets/             # Branding assets, logos, and UI graphics
│   └── images/
│       └── logo.png    # HunarSangam official logo
├── lib/                # Flutter application source code
│   ├── add_product/    # Guided product catalog creation & camera capture flow
│   ├── models/         # Data models (buyer onboarding, orders, crafts, products)
│   ├── screens/        # UI screens (Artisan & Buyer portals, chat, onboarding, orders)
│   ├── services/       # Supabase, Gemini AI, Hardware, Auth & Order services
│   ├── widgets/        # Reusable UI components & branding badges
│   └── main.dart       # App entry point & navigation router
├── supabase/           # Database schema migrations & SQL setup
├── pubspec.yaml        # Flutter project dependencies & asset definitions
└── README.md           # Project documentation
```

---

## 🔒 Security Notice

- **Supabase Keys**: The Flutter client uses only the public `SUPABASE_ANON_KEY`. Never bundle the `SUPABASE_SERVICE_ROLE_KEY` in the mobile app. All database access is governed by Supabase Row-Level Security (RLS) policies.
- **Gemini API Key**: When passing `GEMINI_API_KEY` via `--dart-define`, note that strings in client APKs can be inspected by reverse engineers. For production apps with high quotas, consider routing sensitive operations via an authenticated Supabase Edge Function or proxy. For hackathons, demos, and prototypes, direct client-to-API communication provides optimal simplicity without server management.

---

## 🏆 Smart India Hackathon (SIH)
- **Project**: HunarSangam
- **Tech Stack**: Flutter (Dart), Supabase (PostgreSQL), Google Gemini API

# 🧶 HunarSangam

### Digital Platform for Empowering Traditional Artisans & Handicraft Heritage

**Smart India Hackathon 2026 — SIH26090**
**Team: Elite Innovators**

---

## 🌟 About HunarSangam

**HunarSangam** is a digital platform designed to connect traditional artisans, their unique crafts, and modern customers through technology.

The platform aims to help artisans **showcase their skills, preserve traditional craftsmanship, reach wider markets, and build sustainable digital livelihoods**.

HunarSangam brings together artisan profiles, handcrafted products, storytelling, AI-assisted discovery, and digital commerce into a single ecosystem.

---

## 🎯 Problem Statement

Traditional artisans often face challenges such as:

* Limited access to wider markets
* Lack of digital visibility
* Difficulty in showcasing traditional craftsmanship
* Dependence on intermediaries
* Limited digital knowledge
* Risk of traditional crafts losing visibility among younger generations

HunarSangam addresses these challenges through an accessible and technology-driven digital platform.

---

## 💡 Our Solution

HunarSangam provides a unified platform where:

**Artisans → Showcase their skills & products**

**Customers → Discover authentic traditional crafts**

**AI → Helps users discover and interact with craft content**

**Digital Marketplace → Creates opportunities for wider reach**

**Craft Stories → Preserve the cultural context behind every creation**

---

## ✨ Key Features

### 👨‍🎨 Artisan Profiles

Create digital profiles for artisans and showcase their skills, experience, craft traditions and products.

### 🛍️ Product Catalogue

Browse and explore handcrafted products with structured product information.

### 📖 Craft Stories

Tell the story behind traditional crafts, artisans and regional craftsmanship to preserve cultural heritage.

### 🤖 AI-Powered Assistance

AI-based features help users discover crafts, understand products and interact with the platform more naturally.

### 🎙️ Voice & Camera Interaction

The platform is designed to support modern interaction methods such as voice and camera-based experiences.

### 🌐 Digital Market Access

Help traditional artisans reach customers beyond their local markets.

### 🔎 Smart Discovery

Users can explore products and crafts based on their interests and requirements.

---

## 🏗️ Technology Stack

### Frontend

* Flutter
* Dart

### Backend

* Node.js
* Express.js

### Database & Services

* Supabase

### AI & Machine Learning

* Python
* FastAPI
* AI/ML Models
* Hugging Face

### Design & Development

* Figma
* GitHub
* Vercel

---

## 🔄 System Architecture

```text
                 ┌─────────────────────┐
                 │       User          │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Flutter App       │
                 │  Mobile / Web UI    │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Node.js +         │
                 │   Express Backend   │
                 └───────┬─────┬───────┘
                         │     │
             ┌───────────┘     └────────────┐
             ▼                              ▼
    ┌─────────────────┐            ┌─────────────────┐
    │    Supabase     │            │   FastAPI / AI  │
    │ Database & Auth │            │    Services     │
    └─────────────────┘            └────────┬────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │   AI / ML       │
                                    │     Models      │
                                    └─────────────────┘
```

---

## 📱 Platform Modules

* 🏠 Home & Discovery
* 👨‍🎨 Artisan Profiles
* 🛍️ Product Catalogue
* 📖 Craft Stories
* 🤖 AI Assistant
* 🎙️ Voice Interaction
* 📷 Camera-based Interaction
* 🔍 Search & Discovery
* 👤 User Profile

---

## 🚀 Getting Started

### Prerequisites

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Node.js
* Git
* Python

### Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/HunarSangam.git
cd HunarSangam
```

### Frontend Setup

```bash
flutter pub get
flutter run
```

### Backend Setup

```bash
cd backend
npm install
npm start
```

### AI Service Setup

```bash
cd ai-service
pip install -r requirements.txt
uvicorn main:app --reload
```

> Configure the required environment variables before running the application.

---

## 🎥 Demo

### Project Demo Video

[Watch HunarSangam Demo](YOUR-YOUTUBE-LINK)

### Live Demo

[Open HunarSangam](YOUR-LIVE-DEMO-LINK)


---

## 🌱 Expected Impact

HunarSangam aims to:

* Increase digital visibility of traditional artisans
* Provide wider market access
* Encourage preservation of traditional crafts
* Connect customers with authentic handcrafted products
* Promote India's diverse craft heritage
* Create opportunities for technology-enabled artisan livelihoods

---

## 🔮 Future Scope

Future development may include:

* Advanced AI-based craft recognition
* Multilingual voice assistance
* Personalized product recommendations
* Digital payments and integrated commerce
* Wider artisan onboarding
* Integration with suitable government and digital commerce ecosystems
* Analytics for artisans and platform administrators

---

## 🏆 Smart India Hackathon

**Problem Statement:** SIH26090
**Project:** HunarSangam
**Team:** Elite Innovators
**Event:** Smart India Hackathon 2026

---

## 👥 Team Elite Innovators

**HunarSangam — Technology for Tradition, Digital Access for Artisans.**

---



This project is developed as part of **Smart India Hackathon 2026**.

© 2026 Team Elite Innovators
