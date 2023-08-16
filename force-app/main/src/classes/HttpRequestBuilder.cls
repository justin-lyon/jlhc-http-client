public  class HttpRequestBuilder {
  private static final Integer WAIT_DEFAULT = 1000 * 10;
  private static final String ERROR_HAS_BUILT = 'Cannot use the same builder instance twice!';
  private static final String ERROR_BODY_ALREADY_DEFINED = 'Body is already defined.';
  private static final String TEMPLATE_MISSING_PROPERTY = 'Missing required property: {0}.';
  private Boolean hasBuilt = false;

  @TestVisible
  private HttpRequest req;

  private String bodyString;
  private Blob bodyBlob;
  private Dom.Document bodyDom;

  private String clientCertName;

  private Boolean isCompressed = false;
  private String url;

  private Map<String, String> headers;
  // private HttpMethod method = HttpMethod.GET;
  private HttpMethod method;
  private Integer wait_ms = WAIT_DEFAULT;

  public HttpRequest build() {
    // Validate
    if (hasBuilt) {
      throw new HttpRequestBuilderException(ERROR_HAS_BUILT);
    }

    if (method == null) {
      String message = String.format(TEMPLATE_MISSING_PROPERTY, new List<String> { 'Http Method' });
      throw new HttpRequestBuilderException(message);
    }

    if (String.isBlank(url)) {
      String message = String.format(TEMPLATE_MISSING_PROPERTY, new List<String> { 'Endpoint' });
      throw new HttpRequestBuilderException(message);
    }

    // Build
    req = new HttpRequest();
    req.setEndpoint(url);
    req.setCompressed(isCompressed);
    req.setTimeout(wait_ms);

    this.buildHttpMethod();
    this.buildClientCertificate();
    this.buildHttpRequestHeaders();
    this.buildBody();

    // Return
    hasBuilt = true;
    return req;
  }

  public HttpRequestBuilder setBody(final String body) {
    if (bodyBlob != null || bodyDom != null) {
      throw new HttpRequestBuilderException(ERROR_BODY_ALREADY_DEFINED);
    }

    this.bodyString = body;
    return this;
  }

  public HttpRequestBuilder setBodyAsBlob(final Blob body) {
    if (!String.isBlank(bodyString) || bodyDom != null) {
      throw new HttpRequestBuilderException(ERROR_BODY_ALREADY_DEFINED);
    }

    this.bodyBlob = body;
    return this;
  }

  public HttpRequestBuilder setBodyDocument(final Dom.Document body) {
    if (bodyBlob != null || !String.isBlank(bodyString)) {
      throw new HttpRequestBuilderException(ERROR_BODY_ALREADY_DEFINED);
    }

    this.bodyDom = body;
    return this;
  }

  public HttpRequestBuilder setClientCertificateName(final String certDevName) {
    this.clientCertName = certDevName;
    return this;
  }

  public HttpRequestBuilder setCompressed(boolean isCompressed) {
    this.isCompressed = isCompressed;
    return this;
  }

  public HttpRequestBuilder setEndpoint(final String uri) {
    this.url = uri;
    return this;
  }

  public HttpRequestBuilder setHeader(final String key, final String value) {
    this.initHeaderMap();
    this.headers.put(key, value);

    return this;
  }

  public HttpRequestBuilder setHeaders(Map<String, String> headers) {
    if (headers == null || headers.isEmpty()) {
      return this;
    }

    this.initHeaderMap();
    this.headers.putAll(headers);

    return this;
  }

  public HttpRequestBuilder setMethod(final HttpMethod method) {
    this.method = method;
    return this;
  }

  public HttpRequestBuilder setTimeout(Integer wait_ms) {
    this.wait_ms = wait_ms;
    return this;
  }

  private void buildBody() {
    if (String.isBlank(this.bodyString) && this.bodyBlob == null && this.bodyDom == null) {
      return;
    }

    if (String.isNotBlank(this.bodyString)) {
      this.req.setBody(this.bodyString);
      return;
    }

    if(this.bodyBlob != null) {
      this.req.setBodyAsBlob(this.bodyBlob);
      return;
    }

    if (this.bodyDom != null) {
      this.req.setBodyDocument(this.bodyDom);
    }
  }

  private void buildHttpRequestHeaders() {
    if (this.headers == null || this.headers.isEmpty()) {
      return;
    }

    for (String key : headers.keySet()) {
      String value = headers.get(key);
      this.req.setHeader(key, value);
    }
  }

  private void buildClientCertificate() {
    if (String.isBlank(this.clientCertName)) {
      return;
    }

    if (Test.isRunningTest()) {
      // Runtime error if no Certificate found in config by Certificate Developer Name
      return;
    }

    this.req.setClientCertificateName(this.clientCertName);
  }

  private void buildHttpMethod() {
    String methodName = this.method.name();
    if (this.method == HttpMethod.DEL) {
      methodName = 'DELETE';
    }

    if (this.method == HttpMethod.GET) {
      methodName = 'GET';
    }

    this.req.setMethod(methodName);
  }

  private void initHeaderMap() {
    if (this.headers == null) {
      this.headers = new Map<String, String>();
    }
  }
}