import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/side_menu.dart';
import 'package:profair/src/shared/responsive.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  HomeController? homeController;
  ValueNotifier<bool> openDrawer = ValueNotifier(true);

  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
    homeController!.findActives();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(
              action: () => openDrawer.value = !openDrawer.value,
            ),
            ValueListenableBuilder(
              valueListenable: openDrawer,
              builder: (context, bool value, child) {
                return SizedBox(
                  width: width * ((value || Responsive.isTablet(context)) ? 0.85 : 0.96),
                  // width: double.infinity  ,
                  child: const AutoRouter(),
                );
              },
            ),
            const Expanded(
              child: SizedBox(
                height: double.maxFinite,
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: AutoRouter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:profair/src/utils/colors.dart';
// import 'package:profair/src/views/create_post/create_post.dart';
// import 'package:profair/src/views/favorites/favorites.dart';
// import 'package:profair/src/views/home/home.dart';
// import 'package:profair/src/views/profile/profile.dart';
// import 'package:profair/src/views/search/search.dart';
// import 'package:flutter/material.dart';

// class App extends StatefulWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   int _selectedIndex = 0;
//   List<Widget> pageList = [
//     const HomePage(),
//     const Favorites(),
//     const CreatePost(),
//     const Search(),
//     const Profile(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pageList.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: colorPrimary,
//         unselectedItemColor: colorGreyDark,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         showSelectedLabels: false,
//         items: const [
//           BottomNavigationBarItem(
//             label: 'Home',
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             label: 'Favoritos',
//             icon: Icon(Icons.favorite_outline),
//             activeIcon: Icon(Icons.favorite),
//           ),
//           BottomNavigationBarItem(label: 'Criar', icon: Icon(Icons.add_circle_outline_outlined), activeIcon: Icon(Icons.add_circle)),
//           BottomNavigationBarItem(
//             label: 'Descobrir',
//             icon: Icon(Icons.search),
//             activeIcon: Icon(Icons.search_outlined),
//           ),
//           BottomNavigationBarItem(
//             label: 'Perfil',
//             icon: Icon(Icons.person_outline),
//             activeIcon: Icon(Icons.person),
//           ),
//         ],
//       ),
//     );
//   }
// }
