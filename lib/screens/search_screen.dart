import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/screens/wallpaper_details_screen.dart';
import '../providers/app_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late double screenHeight;
  late double screenWidth;
  List<Wallpaper> listOfWallPapers = [];
  String searchQuery = "";
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClearButton = false;

  void doSearch() async {
    if (searchQuery.isNotEmpty) {
      final wallpaperProvider = Provider.of<WallpaperProvider>(context, listen: false);
      await wallpaperProvider.searchWallpapers(searchQuery);
      final wallpapers = wallpaperProvider.getWallpapers();
      setState(() => listOfWallPapers = wallpapers);
    } else {
      setState(() => listOfWallPapers.clear());
    }
  }

  @override
  void initState() {
    _textEditingController.addListener(_onTextChanged);

    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _textEditingController.text.isNotEmpty;
    });
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      _showClearButton = false;
      listOfWallPapers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFf3f3f3),
                      labelStyle: const TextStyle(color: Colors.grey),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _showClearButton
                          ? GestureDetector(
                              onTap: _clearText,
                              child: const Icon(Icons.clear, color: Colors.grey),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: doSearch,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lightGreen),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 130),
              itemCount: listOfWallPapers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final wallpaper = listOfWallPapers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WallpaperDetailsScreen(wallpaper: wallpaper),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: NetworkImage(wallpaper.imageUrl), fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
