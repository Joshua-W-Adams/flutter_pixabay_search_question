class PixabayResultsModel {
  final int? total;
  final int? totalHits;
  final List<PixabayMediaModel>? hits;

  PixabayResultsModel({
    this.total,
    this.totalHits,
    this.hits,
  });

  factory PixabayResultsModel.fromMap(Map<String, dynamic> data) {
    // TODO - Step 2 - implement pixabay results model

    return PixabayResultsModel();
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'totalHits': totalHits,
      'hits': hits?.map((hit) {
        return hit.toMap();
      }).toList(),
    };
  }
}

class PixabayMediaModel {
  final int? id;
  final String? tags;
  final String? webformatURL;
  final String? user;

  PixabayMediaModel({
    this.id,
    this.tags,
    this.webformatURL,
    this.user,
  });

  factory PixabayMediaModel.fromMap(Map<String, dynamic> data) {
    // TODO - Step 3 - implement pixabay media model

    return PixabayMediaModel();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tags': tags,
      'webformatURL': webformatURL,
      'user': user,
    };
  }
}
