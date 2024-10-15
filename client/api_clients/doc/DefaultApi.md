# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**controllerInterviewInterviewSessionIdAnalyticsGet**](DefaultApi.md#controllerinterviewinterviewsessionidanalyticsget) | **GET** /interview/{interview_session_id}/analytics | Controller
[**controllerInterviewInterviewSessionIdDelete**](DefaultApi.md#controllerinterviewinterviewsessioniddelete) | **DELETE** /interview/{interview_session_id} | Controller
[**controllerInterviewInterviewSessionIdPost**](DefaultApi.md#controllerinterviewinterviewsessionidpost) | **POST** /interview/{interview_session_id} | Controller
[**controllerInterviewPost**](DefaultApi.md#controllerinterviewpost) | **POST** /interview | Controller
[**controllerLoginGet**](DefaultApi.md#controllerloginget) | **GET** /login | Controller
[**controllerOauth2CallbackGet**](DefaultApi.md#controlleroauth2callbackget) | **GET** /oauth2/callback | Controller
[**controllerTeachersGet**](DefaultApi.md#controllerteachersget) | **GET** /teachers | Controller
[**controllerUsersGet**](DefaultApi.md#controllerusersget) | **GET** /users | Controller


# **controllerInterviewInterviewSessionIdAnalyticsGet**
> InterviewAnalytics controllerInterviewInterviewSessionIdAnalyticsGet(interviewSessionId)

Controller

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DefaultApi();
final interviewSessionId = interviewSessionId_example; // String | 

try {
    final result = api_instance.controllerInterviewInterviewSessionIdAnalyticsGet(interviewSessionId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerInterviewInterviewSessionIdAnalyticsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **interviewSessionId** | **String**|  | 

### Return type

[**InterviewAnalytics**](InterviewAnalytics.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerInterviewInterviewSessionIdDelete**
> Object controllerInterviewInterviewSessionIdDelete(interviewSessionId)

Controller

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DefaultApi();
final interviewSessionId = interviewSessionId_example; // String | 

try {
    final result = api_instance.controllerInterviewInterviewSessionIdDelete(interviewSessionId);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerInterviewInterviewSessionIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **interviewSessionId** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerInterviewInterviewSessionIdPost**
> TeacherResponse controllerInterviewInterviewSessionIdPost(interviewSessionId, speakToTeacherRequest)

Controller

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DefaultApi();
final interviewSessionId = interviewSessionId_example; // String | 
final speakToTeacherRequest = SpeakToTeacherRequest(); // SpeakToTeacherRequest | 

try {
    final result = api_instance.controllerInterviewInterviewSessionIdPost(interviewSessionId, speakToTeacherRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerInterviewInterviewSessionIdPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **interviewSessionId** | **String**|  | 
 **speakToTeacherRequest** | [**SpeakToTeacherRequest**](SpeakToTeacherRequest.md)|  | 

### Return type

[**TeacherResponse**](TeacherResponse.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerInterviewPost**
> StartInterviewResponse controllerInterviewPost(interviewSessionRequest)

Controller

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: HTTPBearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('HTTPBearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DefaultApi();
final interviewSessionRequest = InterviewSessionRequest(); // InterviewSessionRequest | 

try {
    final result = api_instance.controllerInterviewPost(interviewSessionRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerInterviewPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **interviewSessionRequest** | [**InterviewSessionRequest**](InterviewSessionRequest.md)|  | 

### Return type

[**StartInterviewResponse**](StartInterviewResponse.md)

### Authorization

[HTTPBearer](../README.md#HTTPBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerLoginGet**
> Object controllerLoginGet()

Controller

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.controllerLoginGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerLoginGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerOauth2CallbackGet**
> Object controllerOauth2CallbackGet(code)

Controller

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final code = code_example; // String | 

try {
    final result = api_instance.controllerOauth2CallbackGet(code);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerOauth2CallbackGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerTeachersGet**
> TeachersListResponse controllerTeachersGet()

Controller

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.controllerTeachersGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerTeachersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**TeachersListResponse**](TeachersListResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerUsersGet**
> List<User> controllerUsersGet()

Controller

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.controllerUsersGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerUsersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<User>**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

