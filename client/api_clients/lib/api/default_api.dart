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
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] interviewSessionId (required):
  Future<Response> controllerInterviewInterviewSessionIdDeleteWithHttpInfo(String interviewSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/interview/{interview_session_id}'
      .replaceAll('{interview_session_id}', interviewSessionId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
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
  Future<Object?> controllerInterviewInterviewSessionIdDelete(String interviewSessionId,) async {
    final response = await controllerInterviewInterviewSessionIdDeleteWithHttpInfo(interviewSessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
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
  Future<Response> controllerInterviewInterviewSessionIdPostWithHttpInfo(String interviewSessionId, SpeakToTeacherRequest speakToTeacherRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/interview/{interview_session_id}'
      .replaceAll('{interview_session_id}', interviewSessionId);

    // ignore: prefer_final_locals
    Object? postBody = speakToTeacherRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
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
  Future<TeacherResponse?> controllerInterviewInterviewSessionIdPost(String interviewSessionId, SpeakToTeacherRequest speakToTeacherRequest,) async {
    final response = await controllerInterviewInterviewSessionIdPostWithHttpInfo(interviewSessionId, speakToTeacherRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TeacherResponse',) as TeacherResponse;
    
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
  Future<Response> controllerInterviewPostWithHttpInfo(InterviewSessionRequest interviewSessionRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/interview';

    // ignore: prefer_final_locals
    Object? postBody = interviewSessionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
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
  Future<InterviewSession?> controllerInterviewPost(InterviewSessionRequest interviewSessionRequest,) async {
    final response = await controllerInterviewPostWithHttpInfo(interviewSessionRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'InterviewSession',) as InterviewSession;
    
    }
    return null;
  }

  /// Controller
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LoginRequest] loginRequest (required):
  Future<Response> controllerLoginPutWithHttpInfo(LoginRequest loginRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/login';

    // ignore: prefer_final_locals
    Object? postBody = loginRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
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
  /// * [LoginRequest] loginRequest (required):
  Future<User?> controllerLoginPut(LoginRequest loginRequest,) async {
    final response = await controllerLoginPutWithHttpInfo(loginRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }
}