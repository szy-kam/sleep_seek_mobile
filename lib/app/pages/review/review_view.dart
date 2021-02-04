import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/review/review_controller.dart';

class ReviewPage extends View {
  ReviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class ReviewPageView extends ViewState<ReviewPage, ReviewController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ReviewPageView(ReviewController controller) : super(controller);

  @override
  Widget get view => throw UnimplementedError();

  @override
  Widget buildPage() {
    // TODO: implement buildPage
    throw UnimplementedError();
  }
}
