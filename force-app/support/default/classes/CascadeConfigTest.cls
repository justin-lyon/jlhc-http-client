@IsTest
private class CascadeConfigTest {
  private static final String CONFIG_GLOBAL = 'Global';
  private static final String CONFIG_PARENT = 'DadJokesAPI';
  private static final String CONFIG_CHILD = 'TestChild';
  private static final String HEADER_GLOBAL = 'GlobalUserAgent';
  private static final String HEADER_PARENT = 'DadJokesAccept';
  private static final String HEADER_CHILD = 'ChildAccept';

  private static final String API_URL = 'https://some.com';

  @IsTest
  static void it_should_cascade_configs() {
    HttpClient client = new HttpClient(API_URL, CONFIG_CHILD);
    System.Assert.isNotNull(client);

    HttpConfig__mdt globalMdt = HttpConfig__mdt.getInstance(CONFIG_GLOBAL);
    HttpConfig__mdt dadJokesMdt = HttpConfig__mdt.getInstance(CONFIG_PARENT);
    HttpConfig__mdt childMdt = HttpConfig__mdt.getInstance(CONFIG_CHILD);
    HttpConfigHeader__mdt globalHeaderMdt = HttpConfigHeader__mdt.getInstance(HEADER_GLOBAL);
    HttpConfigHeader__mdt dadJokesHeaderMdt = HttpConfigHeader__mdt.getInstance(HEADER_PARENT);
    HttpConfigHeader__mdt childHeaderMdt = HttpConfigHeader__mdt.getInstance(HEADER_CHILD);

    HttpConfig config = client.config;
    System.Assert.areEqual(childMdt.DeveloperName, config.getName());
    System.Assert.areEqual(childMdt.IsCompressed__c, config.isCompressed);
    System.Assert.areEqual(childMdt.IsIgnoreNulls__c, config.isIgnoreNulls);
    System.Assert.areEqual(childMdt.TimeoutLimit__c, config.wait_ms);
    System.Assert.areEqual(globalHeaderMdt.Value__c, config.headers.get(globalHeaderMdt.Key__c));
    System.Assert.areEqual(childHeaderMdt.Value__c, config.headers.get(childHeaderMdt.Key__c));

    System.Assert.areNotEqual(globalMdt.DeveloperName, config.getName());
    System.Assert.areNotEqual(dadJokesMdt.DeveloperName, config.getName());
    System.Assert.areNotEqual(dadJokesHeaderMdt.Value__c, config.headers.get(dadJokesHeaderMdt.Key__c));
  }
}