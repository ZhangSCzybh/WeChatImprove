-[BypChatRoomMgr flushDerivedSyncBatch] 0x1007a50d8 v16@0:8
0x1007a50d8: sub      sp, sp, #0x180
0x1007a50dc: stp      x28, x27, [sp, #0x120]
0x1007a50e0: stp      x26, x25, [sp, #0x130]
0x1007a50e4: stp      x24, x23, [sp, #0x140]
0x1007a50e8: stp      x22, x21, [sp, #0x150]
0x1007a50ec: stp      x20, x19, [sp, #0x160]
0x1007a50f0: stp      x29, x30, [sp, #0x170]
0x1007a50f4: add      x29, sp, #0x170
0x1007a50f8: mov      x24, x0
0x1007a50fc: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a5100: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x1007a5104: ldr      x8, [x8]
0x1007a5108: stur     x8, [x29, #-0x60]
0x1007a510c: adrp     x8, #0x11f741000
0x1007a5110: mov      w9, #1
0x1007a5114: strb     w9, [x8, #0xbba]
0x1007a5118: adrp     x8, #0x11ed82000
0x1007a511c: ldrsw    x8, [x8, #0x1a0] ; ivar_offset BypChatRoomMgr._derivedSyncTimerScheduled=0x10
0x1007a5120: strb     wzr, [x0, x8]
0x1007a5124: adrp     x8, #0x11ed82000
0x1007a5128: ldrsw    x21, [x8, #0x19c] ; ivar_offset BypChatRoomMgr._pendingDerivedSyncRooms=0x8
0x1007a512c: ldr      x0, [x0, x21]
0x1007a5130: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a5134: ldr      x20, [x8, #0x850] ; @selector(count) | 'count'
0x1007a5138: mov      x1, x20 ; 'count'
0x1007a513c: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x1007a5140: cbz      x0, #0x1007a5468
0x1007a5144: str      x20, [sp, #0x20] ; 'count'
0x1007a5148: adrp     x8, #0x11ed12000
0x1007a514c: ldr      x0, [x8, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x1007a5150: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x1007a5154: ldr      x1, [x8, #0xd88] ; @selector(array) | 'array'
0x1007a5158: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x1007a515c: mov      x29, x29
0x1007a5160: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5164: str      x0, [sp, #0x40]
0x1007a5168: movi     v0.16b, #0
0x1007a516c: stp      q0, q0, [sp, #0x50]
0x1007a5170: stp      q0, q0, [sp, #0x70]
0x1007a5174: str      x21, [sp, #0x18]
0x1007a5178: ldr      x0, [x24, x21]
0x1007a517c: bl       #0x107c27c74 ; _objc_retain
0x1007a5180: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a5184: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x1007a5188: add      x2, sp, #0x50
0x1007a518c: add      x3, sp, #0x90
0x1007a5190: stp      x1, x0, [sp, #0x28] ; 'countByEnumeratingWithState:objects:count:'
0x1007a5194: mov      w4, #0x10
0x1007a5198: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x1007a519c: str      x0, [sp, #0x48]
0x1007a51a0: cbz      x0, #0x1007a52a4
0x1007a51a4: ldr      x8, [sp, #0x60]
0x1007a51a8: ldr      x8, [x8]
0x1007a51ac: str      x8, [sp, #0x38]
0x1007a51b0: mov      x22, #0
0x1007a51b4: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a51b8: ldr      x25, [x8, #0xcb0] ; @selector(getDerivedSyncKey:) | 'getDerivedSyncKey:'
0x1007a51bc: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a51c0: ldr      x26, [x8, #0xcc8] ; @selector(setInstanceType:) | 'setInstanceType:'
0x1007a51c4: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a51c8: ldr      x27, [x8, #0xcd0] ; @selector(setInstanceId:) | 'setInstanceId:'
0x1007a51cc: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x1007a51d0: ldr      x28, [x8, #0xcd8] ; @selector(setSyncKey:) | 'setSyncKey:'
0x1007a51d4: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x1007a51d8: ldr      x21, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x1007a51dc: ldr      x8, [sp, #0x60]
0x1007a51e0: ldr      x8, [x8]
0x1007a51e4: ldr      x9, [sp, #0x38]
0x1007a51e8: cmp      x8, x9
0x1007a51ec: b.eq     #0x1007a51f8
0x1007a51f0: ldr      x0, [sp, #0x30]
0x1007a51f4: bl       #0x107c27c3c ; _objc_enumerationMutation
0x1007a51f8: ldr      x8, [sp, #0x58]
0x1007a51fc: ldr      x23, [x8, x22, lsl #3]
0x1007a5200: mov      x0, x24
0x1007a5204: mov      x1, x25 ; 'getDerivedSyncKey:'
0x1007a5208: mov      x2, x23
0x1007a520c: bl       #0x107c27c64 ; _objc_msgSend | selector=getDerivedSyncKey:
0x1007a5210: mov      x29, x29
0x1007a5214: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5218: mov      x19, x0
0x1007a521c: adrp     x8, #0x11ed17000 ; classref BrandAttributedNotificationCellViewModel
0x1007a5220: ldr      x0, [x8, #0x5e8] ; classref DerivedSyncKey | Class DerivedSyncKey
0x1007a5224: bl       #0x107c27c0c ; _objc_alloc_init
0x1007a5228: mov      x20, x0
0x1007a522c: mov      x1, x26 ; 'setInstanceType:'
0x1007a5230: mov      w2, #1
0x1007a5234: bl       #0x107c27c64 ; _objc_msgSend | selector=setInstanceType:
0x1007a5238: mov      x0, x20
0x1007a523c: mov      x1, x27 ; 'setInstanceId:'
0x1007a5240: mov      x2, x23
0x1007a5244: bl       #0x107c27c64 ; _objc_msgSend | selector=setInstanceId:
0x1007a5248: mov      x0, x20
0x1007a524c: mov      x1, x28 ; 'setSyncKey:'
0x1007a5250: mov      x2, x19
0x1007a5254: bl       #0x107c27c64 ; _objc_msgSend | selector=setSyncKey:
0x1007a5258: ldr      x0, [sp, #0x40]
0x1007a525c: mov      x1, x21 ; 'safeAddObject:'
0x1007a5260: mov      x2, x20
0x1007a5264: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x1007a5268: mov      x0, x20
0x1007a526c: bl       #0x107c27c70 ; _objc_release
0x1007a5270: mov      x0, x19
0x1007a5274: bl       #0x107c27c70 ; _objc_release
0x1007a5278: add      x22, x22, #1
0x1007a527c: ldr      x8, [sp, #0x48]
0x1007a5280: cmp      x8, x22
0x1007a5284: b.ne     #0x1007a51dc
0x1007a5288: add      x2, sp, #0x50
0x1007a528c: add      x3, sp, #0x90
0x1007a5290: ldp      x1, x0, [sp, #0x28]
0x1007a5294: mov      w4, #0x10
0x1007a5298: bl       #0x107c27c64 ; _objc_msgSend
0x1007a529c: str      x0, [sp, #0x48]
0x1007a52a0: cbnz     x0, #0x1007a51b0
0x1007a52a4: ldr      x0, [sp, #0x30]
0x1007a52a8: bl       #0x107c27c70 ; _objc_release
0x1007a52ac: ldr      x8, [sp, #0x18]
0x1007a52b0: ldr      x0, [x24, x8]
0x1007a52b4: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x1007a52b8: ldr      x1, [x8, #0x420] ; @selector(removeAllObjects) | 'removeAllObjects'
0x1007a52bc: bl       #0x107c27c64 ; _objc_msgSend | selector=removeAllObjects
0x1007a52c0: adrp     x25, #0x11ed12000
0x1007a52c4: mov      x26, x24
0x1007a52c8: ldr      x19, [x25, #0x618] ; classref iConsole | Class iConsole
0x1007a52cc: ldr      x20, [sp, #0x40]
0x1007a52d0: mov      x0, x20
0x1007a52d4: ldr      x1, [sp, #0x20]
0x1007a52d8: bl       #0x107c27c64 ; _objc_msgSend
0x1007a52dc: adrp     x8, #0x11e9c9000
0x1007a52e0: ldr      x22, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a52e4: adrp     x8, #0x11cfec000
0x1007a52e8: add      x8, x8, #0xbb8 ; @'flushDerivedSyncBatch roomCount:%lu'
0x1007a52ec: stp      x8, x0, [sp] ; @'flushDerivedSyncBatch roomCount:%lu'
0x1007a52f0: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a52f4: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a52f8: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a52fc: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a5300: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5304: add      x7, x7, #0xd2d ; '-[BypChatRoomMgr flushDerivedSyncBatch]'
0x1007a5308: mov      x0, x19 ; Class iConsole
0x1007a530c: mov      x1, x22 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a5310: mov      w2, #2
0x1007a5314: mov      w4, #0
0x1007a5318: mov      w6, #0x15f
0x1007a531c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a5320: adrp     x8, #0x11ed17000 ; classref BrandAttributedNotificationCellViewModel
0x1007a5324: ldr      x0, [x8, #0x5f0] ; classref DerivedSyncRequest | Class DerivedSyncRequest
0x1007a5328: bl       #0x107c27c0c ; _objc_alloc_init
0x1007a532c: mov      x21, x0
0x1007a5330: adrp     x8, #0x11ecab000 ; @selector(setBSearchQueueNames:)
0x1007a5334: ldr      x1, [x8, #0xdf0] ; @selector(setKeys:) | 'setKeys:'
0x1007a5338: mov      x2, x20
0x1007a533c: bl       #0x107c27c64 ; _objc_msgSend | selector=setKeys:
0x1007a5340: adrp     x8, #0x11ed12000
0x1007a5344: ldr      x0, [x8, #0xaf0] ; classref ProtobufCGIWrap | Class ProtobufCGIWrap
0x1007a5348: bl       #0x107c27c0c ; _objc_alloc_init
0x1007a534c: mov      x23, x0
0x1007a5350: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a5354: ldr      x1, [x8, #0x840] ; @selector(setM_pbRequest:) | 'setM_pbRequest:'
0x1007a5358: mov      x2, x21
0x1007a535c: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_pbRequest:
0x1007a5360: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a5364: ldr      x1, [x8, #0x848] ; @selector(setM_uiCgi:) | 'setM_uiCgi:'
0x1007a5368: mov      x0, x23
0x1007a536c: mov      w2, #0x4904
0x1007a5370: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiCgi:
0x1007a5374: adrp     x8, #0x11ed12000
0x1007a5378: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x1007a537c: adrp     x8, #0x11e9c9000
0x1007a5380: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x1007a5384: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x1007a5388: mov      x29, x29
0x1007a538c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a5390: mov      x19, x0
0x1007a5394: adrp     x8, #0x11ed12000
0x1007a5398: ldr      x0, [x8, #0xaf8] ; classref EventService | Class EventService
0x1007a539c: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x1007a53a0: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x1007a53a4: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x1007a53a8: mov      x2, x0
0x1007a53ac: adrp     x8, #0x11e9c9000
0x1007a53b0: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x1007a53b4: mov      x0, x19
0x1007a53b8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x1007a53bc: mov      x29, x29
0x1007a53c0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x1007a53c4: mov      x20, x0
0x1007a53c8: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a53cc: ldr      x1, [x8, #0x850] ; @selector(CreateProtobufEvent:Flag:) | 'CreateProtobufEvent:Flag:'
0x1007a53d0: mov      x2, x23
0x1007a53d4: mov      w3, #5
0x1007a53d8: bl       #0x107c27c64 ; _objc_msgSend | selector=CreateProtobufEvent:Flag:
0x1007a53dc: mov      x24, x0
0x1007a53e0: mov      x0, x20
0x1007a53e4: bl       #0x107c27c70 ; _objc_release
0x1007a53e8: mov      x0, x19
0x1007a53ec: bl       #0x107c27c70 ; _objc_release
0x1007a53f0: cbz      w24, #0x1007a5414
0x1007a53f4: adrp     x8, #0x11ed12000
0x1007a53f8: ldr      x0, [x8, #0x840] ; classref CAppUtil | Class CAppUtil
0x1007a53fc: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x1007a5400: ldr      x1, [x8, #0x858] ; @selector(addPBEventObserverListItem:andValue:) | 'addPBEventObserverListItem:andValue:'
0x1007a5404: mov      x2, x24
0x1007a5408: mov      x3, x26
0x1007a540c: bl       #0x107c27c64 ; _objc_msgSend | selector=addPBEventObserverListItem:andValue:
0x1007a5410: b        #0x1007a5450
0x1007a5414: ldr      x0, [x25, #0x618] ; classref iConsole | Class iConsole
0x1007a5418: adrp     x8, #0x11cfec000
0x1007a541c: add      x8, x8, #0xbd8 ; @'CreateProtobufEvent failed for derived sync'
0x1007a5420: str      x8, [sp] ; @'CreateProtobufEvent failed for derived sync'
0x1007a5424: adrp     x3, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5428: add      x3, x3, #0xc3c ; 'BypChatRoom'
0x1007a542c: adrp     x5, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5430: add      x5, x5, #0xc48 ; 'BypChatRoomMgr.mm'
0x1007a5434: adrp     x7, #0x119c19000 ; 'ylist. categroy_id=%@'
0x1007a5438: add      x7, x7, #0xd2d ; '-[BypChatRoomMgr flushDerivedSyncBatch]'
0x1007a543c: mov      x1, x22 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a5440: mov      w2, #2
0x1007a5444: mov      w4, #0
0x1007a5448: mov      w6, #0x16c
0x1007a544c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x1007a5450: mov      x0, x23
0x1007a5454: bl       #0x107c27c70 ; _objc_release
0x1007a5458: mov      x0, x21
0x1007a545c: bl       #0x107c27c70 ; _objc_release
0x1007a5460: ldr      x0, [sp, #0x40]
0x1007a5464: bl       #0x107c27c70 ; _objc_release
0x1007a5468: ldur     x8, [x29, #-0x60]
0x1007a546c: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x1007a5470: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x1007a5474: ldr      x9, [x9]
0x1007a5478: cmp      x9, x8
0x1007a547c: b.ne     #0x1007a54a0
0x1007a5480: ldp      x29, x30, [sp, #0x170]
0x1007a5484: ldp      x20, x19, [sp, #0x160]
0x1007a5488: ldp      x22, x21, [sp, #0x150] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x1007a548c: ldp      x24, x23, [sp, #0x140]
0x1007a5490: ldp      x26, x25, [sp, #0x130]
0x1007a5494: ldp      x28, x27, [sp, #0x120] ; 'setSyncKey:'
0x1007a5498: add      sp, sp, #0x180
0x1007a549c: ret      
0x1007a54a0: bl       #0x107c27730 ; ___stack_chk_fail
