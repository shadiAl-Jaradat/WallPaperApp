# WallPaperApp

A feature-rich Flutter application that provides users with a diverse collection of wallpapers to personalize their devices. The app integrates with the [**Pexels API**](https://www.pexels.com/), offering a vast library of high-quality images. Designed with an intuitive UI and modern development practices, it ensures a seamless and visually engaging user experience.

---

## Table of Contents

1. [Packages Used](#packages-used) 
2. [Screenshots](#screenshots)
3. [Implementation Details](#implementation-details)
   - [State Management](#state-management)
   - [UI Enhancements](#ui-enhancements)
   - [API Integration](#api-integration)
   - [Local Storage](#local-storage)
   - [Layouts](#layouts)
5. [Features](#features)
6. [Getting Started](#getting-started)

---

## Packages Used

Here are the key packages that power this application:

| Package Name               | Description                                                                                  |
|----------------------------|----------------------------------------------------------------------------------------------|
| [**dio**](https://pub.dev/packages/dio)                   | For making HTTP requests to the Pexels API.                                                 |
| [**provider**](https://pub.dev/packages/provider)         | For efficient state management across the app.                                             |
| [**path**](https://pub.dev/packages/path)                 | Provides utilities for manipulating file paths.                                            |
| [**path_provider**](https://pub.dev/packages/path_provider)| For accessing commonly used locations on the device file system.                          |
| [**sqflite**](https://pub.dev/packages/sqflite)           | To implement a local SQLite database for managing favorites.                              |
| [**shimmer**](https://pub.dev/packages/shimmer)           | For skeleton loading animations to improve user experience during data fetching.          |


---

## Screenshots

### Home Screen & Image details 
Explore a grid of random wallpapers.

<img width="450" alt="Home Screen" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/b5d0a40d-c868-4491-b165-ccce06064370">

### Search Screen  
Search for wallpapers by keywords or preferences.

<img width="450" alt="Search Screen" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/e03c89a2-d9db-467e-a159-dbc04b51dc1b">

### Favorites Screen  
Manage your personalized collection of wallpapers.

<img width="450" alt="Favorites Screen" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/36f8847e-36e1-4bb4-9b57-9d56e445a0cc">


### Animated Bottom Navigation Bar

![hh](https://github.com/user-attachments/assets/54ddbaeb-82a8-4f57-8327-bfc2139e4bfb)


---

## Features

- **Home Screen**  
  Browse a grid of randomly displayed wallpapers.

- **Search Screen**  
  Search for wallpapers by entering keywords and view results tailored to your preferences.

- **Wallpaper Details Screen**  
  - View selected wallpapers in full-screen mode.
  - Download wallpapers directly to your device.
  - Add wallpapers to your favorites collection.

- **Favorites Screen**  
  Access and manage your favorite wallpapers in a dedicated section.

---

## Implementation Details

### State Management
- **Provider**  
  Efficient state management using the `Provider` package ensures smooth data flow and synchronization across screens.

### UI Enhancements
- **Skeleton Loading**  
  Implemented with the `Shimmer` package to display placeholder animations while fetching data, improving perceived performance.

- **Animated Navigation**  
  Integrated the `Animated Notch Bottom Bar` package for a visually appealing bottom navigation bar with seamless transitions.

### API Integration
- **Pexels API**  
  Integrated with the Pexels API to provide a vast collection of high-quality wallpapers.

- **Dio**  
  Used for making efficient HTTP requests and handling API responses.

### Local Storage
- **SQLite Database**  
  Utilized `SQFLITE` to store and manage user favorites locally.

### Layouts
- **Flutter Staggered Grid View**  
  Leveraged the `Flutter Staggered Grid View` package for elegant and dynamic grid layouts.

---

## Getting Started

### Prerequisites
- Flutter SDK: Version 3.0.0 or later
- Access to the Pexels API (API Key required)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shadiAl-Jaradat/WallPaperApp.git
   cd WallPaperApp
