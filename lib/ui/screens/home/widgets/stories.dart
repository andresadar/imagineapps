import 'package:flutter/material.dart';
import 'package:imagine_apps/data/models/story_model.dart';
import 'package:imagine_apps/ui/screens/home/controller/controller.dart';
import 'package:imagine_apps/ui/theme/colors.dart';
import 'package:provider/provider.dart';

class StoriesHome extends StatelessWidget {
  const StoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: kToolbarHeight * 2,
            color: Colors.white,
            child: FutureBuilder<List<StoryModel>>(
                future: controller.getStories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('HasError'),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i) {
                      StoryModel story = snapshot.data![i];

                      if (story.myStory) {
                        return _ItemStorie(
                          myUser: true,
                          viewed: true,
                          img: story.img,
                          author: story.author,
                        );
                      }

                      return _ItemStorie(img: story.img, author: story.author);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _ItemStorie extends StatelessWidget {
  const _ItemStorie({
    Key? key,
    this.myUser = false,
    this.viewed = false,
    required this.img,
    required this.author,
  }) : super(key: key);

  final bool myUser;
  final bool viewed;
  final String img, author;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          myUser
              ? Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CircleImageStory(viewed: viewed, img: img),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: .5),
                          ),
                          child: const FittedBox(
                            child: Icon(Icons.add, color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: _CircleImageStory(viewed: viewed, img: img),
                ),
          Text(
            author,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}

class _CircleImageStory extends StatelessWidget {
  const _CircleImageStory({
    Key? key,
    this.viewed = false,
    required this.img,
  }) : super(key: key);

  final bool viewed;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
          color: MyColors.background,
          shape: BoxShape.circle,
          border: Border.all(
              color: viewed ? Colors.transparent : Colors.blue, width: 1.5)),
    );
  }
}
