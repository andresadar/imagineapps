import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imagine_apps/ui/screens/home/widgets/app_bar.dart';
import 'package:imagine_apps/ui/screens/home/widgets/bottom_navbar.dart';
import 'package:imagine_apps/ui/screens/home/widgets/post.dart';
import 'package:imagine_apps/ui/screens/home/widgets/stories.dart';

import 'controller/bottom_nav_controller.dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BottomNavController bottomController;

  @override
  void initState() {
    bottomController = Provider.of<BottomNavController>(context, listen: false);
    bottomController.scrollController
        .addListener(bottomController.scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    bottomController.scrollController
        .removeListener(bottomController.scrollListener);
    bottomController.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        controller: bottomController.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: const [
          //AppBar
          AppBarHome(),

          //Stories
          StoriesHome(),

          //Post
          PostHome(),
        ],
      ),
      bottomNavigationBar: const BottomNavBarHome(),
    );
  }
}
