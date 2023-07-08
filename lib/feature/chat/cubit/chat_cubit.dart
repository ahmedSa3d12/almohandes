import 'package:bloc/bloc.dart';
import 'package:engwheels/core/models/chat_data_model.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ServiceApi api;


  List<ChatModel> rooms = [];
  ChatCubit(this.api) : super(ChatInitial()) {
    getRooms();
}
getRooms() async {
  emit(MyRoomsLoading());
  final response = await api.getRooms();
  response.fold(
        (l) => emit(MyRoomsError()),
        (r) {
          rooms = r.data!;
      emit(MyRoomsLoaded());
    },
  );
}
}
