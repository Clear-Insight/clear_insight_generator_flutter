import 'package:http/http.dart';

class ClearInsightHttpClient extends BaseClient {
  ClearInsightHttpClient({required Client inner, required String projectId})
      : _inner = inner,
        _projectId = projectId;

  final Client _inner;
  final String _projectId;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['x-clear-insight-project-id'] = _projectId;
    return _inner.send(request);
  }
}
