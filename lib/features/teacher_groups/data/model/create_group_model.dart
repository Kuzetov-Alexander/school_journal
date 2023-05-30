
import 'package:school_journal/features/teacher_groups/domain/entities/create_group_entity.dart';

class CreateGroupModel extends CreateGroupEntity {
  const CreateGroupModel({required super.groupName});

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateGroupModel(groupName: json['groupName'] as String);
  }

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
      };
}
