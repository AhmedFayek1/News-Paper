
class News{
  String? title;
  String? publishedAt;
  String? urlToImage;

      News.fromJson(Map<String, dynamic> jsonData) {
      title: jsonData['title'];
      publishedAt: jsonData['publishedAt'];
      urlToImage: jsonData['urlToImage'];

  }

    Map<String, dynamic> toMap(News news) => {
    'title': news.title,
    'publishedAt': news.publishedAt,
    'urlToImage': news.urlToImage,
  };

  //   String encode(List<News> NewsArticles) => json.encode(
  //   NewsArticles
  //       .map<Map<String, dynamic>>((news) => News.toMap(news))
  //       .toList(),
  // );

     // List<News> decode(String NewsArticles) =>
     //  (json.decode(NewsArticles) as List<dynamic>)
     //      .map<News>((item) => News.fromJson(item))
     //      .toList();
}