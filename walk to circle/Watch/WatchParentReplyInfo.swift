import Foundation

struct WatchParentReplyInfo {
  static var data: [String: AnyObject] {
    return [WalkConstants.watch.replyKeys.walkDirection:
      WatchWalkDirection.get ?? NSNull()]
  }
}
