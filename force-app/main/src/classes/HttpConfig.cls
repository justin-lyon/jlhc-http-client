global class HttpConfig {
  // If this.name is set, then it's from a custom metadata record
  // If this.name is NOT set, then it's been created in Apex memory.
  private String name;

  global Map<String, String> headers = new Map<String, String>();
  global Map<String, String> queryParams = new Map<String, String>();
  global String clientCertName;
  global Integer wait_ms;
  global Boolean isCompressed;
  global Boolean isIgnoreNulls;

  private HttpConfigService configService = new HttpConfigService();
  @TestVisible
  private void setHttpConfigService(HttpConfigService service) {
    this.configService = service;
  }

  private HttpConfigHeaderService headerService = new HttpConfigHeaderService();
  @TestVisible
  private void setHttpConfigHeaderService(HttpConfigHeaderService service) {
    this.headerService = service;
  }

  global HttpConfig () {}

  public HttpConfig(final String name) {
    this.name = name;
    setByMetadata(getMetdata(name));
  }

  private HttpConfig(HttpConfig__mdt mdt) {
    setByMetadata(mdt);
  }

  public static HttpConfig fromMetdata(HttpConfig__mdt mdt) {
    HttpConfig cfg = new HttpConfig(mdt);
    return cfg;
  }

  public String getName() {
    return name;
  }

  private void setName(final String val) {
    this.name = val;
  }

  public Boolean isMetadataDefined() {
    return String.isNotBlank(name);
  }

  // Returns a new HttpConfig after appending newCfg to this.
  public HttpConfig appendConfig(HttpConfig newCfg) {
    HttpConfig mergedCfg = this.copy();
    if (newCfg == null) {
      return mergedCfg;
    }

    if (String.isNotBlank(newCfg.getName())) {
      mergedCfg.setName(newCfg.getName());
    }

    if (!newCfg.headers.isEmpty()) {
      mergedCfg.headers.putAll(newCfg.headers);
    }

    if (!newCfg.queryParams.isEmpty()) {
      mergedCfg.queryParams.putAll(newCfg.queryParams);
    }

    if (String.isNotBlank(newCfg.clientCertName)) {
      mergedCfg.clientCertName = newCfg.clientCertName;
    }

    if (newCfg.wait_ms != null) {
      mergedCfg.wait_ms = newCfg.wait_ms;
    }

    if (newCfg.isCompressed != null) {
      mergedCfg.isCompressed = newCfg.isCompressed;
    }

    if (newCfg.isIgnoreNulls != null) {
      mergedCfg.isIgnoreNulls = newCfg.isIgnoreNulls;
    }

    return mergedCfg;
  }

  private HttpConfig copy() {
    HttpConfig cfg = new HttpConfig();

    cfg.setName(this.name);
    cfg.headers = this.headers.clone();
    cfg.clientCertName = this.clientCertName;
    cfg.wait_ms = this.wait_ms;
    cfg.isCompressed = this.isCompressed;
    cfg.isIgnoreNulls = this.isIgnoreNulls;

    return cfg;
  }

  private void setByMetadata(HttpConfig__mdt mdt) {
    this.name = mdt.DeveloperName;
    this.clientCertName = mdt.ClientCertificateName__c;
    this.wait_ms = Integer.valueOf(mdt.TimeoutLimit__c);
    this.isCompressed = mdt.IsCompressed__c;
    this.isIgnoreNulls = mdt.IsIgnoreNulls__c;
    this.setHeaders(mdt.DeveloperName);
  }

  private void setHeaders(final String name) {
    List<HttpConfigHeader__mdt> headersConfigs = headerService.getByParent(name);
    Map<String, String> headers = new Map<String, String>();
    for (HttpConfigHeader__mdt header : headersConfigs) {
      headers.put(header.Key__c, header.Value__c);
    }

    if (headers.isEmpty()) {
      return;
    }

    this.headers.putAll(headers);
  }

  private HttpConfig__mdt getMetdata(final String name) {
    HttpConfig__mdt mdt = configService.getInstance(name);
    if (mdt == null) {
      throw new RuntimeException('No HttpConfig__mdt found by DeveloperName: ' + name);
    }
    return mdt;
  }
}