String baseUrl = 'https://postman-echo.com';
Map<String, String> headers = new Map<String, String> {
  'Accept' => 'application/json',
  'User-Agent' => 'salesforce http practice'
};
Map<String, String> queryParams = new Map<String, String> {
  'opt1' => 'a',
  'opt2' => 'b',
  'opt3' => 'c'
};

HttpConfig options = new HttpConfig();
options.headers = headers;
options.queryParams = queryParams;

HttpClient client = new HttpClient(baseUrl);
HttpResponse res = client.get('/get', options);
String body = res.getBody();

System.debug(res);
System.debug(body);
