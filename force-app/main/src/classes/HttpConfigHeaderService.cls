public class HttpConfigHeaderService {
  public List<HttpConfigHeader__mdt> getByParent(final String name) {
    return [
      SELECT DeveloperName, HttpConfig__r.DeveloperName, Key__c, Value__c
      FROM HttpConfigHeader__mdt
      WHERE HttpConfig__r.DeveloperName = :name
    ];
  }
}