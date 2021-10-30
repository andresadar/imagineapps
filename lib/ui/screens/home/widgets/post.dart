import 'package:flutter/material.dart';
import 'package:imagine_apps/data/models/post_model.dart';
import 'package:imagine_apps/ui/screens/home/controller/controller.dart';
import 'package:imagine_apps/ui/theme/colors.dart';
import 'package:provider/provider.dart';

class PostHome extends StatelessWidget {
  const PostHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return FutureBuilder<List<PostModel>>(
      future: controller.getPost(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverList(
            delegate: SliverChildListDelegate([
              const Center(
                child: CircularProgressIndicator(),
              )
            ]),
          );
        }

        if (snapshot.hasError) {
          return SliverList(
            delegate: SliverChildListDelegate([
              const Center(
                child: Text('HasError'),
              )
            ]),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((_, i) {
            PostModel post = snapshot.data![i];
            return _ItemPost(post: post);
          }, childCount: snapshot.data?.length),
        );
      },
    );
  }
}

class _ItemPost extends StatelessWidget {
  const _ItemPost({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now().difference(post.createAt.toDate()).inMinutes;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10).copyWith(bottom: 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: MyColors.background,
                backgroundImage: NetworkImage(post.imageProfile),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      post.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.profession,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.grey),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '$date min • ',
                        children: [
                          TextSpan(
                            text: post.edit ? 'Edit' : '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.public, size: 15),
                          )
                        ],
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              post.myPost
                  ? IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () => myShowBottomSheet(context, post.id),
                    )
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 10),
          Text(post.description),
          const SizedBox(height: 10),
          post.img != null
              ? Image.network(
                  post.img!,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      child: Center(
                        child: LinearProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child:
                      Icon(Icons.favorite_border, color: Colors.blue, size: 15),
                ),
                TextSpan(
                  text: ' ${post.likes}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _IconPost(
                icon: Icons.favorite,
                label: 'Like',
              ),
              _IconPost(
                icon: Icons.comment,
                label: 'Comment',
              ),
              _IconPost(
                icon: Icons.share,
                label: 'Share',
              ),
              _IconPost(
                icon: Icons.attach_file_rounded,
                label: 'Send',
              ),
            ],
          )
        ],
      ),
    );
  }

  void myShowBottomSheet(BuildContext context, String id) {
    final controller = Provider.of<HomeController>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit post'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) {
                      final textController = TextEditingController();
                      textController.text = post.description;
                      return AlertDialog(
                        title: const Text('Edit post'),
                        content: TextField(
                          controller: textController,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(hintText: 'New text'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (textController.text == post.description) {
                                Navigator.pop(context);
                                return;
                              }
                              if (textController.text.length < 5) return;
                              controller.updatePost(id, textController.text);
                              Navigator.pop(context);
                            },
                            child: const Text('Editar',
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete post'),
                onTap: () {
                  controller.deletePost(id).whenComplete(
                        () => Navigator.pop(context),
                      );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class _IconPost extends StatelessWidget {
  const _IconPost({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: FittedBox(
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.grey),
            )
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
