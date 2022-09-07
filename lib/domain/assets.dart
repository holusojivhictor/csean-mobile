import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/shared/details/constants.dart';
import 'package:flutter/material.dart';

class Assets {
  static String dbPath = 'assets/db';
  static String profileDbPath = '$dbPath/profile.json';
  static String eventsDbPath = '$dbPath/events.json';
  static String blogsDbPath = '$dbPath/blogs.json';
  static String registeredEventsDbPath = '$dbPath/registered_events.json';
  static String newPlaceHolder = 'https://www.youtube.com/watch?v=ni5hRK1ehzk';

  // Items
  static String itemsBasePath = 'assets/items';
  static String filesBasePath = '$itemsBasePath/files';

  static String getFilesIconPath(String name) => '$filesBasePath/$name';


  static int getChapterId(int? id) {
    if (id == null) {
      return 0;
    }
    return id;
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static String getVideoUrl(String? url) {
    const placeHolder = "https://www.youtube.com/watch?v=apiu3pTIwuY";
    if (url == null) {
      return placeHolder;
    }
    return placeHolder;
  }

  static String getResourceDescription(String? description) {
    if (description == null) {
      return 'No description';
    }
    return description;
  }

  static String getTopicDescription(String? description) {
    if (description == null) {
      return 'No description';
    }
    return description;
  }

  static String getAssignedString(String? assigned) {
    if (assigned == null) {
      return 'Unassigned';
    }
    return 'Assigned to $assigned';
  }

  static String getForumDescription(String? description, String name, int privacy) {
    if (description == null) {
      switch (privacy) {
        case 1:
          return "Meet up with members from $name";
        case 0:
          return "Forum about $name";
        default:
          throw Exception('No privacy mode $privacy');
      }
    }
    return description;
  }

  static String getEventDescription(String? details) {
    if (details == null) {
      return loremIpsumText;
    }
    return details;
  }

  static MembershipType getMembershipType(MembershipType? type) {
    if (type == null) {
      return MembershipType.Professional;
    }
    return type;
  }

  static GenderType getGenderType(String? type) {
    if (type == null) {
      return GenderType.notSet;
    }
    switch (type) {
      case 'Male':
        return GenderType.male;
      case 'Female':
        return GenderType.female;
      case 'Other':
        return GenderType.other;
      case 'Not set':
        return GenderType.notSet;
      default:
        throw Exception('Invalid gender type = $type');
    }
  }

  static String translateChapterName(ChapterType type) {
    switch(type) {
      case ChapterType.Lagos:
        return 'Lagos';
      case ChapterType.Ibadan:
        return 'Ibadan';
      case ChapterType.Abuja:
        return 'Abuja';
      case ChapterType.Kaduna:
        return 'Kaduna';
      case ChapterType.Maiduguri:
        return 'Maiduguri';
      case ChapterType.Benue:
        return 'Benue';
      case ChapterType.Abia:
        return 'Abia';
      case ChapterType.Jigawa:
        return 'Jigawa';
      case ChapterType.Jos:
        return 'Jos';
      case ChapterType.Bauchi:
        return 'Bauchi';
      case ChapterType.Adamawa:
        return 'Adamawa';
      case ChapterType.Gombe:
        return 'Gombe';
      case ChapterType.Bayelsa:
        return 'Bayelsa';
      default:
        throw Exception('Invalid chapter type $type');
    }
  }

  static String translateMembershipType(MembershipType type) {
    switch(type) {
      case MembershipType.Student:
        return 'Student';
      case MembershipType.Affiliate:
        return 'Affiliate';
      case MembershipType.Associate:
        return 'Associate';
      case MembershipType.Corporate:
        return 'Corporate';
      case MembershipType.Professional:
        return 'Professional';
      default:
        throw Exception('Invalid membership type $type');
    }
  }

  static String translateMembershipTypeHome(MembershipType type) {
    switch(type) {
      case MembershipType.Student:
        return 'A Student';
      case MembershipType.Affiliate:
        return 'An Affiliate';
      case MembershipType.Associate:
        return 'An Associate';
      case MembershipType.Corporate:
        return 'Corporate';
      case MembershipType.Professional:
        return 'A Professional';
      default:
        throw Exception('Invalid membership type $type');
    }
  }

  static String translateEventPaymentType(EventPaymentType type) {
    switch (type) {
      case EventPaymentType.Free:
        return 'Free';
      case EventPaymentType.Pay:
        return 'Paid';
      default:
        throw Exception('Invalid event payment type = $type');
    }
  }

  static String translateItemRegisterStatusType(ItemRegisterStatusType type) {
    switch (type) {
      case ItemRegisterStatusType.registered:
        return 'Registered';
      case ItemRegisterStatusType.notRegistered:
        return 'Not registered';
      default:
        throw Exception('Invalid item register status type = $type');
    }
  }

  static String translateEventFilterType(EventFilterType type) {
    switch (type) {
      case EventFilterType.title:
        return 'Title';
      case EventFilterType.date:
        return 'Date';
      default:
        throw Exception('Invalid event filter type = $type');
    }
  }

  static String translateSortDirectionType(SortDirectionType type) {
    switch (type) {
      case SortDirectionType.asc:
        return 'Ascending';
      case SortDirectionType.desc:
        return 'Descending';
      default:
        throw Exception('Invalid sort direction type = $type');
    }
  }

  static String translateGenderType(GenderType type) {
    switch (type) {
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
      case GenderType.other:
        return 'Other';
      case GenderType.notSet:
        return 'Not set';
      default:
        throw Exception('Invalid gender type = $type');
    }
  }

  static String translateCategoryType(ResourceCategoryType type) {
    switch (type) {
      case ResourceCategoryType.Business:
        return 'Business';
      case ResourceCategoryType.Technology:
        return 'Technology';
      case ResourceCategoryType.Medical:
        return 'Medical';
      case ResourceCategoryType.Insurance:
        return 'Insurance';
      case ResourceCategoryType.Sport:
        return 'Sport';
      default:
        throw Exception('Invalid resource category type = $type');
    }
  }

  static IconData translateCategoryTypeIcon(ResourceCategoryType type) {
    switch (type) {
      case ResourceCategoryType.Business:
        return Icons.cases_outlined;
      case ResourceCategoryType.Technology:
        return Icons.lan_outlined;
      case ResourceCategoryType.Medical:
        return Icons.medical_services_outlined;
      case ResourceCategoryType.Insurance:
        return Icons.emergency_outlined;
      case ResourceCategoryType.Sport:
        return Icons.emoji_events_outlined;
      default:
        throw Exception('Invalid resource category type = $type');
    }
  }

  static String translateChapterRequestState(ChapterRequestState requestState) {
    switch (requestState) {
      case ChapterRequestState.active:
        return 'Current request still pending approval.';
      case ChapterRequestState.inactive:
        return 'No current activity.';
      default:
        throw Exception('Invalid chapter request state = $requestState');
    }
  }

  static String translateAutoThemeModeType(AutoThemeModeType type) {
    switch (type) {
      case AutoThemeModeType.on:
        return 'Follow OS setting';
      case AutoThemeModeType.off:
        return 'Off';
      default:
        throw Exception('Invalid auto theme mode type = $type');
    }
  }

  static AppThemeType translateThemeTypeBool(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
      default:
        throw Exception('Unknown error occurred');
    }
  }

  static String translateAppLanguageType(AppLanguageType language) {
    switch (language) {
      case AppLanguageType.english:
        return 'English';
      default:
        throw Exception('The provided app language type = $language is not valid');
    }
  }

  static String translateProgressRequestStateType(ProgressRequestState type) {
    switch (type) {
      case ProgressRequestState.Approved:
        return 'Approved';
      case ProgressRequestState.Declined:
        return 'Declined';
      case ProgressRequestState.Pending:
        return 'Pending review';
      default:
        throw Exception('Invalid progress request state type = $type');
    }
  }

  static String translateProgressStatus(double value) {
    if (value <= 0.5) {
      return 'Inadequate, Complete more units.';
    } else {
      return 'In Good Standing';
    }
  }

  static Color translateProgressStatusColor(double value) {
    if (value <= 0.5) {
      return Colors.red;
    } else {
      return const Color(0xFF57C7A0);
    }
  }

  static String translatePaymentHistoryFilterType(PaymentHistoryFilterType type) {
    switch (type) {
      case PaymentHistoryFilterType.week:
        return 'Last week';
      case PaymentHistoryFilterType.month:
        return 'Last month';
      case PaymentHistoryFilterType.year:
        return 'Last year';
      default:
        throw Exception('Invalid payment history filter type = $type');
    }
  }

  static String translateSupportStageType(SupportStageType type) {
    switch (type) {
      case SupportStageType.newItem:
        return 'New';
      case SupportStageType.inProgress:
        return 'In progress';
      case SupportStageType.resolved:
        return 'Resolved';
      default:
        throw Exception('Invalid support stage type = $type');
    }
  }
  
  static String getResourceTypeImage(ResourceType type, String ext) {
    switch (type) {
      case ResourceType.video:
        return getFilesIconPath('mp4.png');
      case ResourceType.document:
        if (ext == 'doc' || ext == 'docx') {
          return getFilesIconPath('doc.png');
        }
        return getFilesIconPath('pdf.png');
      case ResourceType.audio:
        return getFilesIconPath('mp3.png');
      case ResourceType.image:
        if (ext == 'jpg' || ext == 'jpeg') {
          return getFilesIconPath('jpg.png');
        }
        return getFilesIconPath('png.png');
      default:
        throw Exception('Invalid resource type = $type');
    }
  }
}