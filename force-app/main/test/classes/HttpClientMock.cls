@IsTest
public  class HttpClientMock implements HttpCalloutMock {
  public HttpResponse res;
  public Boolean isForceThrow = false;

  public HttpClientMock() {
    HttpResponse res = new HttpResponse();
    res.setStatusCode(200);
    res.setStatus('OK');
  }

  public HttpClientMock(HttpResponse res) {
    this.res = res;
  }

  public HttpResponse respond(HttpRequest req) {
    if (isForceThrow) {
      throw new CalloutException('Forced Exception from HttpClientMock.');
    }

    return res;
  }
}
