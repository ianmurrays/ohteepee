class OneTimePassword {
  final int id;
  final String service;
  final String account;
  final String secret;
  final bool timeBased;

  OneTimePassword({
    this.id,
    this.service,
    this.account,
    this.secret,
    this.timeBased,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service,
      'account': account,
      'secret': secret,
      'timeBased': timeBased,
    };
  }

  @override
  String toString() {
    return 'OneTimePassword{id: $id, service: $service, account: $account, secret: <REDACTED>, timeBased: $timeBased}';
  }
}
