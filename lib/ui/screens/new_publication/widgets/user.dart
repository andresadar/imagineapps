import 'package:flutter/material.dart';
import 'package:imagine_apps/ui/theme/colors.dart';

class UserInformationPost extends StatelessWidget {
  const UserInformationPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: MyColors.background,
          backgroundImage: const NetworkImage(
              'https://www.bnl.gov/today/body_pics/2017/06/stephanhruszkewycz-hr.jpg'),
          radius: 25,
        ),
        const _Chip(
          icon: Icons.person,
          label: 'Andres Arenas R.',
        ),
        const _Chip(
          icon: Icons.public,
          label: 'Anyone',
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Colors.grey),
      avatar: Icon(
        icon,
        color: Colors.grey,
        size: 20,
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.grey),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.grey)
        ],
      ),
    );
  }
}
