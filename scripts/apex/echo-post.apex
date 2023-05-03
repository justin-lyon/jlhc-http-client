String baseUrl = 'https://postman-echo.com';
Map<String, String> headers = new Map<String, String> {
  'Accept' => 'application/json',
  'User-Agent' => 'salesforce http practice'
};

HttpConfig options = new HttpConfig();
options.headers = headers;

Account acc = new Account(Name = 'Test Account');

HttpClient client = new HttpClient(baseUrl);
HttpResponse res = client.post('/post', acc, options);
String body = res.getBody();

System.debug(res);
System.debug(body);
