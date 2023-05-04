# jlhc http-client

This managed package provides an HttpClient API and CustomMetadata config for your Apex HttpRequests.

## Install

### By SF CLI

`sf package install --package 04t8a0000017VW8AAM --target-org <your target org>`

### By URL

[Install to Sandbox](https://test.salesforce.com/packagingSetupUI/ipLanding.app?apvId=04t8a0000017VW8AAM)

[Install to PROD](https://login.salesforce.com/packagingSetupUI/ipLanding.app?apvId=04t8a0000017VW8AAM)

## Usage
```java
// Assumes you have the Remote Site Setting configured
// Define Client using HttpConfig.DadJokesAPI Custom Metadata as base config
jlhc.HttpClient client = new jlhc.HttpClient('https://icanhazdadjoke.com', 'DEFAULT');

jlhc.HttpConfig options = new jlhc.HttpConfig();
options.headers = new Map<String, String> {
  'Accept' => 'text/plain'
};
options.queryParams = new Map<String, String> {
  'opt1' => 'a',
  'opt2' => 'b'
};


// GET using Client's config
HttpResponse res = client.get('/', options);
String joke = res.getBody();

System.debug(res);
System.debug(joke);
```

## HttpClient

### DELETE

`HttpResponse del(String path)`
* DELETE with a relative path.

`HttpResponse del(String path, jlhc.HttpConfig options)`
* DELETE with a relative path and options.

### GET

`HttpResponse get()`
* GET using simply the baseUrl used to construct the HttpClient.

`HttpResponse get(jlhc.HttpConfig options)`
* GET with options.

`HttpResponse get(String path)`
* GET with relative path appended to baseUrl.

`HttpResponse get(String path, jlhc.HttpConfig options)`
* GET with relative path appended to baseUrl and options.

### PATCH

`HttpResponse patch(String path, Object body)`
* PATCH with relative path and a body.

`HttpResponse patch(String path, Object body, jlhc.HttpConfig options)`
* PATCH with relative path, body, and options.

### POST

`HttpResponse post(String path, Object body)`
* POST with relative path and a body.

`HttpResponse post(String path, Object body, jlhc.HttpConfig options)`
* POST with relative path, body, and options.

### PUT

`HttpResponse put(String path, Object body)`
* PUT with relative path and a body.

`HttpResponse put(String path, Object body, jlhc.HttpConfig options)`
* PUT with relative path, body, and options.

### Omni method

`HttpResponse call(jlhc.HttpMethod, String path, Object body, jlhc.HttpConfig options)`
* Allows calling any jlhc.HttpMethod with any combination of path, body, and options.

## HttpConfig

> TODO

## HttpMethod

> TODO

## HttpConfig__mdt

Fields map to the arguments on the Apex HttpRequest class. Use these fields to define how the HttpRequest is sent.

## HttpConfigHeader__mdt

Child of HttpConfig__mdt. Define Headers as Key-Value pairs to be sent with any requests that use the parent HttpConfig.

## Cascading HttpConfig

HttpConfig__mdt.Parent__c allows you to specify hierarchy in the HttpConfig. Configurations are loaded parents first, cascading configuration as it moves down the tree.

In memory config takes highest priority but can only be used in individual calls from the Client.

## More Examples

See `force-app/support` and `scripts/apex` for additional examples of cascading.
