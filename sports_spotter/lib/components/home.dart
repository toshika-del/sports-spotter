import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sports_spotter/api/posts.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';
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
  final queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: primaryColor,
      showChildOpacityTransition: false,
      onRefresh: () async {
        setState(() {
          response = fetchPosts();
          queryController.clear();
        });
      },
      child: Center(
        child: Column(
          children: [
            Visibility(
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextField(
                  controller: queryController,
                  onChanged: (value) {
                    setState(() {
                      response = EventModel.search(value);
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search Events',
                      prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass)),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: response,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      data = data.where((element) => element.status).toList();
                      if (data.isEmpty) {
                        return NothingToShow(
                          refresh: () {
                            setState(() {
                              response = fetchPosts();
                              queryController.clear();
                            });
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
                            return EventCard(model: data[index]);
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
                        setState(() {
                          response = fetchPosts();
                          queryController.clear();
                        });
                      },
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
