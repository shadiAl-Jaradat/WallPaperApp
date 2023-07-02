# wallpaper_app

The Flutter app project aims to provide users with a diverse collection of wallpapers to personalize their devices. The app incorporates various features and packages to deliver a seamless and visually appealing user experience.

---

### Screen Shots

Home Screen :

<img width="450" alt="pic1" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/b5d0a40d-c868-4491-b165-ccce06064370">

Search Screen : 

<img width="450" alt="pic2" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/e03c89a2-d9db-467e-a159-dbc04b51dc1b">

Favourite Screen : 

<img width="450" alt="pic3" src="https://github.com/shadiAl-Jaradat/WallPaperApp/assets/94618324/36f8847e-36e1-4bb4-9b57-9d56e445a0cc">

---
## App Features

- Home Screen: The home screen presents users with a grid view of randomly displayed wallpapers, allowing them to explore a wide range of options.
- Search Screen: The search screen enables users to find wallpapers based on specific keywords or preferences. Users can enter search queries and view relevant wallpapers in the    search results.
- Wallpaper Details Screen: This screen offers users a closer look at selected wallpapers. Wallpapers fill the entire screen, allowing users to appreciate the finer details. They   can also download wallpapers to their device and add them to their favorites collection.
- Favorite Screen: The favorite screen serves as a personalized collection of wallpapers that users have marked as favorites. Users can easily access and manage their favorite      wallpapers in this dedicated section.

---
## Implementation Details
The app incorporates the following ideas and packages to enhance its functionality and user experience:

- ***Provider State Management***  :  The app utilizes the Provider package for efficient state management, ensuring smooth data flow and synchronization across screens.

- ***Skeleton Loading with Shimmer Package***  :  To improve the user experience, the Shimmer package from Flutter is used to implement skeleton loading. This technique provides a placeholder animation while the app fetches and loads data, giving the user a sense of progress and interactivity.

- ***Animated Notch Bottom Bar***  :  The app integrates the Animated Notch Bottom Bar package to create an animated navigation bar at the bottom of the screen. This enhances the app's visual appeal and provides seamless navigation between screens.

- ***API Integration with Pexels***  :  The app integrates with the Pexels API to retrieve wallpapers and related data. This integration ensures a vast collection of high-quality images for users to browse and download.

- ***Dio***  :  The Dio package is used for making HTTP requests to the Pexels API. This package simplifies the process of fetching data and handling API responses efficiently.

- ***SQLite Database (SQFLITE)***  :  The app employs the SQFLITE package to implement a local SQLite database, allowing users to save and manage their favorite wallpapers.

- ***Flutter Staggered Grid View Package***  :  The Flutter Staggered Grid View package is utilized to achieve an elegant and visually appealing grid view layout for displaying wallpapers.




