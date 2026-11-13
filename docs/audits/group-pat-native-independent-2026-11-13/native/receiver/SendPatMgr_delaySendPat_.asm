-[SendPatMgr delaySendPat:] 0x105a95548 v24@0:8@16
0x105a95548: sub      sp, sp, #0x50
0x105a9554c: stp      x24, x23, [sp, #0x10]
0x105a95550: stp      x22, x21, [sp, #0x20]
0x105a95554: stp      x20, x19, [sp, #0x30]
0x105a95558: stp      x29, x30, [sp, #0x40]
0x105a9555c: add      x29, sp, #0x40
0x105a95560: mov      x19, x2
0x105a95564: mov      x20, x0
0x105a95568: adrp     x8, #0x11f754000
0x105a9556c: mov      w9, #1
0x105a95570: strb     w9, [x8, #0xb84]
0x105a95574: mov      x0, x2
0x105a95578: bl       #0x107c27c74 ; _objc_retain
0x105a9557c: adrp     x8, #0x11eb40000 ; @selector(addBoundaryTimeObserverForTimes:queue:usingBlock:)
0x105a95580: ldr      x1, [x8, #0x620] ; @selector(patSendDelayInterval) | 'patSendDelayInterval'
0x105a95584: mov      x0, x20
0x105a95588: bl       #0x107c27c64 ; _objc_msgSend | selector=patSendDelayInterval
0x105a9558c: cbz      w0, #0x105a95678
0x105a95590: adrp     x8, #0x11ed12000
0x105a95594: ldr      x8, [x8, #0x8e8] ; classref MMTimer | Class MMTimer
0x105a95598: ucvtf    d0, w0
0x105a9559c: adrp     x9, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a955a0: ldr      x3, [x9, #0xa00] ; @selector(handleSendPat:) | 'handleSendPat:'
0x105a955a4: adrp     x9, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105a955a8: ldr      x1, [x9, #0x2c0] ; @selector(scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:) | 'scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:'
0x105a955ac: mov      x0, x8 ; Class MMTimer
0x105a955b0: mov      x2, x20
0x105a955b4: mov      x4, x19
0x105a955b8: mov      w5, #0
0x105a955bc: bl       #0x107c27c64 ; _objc_msgSend | selector=scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:
0x105a955c0: mov      x29, x29
0x105a955c4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a955c8: mov      x21, x0
0x105a955cc: adrp     x8, #0x11ed14000 ; classref SilkAudioCodec
0x105a955d0: ldr      x0, [x8, #0x750] ; _OBJC_CLASS_$_NSRunLoop
0x105a955d4: adrp     x8, #0x11e9e3000 ; @selector(viewModelList)
0x105a955d8: ldr      x1, [x8, #0xea0] ; @selector(mainRunLoop) | 'mainRunLoop'
0x105a955dc: bl       #0x107c27c64 ; _objc_msgSend | selector=mainRunLoop
0x105a955e0: mov      x29, x29
0x105a955e4: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a955e8: mov      x22, x0
0x105a955ec: adrp     x8, #0x11e9d6000 ; @selector(setIsMute:)
0x105a955f0: ldr      x1, [x8, #0x948] ; @selector(m_timer) | 'm_timer'
0x105a955f4: mov      x0, x21
0x105a955f8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_timer
0x105a955fc: mov      x29, x29
0x105a95600: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a95604: mov      x23, x0
0x105a95608: adrp     x8, #0x11d74e000 ; _AVLinearPCMIsBigEndianKey
0x105a9560c: ldr      x8, [x8, #0x960] ; _NSRunLoopCommonModes
0x105a95610: ldr      x3, [x8]
0x105a95614: adrp     x8, #0x11eca5000 ; @selector(voiceIdSet)
0x105a95618: ldr      x1, [x8, #0xaf8] ; @selector(addTimer:forMode:) | 'addTimer:forMode:'
0x105a9561c: mov      x0, x22
0x105a95620: mov      x2, x23
0x105a95624: bl       #0x107c27c64 ; _objc_msgSend | selector=addTimer:forMode:
0x105a95628: mov      x0, x23
0x105a9562c: bl       #0x107c27c70 ; _objc_release
0x105a95630: mov      x0, x22
0x105a95634: bl       #0x107c27c70 ; _objc_release
0x105a95638: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a9563c: ldr      x1, [x8, #0x900] ; @selector(onGoingTimerSet) | 'onGoingTimerSet'
0x105a95640: mov      x0, x20
0x105a95644: bl       #0x107c27c64 ; _objc_msgSend | selector=onGoingTimerSet
0x105a95648: mov      x29, x29
0x105a9564c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x105a95650: mov      x20, x0
0x105a95654: adrp     x8, #0x11e9ca000 ; @selector(isUsingEarDeviceWithRoute:)
0x105a95658: ldr      x1, [x8, #0x580] ; @selector(safeAddObject:) | 'safeAddObject:'
0x105a9565c: mov      x2, x21
0x105a95660: bl       #0x107c27c64 ; _objc_msgSend | selector=safeAddObject:
0x105a95664: mov      x0, x20
0x105a95668: bl       #0x107c27c70 ; _objc_release
0x105a9566c: mov      x0, x21
0x105a95670: bl       #0x107c27c70 ; _objc_release
0x105a95674: b        #0x105a956cc
0x105a95678: adrp     x8, #0x11ed12000
0x105a9567c: ldr      x0, [x8, #0x618] ; classref iConsole | Class iConsole
0x105a95680: adrp     x8, #0x11e9c9000
0x105a95684: ldr      x1, [x8, #0x310] ; @selector(logWithLevel:module:errorCode:file:line:func:format:) | 'logWithLevel:module:errorCode:file:line:func:format:'
0x105a95688: adrp     x8, #0x11d332000
0x105a9568c: add      x8, x8, #0x8b8 ; @'delay interval is 0, will send pat immediately'
0x105a95690: str      x8, [sp] ; @'delay interval is 0, will send pat immediately'
0x105a95694: adrp     x5, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a95698: add      x5, x5, #0x196 ; 'SendPatMgr.mm'
0x105a9569c: adrp     x7, #0x11a2a7000 ; 'or code:%d and message: %@'
0x105a956a0: add      x7, x7, #0xcac ; '-[SendPatMgr delaySendPat:]'
0x105a956a4: mov      w2, #2
0x105a956a8: mov      x3, #0
0x105a956ac: mov      w4, #0
0x105a956b0: mov      w6, #0x391
0x105a956b4: bl       #0x107c27c64 ; _objc_msgSend | selector=logWithLevel:module:errorCode:file:line:func:format:
0x105a956b8: adrp     x8, #0x11eb4f000 ; @selector(curLanguageIsEnglish)
0x105a956bc: ldr      x1, [x8, #0xa00] ; @selector(handleSendPat:) | 'handleSendPat:'
0x105a956c0: mov      x0, x20
0x105a956c4: mov      x2, x19
0x105a956c8: bl       #0x107c27c64 ; _objc_msgSend | selector=handleSendPat:
0x105a956cc: mov      x0, x19
0x105a956d0: ldp      x29, x30, [sp, #0x40]
0x105a956d4: ldp      x20, x19, [sp, #0x30]
0x105a956d8: ldp      x22, x21, [sp, #0x20]
0x105a956dc: ldp      x24, x23, [sp, #0x10]
0x105a956e0: add      sp, sp, #0x50
0x105a956e4: b        #0x107c27c70 ; _objc_release
