-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:] 0x105490c4c
0x105490c4c: sub      sp, sp, #0xb0
0x105490c50: stp      x28, x27, [sp, #0x50]
0x105490c54: stp      x26, x25, [sp, #0x60]
0x105490c58: stp      x24, x23, [sp, #0x70]
0x105490c5c: stp      x22, x21, [sp, #0x80]
0x105490c60: stp      x20, x19, [sp, #0x90]
0x105490c64: stp      x29, x30, [sp, #0xa0]
0x105490c68: add      x29, sp, #0xa0
0x105490c6c: mov      x27, x3
0x105490c70: mov      x19, x2
0x105490c74: mov      x25, x0
0x105490c78: adrp     x8, #0x11f753000
0x105490c7c: mov      w9, #1
0x105490c80: strb     w9, [x8, #0x531]
0x105490c84: mov      x0, x2
0x105490c88: bl       #0x107c27c74 ; _objc_retain
0x105490c8c: mov      x0, x27
0x105490c90: bl       #0x107c27c74 ; _objc_retain
0x105490c94: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105490c98: ldr      x24, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105490c9c: adrp     x2, #0x11cfa7000
0x105490ca0: add      x2, x2, #0x598 ; @'cmd'
0x105490ca4: mov      x0, x19
0x105490ca8: mov      x1, x24 ; 'objectForKey:'
0x105490cac: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105490cb0: mov      x29, x29
0x105490cb4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490cb8: mov      x21, x0
0x105490cbc: cbz      x0, #0x105490d3c
0x105490cc0: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x105490cc4: ldr      x1, [x8, #0xea8] ; @selector(hasPrefix:) | 'hasPrefix:'
0x105490cc8: adrp     x2, #0x11d266000
0x105490ccc: add      x2, x2, #0x298 ; @'216'
0x105490cd0: mov      x0, x21
0x105490cd4: bl       #0x107c27c64 ; _objc_msgSend | selector=hasPrefix:
0x105490cd8: cbz      w0, #0x105490d3c
0x105490cdc: adrp     x8, #0x11ed12000
0x105490ce0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105490ce4: adrp     x8, #0x11e9c9000
0x105490ce8: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105490cec: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105490cf0: mov      x29, x29
0x105490cf4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490cf8: mov      x22, x0
0x105490cfc: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x105490d00: ldr      x0, [x8, #0xc08] ; classref WCFinderGlobalPushJumpMgr | Class WCFinderGlobalPushJumpMgr
0x105490d04: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105490d08: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105490d0c: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105490d10: mov      x2, x0
0x105490d14: adrp     x8, #0x11e9c9000
0x105490d18: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105490d1c: mov      x0, x22
0x105490d20: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105490d24: mov      x29, x29
0x105490d28: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490d2c: mov      x23, x0
0x105490d30: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x105490d34: ldr      x1, [x8, #0x338] ; @selector(handleInactiveAPNSPushWithUsrInfo:) | 'handleInactiveAPNSPushWithUsrInfo:'
0x105490d38: b        #0x105490dc4
0x105490d3c: adrp     x2, #0x11d0f3000
0x105490d40: add      x2, x2, #0xdf8 ; @'jump'
0x105490d44: mov      x0, x19
0x105490d48: mov      x1, x24 ; 'objectForKey:'
0x105490d4c: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105490d50: mov      x29, x29
0x105490d54: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490d58: mov      x22, x0
0x105490d5c: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105490d60: ldr      x0, [x8, #0xc20] ; classref MicroMessengerAppDelegate | Class MicroMessengerAppDelegate
0x105490d64: adrp     x8, #0x11e9d2000 ; @selector(defaultMemoryMappedKV)
0x105490d68: ldr      x1, [x8, #0xf8] ; @selector(GlobalInstance) | 'GlobalInstance'
0x105490d6c: bl       #0x107c27c64 ; _objc_msgSend | selector=GlobalInstance
0x105490d70: mov      x29, x29
0x105490d74: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490d78: mov      x23, x0
0x105490d7c: adrp     x8, #0x11e9dc000 ; @selector(SendNotGameEmoticonMessage:errorMsg:)
0x105490d80: ldr      x1, [x8, #0xd58] ; @selector(m_isActive) | 'm_isActive'
0x105490d84: bl       #0x107c27c64 ; _objc_msgSend | selector=m_isActive
0x105490d88: tbnz     w0, #0, #0x105490dd0
0x105490d8c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105490d90: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x105490d94: mov      x0, x22
0x105490d98: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105490d9c: cbz      x0, #0x105490dd0
0x105490da0: adrp     x8, #0x11ed12000
0x105490da4: ldr      x0, [x8, #0xcf8] ; classref CAppViewControllerManager | Class CAppViewControllerManager
0x105490da8: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x105490dac: ldr      x1, [x8, #0x138] ; @selector(hasEnterWechatMain) | 'hasEnterWechatMain'
0x105490db0: bl       #0x107c27c64 ; _objc_msgSend | selector=hasEnterWechatMain
0x105490db4: cbz      w0, #0x105491460
0x105490db8: adrp     x8, #0x11eb25000 ; @selector(setNsSender:)
0x105490dbc: ldr      x1, [x8, #0xe00] ; @selector(handleApnsDeepLink:) | 'handleApnsDeepLink:'
0x105490dc0: mov      x0, x25
0x105490dc4: mov      x2, x19
0x105490dc8: bl       #0x107c27c64 ; _objc_msgSend | selector=handleApnsDeepLink:
0x105490dcc: b        #0x105491460
0x105490dd0: adrp     x2, #0x11d266000
0x105490dd4: add      x2, x2, #0x78 ; @'aps'
0x105490dd8: mov      x0, x19
0x105490ddc: mov      x1, x24 ; 'objectForKey:'
0x105490de0: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105490de4: mov      x29, x29
0x105490de8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490dec: mov      x28, x0
0x105490df0: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105490df4: ldr      x1, [x8, #0x650] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0x105490df8: adrp     x2, #0x11d01e000
0x105490dfc: add      x2, x2, #0x6d8 ; @'category'
0x105490e00: str      x1, [sp, #0x18] ; 'objectForKeyedSubscript:'
0x105490e04: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKeyedSubscript:
0x105490e08: mov      x29, x29
0x105490e0c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490e10: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105490e14: ldr      x1, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105490e18: adrp     x2, #0x11d2f9000
0x105490e1c: add      x2, x2, #0x418 ; @'PushLoginUrlAutoLogin'
0x105490e20: stp      x1, x0, [sp, #0x40] ; 'isEqualToString:'
0x105490e24: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105490e28: adrp     x20, #0x11e9c9000
0x105490e2c: cbz      w0, #0x105490ee0
0x105490e30: adrp     x8, #0x11ed12000
0x105490e34: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105490e38: adrp     x8, #0x11e9c9000
0x105490e3c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105490e40: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105490e44: mov      x29, x29
0x105490e48: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490e4c: mov      x25, x0
0x105490e50: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105490e54: ldr      x0, [x8, #0xd0] ; classref ExtDeviceService | Class ExtDeviceService
0x105490e58: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105490e5c: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105490e60: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105490e64: mov      x2, x0
0x105490e68: adrp     x8, #0x11e9c9000
0x105490e6c: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105490e70: mov      x0, x25
0x105490e74: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105490e78: mov      x29, x29
0x105490e7c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490e80: mov      x26, x0
0x105490e84: adrp     x8, #0x11eb3b000 ; @selector(initWithTeamName:relatedAppList:)
0x105490e88: ldr      x1, [x8, #0x7f0] ; @selector(handleAutoLoginAPNSPushWithUsrInfo:) | 'handleAutoLoginAPNSPushWithUsrInfo:'
0x105490e8c: mov      x2, x19
0x105490e90: bl       #0x107c27c64 ; _objc_msgSend | selector=handleAutoLoginAPNSPushWithUsrInfo:
0x105490e94: mov      x0, x26
0x105490e98: bl       #0x107c27c70 ; _objc_release
0x105490e9c: mov      x0, x25
0x105490ea0: bl       #0x107c27c70 ; _objc_release
0x105490ea4: adrp     x8, #0x11ed12000
0x105490ea8: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105490eac: ldr      x1, [x20, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105490eb0: adrp     x8, #0x11d2f9000
0x105490eb4: add      x8, x8, #0x438 ; @'handleReceiveRemoteNotification handled notification by ext device info'
0x105490eb8: str      x8, [sp] ; @'handleReceiveRemoteNotification handled notification by ext device info'
0x105490ebc: adrp     x5, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105490ec0: add      x5, x5, #0x5ab ; 'NotificationActionsMgr.mm'
0x105490ec4: adrp     x7, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105490ec8: add      x7, x7, #0xb61 ; '-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:]'
0x105490ecc: mov      w2, #2
0x105490ed0: mov      x3, #0
0x105490ed4: mov      w4, #0
0x105490ed8: mov      w6, #0x2a9
0x105490edc: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105490ee0: adrp     x8, #0x11ed12000
0x105490ee4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105490ee8: adrp     x8, #0x11ea0f000 ; @selector(changeToNextPageWithCompletion:)
0x105490eec: ldr      x1, [x8, #0x2e8] ; @selector(isLoggedIn) | 'isLoggedIn'
0x105490ef0: bl       #0x107c27c64 ; _objc_msgSend | selector=isLoggedIn
0x105490ef4: tbnz     w0, #0, #0x105490f18
0x105490ef8: cbz      x21, #0x105491450
0x105490efc: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x105490f00: ldr      x1, [x8, #0xea8] ; @selector(hasPrefix:) | 'hasPrefix:'
0x105490f04: adrp     x2, #0x11d178000
0x105490f08: add      x2, x2, #0xb78 ; @'200'
0x105490f0c: mov      x0, x21
0x105490f10: bl       #0x107c27c64 ; _objc_msgSend | selector=hasPrefix:
0x105490f14: cbz      w0, #0x105491450
0x105490f18: stp      x23, x28, [sp, #0x20]
0x105490f1c: stp      x22, x27, [sp, #0x30]
0x105490f20: adrp     x23, #0x11ed12000
0x105490f24: ldr      x26, [x23, #0x618] ; classref iConsole | Class iConsole
0x105490f28: adrp     x2, #0x11d266000
0x105490f2c: add      x2, x2, #0x78 ; @'aps'
0x105490f30: mov      x0, x19
0x105490f34: mov      x1, x24 ; 'objectForKey:'
0x105490f38: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105490f3c: mov      x29, x29
0x105490f40: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490f44: mov      x28, x0
0x105490f48: ldr      x25, [x20, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105490f4c: adrp     x8, #0x11d2f9000
0x105490f50: add      x8, x8, #0x458 ; @'ReceiveRemoteNotification: push info:%@'
0x105490f54: stp      x8, x0, [sp] ; @'ReceiveRemoteNotification: push info:%@'
0x105490f58: adrp     x22, #0x119ba9000 ; 'st %@'
0x105490f5c: add      x22, x22, #0xcd2 ; 'Kern'
0x105490f60: adrp     x20, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105490f64: add      x20, x20, #0x5ab ; 'NotificationActionsMgr.mm'
0x105490f68: adrp     x27, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105490f6c: add      x27, x27, #0xb61 ; '-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:]'
0x105490f70: mov      x0, x26 ; Class iConsole
0x105490f74: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105490f78: mov      w2, #1
0x105490f7c: mov      x3, x22 ; 'Kern'
0x105490f80: mov      w4, #0
0x105490f84: mov      x5, x20 ; 'NotificationActionsMgr.mm'
0x105490f88: mov      w6, #0x2b6
0x105490f8c: mov      x7, x27 ; '-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:]'
0x105490f90: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105490f94: mov      x0, x28
0x105490f98: bl       #0x107c27c70 ; _objc_release
0x105490f9c: ldr      x0, [x23, #0x618] ; classref iConsole | Class iConsole
0x105490fa0: adrp     x8, #0x11d2f9000
0x105490fa4: add      x8, x8, #0x478 ; @'ReceiveRemoteNotification: user info:%@'
0x105490fa8: stp      x8, x19, [sp] ; @'ReceiveRemoteNotification: user info:%@'
0x105490fac: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105490fb0: mov      w2, #1
0x105490fb4: mov      x3, x22 ; 'Kern'
0x105490fb8: mov      w4, #0
0x105490fbc: mov      x5, x20 ; 'NotificationActionsMgr.mm'
0x105490fc0: mov      w6, #0x2b7
0x105490fc4: mov      x7, x27 ; '-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:]'
0x105490fc8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105490fcc: adrp     x8, #0x11ed12000
0x105490fd0: ldr      x0, [x8, #0x738] ; _OBJC_CLASS_$_UIApplication
0x105490fd4: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x105490fd8: ldr      x1, [x8] ; @selector(sharedApplication) | 'sharedApplication'
0x105490fdc: bl       #0x107c27c64 ; _objc_msgSend | selector=sharedApplication
0x105490fe0: mov      x29, x29
0x105490fe4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105490fe8: mov      x27, x0
0x105490fec: ldr      x20, [sp, #0x40]
0x105490ff0: cbz      x21, #0x105491120
0x105490ff4: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x105490ff8: ldr      x26, [x8, #0xea8] ; @selector(hasPrefix:) | 'hasPrefix:'
0x105490ffc: adrp     x2, #0x11d178000
0x105491000: add      x2, x2, #0xb78 ; @'200'
0x105491004: mov      x0, x21
0x105491008: mov      x1, x26 ; 'hasPrefix:'
0x10549100c: bl       #0x107c27c64 ; _objc_msgSend | selector=hasPrefix:
0x105491010: cbz      w0, #0x10549103c
0x105491014: mov      x26, x27
0x105491018: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x10549101c: ldr      x0, [x8, #0xbe0] ; classref VOIPHelper | Class VOIPHelper
0x105491020: adrp     x8, #0x11eb25000 ; @selector(setNsSender:)
0x105491024: ldr      x1, [x8, #0xdf0] ; @selector(APNSPushWithUsrInfo:requestID:) | 'APNSPushWithUsrInfo:requestID:'
0x105491028: mov      x2, x19
0x10549102c: ldr      x27, [sp, #0x38]
0x105491030: mov      x3, x27
0x105491034: bl       #0x107c27c64 ; _objc_msgSend | selector=APNSPushWithUsrInfo:requestID:
0x105491038: b        #0x105491118
0x10549103c: adrp     x2, #0x11d2ab000
0x105491040: add      x2, x2, #0x9d8 ; @'202'
0x105491044: mov      x0, x21
0x105491048: mov      x1, x26
0x10549104c: bl       #0x107c27c64 ; _objc_msgSend
0x105491050: cbz      w0, #0x105491084
0x105491054: mov      x26, x27
0x105491058: adrp     x8, #0x11ed12000
0x10549105c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105491060: adrp     x8, #0x11e9c9000
0x105491064: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105491068: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x10549106c: mov      x29, x29
0x105491070: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105491074: mov      x20, x0
0x105491078: adrp     x8, #0x11ed1b000 ; classref PatSuffixWrap
0x10549107c: ldr      x0, [x8, #0x900] ; classref WCJdBussinessMgr | Class WCJdBussinessMgr
0x105491080: b        #0x1054910c8
0x105491084: adrp     x2, #0x11d090000
0x105491088: add      x2, x2, #0x218 ; @'203'
0x10549108c: mov      x0, x21
0x105491090: mov      x1, x26
0x105491094: bl       #0x107c27c64 ; _objc_msgSend
0x105491098: cbz      w0, #0x105491120
0x10549109c: mov      x26, x27
0x1054910a0: adrp     x8, #0x11ed12000
0x1054910a4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x1054910a8: adrp     x8, #0x11e9c9000
0x1054910ac: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x1054910b0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x1054910b4: mov      x29, x29
0x1054910b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054910bc: mov      x20, x0
0x1054910c0: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x1054910c4: ldr      x0, [x8, #0xb68] ; classref WCInnerJumpMgr | Class WCInnerJumpMgr
0x1054910c8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1054910cc: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x1054910d0: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x1054910d4: mov      x2, x0
0x1054910d8: adrp     x8, #0x11e9c9000
0x1054910dc: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x1054910e0: mov      x0, x20
0x1054910e4: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x1054910e8: mov      x29, x29
0x1054910ec: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054910f0: mov      x22, x0
0x1054910f4: adrp     x8, #0x11eb26000 ; @selector(getTimelineBackgroundURLSessionIdentifierPrefix)
0x1054910f8: ldr      x1, [x8, #0x338] ; @selector(handleInactiveAPNSPushWithUsrInfo:) | 'handleInactiveAPNSPushWithUsrInfo:'
0x1054910fc: mov      x2, x19
0x105491100: bl       #0x107c27c64 ; _objc_msgSend | selector=handleInactiveAPNSPushWithUsrInfo:
0x105491104: mov      x0, x22
0x105491108: bl       #0x107c27c70 ; _objc_release
0x10549110c: mov      x0, x20
0x105491110: bl       #0x107c27c70 ; _objc_release
0x105491114: ldr      x27, [sp, #0x38]
0x105491118: ldp      x23, x28, [sp, #0x20]
0x10549111c: b        #0x1054913a0
0x105491120: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105491124: ldr      x26, [x8, #0xd40] ; @selector(applicationState) | 'applicationState'
0x105491128: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x10549112c: ldr      x1, [x8, #0x808] ; @selector(respondsToSelector:) | 'respondsToSelector:'
0x105491130: mov      x0, x27
0x105491134: mov      x2, x26 ; 'applicationState'
0x105491138: bl       #0x107c27c64 ; _objc_msgSend | selector=respondsToSelector:
0x10549113c: cbz      w0, #0x1054911c4
0x105491140: mov      x0, x27
0x105491144: mov      x1, x26 ; 'applicationState'
0x105491148: bl       #0x107c27c64 ; _objc_msgSend | selector=applicationState
0x10549114c: cbnz     x0, #0x1054911c4
0x105491150: adrp     x8, #0x11ed12000
0x105491154: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105491158: adrp     x8, #0x11e9c9000
0x10549115c: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105491160: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105491164: mov      x29, x29
0x105491168: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x10549116c: mov      x20, x0
0x105491170: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105491174: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x105491178: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x10549117c: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105491180: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105491184: mov      x2, x0
0x105491188: adrp     x8, #0x11e9c9000
0x10549118c: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105491190: mov      x0, x20
0x105491194: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105491198: mov      x29, x29
0x10549119c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054911a0: mov      x22, x0
0x1054911a4: adrp     x8, #0x11eb3b000 ; @selector(initWithTeamName:relatedAppList:)
0x1054911a8: ldr      x1, [x8, #0x7f8] ; @selector(ApnsNotifySync) | 'ApnsNotifySync'
0x1054911ac: bl       #0x107c27c64 ; _objc_msgSend | selector=ApnsNotifySync
0x1054911b0: mov      x0, x22
0x1054911b4: bl       #0x107c27c70 ; _objc_release
0x1054911b8: mov      x0, x20
0x1054911bc: ldr      x20, [sp, #0x40]
0x1054911c0: bl       #0x107c27c70 ; _objc_release
0x1054911c4: mov      x26, x27
0x1054911c8: adrp     x2, #0x11d03f000
0x1054911cc: add      x2, x2, #0xd98 ; @'alert'
0x1054911d0: ldr      x28, [sp, #0x28]
0x1054911d4: mov      x0, x28
0x1054911d8: ldr      x22, [sp, #0x18]
0x1054911dc: mov      x1, x22
0x1054911e0: bl       #0x107c27c64 ; _objc_msgSend
0x1054911e4: mov      x29, x29
0x1054911e8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054911ec: adrp     x2, #0x11cfa4000
0x1054911f0: add      x2, x2, #0x6b8 ; @'title'
0x1054911f4: mov      x1, x22
0x1054911f8: mov      x22, x0
0x1054911fc: bl       #0x107c27c64 ; _objc_msgSend
0x105491200: mov      x29, x29
0x105491204: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105491208: mov      x27, x0
0x10549120c: adrp     x2, #0x11d2f9000
0x105491210: add      x2, x2, #0x498 ; @'NoViewMessage'
0x105491214: ldr      x0, [sp, #0x48]
0x105491218: mov      x1, x20
0x10549121c: bl       #0x107c27c64 ; _objc_msgSend
0x105491220: ldr      x23, [sp, #0x20]
0x105491224: cbz      w0, #0x10549138c
0x105491228: cbz      x27, #0x105491244
0x10549122c: adrp     x2, #0x11d2f9000
0x105491230: add      x2, x2, #0x4b8 ; @'[Apns]'
0x105491234: mov      x0, x27
0x105491238: mov      x1, x20
0x10549123c: bl       #0x107c27c64 ; _objc_msgSend
0x105491240: cbz      w0, #0x10549138c
0x105491244: adrp     x2, #0x11d0e5000
0x105491248: add      x2, x2, #0x5f8 ; @'body'
0x10549124c: mov      x0, x22
0x105491250: mov      x1, x24 ; 'objectForKey:'
0x105491254: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x105491258: mov      x29, x29
0x10549125c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105491260: mov      x9, x0
0x105491264: adrp     x8, #0x11ed12000
0x105491268: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x10549126c: adrp     x8, #0x11d2f9000
0x105491270: add      x8, x8, #0x4d8 ; @'ReceiveRemoteNotification: msg = %@'
0x105491274: str      x9, [sp, #0x40]
0x105491278: stp      x8, x9, [sp] ; @'ReceiveRemoteNotification: msg = %@'
0x10549127c: adrp     x3, #0x119ba9000 ; 'st %@'
0x105491280: add      x3, x3, #0xcd2 ; 'Kern'
0x105491284: adrp     x5, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105491288: add      x5, x5, #0x5ab ; 'NotificationActionsMgr.mm'
0x10549128c: adrp     x7, #0x11a223000 ; 'CdnDownload:RetCode:]'
0x105491290: add      x7, x7, #0xb61 ; '-[NotificationActionsMgr handleReceiveRemoteNotification:requestID:]'
0x105491294: mov      x1, x25 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105491298: mov      w2, #1
0x10549129c: mov      w4, #0
0x1054912a0: mov      w6, #0x2cd
0x1054912a4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1054912a8: adrp     x8, #0x11f7a1000
0x1054912ac: add      x8, x8, #0xf20
0x1054912b0: ldarb    w8, [x8]
0x1054912b4: tbz      w8, #0, #0x1054914a4
0x1054912b8: adrp     x8, #0x11f7a1000
0x1054912bc: add      x8, x8, #0xf30
0x1054912c0: ldarb    w8, [x8]
0x1054912c4: tbz      w8, #0, #0x1054914ac
0x1054912c8: adrp     x8, #0x11f7a1000
0x1054912cc: add      x8, x8, #0xf40
0x1054912d0: ldarb    w8, [x8]
0x1054912d4: ldr      x25, [sp, #0x40]
0x1054912d8: tbz      w8, #0, #0x1054914b4
0x1054912dc: adrp     x8, #0x11f7a1000
0x1054912e0: ldr      x0, [x8, #0xf18]
0x1054912e4: mov      x1, x20
0x1054912e8: mov      x2, x25
0x1054912ec: bl       #0x107c27c64 ; _objc_msgSend
0x1054912f0: tbz      w0, #0, #0x105491300
0x1054912f4: adrp     x25, #0x11c2fe000
0x1054912f8: add      x25, x25, #0x238 ; __NSConcreteGlobalBlock
0x1054912fc: b        #0x105491338
0x105491300: adrp     x8, #0x11f7a1000
0x105491304: ldr      x0, [x8, #0xf28]
0x105491308: mov      x1, x20
0x10549130c: mov      x2, x25 ; __NSConcreteGlobalBlock
0x105491310: bl       #0x107c27c64 ; _objc_msgSend
0x105491314: tbnz     w0, #0, #0x105491330
0x105491318: adrp     x8, #0x11f7a1000
0x10549131c: ldr      x0, [x8, #0xf38]
0x105491320: mov      x1, x20
0x105491324: mov      x2, x25 ; __NSConcreteGlobalBlock
0x105491328: bl       #0x107c27c64 ; _objc_msgSend
0x10549132c: cbz      w0, #0x105491384
0x105491330: adrp     x25, #0x11c2fe000
0x105491334: add      x25, x25, #0x258 ; __NSConcreteGlobalBlock
0x105491338: adrp     x8, #0x11ed12000
0x10549133c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105491340: adrp     x8, #0x11e9c9000
0x105491344: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105491348: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x10549134c: mov      x29, x29
0x105491350: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105491354: mov      x20, x0
0x105491358: adrp     x8, #0x11ed10000
0x10549135c: ldr      x2, [x8, #0xe90]
0x105491360: adrp     x8, #0x11eb3b000 ; @selector(initWithTeamName:relatedAppList:)
0x105491364: ldr      x3, [x8, #0x800] ; @selector(applicationDidEnterForegroundThroughNotification:) | 'applicationDidEnterForegroundThroughNotification:'
0x105491368: adrp     x8, #0x11e9c9000
0x10549136c: ldr      x1, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x105491370: mov      x4, x25 ; __NSConcreteGlobalBlock
0x105491374: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtension:selector:block:
0x105491378: mov      x0, x20
0x10549137c: bl       #0x107c27c70 ; _objc_release
0x105491380: ldr      x25, [sp, #0x40]
0x105491384: mov      x0, x25
0x105491388: bl       #0x107c27c70 ; _objc_release
0x10549138c: mov      x0, x27
0x105491390: bl       #0x107c27c70 ; _objc_release
0x105491394: mov      x0, x22
0x105491398: bl       #0x107c27c70 ; _objc_release
0x10549139c: ldr      x27, [sp, #0x38]
0x1054913a0: adrp     x2, #0x11d265000
0x1054913a4: add      x2, x2, #0xf78 ; @'m'
0x1054913a8: mov      x0, x19
0x1054913ac: mov      x1, x24 ; 'objectForKey:'
0x1054913b0: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x1054913b4: mov      x29, x29
0x1054913b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054913bc: mov      x20, x0
0x1054913c0: adrp     x2, #0x11d036000
0x1054913c4: add      x2, x2, #0x2d8 ; @'u'
0x1054913c8: mov      x0, x19
0x1054913cc: mov      x1, x24 ; 'objectForKey:'
0x1054913d0: bl       #0x107c27c64 ; _objc_msgSend | selector=objectForKey:
0x1054913d4: mov      x29, x29
0x1054913d8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054913dc: mov      x22, x0
0x1054913e0: adrp     x8, #0x11ed12000
0x1054913e4: ldr      x0, [x8, #0x638] ; _OBJC_CLASS_$_NSString
0x1054913e8: adrp     x8, #0x11ecad000 ; @selector(sharedApplication)
0x1054913ec: ldr      x1, [x8, #0x5c8] ; @selector(stringWithFormat:) | 'stringWithFormat:'
0x1054913f0: adrp     x8, #0x11cf9f000
0x1054913f4: add      x8, x8, #0x1f8 ; @'0'
0x1054913f8: stp      x22, x8, [sp, #8]
0x1054913fc: str      x20, [sp]
0x105491400: adrp     x2, #0x11cfaa000
0x105491404: add      x2, x2, #0x2b8 ; @'%@,%@,%@'
0x105491408: bl       #0x107c27c64 ; _objc_msgSend | selector=stringWithFormat:
0x10549140c: mov      x29, x29
0x105491410: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105491414: mov      x24, x0
0x105491418: mov      w0, #0x2a89
0x10549141c: mov      x1, x24
0x105491420: mov      w2, #0
0x105491424: mov      w3, #0
0x105491428: bl       #0x10241a0cc
0x10549142c: mov      x0, x24
0x105491430: bl       #0x107c27c70 ; _objc_release
0x105491434: mov      x0, x22
0x105491438: bl       #0x107c27c70 ; _objc_release
0x10549143c: mov      x0, x20
0x105491440: bl       #0x107c27c70 ; _objc_release
0x105491444: mov      x0, x26
0x105491448: bl       #0x107c27c70 ; _objc_release
0x10549144c: ldr      x22, [sp, #0x30]
0x105491450: ldr      x0, [sp, #0x48]
0x105491454: bl       #0x107c27c70 ; _objc_release
0x105491458: mov      x0, x28
0x10549145c: bl       #0x107c27c70 ; _objc_release
0x105491460: mov      x0, x23
0x105491464: bl       #0x107c27c70 ; _objc_release
0x105491468: mov      x0, x22
0x10549146c: bl       #0x107c27c70 ; _objc_release
0x105491470: mov      x0, x21
0x105491474: bl       #0x107c27c70 ; _objc_release
0x105491478: mov      x0, x27
0x10549147c: bl       #0x107c27c70 ; _objc_release
0x105491480: mov      x0, x19
0x105491484: ldp      x29, x30, [sp, #0xa0]
0x105491488: ldp      x20, x19, [sp, #0x90]
0x10549148c: ldp      x22, x21, [sp, #0x80]
0x105491490: ldp      x24, x23, [sp, #0x70]
0x105491494: ldp      x26, x25, [sp, #0x60]
0x105491498: ldp      x28, x27, [sp, #0x50]
0x10549149c: add      sp, sp, #0xb0
0x1054914a0: b        #0x107c27c70 ; _objc_release
0x1054914a4: bl       #0x107c0ac1c
0x1054914a8: b        #0x1054912b8
0x1054914ac: bl       #0x107c0ac20
0x1054914b0: b        #0x1054912c8
0x1054914b4: bl       #0x107c0ac24
0x1054914b8: b        #0x1054912dc
