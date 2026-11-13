-[BypChatRoomMgr onDerivedSyncResponse:] 0x1007a58c0 v24@0:8@16
0x1007a58c0: stp      d9, d8, [sp, #-0x70]!
0x1007a58c4: stp      x28, x27, [sp, #0x10]
0x1007a58c8: stp      x26, x25, [sp, #0x20]
0x1007a58cc: stp      x24, x23, [sp, #0x30]
0x1007a58d0: stp      x22, x21, [sp, #0x40]
0x1007a58d4: stp      x20, x19, [sp, #0x50]
0x1007a58d8: stp      x29, x30, [sp, #0x60]
0x1007a58dc: add      x29, sp, #0x60
0x1007a58e0: sub      sp, sp, #0x1b0
0x1007a58e4: mov      x23, x2
0x1007a58e8: str      x0, [sp, #0x80]
0x1007a58ec: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a58f0: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x1007a58f4: ldr      x8, [x8]
0x1007a58f8: stur     x8, [x29, #-0x70]
0x1007a58fc: adrp     x8, #0x11f741000
0x1007a5900: mov      w9, #1
0x1007a5904: strb     w9, [x8, #0xbbc]
0x1007a5908: mov      x0, x2
0x1007a590c: bl       #0x107c27c74 ; _objc_retain
0x1007a5910: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a5914: ldr      x19, [x8, #0x870] ; @selector(m_pbResponse) | 'm_pbResponse'
0x1007a5918: mov      x0, x23
0x1007a591c: mov      x1, x19 ; 'm_pbResponse'
0x1007a5920: bl       #0x107c27c64 ; _objc_msgSend | selector=m_pbResponse
0x1007a5924: mov      x29, x29
0x1007a5928: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a592c: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a5930: ldr      x20, [x8, #0xce0] ; @selector(m_uiMessage) | 'm_uiMessage'
0x1007a5934: cbz      x0, #0x1007a5958
0x1007a5938: mov      x21, x0
0x1007a593c: mov      x0, x23
0x1007a5940: mov      x1, x20 ; 'm_uiMessage'
0x1007a5944: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x1007a5948: mov      x22, x0
0x1007a594c: mov      x0, x21
0x1007a5950: bl       #0x107c27c70 ; _objc_release
0x1007a5954: cbz      w22, #0x1007a59b0
0x1007a5958: adrp     x8, #0x11ed12000
0x1007a595c: ldr      x19, [x8, #0x618] ; classref iConsole | Class iConsole
0x1007a5960: mov      x0, x23
0x1007a5964: mov      x1, x20 ; 'm_uiMessage'
0x1007a5968: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessage
0x1007a596c: adrp     x8, #0x11e9c9000
0x1007a5970: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a5974: adrp     x8, #0x11cfec000
0x1007a5978: add      x8, x8, #0xc18 ; @'onDerivedSyncResponse fail ret:%d'
0x1007a597c: stp      x8, x0, [sp] ; @'onDerivedSyncResponse fail ret:%d'
0x1007a5980: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5984: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a5988: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a598c: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a5990: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5994: add      x7, x7, #0xdf6 ; '-[BypChatRoomMgr onDerivedSyncResponse:]'
0x1007a5998: mov      x0, x19 ; Class iConsole
0x1007a599c: mov      w2, #2
0x1007a59a0: mov      w4, #0
0x1007a59a4: mov      w6, #0x193
0x1007a59a8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a59ac: b        #0x1007a5f0c
0x1007a59b0: mov      x0, x23
0x1007a59b4: mov      x1, x19 ; Class iConsole
0x1007a59b8: bl       #0x107c27c64 ; _objc_msgSend | selector=p4
0x1007a59bc: mov      x29, x29
0x1007a59c0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a59c4: mov      x24, x0
0x1007a59c8: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a59cc: ldr      x19, [x8, #0x480] ; @selector(baseResponse) | 'baseResponse'
0x1007a59d0: mov      x1, x19 ; 'baseResponse'
0x1007a59d4: bl       #0x107c27c64 ; _objc_msgSend | selector=baseResponse
0x1007a59d8: mov      x29, x29
0x1007a59dc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a59e0: mov      x21, x0
0x1007a59e4: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a59e8: ldr      x20, [x8, #0x488] ; @selector(ret) | 'ret'
0x1007a59ec: mov      x1, x20 ; 'ret'
0x1007a59f0: bl       #0x107c27c64 ; _objc_msgSend | selector=ret
0x1007a59f4: mov      x22, x0
0x1007a59f8: mov      x0, x21
0x1007a59fc: bl       #0x107c27c70 ; _objc_release
0x1007a5a00: cbz      w22, #0x1007a5a78
0x1007a5a04: adrp     x8, #0x11ed12000
0x1007a5a08: ldr      x21, [x8, #0x618] ; classref iConsole | Class iConsole
0x1007a5a0c: mov      x0, x24
0x1007a5a10: mov      x1, x19 ; 'baseResponse'
0x1007a5a14: bl       #0x107c27c64 ; _objc_msgSend | selector=baseResponse
0x1007a5a18: mov      x29, x29
0x1007a5a1c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5a20: mov      x19, x0
0x1007a5a24: mov      x1, x20 ; 'ret'
0x1007a5a28: bl       #0x107c27c64 ; _objc_msgSend | selector=ret
0x1007a5a2c: adrp     x8, #0x11e9c9000
0x1007a5a30: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a5a34: adrp     x8, #0x11cfec000
0x1007a5a38: add      x8, x8, #0xc38 ; @'onDerivedSyncResponse baseRet:%d'
0x1007a5a3c: stp      x8, x0, [sp] ; @'onDerivedSyncResponse baseRet:%d'
0x1007a5a40: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5a44: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a5a48: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5a4c: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a5a50: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5a54: add      x7, x7, #0xdf6 ; '-[BypChatRoomMgr onDerivedSyncResponse:]'
0x1007a5a58: mov      x0, x21 ; Class iConsole
0x1007a5a5c: mov      w2, #2
0x1007a5a60: mov      w4, #0
0x1007a5a64: mov      w6, #0x199
0x1007a5a68: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a5a6c: mov      x0, x19
0x1007a5a70: bl       #0x107c27c70 ; _objc_release
0x1007a5a74: b        #0x1007a5f04
0x1007a5a78: stp      x24, x23, [sp, #0x18]
0x1007a5a7c: movi     v0.16b, #0
0x1007a5a80: stp      q0, q0, [sp, #0x100]
0x1007a5a84: stp      q0, q0, [sp, #0xe0]
0x1007a5a88: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5a8c: ldr      x1, [x8, #0xd18] ; @selector(results) | 'results'
0x1007a5a90: mov      x0, x24
0x1007a5a94: bl       #0x107c27c64 ; _objc_msgSend | selector=results
0x1007a5a98: mov      x29, x29
0x1007a5a9c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5aa0: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a5aa4: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x1007a5aa8: add      x2, sp, #0xe0
0x1007a5aac: sub      x3, x29, #0xf0
0x1007a5ab0: str      x0, [sp, #0xa0]
0x1007a5ab4: str      x1, [sp, #0x28] ; 'countByEnumeratingWithState:objects:count:'
0x1007a5ab8: mov      w4, #0x10
0x1007a5abc: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x1007a5ac0: cbz      x0, #0x1007a5ef8
0x1007a5ac4: mov      x24, x0
0x1007a5ac8: ldr      x8, [sp, #0xf0]
0x1007a5acc: ldr      x26, [x8]
0x1007a5ad0: adrp     x23, #0x11cfec000
0x1007a5ad4: add      x23, x23, #0xc58 ; @'onDerivedSyncResult roomName:%@ hasMore:%d'
0x1007a5ad8: adrp     x8, #0x1178c7000
0x1007a5adc: ldr      d8, [x8, #0x680]
0x1007a5ae0: mov      x19, #0
0x1007a5ae4: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5ae8: ldr      x22, [x8, #0xd20] ; @selector(instanceType) | 'instanceType'
0x1007a5aec: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5af0: ldr      x9, [x8, #0xd28] ; @selector(instanceId) | 'instanceId'
0x1007a5af4: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x1007a5af8: ldr      x20, [x8, #0xce8] ; @selector(length) | 'length'
0x1007a5afc: adrp     x8, #0x11e9eb000 ; @selector(setMassSendType:)
0x1007a5b00: ldr      x8, [x8, #0xc10] ; @selector(hasMore) | 'hasMore'
0x1007a5b04: stp      x8, x9, [sp, #0xa8] ; 'hasMore'
0x1007a5b08: adrp     x8, #0x11e9c9000
0x1007a5b0c: ldr      x9, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a5b10: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x1007a5b14: ldr      x8, [x8, #0xae0] ; @selector(items) | 'items'
0x1007a5b18: stp      x8, x9, [sp, #0x88] ; 'items'
0x1007a5b1c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x1007a5b20: ldr      x9, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x1007a5b24: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b28: ldr      x10, [x8, #0xc38] ; @selector(members) | 'members'
0x1007a5b2c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a5b30: ldr      x8, [x8, #0x850] ; @selector(count) | 'count'
0x1007a5b34: stp      x8, x10, [sp, #0x58] ; 'count'
0x1007a5b38: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b3c: ldr      x8, [x8, #0xd30] ; @selector(respSyncKey) | 'respSyncKey'
0x1007a5b40: stp      x9, x8, [sp, #0x70] ; 'parseFromData:'
0x1007a5b44: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b48: ldr      x9, [x8, #0xc40] ; @selector(updateBypMembers:members:derivedSyncKey:) | 'updateBypMembers:members:derivedSyncKey:'
0x1007a5b4c: adrp     x8, #0x11e9c9000
0x1007a5b50: ldr      x8, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x1007a5b54: stp      x8, x9, [sp, #0x48] ; 'currentContext'
0x1007a5b58: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b5c: ldr      x9, [x8, #0xd08] ; @selector(onBypChatRoomMembersUpdated:) | 'onBypChatRoomMembersUpdated:'
0x1007a5b60: adrp     x8, #0x11e9c9000
0x1007a5b64: ldr      x8, [x8, #0xe58] ; @selector(callExtension:selector:block:) | 'callExtension:selector:block:'
0x1007a5b68: stp      x8, x9, [sp, #0x38] ; 'callExtension:selector:block:'
0x1007a5b6c: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b70: ldr      x8, [x8, #0xcf0] ; @selector(setDerivedSyncKey:forRoom:) | 'setDerivedSyncKey:forRoom:'
0x1007a5b74: str      x8, [sp, #0x30] ; 'setDerivedSyncKey:forRoom:'
0x1007a5b78: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a5b7c: ldr      x8, [x8, #0xd38] ; @selector(startDerivedSyncForRoom:) | 'startDerivedSyncForRoom:'
0x1007a5b80: str      x8, [sp, #0x68] ; 'startDerivedSyncForRoom:'
0x1007a5b84: str      x22, [sp, #0x98] ; 'instanceType'
0x1007a5b88: ldr      x8, [sp, #0xf0]
0x1007a5b8c: ldr      x8, [x8]
0x1007a5b90: cmp      x8, x26
0x1007a5b94: b.eq     #0x1007a5ba0
0x1007a5b98: ldr      x0, [sp, #0xa0]
0x1007a5b9c: bl       #0x107c27c3c ; _objc_enumerationMutation
0x1007a5ba0: ldr      x8, [sp, #0xe8]
0x1007a5ba4: ldr      x21, [x8, x19, lsl #3]
0x1007a5ba8: mov      x0, x21
0x1007a5bac: mov      x1, x22 ; 'instanceType'
0x1007a5bb0: bl       #0x107c27c64 ; _objc_msgSend | selector=instanceType
0x1007a5bb4: cmp      w0, #1
0x1007a5bb8: b.ne     #0x1007a5ecc
0x1007a5bbc: mov      x0, x21
0x1007a5bc0: ldr      x1, [sp, #0xb0]
0x1007a5bc4: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5bc8: mov      x29, x29
0x1007a5bcc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5bd0: mov      x28, x20 ; 'length'
0x1007a5bd4: mov      x27, x0
0x1007a5bd8: mov      x1, x20 ; 'length'
0x1007a5bdc: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1007a5be0: mov      x25, x0
0x1007a5be4: mov      x0, x27
0x1007a5be8: bl       #0x107c27c70 ; _objc_release
0x1007a5bec: cbz      x25, #0x1007a5ecc
0x1007a5bf0: adrp     x8, #0x11ed12000
0x1007a5bf4: ldr      x25, [x8, #0x618] ; classref iConsole | Class iConsole
0x1007a5bf8: mov      x0, x21
0x1007a5bfc: ldr      x1, [sp, #0xb0]
0x1007a5c00: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5c04: mov      x29, x29
0x1007a5c08: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5c0c: mov      x27, x0
0x1007a5c10: mov      x0, x21
0x1007a5c14: ldr      x1, [sp, #0xa8]
0x1007a5c18: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5c1c: stp      x27, x0, [sp, #8]
0x1007a5c20: str      x23, [sp] ; @'onDerivedSyncResult roomName:%@ hasMore:%d'
0x1007a5c24: mov      x0, x25 ; Class iConsole
0x1007a5c28: ldr      x1, [sp, #0x90]
0x1007a5c2c: mov      w2, #2
0x1007a5c30: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5c34: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a5c38: mov      w4, #0
0x1007a5c3c: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5c40: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a5c44: mov      w6, #0x1a3
0x1007a5c48: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5c4c: add      x7, x7, #0xdf6 ; '-[BypChatRoomMgr onDerivedSyncResponse:]'
0x1007a5c50: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5c54: mov      x0, x27
0x1007a5c58: bl       #0x107c27c70 ; _objc_release
0x1007a5c5c: mov      x0, x21
0x1007a5c60: ldr      x22, [sp, #0x88]
0x1007a5c64: mov      x1, x22
0x1007a5c68: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5c6c: mov      x29, x29
0x1007a5c70: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5c74: mov      x25, x0
0x1007a5c78: mov      x1, x20 ; 'length'
0x1007a5c7c: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x1007a5c80: mov      x27, x0
0x1007a5c84: mov      x0, x25
0x1007a5c88: bl       #0x107c27c70 ; _objc_release
0x1007a5c8c: cbz      x27, #0x1007a5dfc
0x1007a5c90: adrp     x8, #0x11ed17000 ; classref BrandAttributedNotificationCellViewModel
0x1007a5c94: ldr      x25, [x8, #0x5e0] ; classref BypChatRoomMemberData | Class BypChatRoomMemberData
0x1007a5c98: mov      x0, x21
0x1007a5c9c: mov      x1, x22
0x1007a5ca0: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5ca4: mov      x29, x29
0x1007a5ca8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5cac: mov      x22, x0
0x1007a5cb0: mov      x0, x25 ; Class BypChatRoomMemberData
0x1007a5cb4: ldr      x1, [sp, #0x70]
0x1007a5cb8: mov      x2, x22
0x1007a5cbc: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5cc0: mov      x29, x29
0x1007a5cc4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5cc8: mov      x27, x0
0x1007a5ccc: mov      x0, x22
0x1007a5cd0: bl       #0x107c27c70 ; _objc_release
0x1007a5cd4: cbz      x27, #0x1007a5df4
0x1007a5cd8: mov      x0, x27
0x1007a5cdc: ldr      x20, [sp, #0x60]
0x1007a5ce0: mov      x1, x20
0x1007a5ce4: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5ce8: mov      x29, x29
0x1007a5cec: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5cf0: mov      x22, x0
0x1007a5cf4: ldr      x1, [sp, #0x58]
0x1007a5cf8: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5cfc: mov      x25, x0
0x1007a5d00: mov      x0, x22
0x1007a5d04: bl       #0x107c27c70 ; _objc_release
0x1007a5d08: cbz      x25, #0x1007a5df4
0x1007a5d0c: mov      x0, x21
0x1007a5d10: ldr      x1, [sp, #0xb0]
0x1007a5d14: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5d18: mov      x29, x29
0x1007a5d1c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5d20: mov      x22, x0
0x1007a5d24: mov      x0, x27
0x1007a5d28: mov      x1, x20
0x1007a5d2c: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5d30: mov      x29, x29
0x1007a5d34: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5d38: mov      x25, x0
0x1007a5d3c: mov      x0, x21
0x1007a5d40: ldr      x1, [sp, #0x78]
0x1007a5d44: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5d48: mov      x29, x29
0x1007a5d4c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5d50: mov      x20, x26
0x1007a5d54: mov      x26, x0
0x1007a5d58: ldr      x0, [sp, #0x80]
0x1007a5d5c: ldr      x1, [sp, #0x50]
0x1007a5d60: mov      x2, x22
0x1007a5d64: mov      x3, x25
0x1007a5d68: mov      x4, x26
0x1007a5d6c: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5d70: mov      x0, x26
0x1007a5d74: mov      x26, x20
0x1007a5d78: adrp     x23, #0x11cfec000
0x1007a5d7c: add      x23, x23, #0xc58 ; @'onDerivedSyncResult roomName:%@ hasMore:%d'
0x1007a5d80: bl       #0x107c27c70 ; _objc_release
0x1007a5d84: mov      x0, x25
0x1007a5d88: bl       #0x107c27c70 ; _objc_release
0x1007a5d8c: mov      x0, x22
0x1007a5d90: bl       #0x107c27c70 ; _objc_release
0x1007a5d94: adrp     x8, #0x11ed12000
0x1007a5d98: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x1007a5d9c: ldr      x1, [sp, #0x48]
0x1007a5da0: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5da4: mov      x29, x29
0x1007a5da8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5dac: mov      x22, x0
0x1007a5db0: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x1007a5db4: ldr      x2, [x8, #0xa10]
0x1007a5db8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a5dbc: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x1007a5dc0: str      x8, [sp, #0xb8]
0x1007a5dc4: str      d8, [sp, #0xc0]
0x1007a5dc8: adrp     x8, #0x1007a5000
0x1007a5dcc: add      x9, x8, #0xf54
0x1007a5dd0: adrp     x8, #0x11c280000
0x1007a5dd4: add      x8, x8, #0x7e0
0x1007a5dd8: stp      x9, x8, [sp, #0xc8]
0x1007a5ddc: str      x21, [sp, #0xd8]
0x1007a5de0: add      x4, sp, #0xb8
0x1007a5de4: ldp      x1, x3, [sp, #0x38]
0x1007a5de8: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5dec: mov      x0, x22
0x1007a5df0: bl       #0x107c27c70 ; _objc_release
0x1007a5df4: ldr      x22, [sp, #0x98]
0x1007a5df8: b        #0x1007a5e80
0x1007a5dfc: mov      x0, x21
0x1007a5e00: ldr      x1, [sp, #0x78]
0x1007a5e04: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e08: mov      x29, x29
0x1007a5e0c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5e10: mov      x22, x0
0x1007a5e14: mov      x1, x20
0x1007a5e18: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e1c: mov      x25, x0
0x1007a5e20: mov      x0, x22
0x1007a5e24: bl       #0x107c27c70 ; _objc_release
0x1007a5e28: ldr      x22, [sp, #0x98]
0x1007a5e2c: cbz      x25, #0x1007a5e8c
0x1007a5e30: mov      x0, x21
0x1007a5e34: ldr      x1, [sp, #0x78]
0x1007a5e38: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e3c: mov      x29, x29
0x1007a5e40: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5e44: mov      x27, x0
0x1007a5e48: mov      x0, x21
0x1007a5e4c: ldr      x1, [sp, #0xb0]
0x1007a5e50: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e54: mov      x29, x29
0x1007a5e58: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5e5c: mov      x22, x0
0x1007a5e60: ldr      x0, [sp, #0x80]
0x1007a5e64: ldr      x1, [sp, #0x30]
0x1007a5e68: mov      x2, x27
0x1007a5e6c: mov      x3, x22
0x1007a5e70: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e74: mov      x0, x22
0x1007a5e78: ldr      x22, [sp, #0x98]
0x1007a5e7c: bl       #0x107c27c70 ; _objc_release
0x1007a5e80: mov      x0, x27
0x1007a5e84: bl       #0x107c27c70 ; _objc_release
0x1007a5e88: mov      x20, x28 ; 'length'
0x1007a5e8c: mov      x0, x21
0x1007a5e90: ldr      x1, [sp, #0xa8]
0x1007a5e94: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5e98: cbz      w0, #0x1007a5ecc
0x1007a5e9c: mov      x0, x21
0x1007a5ea0: ldr      x1, [sp, #0xb0]
0x1007a5ea4: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5ea8: mov      x29, x29
0x1007a5eac: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5eb0: mov      x21, x0
0x1007a5eb4: ldr      x0, [sp, #0x80]
0x1007a5eb8: ldr      x1, [sp, #0x68]
0x1007a5ebc: mov      x2, x21
0x1007a5ec0: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5ec4: mov      x0, x21
0x1007a5ec8: bl       #0x107c27c70 ; _objc_release
0x1007a5ecc: add      x19, x19, #1
0x1007a5ed0: cmp      x24, x19
0x1007a5ed4: b.ne     #0x1007a5b88
0x1007a5ed8: add      x2, sp, #0xe0
0x1007a5edc: sub      x3, x29, #0xf0
0x1007a5ee0: ldr      x0, [sp, #0xa0]
0x1007a5ee4: ldr      x1, [sp, #0x28]
0x1007a5ee8: mov      w4, #0x10
0x1007a5eec: bl       #0x107c27c64 ; _objc_msgSend
0x1007a5ef0: mov      x24, x0
0x1007a5ef4: cbnz     x0, #0x1007a5ae0
0x1007a5ef8: ldr      x0, [sp, #0xa0]
0x1007a5efc: bl       #0x107c27c70 ; _objc_release
0x1007a5f00: ldp      x24, x23, [sp, #0x18]
0x1007a5f04: mov      x0, x24
0x1007a5f08: bl       #0x107c27c70 ; _objc_release
0x1007a5f0c: mov      x0, x23 ; @'onDerivedSyncResult roomName:%@ hasMore:%d'
0x1007a5f10: bl       #0x107c27c70 ; _objc_release
0x1007a5f14: ldur     x8, [x29, #-0x70]
0x1007a5f18: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a5f1c: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x1007a5f20: ldr      x9, [x9]
0x1007a5f24: cmp      x9, x8
0x1007a5f28: b.ne     #0x1007a5f50
0x1007a5f2c: add      sp, sp, #0x1b0
0x1007a5f30: ldp      x29, x30, [sp, #0x60]
0x1007a5f34: ldp      x20, x19, [sp, #0x50] ; 'length'
0x1007a5f38: ldp      x22, x21, [sp, #0x40]
0x1007a5f3c: ldp      x24, x23, [sp, #0x30]
0x1007a5f40: ldp      x26, x25, [sp, #0x20]
0x1007a5f44: ldp      x28, x27, [sp, #0x10] ; 'length'
0x1007a5f48: ldp      d9, d8, [sp], #0x70
0x1007a5f4c: ret      
0x1007a5f50: bl       #0x107c27730 ; ___stack_chk_fail
