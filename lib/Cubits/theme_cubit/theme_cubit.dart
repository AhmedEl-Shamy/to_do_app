import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeChanged());
  bool isDark = false;
  void changeTheme(){
    isDark = !isDark;
    emit(ThemeChanged());
  }
}
