/// example view model using event bus
/// why using event driven approach ??
/// - remove repeated code
/// - more organized
/*

class HomeViewModel extends BaseViewModel {

  /// eventBus uses streams so we have every streams functionality
  StreamSubscription? getUserSubscription;


  /// listen to getUserData event in this model
  /// you can multi listen on the same event in several viewModels
  _listenToUserChangeData(){
    getUserSubscription = eventBus.on<GetUserData>().listen((event) {
      // get user data request then notify listeners with new data
      /// or fire another event to save data that reduces the code required
      /// and it will be one place and don't have to repeat your code
      // eventBus.fire(SaveUserData("userData"));
    });
  }


  /// fire event when i want to update user data
  /// now we can fire events with data to pass values throw multi view models
  _fireEventWhenActionHappen(){
    eventBus.fire(GetUserData());
  }

  /// if view model for this screen don't forget to unsubscribe form the events
  /// you listen at
  @override
  void dispose() {
    getUserSubscription!.cancel();
    super.dispose();
  }
}*/
