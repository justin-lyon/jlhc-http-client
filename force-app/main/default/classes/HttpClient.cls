global class HttpClient {
  private String baseUrl;

  @TestVisible
  private HttpConfig config;

  private HttpConfigService configService = new HttpConfigService();

  global HttpClient(final String baseUrl) {
    this(baseUrl, 'DEFAULT');
  }

  global HttpClient(final String baseUrl, final String configName) {
    this.baseUrl = baseUrl;
    this.config = cascadeConfigs(configName);
  }

  // *** HTTP Methods ***
  // *** DELETE ***
  global HttpResponse del(final String path) {
    return this.del(path, null);
  }

  global HttpResponse del(final String path, HttpConfig options) {
    return this.call(HttpMethod.DEL, path, null, options);
  }

  // *** GET ***
  global HttpResponse get() {
    return this.get('');
  }

  global HttpResponse get(HttpConfig options) {
    return this.get('', options);
  }

  global HttpResponse get(final String path) {
    return this.get(path, null);
  }

  global HttpResponse get(final String path, HttpConfig options) {
    return this.call(HttpMethod.GET, path, null, options);
  }

  // *** PATCH ***
  global HttpResponse patch(final String path, Object body) {
    return this.patch(path, body, null);
  }

  global HttpResponse patch(final String path, Object body, HttpConfig options) {
    return this.call(HttpMethod.PATCH, path, body, options);
  }

  // *** POST ***
  global HttpResponse post(final String path, Object body) {
    return this.post(path, body, null);
  }

  global HttpResponse post(final String path, Object body, HttpConfig options) {
    return this.call(HttpMethod.POST, path, body, options);
  }

  // *** PUT ***
  global HttpResponse put(final String path, Object body) {
    return this.put(path, body, null);
  }

  global HttpResponse put(final String path, Object body, HttpConfig options) {
    return this.call(HttpMethod.PUT, path, body, options);
  }

  global HttpResponse call(final HttpMethod method, final String path, Object body, HttpConfig options) {
    HttpConfig localConfig = this.config.appendConfig(options);
    HttpRequest req = new HttpRequestBuilder()
      .setMethod(method)
      .setEndpoint(buildUrl(path, localConfig.queryParams))
      .setBody(this.serializeBody(body, this.config.isIgnoreNulls))
      .setHeaders(localConfig.headers)
      .setClientCertificateName(localConfig.clientCertName)
      .setCompressed(localConfig.isCompressed)
      .setTimeout(localConfig.wait_ms)
      .build();

    return new Http().send(req);
  }

  private HttpConfig cascadeConfigs(final String name) {
    List<HttpConfig__mdt> mdtConfigs = crawlConfig(name);
    HttpConfig result = new HttpConfig();
    for (HttpConfig__mdt mdt : mdtConfigs) {
      HttpConfig config = HttpConfig.fromMetdata(mdt);
      result = result.appendConfig(config);
    }
    return result;
  }

  private List<HttpConfig__mdt> crawlConfig(final String name) {
    List<HttpConfig__mdt> configs = new List<HttpConfig__mdt>();
    HttpConfig__mdt cfg = configService.getInstance(name);

    if (cfg == null) {
      throw new RuntimeException('Cannot find HttpConfig__mdt by name: ' + name);
    }

    if (String.isNotBlank(cfg.Parent__c)) {
      // Crawl up the Parents
      List<HttpConfig__mdt> parentCfgs = crawlConfig(cfg.Parent__c);
      configs.addAll(parentCfgs);
    }

    // Add children last
    configs.add(cfg);

    return configs;
  }

  @TestVisible
  private String buildUrl(final String path, Map<String, String> params) {
    String cleanBaseUrl = this.baseUrl.removeEnd('/');
    String cleanPath = path.removeStart('/').removeEnd('/');
    String fullUrl = cleanBaseUrl;
    if (String.isNotBlank(cleanPath)) {
      fullUrl +=  '/' + cleanPath;
    }

    Boolean urlHasParams = fullUrl.contains('?');
    Boolean hasParams = !params.isEmpty();
    String separator = '';
    String queryString = '';

    if (hasParams) {
      separator = '?';
      queryString = concatParams(params);
    }

    if (urlHasParams && hasParams) {
      separator = '&';
    }

    return fullUrl + separator + queryString;
  }

  private String concatParams(Map<String, String> params) {
    String template = '{0}={1}';
    List<String> paramList = new List<String>();
    for (String key : params.keySet()) {
      String value = params.get(key);

      paramList.add(String.format(template, new List<String> { key, value }));
    }
    return String.join(paramList, '&');
  }

  private String serializeBody(Object body, Boolean isIgnoreNulls) {
    if (body != null) {
      return JSON.serialize(body, isIgnoreNulls);
    }

    return null;
  }
}
