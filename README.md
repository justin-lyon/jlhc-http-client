# jlhc http-client

This managed package provides an HttpClient API and CustomMetadata config for your Apex HttpRequests.

## Install

### By SF CLI

`sf package install --package 04t8a0000017VVeAAM --target-org <your target org>`

### By URL

[Install to Sandbox](https://test.salesforce.com/packagingSetupUI/ipLanding.app?apvId=04t8a0000017VVeAAM)

[Install to PROD](https://login.salesforce.com/packagingSetupUI/ipLanding.app?apvId=04t8a0000017VVeAAM)

## Usage
```java
// Assumes you have the Remote Site Setting configured
// Define Client using HttpConfig.DadJokesAPI Custom Metadata as base config
jlhc.HttpClient client = new jlhc.HttpClient('https://icanhazdadjoke.com', 'DEFAULT');

jlhc.HttpConfig options = new jlhc.HttpConfig();
options.headers = new Map<String, String> {
  'Accept' => 'text/plain'
};

// GET using Client's config
HttpResponse res = client.get('/', options);
String joke = res.getBody();

System.debug(res);
System.debug(joke);
```

## HttpClient

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
