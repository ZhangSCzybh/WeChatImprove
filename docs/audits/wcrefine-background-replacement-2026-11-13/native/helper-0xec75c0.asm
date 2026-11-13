0xec75c0: sub      sp, sp, #0x70
0xec75c4: stp      x29, x30, [sp, #0x60]
0xec75c8: add      x29, sp, #0x60
0xec75cc: adrp     x0, #0x246f000 ; 'er'
0xec75d0: add      x0, x0, #0xc5a ; 'VoipUIManager'
0xec75d4: bl       #0xecb17c
0xec75d8: mov      x29, x29
0xec75dc: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec75e0: stur     x0, [x29, #-0x10]
0xec75e4: ldur     x8, [x29, #-0x10]
0xec75e8: str      x8, [sp, #0x30]
0xec75ec: adrp     x0, #0x2645000
0xec75f0: add      x0, x0, #0xd30 ; @'isVoipWorking'
0xec75f4: bl       #0x2288728 ; _NSSelectorFromString
0xec75f8: mov      x1, x0
0xec75fc: ldr      x0, [sp, #0x30]
0xec7600: bl       #0xecb4dc
0xec7604: tbnz     w0, #0, #0xec7634
0xec7608: b        #0xec760c
0xec760c: ldur     x8, [x29, #-0x10]
0xec7610: str      x8, [sp, #0x28]
0xec7614: adrp     x0, #0x2645000
0xec7618: add      x0, x0, #0xd50 ; @'isTalking'
0xec761c: bl       #0x2288728 ; _NSSelectorFromString
0xec7620: mov      x1, x0
0xec7624: ldr      x0, [sp, #0x28]
0xec7628: bl       #0xecb4dc
0xec762c: tbz      w0, #0, #0xec764c
0xec7630: b        #0xec7634
0xec7634: mov      w8, #1
0xec7638: and      w9, w8, #1
0xec763c: and      w9, w9, w8
0xec7640: sturb    w9, [x29, #-1]
0xec7644: stur     w8, [x29, #-0x14]
0xec7648: b        #0xec77fc
0xec764c: adrp     x0, #0x2489000 ; ''
0xec7650: add      x0, x0, #0x2b5 ; 'MultiTalkMgr'
0xec7654: bl       #0xecb17c
0xec7658: mov      x29, x29
0xec765c: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7660: stur     x0, [x29, #-0x20]
0xec7664: ldur     x8, [x29, #-0x20]
0xec7668: str      x8, [sp, #0x20]
0xec766c: adrp     x0, #0x2645000
0xec7670: add      x0, x0, #0xd70 ; @'isMultiTalkActive'
0xec7674: bl       #0x2288728 ; _NSSelectorFromString
0xec7678: mov      x1, x0
0xec767c: ldr      x0, [sp, #0x20]
0xec7680: bl       #0xecb4dc
0xec7684: tbnz     w0, #0, #0xec76dc
0xec7688: b        #0xec768c
0xec768c: ldur     x8, [x29, #-0x20]
0xec7690: str      x8, [sp, #0x18]
0xec7694: adrp     x0, #0x2645000
0xec7698: add      x0, x0, #0xd90 ; @'isMultiTalkCalling'
0xec769c: bl       #0x2288728 ; _NSSelectorFromString
0xec76a0: mov      x1, x0
0xec76a4: ldr      x0, [sp, #0x18]
0xec76a8: bl       #0xecb4dc
0xec76ac: tbnz     w0, #0, #0xec76dc
0xec76b0: b        #0xec76b4
0xec76b4: ldur     x8, [x29, #-0x20]
0xec76b8: str      x8, [sp, #0x10]
0xec76bc: adrp     x0, #0x2645000
0xec76c0: add      x0, x0, #0xdb0 ; @'isMultiTalkConnected'
0xec76c4: bl       #0x2288728 ; _NSSelectorFromString
0xec76c8: mov      x1, x0
0xec76cc: ldr      x0, [sp, #0x10]
0xec76d0: bl       #0xecb4dc
0xec76d4: tbz      w0, #0, #0xec76f4
0xec76d8: b        #0xec76dc
0xec76dc: mov      w8, #1
0xec76e0: and      w9, w8, #1
0xec76e4: and      w9, w9, w8
0xec76e8: sturb    w9, [x29, #-1]
0xec76ec: stur     w8, [x29, #-0x14]
0xec76f0: b        #0xec77ec
0xec76f4: adrp     x8, #0x2752000
0xec76f8: ldr      x0, [x8, #0x500]
0xec76fc: adrp     x8, #0x271f000
0xec7700: ldr      x1, [x8, #0x6e8] ; @selector(sharedInstance) | 'sharedInstance'
0xec7704: adrp     x8, #0x25f4000
0xec7708: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec770c: blr      x8
0xec7710: mov      x29, x29
0xec7714: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7718: str      x0, [sp, #8]
0xec771c: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec7720: ldr      x1, [x8, #0x2c8] ; @selector(mode) | 'mode'
0xec7724: adrp     x8, #0x25f4000
0xec7728: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec772c: blr      x8
0xec7730: mov      x29, x29
0xec7734: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec7738: mov      x8, x0
0xec773c: ldr      x0, [sp, #8]
0xec7740: stur     x8, [x29, #-0x28]
0xec7744: adrp     x8, #0x25f4000
0xec7748: ldr      x8, [x8, #0x650] ; _objc_release
0xec774c: blr      x8
0xec7750: ldur     x0, [x29, #-0x28]
0xec7754: adrp     x8, #0x25f4000
0xec7758: ldr      x8, [x8, #0x4f8] ; _AVAudioSessionModeVoiceChat
0xec775c: ldr      x2, [x8]
0xec7760: adrp     x8, #0x271f000
0xec7764: ldr      x1, [x8, #0x680] ; @selector(isEqualToString:) | 'isEqualToString:'
0xec7768: adrp     x8, #0x25f4000
0xec776c: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec7770: blr      x8
0xec7774: tbnz     w0, #0, #0xec77a8
0xec7778: b        #0xec777c
0xec777c: ldur     x0, [x29, #-0x28]
0xec7780: adrp     x8, #0x25f4000
0xec7784: ldr      x8, [x8, #0x4f0] ; _AVAudioSessionModeVideoChat
0xec7788: ldr      x2, [x8]
0xec778c: adrp     x8, #0x271f000
0xec7790: ldr      x1, [x8, #0x680] ; @selector(isEqualToString:) | 'isEqualToString:'
0xec7794: adrp     x8, #0x25f4000
0xec7798: ldr      x8, [x8, #0x648] ; _objc_msgSend
0xec779c: blr      x8
0xec77a0: tbz      w0, #0, #0xec77c0
0xec77a4: b        #0xec77a8
0xec77a8: mov      w8, #1
0xec77ac: and      w9, w8, #1
0xec77b0: and      w9, w9, w8
0xec77b4: sturb    w9, [x29, #-1]
0xec77b8: stur     w8, [x29, #-0x14]
0xec77bc: b        #0xec77dc
0xec77c0: mov      w9, #0
0xec77c4: mov      w8, #1
0xec77c8: and      w9, w9, #1
0xec77cc: and      w9, w9, w8
0xec77d0: sturb    w9, [x29, #-1]
0xec77d4: stur     w8, [x29, #-0x14]
0xec77d8: b        #0xec77dc
0xec77dc: sub      x0, x29, #0x28
0xec77e0: mov      x1, #0
0xec77e4: bl       #0x2289118 ; _objc_storeStrong
0xec77e8: b        #0xec77ec
0xec77ec: sub      x0, x29, #0x20
0xec77f0: mov      x1, #0
0xec77f4: bl       #0x2289118 ; _objc_storeStrong
0xec77f8: b        #0xec77fc
0xec77fc: sub      x0, x29, #0x10
0xec7800: mov      x1, #0
0xec7804: bl       #0x2289118 ; _objc_storeStrong
0xec7808: ldurb    w8, [x29, #-1]
0xec780c: and      w0, w8, #1
0xec7810: ldp      x29, x30, [sp, #0x60]
0xec7814: add      sp, sp, #0x70
0xec7818: ret      
