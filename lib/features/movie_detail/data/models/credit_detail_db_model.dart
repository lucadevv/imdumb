class CreditDetailDbModel {
  final String? id;
  final String? creditType;
  final String? department;
  final String? job;
  final String? mediaType;
  final Map<String, dynamic>? person;
  final Map<String, dynamic>? media;

  CreditDetailDbModel({
    this.id,
    this.creditType,
    this.department,
    this.job,
    this.mediaType,
    this.person,
    this.media,
  });

  factory CreditDetailDbModel.fromJson(Map<String, dynamic> json) {
    return CreditDetailDbModel(
      id: json['id'] as String?,
      creditType: json['credit_type'] as String?,
      department: json['department'] as String?,
      job: json['job'] as String?,
      mediaType: json['media_type'] as String?,
      person: json['person'] != null
          ? json['person'] as Map<String, dynamic>
          : null,
      media: json['media'] != null
          ? json['media'] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'credit_type': creditType,
      'department': department,
      'job': job,
      'media_type': mediaType,
      'person': person,
      'media': media,
    };
  }
}
