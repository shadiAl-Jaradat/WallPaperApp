import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/app_state.dart';
import 'package:wallpaper_app/screens/bottom_bar.dart';
import 'package:wallpaper_app/screens/home_screen.dart';
import 'package:wallpaper_app/services/database_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.initDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => WallpaperProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper App',
        home: BottomBar(),
      ),
    ),
  );
}


class WallpaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
