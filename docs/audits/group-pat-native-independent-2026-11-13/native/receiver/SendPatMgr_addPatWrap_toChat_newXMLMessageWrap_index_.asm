-[SendPatMgr addPatWrap:toChat:newXMLMessageWrap:index:] 0x105a9a3e8 I48@0:8@16@24@32^Q40
0x105a9a3e8: sub      sp, sp, #0xc0
0x105a9a3ec: stp      x28, x27, [sp, #0x60]
0x105a9a3f0: stp      x26, x25, [sp, #0x70]
0x105a9a3f4: stp      x24, x23, [sp, #0x80]
0x105a9a3f8: stp      x22, x21, [sp, #0x90]
0x105a9a3fc: stp      x20, x19, [sp, #0xa0]
0x105a9a400: stp      x29, x30, [sp, #0xb0]
0x105a9a404: add      x29, sp, #0xb0
0x105a9a408: str      x5, [sp, #0x28]
0x105a9a40c: mov      x21, x4
0x105a9a410: mov      x20, x3
0x105a9a414: mov      x19, x2
0x105a9a418: mov      x24, x0
0x105a9a41c: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105a9a420: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105a9a424: ldr      x8, [x8]
0x105a9a428: str      x8, [sp, #0x58]
0x105a9a42c: adrp     x8, #0x11f754000
0x105a9a430: mov      w9, #1
0x105a9a434: strb     w9, [x8, #0xb97]
0x105a9a438: mov      x0, x2
0x105a9a43c: bl       #0x107c27c74 ; _objc_retain
0x105a9a440: mov      x0, x20
0x105a9a444: bl       #0x107c27c74 ; _objc_retain
0x105a9a448: mov      x0, x21
0x105a9a44c: bl       #0x107c27c74 ; _objc_retain
0x105a9a450: adrp     x28, #0x11ed12000
0x105a9a454: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x105a9a458: adrp     x8, #0x11e9c9000
0x105a9a45c: ldr      x27, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9a460: stp      x19, x20, [sp, #8]
0x105a9a464: adrp     x8, #0x11d332000
0x105a9a468: add      x8, x8, #0xdf8 ; @'pat wrap to be added: %@ from chat: %@'
0x105a9a46c: str      x8, [sp] ; @'pat wrap to be added: %@ from chat: %@'
0x105a9a470: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9a474: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9a478: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9a47c: add      x7, x7, #0x76c ; '-[SendPatMgr addPatWrap:toChat:newXMLMessageWrap:index:]'
0x105a9a480: mov      x1, x27 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9a484: mov      w2, #1
0x105a9a488: mov      x3, #0
0x105a9a48c: mov      w4, #0
0x105a9a490: mov      w6, #0x633
0x105a9a494: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a9a498: adrp     x8, #0x11ed12000
0x105a9a49c: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a9a4a0: adrp     x8, #0x11e9c9000
0x105a9a4a4: ldr      x1, [x8, #0x800] ; @selector(currentContext) | 'currentContext'
0x105a9a4a8: str      x1, [sp, #0x30] ; 'currentContext'
0x105a9a4ac: bl       #0x107c27c64 ; _objc_msgSend | selector=currentContext
0x105a9a4b0: mov      x29, x29
0x105a9a4b4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a4b8: mov      x22, x0
0x105a9a4bc: adrp     x8, #0x11ed12000
0x105a9a4c0: ldr      x0, [x8, #0xbf8] ; classref MMNewSessionMgr | Class MMNewSessionMgr
0x105a9a4c4: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a9a4c8: ldr      x1, [x8, #0x508] ; @selector(class) | 'class'
0x105a9a4cc: str      x1, [sp, #0x38] ; 'class'
0x105a9a4d0: bl       #0x107c27c64 ; _objc_msgSend | selector=class
0x105a9a4d4: mov      x2, x0
0x105a9a4d8: adrp     x8, #0x11e9c9000
0x105a9a4dc: ldr      x1, [x8, #0xa40] ; @selector(getService:) | 'getService:'
0x105a9a4e0: mov      x0, x22
0x105a9a4e4: str      x1, [sp, #0x40] ; 'getService:'
0x105a9a4e8: bl       #0x107c27c64 ; _objc_msgSend | selector=getService:
0x105a9a4ec: mov      x29, x29
0x105a9a4f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a4f4: mov      x23, x0
0x105a9a4f8: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105a9a4fc: ldr      x1, [x8, #0x5f0] ; @selector(GetSessionByUserName:) | 'GetSessionByUserName:'
0x105a9a500: mov      x2, x20
0x105a9a504: bl       #0x107c27c64 ; _objc_msgSend | selector=GetSessionByUserName:
0x105a9a508: mov      x29, x29
0x105a9a50c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a510: mov      x25, x0
0x105a9a514: mov      x0, x23
0x105a9a518: bl       #0x107c27c70 ; _objc_release
0x105a9a51c: mov      x0, x22
0x105a9a520: bl       #0x107c27c70 ; _objc_release
0x105a9a524: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x105a9a528: ldr      x1, [x8, #0x680] ; @selector(m_extendFields) | 'm_extendFields'
0x105a9a52c: str      x25, [sp, #0x48]
0x105a9a530: mov      x0, x25
0x105a9a534: bl       #0x107c27c64 ; _objc_msgSend | selector=m_extendFields
0x105a9a538: mov      x29, x29
0x105a9a53c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a540: mov      x23, x0
0x105a9a544: adrp     x8, #0x11e9da000 ; @selector(scrollableFinderCellViewOnValidShowItems:)
0x105a9a548: ldr      x1, [x8, #0x688] ; @selector(m_uLastNotifySeq) | 'm_uLastNotifySeq'
0x105a9a54c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uLastNotifySeq
0x105a9a550: mov      x22, x0
0x105a9a554: mov      x0, x23
0x105a9a558: bl       #0x107c27c70 ; _objc_release
0x105a9a55c: adrp     x8, #0x11ed12000
0x105a9a560: ldr      x0, [x8, #0xbc0] ; classref MMKernelUtil | Class MMKernelUtil
0x105a9a564: adrp     x8, #0x11e9cb000 ; @selector(setVideoErrCnt:)
0x105a9a568: ldr      x1, [x8, #0xec0] ; @selector(IsChatRoom:) | 'IsChatRoom:'
0x105a9a56c: mov      x2, x20
0x105a9a570: bl       #0x107c27c64 ; _objc_msgSend | selector=IsChatRoom:
0x105a9a574: eor      w23, w0, #1
0x105a9a578: adrp     x25, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9a57c: cbz      x21, #0x105a9a5b0
0x105a9a580: ldr      x1, [x25, #0xfd8] ; @selector(m_uiCreateTime) | 'm_uiCreateTime'
0x105a9a584: mov      x0, x21
0x105a9a588: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiCreateTime
0x105a9a58c: mov      x3, x0
0x105a9a590: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9a594: ldr      x1, [x8, #0xad0] ; @selector(getLastAppPatMessageWrapForChat:createTime:) | 'getLastAppPatMessageWrapForChat:createTime:'
0x105a9a598: mov      x0, x24
0x105a9a59c: mov      x2, x20
0x105a9a5a0: bl       #0x107c27c64 ; _objc_msgSend | selector=getLastAppPatMessageWrapForChat:createTime:
0x105a9a5a4: mov      x29, x29
0x105a9a5a8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a5ac: b        #0x105a9a5cc
0x105a9a5b0: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9a5b4: ldr      x1, [x8, #0xad8] ; @selector(getLastAppPatMessageWrapForChat:) | 'getLastAppPatMessageWrapForChat:'
0x105a9a5b8: mov      x0, x24
0x105a9a5bc: mov      x2, x20
0x105a9a5c0: bl       #0x107c27c64 ; _objc_msgSend | selector=getLastAppPatMessageWrapForChat:
0x105a9a5c4: mov      x29, x29
0x105a9a5c8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a5cc: mov      x26, x0
0x105a9a5d0: cmp      x0, #0
0x105a9a5d4: csinc    w8, w23, wzr, ne
0x105a9a5d8: cbnz     w22, #0x105a9a678
0x105a9a5dc: tbnz     w8, #0, #0x105a9a678
0x105a9a5e0: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9a5e4: ldr      x1, [x8, #0xc88] ; @selector(patMessageWrap) | 'patMessageWrap'
0x105a9a5e8: mov      x0, x26
0x105a9a5ec: bl       #0x107c27c64 ; _objc_msgSend | selector=patMessageWrap
0x105a9a5f0: mov      x29, x29
0x105a9a5f4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a5f8: mov      x22, x0
0x105a9a5fc: cbz      x0, #0x105a9a66c
0x105a9a600: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9a604: ldr      x25, [x8, #0xc90] ; @selector(patWraps) | 'patWraps'
0x105a9a608: mov      x0, x22
0x105a9a60c: mov      x1, x25 ; 'patWraps'
0x105a9a610: bl       #0x107c27c64 ; _objc_msgSend | selector=patWraps
0x105a9a614: mov      x29, x29
0x105a9a618: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a61c: mov      x23, x0
0x105a9a620: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a9a624: ldr      x1, [x8, #0x850] ; @selector(count) | 'count'
0x105a9a628: str      x1, [sp, #0x20] ; 'count'
0x105a9a62c: bl       #0x107c27c64 ; _objc_msgSend | selector=count
0x105a9a630: mov      x28, x27 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9a634: mov      x27, x26
0x105a9a638: mov      x26, x0
0x105a9a63c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9a640: ldr      x1, [x8, #0xae0] ; @selector(maxNumberOfContinousPats) | 'maxNumberOfContinousPats'
0x105a9a644: mov      x0, x24
0x105a9a648: bl       #0x107c27c64 ; _objc_msgSend | selector=maxNumberOfContinousPats
0x105a9a64c: mov      x24, x0
0x105a9a650: mov      x0, x23
0x105a9a654: bl       #0x107c27c70 ; _objc_release
0x105a9a658: cmp      x26, x24
0x105a9a65c: mov      x26, x27
0x105a9a660: mov      x27, x28 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9a664: adrp     x28, #0x11ed12000
0x105a9a668: b.ls     #0x105a9a8fc
0x105a9a66c: mov      x0, x22
0x105a9a670: bl       #0x107c27c70 ; _objc_release
0x105a9a674: adrp     x25, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9a678: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x105a9a67c: adrp     x8, #0x11d332000
0x105a9a680: add      x8, x8, #0xe38 ; @'create and add a new pat message'
0x105a9a684: str      x8, [sp] ; @'create and add a new pat message'
0x105a9a688: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9a68c: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9a690: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9a694: add      x7, x7, #0x76c ; '-[SendPatMgr addPatWrap:toChat:newXMLMessageWrap:index:]'
0x105a9a698: mov      x1, x27 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9a69c: mov      w2, #2
0x105a9a6a0: mov      x3, #0
0x105a9a6a4: mov      w4, #0
0x105a9a6a8: mov      w6, #0x65b
0x105a9a6ac: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a9a6b0: ldr      x8, [sp, #0x28]
0x105a9a6b4: cbz      x8, #0x105a9a6bc
0x105a9a6b8: str      xzr, [x8]
0x105a9a6bc: adrp     x8, #0x11ed1a000 ; _OBJC_CLASS_$_CXCallObserver
0x105a9a6c0: ldr      x0, [x8, #0xbf0] ; classref PatMessageWrap | Class PatMessageWrap
0x105a9a6c4: bl       #0x107c27c08 ; _objc_alloc
0x105a9a6c8: mov      x22, x0
0x105a9a6cc: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9a6d0: ldr      x1, [x8, #0xe18] ; @selector(setChatUserName:) | 'setChatUserName:'
0x105a9a6d4: mov      x2, x20
0x105a9a6d8: bl       #0x107c27c64 ; _objc_msgSend | selector=setChatUserName:
0x105a9a6dc: str      x19, [sp, #0x50]
0x105a9a6e0: adrp     x8, #0x11ed12000
0x105a9a6e4: ldr      x0, [x8, #0x688] ; _OBJC_CLASS_$_NSArray
0x105a9a6e8: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105a9a6ec: ldr      x1, [x8, #0xdc0] ; @selector(arrayWithObjects:count:) | 'arrayWithObjects:count:'
0x105a9a6f0: add      x2, sp, #0x50
0x105a9a6f4: mov      w3, #1
0x105a9a6f8: bl       #0x107c27c64 ; _objc_msgSend | selector=arrayWithObjects:count:
0x105a9a6fc: mov      x29, x29
0x105a9a700: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a704: mov      x23, x0
0x105a9a708: adrp     x8, #0x11eca9000 ; @selector(makeCallTree)
0x105a9a70c: ldr      x1, [x8, #0x318] ; @selector(mutableCopy) | 'mutableCopy'
0x105a9a710: bl       #0x107c27c64 ; _objc_msgSend | selector=mutableCopy
0x105a9a714: mov      x24, x0
0x105a9a718: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a9a71c: ldr      x1, [x8, #0x258] ; @selector(setPatWraps:) | 'setPatWraps:'
0x105a9a720: mov      x0, x22
0x105a9a724: mov      x2, x24
0x105a9a728: bl       #0x107c27c64 ; _objc_msgSend | selector=setPatWraps:
0x105a9a72c: mov      x0, x24
0x105a9a730: bl       #0x107c27c70 ; _objc_release
0x105a9a734: mov      x0, x23
0x105a9a738: bl       #0x107c27c70 ; _objc_release
0x105a9a73c: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a9a740: ldr      x1, [x8, #0x260] ; @selector(setPatCount:) | 'setPatCount:'
0x105a9a744: mov      x0, x22
0x105a9a748: mov      w2, #1
0x105a9a74c: bl       #0x107c27c64 ; _objc_msgSend | selector=setPatCount:
0x105a9a750: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105a9a754: ldr      x0, [x8, #0x968] ; classref SendPatMgr | Class SendPatMgr
0x105a9a758: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a9a75c: ldr      x1, [x8, #0x268] ; @selector(generatePatMessageFromWrap:) | 'generatePatMessageFromWrap:'
0x105a9a760: mov      x2, x22
0x105a9a764: bl       #0x107c27c64 ; _objc_msgSend | selector=generatePatMessageFromWrap:
0x105a9a768: mov      x29, x29
0x105a9a76c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a770: mov      x24, x0
0x105a9a774: cbz      x21, #0x105a9a798
0x105a9a778: ldr      x1, [x25, #0xfd8] ; @selector(m_uiCreateTime) | 'm_uiCreateTime'
0x105a9a77c: mov      x0, x21
0x105a9a780: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiCreateTime
0x105a9a784: mov      x2, x0
0x105a9a788: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9a78c: ldr      x1, [x8, #0xa98] ; @selector(setM_uiCreateTime:) | 'setM_uiCreateTime:'
0x105a9a790: mov      x0, x24
0x105a9a794: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_uiCreateTime:
0x105a9a798: mov      x27, x26
0x105a9a79c: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a9a7a0: ldr      x25, [x8, #0xfc8] ; @selector(serverId) | 'serverId'
0x105a9a7a4: mov      x0, x19
0x105a9a7a8: mov      x1, x25 ; 'serverId'
0x105a9a7ac: bl       #0x107c27c64 ; _objc_msgSend | selector=serverId
0x105a9a7b0: cbz      x0, #0x105a9a7d4
0x105a9a7b4: mov      x0, x19
0x105a9a7b8: mov      x1, x25 ; 'serverId'
0x105a9a7bc: bl       #0x107c27c64 ; _objc_msgSend | selector=serverId
0x105a9a7c0: mov      x2, x0
0x105a9a7c4: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9a7c8: ldr      x1, [x8, #0x798] ; @selector(setM_n64MesSvrID:) | 'setM_n64MesSvrID:'
0x105a9a7cc: mov      x0, x24
0x105a9a7d0: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_n64MesSvrID:
0x105a9a7d4: adrp     x8, #0x11ed12000
0x105a9a7d8: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a9a7dc: ldr      x1, [sp, #0x30]
0x105a9a7e0: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a7e4: mov      x29, x29
0x105a9a7e8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a7ec: mov      x23, x0
0x105a9a7f0: adrp     x8, #0x11ed12000
0x105a9a7f4: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x105a9a7f8: ldr      x1, [sp, #0x38]
0x105a9a7fc: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a800: mov      x2, x0
0x105a9a804: mov      x0, x23
0x105a9a808: ldr      x1, [sp, #0x40]
0x105a9a80c: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a810: mov      x29, x29
0x105a9a814: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a818: mov      x25, x0
0x105a9a81c: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105a9a820: ldr      x1, [x8, #0x578] ; @selector(m_nsFromUsr) | 'm_nsFromUsr'
0x105a9a824: mov      x0, x24
0x105a9a828: bl       #0x107c27c64 ; _objc_msgSend | selector=m_nsFromUsr
0x105a9a82c: mov      x29, x29
0x105a9a830: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a834: mov      x26, x0
0x105a9a838: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a9a83c: ldr      x1, [x8, #0xec0] ; @selector(AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:) | 'AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:'
0x105a9a840: mov      x0, x25
0x105a9a844: mov      x2, x26
0x105a9a848: mov      x3, x24
0x105a9a84c: mov      w4, #0
0x105a9a850: mov      w5, #0
0x105a9a854: bl       #0x107c27c64 ; _objc_msgSend | selector=AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:
0x105a9a858: mov      x0, x26
0x105a9a85c: bl       #0x107c27c70 ; _objc_release
0x105a9a860: mov      x0, x25
0x105a9a864: bl       #0x107c27c70 ; _objc_release
0x105a9a868: mov      x0, x23
0x105a9a86c: bl       #0x107c27c70 ; _objc_release
0x105a9a870: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9a874: ldr      x1, [x8, #0xfc8] ; @selector(m_uiMesLocalID) | 'm_uiMesLocalID'
0x105a9a878: mov      x0, x24
0x105a9a87c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMesLocalID
0x105a9a880: mov      x25, x0
0x105a9a884: mov      x0, x24
0x105a9a888: bl       #0x107c27c70 ; _objc_release
0x105a9a88c: mov      x0, x22
0x105a9a890: bl       #0x107c27c70 ; _objc_release
0x105a9a894: mov      x26, x27
0x105a9a898: mov      x0, x26
0x105a9a89c: bl       #0x107c27c70 ; _objc_release
0x105a9a8a0: ldr      x0, [sp, #0x48]
0x105a9a8a4: bl       #0x107c27c70 ; _objc_release
0x105a9a8a8: mov      x0, x21
0x105a9a8ac: bl       #0x107c27c70 ; _objc_release
0x105a9a8b0: mov      x0, x20
0x105a9a8b4: bl       #0x107c27c70 ; _objc_release
0x105a9a8b8: mov      x0, x19
0x105a9a8bc: bl       #0x107c27c70 ; _objc_release
0x105a9a8c0: ldr      x8, [sp, #0x58]
0x105a9a8c4: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105a9a8c8: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105a9a8cc: ldr      x9, [x9]
0x105a9a8d0: cmp      x9, x8
0x105a9a8d4: b.ne     #0x105a9ab10
0x105a9a8d8: mov      x0, x25
0x105a9a8dc: ldp      x29, x30, [sp, #0xb0]
0x105a9a8e0: ldp      x20, x19, [sp, #0xa0]
0x105a9a8e4: ldp      x22, x21, [sp, #0x90]
0x105a9a8e8: ldp      x24, x23, [sp, #0x80]
0x105a9a8ec: ldp      x26, x25, [sp, #0x70]
0x105a9a8f0: ldp      x28, x27, [sp, #0x60]
0x105a9a8f4: add      sp, sp, #0xc0
0x105a9a8f8: ret      
0x105a9a8fc: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x105a9a900: adrp     x8, #0x11d332000
0x105a9a904: add      x8, x8, #0xe18 ; @'merge pat wrap to recent pat message'
0x105a9a908: str      x8, [sp] ; @'merge pat wrap to recent pat message'
0x105a9a90c: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9a910: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9a914: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9a918: add      x7, x7, #0x76c ; '-[SendPatMgr addPatWrap:toChat:newXMLMessageWrap:index:]'
0x105a9a91c: mov      x1, x27
0x105a9a920: mov      w2, #2
0x105a9a924: mov      x3, #0
0x105a9a928: mov      w4, #0
0x105a9a92c: mov      w6, #0x647
0x105a9a930: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a934: ldr      x24, [sp, #0x28]
0x105a9a938: cbz      x24, #0x105a9a968
0x105a9a93c: mov      x0, x22
0x105a9a940: mov      x1, x25
0x105a9a944: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a948: mov      x29, x29
0x105a9a94c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a950: mov      x23, x0
0x105a9a954: ldr      x1, [sp, #0x20]
0x105a9a958: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a95c: str      x0, [x24]
0x105a9a960: mov      x0, x23
0x105a9a964: bl       #0x107c27c70 ; _objc_release
0x105a9a968: mov      x0, x22
0x105a9a96c: mov      x1, x25
0x105a9a970: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a974: mov      x29, x29
0x105a9a978: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a97c: mov      x23, x0
0x105a9a980: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105a9a984: ldr      x1, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105a9a988: mov      x2, x19
0x105a9a98c: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105a9a990: mov      x0, x23
0x105a9a994: bl       #0x107c27c70 ; _objc_release
0x105a9a998: mov      x0, x22
0x105a9a99c: mov      x1, x25
0x105a9a9a0: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a9a4: mov      x29, x29
0x105a9a9a8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9a9ac: mov      x23, x0
0x105a9a9b0: ldr      x1, [sp, #0x20]
0x105a9a9b4: bl       #0x107c27c64 ; _objc_msgSend
0x105a9a9b8: mov      x2, x0
0x105a9a9bc: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a9a9c0: ldr      x1, [x8, #0x260] ; @selector(setPatCount:) | 'setPatCount:'
0x105a9a9c4: mov      x0, x22
0x105a9a9c8: bl       #0x107c27c64 ; _objc_msgSend | selector=setPatCount:
0x105a9a9cc: mov      x0, x23
0x105a9a9d0: bl       #0x107c27c70 ; _objc_release
0x105a9a9d4: adrp     x8, #0x11ed13000 ; classref CommonAffServiceCenterCpp
0x105a9a9d8: ldr      x0, [x8, #0x968] ; classref SendPatMgr | Class SendPatMgr
0x105a9a9dc: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9a9e0: ldr      x1, [x8, #0xfc0] ; @selector(updateMessageWrap:fromWrap:) | 'updateMessageWrap:fromWrap:'
0x105a9a9e4: mov      x2, x26
0x105a9a9e8: mov      x3, x22
0x105a9a9ec: bl       #0x107c27c64 ; _objc_msgSend | selector=updateMessageWrap:fromWrap:
0x105a9a9f0: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a9a9f4: ldr      x24, [x8, #0xfc8] ; @selector(serverId) | 'serverId'
0x105a9a9f8: mov      x0, x19
0x105a9a9fc: mov      x1, x24 ; 'serverId'
0x105a9aa00: bl       #0x107c27c64 ; _objc_msgSend | selector=serverId
0x105a9aa04: cbz      x0, #0x105a9aa1c
0x105a9aa08: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9aa0c: ldr      x1, [x8, #0xfd0] ; @selector(m_n64MesSvrID) | 'm_n64MesSvrID'
0x105a9aa10: mov      x0, x26
0x105a9aa14: bl       #0x107c27c64 ; _objc_msgSend | selector=m_n64MesSvrID
0x105a9aa18: cbz      x0, #0x105a9aa24
0x105a9aa1c: mov      w24, #4
0x105a9aa20: b        #0x105a9aa80
0x105a9aa24: ldr      x0, [x28, #0x618] ; classref iConsole | Class iConsole
0x105a9aa28: adrp     x8, #0x11d332000
0x105a9aa2c: add      x8, x8, #0xb8 ; @'server id is 0 for whole message, will update to message'
0x105a9aa30: str      x8, [sp] ; @'server id is 0 for whole message, will update to message'
0x105a9aa34: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9aa38: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9aa3c: adrp     x7, #0x11a2a8000 ; 'hin double tap revoke interval and has not revoked before, should revoke'
0x105a9aa40: add      x7, x7, #0x76c ; '-[SendPatMgr addPatWrap:toChat:newXMLMessageWrap:index:]'
0x105a9aa44: mov      x1, x27
0x105a9aa48: mov      w2, #2
0x105a9aa4c: mov      x3, #0
0x105a9aa50: mov      w4, #0
0x105a9aa54: mov      w6, #0x651
0x105a9aa58: bl       #0x107c27c64 ; _objc_msgSend
0x105a9aa5c: mov      x0, x19
0x105a9aa60: mov      x1, x24 ; 'serverId'
0x105a9aa64: bl       #0x107c27c64 ; _objc_msgSend | selector=serverId
0x105a9aa68: mov      x2, x0
0x105a9aa6c: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a9aa70: ldr      x1, [x8, #0x798] ; @selector(setM_n64MesSvrID:) | 'setM_n64MesSvrID:'
0x105a9aa74: mov      x0, x26
0x105a9aa78: bl       #0x107c27c64 ; _objc_msgSend | selector=setM_n64MesSvrID:
0x105a9aa7c: mov      w24, #6
0x105a9aa80: adrp     x8, #0x11ed12000
0x105a9aa84: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a9aa88: ldr      x1, [sp, #0x30]
0x105a9aa8c: bl       #0x107c27c64 ; _objc_msgSend
0x105a9aa90: mov      x29, x29
0x105a9aa94: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9aa98: mov      x23, x0
0x105a9aa9c: adrp     x8, #0x11ed12000
0x105a9aaa0: ldr      x0, [x8, #0xc20] ; classref CMessageMgr | Class CMessageMgr
0x105a9aaa4: ldr      x1, [sp, #0x38]
0x105a9aaa8: bl       #0x107c27c64 ; _objc_msgSend
0x105a9aaac: mov      x2, x0
0x105a9aab0: mov      x0, x23
0x105a9aab4: ldr      x1, [sp, #0x40]
0x105a9aab8: bl       #0x107c27c64 ; _objc_msgSend
0x105a9aabc: mov      x29, x29
0x105a9aac0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9aac4: mov      x25, x0
0x105a9aac8: adrp     x8, #0x11e9cf000 ; @selector(lastUpdateWatermarkTime)
0x105a9aacc: ldr      x1, [x8, #0xd50] ; @selector(ModMsgByBitSet:MsgWrap:BitSet:) | 'ModMsgByBitSet:MsgWrap:BitSet:'
0x105a9aad0: mov      x2, x20
0x105a9aad4: mov      x3, x26
0x105a9aad8: mov      x4, x24 ; 'serverId'
0x105a9aadc: bl       #0x107c27c64 ; _objc_msgSend | selector=ModMsgByBitSet:MsgWrap:BitSet:
0x105a9aae0: mov      x0, x25
0x105a9aae4: bl       #0x107c27c70 ; _objc_release
0x105a9aae8: mov      x0, x23
0x105a9aaec: bl       #0x107c27c70 ; _objc_release
0x105a9aaf0: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a9aaf4: ldr      x1, [x8, #0xfc8] ; @selector(m_uiMesLocalID) | 'm_uiMesLocalID'
0x105a9aaf8: mov      x0, x26
0x105a9aafc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMesLocalID
0x105a9ab00: mov      x25, x0
0x105a9ab04: mov      x0, x22
0x105a9ab08: bl       #0x107c27c70 ; _objc_release
0x105a9ab0c: b        #0x105a9a898
0x105a9ab10: bl       #0x107c27730 ; ___stack_chk_fail
