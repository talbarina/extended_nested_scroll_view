import 'package:flutter/widgets.dart';

/// Tells an [ExtendedNestedScrollView] with `onlyOneScrollInBody` whether the
/// scroll views in [child] are the body's shown ones (such as the current
/// page of a TabBarView whose pages are kept alive).
///
/// When no body scroll view is being dragged (a fling, or a drag that starts
/// on the header), the coordinator moves only the body scroll views marked
/// shown, instead of guessing from visibility, which fails while the header
/// pushes the body partly off screen and then moves every kept-alive page.
/// The visibility checks are used only when no body scroll view has a
/// marker; once any has one, unmarked ones are never moved.
class ExtendedNestedScrollBodyShown extends InheritedWidget {
  /// Creates a marker whose [isShown] is asked each time the coordinator
  /// picks the body scroll views to move, so it never goes stale.
  const ExtendedNestedScrollBodyShown({
    super.key,
    required this.isShown,
    required super.child,
  });

  /// Whether the scroll views in [child] are the body's shown ones now.
  final ValueGetter<bool> isShown;

  /// The [isShown] of the marker above [context], or null without one.
  static bool? of(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<ExtendedNestedScrollBodyShown>()
        ?.isShown();
  }

  // [of] registers no dependency, so there is never anyone to notify
  @override
  bool updateShouldNotify(ExtendedNestedScrollBodyShown oldWidget) => false;
}
