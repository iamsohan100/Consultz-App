import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/discover/controller/content_controller.dart';
import 'package:consultz/feature/discover/controller/discover_controller.dart';
import 'package:consultz/feature/discover/model/content_meta_response_model.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  Future<void> likeContent(
    String contentId, {
    required bool? isDiscover,
  }) async {
    // Step 1: Optimistic UI — আগেই like দেখাও
    _updateLocal(contentId, isLiked: true, delta: 1, isDiscover: isDiscover);

    try {
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.likeContent(contentId),
        body: {},
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // Step 2: Server থেকে সঠিক count নাও
        final meta = ContentMetaResponseModel.fromJson(response?.responseData);
        _updateLocal(
          contentId,
          isLiked: true,
          serverCount: meta.data?.like,
          isDiscover: isDiscover,
        );
      } else {
        // Rollback
        _updateLocal(
          contentId,
          isLiked: false,
          delta: -1,
          isDiscover: isDiscover,
        );
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      // Rollback
      _updateLocal(
        contentId,
        isLiked: false,
        delta: -1,
        isDiscover: isDiscover,
      );
      bottomMessage(msg: e.toString());
    }
  }

  Future<void> unlikeContent(
    String contentId, {
    required bool? isDiscover,
  }) async {
    // Step 1: Optimistic UI — আগেই unlike দেখাও
    _updateLocal(contentId, isLiked: false, delta: -1, isDiscover: isDiscover);

    try {
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.unlikeContent(contentId),
        body: {},
      );

      if (response?.statusCode == 200 && response?.isSuccess == true) {
        // Step 2: Server থেকে সঠিক count নাও
        final meta = ContentMetaResponseModel.fromJson(response?.responseData);
        _updateLocal(
          contentId,
          isLiked: false,
          serverCount: meta.data?.like,
          isDiscover: isDiscover,
        );
      } else {
        // Rollback
        _updateLocal(
          contentId,
          isLiked: true,
          delta: 1,
          isDiscover: isDiscover,
        );
        bottomMessage(msg: response?.message);
      }
    } catch (e) {
      // Rollback
      _updateLocal(contentId, isLiked: true, delta: 1, isDiscover: isDiscover);
      bottomMessage(msg: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Private helper
  // ─────────────────────────────────────────────────────────────────────────

  /// [serverCount] দিলে সেটা বসায়, না দিলে [delta] দিয়ে local count change করে
  void _updateLocal(
    String contentId, {
    required bool isLiked,
    int? delta,
    int? serverCount,
    required bool? isDiscover,
  }) {
    final contentController = Get.find<ContentController>();
    final discoverController = Get.find<DiscoverController>();

    final index = isDiscover == true
        ? discoverController.contentList.indexWhere((f) => f.sId == contentId)
        : contentController.contentList.indexWhere((f) => f.sId == contentId);
    if (index == -1) return;

    final feed = isDiscover == true
        ? discoverController.contentList[index]
        : contentController.contentList[index];

    feed.isLiked = isLiked;

    if (serverCount != null) {
      feed.contentMeta?.like = serverCount;
    } else if (delta != null) {
      final current = feed.contentMeta?.like ?? 0;
      feed.contentMeta?.like = (current + delta).clamp(0, 999999);
    }

    isDiscover == true
        ? discoverController.contentList[index] = feed
        : contentController.contentList[index] = feed;
    isDiscover == true
        ? discoverController.contentList.refresh()
        : contentController.contentList.refresh();
  }
}
