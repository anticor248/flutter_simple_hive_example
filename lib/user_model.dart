import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

//to generate .g model, open terminal below and copy-run code below
//flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Users extends Equatable {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String userPassword;

  @HiveField(2)
  String userAvatarUrl;

  Users(
      {required this.userName,
      required this.userPassword,
      required this.userAvatarUrl});

  //this is for editing username, user password or user avatar
  Users copyWith({
    String? userName,
    String? userPassword,
    String? userAvatarUrl,
  }) {
    return Users(
        userName: userName ?? this.userName,
        userPassword: userPassword ?? this.userPassword,
        userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl);
  }

  @override
  List<Object> get props => [userName, userPassword, userAvatarUrl];
}
