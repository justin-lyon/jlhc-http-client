@IsTest
private class HttpConfigTest {
  private static final String CONFIG_DEFAULT = 'DEFAULT';

  @IsTest
  static void it_should_default_construct() {
    HttpConfig cfg = new HttpConfig();
    System.Assert.isNotNull(cfg);
  }

  @IsTest
  static void it_should_construct_with_name() {
    HttpConfig cfg = new HttpConfig(CONFIG_DEFAULT);
    System.Assert.isNotNull(cfg);
  }

  @IsTest
  static void it_should_return_a_string_from_get_name() {
    HttpConfig cfg = new HttpConfig(CONFIG_DEFAULT);
    System.Assert.areEqual(CONFIG_DEFAULT, cfg.getName());
  }

  @IsTest
  static void it_should_return_true_when_config_is_created_by_custom_metadata() {
    HttpConfig cfg = new HttpConfig(CONFIG_DEFAULT);
    System.Assert.isTrue(cfg.isMetadataDefined());
  }

  @IsTest
  static void it_should_return_false_when_config_is_created_in_apex_memory() {
    HttpConfig cfg = new HttpConfig();
    System.Assert.isFalse(cfg.isMetadataDefined());
  }

  @IsTest
  static void it_should_return_a_new_httpconfig_when_we_append() {
    HttpConfig cfg = new HttpConfig();
    HttpConfig copyCfg = cfg.appendConfig(null);
    System.Assert.areNotEqual(System.hashCode(cfg), System.hashCode(copyCfg));
  }

  @IsTest
  static void it_should_override_this_config_when_new_config_is_not_null() {
    HttpConfig oldCfg = createConfig();
    HttpConfig newCfg = createConfig();
    newCfg.clientCertName += 'new';
    newCfg.wait_ms += 1;
    newCfg.isCompressed = !newCfg.isCompressed;
    newCfg.isIgnoreNulls = !newCfg.isIgnoreNulls;
    newCfg.headers.put('Accept', 'text/html');

    HttpConfig mergedCfg = oldCfg.appendConfig(newCfg);
    System.Assert.areEqual(newCfg.clientCertName, mergedCfg.clientCertName);
    System.Assert.areEqual(newCfg.wait_ms, mergedCfg.wait_ms);
    System.Assert.areEqual(newCfg.isCompressed, mergedCfg.isCompressed);
    System.Assert.areEqual(newCfg.isIgnoreNulls, mergedCfg.isIgnoreNulls);
    System.Assert.areEqual(newCfg.headers, mergedCfg.headers);

    System.Assert.areNotEqual(oldCfg.clientCertName, mergedCfg.clientCertName);
    System.Assert.areNotEqual(oldCfg.wait_ms, mergedCfg.wait_ms);
    System.Assert.areNotEqual(oldCfg.isCompressed, mergedCfg.isCompressed);
    System.Assert.areNotEqual(oldCfg.isIgnoreNulls, mergedCfg.isIgnoreNulls);
    System.Assert.areNotEqual(oldCfg.headers, mergedCfg.headers);
  }

  @IsTest
  static void it_should_keep_this_config_when_new_config_is_null() {
    HttpConfig oldCfg = createConfig();
    HttpConfig newCfg = new HttpConfig();

    HttpConfig mergedCfg = oldCfg.appendConfig(newCfg);
    System.Assert.areNotEqual(newCfg.clientCertName, mergedCfg.clientCertName);
    System.Assert.areNotEqual(newCfg.wait_ms, mergedCfg.wait_ms);
    System.Assert.areNotEqual(newCfg.isCompressed, mergedCfg.isCompressed);
    System.Assert.areNotEqual(newCfg.isIgnoreNulls, mergedCfg.isIgnoreNulls);
    System.Assert.areNotEqual(newCfg.headers, mergedCfg.headers);

    System.Assert.areEqual(oldCfg.clientCertName, mergedCfg.clientCertName);
    System.Assert.areEqual(oldCfg.wait_ms, mergedCfg.wait_ms);
    System.Assert.areEqual(oldCfg.isCompressed, mergedCfg.isCompressed);
    System.Assert.areEqual(oldCfg.isIgnoreNulls, mergedCfg.isIgnoreNulls);
    System.Assert.areEqual(oldCfg.headers, mergedCfg.headers);
  }

  private static HttpConfig createConfig() {
    HttpConfig c = new HttpConfig(CONFIG_DEFAULT);
    c.clientCertName = 'clientCertName';
    c.wait_ms = 3000;
    c.isCompressed = false;
    c.isIgnoreNulls = true;
    c.headers = new Map<String, String> {
      'Accept' => 'text/plain',
      'User-Agent' => 'salesforce apex test'
    };
    return c;
  }
}