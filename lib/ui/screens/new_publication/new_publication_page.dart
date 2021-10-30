import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imagine_apps/ui/screens/new_publication/controller/controller.dart';

import 'widgets/user.dart';

class NewPublicationPage extends StatefulWidget {
  const NewPublicationPage({Key? key}) : super(key: key);

  @override
  State<NewPublicationPage> createState() => _NewPublicationPageState();
}

class _NewPublicationPageState extends State<NewPublicationPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        myShowBottomSheet();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostController controller =
        Provider.of<PostController>(context, listen: true);
    controller.textController.text = '';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text('Start post'),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.loadingPost) return;

              if (controller.textController.text.length < 5) {
                const snackBar = SnackBar(
                  content: Text('Escribe algo para publicar'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                await controller.createPost(controller.textController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
      body: Column(
        children: [
          //Linear Progress
          controller.loadingPost
              ? const LinearProgressIndicator(
                  color: Colors.blue,
                )
              : const SizedBox(),

          //TextField
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const UserInformationPost(),
                const Divider(),
                TextField(
                  controller: controller.textController,
                  focusNode: controller.inputFocus,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'What do you want to talk about?'),
                )
              ],
            ),
          ),

          //Buttons showBottomSheet
          Container(
            alignment: Alignment.center,
            height: kToolbarHeight,
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () => myShowBottomSheet(),
            ),
          )
        ],
      ),
    );
  }

  void myShowBottomSheet() {
    showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const _ListTile(
                      icon: Icons.photo,
                      label: 'Add a photo',
                    ),
                    const _ListTile(
                      icon: Icons.video_call,
                      label: 'Take a video',
                    ),
                    const _ListTile(
                      icon: Icons.verified,
                      label: 'Celebrate an occasion',
                    ),
                    const _ListTile(
                      icon: Icons.document_scanner,
                      label: 'Add a document',
                    ),
                    const _ListTile(
                      icon: Icons.work_outline_rounded,
                      label: 'Share that you are hiring',
                    ),
                    const _ListTile(
                      icon: Icons.contact_mail,
                      label: 'Find an expert',
                    ),
                    const _ListTile(
                      icon: Icons.photo_album,
                      label: 'Share a story',
                    ),
                    _ListTile(
                      icon: Icons.bar_chart_outlined,
                      label: 'Create a poli',
                      voidCallback: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.white,
            barrierColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            elevation: 2,
            isScrollControlled: true)
        .whenComplete(() {
      PostController controller =
          Provider.of<PostController>(context, listen: false);
      FocusScope.of(context).requestFocus(controller.inputFocus);
    });
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    required this.icon,
    required this.label,
    this.voidCallback,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: voidCallback,
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
