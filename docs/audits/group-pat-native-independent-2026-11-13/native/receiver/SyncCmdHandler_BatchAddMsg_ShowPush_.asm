-[SyncCmdHandler BatchAddMsg:ShowPush:] 0x105e415ac B24@0:8B16B20
0x105e415ac: stp      d9, d8, [sp, #-0x70]!
0x105e415b0: stp      x28, x27, [sp, #0x10]
0x105e415b4: stp      x26, x25, [sp, #0x20]
0x105e415b8: stp      x24, x23, [sp, #0x30]
0x105e415bc: stp      x22, x21, [sp, #0x40]
0x105e415c0: stp      x20, x19, [sp, #0x50]
0x105e415c4: stp      x29, x30, [sp, #0x60]
0x105e415c8: add      x29, sp, #0x60
0x105e415cc: sub      sp, sp, #0x7b0
0x105e415d0: str      w3, [sp, #0x154]
0x105e415d4: mov      x19, x2
0x105e415d8: mov      x27, x0
0x105e415dc: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e415e0: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105e415e4: ldr      x8, [x8]
0x105e415e8: stur     x8, [x29, #-0x70]
0x105e415ec: adrp     x8, #0x11f755000
0x105e415f0: mov      w9, #1
0x105e415f4: strb     w9, [x8, #0x8f3]
0x105e415f8: adrp     x8, #0x11edd4000
0x105e415fc: ldrsw    x20, [x8, #0x5f8] ; ivar_offset SyncCmdHandler.m_arrMsgList=0x8
0x105e41600: ldr      x0, [x0, x20]
0x105e41604: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e41608: ldr      x21, [x8, #0x850] ; @selector(count) | 'count'
0x105e4160c: mov      x1, x21 ; 'count'
0x105e41610: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105e41614: cbz      x0, #0x105e4207c
0x105e41618: str      w19, [sp, #0x2c]
0x105e4161c: adrp     x26, #0x11ed12000
0x105e41620: ldr      x0, [x26, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e41624: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e41628: str      x21, [sp, #0x138] ; 'count'
0x105e4162c: ldr      x24, [x8, #0xf70] ; @selector(dictionary) | 'dictionary'
0x105e41630: mov      x1, x24 ; 'dictionary'
0x105e41634: bl       #0x107c27c64 ; _objc_msgSend | selector=dictionary
0x105e41638: mov      x29, x29
0x105e4163c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41640: str      x0, [sp, #0xc0]
0x105e41644: adrp     x21, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105e41648: ldr      x0, [x21, #0x260] ; _OBJC_CLASS_$_NSMutableSet
0x105e4164c: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x105e41650: ldr      x19, [x8, #0xca8] ; @selector(set) | 'set'
0x105e41654: mov      x1, x19 ; 'set'
0x105e41658: bl       #0x107c27c64 ; _objc_msgSend | selector=set
0x105e4165c: mov      x29, x29
0x105e41660: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41664: str      x0, [sp, #0x40]
0x105e41668: adrp     x22, #0x11ed12000
0x105e4166c: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e41670: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e41674: ldr      x23, [x8, #0xd88] ; @selector(array) | 'array'
0x105e41678: mov      x1, x23 ; 'array'
0x105e4167c: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e41680: mov      x29, x29
0x105e41684: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41688: str      x0, [sp, #0xb0]
0x105e4168c: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e41690: mov      x1, x23 ; 'array'
0x105e41694: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e41698: mov      x29, x29
0x105e4169c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e416a0: str      x0, [sp, #0x108]
0x105e416a4: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e416a8: mov      x1, x23 ; 'array'
0x105e416ac: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e416b0: mov      x29, x29
0x105e416b4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e416b8: str      x0, [sp, #0x100]
0x105e416bc: ldr      x0, [x21, #0x260] ; _OBJC_CLASS_$_NSMutableSet
0x105e416c0: mov      x1, x19 ; 'set'
0x105e416c4: bl       #0x107c27c64 ; _objc_msgSend | selector=set
0x105e416c8: mov      x29, x29
0x105e416cc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e416d0: str      x0, [sp, #0x1a8]
0x105e416d4: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e416d8: mov      x1, x23 ; 'array'
0x105e416dc: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e416e0: mov      x29, x29
0x105e416e4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e416e8: str      x0, [sp, #0xf0]
0x105e416ec: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e416f0: mov      x1, x23 ; 'array'
0x105e416f4: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e416f8: mov      x29, x29
0x105e416fc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41700: mov      x25, x0
0x105e41704: ldr      x0, [x26, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e41708: mov      x1, x24 ; 'dictionary'
0x105e4170c: bl       #0x107c27c64 ; _objc_msgSend | selector=dictionary
0x105e41710: mov      x29, x29
0x105e41714: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41718: str      x0, [sp, #0x68]
0x105e4171c: ldr      x0, [x26, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e41720: str      x24, [sp, #0x130] ; 'dictionary'
0x105e41724: mov      x1, x24 ; 'dictionary'
0x105e41728: bl       #0x107c27c64 ; _objc_msgSend | selector=dictionary
0x105e4172c: mov      x29, x29
0x105e41730: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41734: str      x0, [sp, #0x60]
0x105e41738: ldr      x0, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e4173c: str      x23, [sp, #0x38] ; 'array'
0x105e41740: mov      x1, x23 ; 'array'
0x105e41744: bl       #0x107c27c64 ; _objc_msgSend | selector=array
0x105e41748: mov      x29, x29
0x105e4174c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41750: str      x0, [sp, #0x148]
0x105e41754: ldr      x19, [x22, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e41758: ldr      x0, [x27, x20]
0x105e4175c: ldr      x1, [sp, #0x138]
0x105e41760: bl       #0x107c27c64 ; _objc_msgSend
0x105e41764: mov      x2, x0
0x105e41768: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e4176c: ldr      x1, [x8, #0xda8] ; @selector(arrayWithCapacity:) | 'arrayWithCapacity:'
0x105e41770: mov      x0, x19
0x105e41774: bl       #0x107c27c64 ; _objc_msgSend | selector=arrayWithCapacity:
0x105e41778: mov      x29, x29
0x105e4177c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41780: mov      x22, x0
0x105e41784: bl       #0x107c27c1c ; _objc_autoreleasePoolPush
0x105e41788: mov      x19, x0
0x105e4178c: movi     v0.16b, #0
0x105e41790: str      q0, [sp, #0x460]
0x105e41794: str      q0, [sp, #0x470]
0x105e41798: str      q0, [sp, #0x480]
0x105e4179c: str      q0, [sp, #0x490]
0x105e417a0: ldr      x20, [x27, x20]
0x105e417a4: mov      x0, x20
0x105e417a8: bl       #0x107c27c74 ; _objc_retain
0x105e417ac: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e417b0: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x105e417b4: add      x2, sp, #0x460
0x105e417b8: sub      x3, x29, #0xf0
0x105e417bc: str      x1, [sp, #0xc8] ; 'countByEnumeratingWithState:objects:count:'
0x105e417c0: mov      w4, #0x10
0x105e417c4: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x105e417c8: str      x25, [sp, #0x128]
0x105e417cc: str      x22, [sp, #0x1c0]
0x105e417d0: str      x27, [sp, #0x1e8]
0x105e417d4: cbz      x0, #0x105e420f8
0x105e417d8: mov      x23, x0
0x105e417dc: str      x19, [sp, #0x30]
0x105e417e0: str      wzr, [sp, #0x168]
0x105e417e4: str      wzr, [sp, #0x160]
0x105e417e8: ldr      x8, [sp, #0x470]
0x105e417ec: ldr      x24, [x8]
0x105e417f0: str      x24, [sp, #0x158]
0x105e417f4: str      x20, [sp, #0x170]
0x105e417f8: mov      x19, #0
0x105e417fc: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x105e41800: ldr      x8, [x8, #0xf00] ; @selector(m_isEnterpriseMsg) | 'm_isEnterpriseMsg'
0x105e41804: str      x8, [sp, #0x1e0] ; 'm_isEnterpriseMsg'
0x105e41808: adrp     x8, #0x11eb0a000 ; @selector(playWithMusicInfo:updateSessionId:)
0x105e4180c: ldr      x9, [x8, #0xa70] ; @selector(GetChatName:Des:) | 'GetChatName:Des:'
0x105e41810: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e41814: ldr      x8, [x8, #0x3f0] ; @selector(m_uiMessageType) | 'm_uiMessageType'
0x105e41818: stp      x9, x8, [sp, #0x1c8] ; 'GetChatName:Des:'
0x105e4181c: adrp     x8, #0x11e9f2000 ; @selector(getTimelineMsgArr)
0x105e41820: ldr      x9, [x8, #0xda0] ; @selector(setWrapMsg:) | 'setWrapMsg:'
0x105e41824: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e41828: ldr      x8, [x8, #0xb88] ; @selector(setChatName:) | 'setChatName:'
0x105e4182c: stp      x8, x9, [sp, #0x190] ; 'setChatName:'
0x105e41830: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e41834: ldr      x9, [x8, #0x7c0] ; @selector(setUiDes:) | 'setUiDes:'
0x105e41838: adrp     x8, #0x11e9df000 ; @selector(exitTracking)
0x105e4183c: ldr      x10, [x8, #0x9e8] ; @selector(m_uiVoipStatus) | 'm_uiVoipStatus'
0x105e41840: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x105e41844: ldr      x8, [x8, #0x7b0] ; @selector(CanNotAddToDB:ChatName:) | 'CanNotAddToDB:ChatName:'
0x105e41848: stp      x8, x9, [sp, #0x180] ; 'CanNotAddToDB:ChatName:'
0x105e4184c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e41850: ldr      x8, [x8, #0x7c8] ; @selector(setIsCanAddDB:) | 'setIsCanAddDB:'
0x105e41854: str      x8, [sp, #0x178] ; 'setIsCanAddDB:'
0x105e41858: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105e4185c: ldr      x8, [x8, #0x578] ; @selector(m_nsFromUsr) | 'm_nsFromUsr'
0x105e41860: stp      x10, x8, [sp, #0x118] ; 'm_uiVoipStatus'
0x105e41864: adrp     x8, #0x11e9d2000 ; @selector(defaultMemoryMappedKV)
0x105e41868: ldr      x8, [x8, #0x8e8] ; @selector(getPluginUserNameType:) | 'getPluginUserNameType:'
0x105e4186c: str      x8, [sp, #0x110] ; 'getPluginUserNameType:'
0x105e41870: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105e41874: ldr      x8, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x105e41878: str      x8, [sp, #0x1a0] ; 'm_n64MesSvrID'
0x105e4187c: adrp     x8, #0x11e9c9000
0x105e41880: ldr      x28, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e41884: adrp     x8, #0x11eb21000 ; @selector(removeIfExpiredTask:forKey:now:scene:)
0x105e41888: ldr      x9, [x8, #0xb28] ; @selector(parseMsgClusterType) | 'parseMsgClusterType'
0x105e4188c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e41890: ldr      x8, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105e41894: stp      x8, x9, [sp, #0xe0] ; 'isEqualToString:'
0x105e41898: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e4189c: ldr      x9, [x8, #0xd10] ; @selector(ChangeForDisplay) | 'ChangeForDisplay'
0x105e418a0: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e418a4: ldr      x8, [x8, #0x3f8] ; @selector(m_uiAppMsgInnerType) | 'm_uiAppMsgInnerType'
0x105e418a8: stp      x8, x9, [sp, #0x70] ; 'm_uiAppMsgInnerType'
0x105e418ac: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x105e418b0: ldr      x9, [x8, #0x618] ; @selector(m_arrReaderWaps) | 'm_arrReaderWaps'
0x105e418b4: adrp     x8, #0x11eca7000 ; @selector(didReceiveAuthenticationChallengeForDelegate:webView:challenge:completion:)
0x105e418b8: ldr      x8, [x8, #0x598] ; @selector(firstObject) | 'firstObject'
0x105e418bc: stp      x8, x9, [sp, #0x50] ; 'firstObject'
0x105e418c0: adrp     x8, #0x11e9d3000 ; @selector(deleteSearchableItemsWithDomainIdentifiers:completionHandler:)
0x105e418c4: ldr      x8, [x8, #0x620] ; @selector(m_uiItemShowType) | 'm_uiItemShowType'
0x105e418c8: str      x8, [sp, #0x48] ; 'm_uiItemShowType'
0x105e418cc: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e418d0: ldr      x8, [x8, #0xce8] ; @selector(length) | 'length'
0x105e418d4: str      x8, [sp, #0x1b8] ; 'length'
0x105e418d8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e418dc: ldr      x9, [x8, #0x7e0] ; @selector(setClusterType:) | 'setClusterType:'
0x105e418e0: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e418e4: ldr      x8, [x8, #0x7d0] ; @selector(setAddMsgType:) | 'setAddMsgType:'
0x105e418e8: str      x8, [sp, #0xf8] ; 'setAddMsgType:'
0x105e418ec: adrp     x8, #0x11eb23000 ; @selector(clearReddot:)
0x105e418f0: ldr      x8, [x8, #0x900] ; @selector(IsNeedAddWCPayMsgBizExt) | 'IsNeedAddWCPayMsgBizExt'
0x105e418f4: str      x8, [sp, #0xb8] ; 'IsNeedAddWCPayMsgBizExt'
0x105e418f8: adrp     x8, #0x11ea16000 ; @selector(getSessionDetailQueue)
0x105e418fc: ldr      x8, [x8, #0x378] ; @selector(isNewWCPayBizExtMsg:) | 'isNewWCPayBizExtMsg:'
0x105e41900: stp      x8, x9, [sp, #0x80] ; 'isNewWCPayBizExtMsg:'
0x105e41904: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e41908: ldr      x9, [x8, #0xa38] ; @selector(addObject:) | 'addObject:'
0x105e4190c: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e41910: ldr      x8, [x8, #0x460] ; @selector(m_nsContent) | 'm_nsContent'
0x105e41914: stp      x23, x8, [sp, #0xd0]
0x105e41918: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e4191c: ldr      x10, [x8, #0x7d8] ; @selector(HandleHelloMsg:SpcialSession:NotAddDBSession:GetChangeDisplay:) | 'HandleHelloMsg:SpcialSession:NotAddDBSession:GetChangeDisplay:'
0x105e41920: adrp     x8, #0x11eb2c000 ; @selector(presentedFullScreenNav)
0x105e41924: ldr      x8, [x8, #0x5a0] ; @selector(setAddDBResult:) | 'setAddDBResult:'
0x105e41928: stp      x8, x10, [sp, #0xa0] ; 'setAddDBResult:'
0x105e4192c: adrp     x8, #0x11eb2c000 ; @selector(presentedFullScreenNav)
0x105e41930: ldr      x8, [x8, #0x570] ; @selector(setIsNeedChangeDisplay:) | 'setIsNeedChangeDisplay:'
0x105e41934: stp      x9, x8, [sp, #0x90] ; 'addObject:'
0x105e41938: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105e4193c: ldr      x8, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105e41940: str      x8, [sp, #0x1d8] ; 'safeAddObject:'
0x105e41944: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e41948: ldr      x8, [x8, #0x7b8] ; @selector(ParseStatusNotify:map:) | 'ParseStatusNotify:map:'
0x105e4194c: str      x8, [sp, #0x140] ; 'ParseStatusNotify:map:'
0x105e41950: str      x28, [sp, #0x1b0] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e41954: ldr      x8, [sp, #0x470]
0x105e41958: ldr      x8, [x8]
0x105e4195c: cmp      x8, x24
0x105e41960: b.eq     #0x105e4196c
0x105e41964: mov      x0, x20
0x105e41968: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e4196c: ldr      x8, [sp, #0x468]
0x105e41970: ldr      x21, [x8, x19, lsl #3]
0x105e41974: mov      x0, x21
0x105e41978: ldr      x1, [sp, #0x1e0]
0x105e4197c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41980: cbz      w0, #0x105e41998
0x105e41984: mov      x0, x25
0x105e41988: ldr      x1, [sp, #0x1d8]
0x105e4198c: mov      x2, x21
0x105e41990: bl       #0x107c27c64 ; _objc_msgSend
0x105e41994: b        #0x105e41ec0
0x105e41998: mov      x22, x23
0x105e4199c: mov      x23, x25
0x105e419a0: str      wzr, [sp, #0x358]
0x105e419a4: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e419a8: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e419ac: add      x3, sp, #0x358
0x105e419b0: ldr      x1, [sp, #0x1c8]
0x105e419b4: mov      x2, x21
0x105e419b8: bl       #0x107c27c64 ; _objc_msgSend
0x105e419bc: mov      x29, x29
0x105e419c0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e419c4: mov      x28, x0
0x105e419c8: mov      x0, x21
0x105e419cc: ldr      x25, [sp, #0x1d0]
0x105e419d0: mov      x1, x25
0x105e419d4: bl       #0x107c27c64 ; _objc_msgSend
0x105e419d8: cmp      w0, #0x33
0x105e419dc: b.ne     #0x105e41a5c
0x105e419e0: mov      x0, x28
0x105e419e4: ldr      x1, [sp, #0x1b8]
0x105e419e8: bl       #0x107c27c64 ; _objc_msgSend
0x105e419ec: mov      x25, x23
0x105e419f0: mov      x23, x22
0x105e419f4: cbz      x0, #0x105e41a50
0x105e419f8: adrp     x8, #0x11ed12000
0x105e419fc: ldr      x0, [x8, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e41a00: ldr      x1, [sp, #0x130]
0x105e41a04: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a08: mov      x29, x29
0x105e41a0c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41a10: mov      x22, x0
0x105e41a14: mov      x0, x27
0x105e41a18: ldr      x1, [sp, #0x140]
0x105e41a1c: mov      x2, x21
0x105e41a20: mov      x3, x22
0x105e41a24: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a28: mov      x0, x22
0x105e41a2c: ldr      x1, [sp, #0x138]
0x105e41a30: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a34: cbz      x0, #0x105e41a48
0x105e41a38: ldr      x0, [sp, #0xf0]
0x105e41a3c: ldr      x1, [sp, #0x1d8]
0x105e41a40: mov      x2, x22
0x105e41a44: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a48: mov      x0, x22
0x105e41a4c: bl       #0x107c27c70 ; _objc_release
0x105e41a50: mov      x0, x28
0x105e41a54: bl       #0x107c27c70 ; _objc_release
0x105e41a58: b        #0x105e41ec0
0x105e41a5c: adrp     x8, #0x11ed37000 ; classref GetEmotionRewardRequest
0x105e41a60: ldr      x0, [x8, #0x160] ; classref BatchAddMsgInfo | Class BatchAddMsgInfo
0x105e41a64: bl       #0x107c27c0c ; _objc_alloc_init
0x105e41a68: mov      x27, x0
0x105e41a6c: ldr      x1, [sp, #0x198]
0x105e41a70: mov      x2, x21
0x105e41a74: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a78: mov      x0, x27
0x105e41a7c: ldr      x1, [sp, #0x190]
0x105e41a80: mov      x2, x28
0x105e41a84: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a88: ldr      w2, [sp, #0x358]
0x105e41a8c: mov      x0, x27
0x105e41a90: ldr      x1, [sp, #0x188]
0x105e41a94: bl       #0x107c27c64 ; _objc_msgSend
0x105e41a98: mov      x0, x21
0x105e41a9c: mov      x1, x25
0x105e41aa0: bl       #0x107c27c64 ; _objc_msgSend
0x105e41aa4: cmp      w0, #0x32
0x105e41aa8: b.ne     #0x105e41ad8
0x105e41aac: mov      x0, x21
0x105e41ab0: ldr      x1, [sp, #0x118]
0x105e41ab4: bl       #0x107c27c64 ; _objc_msgSend
0x105e41ab8: ands     w8, w0, #0x20
0x105e41abc: cset     w9, eq
0x105e41ac0: ldr      w10, [sp, #0x168]
0x105e41ac4: orr      w10, w9, w10
0x105e41ac8: str      w10, [sp, #0x168]
0x105e41acc: ldr      w9, [sp, #0x160]
0x105e41ad0: orr      w9, w9, w8, lsr #5
0x105e41ad4: str      w9, [sp, #0x160]
0x105e41ad8: mov      x25, x23
0x105e41adc: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e41ae0: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e41ae4: ldr      x1, [sp, #0x180]
0x105e41ae8: mov      x2, x21
0x105e41aec: mov      x3, x28
0x105e41af0: bl       #0x107c27c64 ; _objc_msgSend
0x105e41af4: mov      x23, x22
0x105e41af8: tbz      w0, #0, #0x105e41b68
0x105e41afc: adrp     x8, #0x11ed12000
0x105e41b00: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41b04: mov      x0, x21
0x105e41b08: ldr      x1, [sp, #0x1a0]
0x105e41b0c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41b10: adrp     x8, #0x11d353000
0x105e41b14: add      x8, x8, #0xa18 ; @'msg not add db id %lld'
0x105e41b18: stp      x8, x0, [sp] ; @'msg not add db id %lld'
0x105e41b1c: mov      x0, x20 ; Class iConsole
0x105e41b20: ldr      x1, [sp, #0x1b0]
0x105e41b24: mov      w2, #2
0x105e41b28: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e41b2c: add      x3, x3, #0xfaf ; 'Sync'
0x105e41b30: mov      w4, #0
0x105e41b34: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e41b38: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e41b3c: mov      w6, #0x228
0x105e41b40: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e41b44: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41b48: bl       #0x107c27c64 ; _objc_msgSend
0x105e41b4c: mov      x0, x27
0x105e41b50: ldr      x1, [sp, #0x178]
0x105e41b54: mov      w2, #0
0x105e41b58: bl       #0x107c27c64 ; _objc_msgSend
0x105e41b5c: ldr      x20, [sp, #0x170]
0x105e41b60: ldr      x24, [sp, #0x158]
0x105e41b64: b        #0x105e41e9c
0x105e41b68: mov      x0, x27
0x105e41b6c: ldr      x1, [sp, #0x178]
0x105e41b70: mov      w2, #1
0x105e41b74: bl       #0x107c27c64 ; _objc_msgSend
0x105e41b78: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105e41b7c: ldr      x22, [x8, #0xda8] ; classref PluginUtil | Class PluginUtil
0x105e41b80: mov      x0, x21
0x105e41b84: ldr      x1, [sp, #0x120]
0x105e41b88: bl       #0x107c27c64 ; _objc_msgSend
0x105e41b8c: mov      x29, x29
0x105e41b90: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41b94: mov      x25, x0
0x105e41b98: mov      x0, x22 ; Class PluginUtil
0x105e41b9c: ldr      x1, [sp, #0x110]
0x105e41ba0: mov      x2, x25
0x105e41ba4: bl       #0x107c27c64 ; _objc_msgSend
0x105e41ba8: mov      x20, x0
0x105e41bac: mov      x0, x25
0x105e41bb0: bl       #0x107c27c70 ; _objc_release
0x105e41bb4: adrp     x26, #0x11ed12000
0x105e41bb8: ldr      x22, [x26, #0x618] ; classref iConsole | Class iConsole
0x105e41bbc: mov      x0, x21
0x105e41bc0: ldr      x1, [sp, #0x1a0]
0x105e41bc4: bl       #0x107c27c64 ; _objc_msgSend
0x105e41bc8: cmp      x20, #4
0x105e41bcc: b.ne     #0x105e41cb0
0x105e41bd0: adrp     x8, #0x11d353000
0x105e41bd4: add      x8, x8, #0x918 ; @'msg say hello id %lld'
0x105e41bd8: stp      x8, x0, [sp] ; @'msg say hello id %lld'
0x105e41bdc: mov      x0, x22 ; Class iConsole
0x105e41be0: ldr      x24, [sp, #0x1b0]
0x105e41be4: mov      x1, x24
0x105e41be8: mov      w2, #2
0x105e41bec: adrp     x23, #0x119cf5000 ; 'ns_filled_pause2'
0x105e41bf0: add      x23, x23, #0xfaf ; 'Sync'
0x105e41bf4: mov      x3, x23 ; 'Sync'
0x105e41bf8: mov      w4, #0
0x105e41bfc: adrp     x25, #0x11a2e0000 ; 'tice?language='
0x105e41c00: add      x25, x25, #0x21 ; 'SyncCmdHandler.mm'
0x105e41c04: mov      x5, x25 ; 'SyncCmdHandler.mm'
0x105e41c08: mov      w6, #0x1e7
0x105e41c0c: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e41c10: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41c14: mov      x26, x7 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41c18: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c1c: mov      x0, x21
0x105e41c20: ldr      x1, [sp, #0xd8]
0x105e41c24: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c28: mov      x29, x29
0x105e41c2c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41c30: mov      x20, x0
0x105e41c34: ldr      x1, [sp, #0x1b8]
0x105e41c38: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c3c: mov      x22, x0
0x105e41c40: mov      x0, x20
0x105e41c44: bl       #0x107c27c70 ; _objc_release
0x105e41c48: cbz      x22, #0x105e41db8
0x105e41c4c: mov      x0, x27
0x105e41c50: ldr      x1, [sp, #0xf8]
0x105e41c54: mov      w2, #1
0x105e41c58: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c5c: strb     wzr, [sp, #0x270]
0x105e41c60: add      x5, sp, #0x270
0x105e41c64: ldr      x0, [sp, #0x1e8]
0x105e41c68: ldr      x1, [sp, #0xa8]
0x105e41c6c: mov      x2, x21
0x105e41c70: ldp      x4, x3, [sp, #0x60]
0x105e41c74: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c78: ldr      x20, [sp, #0x170]
0x105e41c7c: cbz      w0, #0x105e42a14
0x105e41c80: mov      x0, x27
0x105e41c84: ldr      x1, [sp, #0xa0]
0x105e41c88: mov      w2, #1
0x105e41c8c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41c90: ldrb     w2, [sp, #0x270]
0x105e41c94: mov      x0, x27
0x105e41c98: ldr      x1, [sp, #0x98]
0x105e41c9c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41ca0: ldr      x25, [sp, #0x128]
0x105e41ca4: ldr      x24, [sp, #0x158]
0x105e41ca8: ldr      x23, [sp, #0xd0]
0x105e41cac: b        #0x105e41e9c
0x105e41cb0: adrp     x8, #0x11d353000
0x105e41cb4: add      x8, x8, #0x978 ; @'msg add db id %lld'
0x105e41cb8: stp      x8, x0, [sp] ; @'msg add db id %lld'
0x105e41cbc: mov      x0, x22
0x105e41cc0: ldr      x24, [sp, #0x1b0]
0x105e41cc4: mov      x1, x24
0x105e41cc8: mov      w2, #2
0x105e41ccc: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e41cd0: add      x3, x3, #0xfaf ; 'Sync'
0x105e41cd4: mov      w4, #0
0x105e41cd8: adrp     x20, #0x11a2e0000 ; 'tice?language='
0x105e41cdc: add      x20, x20, #0x21 ; 'SyncCmdHandler.mm'
0x105e41ce0: mov      x5, x20 ; 'SyncCmdHandler.mm'
0x105e41ce4: mov      w6, #0x1ff
0x105e41ce8: adrp     x25, #0x11a2e0000 ; 'tice?language='
0x105e41cec: add      x25, x25, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41cf0: mov      x7, x25 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41cf4: bl       #0x107c27c64 ; _objc_msgSend
0x105e41cf8: mov      x0, x21
0x105e41cfc: ldr      x1, [sp, #0xe8]
0x105e41d00: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d04: mov      x29, x29
0x105e41d08: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41d0c: mov      x22, x0
0x105e41d10: ldr      x0, [x26, #0x618] ; 'st'
0x105e41d14: adrp     x8, #0x11d353000
0x105e41d18: add      x8, x8, #0x998 ; @'#clusterType# is %@'
0x105e41d1c: stp      x8, x22, [sp] ; @'#clusterType# is %@'
0x105e41d20: mov      x1, x24
0x105e41d24: mov      w2, #1
0x105e41d28: mov      x3, #0
0x105e41d2c: mov      w4, #0
0x105e41d30: mov      x5, x20 ; 'SyncCmdHandler.mm'
0x105e41d34: mov      w6, #0x204
0x105e41d38: mov      x7, x25 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41d3c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d40: mov      x0, x22
0x105e41d44: ldr      x1, [sp, #0xe0]
0x105e41d48: adrp     x2, #0x11cfae000
0x105e41d4c: add      x2, x2, #0x6f8 ; @'notification_messages'
0x105e41d50: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d54: ldr      x20, [sp, #0x170]
0x105e41d58: cbz      w0, #0x105e41d90
0x105e41d5c: mov      x0, x21
0x105e41d60: ldr      x1, [sp, #0x1d0]
0x105e41d64: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d68: cmp      w0, #0x31
0x105e41d6c: b.ne     #0x105e41e00
0x105e41d70: mov      x0, x21
0x105e41d74: ldr      x1, [sp, #0x78]
0x105e41d78: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d7c: mov      x0, x21
0x105e41d80: ldr      x1, [sp, #0x70]
0x105e41d84: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d88: cmp      w0, #0x29
0x105e41d8c: b.ne     #0x105e41ed0
0x105e41d90: mov      x0, x22
0x105e41d94: ldr      x1, [sp, #0x1b8]
0x105e41d98: bl       #0x107c27c64 ; _objc_msgSend
0x105e41d9c: cbz      x0, #0x105e41e40
0x105e41da0: mov      x0, x27
0x105e41da4: ldr      x1, [sp, #0x88]
0x105e41da8: mov      x2, x22
0x105e41dac: bl       #0x107c27c64 ; _objc_msgSend
0x105e41db0: mov      w2, #3
0x105e41db4: b        #0x105e41e44
0x105e41db8: adrp     x8, #0x11ed12000
0x105e41dbc: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41dc0: adrp     x8, #0x11d353000
0x105e41dc4: add      x8, x8, #0x938 ; @'no content, skip msg'
0x105e41dc8: str      x8, [sp] ; @'no content, skip msg'
0x105e41dcc: mov      x1, x24
0x105e41dd0: mov      w2, #3
0x105e41dd4: mov      x3, x23
0x105e41dd8: mov      w4, #0
0x105e41ddc: mov      x5, x25 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41de0: mov      w6, #0x1e9
0x105e41de4: mov      x7, x26 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41de8: bl       #0x107c27c64 ; _objc_msgSend
0x105e41dec: ldr      x25, [sp, #0x128]
0x105e41df0: ldr      x20, [sp, #0x170]
0x105e41df4: ldr      x24, [sp, #0x158]
0x105e41df8: ldr      x23, [sp, #0xd0]
0x105e41dfc: b        #0x105e41eac
0x105e41e00: adrp     x8, #0x11ed12000
0x105e41e04: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41e08: adrp     x8, #0x11d353000
0x105e41e0c: add      x8, x8, #0x9b8 ; @'only appmsg can add to template holder'
0x105e41e10: str      x8, [sp] ; @'only appmsg can add to template holder'
0x105e41e14: ldr      x1, [sp, #0x1b0]
0x105e41e18: mov      w2, #2
0x105e41e1c: mov      x3, #0
0x105e41e20: mov      w4, #0
0x105e41e24: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e41e28: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e41e2c: mov      w6, #0x20a
0x105e41e30: mov      x7, x25
0x105e41e34: bl       #0x107c27c64 ; _objc_msgSend
0x105e41e38: ldr      x25, [sp, #0x128]
0x105e41e3c: b        #0x105e42030
0x105e41e40: mov      w2, #2
0x105e41e44: ldr      x25, [sp, #0x128]
0x105e41e48: ldr      x24, [sp, #0x158]
0x105e41e4c: mov      x0, x27
0x105e41e50: ldr      x1, [sp, #0xf8]
0x105e41e54: bl       #0x107c27c64 ; _objc_msgSend
0x105e41e58: mov      x8, #-1
0x105e41e5c: str      x8, [sp, #0x270]
0x105e41e60: mov      x0, x21
0x105e41e64: ldr      x1, [sp, #0xb8]
0x105e41e68: bl       #0x107c27c64 ; _objc_msgSend
0x105e41e6c: tbnz     w0, #0, #0x105e41e84
0x105e41e70: add      x2, sp, #0x270
0x105e41e74: mov      x0, x21
0x105e41e78: ldr      x1, [sp, #0x80]
0x105e41e7c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41e80: cbz      w0, #0x105e41e94
0x105e41e84: ldr      x0, [sp, #0x148]
0x105e41e88: ldr      x1, [sp, #0x90]
0x105e41e8c: mov      x2, x21
0x105e41e90: bl       #0x107c27c64 ; _objc_msgSend
0x105e41e94: mov      x0, x22
0x105e41e98: bl       #0x107c27c70 ; _objc_release
0x105e41e9c: ldr      x0, [sp, #0x1c0]
0x105e41ea0: ldr      x1, [sp, #0x1d8]
0x105e41ea4: mov      x2, x27
0x105e41ea8: bl       #0x107c27c64 ; _objc_msgSend
0x105e41eac: mov      x0, x27
0x105e41eb0: bl       #0x107c27c70 ; _objc_release
0x105e41eb4: mov      x0, x28
0x105e41eb8: bl       #0x107c27c70 ; _objc_release
0x105e41ebc: ldr      x27, [sp, #0x1e8]
0x105e41ec0: add      x19, x19, #1
0x105e41ec4: cmp      x23, x19
0x105e41ec8: b.ne     #0x105e41954
0x105e41ecc: b        #0x105e42040
0x105e41ed0: mov      x0, x21
0x105e41ed4: ldr      x24, [sp, #0x58]
0x105e41ed8: mov      x1, x24
0x105e41edc: bl       #0x107c27c64 ; _objc_msgSend
0x105e41ee0: mov      x29, x29
0x105e41ee4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41ee8: mov      x20, x0
0x105e41eec: ldr      x26, [sp, #0x138]
0x105e41ef0: mov      x1, x26
0x105e41ef4: bl       #0x107c27c64 ; _objc_msgSend
0x105e41ef8: mov      x25, x0
0x105e41efc: mov      x0, x20
0x105e41f00: bl       #0x107c27c70 ; _objc_release
0x105e41f04: cmp      x25, #1
0x105e41f08: b.ne     #0x105e41f74
0x105e41f0c: mov      x0, x21
0x105e41f10: mov      x1, x24
0x105e41f14: bl       #0x107c27c64 ; _objc_msgSend
0x105e41f18: mov      x29, x29
0x105e41f1c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41f20: mov      x20, x0
0x105e41f24: ldr      x1, [sp, #0x50]
0x105e41f28: bl       #0x107c27c64 ; _objc_msgSend
0x105e41f2c: mov      x29, x29
0x105e41f30: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41f34: mov      x26, x0
0x105e41f38: mov      x0, x20
0x105e41f3c: bl       #0x107c27c70 ; _objc_release
0x105e41f40: mov      x0, x26
0x105e41f44: ldr      x24, [sp, #0x48]
0x105e41f48: mov      x1, x24
0x105e41f4c: bl       #0x107c27c64 ; _objc_msgSend
0x105e41f50: cmp      w0, #4
0x105e41f54: adrp     x8, #0x11ed12000
0x105e41f58: adrp     x25, #0x11a2e0000 ; 'tice?language='
0x105e41f5c: add      x25, x25, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41f60: b.ne     #0x105e41fdc
0x105e41f64: mov      x0, x26
0x105e41f68: bl       #0x107c27c70 ; _objc_release
0x105e41f6c: ldr      x20, [sp, #0x170]
0x105e41f70: b        #0x105e41d90
0x105e41f74: adrp     x8, #0x11ed12000
0x105e41f78: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e41f7c: mov      x0, x21
0x105e41f80: mov      x1, x24
0x105e41f84: bl       #0x107c27c64 ; _objc_msgSend
0x105e41f88: mov      x29, x29
0x105e41f8c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e41f90: mov      x21, x0
0x105e41f94: mov      x1, x26
0x105e41f98: bl       #0x107c27c64 ; _objc_msgSend
0x105e41f9c: adrp     x8, #0x11d353000
0x105e41fa0: add      x8, x8, #0x9d8 ; @'only tempmsg can add to template holder:%lu'
0x105e41fa4: stp      x8, x0, [sp] ; @'only tempmsg can add to template holder:%lu'
0x105e41fa8: mov      x0, x20 ; Class iConsole
0x105e41fac: ldr      x1, [sp, #0x1b0]
0x105e41fb0: mov      w2, #2
0x105e41fb4: mov      x3, #0
0x105e41fb8: mov      w4, #0
0x105e41fbc: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e41fc0: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e41fc4: mov      w6, #0x211
0x105e41fc8: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e41fcc: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e41fd0: bl       #0x107c27c64 ; _objc_msgSend
0x105e41fd4: mov      x0, x21
0x105e41fd8: b        #0x105e42024
0x105e41fdc: ldr      x20, [x8, #0x618]
0x105e41fe0: mov      x0, x26
0x105e41fe4: mov      x1, x24
0x105e41fe8: bl       #0x107c27c64 ; _objc_msgSend
0x105e41fec: adrp     x8, #0x11d353000
0x105e41ff0: add      x8, x8, #0x9f8 ; @'only dyeing showtype msg can add to template holder:%u'
0x105e41ff4: stp      x8, x0, [sp] ; @'only dyeing showtype msg can add to template holder:%u'
0x105e41ff8: mov      x0, x20
0x105e41ffc: ldr      x1, [sp, #0x1b0]
0x105e42000: mov      w2, #2
0x105e42004: mov      x3, #0
0x105e42008: mov      w4, #0
0x105e4200c: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e42010: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e42014: mov      w6, #0x216
0x105e42018: mov      x7, x25 ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e4201c: bl       #0x107c27c64 ; _objc_msgSend
0x105e42020: mov      x0, x26
0x105e42024: bl       #0x107c27c70 ; _objc_release
0x105e42028: ldr      x25, [sp, #0x128]
0x105e4202c: ldr      x20, [sp, #0x170]
0x105e42030: mov      x0, x22
0x105e42034: bl       #0x107c27c70 ; _objc_release
0x105e42038: ldr      x24, [sp, #0x158]
0x105e4203c: b        #0x105e41eac
0x105e42040: add      x2, sp, #0x460
0x105e42044: sub      x3, x29, #0xf0
0x105e42048: mov      x0, x20
0x105e4204c: ldr      x1, [sp, #0xc8]
0x105e42050: mov      w4, #0x10
0x105e42054: bl       #0x107c27c64 ; _objc_msgSend
0x105e42058: mov      x23, x0
0x105e4205c: cbnz     x0, #0x105e417f8
0x105e42060: ldr      w8, [sp, #0x168]
0x105e42064: eor      w8, w8, #1
0x105e42068: ldr      w9, [sp, #0x160]
0x105e4206c: and      w21, w9, w8
0x105e42070: ldr      x22, [sp, #0x1c0]
0x105e42074: ldr      x19, [sp, #0x30]
0x105e42078: b        #0x105e420fc
0x105e4207c: adrp     x8, #0x11ed12000
0x105e42080: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e42084: adrp     x8, #0x11e9c9000
0x105e42088: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e4208c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e42090: mov      x29, x29
0x105e42094: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42098: mov      x19, x0
0x105e4209c: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x105e420a0: ldr      x0, [x8, #0xbb0] ; classref VoIPFirstMessageStatisticsService | Class VoIPFirstMessageStatisticsService
0x105e420a4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e420a8: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105e420ac: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105e420b0: mov      x2, x0
0x105e420b4: adrp     x8, #0x11e9c9000
0x105e420b8: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105e420bc: mov      x0, x19
0x105e420c0: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105e420c4: mov      x29, x29
0x105e420c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e420cc: mov      x20, x0
0x105e420d0: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e420d4: ldr      x1, [x8, #0x7b0] ; @selector(receiveIfIsInviteMessage:) | 'receiveIfIsInviteMessage:'
0x105e420d8: mov      w2, #0
0x105e420dc: bl       #0x107c27c64 ; _objc_msgSend | selector=receiveIfIsInviteMessage:
0x105e420e0: mov      x0, x20
0x105e420e4: bl       #0x107c27c70 ; _objc_release
0x105e420e8: mov      x0, x19
0x105e420ec: bl       #0x107c27c70 ; _objc_release
0x105e420f0: mov      w19, #1
0x105e420f4: b        #0x105e43544
0x105e420f8: mov      w21, #0
0x105e420fc: mov      x0, x20
0x105e42100: bl       #0x107c27c70 ; _objc_release
0x105e42104: mov      x0, x19
0x105e42108: bl       #0x107c27c18 ; _objc_autoreleasePoolPop
0x105e4210c: adrp     x24, #0x11ed12000
0x105e42110: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x105e42114: adrp     x8, #0x11e9c9000
0x105e42118: ldr      x23, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105e4211c: mov      x1, x23 ; 'currentContext'
0x105e42120: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e42124: mov      x29, x29
0x105e42128: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4212c: mov      x19, x0
0x105e42130: adrp     x8, #0x11ed32000 ; classref MagicEcsNirvanaLoadingComponent
0x105e42134: ldr      x0, [x8, #0xbb0] ; classref VoIPFirstMessageStatisticsService | Class VoIPFirstMessageStatisticsService
0x105e42138: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105e4213c: ldr      x26, [x8, #0x508] ; @selector(class) | 'class'
0x105e42140: mov      x1, x26 ; 'class'
0x105e42144: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105e42148: mov      x2, x0
0x105e4214c: adrp     x8, #0x11e9c9000
0x105e42150: ldr      x28, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105e42154: mov      x0, x19
0x105e42158: mov      x1, x28 ; 'getService:'
0x105e4215c: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105e42160: mov      x29, x29
0x105e42164: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42168: mov      x20, x0
0x105e4216c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42170: ldr      x1, [x8, #0x7b0] ; @selector(receiveIfIsInviteMessage:) | 'receiveIfIsInviteMessage:'
0x105e42174: and      w2, w21, #1
0x105e42178: bl       #0x107c27c64 ; _objc_msgSend | selector=receiveIfIsInviteMessage:
0x105e4217c: mov      x0, x20
0x105e42180: bl       #0x107c27c70 ; _objc_release
0x105e42184: mov      x0, x19
0x105e42188: bl       #0x107c27c70 ; _objc_release
0x105e4218c: ldr      x0, [x24, #0x780] ; classref MMContext | Class MMContext
0x105e42190: str      x23, [sp, #0x1a0] ; 'currentContext'
0x105e42194: mov      x1, x23 ; 'currentContext'
0x105e42198: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105e4219c: mov      x29, x29
0x105e421a0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e421a4: mov      x19, x0
0x105e421a8: adrp     x8, #0x11ed12000
0x105e421ac: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x105e421b0: str      x26, [sp, #0xa0] ; 'class'
0x105e421b4: mov      x1, x26 ; 'class'
0x105e421b8: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105e421bc: mov      x2, x0
0x105e421c0: mov      x0, x19
0x105e421c4: str      x28, [sp, #0x98] ; 'getService:'
0x105e421c8: mov      x1, x28 ; 'getService:'
0x105e421cc: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105e421d0: mov      x29, x29
0x105e421d4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e421d8: str      x0, [sp, #0x1c8]
0x105e421dc: mov      x0, x19
0x105e421e0: bl       #0x107c27c70 ; _objc_release
0x105e421e4: bl       #0x107c27c1c ; _objc_autoreleasePoolPush
0x105e421e8: str      x0, [sp, #0x158]
0x105e421ec: adrp     x20, #0x11ed12000
0x105e421f0: ldr      x0, [x20, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e421f4: ldr      x19, [sp, #0x130]
0x105e421f8: mov      x1, x19
0x105e421fc: bl       #0x107c27c64 ; _objc_msgSend
0x105e42200: mov      x29, x29
0x105e42204: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42208: str      x0, [sp, #0x1e0]
0x105e4220c: ldr      x0, [x20, #0x630] ; _OBJC_CLASS_$_NSMutableDictionary
0x105e42210: mov      x1, x19
0x105e42214: bl       #0x107c27c64 ; _objc_msgSend
0x105e42218: mov      x29, x29
0x105e4221c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42220: str      x0, [sp, #0x180]
0x105e42224: movi     v0.16b, #0
0x105e42228: str      q0, [sp, #0x420]
0x105e4222c: str      q0, [sp, #0x430]
0x105e42230: str      q0, [sp, #0x440]
0x105e42234: str      q0, [sp, #0x450]
0x105e42238: mov      x0, x22
0x105e4223c: bl       #0x107c27c74 ; _objc_retain
0x105e42240: add      x2, sp, #0x420
0x105e42244: add      x3, sp, #0x6a0
0x105e42248: ldr      x1, [sp, #0xc8]
0x105e4224c: mov      w4, #0x10
0x105e42250: bl       #0x107c27c64 ; _objc_msgSend
0x105e42254: cbz      x0, #0x105e42524
0x105e42258: mov      x20, x0
0x105e4225c: ldr      x8, [sp, #0x430]
0x105e42260: adrp     x9, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42264: adrp     x10, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42268: adrp     x11, #0x11e9d1000 ; @selector(scanItem)
0x105e4226c: adrp     x12, #0x11eca9000 ; @selector(makeCallTree)
0x105e42270: ldr      x26, [x8]
0x105e42274: adrp     x13, #0x11ea91000 ; @selector(m_tableVoIPCancelMsg)
0x105e42278: adrp     x14, #0x11eca9000 ; @selector(makeCallTree)
0x105e4227c: adrp     x15, #0x11eca9000 ; @selector(makeCallTree)
0x105e42280: adrp     x16, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42284: adrp     x17, #0x11ecac000 ; @selector(setManager:)
0x105e42288: adrp     x0, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e4228c: mov      x24, #0
0x105e42290: ldr      x23, [x9, #0x7e8] ; @selector(isCanAddDB) | 'isCanAddDB'
0x105e42294: ldr      x28, [x10, #0x7f0] ; @selector(addMsgType) | 'addMsgType'
0x105e42298: ldr      x9, [x11, #0x28] ; @selector(realChatName) | 'realChatName'
0x105e4229c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e422a0: ldr      x19, [x8, #0xce8] ; @selector(length) | 'length'
0x105e422a4: ldr      x8, [x12, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105e422a8: stp      x9, x8, [sp, #0x1d0] ; 'realChatName'
0x105e422ac: ldr      x9, [x13, #0x148] ; @selector(getTargetingDatabaseWithUserName:excludingMMDB:) | 'getTargetingDatabaseWithUserName:excludingMMDB:'
0x105e422b0: ldr      x8, [x14, #0xd28] ; @selector(path) | 'path'
0x105e422b4: stp      x8, x9, [sp, #0x170] ; 'path'
0x105e422b8: ldr      x9, [x15, #0x650] ; @selector(objectForKeyedSubscript:) | 'objectForKeyedSubscript:'
0x105e422bc: ldr      x8, [x16, #0x700] ; @selector(initWithDataBase:) | 'initWithDataBase:'
0x105e422c0: stp      x8, x9, [sp, #0x160] ; 'initWithDataBase:'
0x105e422c4: ldr      x9, [x17, #0x298] ; @selector(setObject:forKeyedSubscript:) | 'setObject:forKeyedSubscript:'
0x105e422c8: ldr      x8, [x0, #0x7f8] ; @selector(arrMsgInfo) | 'arrMsgInfo'
0x105e422cc: str      x8, [sp, #0x198] ; 'arrMsgInfo'
0x105e422d0: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e422d4: ldr      x8, [x8, #0xa38] ; @selector(addObject:) | 'addObject:'
0x105e422d8: stp      x9, x8, [sp, #0x188] ; 'setObject:forKeyedSubscript:'
0x105e422dc: stp      x23, x19, [sp, #0x1b0] ; 'isCanAddDB'
0x105e422e0: ldr      x8, [sp, #0x430]
0x105e422e4: ldr      x8, [x8]
0x105e422e8: cmp      x8, x26
0x105e422ec: b.eq     #0x105e422f8
0x105e422f0: ldr      x0, [sp, #0x1c0]
0x105e422f4: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e422f8: ldr      x8, [sp, #0x428]
0x105e422fc: ldr      x22, [x8, x24, lsl #3]
0x105e42300: mov      x0, x22
0x105e42304: mov      x1, x23 ; 'isCanAddDB'
0x105e42308: bl       #0x107c27c64 ; _objc_msgSend | selector=isCanAddDB
0x105e4230c: cbz      w0, #0x105e424cc
0x105e42310: mov      x0, x22
0x105e42314: mov      x1, x28 ; 'addMsgType'
0x105e42318: bl       #0x107c27c64 ; _objc_msgSend | selector=addMsgType
0x105e4231c: cmp      x0, #2
0x105e42320: b.eq     #0x105e42338
0x105e42324: mov      x0, x22
0x105e42328: mov      x1, x28 ; 'addMsgType'
0x105e4232c: bl       #0x107c27c64 ; _objc_msgSend | selector=addMsgType
0x105e42330: cmp      x0, #3
0x105e42334: b.ne     #0x105e424cc
0x105e42338: mov      x0, x22
0x105e4233c: ldr      x1, [sp, #0x1d0]
0x105e42340: bl       #0x107c27c64 ; _objc_msgSend
0x105e42344: mov      x29, x29
0x105e42348: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4234c: mov      x21, x0
0x105e42350: mov      x1, x19 ; 'length'
0x105e42354: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105e42358: cbz      x0, #0x105e42b3c
0x105e4235c: mov      x23, x20
0x105e42360: mov      x20, x28 ; 'addMsgType'
0x105e42364: ldr      x0, [sp, #0x180]
0x105e42368: ldr      x1, [sp, #0x1d8]
0x105e4236c: mov      x2, x21
0x105e42370: bl       #0x107c27c64 ; _objc_msgSend
0x105e42374: mov      x29, x29
0x105e42378: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4237c: mov      x25, x0
0x105e42380: mov      x1, x19 ; 'length'
0x105e42384: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105e42388: cbz      x0, #0x105e42394
0x105e4238c: mov      x27, x25
0x105e42390: b        #0x105e4245c
0x105e42394: adrp     x8, #0x11edd4000
0x105e42398: ldrsw    x8, [x8, #0x610] ; ivar_offset SyncCmdHandler.m_oMMDB=0x38
0x105e4239c: ldr      x0, [x27, x8]
0x105e423a0: ldr      x1, [sp, #0x178]
0x105e423a4: mov      x2, x21
0x105e423a8: mov      w3, #0
0x105e423ac: bl       #0x107c27c64 ; _objc_msgSend
0x105e423b0: mov      x29, x29
0x105e423b4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e423b8: mov      x28, x0
0x105e423bc: ldr      x1, [sp, #0x170]
0x105e423c0: bl       #0x107c27c64 ; _objc_msgSend
0x105e423c4: mov      x29, x29
0x105e423c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e423cc: mov      x27, x0
0x105e423d0: mov      x0, x25
0x105e423d4: bl       #0x107c27c70 ; _objc_release
0x105e423d8: mov      x0, x27
0x105e423dc: mov      x1, x19 ; 'length'
0x105e423e0: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105e423e4: cbz      x0, #0x105e43234
0x105e423e8: ldr      x0, [sp, #0x1e0]
0x105e423ec: ldr      x1, [sp, #0x168]
0x105e423f0: mov      x2, x27
0x105e423f4: bl       #0x107c27c64 ; _objc_msgSend
0x105e423f8: mov      x29, x29
0x105e423fc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42400: mov      x25, x0
0x105e42404: bl       #0x107c27c70 ; _objc_release
0x105e42408: cbnz     x25, #0x105e42444
0x105e4240c: adrp     x8, #0x11ed37000 ; classref GetEmotionRewardRequest
0x105e42410: ldr      x0, [x8, #0x120] ; classref DBWrapper | Class DBWrapper
0x105e42414: bl       #0x107c27c08 ; _objc_alloc
0x105e42418: ldr      x1, [sp, #0x160]
0x105e4241c: mov      x2, x28
0x105e42420: bl       #0x107c27c64 ; _objc_msgSend
0x105e42424: mov      x25, x0
0x105e42428: ldr      x0, [sp, #0x1e0]
0x105e4242c: ldr      x1, [sp, #0x188]
0x105e42430: mov      x2, x25
0x105e42434: mov      x3, x27
0x105e42438: bl       #0x107c27c64 ; _objc_msgSend
0x105e4243c: mov      x0, x25
0x105e42440: bl       #0x107c27c70 ; _objc_release
0x105e42444: ldp      x0, x1, [sp, #0x180]
0x105e42448: mov      x2, x27
0x105e4244c: mov      x3, x21
0x105e42450: bl       #0x107c27c64 ; _objc_msgSend
0x105e42454: mov      x0, x28
0x105e42458: bl       #0x107c27c70 ; _objc_release
0x105e4245c: ldp      x1, x0, [sp, #0x1d8]
0x105e42460: mov      x2, x27
0x105e42464: bl       #0x107c27c64 ; _objc_msgSend
0x105e42468: mov      x29, x29
0x105e4246c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42470: mov      x25, x0
0x105e42474: ldr      x1, [sp, #0x198]
0x105e42478: bl       #0x107c27c64 ; _objc_msgSend
0x105e4247c: mov      x29, x29
0x105e42480: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42484: mov      x28, x0
0x105e42488: mov      x0, x25
0x105e4248c: bl       #0x107c27c70 ; _objc_release
0x105e42490: mov      x0, x28
0x105e42494: ldr      x1, [sp, #0x190]
0x105e42498: mov      x2, x22
0x105e4249c: bl       #0x107c27c64 ; _objc_msgSend
0x105e424a0: mov      x0, x28
0x105e424a4: bl       #0x107c27c70 ; _objc_release
0x105e424a8: mov      x0, x27
0x105e424ac: bl       #0x107c27c70 ; _objc_release
0x105e424b0: mov      x0, x21
0x105e424b4: bl       #0x107c27c70 ; _objc_release
0x105e424b8: ldr      x25, [sp, #0x128]
0x105e424bc: ldr      x27, [sp, #0x1e8]
0x105e424c0: mov      x28, x20 ; 'addMsgType'
0x105e424c4: mov      x20, x23
0x105e424c8: ldp      x23, x19, [sp, #0x1b0]
0x105e424cc: add      x24, x24, #1
0x105e424d0: cmp      x20, x24
0x105e424d4: b.ne     #0x105e422e0
0x105e424d8: add      x2, sp, #0x420
0x105e424dc: add      x3, sp, #0x6a0
0x105e424e0: ldr      x22, [sp, #0x1c0]
0x105e424e4: mov      x0, x22
0x105e424e8: ldr      x1, [sp, #0xc8]
0x105e424ec: mov      w4, #0x10
0x105e424f0: bl       #0x107c27c64 ; _objc_msgSend
0x105e424f4: mov      x20, x0
0x105e424f8: adrp     x9, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e424fc: adrp     x10, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42500: adrp     x11, #0x11e9d1000 ; @selector(scanItem)
0x105e42504: adrp     x12, #0x11eca9000 ; @selector(makeCallTree)
0x105e42508: adrp     x13, #0x11ea91000 ; @selector(m_tableVoIPCancelMsg)
0x105e4250c: adrp     x14, #0x11eca9000 ; @selector(makeCallTree)
0x105e42510: adrp     x15, #0x11eca9000 ; @selector(makeCallTree)
0x105e42514: adrp     x16, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42518: adrp     x17, #0x11ecac000 ; @selector(setManager:)
0x105e4251c: adrp     x0, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42520: cbnz     x20, #0x105e4228c
0x105e42524: mov      x0, x22
0x105e42528: bl       #0x107c27c70 ; _objc_release
0x105e4252c: adrp     x8, #0x11ed12000
0x105e42530: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x105e42534: adrp     x8, #0x11e9c9000
0x105e42538: ldr      x1, [x8, #0xf20] ; @selector(genCurrentTimeInMs) | 'genCurrentTimeInMs'
0x105e4253c: str      x1, [sp, #0x178] ; 'genCurrentTimeInMs'
0x105e42540: bl       #0x107c27c64 ; _objc_msgSend | selector=genCurrentTimeInMs
0x105e42544: str      x0, [sp, #0x1b8]
0x105e42548: bl       #0x107c27884 ; _dispatch_group_create
0x105e4254c: str      x0, [sp, #0x1d8]
0x105e42550: mov      x0, #0
0x105e42554: mov      x1, #0
0x105e42558: bl       #0x107c2787c ; _dispatch_get_global_queue
0x105e4255c: mov      x29, x29
0x105e42560: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42564: str      x0, [sp, #0x1d0]
0x105e42568: add      x19, sp, #0x270
0x105e4256c: str      xzr, [sp, #0x270]
0x105e42570: str      x19, [sp, #0x278]
0x105e42574: adrp     x8, #0x1178c7000
0x105e42578: ldr      d0, [x8, #0x7f8]
0x105e4257c: str      d0, [sp, #0x280]
0x105e42580: mov      w8, #1
0x105e42584: strb     w8, [sp, #0x288]
0x105e42588: movi     v0.16b, #0
0x105e4258c: stp      q0, q0, [sp, #0x3e0]
0x105e42590: str      q0, [sp, #0x400]
0x105e42594: str      q0, [sp, #0x410]
0x105e42598: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105e4259c: ldr      x1, [x8, #0xba0] ; @selector(allKeys) | 'allKeys'
0x105e425a0: ldr      x0, [sp, #0x1e0]
0x105e425a4: bl       #0x107c27c64 ; _objc_msgSend | selector=allKeys
0x105e425a8: mov      x29, x29
0x105e425ac: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e425b0: mov      x22, x0
0x105e425b4: add      x2, sp, #0x3e0
0x105e425b8: add      x3, sp, #0x620
0x105e425bc: ldr      x1, [sp, #0xc8]
0x105e425c0: mov      w4, #0x10
0x105e425c4: bl       #0x107c27c64 ; _objc_msgSend
0x105e425c8: adrp     x28, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e425cc: ldr      x28, [x28, #0x930] ; __NSConcreteStackBlock
0x105e425d0: cbz      x0, #0x105e42684
0x105e425d4: mov      x23, x0
0x105e425d8: ldr      x8, [sp, #0x3f0]
0x105e425dc: ldr      x20, [x8]
0x105e425e0: adrp     x8, #0x1178c7000
0x105e425e4: ldr      d8, [x8, #0x680]
0x105e425e8: adrp     x21, #0x105e43000
0x105e425ec: add      x21, x21, #0x588
0x105e425f0: adrp     x24, #0x11c2a3000
0x105e425f4: add      x24, x24, #0x5f0
0x105e425f8: mov      x25, #0
0x105e425fc: ldr      x8, [sp, #0x3f0]
0x105e42600: ldr      x8, [x8]
0x105e42604: cmp      x8, x20
0x105e42608: b.eq     #0x105e42614
0x105e4260c: mov      x0, x22
0x105e42610: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e42614: ldr      x8, [sp, #0x3e8]
0x105e42618: ldr      x26, [x8, x25, lsl #3]
0x105e4261c: str      x28, [sp, #0x3a0]
0x105e42620: str      d8, [sp, #0x3a8]
0x105e42624: str      x21, [sp, #0x3b0]
0x105e42628: str      x24, [sp, #0x3b8]
0x105e4262c: ldr      x0, [sp, #0x1e0]
0x105e42630: bl       #0x107c27c74 ; _objc_retain
0x105e42634: str      x0, [sp, #0x3c0]
0x105e42638: str      x26, [sp, #0x3c8]
0x105e4263c: str      x27, [sp, #0x3d0]
0x105e42640: str      x19, [sp, #0x3d8]
0x105e42644: add      x2, sp, #0x3a0
0x105e42648: ldp      x1, x0, [sp, #0x1d0]
0x105e4264c: bl       #0x107c0cbac
0x105e42650: ldr      x0, [sp, #0x3c0]
0x105e42654: bl       #0x107c27c70 ; _objc_release
0x105e42658: add      x25, x25, #1
0x105e4265c: cmp      x23, x25
0x105e42660: b.ne     #0x105e425fc
0x105e42664: add      x2, sp, #0x3e0
0x105e42668: add      x3, sp, #0x620
0x105e4266c: mov      x0, x22
0x105e42670: ldr      x1, [sp, #0xc8]
0x105e42674: mov      w4, #0x10
0x105e42678: bl       #0x107c27c64 ; _objc_msgSend
0x105e4267c: mov      x23, x0
0x105e42680: cbnz     x0, #0x105e425f8
0x105e42684: mov      x0, x22
0x105e42688: bl       #0x107c27c70 ; _objc_release
0x105e4268c: ldr      x0, [sp, #0x1d8]
0x105e42690: mov      x1, #-1
0x105e42694: bl       #0x107c27890 ; _dispatch_group_wait
0x105e42698: ldr      x8, [sp, #0x278]
0x105e4269c: ldrb     w19, [x8, #0x18]
0x105e426a0: tbz      w19, #0, #0x105e42bb0
0x105e426a4: str      w19, [sp, #0x170]
0x105e426a8: movi     v0.16b, #0
0x105e426ac: stp      q0, q0, [sp, #0x380]
0x105e426b0: stp      q0, q0, [sp, #0x360]
0x105e426b4: ldr      x0, [sp, #0x148]
0x105e426b8: bl       #0x107c27c74 ; _objc_retain
0x105e426bc: add      x2, sp, #0x360
0x105e426c0: add      x3, sp, #0x5a0
0x105e426c4: ldr      x1, [sp, #0xc8]
0x105e426c8: mov      w4, #0x10
0x105e426cc: bl       #0x107c27c64 ; _objc_msgSend
0x105e426d0: cbz      x0, #0x105e427c4
0x105e426d4: mov      x22, x0
0x105e426d8: ldr      x8, [sp, #0x370]
0x105e426dc: ldr      x21, [x8]
0x105e426e0: adrp     x24, #0x11edd4000
0x105e426e4: mov      x19, #-1
0x105e426e8: mov      x20, #0
0x105e426ec: adrp     x8, #0x11eb23000 ; @selector(clearReddot:)
0x105e426f0: ldr      x23, [x8, #0x900] ; @selector(IsNeedAddWCPayMsgBizExt) | 'IsNeedAddWCPayMsgBizExt'
0x105e426f4: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e426f8: ldr      x25, [x8, #0x838] ; @selector(AddMessageToWCPayMsgBizExt:DB:) | 'AddMessageToWCPayMsgBizExt:DB:'
0x105e426fc: adrp     x8, #0x11ea16000 ; @selector(getSessionDetailQueue)
0x105e42700: ldr      x26, [x8, #0x378] ; @selector(isNewWCPayBizExtMsg:) | 'isNewWCPayBizExtMsg:'
0x105e42704: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42708: ldr      x27, [x8, #0x840] ; @selector(AddMessageToNewWCPayBizExt:DB:type:) | 'AddMessageToNewWCPayBizExt:DB:type:'
0x105e4270c: ldr      x8, [sp, #0x370]
0x105e42710: ldr      x8, [x8]
0x105e42714: cmp      x8, x21
0x105e42718: b.eq     #0x105e42724
0x105e4271c: ldr      x0, [sp, #0x148]
0x105e42720: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e42724: ldr      x8, [sp, #0x368]
0x105e42728: ldr      x28, [x8, x20, lsl #3]
0x105e4272c: mov      x0, x28
0x105e42730: mov      x1, x23 ; 'IsNeedAddWCPayMsgBizExt'
0x105e42734: bl       #0x107c27c64 ; _objc_msgSend | selector=IsNeedAddWCPayMsgBizExt
0x105e42738: cbz      w0, #0x105e4275c
0x105e4273c: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e42740: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e42744: ldrsw    x8, [x24, #0x610] ; ivar_offset SyncCmdHandler.m_oMMDB=0x38
0x105e42748: ldr      x9, [sp, #0x1e8]
0x105e4274c: ldr      x3, [x9, x8]
0x105e42750: mov      x1, x25 ; 'AddMessageToWCPayMsgBizExt:DB:'
0x105e42754: mov      x2, x28
0x105e42758: bl       #0x107c27c64 ; _objc_msgSend | selector=AddMessageToWCPayMsgBizExt:DB:
0x105e4275c: str      x19, [sp, #0x358]
0x105e42760: add      x2, sp, #0x358
0x105e42764: mov      x0, x28
0x105e42768: mov      x1, x26 ; 'isNewWCPayBizExtMsg:'
0x105e4276c: bl       #0x107c27c64 ; _objc_msgSend | selector=isNewWCPayBizExtMsg:
0x105e42770: cbz      w0, #0x105e42798
0x105e42774: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e42778: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e4277c: ldrsw    x8, [x24, #0x610] ; ivar_offset SyncCmdHandler.m_oMMDB=0x38
0x105e42780: ldr      x9, [sp, #0x1e8]
0x105e42784: ldr      x3, [x9, x8]
0x105e42788: ldr      w4, [sp, #0x358]
0x105e4278c: mov      x1, x27 ; 'AddMessageToNewWCPayBizExt:DB:type:'
0x105e42790: mov      x2, x28
0x105e42794: bl       #0x107c27c64 ; _objc_msgSend | selector=AddMessageToNewWCPayBizExt:DB:type:
0x105e42798: add      x20, x20, #1
0x105e4279c: cmp      x22, x20
0x105e427a0: b.ne     #0x105e4270c
0x105e427a4: add      x2, sp, #0x360
0x105e427a8: add      x3, sp, #0x5a0
0x105e427ac: ldr      x0, [sp, #0x148]
0x105e427b0: ldr      x1, [sp, #0xc8]
0x105e427b4: mov      w4, #0x10
0x105e427b8: bl       #0x107c27c64 ; _objc_msgSend
0x105e427bc: mov      x22, x0
0x105e427c0: cbnz     x0, #0x105e426e8
0x105e427c4: ldr      x0, [sp, #0x148]
0x105e427c8: bl       #0x107c27c70 ; _objc_release
0x105e427cc: adrp     x21, #0x11ed12000
0x105e427d0: ldr      x0, [x21, #0x8a0] ; classref CUtility | Class CUtility
0x105e427d4: ldr      x22, [sp, #0x178]
0x105e427d8: mov      x1, x22
0x105e427dc: bl       #0x107c27c64 ; _objc_msgSend
0x105e427e0: ldr      x8, [sp, #0x1b8]
0x105e427e4: sub      x19, x0, x8
0x105e427e8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e427ec: ldr      x1, [x8, #0x848] ; @selector(addMsgTime) | 'addMsgTime'
0x105e427f0: ldr      x20, [sp, #0x1e8]
0x105e427f4: mov      x0, x20
0x105e427f8: bl       #0x107c27c64 ; _objc_msgSend | selector=addMsgTime
0x105e427fc: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42800: ldr      x1, [x8, #0x850] ; @selector(setAddMsgTime:) | 'setAddMsgTime:'
0x105e42804: add      x2, x19, x0
0x105e42808: mov      x0, x20
0x105e4280c: bl       #0x107c27c64 ; _objc_msgSend | selector=setAddMsgTime:
0x105e42810: ldr      x0, [x21, #0x8a0] ; classref CUtility | Class CUtility
0x105e42814: mov      x1, x22
0x105e42818: bl       #0x107c27c64 ; _objc_msgSend
0x105e4281c: str      x0, [sp, #0x168]
0x105e42820: movi     v0.16b, #0
0x105e42824: stp      q0, q0, [sp, #0x310]
0x105e42828: stp      q0, q0, [sp, #0x330]
0x105e4282c: adrp     x8, #0x11edd4000
0x105e42830: ldrsw    x8, [x8, #0x5fc] ; ivar_offset SyncCmdHandler.m_dicWebWxClearUnRead=0x10
0x105e42834: str      x8, [sp, #0x198]
0x105e42838: ldr      x0, [x20, x8]
0x105e4283c: bl       #0x107c27c74 ; _objc_retain
0x105e42840: add      x2, sp, #0x310
0x105e42844: add      x3, sp, #0x520
0x105e42848: str      x0, [sp, #0x188]
0x105e4284c: ldr      x1, [sp, #0xc8]
0x105e42850: mov      w4, #0x10
0x105e42854: bl       #0x107c27c64 ; _objc_msgSend
0x105e42858: str      x0, [sp, #0x1b8]
0x105e4285c: cbz      x0, #0x105e429d0
0x105e42860: ldr      x8, [sp, #0x320]
0x105e42864: ldr      x8, [x8]
0x105e42868: str      x8, [sp, #0x190]
0x105e4286c: adrp     x8, #0x1178c7000
0x105e42870: ldr      d8, [x8, #0x680]
0x105e42874: mov      x25, #0
0x105e42878: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105e4287c: ldr      x8, [x8, #0x640] ; @selector(objectForKey:) | 'objectForKey:'
0x105e42880: str      x8, [sp, #0x1b0] ; 'objectForKey:'
0x105e42884: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105e42888: ldr      x27, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105e4288c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105e42890: ldr      x28, [x8, #0xf28] ; @selector(longLongValue) | 'longLongValue'
0x105e42894: adrp     x8, #0x11eb3c000 ; @selector(uploadCost)
0x105e42898: ldr      x21, [x8, #0x518] ; @selector(ClearUnreadForSync:CreateTime:) | 'ClearUnreadForSync:CreateTime:'
0x105e4289c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e428a0: ldr      x26, [x8, #0x858] ; @selector(onNewSyncMarkRead:lastMsgTime:) | 'onNewSyncMarkRead:lastMsgTime:'
0x105e428a4: adrp     x8, #0x11e9c9000
0x105e428a8: ldr      x22, [x8, #0xf70] ; @selector(callExtensionOnMainThread:selector:sync:block:) | 'callExtensionOnMainThread:selector:sync:block:'
0x105e428ac: ldr      x8, [sp, #0x320]
0x105e428b0: ldr      x8, [x8]
0x105e428b4: ldr      x9, [sp, #0x190]
0x105e428b8: cmp      x8, x9
0x105e428bc: b.eq     #0x105e428c8
0x105e428c0: ldr      x0, [sp, #0x188]
0x105e428c4: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e428c8: ldr      x8, [sp, #0x318]
0x105e428cc: ldr      x20, [x8, x25, lsl #3]
0x105e428d0: ldr      x8, [sp, #0x1e8]
0x105e428d4: ldr      x9, [sp, #0x198]
0x105e428d8: ldr      x0, [x8, x9]
0x105e428dc: ldr      x1, [sp, #0x1b0]
0x105e428e0: mov      x2, x20
0x105e428e4: bl       #0x107c27c64 ; _objc_msgSend
0x105e428e8: mov      x29, x29
0x105e428ec: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e428f0: mov      x24, x0
0x105e428f4: ldr      x0, [sp, #0x1a8]
0x105e428f8: mov      x1, x27 ; 'safeAddObject:'
0x105e428fc: mov      x2, x20
0x105e42900: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e42904: mov      x0, x24
0x105e42908: mov      x1, x28 ; 'longLongValue'
0x105e4290c: bl       #0x107c27c64 ; _objc_msgSend | selector=longLongValue
0x105e42910: mov      x19, x0
0x105e42914: ldr      x0, [sp, #0x1c8]
0x105e42918: mov      x1, x21 ; 'ClearUnreadForSync:CreateTime:'
0x105e4291c: mov      x2, x20
0x105e42920: mov      x3, x19
0x105e42924: bl       #0x107c27c64 ; _objc_msgSend | selector=ClearUnreadForSync:CreateTime:
0x105e42928: adrp     x8, #0x11ed12000
0x105e4292c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e42930: ldr      x1, [sp, #0x1a0]
0x105e42934: bl       #0x107c27c64 ; _objc_msgSend
0x105e42938: mov      x29, x29
0x105e4293c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42940: mov      x23, x0
0x105e42944: adrp     x8, #0x11ed0f000 ; @selector(onJumpToResultPageWithCurQueryText:)
0x105e42948: ldr      x2, [x8, #0x760]
0x105e4294c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e42950: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105e42954: str      x8, [sp, #0x2e0]
0x105e42958: str      d8, [sp, #0x2e8]
0x105e4295c: adrp     x8, #0x105e44000
0x105e42960: add      x8, x8, #0x138
0x105e42964: str      x8, [sp, #0x2f0]
0x105e42968: adrp     x8, #0x11c280000
0x105e4296c: add      x8, x8, #0x8a0
0x105e42970: str      x8, [sp, #0x2f8]
0x105e42974: str      x20, [sp, #0x300]
0x105e42978: str      w19, [sp, #0x308]
0x105e4297c: add      x5, sp, #0x2e0
0x105e42980: mov      x1, x22 ; 'callExtensionOnMainThread:selector:sync:block:'
0x105e42984: mov      x3, x26 ; 'onNewSyncMarkRead:lastMsgTime:'
0x105e42988: mov      w4, #0
0x105e4298c: bl       #0x107c27c64 ; _objc_msgSend | selector=callExtensionOnMainThread:selector:sync:block:
0x105e42990: mov      x0, x23
0x105e42994: bl       #0x107c27c70 ; _objc_release
0x105e42998: mov      x0, x24
0x105e4299c: bl       #0x107c27c70 ; _objc_release
0x105e429a0: add      x25, x25, #1
0x105e429a4: ldr      x8, [sp, #0x1b8]
0x105e429a8: cmp      x8, x25
0x105e429ac: b.ne     #0x105e428ac
0x105e429b0: add      x2, sp, #0x310
0x105e429b4: add      x3, sp, #0x520
0x105e429b8: ldr      x0, [sp, #0x188]
0x105e429bc: ldr      x1, [sp, #0xc8]
0x105e429c0: mov      w4, #0x10
0x105e429c4: bl       #0x107c27c64 ; _objc_msgSend
0x105e429c8: str      x0, [sp, #0x1b8]
0x105e429cc: cbnz     x0, #0x105e42874
0x105e429d0: ldr      x0, [sp, #0x188]
0x105e429d4: bl       #0x107c27c70 ; _objc_release
0x105e429d8: adrp     x8, #0x11ed12000
0x105e429dc: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x105e429e0: ldr      x1, [sp, #0x178]
0x105e429e4: bl       #0x107c27c64 ; _objc_msgSend
0x105e429e8: ldr      x8, [sp, #0x168]
0x105e429ec: sub      x8, x0, x8
0x105e429f0: adrp     x9, #0x11edd4000
0x105e429f4: ldrsw    x9, [x9, #0x61c] ; ivar_offset SyncCmdHandler._clearUnReadTime=0x58
0x105e429f8: ldr      x27, [sp, #0x1e8]
0x105e429fc: str      x8, [x27, x9]
0x105e42a00: ldr      x21, [sp, #0x1c0]
0x105e42a04: adrp     x28, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e42a08: ldr      x28, [x28, #0x930] ; __NSConcreteStackBlock
0x105e42a0c: ldr      w19, [sp, #0x170]
0x105e42a10: b        #0x105e42bf8
0x105e42a14: adrp     x8, #0x11ed12000
0x105e42a18: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e42a1c: adrp     x24, #0x11ed12000
0x105e42a20: ldr      x22, [x24, #0x638] ; _OBJC_CLASS_$_NSString
0x105e42a24: mov      x0, x21
0x105e42a28: ldr      x1, [sp, #0x120]
0x105e42a2c: bl       #0x107c27c64 ; _objc_msgSend
0x105e42a30: mov      x29, x29
0x105e42a34: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42a38: mov      x19, x0
0x105e42a3c: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105e42a40: ldr      x23, [x8, #0xfb8] ; @selector(generatePrivacyString:) | 'generatePrivacyString:'
0x105e42a44: mov      x0, x22
0x105e42a48: mov      x1, x23 ; 'generatePrivacyString:'
0x105e42a4c: mov      x2, x19
0x105e42a50: bl       #0x107c27c64 ; _objc_msgSend | selector=generatePrivacyString:
0x105e42a54: mov      x29, x29
0x105e42a58: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42a5c: mov      x22, x0
0x105e42a60: ldr      x24, [x24, #0x638] ; _OBJC_CLASS_$_NSString
0x105e42a64: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e42a68: ldr      x1, [x8, #0x368] ; @selector(m_nsToUsr) | 'm_nsToUsr'
0x105e42a6c: mov      x0, x21
0x105e42a70: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsToUsr
0x105e42a74: mov      x29, x29
0x105e42a78: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42a7c: mov      x25, x0
0x105e42a80: mov      x0, x24
0x105e42a84: mov      x1, x23 ; 'generatePrivacyString:'
0x105e42a88: mov      x2, x25
0x105e42a8c: bl       #0x107c27c64 ; _objc_msgSend | selector=generatePrivacyString:
0x105e42a90: mov      x29, x29
0x105e42a94: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42a98: mov      x23, x0
0x105e42a9c: mov      x0, x21
0x105e42aa0: ldr      x1, [sp, #0x1a0]
0x105e42aa4: bl       #0x107c27c64 ; _objc_msgSend
0x105e42aa8: stp      x23, x0, [sp, #0x10]
0x105e42aac: adrp     x8, #0x11d353000
0x105e42ab0: add      x8, x8, #0x958 ; @'add hello msg fail f %@ t %@ s %lld'
0x105e42ab4: stp      x8, x22, [sp] ; @'add hello msg fail f %@ t %@ s %lld'
0x105e42ab8: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e42abc: add      x3, x3, #0xfaf ; 'Sync'
0x105e42ac0: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e42ac4: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e42ac8: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e42acc: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e42ad0: mov      x0, x20 ; Class iConsole
0x105e42ad4: ldr      x1, [sp, #0x1b0]
0x105e42ad8: mov      w2, #4
0x105e42adc: mov      w4, #0
0x105e42ae0: mov      w6, #0x1f8
0x105e42ae4: bl       #0x107c27c64 ; _objc_msgSend
0x105e42ae8: mov      x0, x23
0x105e42aec: bl       #0x107c27c70 ; _objc_release
0x105e42af0: mov      x0, x25
0x105e42af4: bl       #0x107c27c70 ; _objc_release
0x105e42af8: mov      x0, x22
0x105e42afc: bl       #0x107c27c70 ; _objc_release
0x105e42b00: mov      x0, x19
0x105e42b04: bl       #0x107c27c70 ; _objc_release
0x105e42b08: mov      x0, x27
0x105e42b0c: bl       #0x107c27c70 ; _objc_release
0x105e42b10: mov      x0, x28
0x105e42b14: bl       #0x107c27c70 ; _objc_release
0x105e42b18: ldr      x0, [sp, #0x170]
0x105e42b1c: bl       #0x107c27c70 ; _objc_release
0x105e42b20: ldr      x0, [sp, #0x30]
0x105e42b24: bl       #0x107c27c18 ; _objc_autoreleasePoolPop
0x105e42b28: mov      w19, #0
0x105e42b2c: ldr      x23, [sp, #0xc0]
0x105e42b30: ldr      x25, [sp, #0x128]
0x105e42b34: ldr      x21, [sp, #0x1c0]
0x105e42b38: b        #0x105e434e4
0x105e42b3c: adrp     x8, #0x11ed12000
0x105e42b40: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e42b44: adrp     x8, #0x11e9ed000 ; @selector(setDigestFinderLiveInfoFromAff:)
0x105e42b48: ldr      x1, [x8, #0xa18] ; @selector(wrapMsg) | 'wrapMsg'
0x105e42b4c: mov      x0, x22
0x105e42b50: bl       #0x107c27c64 ; _objc_msgSend | selector=wrapMsg
0x105e42b54: mov      x29, x29
0x105e42b58: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42b5c: mov      x27, x0
0x105e42b60: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105e42b64: ldr      x1, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x105e42b68: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105e42b6c: adrp     x8, #0x11e9c9000
0x105e42b70: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e42b74: adrp     x8, #0x11d353000
0x105e42b78: add      x8, x8, #0xa38 ; @'nil chatName for msg svrid:%lld'
0x105e42b7c: stp      x8, x0, [sp] ; @'nil chatName for msg svrid:%lld'
0x105e42b80: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e42b84: add      x3, x3, #0xfaf ; 'Sync'
0x105e42b88: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e42b8c: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e42b90: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e42b94: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e42b98: mov      x0, x20 ; Class iConsole
0x105e42b9c: mov      w2, #4
0x105e42ba0: mov      w4, #0
0x105e42ba4: mov      w6, #0x23f
0x105e42ba8: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e42bac: b        #0x105e432bc
0x105e42bb0: adrp     x8, #0x11ed12000
0x105e42bb4: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e42bb8: adrp     x8, #0x11e9c9000
0x105e42bbc: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e42bc0: adrp     x8, #0x11d353000
0x105e42bc4: add      x8, x8, #0xb18 ; @'add msg fail!'
0x105e42bc8: str      x8, [sp] ; @'add msg fail!'
0x105e42bcc: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e42bd0: add      x3, x3, #0xfaf ; 'Sync'
0x105e42bd4: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e42bd8: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e42bdc: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e42be0: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e42be4: mov      w2, #4
0x105e42be8: mov      w4, #0
0x105e42bec: mov      w6, #0x2de
0x105e42bf0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e42bf4: ldr      x21, [sp, #0x1c0]
0x105e42bf8: add      x0, sp, #0x270
0x105e42bfc: mov      w1, #8
0x105e42c00: bl       #0x107c26d80 ; __Block_object_dispose
0x105e42c04: ldr      x0, [sp, #0x1d0]
0x105e42c08: bl       #0x107c27c70 ; _objc_release
0x105e42c0c: ldr      x0, [sp, #0x1d8]
0x105e42c10: bl       #0x107c27c70 ; _objc_release
0x105e42c14: ldr      x0, [sp, #0x180]
0x105e42c18: bl       #0x107c27c70 ; _objc_release
0x105e42c1c: ldr      x0, [sp, #0x1e0]
0x105e42c20: bl       #0x107c27c70 ; _objc_release
0x105e42c24: ldr      x0, [sp, #0x158]
0x105e42c28: bl       #0x107c27c18 ; _objc_autoreleasePoolPop
0x105e42c2c: ldr      x23, [sp, #0xc0]
0x105e42c30: ldr      x25, [sp, #0x128]
0x105e42c34: cbz      w19, #0x105e432f4
0x105e42c38: adrp     x8, #0x11ed12000
0x105e42c3c: ldr      x0, [x8, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e42c40: ldr      x1, [sp, #0x38]
0x105e42c44: bl       #0x107c27c64 ; _objc_msgSend
0x105e42c48: mov      x29, x29
0x105e42c4c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42c50: str      x0, [sp, #0x160]
0x105e42c54: bl       #0x107c27c1c ; _objc_autoreleasePoolPush
0x105e42c58: mov      x19, x0
0x105e42c5c: movi     v0.16b, #0
0x105e42c60: stp      q0, q0, [sp, #0x2a0]
0x105e42c64: stp      q0, q0, [sp, #0x2c0]
0x105e42c68: mov      x0, x21
0x105e42c6c: bl       #0x107c27c74 ; _objc_retain
0x105e42c70: add      x2, sp, #0x2a0
0x105e42c74: add      x3, sp, #0x4a0
0x105e42c78: ldr      x1, [sp, #0xc8]
0x105e42c7c: mov      w4, #0x10
0x105e42c80: bl       #0x107c27c64 ; _objc_msgSend
0x105e42c84: str      x0, [sp, #0x1e0]
0x105e42c88: cbz      x0, #0x105e43304
0x105e42c8c: str      x19, [sp, #0x90]
0x105e42c90: str      xzr, [sp, #0x118]
0x105e42c94: str      xzr, [sp, #0x158]
0x105e42c98: ldr      x8, [sp, #0x2b0]
0x105e42c9c: ldr      x8, [x8]
0x105e42ca0: str      x8, [sp, #0x198]
0x105e42ca4: mov      x25, #0
0x105e42ca8: adrp     x8, #0x11e9ed000 ; @selector(setDigestFinderLiveInfoFromAff:)
0x105e42cac: ldr      x28, [x8, #0xa18] ; @selector(wrapMsg) | 'wrapMsg'
0x105e42cb0: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e42cb4: ldr      x9, [x8, #0xc68] ; @selector(chatName) | 'chatName'
0x105e42cb8: adrp     x8, #0x11eb2c000 ; @selector(presentedFullScreenNav)
0x105e42cbc: ldr      x8, [x8, #0x578] ; @selector(uiDes) | 'uiDes'
0x105e42cc0: stp      x8, x9, [sp, #0x1d0] ; 'uiDes'
0x105e42cc4: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42cc8: ldr      x24, [x8, #0x820] ; @selector(isInsertNew) | 'isInsertNew'
0x105e42ccc: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105e42cd0: ldr      x26, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105e42cd4: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42cd8: ldr      x8, [x8, #0x7e8] ; @selector(isCanAddDB) | 'isCanAddDB'
0x105e42cdc: str      x8, [sp, #0x1b8] ; 'isCanAddDB'
0x105e42ce0: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42ce4: ldr      x9, [x8, #0x860] ; @selector(checkForSecSystemMsg:) | 'checkForSecSystemMsg:'
0x105e42ce8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42cec: ldr      x8, [x8, #0x868] ; @selector(isNeedChangeDisplay) | 'isNeedChangeDisplay'
0x105e42cf0: stp      x8, x9, [sp, #0x168] ; 'isNeedChangeDisplay'
0x105e42cf4: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e42cf8: ldr      x8, [x8, #0xd10] ; @selector(ChangeForDisplay) | 'ChangeForDisplay'
0x105e42cfc: str      x8, [sp, #0x130] ; 'ChangeForDisplay'
0x105e42d00: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d04: ldr      x8, [x8, #0x7f0] ; @selector(addMsgType) | 'addMsgType'
0x105e42d08: str      x8, [sp, #0x188] ; 'addMsgType'
0x105e42d0c: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e42d10: ldr      x8, [x8, #0xbd8] ; @selector(IsFileMsg) | 'IsFileMsg'
0x105e42d14: str      x8, [sp, #0xf8] ; 'IsFileMsg'
0x105e42d18: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d1c: ldr      x9, [x8, #0x878] ; @selector(onMsgClearOnBatchAdd:dataId:) | 'onMsgClearOnBatchAdd:dataId:'
0x105e42d20: adrp     x8, #0x11e9d1000 ; @selector(scanItem)
0x105e42d24: ldr      x8, [x8, #0x28] ; @selector(realChatName) | 'realChatName'
0x105e42d28: str      x8, [sp, #0xe8] ; 'realChatName'
0x105e42d2c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d30: ldr      x8, [x8, #0x880] ; @selector(ProcessOnAddNewMsg:ChatName:Lock:) | 'ProcessOnAddNewMsg:ChatName:Lock:'
0x105e42d34: stp      x9, x8, [sp, #0xd8] ; 'onMsgClearOnBatchAdd:dataId:'
0x105e42d38: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x105e42d3c: ldr      x8, [x8, #0xe10] ; @selector(IsImgMsg) | 'IsImgMsg'
0x105e42d40: str      x8, [sp, #0x120] ; 'IsImgMsg'
0x105e42d44: adrp     x8, #0x11eb2c000 ; @selector(presentedFullScreenNav)
0x105e42d48: ldr      x8, [x8, #0x5a8] ; @selector(isNotify) | 'isNotify'
0x105e42d4c: str      x8, [sp, #0x1b0] ; 'isNotify'
0x105e42d50: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d54: ldr      x8, [x8, #0x888] ; @selector(clusterType) | 'clusterType'
0x105e42d58: str      x8, [sp, #0xd0] ; 'clusterType'
0x105e42d5c: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105e42d60: ldr      x8, [x8, #0xa68] ; @selector(setM_nsFromUsr:) | 'setM_nsFromUsr:'
0x105e42d64: str      x8, [sp, #0xb8] ; 'setM_nsFromUsr:'
0x105e42d68: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105e42d6c: ldr      x8, [x8, #0xb88] ; @selector(setChatName:) | 'setChatName:'
0x105e42d70: str      x8, [sp, #0xa8] ; 'setChatName:'
0x105e42d74: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d78: ldr      x8, [x8, #0x870] ; @selector(IsShowPush:Des:Msg:) | 'IsShowPush:Des:Msg:'
0x105e42d7c: str      x8, [sp, #0x190] ; 'IsShowPush:Des:Msg:'
0x105e42d80: adrp     x8, #0x11eb0a000 ; @selector(playWithMusicInfo:updateSessionId:)
0x105e42d84: ldr      x9, [x8, #0xb00] ; @selector(m_bNew) | 'm_bNew'
0x105e42d88: adrp     x8, #0x11e9c9000
0x105e42d8c: ldr      x10, [x8, #0x350] ; @selector(safeSetObject:forKey:) | 'safeSetObject:forKey:'
0x105e42d90: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e42d94: ldr      x8, [x8, #0x890] ; @selector(IsNotifyOnNotAddDB:ChatName:) | 'IsNotifyOnNotAddDB:ChatName:'
0x105e42d98: stp      x8, x9, [sp, #0x138] ; 'IsNotifyOnNotAddDB:ChatName:'
0x105e42d9c: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x105e42da0: ldr      x8, [x8, #0x3f0] ; @selector(m_uiMessageType) | 'm_uiMessageType'
0x105e42da4: stp      x8, x10, [sp, #0x178] ; 'm_uiMessageType'
0x105e42da8: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105e42dac: ldr      x8, [x8, #0x970] ; @selector(m_uiStatus) | 'm_uiStatus'
0x105e42db0: str      x8, [sp, #0x110] ; 'm_uiStatus'
0x105e42db4: ldr      x8, [sp, #0x2b0]
0x105e42db8: ldr      x8, [x8]
0x105e42dbc: ldr      x9, [sp, #0x198]
0x105e42dc0: cmp      x8, x9
0x105e42dc4: b.eq     #0x105e42dd0
0x105e42dc8: ldr      x0, [sp, #0x1c0]
0x105e42dcc: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105e42dd0: ldr      x8, [sp, #0x2a8]
0x105e42dd4: ldr      x20, [x8, x25, lsl #3]
0x105e42dd8: mov      x0, x20
0x105e42ddc: mov      x1, x28 ; 'wrapMsg'
0x105e42de0: bl       #0x107c27c64 ; _objc_msgSend | selector=wrapMsg
0x105e42de4: mov      x29, x29
0x105e42de8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42dec: mov      x21, x0
0x105e42df0: mov      x0, x20
0x105e42df4: ldr      x1, [sp, #0x1d8]
0x105e42df8: bl       #0x107c27c64 ; _objc_msgSend
0x105e42dfc: mov      x29, x29
0x105e42e00: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42e04: mov      x19, x0
0x105e42e08: mov      x0, x20
0x105e42e0c: ldr      x1, [sp, #0x1d0]
0x105e42e10: bl       #0x107c27c64 ; _objc_msgSend
0x105e42e14: mov      x22, x0
0x105e42e18: mov      x0, x20
0x105e42e1c: mov      x1, x24 ; 'isInsertNew'
0x105e42e20: bl       #0x107c27c64 ; _objc_msgSend | selector=isInsertNew
0x105e42e24: cbz      w0, #0x105e42e38
0x105e42e28: ldr      x0, [sp, #0x160]
0x105e42e2c: mov      x1, x26 ; 'safeAddObject:'
0x105e42e30: mov      x2, x21
0x105e42e34: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e42e38: mov      x0, x20
0x105e42e3c: ldr      x1, [sp, #0x1b8]
0x105e42e40: bl       #0x107c27c64 ; _objc_msgSend
0x105e42e44: cbz      w0, #0x105e43020
0x105e42e48: ldr      x0, [sp, #0x1c8]
0x105e42e4c: ldr      x1, [sp, #0x170]
0x105e42e50: mov      x2, x21
0x105e42e54: bl       #0x107c27c64 ; _objc_msgSend
0x105e42e58: mov      x0, x20
0x105e42e5c: ldr      x1, [sp, #0x168]
0x105e42e60: bl       #0x107c27c64 ; _objc_msgSend
0x105e42e64: cbz      w0, #0x105e42ea0
0x105e42e68: add      x0, sp, #0x270
0x105e42e6c: adrp     x1, #0x11a2e0000 ; 'tice?language='
0x105e42e70: add      x1, x1, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e42e74: adrp     x2, #0x119d86000 ; '}'
0x105e42e78: add      x2, x2, #0x122 ; 'change'
0x105e42e7c: mov      x3, #0
0x105e42e80: bl       #0x107c0cbd4
0x105e42e84: mov      x0, x21
0x105e42e88: ldr      x1, [sp, #0x130]
0x105e42e8c: bl       #0x107c27c64 ; _objc_msgSend
0x105e42e90: add      x0, sp, #0x270
0x105e42e94: bl       #0x107c0cbd8
0x105e42e98: add      x0, sp, #0x270
0x105e42e9c: bl       #0x107c0cbdc
0x105e42ea0: mov      x0, x20
0x105e42ea4: ldr      x1, [sp, #0x188]
0x105e42ea8: bl       #0x107c27c64 ; _objc_msgSend
0x105e42eac: sub      x8, x0, #2
0x105e42eb0: cmp      x8, #2
0x105e42eb4: b.hs     #0x105e4300c
0x105e42eb8: mov      x0, x20
0x105e42ebc: mov      x1, x24 ; 'isInsertNew'
0x105e42ec0: bl       #0x107c27c64 ; _objc_msgSend | selector=isInsertNew
0x105e42ec4: cbz      w0, #0x105e42f50
0x105e42ec8: mov      x0, x21
0x105e42ecc: ldr      x1, [sp, #0xf8]
0x105e42ed0: bl       #0x107c27c64 ; _objc_msgSend
0x105e42ed4: cbz      w0, #0x105e42ef4
0x105e42ed8: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105e42edc: ldr      x0, [x8, #0x6c0] ; classref MsgFileMonitor | Class MsgFileMonitor
0x105e42ee0: ldr      x1, [sp, #0xd8]
0x105e42ee4: mov      x2, x21
0x105e42ee8: adrp     x3, #0x11cf9b000
0x105e42eec: add      x3, x3, #0xe58 ; @''
0x105e42ef0: bl       #0x107c27c64 ; _objc_msgSend
0x105e42ef4: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e42ef8: ldr      x27, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e42efc: mov      x0, x20
0x105e42f00: ldr      x1, [sp, #0xe8]
0x105e42f04: bl       #0x107c27c64 ; _objc_msgSend
0x105e42f08: mov      x29, x29
0x105e42f0c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42f10: mov      x23, x0
0x105e42f14: adrp     x8, #0x11edd4000
0x105e42f18: ldrsw    x8, [x8, #0x614] ; ivar_offset SyncCmdHandler.m_oLock=0x40
0x105e42f1c: ldr      x9, [sp, #0x1e8]
0x105e42f20: ldr      x4, [x9, x8]
0x105e42f24: mov      x0, x27 ; Class MsgHelper
0x105e42f28: ldr      x1, [sp, #0xe0]
0x105e42f2c: mov      x2, x21
0x105e42f30: mov      x3, x23
0x105e42f34: bl       #0x107c27c64 ; _objc_msgSend
0x105e42f38: mov      x27, x0
0x105e42f3c: mov      x0, x23
0x105e42f40: bl       #0x107c27c70 ; _objc_release
0x105e42f44: ldr      x8, [sp, #0x118]
0x105e42f48: add      w8, w8, w27
0x105e42f4c: str      x8, [sp, #0x118]
0x105e42f50: mov      x0, x20
0x105e42f54: mov      x1, x28 ; 'wrapMsg'
0x105e42f58: bl       #0x107c27c64 ; _objc_msgSend | selector=wrapMsg
0x105e42f5c: mov      x29, x29
0x105e42f60: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42f64: mov      x23, x0
0x105e42f68: ldr      x1, [sp, #0x120]
0x105e42f6c: bl       #0x107c27c64 ; _objc_msgSend
0x105e42f70: mov      x27, x0
0x105e42f74: mov      x0, x23
0x105e42f78: bl       #0x107c27c70 ; _objc_release
0x105e42f7c: ldr      x8, [sp, #0x158]
0x105e42f80: add      w8, w8, w27
0x105e42f84: str      x8, [sp, #0x158]
0x105e42f88: mov      x0, x20
0x105e42f8c: ldr      x1, [sp, #0x188]
0x105e42f90: bl       #0x107c27c64 ; _objc_msgSend
0x105e42f94: cmp      x0, #3
0x105e42f98: b.ne     #0x105e43018
0x105e42f9c: mov      x0, x20
0x105e42fa0: ldr      x1, [sp, #0x1b0]
0x105e42fa4: bl       #0x107c27c64 ; _objc_msgSend
0x105e42fa8: ldr      x27, [sp, #0x1e8]
0x105e42fac: cbz      w0, #0x105e43004
0x105e42fb0: mov      x0, x20
0x105e42fb4: ldr      x1, [sp, #0xd0]
0x105e42fb8: bl       #0x107c27c64 ; _objc_msgSend
0x105e42fbc: mov      x29, x29
0x105e42fc0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e42fc4: mov      x23, x0
0x105e42fc8: mov      x0, x21
0x105e42fcc: ldr      x1, [sp, #0xb8]
0x105e42fd0: mov      x2, x23
0x105e42fd4: bl       #0x107c27c64 ; _objc_msgSend
0x105e42fd8: mov      x0, x23
0x105e42fdc: bl       #0x107c27c74 ; _objc_retain
0x105e42fe0: mov      x0, x19
0x105e42fe4: bl       #0x107c27c70 ; _objc_release
0x105e42fe8: mov      x0, x20
0x105e42fec: ldr      x1, [sp, #0xa8]
0x105e42ff0: mov      x2, x23
0x105e42ff4: bl       #0x107c27c64 ; _objc_msgSend
0x105e42ff8: mov      x0, x23
0x105e42ffc: bl       #0x107c27c70 ; _objc_release
0x105e43000: mov      x19, x23
0x105e43004: ldr      x23, [sp, #0xc0]
0x105e43008: b        #0x105e43020
0x105e4300c: cmp      x0, #1
0x105e43010: b.ne     #0x105e43020
0x105e43014: b        #0x105e43094
0x105e43018: ldr      x23, [sp, #0xc0]
0x105e4301c: ldr      x27, [sp, #0x1e8]
0x105e43020: mov      x0, x20
0x105e43024: ldr      x1, [sp, #0x1b0]
0x105e43028: bl       #0x107c27c64 ; _objc_msgSend
0x105e4302c: cbz      w0, #0x105e430b8
0x105e43030: mov      x0, x23
0x105e43034: ldr      x1, [sp, #0x180]
0x105e43038: mov      x2, x21
0x105e4303c: mov      x3, x19
0x105e43040: bl       #0x107c27c64 ; _objc_msgSend
0x105e43044: cmp      w22, #1
0x105e43048: b.ne     #0x105e43084
0x105e4304c: mov      x0, x21
0x105e43050: ldr      x1, [sp, #0x110]
0x105e43054: bl       #0x107c27c64 ; _objc_msgSend
0x105e43058: cmp      w0, #3
0x105e4305c: b.ne     #0x105e43084
0x105e43060: mov      x0, x21
0x105e43064: ldr      x1, [sp, #0x178]
0x105e43068: bl       #0x107c27c64 ; _objc_msgSend
0x105e4306c: cmp      w0, #0x22
0x105e43070: b.eq     #0x105e43084
0x105e43074: ldr      x0, [sp, #0x40]
0x105e43078: mov      x1, x26 ; 'safeAddObject:'
0x105e4307c: mov      x2, x19
0x105e43080: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e43084: ldr      x0, [sp, #0x108]
0x105e43088: mov      x1, x26 ; 'safeAddObject:'
0x105e4308c: mov      x2, x21
0x105e43090: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e43094: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e43098: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e4309c: ldr      x1, [sp, #0x190]
0x105e430a0: ldr      w2, [sp, #0x154]
0x105e430a4: mov      x3, x22
0x105e430a8: mov      x4, x21
0x105e430ac: bl       #0x107c27c64 ; _objc_msgSend
0x105e430b0: tbnz     w0, #0, #0x105e4313c
0x105e430b4: b        #0x105e4314c
0x105e430b8: mov      x0, x21
0x105e430bc: ldr      x1, [sp, #0x140]
0x105e430c0: bl       #0x107c27c64 ; _objc_msgSend
0x105e430c4: tbnz     w0, #0, #0x105e430dc
0x105e430c8: mov      x0, x23
0x105e430cc: ldr      x1, [sp, #0x180]
0x105e430d0: mov      x2, x21
0x105e430d4: mov      x3, x19
0x105e430d8: bl       #0x107c27c64 ; _objc_msgSend
0x105e430dc: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e430e0: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e430e4: ldr      x1, [sp, #0x138]
0x105e430e8: mov      x2, x21
0x105e430ec: mov      x3, x19
0x105e430f0: bl       #0x107c27c64 ; _objc_msgSend
0x105e430f4: cbz      w0, #0x105e43108
0x105e430f8: ldr      x0, [sp, #0xb0]
0x105e430fc: mov      x1, x26 ; 'safeAddObject:'
0x105e43100: mov      x2, x21
0x105e43104: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e43108: mov      x0, x21
0x105e4310c: ldr      x1, [sp, #0x178]
0x105e43110: bl       #0x107c27c64 ; _objc_msgSend
0x105e43114: cmp      w0, #0x2f
0x105e43118: b.ne     #0x105e4314c
0x105e4311c: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e43120: ldr      x0, [x8, #0xdb8] ; classref MsgHelper | Class MsgHelper
0x105e43124: ldr      x1, [sp, #0x190]
0x105e43128: ldr      w2, [sp, #0x154]
0x105e4312c: mov      x3, x22
0x105e43130: mov      x4, x21
0x105e43134: bl       #0x107c27c64 ; _objc_msgSend
0x105e43138: cbz      w0, #0x105e4314c
0x105e4313c: ldr      x0, [sp, #0x100]
0x105e43140: mov      x1, x26 ; 'safeAddObject:'
0x105e43144: mov      x2, x21
0x105e43148: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105e4314c: mov      x0, x19
0x105e43150: bl       #0x107c27c70 ; _objc_release
0x105e43154: mov      x0, x21
0x105e43158: bl       #0x107c27c70 ; _objc_release
0x105e4315c: add      x25, x25, #1
0x105e43160: ldr      x8, [sp, #0x1e0]
0x105e43164: cmp      x8, x25
0x105e43168: b.ne     #0x105e42db4
0x105e4316c: add      x2, sp, #0x2a0
0x105e43170: add      x3, sp, #0x4a0
0x105e43174: ldr      x21, [sp, #0x1c0]
0x105e43178: mov      x0, x21
0x105e4317c: ldr      x1, [sp, #0xc8]
0x105e43180: mov      w4, #0x10
0x105e43184: bl       #0x107c27c64 ; _objc_msgSend
0x105e43188: str      x0, [sp, #0x1e0]
0x105e4318c: cbnz     x0, #0x105e42ca4
0x105e43190: mov      x0, x21
0x105e43194: bl       #0x107c27c70 ; _objc_release
0x105e43198: ldr      x20, [sp, #0x158]
0x105e4319c: cmp      w20, #5
0x105e431a0: ldr      x25, [sp, #0x128]
0x105e431a4: adrp     x28, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e431a8: ldr      x28, [x28, #0x930] ; __NSConcreteStackBlock
0x105e431ac: ldr      x19, [sp, #0x90]
0x105e431b0: ldr      x22, [sp, #0x118]
0x105e431b4: b.le     #0x105e431c0
0x105e431b8: cmp      w22, #5
0x105e431bc: b.lt     #0x105e431d0
0x105e431c0: cmp      w20, #5
0x105e431c4: b.ge     #0x105e4330c
0x105e431c8: cmp      w22, w20
0x105e431cc: b.eq     #0x105e4330c
0x105e431d0: mov      w0, #0x90
0x105e431d4: mov      w1, #0x12
0x105e431d8: mov      w2, #1
0x105e431dc: mov      w3, #0
0x105e431e0: mov      w4, #0
0x105e431e4: bl       #0x1020ea20c
0x105e431e8: adrp     x8, #0x11ed12000
0x105e431ec: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e431f0: adrp     x8, #0x11e9c9000
0x105e431f4: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e431f8: stp      x20, x22, [sp, #8]
0x105e431fc: adrp     x8, #0x11d353000
0x105e43200: add      x8, x8, #0xb38 ; @'thumb num error: img num %d, thumb num %d'
0x105e43204: str      x8, [sp] ; @'thumb num error: img num %d, thumb num %d'
0x105e43208: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e4320c: add      x3, x3, #0xfaf ; 'Sync'
0x105e43210: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e43214: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e43218: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e4321c: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e43220: mov      w2, #2
0x105e43224: mov      w4, #0
0x105e43228: mov      w6, #0x35a
0x105e4322c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e43230: b        #0x105e4330c
0x105e43234: adrp     x8, #0x11ed12000
0x105e43238: ldr      x20, [x8, #0x618] ; classref iConsole | Class iConsole
0x105e4323c: adrp     x8, #0x11e9ed000 ; @selector(setDigestFinderLiveInfoFromAff:)
0x105e43240: ldr      x1, [x8, #0xa18] ; @selector(wrapMsg) | 'wrapMsg'
0x105e43244: mov      x0, x22
0x105e43248: bl       #0x107c27c64 ; _objc_msgSend | selector=wrapMsg
0x105e4324c: mov      x29, x29
0x105e43250: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e43254: mov      x22, x0
0x105e43258: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105e4325c: ldr      x1, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x105e43260: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105e43264: adrp     x8, #0x11e9c9000
0x105e43268: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105e4326c: stp      x0, x21, [sp, #8]
0x105e43270: adrp     x8, #0x11d353000
0x105e43274: add      x8, x8, #0xa58 ; @'nil db path name for msg svrid:%lld, chatName %@'
0x105e43278: str      x8, [sp] ; @'nil db path name for msg svrid:%lld, chatName %@'
0x105e4327c: adrp     x3, #0x119cf5000 ; 'ns_filled_pause2'
0x105e43280: add      x3, x3, #0xfaf ; 'Sync'
0x105e43284: adrp     x5, #0x11a2e0000 ; 'tice?language='
0x105e43288: add      x5, x5, #0x21 ; 'SyncCmdHandler.mm'
0x105e4328c: adrp     x7, #0x11a2e0000 ; 'tice?language='
0x105e43290: add      x7, x7, #0x3eb ; '-[SyncCmdHandler BatchAddMsg:ShowPush:]'
0x105e43294: mov      x0, x20 ; Class iConsole
0x105e43298: mov      w2, #4
0x105e4329c: mov      w4, #0
0x105e432a0: mov      w6, #0x253
0x105e432a4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105e432a8: mov      x0, x22
0x105e432ac: bl       #0x107c27c70 ; _objc_release
0x105e432b0: mov      x0, x28
0x105e432b4: bl       #0x107c27c70 ; _objc_release
0x105e432b8: ldr      x25, [sp, #0x128]
0x105e432bc: mov      x0, x27
0x105e432c0: bl       #0x107c27c70 ; _objc_release
0x105e432c4: mov      x0, x21
0x105e432c8: bl       #0x107c27c70 ; _objc_release
0x105e432cc: ldr      x21, [sp, #0x1c0]
0x105e432d0: mov      x0, x21
0x105e432d4: bl       #0x107c27c70 ; _objc_release
0x105e432d8: ldr      x0, [sp, #0x180]
0x105e432dc: bl       #0x107c27c70 ; _objc_release
0x105e432e0: ldr      x0, [sp, #0x1e0]
0x105e432e4: bl       #0x107c27c70 ; _objc_release
0x105e432e8: ldr      x0, [sp, #0x158]
0x105e432ec: bl       #0x107c27c18 ; _objc_autoreleasePoolPop
0x105e432f0: ldr      x23, [sp, #0xc0]
0x105e432f4: ldr      x0, [sp, #0x1c8]
0x105e432f8: bl       #0x107c27c70 ; _objc_release
0x105e432fc: mov      w19, #0
0x105e43300: b        #0x105e434e4
0x105e43304: mov      x0, x21
0x105e43308: bl       #0x107c27c70 ; _objc_release
0x105e4330c: mov      x0, x19
0x105e43310: bl       #0x107c27c18 ; _objc_autoreleasePoolPop
0x105e43314: mov      x0, x21
0x105e43318: bl       #0x107c27c70 ; _objc_release
0x105e4331c: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e43320: ldr      x1, [x8, #0x898] ; @selector(setArrNewInsertMsg:) | 'setArrNewInsertMsg:'
0x105e43324: mov      x0, x27
0x105e43328: ldr      x19, [sp, #0x160]
0x105e4332c: mov      x2, x19
0x105e43330: bl       #0x107c27c64 ; _objc_msgSend | selector=setArrNewInsertMsg:
0x105e43334: mov      x0, x19
0x105e43338: bl       #0x107c27c70 ; _objc_release
0x105e4333c: ldr      x0, [sp, #0x1c8]
0x105e43340: bl       #0x107c27c70 ; _objc_release
0x105e43344: adrp     x8, #0x11ed12000
0x105e43348: ldr      x0, [x8, #0x658] ; _OBJC_CLASS_$_NSMutableArray
0x105e4334c: ldr      x1, [sp, #0x38]
0x105e43350: bl       #0x107c27c64 ; _objc_msgSend
0x105e43354: mov      x29, x29
0x105e43358: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e4335c: mov      x21, x0
0x105e43360: adrp     x8, #0x11ed12000
0x105e43364: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105e43368: ldr      x1, [sp, #0x1a0]
0x105e4336c: bl       #0x107c27c64 ; _objc_msgSend
0x105e43370: mov      x29, x29
0x105e43374: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e43378: mov      x19, x0
0x105e4337c: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105e43380: ldr      x0, [x8, #0x160] ; classref EnterpriseMsgMgr | Class EnterpriseMsgMgr
0x105e43384: ldr      x1, [sp, #0xa0]
0x105e43388: bl       #0x107c27c64 ; _objc_msgSend
0x105e4338c: mov      x2, x0
0x105e43390: mov      x0, x19
0x105e43394: ldr      x1, [sp, #0x98]
0x105e43398: bl       #0x107c27c64 ; _objc_msgSend
0x105e4339c: mov      x29, x29
0x105e433a0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105e433a4: mov      x20, x0
0x105e433a8: adrp     x8, #0x11eb5b000 ; @selector(reportFullScreenLongClickTime:)
0x105e433ac: ldr      x1, [x8, #0x8a0] ; @selector(BatchAddEnterpriseMsgList:NotifyArrayMessage:) | 'BatchAddEnterpriseMsgList:NotifyArrayMessage:'
0x105e433b0: mov      x2, x25
0x105e433b4: mov      x3, x21
0x105e433b8: bl       #0x107c27c64 ; _objc_msgSend | selector=BatchAddEnterpriseMsgList:NotifyArrayMessage:
0x105e433bc: mov      x0, x20
0x105e433c0: bl       #0x107c27c70 ; _objc_release
0x105e433c4: mov      x0, x19
0x105e433c8: bl       #0x107c27c70 ; _objc_release
0x105e433cc: str      x28, [sp, #0x1f0]
0x105e433d0: adrp     x8, #0x1178c7000
0x105e433d4: ldr      d0, [x8, #0x680]
0x105e433d8: str      d0, [sp, #0x1f8]
0x105e433dc: adrp     x8, #0x105e44000
0x105e433e0: add      x8, x8, #0x154
0x105e433e4: adrp     x9, #0x11c309000
0x105e433e8: add      x9, x9, #0x5e8
0x105e433ec: str      x8, [sp, #0x200]
0x105e433f0: str      x9, [sp, #0x208]
0x105e433f4: ldr      x0, [sp, #0x100]
0x105e433f8: bl       #0x107c27c74 ; _objc_retain
0x105e433fc: str      x0, [sp, #0x210]
0x105e43400: ldr      x0, [sp, #0x108]
0x105e43404: bl       #0x107c27c74 ; _objc_retain
0x105e43408: str      x0, [sp, #0x218]
0x105e4340c: ldr      x0, [sp, #0xf0]
0x105e43410: bl       #0x107c27c74 ; _objc_retain
0x105e43414: str      x0, [sp, #0x220]
0x105e43418: str      x27, [sp, #0x228]
0x105e4341c: mov      x0, x23
0x105e43420: bl       #0x107c27c74 ; _objc_retain
0x105e43424: str      x23, [sp, #0x230]
0x105e43428: ldr      x0, [sp, #0x40]
0x105e4342c: bl       #0x107c27c74 ; _objc_retain
0x105e43430: str      x0, [sp, #0x238]
0x105e43434: ldr      x0, [sp, #0xb0]
0x105e43438: bl       #0x107c27c74 ; _objc_retain
0x105e4343c: str      x0, [sp, #0x240]
0x105e43440: ldr      x0, [sp, #0x1a8]
0x105e43444: bl       #0x107c27c74 ; _objc_retain
0x105e43448: str      x0, [sp, #0x248]
0x105e4344c: ldr      x0, [sp, #0x68]
0x105e43450: bl       #0x107c27c74 ; _objc_retain
0x105e43454: str      x0, [sp, #0x250]
0x105e43458: ldr      x0, [sp, #0x60]
0x105e4345c: bl       #0x107c27c74 ; _objc_retain
0x105e43460: ldr      w8, [sp, #0x154]
0x105e43464: strb     w8, [sp, #0x268]
0x105e43468: ldr      w8, [sp, #0x2c]
0x105e4346c: strb     w8, [sp, #0x269]
0x105e43470: str      x0, [sp, #0x258]
0x105e43474: str      x21, [sp, #0x260]
0x105e43478: mov      x0, x21
0x105e4347c: bl       #0x107c27c74 ; _objc_retain
0x105e43480: adrp     x0, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e43484: ldr      x0, [x0, #0xa98] ; __dispatch_main_q
0x105e43488: add      x1, sp, #0x1f0
0x105e4348c: bl       #0x107c0cb9c
0x105e43490: ldr      x0, [sp, #0x260]
0x105e43494: bl       #0x107c27c70 ; _objc_release
0x105e43498: ldr      x0, [sp, #0x258]
0x105e4349c: bl       #0x107c27c70 ; _objc_release
0x105e434a0: ldr      x0, [sp, #0x250]
0x105e434a4: bl       #0x107c27c70 ; _objc_release
0x105e434a8: ldr      x0, [sp, #0x248]
0x105e434ac: bl       #0x107c27c70 ; _objc_release
0x105e434b0: ldr      x0, [sp, #0x240]
0x105e434b4: bl       #0x107c27c70 ; _objc_release
0x105e434b8: ldr      x0, [sp, #0x238]
0x105e434bc: bl       #0x107c27c70 ; _objc_release
0x105e434c0: ldr      x0, [sp, #0x230]
0x105e434c4: bl       #0x107c27c70 ; _objc_release
0x105e434c8: ldr      x0, [sp, #0x220]
0x105e434cc: bl       #0x107c27c70 ; _objc_release
0x105e434d0: ldr      x0, [sp, #0x218]
0x105e434d4: bl       #0x107c27c70 ; _objc_release
0x105e434d8: ldr      x0, [sp, #0x210]
0x105e434dc: bl       #0x107c27c70 ; _objc_release
0x105e434e0: mov      w19, #1
0x105e434e4: mov      x0, x21
0x105e434e8: bl       #0x107c27c70 ; _objc_release
0x105e434ec: ldr      x0, [sp, #0x148]
0x105e434f0: bl       #0x107c27c70 ; _objc_release
0x105e434f4: ldr      x0, [sp, #0x60]
0x105e434f8: bl       #0x107c27c70 ; _objc_release
0x105e434fc: ldr      x0, [sp, #0x68]
0x105e43500: bl       #0x107c27c70 ; _objc_release
0x105e43504: mov      x0, x25
0x105e43508: bl       #0x107c27c70 ; _objc_release
0x105e4350c: ldr      x0, [sp, #0xf0]
0x105e43510: bl       #0x107c27c70 ; _objc_release
0x105e43514: ldr      x0, [sp, #0x1a8]
0x105e43518: bl       #0x107c27c70 ; _objc_release
0x105e4351c: ldr      x0, [sp, #0x100]
0x105e43520: bl       #0x107c27c70 ; _objc_release
0x105e43524: ldr      x0, [sp, #0x108]
0x105e43528: bl       #0x107c27c70 ; _objc_release
0x105e4352c: ldr      x0, [sp, #0xb0]
0x105e43530: bl       #0x107c27c70 ; _objc_release
0x105e43534: ldr      x0, [sp, #0x40]
0x105e43538: bl       #0x107c27c70 ; _objc_release
0x105e4353c: mov      x0, x23
0x105e43540: bl       #0x107c27c70 ; _objc_release
0x105e43544: ldur     x8, [x29, #-0x70]
0x105e43548: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105e4354c: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105e43550: ldr      x9, [x9]
0x105e43554: cmp      x9, x8
0x105e43558: b.ne     #0x105e43584
0x105e4355c: mov      x0, x19
0x105e43560: add      sp, sp, #0x7b0
0x105e43564: ldp      x29, x30, [sp, #0x60]
0x105e43568: ldp      x20, x19, [sp, #0x50]
0x105e4356c: ldp      x22, x21, [sp, #0x40]
0x105e43570: ldp      x24, x23, [sp, #0x30] ; 'isInsertNew'
0x105e43574: ldp      x26, x25, [sp, #0x20] ; 'safeAddObject:'
0x105e43578: ldp      x28, x27, [sp, #0x10]
0x105e4357c: ldp      d9, d8, [sp], #0x70
0x105e43580: ret      
0x105e43584: bl       #0x107c27730 ; ___stack_chk_fail
