@IsTest
private class HttpClientTest {
  private static final String CONFIG_DEFAULT = 'DEFAULT';

  private static final String API_URL = 'https://some.com';
  private static final String PATH = 'some/path';
  private static HttpResponse mockResponse = new HttpResponse();

  @IsTest
  static void it_should_construct_with_path() {
    HttpClient client = new HttpClient(API_URL);
    System.Assert.isNotNull(client);
  }

  @IsTest
  static void it_should_construct_with_path_and_config() {
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    System.Assert.isNotNull(client);
  }

  @IsTest
  static void it_should_throw_when_mdtname_is_invalid() {

    Boolean isSuccess = false;
    try {
      HttpClient client = new HttpClient(API_URL, 'invalidname');
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, RuntimeException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_succeed_when_delete_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    Test.setMock(HttpCalloutMock.class, mock);

    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    HttpResponse res = client.del(PATH);

    System.Assert.isNotNull(res);
  }

  @IsTest
  static void it_should_throw_when_delete_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    mock.isForceThrow = true;
    Test.setMock(HttpCalloutMock.class, mock);

    Boolean isSuccess = false;
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    try {
      HttpResponse res = client.del(PATH);
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, CalloutException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_succeed_when_get_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    Test.setMock(HttpCalloutMock.class, mock);

    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    HttpResponse res = client.get();

    System.Assert.isNotNull(res);
  }

  @IsTest
  static void it_should_throw_when_get_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    mock.isForceThrow = true;
    Test.setMock(HttpCalloutMock.class, mock);

    Boolean isSuccess = false;
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    try {
      HttpResponse res = client.get();
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, CalloutException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_succeed_when_patch_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    Test.setMock(HttpCalloutMock.class, mock);

    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    HttpResponse res = client.patch(PATH, new Account());

    System.Assert.isNotNull(res);
  }

  @IsTest
  static void it_should_throw_when_patch_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    mock.isForceThrow = true;
    Test.setMock(HttpCalloutMock.class, mock);

    Boolean isSuccess = false;
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    try {
      HttpResponse res = client.patch(PATH, new Account());
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, CalloutException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_succeed_when_post_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    Test.setMock(HttpCalloutMock.class, mock);

    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    HttpResponse res = client.post(PATH, new Account());

    System.Assert.isNotNull(res);
  }

  @IsTest
  static void it_should_throw_when_post_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    mock.isForceThrow = true;
    Test.setMock(HttpCalloutMock.class, mock);

    Boolean isSuccess = false;
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    try {
      HttpResponse res = client.post(PATH, new Account());
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, CalloutException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_succeed_when_put_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    Test.setMock(HttpCalloutMock.class, mock);

    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    HttpResponse res = client.put(PATH, new Account());

    System.Assert.isNotNull(res);
  }

  @IsTest
  static void it_should_throw_when_put_is_called() {
    HttpClientMock mock = new HttpClientMock(mockResponse);
    mock.isForceThrow = true;
    Test.setMock(HttpCalloutMock.class, mock);

    Boolean isSuccess = false;
    HttpClient client = new HttpClient(API_URL, CONFIG_DEFAULT);
    try {
      HttpResponse res = client.put(PATH, new Account());
      System.Assert.fail('It should throw.');
    } catch(Exception exc) {
      System.Assert.isInstanceOfType(exc, CalloutException.class, String.valueOf(exc));
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_build_url_with_query_params() {
    String expectedUrl = 'https://some.com/some/path?galantis=damn&david=guetta&ft=mnek';
    Map<String, String> params = new Map<String, String> {
      'galantis' => 'damn',
      'david' => 'guetta',
      'ft' => 'mnek'
    };
    String actualUrl = new HttpClient('https://some.com/', 'DEFAULT').buildUrl('/some/path/', params);

    System.Assert.areEqual(expectedUrl, actualUrl);
  }

  @IsTest
  static void it_should_build_url_with_additional_query_params() {
    String expectedUrl = 'https://some.com/some/path?galantis=damn&david=guetta&ft=mnek';
    Map<String, String> params = new Map<String, String> {
      'david' => 'guetta',
      'ft' => 'mnek'
    };
    String actualUrl = new HttpClient('https://some.com/', 'DEFAULT').buildUrl('/some/path?galantis=damn', params);

    System.Assert.areEqual(expectedUrl, actualUrl);
  }
}
