import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sports_spotter/api/posts.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/widgets/error_widget.dart';
import 'package:sports_spotter/widgets/event_card.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var response = fetchPosts();
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: primaryColor,
      showChildOpacityTransition: false,
      onRefresh: () async {
        setState(() {
          response = fetchPosts();
        });
      },
      child: Center(
        child: FutureBuilder(
            future: response,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return NothingToShow(
                    refresh: () {
                      setState(() {});
                    },
                  );
                }
                return ListView.separated(
                    padding: paddingAll8,
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 4,
                        ),
                    itemBuilder: (context, index) {
                      return EventCard(
                          image: NetworkImage(data[index]['image_url']),
                          title: data[index]['title'],
                          description: data[index]['description']);
                    });
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.flickr(
                    leftDotColor: primaryColor,
                    rightDotColor: secondaryColor,
                    size: 64);
              }
              return ErrorMessage(
                refresh: () {
                  setState(() {});
                },
              );
            })),
      ),
    );
  }
}
