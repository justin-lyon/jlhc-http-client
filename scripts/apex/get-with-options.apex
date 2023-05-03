final String CONFIG_NAME_GLOBAL = 'Global';
final String CONFIG_NAME_DADJOKES = 'DadJokesAPI';
final String CONFIG_NAME_CHILD = 'TestChild';

String baseUrl = 'https://icanhazdadjoke.com';
Map<String, String> headers = new Map<String, String> {
  'Accept' => 'text/plain'
};

HttpConfig options = new HttpConfig();
options.headers = headers;

HttpClient client = new HttpClient(baseUrl, CONFIG_NAME_CHILD);
// HttpResponse res = client.call(HttpMethod.GET, '', null, options);
HttpResponse res = client.get('', options);
// HttpResponse res = client.get();
String joke = res.getBody();

System.debug(res);
System.debug(joke);
