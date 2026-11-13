-[SendPatMgr sendPat:] 0x105a94098 B24@0:8@16
0x105a94098: sub      sp, sp, #0x1e0
0x105a9409c: stp      x28, x27, [sp, #0x180]
0x105a940a0: stp      x26, x25, [sp, #0x190]
0x105a940a4: stp      x24, x23, [sp, #0x1a0]
0x105a940a8: stp      x22, x21, [sp, #0x1b0]
0x105a940ac: stp      x20, x19, [sp, #0x1c0]
0x105a940b0: stp      x29, x30, [sp, #0x1d0]
0x105a940b4: add      x29, sp, #0x1d0
0x105a940b8: mov      x22, x2
0x105a940bc: mov      x25, x0
0x105a940c0: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105a940c4: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x105a940c8: ldr      x8, [x8]
0x105a940cc: stur     x8, [x29, #-0x60]
0x105a940d0: adrp     x8, #0x11f754000
0x105a940d4: mov      w9, #1
0x105a940d8: strb     w9, [x8, #0xb81]
0x105a940dc: mov      x0, x2
0x105a940e0: bl       #0x107c27c74 ; _objc_retain
0x105a940e4: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a940e8: ldr      x1, [x8, #0xa60] ; @selector(isValid) | 'isValid'
0x105a940ec: mov      x0, x22
0x105a940f0: bl       #0x107c27c64 ; _objc_msgSend | selector=isValid
0x105a940f4: tbz      w0, #0, #0x105a941fc
0x105a940f8: adrp     x8, #0x11ed36000 ; classref ScanQRCodeMerchantPayUrlHandler
0x105a940fc: ldr      x0, [x8, #0x2d8] ; classref SendPatReportObject | Class SendPatReportObject
0x105a94100: bl       #0x107c27c0c ; _objc_alloc_init
0x105a94104: mov      x24, x0
0x105a94108: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9410c: ldr      x23, [x8, #0x920] ; @selector(setSendPatWrap:) | 'setSendPatWrap:'
0x105a94110: mov      x1, x23 ; 'setSendPatWrap:'
0x105a94114: mov      x2, x22
0x105a94118: bl       #0x107c27c64 ; _objc_msgSend | selector=setSendPatWrap:
0x105a9411c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94120: ldr      x1, [x8, #0x928] ; @selector(prepareReport) | 'prepareReport'
0x105a94124: mov      x0, x24
0x105a94128: bl       #0x107c27c64 ; _objc_msgSend | selector=prepareReport
0x105a9412c: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a94130: ldr      x27, [x8, #0xf98] ; @selector(pattedUserName) | 'pattedUserName'
0x105a94134: mov      x0, x22
0x105a94138: mov      x1, x27 ; 'pattedUserName'
0x105a9413c: bl       #0x107c27c64 ; _objc_msgSend | selector=pattedUserName
0x105a94140: mov      x29, x29
0x105a94144: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94148: mov      x21, x0
0x105a9414c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94150: ldr      x1, [x8, #0x930] ; @selector(hitFrequencyLimitForUserName:) | 'hitFrequencyLimitForUserName:'
0x105a94154: mov      x0, x25
0x105a94158: mov      x2, x21
0x105a9415c: bl       #0x107c27c64 ; _objc_msgSend | selector=hitFrequencyLimitForUserName:
0x105a94160: cbz      w0, #0x105a94244
0x105a94164: adrp     x8, #0x11ed12000
0x105a94168: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9416c: adrp     x8, #0x11e9c9000
0x105a94170: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a94174: adrp     x8, #0x11d332000
0x105a94178: add      x8, x8, #0x738 ; @'hit frequency limit, will not send pat'
0x105a9417c: str      x8, [sp] ; @'hit frequency limit, will not send pat'
0x105a94180: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94184: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a94188: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9418c: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a94190: mov      w2, #4
0x105a94194: mov      x3, #0
0x105a94198: mov      w4, #0
0x105a9419c: mov      w6, #0x2d2
0x105a941a0: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a941a4: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a941a8: ldr      x1, [x8, #0x938] ; @selector(needRevokeLastPatForSendPat:) | 'needRevokeLastPatForSendPat:'
0x105a941ac: mov      x0, x25
0x105a941b0: mov      x2, x22
0x105a941b4: bl       #0x107c27c64 ; _objc_msgSend | selector=needRevokeLastPatForSendPat:
0x105a941b8: mov      x2, x0
0x105a941bc: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a941c0: ldr      x1, [x8, #0x940] ; @selector(setNeedRevokeLastPat:) | 'setNeedRevokeLastPat:'
0x105a941c4: mov      x0, x25
0x105a941c8: bl       #0x107c27c64 ; _objc_msgSend | selector=setNeedRevokeLastPat:
0x105a941cc: adrp     x8, #0x11ea1a000 ; @selector(isMediaGroupFirstDisplayMsg:)
0x105a941d0: ldr      x1, [x8, #0x148] ; @selector(needRevokeLastPat) | 'needRevokeLastPat'
0x105a941d4: mov      x0, x25
0x105a941d8: bl       #0x107c27c64 ; _objc_msgSend | selector=needRevokeLastPat
0x105a941dc: mov      w19, #0
0x105a941e0: tbnz     w0, #0, #0x105a94958
0x105a941e4: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a941e8: ldr      x1, [x8, #0x948] ; @selector(reportFromHitFrequencyLimit) | 'reportFromHitFrequencyLimit'
0x105a941ec: mov      x0, x24
0x105a941f0: bl       #0x107c27c64 ; _objc_msgSend | selector=reportFromHitFrequencyLimit
0x105a941f4: mov      w19, #0
0x105a941f8: b        #0x105a94958
0x105a941fc: adrp     x8, #0x11ed12000
0x105a94200: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a94204: adrp     x8, #0x11e9c9000
0x105a94208: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9420c: adrp     x8, #0x11d332000
0x105a94210: add      x8, x8, #0x718 ; @'invalid send pat wrap: %@'
0x105a94214: stp      x8, x22, [sp] ; @'invalid send pat wrap: %@'
0x105a94218: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9421c: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a94220: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94224: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a94228: mov      w2, #4
0x105a9422c: mov      x3, #0
0x105a94230: mov      w4, #0
0x105a94234: mov      w6, #0x2c8
0x105a94238: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a9423c: mov      w19, #0
0x105a94240: b        #0x105a94968
0x105a94244: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94248: ldr      x1, [x8, #0x950] ; @selector(updatePatTimeForUsername:) | 'updatePatTimeForUsername:'
0x105a9424c: mov      x0, x25
0x105a94250: mov      x2, x21
0x105a94254: bl       #0x107c27c64 ; _objc_msgSend | selector=updatePatTimeForUsername:
0x105a94258: adrp     x8, #0x11eb2a000 ; @selector(setFloatViewYBeforeKeyboardShow:)
0x105a9425c: ldr      x1, [x8, #0x218] ; @selector(patSuffixWrapForUserName:) | 'patSuffixWrapForUserName:'
0x105a94260: mov      x0, x25
0x105a94264: mov      x2, x21
0x105a94268: bl       #0x107c27c64 ; _objc_msgSend | selector=patSuffixWrapForUserName:
0x105a9426c: mov      x29, x29
0x105a94270: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94274: mov      x26, x0
0x105a94278: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9427c: ldr      x1, [x8, #0x830] ; @selector(setCachedPatSuffixWrap:) | 'setCachedPatSuffixWrap:'
0x105a94280: mov      x0, x22
0x105a94284: mov      x2, x26
0x105a94288: bl       #0x107c27c64 ; _objc_msgSend | selector=setCachedPatSuffixWrap:
0x105a9428c: mov      x0, x22
0x105a94290: mov      x1, x27 ; 'pattedUserName'
0x105a94294: bl       #0x107c27c64 ; _objc_msgSend | selector=pattedUserName
0x105a94298: mov      x29, x29
0x105a9429c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a942a0: mov      x19, x0
0x105a942a4: adrp     x8, #0x11ea1c000 ; @selector(textStateJumpTopicSquareWithReporter:)
0x105a942a8: ldr      x1, [x8, #0x508] ; @selector(patSuffix) | 'patSuffix'
0x105a942ac: mov      x0, x26
0x105a942b0: bl       #0x107c27c64 ; _objc_msgSend | selector=patSuffix
0x105a942b4: mov      x29, x29
0x105a942b8: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a942bc: mov      x20, x0
0x105a942c0: adrp     x8, #0x11ea1c000 ; @selector(textStateJumpTopicSquareWithReporter:)
0x105a942c4: ldr      x1, [x8, #0x510] ; @selector(templeteVersion) | 'templeteVersion'
0x105a942c8: mov      x0, x26
0x105a942cc: bl       #0x107c27c64 ; _objc_msgSend | selector=templeteVersion
0x105a942d0: mov      x4, x0
0x105a942d4: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a942d8: ldr      x1, [x8, #0x838] ; @selector(createSendPatTempleteFromPattedUserName:withSuffix:andVersion:) | 'createSendPatTempleteFromPattedUserName:withSuffix:andVersion:'
0x105a942dc: mov      x0, x25
0x105a942e0: mov      x2, x19
0x105a942e4: mov      x3, x20
0x105a942e8: bl       #0x107c27c64 ; _objc_msgSend | selector=createSendPatTempleteFromPattedUserName:withSuffix:andVersion:
0x105a942ec: mov      x29, x29
0x105a942f0: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a942f4: mov      x28, x0
0x105a942f8: mov      x0, x20
0x105a942fc: bl       #0x107c27c70 ; _objc_release
0x105a94300: mov      x0, x19
0x105a94304: bl       #0x107c27c70 ; _objc_release
0x105a94308: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a9430c: ldr      x1, [x8, #0xce8] ; @selector(length) | 'length'
0x105a94310: mov      x0, x28
0x105a94314: bl       #0x107c27c64 ; _objc_msgSend | selector=length
0x105a94318: cmp      x0, #0
0x105a9431c: cset     w19, ne
0x105a94320: cbz      x0, #0x105a94524
0x105a94324: str      x23, [sp, #0x68] ; 'setSendPatWrap:'
0x105a94328: str      w19, [sp, #0x2c]
0x105a9432c: adrp     x8, #0x11ed12000
0x105a94330: ldr      x0, [x8, #0x8a0] ; classref CUtility | Class CUtility
0x105a94334: adrp     x8, #0x11e9cc000 ; @selector(setCenterY:)
0x105a94338: ldr      x1, [x8, #0x38] ; @selector(genServerCurrentTime) | 'genServerCurrentTime'
0x105a9433c: bl       #0x107c27c64 ; _objc_msgSend | selector=genServerCurrentTime
0x105a94340: mov      x19, x0
0x105a94344: adrp     x8, #0x11ed34000 ; classref WCFinderObjectMonotonicData
0x105a94348: ldr      x0, [x8, #0xc70] ; classref PatWrap | Class PatWrap
0x105a9434c: bl       #0x107c27c0c ; _objc_alloc_init
0x105a94350: mov      x23, x0
0x105a94354: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a94358: ldr      x1, [x8, #0xfa0] ; @selector(fromUserName) | 'fromUserName'
0x105a9435c: mov      x0, x22
0x105a94360: bl       #0x107c27c64 ; _objc_msgSend | selector=fromUserName
0x105a94364: mov      x29, x29
0x105a94368: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a9436c: mov      x20, x0
0x105a94370: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a94374: ldr      x1, [x8, #0x6e0] ; @selector(setFromUserName:) | 'setFromUserName:'
0x105a94378: mov      x0, x23
0x105a9437c: mov      x2, x20
0x105a94380: bl       #0x107c27c64 ; _objc_msgSend | selector=setFromUserName:
0x105a94384: mov      x0, x20
0x105a94388: bl       #0x107c27c70 ; _objc_release
0x105a9438c: mov      x0, x22
0x105a94390: mov      x1, x27 ; 'pattedUserName'
0x105a94394: bl       #0x107c27c64 ; _objc_msgSend | selector=pattedUserName
0x105a94398: mov      x29, x29
0x105a9439c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a943a0: mov      x20, x0
0x105a943a4: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a943a8: ldr      x1, [x8, #0x808] ; @selector(setPattedUserName:) | 'setPattedUserName:'
0x105a943ac: mov      x0, x23
0x105a943b0: mov      x2, x20
0x105a943b4: bl       #0x107c27c64 ; _objc_msgSend | selector=setPattedUserName:
0x105a943b8: mov      x0, x20
0x105a943bc: bl       #0x107c27c70 ; _objc_release
0x105a943c0: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a943c4: ldr      x1, [x8, #0x840] ; @selector(setTemplete:) | 'setTemplete:'
0x105a943c8: mov      x0, x23
0x105a943cc: mov      x2, x28
0x105a943d0: bl       #0x107c27c64 ; _objc_msgSend | selector=setTemplete:
0x105a943d4: mov      w8, #0x3e8
0x105a943d8: umull    x2, w19, w8
0x105a943dc: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a943e0: ldr      x1, [x8, #0x708] ; @selector(setCreateTime:) | 'setCreateTime:'
0x105a943e4: mov      x0, x23
0x105a943e8: bl       #0x107c27c64 ; _objc_msgSend | selector=setCreateTime:
0x105a943ec: adrp     x8, #0x11e9ea000 ; @selector(shouldHandleCategoryItem:)
0x105a943f0: ldr      x1, [x8, #0xff0] ; @selector(setServerId:) | 'setServerId:'
0x105a943f4: mov      x0, x23
0x105a943f8: mov      x2, #0
0x105a943fc: bl       #0x107c27c64 ; _objc_msgSend | selector=setServerId:
0x105a94400: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a94404: ldr      x1, [x8, #0xfa8] ; @selector(setIsRead:) | 'setIsRead:'
0x105a94408: mov      x0, x23
0x105a9440c: mov      w2, #0
0x105a94410: bl       #0x107c27c64 ; _objc_msgSend | selector=setIsRead:
0x105a94414: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94418: ldr      x19, [x8, #0x8a8] ; @selector(setShowChangeSuffixRemind:) | 'setShowChangeSuffixRemind:'
0x105a9441c: mov      x0, x23
0x105a94420: mov      x1, x19 ; 'setShowChangeSuffixRemind:'
0x105a94424: mov      w2, #0
0x105a94428: bl       #0x107c27c64 ; _objc_msgSend | selector=setShowChangeSuffixRemind:
0x105a9442c: adrp     x8, #0x11ed12000
0x105a94430: ldr      x0, [x8, #0x780] ; classref MMContext | Class MMContext
0x105a94434: adrp     x8, #0x11e9cd000 ; @selector(isMsgSendFromMe)
0x105a94438: ldr      x1, [x8, #0x990] ; @selector(currentUserName) | 'currentUserName'
0x105a9443c: bl       #0x107c27c64 ; _objc_msgSend | selector=currentUserName
0x105a94440: mov      x29, x29
0x105a94444: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94448: mov      x20, x0
0x105a9444c: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a94450: ldr      x1, [x8, #0x7b8] ; @selector(isEqualToString:) | 'isEqualToString:'
0x105a94454: str      x21, [sp, #0x38]
0x105a94458: mov      x0, x21
0x105a9445c: mov      x2, x20
0x105a94460: bl       #0x107c27c64 ; _objc_msgSend | selector=isEqualToString:
0x105a94464: mov      x21, x0
0x105a94468: mov      x0, x20
0x105a9446c: bl       #0x107c27c70 ; _objc_release
0x105a94470: cbz      w21, #0x105a944a8
0x105a94474: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94478: ldr      x1, [x8, #0x958] ; @selector(needShowChangeSuffixRemind) | 'needShowChangeSuffixRemind'
0x105a9447c: mov      x0, x25
0x105a94480: bl       #0x107c27c64 ; _objc_msgSend | selector=needShowChangeSuffixRemind
0x105a94484: cbz      w0, #0x105a944a8
0x105a94488: mov      x0, x23
0x105a9448c: mov      x1, x19 ; 'setShowChangeSuffixRemind:'
0x105a94490: mov      w2, #1
0x105a94494: bl       #0x107c27c64 ; _objc_msgSend | selector=setShowChangeSuffixRemind:
0x105a94498: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9449c: ldr      x1, [x8, #0x960] ; @selector(updateModifyPatSuffixTimeAndCount) | 'updateModifyPatSuffixTimeAndCount'
0x105a944a0: mov      x0, x25
0x105a944a4: bl       #0x107c27c64 ; _objc_msgSend | selector=updateModifyPatSuffixTimeAndCount
0x105a944a8: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a944ac: ldr      x1, [x8, #0xe10] ; @selector(setPatWrap:) | 'setPatWrap:'
0x105a944b0: mov      x0, x22
0x105a944b4: mov      x2, x23
0x105a944b8: bl       #0x107c27c64 ; _objc_msgSend | selector=setPatWrap:
0x105a944bc: str      xzr, [sp, #0xe8]
0x105a944c0: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a944c4: ldr      x1, [x8, #0xc98] ; @selector(chatUserName) | 'chatUserName'
0x105a944c8: mov      x0, x22
0x105a944cc: bl       #0x107c27c64 ; _objc_msgSend | selector=chatUserName
0x105a944d0: mov      x29, x29
0x105a944d4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a944d8: mov      x20, x0
0x105a944dc: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a944e0: ldr      x1, [x8, #0x968] ; @selector(addPatWrap:toChat:newXMLMessageWrap:index:) | 'addPatWrap:toChat:newXMLMessageWrap:index:'
0x105a944e4: add      x5, sp, #0xe8
0x105a944e8: mov      x0, x25
0x105a944ec: mov      x2, x23
0x105a944f0: mov      x3, x20
0x105a944f4: mov      x4, #0
0x105a944f8: bl       #0x107c27c64 ; _objc_msgSend | selector=addPatWrap:toChat:newXMLMessageWrap:index:
0x105a944fc: mov      x19, x0
0x105a94500: mov      x0, x20
0x105a94504: bl       #0x107c27c70 ; _objc_release
0x105a94508: cbz      w19, #0x105a94568
0x105a9450c: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94510: ldr      x1, [x8, #0x970] ; @selector(setAssociateMessageLocalID:) | 'setAssociateMessageLocalID:'
0x105a94514: mov      x0, x22
0x105a94518: mov      x2, x19
0x105a9451c: bl       #0x107c27c64 ; _objc_msgSend | selector=setAssociateMessageLocalID:
0x105a94520: b        #0x105a945a8
0x105a94524: adrp     x8, #0x11ed12000
0x105a94528: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9452c: adrp     x8, #0x11e9c9000
0x105a94530: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a94534: adrp     x8, #0x11d332000
0x105a94538: add      x8, x8, #0x358 ; @'templete is empty'
0x105a9453c: str      x8, [sp] ; @'templete is empty'
0x105a94540: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94544: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a94548: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9454c: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a94550: mov      w2, #4
0x105a94554: mov      x3, #0
0x105a94558: mov      w4, #0
0x105a9455c: mov      w6, #0x2e1
0x105a94560: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a94564: b        #0x105a94948
0x105a94568: adrp     x8, #0x11ed12000
0x105a9456c: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a94570: adrp     x8, #0x11e9c9000
0x105a94574: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a94578: adrp     x8, #0x11d332000
0x105a9457c: add      x8, x8, #0x758 ; @'sender message wrap with 0 local id'
0x105a94580: str      x8, [sp] ; @'sender message wrap with 0 local id'
0x105a94584: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94588: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9458c: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94590: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a94594: mov      w2, #4
0x105a94598: mov      x3, #0
0x105a9459c: mov      w4, #0
0x105a945a0: mov      w6, #0x2fd
0x105a945a4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a945a8: str      x28, [sp, #0x20]
0x105a945ac: str      x26, [sp, #0x30]
0x105a945b0: cmp      w19, #1
0x105a945b4: cset     w2, eq
0x105a945b8: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a945bc: ldr      x1, [x8, #0x978] ; @selector(setCreateNewChat:) | 'setCreateNewChat:'
0x105a945c0: mov      x0, x24
0x105a945c4: bl       #0x107c27c64 ; _objc_msgSend | selector=setCreateNewChat:
0x105a945c8: ldr      x2, [sp, #0xe8]
0x105a945cc: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a945d0: ldr      x1, [x8, #0x980] ; @selector(setPatIndex:) | 'setPatIndex:'
0x105a945d4: mov      x0, x24
0x105a945d8: bl       #0x107c27c64 ; _objc_msgSend | selector=setPatIndex:
0x105a945dc: adrp     x8, #0x11e9e4000 ; @selector(readPedometerProfileTarget:)
0x105a945e0: ldr      x1, [x8, #0x830] ; @selector(setStatus:) | 'setStatus:'
0x105a945e4: mov      x0, x22
0x105a945e8: mov      x2, #0
0x105a945ec: bl       #0x107c27c64 ; _objc_msgSend | selector=setStatus:
0x105a945f0: adrp     x8, #0x11e9d2000 ; @selector(defaultMemoryMappedKV)
0x105a945f4: ldr      x1, [x8, #0xe58] ; @selector(setReportObject:) | 'setReportObject:'
0x105a945f8: mov      x0, x22
0x105a945fc: mov      x2, x24
0x105a94600: bl       #0x107c27c64 ; _objc_msgSend | selector=setReportObject:
0x105a94604: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94608: ldr      x1, [x8, #0x988] ; @selector(setLastSendPatWrap:) | 'setLastSendPatWrap:'
0x105a9460c: mov      x0, x25
0x105a94610: mov      x2, x22
0x105a94614: bl       #0x107c27c64 ; _objc_msgSend | selector=setLastSendPatWrap:
0x105a94618: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9461c: ldr      x1, [x8, #0x990] ; @selector(checkAndShowRevokeGuideForSendPat:) | 'checkAndShowRevokeGuideForSendPat:'
0x105a94620: mov      x0, x25
0x105a94624: mov      x2, x22
0x105a94628: bl       #0x107c27c64 ; _objc_msgSend | selector=checkAndShowRevokeGuideForSendPat:
0x105a9462c: tbnz     w0, #0, #0x105a94644
0x105a94630: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a94634: ldr      x1, [x8, #0x998] ; @selector(delaySendPat:) | 'delaySendPat:'
0x105a94638: mov      x0, x25
0x105a9463c: mov      x2, x22
0x105a94640: bl       #0x107c27c64 ; _objc_msgSend | selector=delaySendPat:
0x105a94644: str      x23, [sp, #0x18]
0x105a94648: str      x24, [sp, #0x40]
0x105a9464c: adrp     x8, #0x11eb40000 ; @selector(addBoundaryTimeObserverForTimes:queue:usingBlock:)
0x105a94650: ldr      x1, [x8, #0x620] ; @selector(patSendDelayInterval) | 'patSendDelayInterval'
0x105a94654: mov      x0, x25
0x105a94658: bl       #0x107c27c64 ; _objc_msgSend | selector=patSendDelayInterval
0x105a9465c: cbz      w0, #0x105a94718
0x105a94660: adrp     x8, #0x11ed12000
0x105a94664: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a94668: adrp     x8, #0x11e9c9000
0x105a9466c: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a94670: adrp     x8, #0x11d332000
0x105a94674: add      x8, x8, #0x778 ; @'delay send pat, request suffix first'
0x105a94678: str      x8, [sp] ; @'delay send pat, request suffix first'
0x105a9467c: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94680: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a94684: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a94688: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a9468c: mov      w2, #2
0x105a94690: mov      x3, #0
0x105a94694: mov      w4, #0
0x105a94698: mov      w6, #0x30e
0x105a9469c: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a946a0: adrp     x8, #0x11ed36000 ; classref ScanQRCodeMerchantPayUrlHandler
0x105a946a4: ldr      x0, [x8, #0x2e0] ; classref SendPatCgi | Class SendPatCgi
0x105a946a8: bl       #0x107c27c0c ; _objc_alloc_init
0x105a946ac: mov      x19, x0
0x105a946b0: ldr      x1, [sp, #0x68]
0x105a946b4: mov      x2, x22
0x105a946b8: bl       #0x107c27c64 ; _objc_msgSend
0x105a946bc: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105a946c0: ldr      x8, [x8, #0x930] ; __NSConcreteStackBlock
0x105a946c4: str      x8, [sp, #0xb8]
0x105a946c8: adrp     x8, #0x1178c7000
0x105a946cc: ldr      d0, [x8, #0x680]
0x105a946d0: str      d0, [sp, #0xc0]
0x105a946d4: adrp     x8, #0x105a94000
0x105a946d8: add      x8, x8, #0x9b0
0x105a946dc: adrp     x9, #0x11c305000
0x105a946e0: add      x9, x9, #0x720
0x105a946e4: stp      x8, x9, [sp, #0xc8]
0x105a946e8: mov      x0, x22
0x105a946ec: bl       #0x107c27c74 ; _objc_retain
0x105a946f0: stp      x22, x25, [sp, #0xd8]
0x105a946f4: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a946f8: ldr      x1, [x8, #0x9a8] ; @selector(retrievePatSuffixWithSuccessBlock:) | 'retrievePatSuffixWithSuccessBlock:'
0x105a946fc: add      x2, sp, #0xb8
0x105a94700: mov      x0, x19
0x105a94704: bl       #0x107c27c64 ; _objc_msgSend | selector=retrievePatSuffixWithSuccessBlock:
0x105a94708: ldr      x0, [sp, #0xd8]
0x105a9470c: bl       #0x107c27c70 ; _objc_release
0x105a94710: mov      x0, x19
0x105a94714: bl       #0x107c27c70 ; _objc_release
0x105a94718: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9471c: ldr      x21, [x8, #0x8f8] ; @selector(availableSendPatWraps) | 'availableSendPatWraps'
0x105a94720: mov      x0, x25
0x105a94724: mov      x1, x21 ; 'availableSendPatWraps'
0x105a94728: bl       #0x107c27c64 ; _objc_msgSend | selector=availableSendPatWraps
0x105a9472c: mov      x29, x29
0x105a94730: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94734: mov      x19, x0
0x105a94738: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x105a9473c: ldr      x1, [x8, #0xb80] ; @selector(key) | 'key'
0x105a94740: mov      x0, x22
0x105a94744: str      x1, [sp, #0x58] ; 'key'
0x105a94748: bl       #0x107c27c64 ; _objc_msgSend | selector=key
0x105a9474c: mov      x29, x29
0x105a94750: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94754: mov      x20, x0
0x105a94758: adrp     x8, #0x11e9e0000 ; @selector(viewWillPresent:)
0x105a9475c: ldr      x1, [x8, #0xd18] ; @selector(setObjectAsLastObject:forKey:) | 'setObjectAsLastObject:forKey:'
0x105a94760: mov      x0, x19
0x105a94764: str      x22, [sp, #0x48]
0x105a94768: mov      x2, x22
0x105a9476c: mov      x3, x20
0x105a94770: bl       #0x107c27c64 ; _objc_msgSend | selector=setObjectAsLastObject:forKey:
0x105a94774: mov      x0, x20
0x105a94778: bl       #0x107c27c70 ; _objc_release
0x105a9477c: mov      x0, x19
0x105a94780: bl       #0x107c27c70 ; _objc_release
0x105a94784: movi     v0.16b, #0
0x105a94788: stp      q0, q0, [sp, #0x90]
0x105a9478c: stp      q0, q0, [sp, #0x70]
0x105a94790: stp      x21, x25, [sp, #0x60] ; 'availableSendPatWraps'
0x105a94794: mov      x0, x25
0x105a94798: mov      x1, x21 ; 'availableSendPatWraps'
0x105a9479c: bl       #0x107c27c64 ; _objc_msgSend | selector=availableSendPatWraps
0x105a947a0: mov      x29, x29
0x105a947a4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a947a8: mov      x19, x0
0x105a947ac: adrp     x8, #0x11ea16000 ; @selector(getSessionDetailQueue)
0x105a947b0: ldr      x1, [x8, #0xc88] ; @selector(allValuesInOrder) | 'allValuesInOrder'
0x105a947b4: bl       #0x107c27c64 ; _objc_msgSend | selector=allValuesInOrder
0x105a947b8: mov      x29, x29
0x105a947bc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a947c0: mov      x20, x0
0x105a947c4: mov      x0, x19
0x105a947c8: bl       #0x107c27c70 ; _objc_release
0x105a947cc: adrp     x8, #0x11eca6000 ; @selector(beaconTimeInterval)
0x105a947d0: ldr      x1, [x8, #0x858] ; @selector(countByEnumeratingWithState:objects:count:) | 'countByEnumeratingWithState:objects:count:'
0x105a947d4: add      x2, sp, #0x70
0x105a947d8: sub      x3, x29, #0xe0
0x105a947dc: str      x20, [sp, #0x50]
0x105a947e0: mov      x0, x20
0x105a947e4: str      x1, [sp, #0x10] ; 'countByEnumeratingWithState:objects:count:'
0x105a947e8: mov      w4, #0x10
0x105a947ec: bl       #0x107c27c64 ; _objc_msgSend | selector=countByEnumeratingWithState:objects:count:
0x105a947f0: cbz      x0, #0x105a94928
0x105a947f4: mov      x23, x0
0x105a947f8: ldr      x8, [sp, #0x80]
0x105a947fc: ldr      x28, [x8]
0x105a94800: mov      x27, #0
0x105a94804: adrp     x8, #0x11eb40000 ; @selector(addBoundaryTimeObserverForTimes:queue:usingBlock:)
0x105a94808: ldr      x20, [x8, #0x598] ; @selector(patWrap) | 'patWrap'
0x105a9480c: adrp     x8, #0x11e9d0000 ; @selector(nsTargetClockInType)
0x105a94810: ldr      x24, [x8, #0xcb8] ; @selector(canRevoke) | 'canRevoke'
0x105a94814: adrp     x8, #0x11e9c9000
0x105a94818: ldr      x22, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9481c: adrp     x8, #0x11ecaa000 ; @selector(processIdentifier)
0x105a94820: ldr      x19, [x8, #0x4d8] ; @selector(removeObjectForKey:) | 'removeObjectForKey:'
0x105a94824: ldr      x8, [sp, #0x80]
0x105a94828: ldr      x8, [x8]
0x105a9482c: cmp      x8, x28
0x105a94830: b.eq     #0x105a9483c
0x105a94834: ldr      x0, [sp, #0x50]
0x105a94838: bl       #0x107c27c3c ; _objc_enumerationMutation
0x105a9483c: ldr      x8, [sp, #0x78]
0x105a94840: ldr      x21, [x8, x27, lsl #3]
0x105a94844: mov      x0, x21
0x105a94848: mov      x1, x20 ; 'patWrap'
0x105a9484c: bl       #0x107c27c64 ; _objc_msgSend | selector=patWrap
0x105a94850: mov      x29, x29
0x105a94854: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a94858: mov      x26, x0
0x105a9485c: mov      x1, x24 ; 'canRevoke'
0x105a94860: bl       #0x107c27c64 ; _objc_msgSend | selector=canRevoke
0x105a94864: mov      x25, x0
0x105a94868: mov      x0, x26
0x105a9486c: bl       #0x107c27c70 ; _objc_release
0x105a94870: tbnz     w25, #0, #0x105a94928
0x105a94874: adrp     x8, #0x11ed12000
0x105a94878: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a9487c: adrp     x8, #0x11d332000
0x105a94880: add      x8, x8, #0x7b8 ; @'remove send pat wrap: %@ from available send pat wraps'
0x105a94884: stp      x8, x21, [sp] ; @'remove send pat wrap: %@ from available send pat wraps'
0x105a94888: mov      x1, x22 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9488c: mov      w2, #1
0x105a94890: mov      x3, #0
0x105a94894: mov      w4, #0
0x105a94898: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a9489c: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a948a0: mov      w6, #0x321
0x105a948a4: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a948a8: add      x7, x7, #0x9ea ; '-[SendPatMgr sendPat:]'
0x105a948ac: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a948b0: ldp      x1, x0, [sp, #0x60]
0x105a948b4: bl       #0x107c27c64 ; _objc_msgSend
0x105a948b8: mov      x29, x29
0x105a948bc: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a948c0: mov      x25, x0
0x105a948c4: mov      x0, x21
0x105a948c8: ldr      x1, [sp, #0x58]
0x105a948cc: bl       #0x107c27c64 ; _objc_msgSend
0x105a948d0: mov      x29, x29
0x105a948d4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a948d8: mov      x21, x0
0x105a948dc: mov      x0, x25
0x105a948e0: mov      x1, x19 ; 'removeObjectForKey:'
0x105a948e4: mov      x2, x21
0x105a948e8: bl       #0x107c27c64 ; _objc_msgSend | selector=removeObjectForKey:
0x105a948ec: mov      x0, x21
0x105a948f0: bl       #0x107c27c70 ; _objc_release
0x105a948f4: mov      x0, x25
0x105a948f8: bl       #0x107c27c70 ; _objc_release
0x105a948fc: add      x27, x27, #1
0x105a94900: cmp      x23, x27
0x105a94904: b.ne     #0x105a94824
0x105a94908: add      x2, sp, #0x70
0x105a9490c: sub      x3, x29, #0xe0
0x105a94910: ldr      x0, [sp, #0x50]
0x105a94914: ldr      x1, [sp, #0x10]
0x105a94918: mov      w4, #0x10
0x105a9491c: bl       #0x107c27c64 ; _objc_msgSend
0x105a94920: mov      x23, x0
0x105a94924: cbnz     x0, #0x105a94800
0x105a94928: ldr      x0, [sp, #0x50]
0x105a9492c: bl       #0x107c27c70 ; _objc_release
0x105a94930: ldr      x0, [sp, #0x18]
0x105a94934: bl       #0x107c27c70 ; _objc_release
0x105a94938: ldp      x24, x22, [sp, #0x40] ; 'canRevoke'
0x105a9493c: ldp      x26, x21, [sp, #0x30]
0x105a94940: ldr      w19, [sp, #0x2c]
0x105a94944: ldr      x28, [sp, #0x20]
0x105a94948: mov      x0, x28
0x105a9494c: bl       #0x107c27c70 ; _objc_release
0x105a94950: mov      x0, x26
0x105a94954: bl       #0x107c27c70 ; _objc_release
0x105a94958: mov      x0, x21
0x105a9495c: bl       #0x107c27c70 ; _objc_release
0x105a94960: mov      x0, x24 ; 'canRevoke'
0x105a94964: bl       #0x107c27c70 ; _objc_release
0x105a94968: mov      x0, x22 ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a9496c: bl       #0x107c27c70 ; _objc_release
0x105a94970: ldur     x8, [x29, #-0x60]
0x105a94974: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x105a94978: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x105a9497c: ldr      x9, [x9]
0x105a94980: cmp      x9, x8
0x105a94984: b.ne     #0x105a949ac
0x105a94988: mov      x0, x19 ; 'removeObjectForKey:'
0x105a9498c: ldp      x29, x30, [sp, #0x1d0]
0x105a94990: ldp      x20, x19, [sp, #0x1c0] ; 'patWrap'
0x105a94994: ldp      x22, x21, [sp, #0x1b0] ; 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a94998: ldp      x24, x23, [sp, #0x1a0] ; 'canRevoke'
0x105a9499c: ldp      x26, x25, [sp, #0x190]
0x105a949a0: ldp      x28, x27, [sp, #0x180]
0x105a949a4: add      sp, sp, #0x1e0
0x105a949a8: ret      
0x105a949ac: bl       #0x107c27730 ; ___stack_chk_fail
