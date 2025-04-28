# Pixabay Image Search with Object Detection

A Flutter application that allows users to search for images from Pixabay API and apply object detection to the selected images. Users can input a search term, view a list of images, and see detected objects in those images.

## Features

- **Image Search:** Fetches images from the [Pixabay API](https://pixabay.com/api/docs/) based on a user's search term.
- **Object Detection:** Uses Google ML Kit to detect objects in the selected images.
- **Responsive UI:** A simple and clean UI for searching and displaying images with object detection results.

## Getting Started

### 1. Clone the repository

Clone this repository to your local machine using Git:

```bash
git clone https://github.com/your-username/pixabay-object-detection.git
```

### 2. Install dependencies

Navigate to the project folder and install the required dependencies:
```bash
cd pixabay-object-detection
flutter pub get
```

### 3. Configure Pixabay API Key

In the lib/services/pixabay_service.dart file, replace the apiKey value with your own API key that you obtained from Pixabay.

### 4. Run the App

Run the app on an emulator or a real device:
```bash
flutter run
```

