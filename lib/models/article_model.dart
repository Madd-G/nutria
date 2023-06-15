class ArticleModel {
  List<Article>? articles;

  ArticleModel({this.articles});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      articles = <Article>[];
      json['data'].forEach((v) {
        articles!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> articles = <String, dynamic>{};
    if (this.articles != null) {
      articles['data'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return articles;
  }
}

class Article {
  String? id;
  String? image;
  String? profileImage;
  String? pictureDescription;
  String? title;
  String? introduction;
  String? article;
  String? category;
  String? author;
  String? date;

  Article({
    this.id,
    this.image,
    this.profileImage,
    this.pictureDescription,
    this.title,
    this.introduction,
    this.article,
    this.category,
    this.author,
    this.date,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    profileImage = json['profile-image'];
    pictureDescription = json['picture-description'];
    title = json['title'];
    introduction = json['introduction'];
    article = json['article'];
    category = json['category'];
    author = json['author'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['profile-image'] = profileImage;
    data['picture-description'] = pictureDescription;
    data['title'] = title;
    data['introduction'] = introduction;
    data['article'] = article;
    data['category'] = category;
    data['author'] = author;
    data['date'] = date;
    return data;
  }
}