import 'package:flutter/material.dart';
import 'package:imagine_apps/ui/theme/colors.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;
    return SliverAppBar(
      floating: true,
      forceElevated: true,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: Theme.of(context).appBarTheme.toolbarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundColor: MyColors.background,
              backgroundImage: const NetworkImage(
                  'https://www.bnl.gov/today/body_pics/2017/06/stephanhruszkewycz-hr.jpg'),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 8.0),
                  padding: const EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                    color: MyColors.background,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Text(
                        'Search',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      Material(
                        color: MyColors.background,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.qr_code_scanner_rounded,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: IconButton(
                constraints: const BoxConstraints(minWidth: 45.0),
                onPressed: () {},
                icon: const Icon(Icons.message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
