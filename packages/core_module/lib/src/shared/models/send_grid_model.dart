class SendGridModel {
  const SendGridModel(
    this.personalizations,
    this.from,
    this.subject, {
    this.content,
    this.replyTo,
    this.attachments,
    this.templateId,
    this.headers,
    this.categories,
    this.customArgs,
    this.sendAt,
    this.batchId,
    this.asm,
    this.ipPoolName,
    this.mailSettings,
    this.trackingSettings,
  });

  final List<Personalization> personalizations;
  final Address from;
  final Address? replyTo;
  final String subject;
  final List<Content>? content;
  final List<Attachment>? attachments;
  final String? templateId;
  final Map<String, String>? headers;
  final List<String>? categories;
  final Map<String, String>? customArgs;
  final DateTime? sendAt;
  final String? batchId;
  final AdvancedSuppressionManager? asm;
  final String? ipPoolName;
  final MailSettings? mailSettings;
  final TrackingSettings? trackingSettings;

  Map<String, dynamic> toJson() => {
    'personalizations': personalizations.map((e) => e.toJson()).toList(),
    'from': from.toJson(),
    'reply_to': replyTo?.toJson(),
    'subject': subject,
    'content': content?.map((e) => e.toJson()).toList(),
    'attachments': attachments?.map((e) => e.toJson()).toList(),
    'template_id': templateId,
    'headers': headers,
    'categories': categories,
    'customArgs': customArgs,
    'send_at': sendAt?.toUtc().millisecondsSinceEpoch,
    'batch_id': batchId,
    'asm': asm?.toJson(),
    'ip_pool_name': ipPoolName,
    'mail_settings': mailSettings?.toJson(),
    'tracking_settings': trackingSettings?.toJson(),
  };
}

class Email {
  const Email(
    this.personalizations,
    this.from,
    this.subject, {
    this.content,
    this.replyTo,
    this.attachments,
    this.templateId,
    this.headers,
    this.categories,
    this.customArgs,
    this.sendAt,
    this.batchId,
    this.asm,
    this.ipPoolName,
    this.mailSettings,
    this.trackingSettings,
  });

  final List<Personalization> personalizations;
  final Address from;
  final Address? replyTo;
  final String subject;
  final List<Content>? content;
  final List<Attachment>? attachments;
  final String? templateId;
  final Map<String, String>? headers;
  final List<String>? categories;
  final Map<String, String>? customArgs;
  final DateTime? sendAt;
  final String? batchId;
  final AdvancedSuppressionManager? asm;
  final String? ipPoolName;
  final MailSettings? mailSettings;
  final TrackingSettings? trackingSettings;

  Map<String, dynamic> toJson() => {
    'personalizations': personalizations.map((e) => e.toJson()).toList(),
    'from': from.toJson(),
    'reply_to': replyTo?.toJson(),
    'subject': subject,
    'content': content?.map((e) => e.toJson()).toList(),
    'attachments': attachments?.map((e) => e.toJson()).toList(),
    'template_id': templateId,
    'headers': headers,
    'categories': categories,
    'customArgs': customArgs,
    'send_at': sendAt?.toUtc().millisecondsSinceEpoch,
    'batch_id': batchId,
    'asm': asm?.toJson(),
    'ip_pool_name': ipPoolName,
    'mail_settings': mailSettings?.toJson(),
    'tracking_settings': trackingSettings?.toJson(),
  };
}

class Footer {
  const Footer({this.enable, this.text, this.html});

  final bool? enable;
  final String? text;
  final String? html;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'text': text,
    'html': html,
  };
}

class GoogleAnalytics {
  const GoogleAnalytics({
    this.enable,
    this.utmSource,
    this.utmMedium,
    this.utmTerm,
    this.utmContent,
    this.utmCampaign,
  });

  final bool? enable;
  final String? utmSource;
  final String? utmMedium;
  final String? utmTerm;
  final String? utmContent;
  final String? utmCampaign;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'utm_source': utmSource,
    'utm_medium': utmMedium,
    'utm_term': utmTerm,
    'utm_content': utmContent,
    'utm_campaign': utmCampaign,
  };
}

class SpamCheck {
  const SpamCheck({this.enable, this.threshhold, this.postToURL});

  final bool? enable;
  final int? threshhold;
  final String? postToURL;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'threshhold': threshhold,
    'post_to_url': postToURL,
  };
}

class OpenTracking {
  const OpenTracking({this.enable, this.substitutionTag});

  final bool? enable;
  final String? substitutionTag;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'substitution_tag': substitutionTag,
  };
}

class Personalization {
  const Personalization(
    this.to, {
    this.cc,
    this.bcc,
    this.subject,
    this.headers,
    this.substitutions,
    this.customArgs,
    this.sendAt,
    this.dynamicTemplateData,
  });

  final List<Address> to;
  final List<Address>? cc;
  final List<Address>? bcc;
  final String? subject;
  final Map<String, String>? headers;
  final Map<String, String>? substitutions;
  final Map<String, String>? customArgs;
  final DateTime? sendAt;
  final Map<String, dynamic>? dynamicTemplateData;

  Map<String, dynamic> toJson() => {
    'to': to.map((e) => e.toJson()).toList(),
    'cc': cc?.map((e) => e.toJson()).toList(),
    'bcc': bcc?.map((e) => e.toJson()).toList(),
    'subject': subject,
    'headers': headers,
    'substitutions': substitutions,
    'custom_args': customArgs,
    'send_at': sendAt?.toUtc().millisecondsSinceEpoch,
    'dynamic_template_data': dynamicTemplateData,
  };
}

class ResponseStatusCode {
  static const ok = 200;
  static const accepted = 202;
  static const badRequest = 400;
  static const unauthorized = 401;
  static const forbidden = 403;
  static const payloadTooLarge = 413;

  static const List<int> successCodes = [
    ResponseStatusCode.ok,
    ResponseStatusCode.accepted,
  ];

  static const List<int> errorCodes = [
    ResponseStatusCode.badRequest,
    ResponseStatusCode.unauthorized,
    ResponseStatusCode.forbidden,
    ResponseStatusCode.payloadTooLarge,
  ];
}

class SendGridError {
  const SendGridError({
    this.message,
    this.field,
    this.help,
    this.errorId,
    this.parameter,
  });

  SendGridError.fromJson(Map<String, dynamic> json)
    : message = json['message'],
      field = json['field'],
      help = json['help'],
      errorId = json['error_id'],
      parameter = json['parameter'];

  final String? message;
  final String? field;
  final String? help;
  final String? errorId;
  final String? parameter;

  @override
  String toString() {
    return 'SendGridError: $message $field $help';
  }
}

class SubscriptionTracking {
  const SubscriptionTracking({
    this.enable,
    this.text,
    this.html,
    this.substitutionTag,
  });

  final bool? enable;
  final String? text;
  final String? html;
  final String? substitutionTag;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'text': text,
    'html': html,
    'substitution_tag': substitutionTag,
  };
}

class TrackingSettings {
  const TrackingSettings({
    this.clickTracking,
    this.openTracking,
    this.subscriptionTracking,
    this.ganalytics,
  });

  final ClickTracking? clickTracking;
  final OpenTracking? openTracking;
  final SubscriptionTracking? subscriptionTracking;
  final GoogleAnalytics? ganalytics;

  Map<String, dynamic> toJson() => {
    'click_tracking': clickTracking?.toJson(),
    'open_tracking': openTracking?.toJson(),
    'subscription_tracking': subscriptionTracking?.toJson(),
    'ganalytics': ganalytics?.toJson(),
  };
}

class MailSettings {
  const MailSettings({
    this.bypassManagementList,
    this.footer,
    this.sandboxMode,
    this.spamCheck,
  });

  final BooleanSetting? bypassManagementList;
  final Footer? footer;
  final BooleanSetting? sandboxMode;
  final SpamCheck? spamCheck;

  Map<String, dynamic> toJson() => {
    'bypass_list_management': bypassManagementList,
    'footer': footer,
    'sandbox_mode': sandboxMode,
    'spam_check': spamCheck,
  };
}

class Address {
  const Address(this.email, [this.name]);

  final String email;
  final String? name;

  Map<String, dynamic> toJson() => {'email': email, 'name': name};
}

class AdvancedSuppressionManager {
  const AdvancedSuppressionManager(this.groupId, {this.groupsToDisplay});

  final int groupId;
  final List<int>? groupsToDisplay;

  Map<String, dynamic> toJson() => {
    'group_id': groupId,
    'groups_to_display': groupsToDisplay,
  };
}

class Attachment {
  const Attachment(
    this.content,
    this.filename, {
    this.type,
    this.disposition,
    this.contentId,
  });

  final String content;
  final String filename;
  final String? type;
  final String? disposition;
  final String? contentId;

  Map<String, dynamic> toJson() => {
    'content': content,
    'filename': filename,
    'type': type,
    'disposition': disposition,
    'content_id': contentId,
  };
}

class BooleanSetting {
  const BooleanSetting({this.enable});
  final bool? enable;

  Map<String, dynamic> toJson() => {'enable': enable};
}

class ClickTracking {
  const ClickTracking({this.enable, this.enableText});

  final bool? enable;
  final bool? enableText;

  Map<String, dynamic> toJson() => {
    'enable': enable,
    'enable_text': enableText,
  };
}

class Content {
  const Content(this.type, this.value);
  final String type;
  final String value;

  Map<String, dynamic> toJson() => {'type': type, 'value': value};
}
