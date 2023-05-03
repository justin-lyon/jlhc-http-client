String baseUrl = 'https://icanhazdadjoke.com';
Map<String, String> headers = new Map<String, String> {
  'Accept' => 'text/plain',
  'User-Agent' => 'salesforce http practice'
};

HttpRequest req = new HttpRequest();
req.setMethod('GET');
req.setEndpoint(baseUrl);
req.setHeader('Accept', 'text/plain');

HttpResponse res = new Http().send(req);
String joke = res.getBody();

System.debug(req);
System.debug(res);
System.debug(joke);
