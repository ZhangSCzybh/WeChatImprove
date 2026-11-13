-[NewSyncService onServiceEnterBackground] 0x105461dd4 v16@0:8
0x105461dd4: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105461dd8: ldr      x1, [x8, #0xbc8] ; @selector(sendBgFgRequestWithOnlineMode:) | 'sendBgFgRequestWithOnlineMode:'
0x105461ddc: mov      w2, #2
0x105461de0: b        #0x107c27c64 ; _objc_msgSend | selector=sendBgFgRequestWithOnlineMode:
