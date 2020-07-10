import 'package:fitfunction/authentication.dart';
import 'package:fitfunction/screens/homePages/menu_page.dart';
import 'package:fitfunction/screens/homePages/post_page.dart';
import 'package:fitfunction/screens/homePages/profile_page.dart';
import 'package:fitfunction/screens/homePages/workout_page.dart';
import 'package:fitfunction/screens/loginPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Authentication authentication = Authentication();
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Center(
          child: Text(
            'FitFunction',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottom: TabBar(
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.black26,
        tabs: [
          Tab(
            icon: Image.asset('images/home.png'),
          ),
          Tab(
            icon: Image.asset('images/dumbbell.png'),
          ),
          Tab(
            icon: Image.asset('images/person.png'),
          ),
          Tab(
            icon: Image.asset('images/menu.png'),
          ),
        ],
      ),
      pinned: true,
      floating: true,
    );

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                flexibleSpaceWidget,
              ];
            },
            body: TabBarView(
              children: <Widget>[
                PostPage(),
                WorkoutPage(),
                ProfilePage(),
                MenuPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar _tabBar;

//   _SliverAppBarDelegate(this._tabBar);

//   @override
//   double get minExtent => _tabBar.preferredSize.height;

//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
