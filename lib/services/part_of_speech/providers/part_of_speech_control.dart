import 'package:dictionary_app/accessors/part_of_speech_utils_accessor.dart';
import 'package:dictionary_app/services/pagination/api_page.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/part_of_speech/part_of_speech_domain_object.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'part_of_speech_control.g.dart';

@riverpod
class PartOfSpeechControl extends _$PartOfSpeechControl
    with PartOfSpeechUtilsAccessor {
  @override
  Future<ApiPage<PartOfSpeechDomainObject>> build(String namePattern,
      {ApiPageDetails pageDetails = const ApiPageDetails()}) async {
    return await (await partOfSpeechDomainService())
        .searchByNamePattern(namePattern, pageDetails: pageDetails);
  }

  Future<PartOfSpeechDomainObject> addNew(
      PartOfSpeechDomainObject newPart) async {
    var result = await (await partOfSpeechDomainService()).create(newPart);

    ref.invalidateSelf();

    return result;
  }
}
