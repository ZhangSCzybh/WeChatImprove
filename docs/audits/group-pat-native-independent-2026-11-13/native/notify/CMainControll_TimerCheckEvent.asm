-[CMainControll TimerCheckEvent] 0x104d15b7c v16@0:8
0x104d15b7c: sub      sp, sp, #0xc0
0x104d15b80: stp      x28, x27, [sp, #0x60]
0x104d15b84: stp      x26, x25, [sp, #0x70]
0x104d15b88: stp      x24, x23, [sp, #0x80]
0x104d15b8c: stp      x22, x21, [sp, #0x90]
0x104d15b90: stp      x20, x19, [sp, #0xa0]
0x104d15b94: stp      x29, x30, [sp, #0xb0]
0x104d15b98: add      x29, sp, #0xb0
0x104d15b9c: mov      x21, x0
0x104d15ba0: adrp     x8, #0x11f751000
0x104d15ba4: mov      w9, #1
0x104d15ba8: strb     w9, [x8, #0x95e]
0x104d15bac: adrp     x8, #0x11ed12000
0x104d15bb0: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104d15bb4: adrp     x8, #0x11e9c9000
0x104d15bb8: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x104d15bbc: str      x1, [sp, #0x18] ; 'currentContext'
0x104d15bc0: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x104d15bc4: mov      x29, x29
0x104d15bc8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15bcc: mov      x19, x0
0x104d15bd0: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x104d15bd4: ldr      x0, [x8, #0xc30] ; classref NewSyncService | Class NewSyncService
0x104d15bd8: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d15bdc: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x104d15be0: str      x1, [sp, #0x10] ; 'class'
0x104d15be4: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x104d15be8: mov      x2, x0
0x104d15bec: adrp     x8, #0x11e9c9000
0x104d15bf0: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x104d15bf4: mov      x0, x19
0x104d15bf8: str      x1, [sp, #8] ; 'getService:'
0x104d15bfc: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x104d15c00: mov      x29, x29
0x104d15c04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15c08: mov      x20, x0
0x104d15c0c: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15c10: ldr      x1, [x8, #0x650] ; @selector(checkNeedSync) | 'checkNeedSync'
0x104d15c14: bl       #0x107c27c64 ; _objc_msgSend | selector=checkNeedSync
0x104d15c18: mov      x0, x20
0x104d15c1c: bl       #0x107c27c70 ; _objc_release
0x104d15c20: mov      x0, x19
0x104d15c24: bl       #0x107c27c70 ; _objc_release
0x104d15c28: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x104d15c2c: ldr      x23, [x8, #0x850] ; @selector(count) | 'count'
0x104d15c30: ldr      x0, [x21, #0x30]
0x104d15c34: mov      x1, x23 ; 'count'
0x104d15c38: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x104d15c3c: cbz      x0, #0x104d15dc8
0x104d15c40: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x104d15c44: ldr      x24, [x8, #0x598] ; @selector(firstObject) | 'firstObject'
0x104d15c48: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x104d15c4c: ldr      x25, [x8, #0x668] ; @selector(safeRemoveObjectAtIndex:) | 'safeRemoveObjectAtIndex:'
0x104d15c50: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15c54: ldr      x26, [x8, #0x658] ; @selector(m_bNotify) | 'm_bNotify'
0x104d15c58: adrp     x8, #0x11ea3b000 ; @selector(OnBatchAddEnterpriseMsg:Brand:)
0x104d15c5c: ldr      x27, [x8, #0x688] ; @selector(m_pbCGIWrap) | 'm_pbCGIWrap'
0x104d15c60: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x104d15c64: ldr      x9, [x8, #0xcc0] ; @selector(m_uiEventID) | 'm_uiEventID'
0x104d15c68: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15c6c: ldr      x8, [x8, #0x660] ; @selector(NotifyFromMainCtrl:Event:) | 'NotifyFromMainCtrl:Event:'
0x104d15c70: stp      x8, x9, [sp, #0x38] ; 'NotifyFromMainCtrl:Event:'
0x104d15c74: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x104d15c78: ldr      x9, [x8, #0xce0] ; @selector(m_uiMessage) | 'm_uiMessage'
0x104d15c7c: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15c80: ldr      x8, [x8, #0x668] ; @selector(m_dicMessageInfo) | 'm_dicMessageInfo'
0x104d15c84: stp      x8, x9, [sp, #0x28] ; 'm_dicMessageInfo'
0x104d15c88: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15c8c: ldr      x8, [x8, #0x670] ; @selector(NotifyFromMainCtrl:MessageInfo:Event:) | 'NotifyFromMainCtrl:MessageInfo:Event:'
0x104d15c90: str      x8, [sp, #0x20] ; 'NotifyFromMainCtrl:MessageInfo:Event:'
0x104d15c94: add      x0, sp, #0x58
0x104d15c98: bl       #0x107c0c3e4
0x104d15c9c: ldr      x1, [x21, #0x28]
0x104d15ca0: add      x0, sp, #0x48
0x104d15ca4: bl       #0x107c0ccb0
0x104d15ca8: ldr      x0, [x21, #0x30]
0x104d15cac: mov      x1, x24 ; 'firstObject'
0x104d15cb0: bl       #0x107c27c64 ; _objc_msgSend | selector=firstObject
0x104d15cb4: mov      x29, x29
0x104d15cb8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15cbc: mov      x22, x0
0x104d15cc0: ldr      x0, [x21, #0x30]
0x104d15cc4: mov      x1, x25 ; 'safeRemoveObjectAtIndex:'
0x104d15cc8: mov      x2, #0
0x104d15ccc: bl       #0x107c27c64 ; _objc_msgSend | selector=safeRemoveObjectAtIndex:
0x104d15cd0: add      x0, sp, #0x48
0x104d15cd4: bl       #0x107c0ccb4
0x104d15cd8: mov      x0, x22
0x104d15cdc: mov      x1, x26 ; 'm_bNotify'
0x104d15ce0: bl       #0x107c27c64 ; _objc_msgSend | selector=m_bNotify
0x104d15ce4: cbz      w0, #0x104d15da8
0x104d15ce8: add      x0, x21, #0x20
0x104d15cec: bl       #0x107c27c5c ; _objc_loadWeakRetained
0x104d15cf0: mov      x20, x0
0x104d15cf4: mov      x0, x22
0x104d15cf8: mov      x1, x27 ; 'm_pbCGIWrap'
0x104d15cfc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbCGIWrap
0x104d15d00: mov      x29, x29
0x104d15d04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15d08: mov      x19, x0
0x104d15d0c: bl       #0x107c27c70 ; _objc_release
0x104d15d10: mov      x0, x22
0x104d15d14: cbz      x19, #0x104d15d50
0x104d15d18: mov      x1, x27 ; 'm_pbCGIWrap'
0x104d15d1c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbCGIWrap
0x104d15d20: mov      x29, x29
0x104d15d24: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15d28: mov      x19, x0
0x104d15d2c: mov      x0, x22
0x104d15d30: ldr      x1, [sp, #0x40]
0x104d15d34: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d38: mov      x3, x0
0x104d15d3c: mov      x0, x20
0x104d15d40: ldr      x1, [sp, #0x38]
0x104d15d44: mov      x2, x19
0x104d15d48: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d4c: b        #0x104d15d98
0x104d15d50: ldr      x1, [sp, #0x30]
0x104d15d54: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d58: mov      x28, x0
0x104d15d5c: mov      x0, x22
0x104d15d60: ldr      x1, [sp, #0x28]
0x104d15d64: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d68: mov      x29, x29
0x104d15d6c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15d70: mov      x19, x0
0x104d15d74: mov      x0, x22
0x104d15d78: ldr      x1, [sp, #0x40]
0x104d15d7c: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d80: mov      x4, x0
0x104d15d84: mov      x0, x20
0x104d15d88: ldr      x1, [sp, #0x20]
0x104d15d8c: mov      x2, x28
0x104d15d90: mov      x3, x19
0x104d15d94: bl       #0x107c27c64 ; _objc_msgSend
0x104d15d98: mov      x0, x19
0x104d15d9c: bl       #0x107c27c70 ; _objc_release
0x104d15da0: mov      x0, x20
0x104d15da4: bl       #0x107c27c70 ; _objc_release
0x104d15da8: mov      x0, x22
0x104d15dac: bl       #0x107c27c70 ; _objc_release
0x104d15db0: add      x0, sp, #0x58
0x104d15db4: bl       #0x107c0c3e8
0x104d15db8: ldr      x0, [x21, #0x30]
0x104d15dbc: mov      x1, x23 ; 'count'
0x104d15dc0: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x104d15dc4: cbnz     x0, #0x104d15c94
0x104d15dc8: ldrb     w8, [x21, #0x58]
0x104d15dcc: tbnz     w8, #0, #0x104d15e34
0x104d15dd0: adrp     x8, #0x11ed12000
0x104d15dd4: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x104d15dd8: ldr      x1, [sp, #0x18]
0x104d15ddc: bl       #0x107c27c64 ; _objc_msgSend
0x104d15de0: mov      x29, x29
0x104d15de4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15de8: mov      x19, x0
0x104d15dec: adrp     x8, #0x11ed12000
0x104d15df0: ldr      x0, [x8, #0xaf8] ; classref EventService | Class EventService
0x104d15df4: ldr      x1, [sp, #0x10]
0x104d15df8: bl       #0x107c27c64 ; _objc_msgSend
0x104d15dfc: mov      x2, x0
0x104d15e00: mov      x0, x19
0x104d15e04: ldr      x1, [sp, #8]
0x104d15e08: bl       #0x107c27c64 ; _objc_msgSend
0x104d15e0c: mov      x29, x29
0x104d15e10: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104d15e14: mov      x20, x0
0x104d15e18: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x104d15e1c: ldr      x1, [x8, #0x678] ; @selector(TryStartEvents) | 'TryStartEvents'
0x104d15e20: bl       #0x107c27c64 ; _objc_msgSend | selector=TryStartEvents
0x104d15e24: mov      x0, x20
0x104d15e28: bl       #0x107c27c70 ; _objc_release
0x104d15e2c: mov      x0, x19
0x104d15e30: bl       #0x107c27c70 ; _objc_release
0x104d15e34: ldp      x29, x30, [sp, #0xb0]
0x104d15e38: ldp      x20, x19, [sp, #0xa0]
0x104d15e3c: ldp      x22, x21, [sp, #0x90]
0x104d15e40: ldp      x24, x23, [sp, #0x80] ; 'firstObject'
0x104d15e44: ldp      x26, x25, [sp, #0x70] ; 'm_bNotify'
0x104d15e48: ldp      x28, x27, [sp, #0x60]
0x104d15e4c: add      sp, sp, #0xc0
0x104d15e50: ret      
