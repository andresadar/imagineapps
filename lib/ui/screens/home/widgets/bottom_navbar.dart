import 'package:flutter/material.dart';
import 'package:imagine_apps/ui/screens/home/controller/bottom_nav_controller.dart.dart';
import 'package:imagine_apps/ui/screens/home/controller/controller.dart';
import 'package:provider/provider.dart';

class BottomNavBarHome extends StatelessWidget {
  const BottomNavBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BottomNavController>(context);

    return SizedBox(
      height: kToolbarHeight,
      child: Stack(
        children: [
          AnimatedPositioned(
            bottom: controller.showNavBar ? 0 : -kToolbarHeight,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _IconItem(index: 0, icon: Icons.home, label: 'Home'),
                  _IconItem(
                      index: 1, icon: Icons.person_search, label: 'My Network'),
                  _IconItem(
                      index: 2, icon: Icons.add_box_rounded, label: 'Post'),
                  _IconItem(
                      index: 3,
                      icon: Icons.notifications,
                      label: 'Notifications'),
                  _IconItem(index: 4, icon: Icons.work_rounded, label: 'jobs'),
                ],
              ),
            ),
            duration: const Duration(milliseconds: 200),
          )
        ],
      ),
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({
    Key? key,
    required this.index,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final int index;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomNavController>(context);
    final bool isSelected = bottomController.index == index;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 2,
            color: isSelected ? Colors.black : Colors.transparent,
          ),
          Expanded(
            child: FittedBox(
              child: InkWell(
                onTap: index == 2
                    ? () async => await Navigator.pushNamed(context, '/post')
                            .whenComplete(() {
                          final homeController = Provider.of<HomeController>(
                              context,
                              listen: false);
                          homeController.refresh();
                        })
                    : () => bottomController.changeIndex(index),
                child: Column(
                  children: [
                    Icon((icon),
                        color: isSelected ? Colors.black : Colors.grey),
                    const SizedBox(height: 5),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: isSelected ? Colors.black : Colors.grey,
                          fontSize: 9),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
