@IsTest
private class HttpRequestBuilderTest {
  private static final String API_URL = 'icanhazdadjoke.com';

  private static final String BODY_TEXT = 'body text';
  private static final Blob BODY_BLOB = Blob.valueOf(BODY_TEXT);
  private static final Dom.Document BODY_DOM = new Dom.Document();

  private static final String CERT_NAME = 'anystring';
  private static final Map<String, String> HEADERS;
  private static final Integer WAIT_MS = 1000 * 120;

  private static final String HEADER_KEY_ACCEPT = 'Accept';
  private static final String HEADER_KEY_AUTHORIZATION = 'Authorization';
  private static final String HEADER_KEY_ACCEPT_LANGUAGE = 'Accept-Language';

  private static final String HEADER_VALUE_ACCEPT = 'application/json';
  private static final String HEADER_VALUE_AUTHORIZATION = 'Bearer token';
  private static final String HEADER_VALUE_ACCEPT_LANGUAGE = 'en-US';

  static {
    HEADERS = new Map<String, String> {
      HEADER_KEY_AUTHORIZATION => HEADER_VALUE_AUTHORIZATION,
      HEADER_KEY_ACCEPT_LANGUAGE => HEADER_VALUE_ACCEPT_LANGUAGE
    };
  }

  @IsTest
  static void it_should_throw_when_builder_is_used_more_than_once() {
    Boolean isSucess = false;

    HttpRequestBuilder builder = new HttpRequestBuilder();
    HttpRequest req = builder
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .build();

    try {

      builder.build();
      System.Assert.fail();

    } catch(HttpRequestBuilderException bex) {
      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSucess = true;
    }

    System.Assert.isTrue(isSucess);
  }

  @IsTest
  static void it_should_build_when_provided_all_inputs() {
    HttpRequest req = new HttpRequestBuilder()
      .setBody(BODY_TEXT)
      .setClientCertificateName(CERT_NAME)
      .setCompressed(true)
      .setEndpoint(API_URL)
      .setHeader(HEADER_KEY_ACCEPT, HEADER_VALUE_ACCEPT)
      .setHeaders(headers)
      .setMethod(HttpMethod.DEL)
      .setTimeout(1000 * 120)
      .build();

    System.Assert.areEqual(BODY_TEXT, req.getBody());
    System.Assert.areEqual(true, req.getCompressed());
    System.Assert.areEqual(API_URL, req.getEndpoint());
    System.Assert.areEqual(HEADER_VALUE_ACCEPT, req.getHeader(HEADER_KEY_ACCEPT));
    System.Assert.areEqual(HEADER_VALUE_AUTHORIZATION, req.getHeader(HEADER_KEY_AUTHORIZATION));
    System.Assert.areEqual(HEADER_VALUE_ACCEPT_LANGUAGE, req.getHeader(HEADER_KEY_ACCEPT_LANGUAGE));
    System.Assert.areEqual('DELETE', req.getMethod());
  }

  @IsTest
  static void it_should_set_body_text() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setBody(BODY_TEXT)
      .build();

    System.Assert.areEqual(BODY_TEXT, req.getBody());
  }

  @IsTest
  static void it_should_set_body_blob() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setBodyAsBlob(BODY_BLOB)
      .build();

    System.Assert.areEqual(BODY_BLOB, req.getBodyAsBlob());
  }

  @IsTest
  static void it_should_set_body_document() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setBodyDocument(BODY_DOM)
      .build();

    System.Assert.areEqual(BODY_DOM, req.getBodyDocument());
  }

  @IsTest
  static void it_should_throw_when_setting_body_blob_when_body_text_is_set() {
    Boolean isSuccess = false;

    try {
      HttpRequest req = new HttpRequestBuilder()
        .setEndpoint(API_URL)
        .setMethod(HttpMethod.GET)
        .setBody(BODY_TEXT)
        .setBodyAsBlob(BODY_BLOB)
        .build();
      System.Assert.fail('It should throw on setBodyAsBlob because setBody was already called.');

    } catch(HttpRequestBuilderException bex) {
      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_throw_when_setting_body_text_when_body_blob_is_set() {
    Boolean isSuccess = false;

    try {
      HttpRequest req = new HttpRequestBuilder()
        .setEndpoint(API_URL)
        .setMethod(HttpMethod.GET)
        .setBodyAsBlob(BODY_BLOB)
        .setBody(BODY_TEXT)
        .build();
      System.Assert.fail('It should throw on setBody because setBodyAsBlob was already called.');

    } catch(HttpRequestBuilderException bex) {
      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_throw_when_setting_body_dom_when_body_text_is_set() {
    Boolean isSuccess = false;

    try {
      HttpRequest req = new HttpRequestBuilder()
        .setEndpoint(API_URL)
        .setMethod(HttpMethod.GET)
        .setBody(BODY_TEXT)
        .setBodyDocument(BODY_DOM)
        .build();
      System.Assert.fail('It should throw on setBodyDocument because setBody was already called.');

    } catch(HttpRequestBuilderException bex) {
      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_default_to_compressed_false() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .build();

    System.Assert.isFalse(req.getCompressed());
  }

  @IsTest
  static void it_should_set_is_compressed() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setCompressed(true)
      .build();

    System.Assert.isTrue(req.getCompressed());
  }

  @IsTest
  static void it_should_set_endpoint() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .build();

    System.Assert.areEqual(API_URL, req.getEndpoint());
  }

  @IsTest
  static void it_should_throw_when_endpoint_is_blank() {
    Boolean isSuccess = false;
    try {
      HttpRequest req = new HttpRequestBuilder().build();

      System.Assert.fail('It should throw on HttpRequestBuilder.build because Endpoint is required.');
    } catch(HttpRequestBuilderException bex) {

      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }

  @IsTest
  static void it_should_set_one_header() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setHeader(HEADER_KEY_ACCEPT, HEADER_VALUE_ACCEPT)
      .build();

    System.Assert.areEqual(HEADER_VALUE_ACCEPT, req.getHeader(HEADER_KEY_ACCEPT));
  }

  @IsTest
  static void it_should_set_multiple_headers() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.GET)
      .setHeaders(headers)
      .setHeader(HEADER_KEY_ACCEPT, HEADER_VALUE_ACCEPT)
      .build();

    System.Assert.areEqual(HEADER_VALUE_ACCEPT, req.getHeader(HEADER_KEY_ACCEPT));
    System.Assert.areEqual(HEADER_VALUE_AUTHORIZATION, req.getHeader(HEADER_KEY_AUTHORIZATION));
    System.Assert.areEqual(HEADER_VALUE_ACCEPT_LANGUAGE, req.getHeader(HEADER_KEY_ACCEPT_LANGUAGE));
  }

  @IsTest
  static void it_should_set_method() {
    HttpRequest req = new HttpRequestBuilder()
      .setEndpoint(API_URL)
      .setMethod(HttpMethod.DEL)
      .build();

    System.Assert.areEqual('DELETE', req.getMethod());
  }

  @IsTest
  static void it_should_throw_when_http_method_is_null() {
    Boolean isSuccess = false;
    try {
      HttpRequest req = new HttpRequestBuilder()
        .setEndpoint(API_URL)
        .setMethod(null)
        .build();

      System.Assert.fail('It should throw on HttpRequestBuilder.build because method is null');
    } catch(HttpRequestBuilderException bex) {

      System.Assert.isInstanceOfType(bex, HttpRequestBuilderException.class);
      isSuccess = true;
    }

    System.Assert.isTrue(isSuccess);
  }
}