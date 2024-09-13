# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**controllerInterviewInterviewSessionIdDelete**](DefaultApi.md#controllerinterviewinterviewsessioniddelete) | **DELETE** /interview/{interview_session_id} | Controller
[**controllerInterviewInterviewSessionIdPost**](DefaultApi.md#controllerinterviewinterviewsessionidpost) | **POST** /interview/{interview_session_id} | Controller
[**controllerInterviewPost**](DefaultApi.md#controllerinterviewpost) | **POST** /interview | Controller
[**controllerLoginPut**](DefaultApi.md#controllerloginput) | **PUT** /login | Controller


# **controllerInterviewInterviewSessionIdDelete**
> Object controllerInterviewInterviewSessionIdDelete(interviewSessionId)

Controller

### Example
```dart
import 'package:openapi/api.dart';

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

No authorization required

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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerInterviewPost**
> InterviewSession controllerInterviewPost(interviewSessionRequest)

Controller

### Example
```dart
import 'package:openapi/api.dart';

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

[**InterviewSession**](InterviewSession.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **controllerLoginPut**
> User controllerLoginPut(loginRequest)

Controller

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = DefaultApi();
final loginRequest = LoginRequest(); // LoginRequest | 

try {
    final result = api_instance.controllerLoginPut(loginRequest);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->controllerLoginPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

