import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/result_model.dart';
import 'package:sports_spotter/widgets/nothing_to_show.dart';
import 'package:sports_spotter/widgets/result_view.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late Future<List<ResultModel>?> resultsFuture;
  @override
  void initState() {
    resultsFuture = ResultModel.getResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: FutureBuilder(
            future: resultsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                if (data!.isEmpty) {
                  return NothingToShow(refresh: () {
                    setState(() {
                      resultsFuture = ResultModel.getResults();
                    });
                  });
                }
                return LiquidPullToRefresh(
                    color: primaryColor,
                    onRefresh: () async {
                      setState(() {
                        resultsFuture = ResultModel.getResults();
                      });
                    },
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => ListTile(
                          title: Text(data[index].toString()),
                          leading: const Icon(FontAwesomeIcons.trophy),
                          subtitle: Text(data[index]
                              .declareDate
                              .toString()
                              .substring(0, 10)),
                          onTap: () => showModalBottomSheet(
                              isScrollControlled: true,
                              useSafeArea: true,
                              showDragHandle: true,
                              context: context,
                              builder: (context) => Container(
                                  width: double.maxFinite,
                                  padding: paddingAll24,
                                  child: ResultView(result: data[index])))),
                    ));
              }
              return loader;
            }),
      ),
    );
  }
}
