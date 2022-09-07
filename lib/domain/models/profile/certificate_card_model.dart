class CertificateCardModel {
  final int id;
  final int userId;
  final String certificateUrl;
  final String certificateName;
  final String certificationDate;
  final String? certificateDetails;

  CertificateCardModel({
    required this.id,
    required this.userId,
    required this.certificateUrl,
    required this.certificateName,
    required this.certificationDate,
    required this.certificateDetails,
  });
}