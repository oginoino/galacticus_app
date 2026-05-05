import 'package:flutter/foundation.dart';

import '../di/di.dart';
import '../domain/post_detail_overview.dart';
import '../repository/post_detail_repository.dart';
import '../util/const/app_constants.dart';

class PostDetailProvider extends ChangeNotifier {
  PostDetailProvider(this._repository);

  final PostDetailRepository _repository;

  PostDetailOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  PostDetailOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPost({String? id}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _overview = await _repository.getPostDetail(id: id);
    } catch (_) {
      _errorMessage = sl<AppConstants>().postDetailLoadErrorMessage;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
