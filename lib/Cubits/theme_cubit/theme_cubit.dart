import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeChanged());
  String currentTheme = 'system';

  void changeTheme(String theme){
    emit(ThemeChanged());
  }
}
