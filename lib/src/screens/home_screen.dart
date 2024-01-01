import 'dart:convert';
import 'dart:developer';

import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tony_web/src/Api/data_model.dart';
import 'package:tony_web/src/screens/line_chart_screen.dart';
import 'package:tony_web/src/screens/passive_screen.dart';
import 'package:tony_web/src/utilities/helper.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var dummyData = {
  //   "emotion_score": 81.38888888888889,
  //   "emotion_split": {"Anger": 9, "Antipation": 0, "Disgust": 2, "Fear": 0, "Joy": 20, "Sadness": 3, "Surprise": 2, "Trust": 6},
  //   "intention_score": 28.333333333333332,
  //   "intention_split": {"Advice": 0, "Cancelation": 0, "Complaint": 2, "Information": 0, "Purchase": 0, "Recommendation": 1, "Support": 0},
  //   "keywords": [
  //     "lassan",
  //     "good",
  //     "person",
  //     "odd",
  //     "numero",
  //     "uno",
  //   ],
  //   "sentiment_score": 51.666666666666664,
  //   "sentiment_split": {"Extremely Negative": 4, "Extremely Positive": 6, "Negative": 12, "Neutral": 9, "None": 8, "Positive": 21},
  //   "social_score": 0.0,
  //   "social_score_diagram": [40, 50, 45, 53, 40, 60, 72],
  //   "top_tweets": [
  //     {
  //       "date": null,
  //       "like_count": 0,
  //       "retweet_count": 0,
  //       "tweet":
  //           "Top 10 Google's Most Searched People in the world (2023)\n\n1)Damar Hamlin\n2)Jeremy Renner\n3)Andrew Tate\n4)Kylian Mbappé\n5)Travis Kelce\n6)Jenna Ortega\n7)Lil Tay\n8)Danny Masterson\n9)Devid Beckham\n10)Pedro Pascal\n\n#DamarHamlin #AndrewTate #JeremyRenner #LilTay",
  //       "views_count": 425
  //     },
  //     {
  //       "date": null,
  //       "like_count": 0,
  //       "retweet_count": 0,
  //       "tweet": "Yesterday was a good day for the most people in the world ",
  //       "views_count": 5
  //     },
  //     {
  //       "date": null,
  //       "like_count": 0,
  //       "retweet_count": 0,
  //       "tweet": "Yesterday was a good day for the most people in the world ",
  //       "views_count": 5
  //     },
  //     {
  //       "date": null,
  //       "like_count": 0,
  //       "retweet_count": 0,
  //       "tweet": "Yesterday was a good day for the most people in the world ",
  //       "views_count": 5
  //     },
  //     {
  //       "date": null,
  //       "like_count": 0,
  //       "retweet_count": 0,
  //       "tweet": "Yesterday was a good day for the most people in the world ",
  //       "views_count": 5
  //     },
  //     {"date": null, "like_count": 0, "retweet_count": 0, "tweet": "What do youthinitely", "views_count": 425}
  //   ],
  //   "total_tweets": 60,
  //   "volume_diagram": [40, 50, 60, 70, 50, 40, 60]
  // };
  final TextEditingController _searchC = TextEditingController();
  var colors = [
    Colors.blue.shade600,
    Colors.purple.shade600,
    Colors.red.shade600,
    Colors.yellow.shade600,
    Colors.green.shade600,
    Colors.brown.shade600,
    Colors.pink.shade300,
    Colors.teal,
  ];
  DataModel? _dataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.only(left: 45, right: 45, top: 20, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 38),
                      ),
                      Text(
                        "Tony",
                        style: TextStyle(fontSize: 54, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PassiveScreen(),
                            ));
                      },
                      child: const Text("Passive Monitoring ->"))
                ],
              ),
              const SizedBox(height: 35),
              Center(
                child: Container(
                  // margin: const EdgeInsets.only(left: 160, right: 160),
                  width: Helper.setWidth(context, width: 0.5),
                  padding: const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: TextFormField(
                    controller: _searchC,
                    onFieldSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Please wait this may take a while..."),
                            content: SizedBox(height: 50, width: 50, child: Center(child: CircularProgressIndicator())),
                          ),
                        );
                        _dataModel = await getApiData(value);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        setState(() {});
                      }
                    },
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search...",
                        hintStyle: TextStyle(fontSize: 22),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 35,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              _dataModel == null
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TOP TWO CARDS ROW
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: Colors.grey.shade300,
                                        child: SizedBox(
                                          height: Helper.setHeight(context, height: 0.5),
                                          width: Helper.setWidth(context, width: 0.5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              const Text(
                                                "Social Score Trend",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Expanded(child: LineChartSample(values: _dataModel!.socialScoreDiagram)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 35),
                                    height: Helper.setHeight(context, height: 0.2),
                                    width: Helper.setWidth(context, width: 0.18),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.white, boxShadow: [
                                      BoxShadow(blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))
                                    ]),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue.withOpacity(0.2),
                                          ),
                                          child: const Icon(
                                            Icons.bar_chart,
                                            color: Colors.blue,
                                            size: 35,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _dataModel == null ? "- - -" : _dataModel!.socialScore.toString(),
                                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
                                            ),
                                            const Text(
                                              "Social Score",
                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 22),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: Colors.grey.shade300,
                                        child: SizedBox(
                                          height: Helper.setHeight(context, height: 0.5),
                                          width: Helper.setWidth(context, width: 0.5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              const Text(
                                                "Volume Trend",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Expanded(child: LineChartSample(values: _dataModel!.volumeDiagram)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 35),
                                    height: Helper.setHeight(context, height: 0.2),
                                    width: Helper.setWidth(context, width: 0.18),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow.withOpacity(0.2),
                                          ),
                                          child: const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 35,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _dataModel == null ? "- - -" : _dataModel!.totalTweets.toString(),
                                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
                                            ),
                                            const Text(
                                              "Volume",
                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 22),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //BOTTOM THREE CARDS
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                                    height: Helper.setHeight(context, height: 0.52),
                                    width: Helper.setWidth(context, width: 0.18),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                                      BoxShadow(blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))
                                    ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Sentiment\nScore",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  _dataModel != null ? _dataModel!.sentimentScore.toStringAsFixed(1) : "-",
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            AnimatedCircularChart(
                                              edgeStyle: SegmentEdgeStyle.round,
                                              size: const Size(150.0, 150.0),
                                              initialChartData: <CircularStackEntry>[
                                                CircularStackEntry(
                                                  [
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.extremelyNegative.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.extremelyNegative.toDouble(),
                                                        colors[0],
                                                        rankKey: '2'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.extremelyPositive.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.extremelyPositive.toDouble(),
                                                        colors[1],
                                                        rankKey: '3'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.negative.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.negative.toDouble(),
                                                        colors[2],
                                                        rankKey: '4'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.neutral.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.neutral.toDouble(),
                                                        colors[3],
                                                        rankKey: '5'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.none.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.neutral.toDouble(),
                                                        colors[4],
                                                        rankKey: '6'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.sentimentSplit.positive.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.sentimentSplit.positive.toDouble(),
                                                        colors[5],
                                                        rankKey: '1'),
                                                  ],
                                                  rankKey: 'Quarterly Profits',
                                                ),
                                              ],
                                              chartType: CircularChartType.Radial,
                                            )
                                          ],
                                        ),
                                        ColorBar(
                                            title: "Extremely Negative",
                                            value: _dataModel!.sentimentSplit.extremelyNegative,
                                            color: colors[0]),
                                        ColorBar(
                                            title: "Extremely Positive",
                                            value: _dataModel!.sentimentSplit.extremelyPositive,
                                            color: colors[1]),
                                        ColorBar(title: "Negative", value: _dataModel!.sentimentSplit.negative, color: colors[2]),
                                        ColorBar(title: "Neutral", value: _dataModel!.sentimentSplit.neutral, color: colors[3]),
                                        ColorBar(title: "None", value: _dataModel!.sentimentSplit.none, color: colors[4]),
                                        ColorBar(title: "Positive", value: _dataModel!.sentimentSplit.positive, color: colors[5]),
                                      ],
                                    )),

                                Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                                    height: Helper.setHeight(context, height: 0.58),
                                    width: Helper.setWidth(context, width: 0.18),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                                      BoxShadow(blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))
                                    ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Intention\nScore",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  _dataModel != null ? _dataModel!.intentionScore.toStringAsFixed(1) : "-",
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            AnimatedCircularChart(
                                              edgeStyle: SegmentEdgeStyle.round,
                                              size: const Size(150.0, 150.0),
                                              initialChartData: <CircularStackEntry>[
                                                CircularStackEntry(
                                                  [
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.advice.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.advice.toDouble(),
                                                        colors[0],
                                                        rankKey: '1'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.cancelation.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.cancelation.toDouble(),
                                                        colors[1],
                                                        rankKey: '2'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.complaint.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.complaint.toDouble(),
                                                        colors[2],
                                                        rankKey: '3'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.information.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.information.toDouble(),
                                                        colors[3],
                                                        rankKey: '4'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.purchase.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.purchase.toDouble(),
                                                        colors[4],
                                                        rankKey: '5'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.recommendation.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.intentionSplit.recommendation.toDouble(),
                                                        colors[5],
                                                        rankKey: '6'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.intentionSplit.support.toString()) == 0
                                                            ? 1.0
                                                            : _dataModel!.intentionSplit.support.toDouble(),
                                                        double.tryParse(_dataModel!.intentionSplit.support.toString()) == 0
                                                            ? Colors.grey.shade300
                                                            : colors[6],
                                                        rankKey: '7'),
                                                  ],
                                                  rankKey: 'E Profits',
                                                ),
                                              ],
                                              chartType: CircularChartType.Radial,
                                            )
                                          ],
                                        ),
                                        ColorBar(title: "Advice", value: _dataModel!.intentionSplit.advice, color: colors[0]),
                                        ColorBar(title: "Cancelation", value: _dataModel!.intentionSplit.cancelation, color: colors[1]),
                                        ColorBar(title: "Complaint", value: _dataModel!.intentionSplit.complaint, color: colors[2]),
                                        ColorBar(title: "Information", value: _dataModel!.intentionSplit.information, color: colors[3]),
                                        ColorBar(title: "Purchase", value: _dataModel!.intentionSplit.purchase, color: colors[4]),
                                        ColorBar(
                                            title: "Recommendation", value: _dataModel!.intentionSplit.recommendation, color: colors[5]),
                                        ColorBar(title: "Support", value: _dataModel!.intentionSplit.support, color: colors[6]),
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                                    height: Helper.setHeight(context, height: 0.62),
                                    width: Helper.setWidth(context, width: 0.18),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                                      BoxShadow(blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))
                                    ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Emotion\nScore",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  _dataModel != null ? _dataModel!.emotionScore.toStringAsFixed(1) : "-",
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            AnimatedCircularChart(
                                              edgeStyle: SegmentEdgeStyle.round,
                                              size: const Size(150.0, 150.0),
                                              initialChartData: <CircularStackEntry>[
                                                CircularStackEntry(
                                                  [
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.anger.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.anger.toDouble(),
                                                        colors[0],
                                                        rankKey: '1'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.antipation.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.antipation.toDouble(),
                                                        colors[1],
                                                        rankKey: '2'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.disgust.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.disgust.toDouble(),
                                                        colors[2],
                                                        rankKey: '3'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.fear.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.fear.toDouble(),
                                                        colors[3],
                                                        rankKey: '4'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.joy.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.joy.toDouble(),
                                                        colors[4],
                                                        rankKey: '5'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.sadness.toString()) == 0
                                                            ? 0.0
                                                            : _dataModel!.emotionSplit.sadness.toDouble(),
                                                        colors[5],
                                                        rankKey: '6'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.surprise.toString()) == 0
                                                            ? 1.0
                                                            : _dataModel!.emotionSplit.surprise.toDouble(),
                                                        colors[6],
                                                        rankKey: '7'),
                                                    CircularSegmentEntry(
                                                        double.tryParse(_dataModel!.emotionSplit.trust.toString()) == 0
                                                            ? 1.0
                                                            : _dataModel!.emotionSplit.trust.toDouble(),
                                                        double.tryParse(_dataModel!.emotionSplit.trust.toString()) == 0
                                                            ? Colors.grey.shade300
                                                            : colors[7],
                                                        rankKey: '8'),
                                                  ],
                                                  rankKey: 'E Profits',
                                                ),
                                              ],
                                              chartType: CircularChartType.Radial,
                                            )
                                          ],
                                        ),
                                        ColorBar(title: "Anger", value: _dataModel!.emotionSplit.anger, color: colors[0]),
                                        ColorBar(title: "Antipation", value: _dataModel!.emotionSplit.antipation, color: colors[1]),
                                        ColorBar(title: "Disgust", value: _dataModel!.emotionSplit.disgust, color: colors[2]),
                                        ColorBar(title: "Fear", value: _dataModel!.emotionSplit.fear, color: colors[3]),
                                        ColorBar(title: "Joy", value: _dataModel!.emotionSplit.joy, color: colors[4]),
                                        ColorBar(title: "Sadness", value: _dataModel!.emotionSplit.sadness, color: colors[5]),
                                        ColorBar(title: "Surprise", value: _dataModel!.emotionSplit.surprise, color: colors[6]),
                                        ColorBar(title: "Trust", value: _dataModel!.emotionSplit.trust, color: colors[7]),
                                      ],
                                    )),

                                // BottomBox(
                                //   title: "Sentiment\nScore",
                                //   value: _dataModel != null ? _dataModel!.sentimentScore.toString() : "-",
                                //   splits: _dataModel != null ? _dataModel!.sentimentSplit.toJson() : {},
                                // ),
                                // BottomBox(
                                //   title: "Intention\nScore",
                                //   value: _dataModel != null ? _dataModel!.intentionScore.toString() : "-",
                                //   splits: _dataModel != null ? _dataModel!.intentionSplit.toJson() : {},
                                // ),
                                // BottomBox(
                                //   title: "Emotion\nScore",
                                //   value: _dataModel != null ? _dataModel!.emotionScore.toString() : "-",
                                //   splits: _dataModel != null ? _dataModel!.emotionSplit.toJson() : {},
                                // )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Keywords",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              width: Helper.setWidth(context, width: 0.25),
                              height: Helper.setHeight(context, height: 0.3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade300,
                              ),
                              child: _dataModel!.keywords.isEmpty
                                  ? const Center(
                                      child: Text("No keywords available"),
                                    )
                                  : SingleChildScrollView(
                                      child: Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                                        for (String word in _dataModel!.keywords)
                                          Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.circular(32),
                                              ),
                                              child: Text(word))
                                      ]),
                                    ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              "Top Tweets",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              child: _dataModel!.topTweets.isEmpty
                                  ? const Center(
                                      child: Text("No Tweets available"),
                                    )
                                  : SizedBox(
                                      width: Helper.setWidth(context, width: 0.35),
                                      height: Helper.setHeight(context, height: 0.4),
                                      child: ListView.builder(
                                        itemCount: _dataModel!.topTweets.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          var tt = _dataModel!.topTweets[index];
                                          return Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(tt.tweet),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: SizedBox(
                                                    width: Helper.setWidth(context, width: 0.2),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.thumb_up),
                                                        Text(tt.likeCount.toString()),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        const Icon(Icons.remove_red_eye),
                                                        Text("Views ${tt.viewsCount}"),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        const Icon(Icons.replay_circle_filled_sharp),
                                                        Text("Retweets ${tt.retweetCount}"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future? getApiData(String searchKeywork) async {
    final String url = "https://warenenticllcbackend.youthinc23.repl.co/runSocialVox/$searchKeywork";
    http.Response res = await http.get(Uri.parse(url));
    log(res.statusCode.toString());
    log(res.body.toString());
    if (res.statusCode == 200) {
      return dataModelFromJson(res.body);
      // return dataModelFromJson(jsonEncode(dummyData));
    } else {
      return null;
    }
  }
}

class ColorBar extends StatelessWidget {
  final String title;
  final value;
  final color;
  const ColorBar({
    super.key,
    required this.title,
    this.value = 0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
            color: color,
            value: double.tryParse(value.toString()),
          )
        ],
      ),
    );
  }
}

// class BottomBox extends StatelessWidget {
//   final String title;
//   final String value;
//   final splits;
//   const BottomBox({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.splits,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.only(left: 10, right: 10),
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//         height: Helper.setHeight(context, height: 0.4),
//         width: Helper.setWidth(context, width: 0.18),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Colors.white,
//             boxShadow: [BoxShadow(blurRadius: 0.4, spreadRadius: 0.4, color: Colors.grey.shade300, offset: const Offset(1, 2))]),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     Text(
//                       value,
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ],
//                 ),
//                 AnimatedCircularChart(
//                   edgeStyle: SegmentEdgeStyle.round,
//                   size: const Size(150.0, 150.0),
//                   initialChartData: data,
//                   chartType: CircularChartType.Radial,
//                 )
//               ],
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 12),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Sentiment Score",
//                         style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//                       ),
//                       Text(
//                         "80.0%",
//                         style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   LinearProgressIndicator(
//                     backgroundColor: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.purple,
//                     value: 0.5,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
