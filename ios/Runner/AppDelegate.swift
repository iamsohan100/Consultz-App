import Flutter
import UIKit
import PushKit
import flutter_callkit_incoming
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    // UNUserNotificationCenter delegate (foreground notifications)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    // Register for remote notifications (FCM)
    application.registerForRemoteNotifications()

    // Register for VoIP pushes (PushKit) — required for CallKit on iOS
    let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
    voipRegistry.delegate = self
    voipRegistry.desiredPushTypes = [.voIP]

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  // MARK: - PKPushRegistryDelegate

  // Called when a new VoIP push token is received
  func pushRegistry(
    _ registry: PKPushRegistry,
    didUpdate pushCredentials: PKPushCredentials,
    for type: PKPushType
  ) {
    let token = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
    print("📱 VoIP Push Token: \(token)")
    // Send this token to your backend so it can send VoIP pushes
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(token)
  }

  // Called when a VoIP push is received (Background / Terminated)
  func pushRegistry(
    _ registry: PKPushRegistry,
    didReceiveIncomingPushWith payload: PKPushPayload,
    for type: PKPushType,
    completion: @escaping () -> Void
  ) {
    guard type == .voIP else { return }

    let data = payload.dictionaryPayload
    print("📞 VoIP Push received: \(data)")

    // Extract call info from payload
    let callId       = data["call_id"]     as? String ?? UUID().uuidString
    let callerName   = data["caller_name"] as? String ?? "Incoming Call"
    let callerPhoto  = data["caller_photo"] as? String ?? ""
    let channelName  = data["channel_name"] as? String ?? ""
    let agoraToken   = data["agora_token"]  as? String ?? ""
    let agoraUid     = data["agora_uid"]    as? String ?? "0"
    let isVideoStr   = data["is_video"]     as? String ?? "true"
    let isVideo      = (isVideoStr == "true" || isVideoStr == "1")

    // Build CallKit params for flutter_callkit_incoming
    let content = flutter_callkit_incoming.Data()
    content.uuid          = callId
    content.nameCaller    = callerName
    content.appName       = "Consultz"
    content.avatar        = callerPhoto
    content.handle        = isVideo ? "Video Call" : "Audio Call"
    content.type          = isVideo ? 1 : 0
    content.duration      = 30000
    content.extra         = [
      "call_id":      callId,
      "channel_name": channelName,
      "agora_token":  agoraToken,
      "agora_uid":    agoraUid,
      "caller_name":  callerName,
      "caller_photo": callerPhoto,
    ]
    content.supportsDTMF       = true
    content.supportsHolding    = true
    content.supportsGrouping   = true
    content.supportsUngrouping = true
    content.supportsVideo      = isVideo
    content.iconName           = "AppIcon"
    content.handleType         = "generic"
    content.textAccept         = "Accept"
    content.textDecline        = "Decline"

    // Show CallKit incoming call UI
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(content, fromPushKit: true)

    // Must call completion immediately per Apple requirement
    completion()
  }

  // Called when a VoIP push token is invalidated
  func pushRegistry(
    _ registry: PKPushRegistry,
    didInvalidatePushTokenFor type: PKPushType
  ) {
    print("⚠️ VoIP Push Token invalidated")
  }
}

