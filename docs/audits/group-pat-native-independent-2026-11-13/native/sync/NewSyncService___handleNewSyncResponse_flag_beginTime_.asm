-[NewSyncService __handleNewSyncResponse:flag:beginTime:] 0x105464948 v36@0:8@16I24Q28
0x105464948: sub      sp, sp, #0x120
0x10546494c: stp      x28, x27, [sp, #0xc0]
0x105464950: stp      x26, x25, [sp, #0xd0]
0x105464954: stp      x24, x23, [sp, #0xe0]
0x105464958: stp      x22, x21, [sp, #0xf0]
0x10546495c: stp      x20, x19, [sp, #0x100]
0x105464960: stp      x29, x30, [sp, #0x110]
0x105464964: add      x29, sp, #0x110
0x105464968: mov      x23, x4
0x10546496c: mov      x26, x3
0x105464970: mov      x19, x2
0x105464974: mov      x24, x0
0x105464978: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x10546497c: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105464980: ldr      x8, [x8]
0x105464984: stur     x8, [x29, #-0x60]
0x105464988: adrp     x8, #0x11f753000
0x10546498c: mov      w9, #1
0x105464990: strb     w9, [x8, #0x482]
0x105464994: mov      x0, x2
0x105464998: bl       #0x107c27c74 ; _objc_retain
0x10546499c: adrp     x27, #0x11ed12000
0x1054649a0: ldr      x0, [x27, #0x9d0] ; classref SettingUtil | Class SettingUtil
0x1054649a4: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x1054649a8: ldr      x20, [x8, #0xbf8] ; @selector(getMainSetting) | 'getMainSetting'
0x1054649ac: mov      x1, x20 ; 'getMainSetting'
0x1054649b0: bl       #0x107c27c64 ; _objc_msgSend | selector=getMainSetting
0x1054649b4: mov      x29, x29
0x1054649b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054649bc: mov      x21, x0
0x1054649c0: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1054649c4: ldr      x1, [x8, #0xac0] ; @selector(isMessagePushEnabled) | 'isMessagePushEnabled'
0x1054649c8: bl       #0x107c27c64 ; _objc_msgSend | selector=isMessagePushEnabled
0x1054649cc: mov      x22, x0
0x1054649d0: mov      x0, x21
0x1054649d4: bl       #0x107c27c70 ; _objc_release
0x1054649d8: tst      w26, #2
0x1054649dc: csel     w25, wzr, w22, ne
0x1054649e0: adrp     x8, #0x11ea4d000 ; @selector(ConvertImg2MsgWrap:)
0x1054649e4: ldr      x21, [x8, #0x528] ; @selector(keyBuf) | 'keyBuf'
0x1054649e8: mov      x0, x19
0x1054649ec: mov      x1, x21 ; 'keyBuf'
0x1054649f0: bl       #0x107c27c64 ; _objc_msgSend | selector=keyBuf
0x1054649f4: mov      x29, x29
0x1054649f8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1054649fc: mov      x22, x0
0x105464a00: adrp     x8, #0x11e9d4000 ; @selector(isVoiceTranscriptionMatchedWithChatName:audioId:)
0x105464a04: ldr      x1, [x8, #0x1c8] ; @selector(iLen) | 'iLen'
0x105464a08: bl       #0x107c27c64 ; _objc_msgSend | selector=iLen
0x105464a0c: cbz      w0, #0x105464b48
0x105464a10: str      w25, [sp, #0x2c]
0x105464a14: str      x23, [sp, #0x20]
0x105464a18: mov      x0, x19
0x105464a1c: mov      x1, x21 ; 'keyBuf'
0x105464a20: bl       #0x107c27c64 ; _objc_msgSend | selector=keyBuf
0x105464a24: mov      x29, x29
0x105464a28: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464a2c: mov      x28, x0
0x105464a30: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105464a34: ldr      x23, [x8, #0x388] ; @selector(buffer) | 'buffer'
0x105464a38: mov      x1, x23 ; 'buffer'
0x105464a3c: bl       #0x107c27c64 ; _objc_msgSend | selector=buffer
0x105464a40: mov      x29, x29
0x105464a44: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464a48: mov      x25, x0
0x105464a4c: bl       #0x107c27c70 ; _objc_release
0x105464a50: mov      x0, x28
0x105464a54: bl       #0x107c27c70 ; _objc_release
0x105464a58: mov      x0, x22
0x105464a5c: bl       #0x107c27c70 ; _objc_release
0x105464a60: cbz      x25, #0x105464b50
0x105464a64: mov      x0, x19
0x105464a68: mov      x1, x21 ; 'keyBuf'
0x105464a6c: bl       #0x107c27c64 ; _objc_msgSend | selector=keyBuf
0x105464a70: mov      x29, x29
0x105464a74: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464a78: mov      x21, x0
0x105464a7c: mov      x1, x23 ; 'buffer'
0x105464a80: bl       #0x107c27c64 ; _objc_msgSend | selector=buffer
0x105464a84: mov      x29, x29
0x105464a88: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464a8c: mov      x25, x0
0x105464a90: mov      x0, x21
0x105464a94: bl       #0x107c27c70 ; _objc_release
0x105464a98: adrp     x8, #0x11edca000
0x105464a9c: ldrsw    x8, [x8, #0x90c] ; ivar_offset NewSyncService.m_oLock=0x38
0x105464aa0: ldr      x1, [x24, x8]
0x105464aa4: sub      x0, x29, #0x78
0x105464aa8: bl       #0x107c0ccb0
0x105464aac: ldr      x0, [x27, #0x9d0] ; classref SettingUtil | Class SettingUtil
0x105464ab0: mov      x1, x20 ; 'getMainSetting'
0x105464ab4: bl       #0x107c27c64 ; _objc_msgSend | selector=getMainSetting
0x105464ab8: mov      x29, x29
0x105464abc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464ac0: mov      x20, x0
0x105464ac4: cbz      x0, #0x105464bc4
0x105464ac8: adrp     x8, #0x11ed12000
0x105464acc: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105464ad0: adrp     x8, #0x11e9c9000
0x105464ad4: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105464ad8: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105464adc: mov      x29, x29
0x105464ae0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464ae4: mov      x22, x0
0x105464ae8: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105464aec: ldr      x0, [x8, #0xe98] ; classref AccountStorageMgr | Class AccountStorageMgr
0x105464af0: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105464af4: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105464af8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105464afc: mov      x2, x0
0x105464b00: adrp     x8, #0x11e9c9000
0x105464b04: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105464b08: mov      x0, x22
0x105464b0c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105464b10: mov      x29, x29
0x105464b14: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464b18: mov      x23, x0
0x105464b1c: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105464b20: ldr      x1, [x8, #0x628] ; @selector(GetSyncBuffer) | 'GetSyncBuffer'
0x105464b24: bl       #0x107c27c64 ; _objc_msgSend | selector=GetSyncBuffer
0x105464b28: mov      x29, x29
0x105464b2c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464b30: mov      x21, x0
0x105464b34: mov      x0, x23
0x105464b38: bl       #0x107c27c70 ; _objc_release
0x105464b3c: mov      x0, x22
0x105464b40: bl       #0x107c27c70 ; _objc_release
0x105464b44: b        #0x105464bc8
0x105464b48: mov      x0, x22
0x105464b4c: bl       #0x107c27c70 ; _objc_release
0x105464b50: adrp     x8, #0x11ed12000
0x105464b54: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105464b58: adrp     x8, #0x11e9c9000
0x105464b5c: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464b60: adrp     x8, #0x11d2f7000
0x105464b64: add      x8, x8, #0x1d8 ; @'oNewSyncResp.tKeyBuf error'
0x105464b68: str      x8, [sp] ; @'oNewSyncResp.tKeyBuf error'
0x105464b6c: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464b70: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464b74: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464b78: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105464b7c: mov      w2, #4
0x105464b80: mov      x3, #0
0x105464b84: mov      w4, #0
0x105464b88: mov      w6, #0x2ff
0x105464b8c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464b90: mov      w0, #0x90
0x105464b94: mov      w1, #0xc
0x105464b98: mov      w2, #1
0x105464b9c: mov      w3, #0
0x105464ba0: mov      w4, #0
0x105464ba4: bl       #0x1020ea20c
0x105464ba8: adrp     x1, #0x11d2f7000
0x105464bac: add      x1, x1, #0x1f8 ; @'12,0'
0x105464bb0: mov      w0, #0x8ab9
0x105464bb4: mov      w2, #0
0x105464bb8: mov      w3, #0
0x105464bbc: bl       #0x10241a0cc
0x105464bc0: b        #0x1054651c8
0x105464bc4: mov      x21, #0
0x105464bc8: mov      x0, x20
0x105464bcc: bl       #0x107c27c70 ; _objc_release
0x105464bd0: sub      x0, x29, #0x78
0x105464bd4: bl       #0x107c0ccb4
0x105464bd8: adrp     x8, #0x11ed12000
0x105464bdc: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x105464be0: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105464be4: ldr      x1, [x8, #0xc20] ; @selector(MergeSyncBuffer:NewBuffer:) | 'MergeSyncBuffer:NewBuffer:'
0x105464be8: stp      x21, x25, [sp, #0x30]
0x105464bec: mov      x2, x21
0x105464bf0: mov      x3, x25
0x105464bf4: bl       #0x107c27c64 ; _objc_msgSend | selector=MergeSyncBuffer:NewBuffer:
0x105464bf8: mov      x29, x29
0x105464bfc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464c00: mov      x22, x0
0x105464c04: stp      xzr, xzr, [x29, #-0x78]
0x105464c08: stur     xzr, [x29, #-0x68]
0x105464c0c: bl       #0x107c27c78 ; _objc_retainAutorelease
0x105464c10: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105464c14: ldr      x1, [x8, #0x1e0] ; @selector(bytes) | 'bytes'
0x105464c18: bl       #0x107c27c64 ; _objc_msgSend | selector=bytes
0x105464c1c: mov      x20, x0
0x105464c20: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105464c24: ldr      x28, [x8, #0xce8] ; @selector(length) | 'length'
0x105464c28: mov      x0, x22
0x105464c2c: mov      x1, x28 ; 'length'
0x105464c30: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464c34: mov      x2, x0
0x105464c38: sub      x0, x29, #0x78
0x105464c3c: mov      x1, x20
0x105464c40: bl       #0x107c0cce4
0x105464c44: adrp     x8, #0x11ed1f000 ; classref FavTempNavPlaceholderViewController
0x105464c48: ldr      x0, [x8, #0x958] ; classref SyncKey | Class SyncKey
0x105464c4c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105464c50: ldr      x1, [x8, #0x738] ; @selector(parseFromData:) | 'parseFromData:'
0x105464c54: mov      x2, x22
0x105464c58: bl       #0x107c27c64 ; _objc_msgSend | selector=parseFromData:
0x105464c5c: mov      x29, x29
0x105464c60: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464c64: mov      x23, x0
0x105464c68: cmp      x0, #0
0x105464c6c: cset     w27, ne
0x105464c70: adrp     x8, #0x11ed12000
0x105464c74: ldr      x25, [x8, #0x618] ; classref iConsole | Class iConsole
0x105464c78: mov      x0, x22
0x105464c7c: mov      x1, x28 ; 'length'
0x105464c80: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105464c84: mov      x21, x0
0x105464c88: add      x20, sp, #0x70
0x105464c8c: add      x8, sp, #0x70
0x105464c90: sub      x0, x29, #0x78
0x105464c94: bl       #0x107c0ccdc
0x105464c98: ldrsb    w8, [sp, #0x87]
0x105464c9c: ldr      x9, [sp, #0x70]
0x105464ca0: cmp      w8, #0
0x105464ca4: csel     x8, x9, x20, lt
0x105464ca8: adrp     x9, #0x11e9c9000
0x105464cac: ldr      x20, [x9, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464cb0: stp      x27, x8, [sp, #0x10]
0x105464cb4: adrp     x8, #0x11d2f7000
0x105464cb8: add      x8, x8, #0x218 ; @'new sync push merge len %lu ret %d md5 %s'
0x105464cbc: stp      x8, x21, [sp] ; @'new sync push merge len %lu ret %d md5 %s'
0x105464cc0: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464cc4: add      x3, x3, #0xfaf ; 'Sync'
0x105464cc8: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464ccc: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464cd0: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464cd4: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105464cd8: mov      x0, x25 ; Class iConsole
0x105464cdc: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464ce0: mov      w2, #2
0x105464ce4: mov      w4, #0
0x105464ce8: mov      w6, #0x315
0x105464cec: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464cf0: ldrsb    w8, [sp, #0x87]
0x105464cf4: tbz      w8, #0x1f, #0x105464d08
0x105464cf8: ldr      x0, [sp, #0x70]
0x105464cfc: ldr      x8, [sp, #0x80]
0x105464d00: and      x1, x8, #0x7fffffffffffffff
0x105464d04: bl       #0x107c276f0 ; __ZdlPvm
0x105464d08: adrp     x8, #0x11edca000
0x105464d0c: ldrsw    x25, [x8, #0x910] ; ivar_offset NewSyncService.m_bSyncOpError=0x4a
0x105464d10: ldrb     w8, [x24, x25]
0x105464d14: adrp     x9, #0x11edca000
0x105464d18: ldrsw    x21, [x9, #0x8e4] ; ivar_offset NewSyncService.m_bIsSyncPause=0x54
0x105464d1c: ldrb     w9, [x24, x21]
0x105464d20: adrp     x10, #0x11edca000
0x105464d24: cmp      w8, #1
0x105464d28: b.ne     #0x105464d34
0x105464d2c: ldr      w27, [x10, #0x920] ; ivar_offset NewSyncService.m_bSyncOperating=0x4b
0x105464d30: b        #0x105464d54
0x105464d34: ldr      w27, [x10, #0x920] ; ivar_offset NewSyncService.m_bSyncOperating=0x4b
0x105464d38: tbz      w9, #0, #0x105464d44
0x105464d3c: mov      w9, #1
0x105464d40: b        #0x105464d54
0x105464d44: ldrb     w9, [x24, w27, sxtw]
0x105464d48: cmp      w9, #1
0x105464d4c: b.ne     #0x105464e60
0x105464d50: mov      w9, #0
0x105464d54: adrp     x10, #0x11ed12000
0x105464d58: ldr      x0, [x10, #0x618] ; classref iConsole | Class iConsole
0x105464d5c: ldrb     w10, [x24, w27, sxtw]
0x105464d60: stp      x9, x10, [sp, #0x10]
0x105464d64: adrp     x9, #0x11d2f7000
0x105464d68: add      x9, x9, #0x238 ; @'push data ignore, syncOpError %d, syncPause %d operating %d'
0x105464d6c: stp      x9, x8, [sp] ; @'push data ignore, syncOpError %d, syncPause %d operating %d'
0x105464d70: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105464d74: add      x3, x3, #0xfaf ; 'Sync'
0x105464d78: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x105464d7c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105464d80: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464d84: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105464d88: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464d8c: mov      w2, #4
0x105464d90: mov      w4, #0
0x105464d94: mov      w6, #0x319
0x105464d98: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464d9c: mov      w0, #0x90
0x105464da0: mov      w1, #7
0x105464da4: mov      w2, #1
0x105464da8: mov      w3, #0
0x105464dac: mov      w4, #0
0x105464db0: bl       #0x1020ea20c
0x105464db4: adrp     x1, #0x11d2f7000
0x105464db8: add      x1, x1, #0x258 ; @'7,0'
0x105464dbc: mov      w0, #0x8ab9
0x105464dc0: mov      w2, #0
0x105464dc4: mov      w3, #0
0x105464dc8: bl       #0x10241a0cc
0x105464dcc: ldrb     w8, [x24, x25]
0x105464dd0: cmp      w8, #1
0x105464dd4: b.ne     #0x105464e0c
0x105464dd8: mov      w0, #0x90
0x105464ddc: mov      w1, #0x1e
0x105464de0: mov      w2, #1
0x105464de4: mov      w3, #0
0x105464de8: mov      w4, #0
0x105464dec: bl       #0x1020ea20c
0x105464df0: adrp     x1, #0x11d2f7000
0x105464df4: add      x1, x1, #0x278 ; @'30,0'
0x105464df8: mov      w0, #0x8ab9
0x105464dfc: mov      w2, #0
0x105464e00: mov      w3, #0
0x105464e04: bl       #0x10241a0cc
0x105464e08: b        #0x10546519c
0x105464e0c: ldrb     w8, [x24, x21]
0x105464e10: cmp      w8, #1
0x105464e14: b.ne     #0x105464e34
0x105464e18: mov      w0, #0x90
0x105464e1c: mov      w1, #0x1f
0x105464e20: mov      w2, #1
0x105464e24: mov      w3, #0
0x105464e28: mov      w4, #0
0x105464e2c: bl       #0x1020ea20c
0x105464e30: b        #0x10546519c
0x105464e34: ldrb     w8, [x24, w27, sxtw]
0x105464e38: cmp      w8, #1
0x105464e3c: ldr      x27, [sp, #0x30]
0x105464e40: b.ne     #0x1054651a0
0x105464e44: mov      w0, #0x90
0x105464e48: mov      w1, #0x21
0x105464e4c: mov      w2, #1
0x105464e50: mov      w3, #0
0x105464e54: mov      w4, #0
0x105464e58: bl       #0x1020ea20c
0x105464e5c: b        #0x1054651a0
0x105464e60: adrp     x8, #0x11edca000
0x105464e64: ldrsw    x8, [x8, #0x8f0] ; ivar_offset NewSyncService.m_lastSyncFinishCallingExtension=0x4c
0x105464e68: strb     wzr, [x24, x8]
0x105464e6c: adrp     x8, #0x11ed12000
0x105464e70: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105464e74: adrp     x8, #0x11e9c9000
0x105464e78: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105464e7c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105464e80: mov      x29, x29
0x105464e84: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464e88: mov      x21, x0
0x105464e8c: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105464e90: ldr      x2, [x8, #0x760]
0x105464e94: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105464e98: ldr      x3, [x8, #0xa50] ; @selector(onNewSyncBegin) | 'onNewSyncBegin'
0x105464e9c: adrp     x8, #0x11e9c9000
0x105464ea0: ldr      x1, [x8, #0xf70] ; @selector(callExtensionOnMainThread:selector:sync:block:) | 'callExtensionOnMainThread:selector:sync:block:'
0x105464ea4: adrp     x5, #0x11c2fd000
0x105464ea8: add      x5, x5, #0xf28 ; __NSConcreteGlobalBlock
0x105464eac: mov      w4, #0
0x105464eb0: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtensionOnMainThread:selector:sync:block:
0x105464eb4: mov      x0, x21
0x105464eb8: bl       #0x107c27c70 ; _objc_release
0x105464ebc: adrp     x8, #0x11ed12000
0x105464ec0: ldr      x0, [x8, #0x6c8] ; _OBJC_CLASS_$_NSNotificationCenter
0x105464ec4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105464ec8: ldr      x1, [x8, #0xcd0] ; @selector(defaultCenter) | 'defaultCenter'
0x105464ecc: bl       #0x107c27c64 ; _objc_msgSend | selector=defaultCenter
0x105464ed0: mov      x29, x29
0x105464ed4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464ed8: mov      x27, x0
0x105464edc: adrp     x8, #0x11d2e9000
0x105464ee0: add      x8, x8, #0x178 ; @'isFromPush'
0x105464ee4: str      x8, [sp, #0x88] ; @'isFromPush'
0x105464ee8: adrp     x8, #0x11ed12000
0x105464eec: ldr      x0, [x8, #0x6c0] ; _OBJC_CLASS_$_NSNumber
0x105464ef0: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105464ef4: ldr      x1, [x8, #0x588] ; @selector(numberWithBool:) | 'numberWithBool:'
0x105464ef8: mov      w2, #1
0x105464efc: bl       #0x107c27c64 ; _objc_msgSend | selector=numberWithBool:
0x105464f00: mov      x29, x29
0x105464f04: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464f08: mov      x25, x0
0x105464f0c: stur     x0, [x29, #-0x80]
0x105464f10: adrp     x8, #0x11ed12000
0x105464f14: ldr      x0, [x8, #0x698] ; _OBJC_CLASS_$_NSDictionary
0x105464f18: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105464f1c: ldr      x1, [x8, #0xfc0] ; @selector(dictionaryWithObjects:forKeys:count:) | 'dictionaryWithObjects:forKeys:count:'
0x105464f20: sub      x2, x29, #0x80
0x105464f24: add      x3, sp, #0x88
0x105464f28: mov      w4, #1
0x105464f2c: bl       #0x107c27c64 ; _objc_msgSend | selector=dictionaryWithObjects:forKeys:count:
0x105464f30: mov      x29, x29
0x105464f34: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105464f38: mov      x21, x0
0x105464f3c: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105464f40: ldr      x1, [x8, #0xf08] ; @selector(postNotificationName:object:userInfo:) | 'postNotificationName:object:userInfo:'
0x105464f44: adrp     x2, #0x11d2e8000
0x105464f48: add      x2, x2, #0xcd8 ; @'NewSyncBeginNotifyEvent'
0x105464f4c: mov      x0, x27
0x105464f50: mov      x3, #0
0x105464f54: mov      x4, x21
0x105464f58: bl       #0x107c27c64 ; _objc_msgSend | selector=postNotificationName:object:userInfo:
0x105464f5c: mov      x0, x21
0x105464f60: bl       #0x107c27c70 ; _objc_release
0x105464f64: mov      x0, x25
0x105464f68: bl       #0x107c27c70 ; _objc_release
0x105464f6c: mov      x0, x27
0x105464f70: bl       #0x107c27c70 ; _objc_release
0x105464f74: mov      x0, x19
0x105464f78: mov      w1, #1
0x105464f7c: ldr      w2, [sp, #0x2c]
0x105464f80: bl       #0x10545e124
0x105464f84: mov      x21, x0
0x105464f88: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105464f8c: ldr      x1, [x8, #0xc30] ; @selector(HandleSyncResp:handleResult:) | 'HandleSyncResp:handleResult:'
0x105464f90: mov      x0, x24
0x105464f94: mov      x2, x19
0x105464f98: mov      x3, x21
0x105464f9c: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleSyncResp:handleResult:
0x105464fa0: tbz      w21, #0, #0x10546515c
0x105464fa4: ldr      x27, [sp, #0x30]
0x105464fa8: tbz      w26, #0, #0x1054651a0
0x105464fac: adrp     x25, #0x11ed12000
0x105464fb0: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105464fb4: adrp     x8, #0x11d2f7000
0x105464fb8: add      x8, x8, #0x2b8 ; @'send new sync push ack'
0x105464fbc: str      x8, [sp] ; @'send new sync push ack'
0x105464fc0: adrp     x21, #0x119cf5000 ; 'ns_filled_pause2'
0x105464fc4: add      x21, x21, #0xfaf ; 'Sync'
0x105464fc8: adrp     x24, #0x11a21f000 ; 'llu,%llu'
0x105464fcc: add      x24, x24, #0xad1 ; 'NewSyncService.mm'
0x105464fd0: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105464fd4: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105464fd8: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105464fdc: mov      w2, #2
0x105464fe0: mov      x3, x21 ; 'Sync'
0x105464fe4: mov      w4, #0
0x105464fe8: mov      x5, x24 ; 'NewSyncService.mm'
0x105464fec: mov      w6, #0x33b
0x105464ff0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105464ff4: adrp     x8, #0x11ed12000
0x105464ff8: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x105464ffc: adrp     x8, #0x11e9c9000
0x105465000: ldr      x1, [x8, #0xf20] ; @selector(genCurrentTimeInMs) | 'genCurrentTimeInMs'
0x105465004: bl       #0x107c27c64 ; _objc_msgSend | selector=genCurrentTimeInMs
0x105465008: ldr      x8, [sp, #0x20]
0x10546500c: sub      x26, x0, x8
0x105465010: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x105465014: adrp     x8, #0x11d2f7000
0x105465018: add      x8, x8, #0x2d8 ; @'send new sync push ack cost %u'
0x10546501c: stp      x8, x26, [sp] ; @'send new sync push ack cost %u'
0x105465020: mov      x1, x20 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105465024: mov      w2, #2
0x105465028: mov      x3, x21 ; 'Sync'
0x10546502c: mov      w4, #0
0x105465030: mov      x5, x24 ; 'NewSyncService.mm'
0x105465034: mov      w6, #0x340
0x105465038: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x10546503c: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105465040: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105465044: adrp     x8, #0x11ed12000
0x105465048: ldr      x0, [x8, #0x910] ; _OBJC_CLASS_$_NSMutableData
0x10546504c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105465050: ldr      x1, [x8, #0xb50] ; @selector(data) | 'data'
0x105465054: bl       #0x107c27c64 ; _objc_msgSend | selector=data
0x105465058: mov      x29, x29
0x10546505c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105465060: mov      x20, x0
0x105465064: rev      w8, w26
0x105465068: str      w8, [sp, #0x70]
0x10546506c: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105465070: ldr      x21, [x8, #0xcf0] ; @selector(appendBytes:length:) | 'appendBytes:length:'
0x105465074: add      x2, sp, #0x70
0x105465078: mov      x1, x21 ; 'appendBytes:length:'
0x10546507c: mov      w3, #4
0x105465080: bl       #0x107c27c64 ; _objc_msgSend | selector=appendBytes:length:
0x105465084: mov      x0, x22
0x105465088: mov      x1, x28 ; 'length'
0x10546508c: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105465090: rev      w8, w0
0x105465094: str      w8, [sp, #0x6c]
0x105465098: add      x2, sp, #0x6c
0x10546509c: mov      x0, x20
0x1054650a0: mov      x1, x21 ; 'appendBytes:length:'
0x1054650a4: mov      w3, #4
0x1054650a8: bl       #0x107c27c64 ; _objc_msgSend | selector=appendBytes:length:
0x1054650ac: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x1054650b0: ldr      x1, [x8, #0xcf8] ; @selector(appendData:) | 'appendData:'
0x1054650b4: mov      x0, x20
0x1054650b8: mov      x2, x22
0x1054650bc: bl       #0x107c27c64 ; _objc_msgSend | selector=appendData:
0x1054650c0: adrp     x8, #0x11ed1e000 ; classref MainSessionInfoItem
0x1054650c4: ldr      x0, [x8, #0x20] ; classref NetCmdSendOnlyEvent | Class NetCmdSendOnlyEvent
0x1054650c8: bl       #0x107c27c0c ; _objc_alloc_init
0x1054650cc: mov      x21, x0
0x1054650d0: mov      w0, #0x10
0x1054650d4: bl       #0x107c276f8 ; __Znwm
0x1054650d8: mov      x24, x0
0x1054650dc: mov      x1, x20
0x1054650e0: bl       #0x105322924
0x1054650e4: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054650e8: ldr      x1, [x8, #0xb98] ; @selector(setM_netcmd:) | 'setM_netcmd:'
0x1054650ec: mov      x0, x21
0x1054650f0: mov      x2, x24
0x1054650f4: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_netcmd:
0x1054650f8: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1054650fc: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105465100: str      x8, [sp, #0x40]
0x105465104: adrp     x8, #0x1178c7000
0x105465108: ldr      d0, [x8, #0x680]
0x10546510c: adrp     x8, #0x105465000
0x105465110: add      x8, x8, #0x21c
0x105465114: str      d0, [sp, #0x48]
0x105465118: adrp     x9, #0x11c280000
0x10546511c: add      x9, x9, #0x470
0x105465120: stp      x8, x9, [sp, #0x50]
0x105465124: str      x21, [sp, #0x60]
0x105465128: mov      x0, x21
0x10546512c: bl       #0x107c27c74 ; _objc_retain
0x105465130: adrp     x0, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105465134: ldr      x0, [x0, #0xa98] ; __dispatch_main_q
0x105465138: add      x1, sp, #0x40
0x10546513c: bl       #0x107c0cb9c
0x105465140: ldr      x0, [sp, #0x60]
0x105465144: bl       #0x107c27c70 ; _objc_release
0x105465148: mov      x0, x21
0x10546514c: bl       #0x107c27c70 ; _objc_release
0x105465150: mov      x0, x20
0x105465154: bl       #0x107c27c70 ; _objc_release
0x105465158: b        #0x1054651a0
0x10546515c: adrp     x8, #0x11ed12000
0x105465160: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105465164: adrp     x8, #0x11d2f7000
0x105465168: add      x8, x8, #0x298 ; @'do not send ack'
0x10546516c: str      x8, [sp] ; @'do not send ack'
0x105465170: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105465174: add      x3, x3, #0xfaf ; 'Sync'
0x105465178: adrp     x5, #0x11a21f000 ; 'llu,%llu'
0x10546517c: add      x5, x5, #0xad1 ; 'NewSyncService.mm'
0x105465180: adrp     x7, #0x11a220000 ; 'p:handleResult:]'
0x105465184: add      x7, x7, #0x2d3 ; '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
0x105465188: mov      x1, x20
0x10546518c: mov      w2, #2
0x105465190: mov      w4, #0
0x105465194: mov      w6, #0x335
0x105465198: bl       #0x107c27c64 ; _objc_msgSend
0x10546519c: ldr      x27, [sp, #0x30]
0x1054651a0: mov      x0, x23
0x1054651a4: bl       #0x107c27c70 ; _objc_release
0x1054651a8: sub      x0, x29, #0x78
0x1054651ac: bl       #0x107c0ccd8
0x1054651b0: mov      x0, x22
0x1054651b4: bl       #0x107c27c70 ; _objc_release
0x1054651b8: mov      x0, x27
0x1054651bc: bl       #0x107c27c70 ; _objc_release
0x1054651c0: ldr      x0, [sp, #0x38]
0x1054651c4: bl       #0x107c27c70 ; _objc_release
0x1054651c8: mov      x0, x19
0x1054651cc: bl       #0x107c27c70 ; _objc_release
0x1054651d0: ldur     x8, [x29, #-0x60]
0x1054651d4: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1054651d8: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x1054651dc: ldr      x9, [x9]
0x1054651e0: cmp      x9, x8
0x1054651e4: b.ne     #0x105465208
0x1054651e8: ldp      x29, x30, [sp, #0x110]
0x1054651ec: ldp      x20, x19, [sp, #0x100]
0x1054651f0: ldp      x22, x21, [sp, #0xf0]
0x1054651f4: ldp      x24, x23, [sp, #0xe0]
0x1054651f8: ldp      x26, x25, [sp, #0xd0]
0x1054651fc: ldp      x28, x27, [sp, #0xc0] ; 'length'
0x105465200: add      sp, sp, #0x120
0x105465204: ret      
0x105465208: bl       #0x107c27730 ; ___stack_chk_fail
