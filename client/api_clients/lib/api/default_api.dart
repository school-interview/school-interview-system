//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DefaultApi {
  DefaultApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  Future<Response>
      controllerInterviewInterviewSessionIdAnalyticsGetWithHttpInfo(
    String interviewSessionId,
    String idToken,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/interview/{interview_session_id}/analytics'
        .replaceAll('{interview_session_id}', interviewSessionId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  Future<InterviewAnalytics?> controllerInterviewInterviewSessionIdAnalyticsGet(
    String interviewSessionId,
    String idToken,
  ) async {
    final response =
        await controllerInterviewInterviewSessionIdAnalyticsGetWithHttpInfo(
      interviewSessionId,
      idToken,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'InterviewAnalytics',
      ) as InterviewAnalytics;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  Future<Response> controllerInterviewInterviewSessionIdDeleteWithHttpInfo(
    String interviewSessionId,
    String idToken,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/interview/{interview_session_id}'
        .replaceAll('{interview_session_id}', interviewSessionId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  Future<Object?> controllerInterviewInterviewSessionIdDelete(
    String interviewSessionId,
    String idToken,
  ) async {
    final response =
        await controllerInterviewInterviewSessionIdDeleteWithHttpInfo(
      interviewSessionId,
      idToken,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Object',
      ) as Object;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  ///
  /// * [SpeakToTeacherRequest] speakToTeacherRequest (required):
  Future<Response> controllerInterviewInterviewSessionIdPostWithHttpInfo(
    String interviewSessionId,
    SpeakToTeacherRequest speakToTeacherRequest,
    String idToken,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/interview/{interview_session_id}'
        .replaceAll('{interview_session_id}', interviewSessionId);

    // ignore: prefer_final_locals
    Object? postBody = speakToTeacherRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  ///
  /// * [SpeakToTeacherRequest] speakToTeacherRequest (required):
  Future<TeacherResponse?> controllerInterviewInterviewSessionIdPost(
    String interviewSessionId,
    SpeakToTeacherRequest speakToTeacherRequest,
    String idToken,
  ) async {
    final response =
        await controllerInterviewInterviewSessionIdPostWithHttpInfo(
      interviewSessionId,
      speakToTeacherRequest,
      idToken,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TeacherResponse',
      ) as TeacherResponse;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [InterviewSessionRequest] interviewSessionRequest (required):
  Future<Response> controllerInterviewPostWithHttpInfo(
    InterviewSessionRequest interviewSessionRequest,
    String idToken,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/interview';

    // ignore: prefer_final_locals
    Object? postBody = interviewSessionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [InterviewSessionRequest] interviewSessionRequest (required):
  Future<StartInterviewResponse?> controllerInterviewPost(
    InterviewSessionRequest interviewSessionRequest,
    String idToken,
  ) async {
    final response = await controllerInterviewPostWithHttpInfo(
      interviewSessionRequest,
      idToken,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'StartInterviewResponse',
      ) as StartInterviewResponse;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> controllerInterviewReportsGetWithHttpInfo(
      String idToken) async {
    // ignore: prefer_const_declarations
    final path = r'/interview-reports';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  Future<InterviewReportsResponse?> controllerInterviewReportsGet(
      String idToken) async {
    final response = await controllerInterviewReportsGetWithHttpInfo(idToken);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'InterviewReportsResponse',
      ) as InterviewReportsResponse;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> controllerLoginGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/login';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  Future<Object?> controllerLoginGet() async {
    final response = await controllerLoginGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Object',
      ) as Object;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> controllerMeGetWithHttpInfo(String idToken) async {
    // ignore: prefer_const_declarations
    final path = r'/me';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  Future<User?> controllerMeGet(String idToken) async {
    final response = await controllerMeGetWithHttpInfo(idToken);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'User',
      ) as User;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] code (required):
  Future<Response> controllerOauth2CallbackGetWithHttpInfo(
    String code,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/oauth2/callback';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'code', code));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [String] code (required):
  Future<LoginResult?> controllerOauth2CallbackGet(
    String code,
  ) async {
    final response = await controllerOauth2CallbackGetWithHttpInfo(
      code,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'LoginResult',
      ) as LoginResult;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> controllerTeachersGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/teachers';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  Future<TeachersListResponse?> controllerTeachersGet() async {
    final response = await controllerTeachersGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TeachersListResponse',
      ) as TeachersListResponse;
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> controllerUsersGetWithHttpInfo(String idToken) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  Future<List<User>?> controllerUsersGet(String idToken) async {
    final response = await controllerUsersGetWithHttpInfo(idToken);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<User>')
              as List)
          .cast<User>()
          .toList(growable: false);
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [StudentUpdate] studentUpdate (required):
  Future<Response> controllerUsersUserIdStudentPutWithHttpInfo(
    String userId,
    StudentUpdate studentUpdate,
    String idToken,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{user_id}/student'.replaceAll('{user_id}', userId);

    // ignore: prefer_final_locals
    Object? postBody = studentUpdate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $idToken'};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Controller
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [StudentUpdate] studentUpdate (required):
  Future<Student?> controllerUsersUserIdStudentPut(
    String userId,
    StudentUpdate studentUpdate,
    String idToken,
  ) async {
    final response = await controllerUsersUserIdStudentPutWithHttpInfo(
      userId,
      studentUpdate,
      idToken,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Student',
      ) as Student;
    }
    return null;
  }
}
