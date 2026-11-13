+[WCRefineBackgroundKeepAlive load] 0xec73ac v16@0:8
0xec73ac: sub      sp, sp, #0x40
0xec73b0: stp      x29, x30, [sp, #0x30]
0xec73b4: add      x29, sp, #0x30
0xec73b8: stur     x0, [x29, #-8]
0xec73bc: stur     x1, [x29, #-0x10]
0xec73c0: adrp     x0, #0x2469000 ; 'ndler:'
0xec73c4: add      x0, x0, #0xcc5 ; 'MicroMessengerAppDelegate'
0xec73c8: bl       #0x2289010 ; _objc_getClass
0xec73cc: str      x0, [sp, #0x18]
0xec73d0: ldr      x8, [sp, #0x18]
0xec73d4: cbz      x8, #0xec7400
0xec73d8: b        #0xec73dc
0xec73dc: ldr      x0, [sp, #0x18]
0xec73e0: adrp     x8, #0x272e000 ; @selector(persistUsageCache)
0xec73e4: ldr      x1, [x8, #0xf8] ; @selector(applicationWillTerminate:) | 'applicationWillTerminate:'
0xec73e8: adrp     x2, #0xec7000
0xec73ec: add      x2, x2, #0x448
0xec73f0: adrp     x3, #0x295b000
0xec73f4: add      x3, x3, #0x528
0xec73f8: bl       #0x22886d4 ; _MSHookMessageEx
0xec73fc: b        #0xec7400
0xec7400: adrp     x0, #0x25f4000
0xec7404: ldr      x0, [x0, #0x6a0] ; __dispatch_main_q
0xec7408: str      x0, [sp, #8]
0xec740c: bl       #0x22890c4 ; _objc_retainAutoreleaseReturnValue
0xec7410: ldr      x0, [sp, #8]
0xec7414: mov      x29, x29
0xec7418: bl       #0x22890d0 ; _objc_retainAutoreleasedReturnValue
0xec741c: str      x0, [sp, #0x10]
0xec7420: adrp     x1, #0x25fd000
0xec7424: add      x1, x1, #0xe58
0xec7428: bl       #0x2288bcc ; _dispatch_async
0xec742c: ldr      x0, [sp, #0x10]
0xec7430: adrp     x8, #0x25f4000
0xec7434: ldr      x8, [x8, #0x650] ; _objc_release
0xec7438: blr      x8
0xec743c: ldp      x29, x30, [sp, #0x30]
0xec7440: add      sp, sp, #0x40
0xec7444: ret      
