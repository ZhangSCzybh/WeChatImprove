-[SyncCmdHandler handleBatchMessages:isFromPushData:ShowPush:] 0x105e410d0 B32@0:8@16B24B28
0x105e410d0: sub      sp, sp, #0x140
0x105e410d4: stp      x28, x27, [sp, #0xe0]
0x105e410d8: stp      x26, x25, [sp, #0xf0]
0x105e410dc: stp      x24, x23, [sp, #0x100]
0x105e410e0: stp      x22, x21, [sp, #0x110]
0x105e410e4: stp      x20, x19, [sp, #0x120]
0x105e410e8: stp      x29, x30, [sp, #0x130]
0x105e410ec: add      x29, sp, #0x130
0x105e410f0: mov      x20, x4
0x105e410f4: mov      x21, x3
0x105e410f8: mov      x19, x2
0x105e410fc: mov      x22, x0
0x105e41100: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e41104: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105e41108: ldr      x8, [x8]
0x105e4110c: stur     x8, [x29, #-0x60]
0x105e41110: adrp     x8, #0x11f755000
0x105e41114: mov      w23, #1
0x105e41118: strb     w23, [x8, #0x8f1]
0x105e4111c: mov      x0, x2
0x105e41120: bl       #0x107c27c74 ; _objc_retain
0x105e41124: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e41128: ldr      x1, [x8, #0x850] ; @selector(count) | 'count'
0x105e4112c: mov      x0, x19
0x105e41130: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105e41134: cbz      x0, #0x105e41278
0x105e41138: stp      w21, w20, [sp, #8]
0x105e4113c: movi     v0.16b, #0
0x105e41140: stp      q0, q0, [sp, #0x30]
0x105e41144: stp      q0, q0, [sp, #0x10]
0x105e41148: mov      x0, x19
0x105e4114c: bl       #0x107c27c74 ; _objc_retain
0x105e41150: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e41154: ldr      x23, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x105e41158: add      x2, sp, #0x10
0x105e4115c: add      x3, sp, #0x50
0x105e41160: mov      x1, x23 ; 'countByEnumeratingWithState:objects:count:'
0x105e41164: mov      w4, #0x10
0x105e41168: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x105e4116c: cbz      x0, #0x105e41208
0x105e41170: mov      x24, x0
0x105e41174: ldr      x8, [sp, #0x20]
0x105e41178: ldr      x28, [x8]
0x105e4117c: adrp     x20, #0x11edd4000
0x105e41180: mov      x21, #0
0x105e41184: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e41188: ldr      x25, [x8, #0x710] ; @selector(processSpecialMessage:) | 'processSpecialMessage:'
0x105e4118c: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105e41190: ldr      x26, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105e41194: ldr      x8, [sp, #0x20]
0x105e41198: ldr      x8, [x8]
0x105e4119c: cmp      x8, x28
0x105e411a0: b.eq     #0x105e411ac
0x105e411a4: mov      x0, x19
0x105e411a8: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e411ac: ldr      x8, [sp, #0x18]
0x105e411b0: ldr      x27, [x8, x21, lsl #3]
0x105e411b4: mov      x0, x22
0x105e411b8: mov      x1, x25 ; 'processSpecialMessage:'
0x105e411bc: mov      x2, x27
0x105e411c0: bl       #0x107c27c64 ; _objc_msgSend | selector=processSpecialMessage:
0x105e411c4: tbnz     w0, #0, #0x105e411dc
0x105e411c8: ldrsw    x8, [x20, #0x5f8] ; ivar_offset SyncCmdHandler.m_arrMsgList=0x8
0x105e411cc: ldr      x0, [x22, x8]
0x105e411d0: mov      x1, x26 ; 'safeAddObject:'
0x105e411d4: mov      x2, x27
0x105e411d8: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e411dc: add      x21, x21, #1
0x105e411e0: cmp      x24, x21
0x105e411e4: b.ne     #0x105e41194
0x105e411e8: add      x2, sp, #0x10
0x105e411ec: add      x3, sp, #0x50
0x105e411f0: mov      x0, x19
0x105e411f4: mov      x1, x23 ; 'countByEnumeratingWithState:objects:count:'
0x105e411f8: mov      w4, #0x10
0x105e411fc: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x105e41200: mov      x24, x0
0x105e41204: cbnz     x0, #0x105e41180
0x105e41208: mov      x0, x19
0x105e4120c: bl       #0x107c27c70 ; _objc_release
0x105e41210: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e41214: ldr      x1, [x8, #0x780] ; @selector(BatchAddMsg:ShowPush:) | 'BatchAddMsg:ShowPush:'
0x105e41218: mov      x0, x22
0x105e4121c: ldp      w2, w3, [sp, #8]
0x105e41220: bl       #0x107c27c64 ; _objc_msgSend | selector=BatchAddMsg:ShowPush:
0x105e41224: tbz      w0, #0, #0x105e41230
0x105e41228: mov      w23, #1
0x105e4122c: b        #0x105e41278
0x105e41230: adrp     x8, #0x11ed12000
0x105e41234: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41238: adrp     x8, #0x11e9c9000
0x105e4123c: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e41240: adrp     x8, #0x11d353000
0x105e41244: add      x8, x8, #0x898 ; @'BatchAddMsg fail'
0x105e41248: str      x8, [sp] ; @'BatchAddMsg fail'
0x105e4124c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e41250: add      x3, x3, #0xfaf ; 'Sync'
0x105e41254: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e41258: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e4125c: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e41260: add      x7, x7, #0x34d ; '-[SyncCmdHandler handleBatchMessages:isFromPushData:ShowPush:]'
0x105e41264: mov      w2, #4
0x105e41268: mov      w4, #0
0x105e4126c: mov      w6, #0x179
0x105e41270: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e41274: mov      w23, #0
0x105e41278: mov      x0, x19
0x105e4127c: bl       #0x107c27c70 ; _objc_release
0x105e41280: ldur     x8, [x29, #-0x60]
0x105e41284: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e41288: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105e4128c: ldr      x9, [x9]
0x105e41290: cmp      x9, x8
0x105e41294: b.ne     #0x105e412bc
0x105e41298: mov      x0, x23 ; 'countByEnumeratingWithState:objects:count:'
0x105e4129c: ldp      x29, x30, [sp, #0x130]
0x105e412a0: ldp      x20, x19, [sp, #0x120]
0x105e412a4: ldp      x22, x21, [sp, #0x110]
0x105e412a8: ldp      x24, x23, [sp, #0x100]
0x105e412ac: ldp      x26, x25, [sp, #0xf0] ; 'safeAddObject:'
0x105e412b0: ldp      x28, x27, [sp, #0xe0]
0x105e412b4: add      sp, sp, #0x140
0x105e412b8: ret      
0x105e412bc: bl       #0x107c27730 ; ___stack_chk_fail
