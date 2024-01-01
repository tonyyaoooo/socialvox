// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  double emotionScore;
  EmotionSplit emotionSplit;
  double intentionScore;
  IntentionSplit intentionSplit;
  List<String> keywords;
  double sentimentScore;
  SentimentSplit sentimentSplit;
  double socialScore;
  List<double> socialScoreDiagram;
  List<TopTweet> topTweets;
  double totalTweets;
  List<double> volumeDiagram;

  DataModel({
    required this.emotionScore,
    required this.emotionSplit,
    required this.intentionScore,
    required this.intentionSplit,
    required this.keywords,
    required this.sentimentScore,
    required this.sentimentSplit,
    required this.socialScore,
    required this.socialScoreDiagram,
    required this.topTweets,
    required this.totalTweets,
    required this.volumeDiagram,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        emotionScore: json["emotion_score"],
        emotionSplit: EmotionSplit.fromJson(json["emotion_split"]),
        intentionScore: json["intention_score"],
        intentionSplit: IntentionSplit.fromJson(json["intention_split"]),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        sentimentScore: json["sentiment_score"]?.toDouble(),
        sentimentSplit: SentimentSplit.fromJson(json["sentiment_split"]),
        socialScore: json["social_score"],
        socialScoreDiagram: List<double>.from(json["social_score_diagram"].map((x) => x)),
        topTweets: List<TopTweet>.from(json["top_tweets"].map((x) => TopTweet.fromJson(x))),
        totalTweets: json["total_tweets"],
        volumeDiagram: List<double>.from(json["volume_diagram"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "emotion_score": emotionScore,
        "emotion_split": emotionSplit.toJson(),
        "intention_score": intentionScore,
        "intention_split": intentionSplit.toJson(),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "sentiment_score": sentimentScore,
        "sentiment_split": sentimentSplit.toJson(),
        "social_score": socialScore,
        "social_score_diagram": List<dynamic>.from(socialScoreDiagram.map((x) => x)),
        "top_tweets": List<dynamic>.from(topTweets.map((x) => x.toJson())),
        "total_tweets": totalTweets,
        "volume_diagram": List<dynamic>.from(volumeDiagram.map((x) => x)),
      };
}

class EmotionSplit {
  int anger;
  int antipation;
  int disgust;
  int fear;
  int joy;
  int sadness;
  int surprise;
  int trust;

  EmotionSplit({
    required this.anger,
    required this.antipation,
    required this.disgust,
    required this.fear,
    required this.joy,
    required this.sadness,
    required this.surprise,
    required this.trust,
  });

  factory EmotionSplit.fromJson(Map<String, dynamic> json) => EmotionSplit(
        anger: json["Anger"],
        antipation: json["Antipation"],
        disgust: json["Disgust"],
        fear: json["Fear"],
        joy: json["Joy"],
        sadness: json["Sadness"],
        surprise: json["Surprise"],
        trust: json["Trust"],
      );

  Map<String, dynamic> toJson() => {
        "Anger": anger,
        "Antipation": antipation,
        "Disgust": disgust,
        "Fear": fear,
        "Joy": joy,
        "Sadness": sadness,
        "Surprise": surprise,
        "Trust": trust,
      };
}

class IntentionSplit {
  int advice;
  int cancelation;
  int complaint;
  int information;
  int purchase;
  int recommendation;
  int support;

  IntentionSplit({
    required this.advice,
    required this.cancelation,
    required this.complaint,
    required this.information,
    required this.purchase,
    required this.recommendation,
    required this.support,
  });

  factory IntentionSplit.fromJson(Map<String, dynamic> json) => IntentionSplit(
        advice: json["Advice"],
        cancelation: json["Cancelation"],
        complaint: json["Complaint"],
        information: json["Information"],
        purchase: json["Purchase"],
        recommendation: json["Recommendation"],
        support: json["Support"],
      );

  Map<String, dynamic> toJson() => {
        "Advice": advice,
        "Cancelation": cancelation,
        "Complaint": complaint,
        "Information": information,
        "Purchase": purchase,
        "Recommendation": recommendation,
        "Support": support,
      };
}

class SentimentSplit {
  int extremelyNegative;
  int extremelyPositive;
  int negative;
  int neutral;
  int none;
  int positive;

  SentimentSplit({
    required this.extremelyNegative,
    required this.extremelyPositive,
    required this.negative,
    required this.neutral,
    required this.none,
    required this.positive,
  });

  factory SentimentSplit.fromJson(Map<String, dynamic> json) => SentimentSplit(
        extremelyNegative: json["Extremely Negative"],
        extremelyPositive: json["Extremely Positive"],
        negative: json["Negative"],
        neutral: json["Neutral"],
        none: json["None"],
        positive: json["Positive"],
      );

  Map<String, dynamic> toJson() => {
        "Extremely Negative": extremelyNegative,
        "Extremely Positive": extremelyPositive,
        "Negative": negative,
        "Neutral": neutral,
        "None": none,
        "Positive": positive,
      };
}

class TopTweet {
  dynamic date;
  int likeCount;
  int retweetCount;
  String tweet;
  int viewsCount;

  TopTweet({
    required this.date,
    required this.likeCount,
    required this.retweetCount,
    required this.tweet,
    required this.viewsCount,
  });

  factory TopTweet.fromJson(Map<String, dynamic> json) => TopTweet(
        date: json["date"],
        likeCount: json["like_count"],
        retweetCount: json["retweet_count"],
        tweet: json["tweet"],
        viewsCount: json["views_count"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "like_count": likeCount,
        "retweet_count": retweetCount,
        "tweet": tweet,
        "views_count": viewsCount,
      };
}
