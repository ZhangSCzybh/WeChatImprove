+[ThreadQueue RunWithTarget:selector:object:] 0x1131fd574
0x1131fd574: sub      sp, sp, #0x40
0x1131fd578: stp      x22, x21, [sp, #0x10]
0x1131fd57c: stp      x20, x19, [sp, #0x20]
0x1131fd580: stp      x29, x30, [sp, #0x30]
0x1131fd584: add      x29, sp, #0x30
0x1131fd588: mov      x20, x4
0x1131fd58c: mov      x21, x3
0x1131fd590: mov      x22, x2
0x1131fd594: add      x0, sp, #8
0x1131fd598: bl       #0x113201918
0x1131fd59c: adrp     x8, #0x11ed52000 ; classref TPPreloadProxyInternalDelegate
0x1131fd5a0: ldr      x0, [x8, #0x210] ; classref __ThreadWarp | Class __ThreadWarp
0x1131fd5a4: bl       #0x116e5c3e8 ; _objc_alloc_init
0x1131fd5a8: mov      x19, x0
0x1131fd5ac: adrp     x8, #0x11ec73000 ; @selector(eventTrackingPublisher)
0x1131fd5b0: ldr      x1, [x8, #0xb08] ; @selector(setM_target:) | 'setM_target:'
0x1131fd5b4: mov      x2, x22
0x1131fd5b8: bl       #0x116e5c544 ; _objc_msgSend | selector=setM_target:
0x1131fd5bc: adrp     x8, #0x11ec73000 ; @selector(eventTrackingPublisher)
0x1131fd5c0: ldr      x1, [x8, #0xb18] ; @selector(setM_sel:) | 'setM_sel:'
0x1131fd5c4: mov      x0, x19
0x1131fd5c8: mov      x2, x21
0x1131fd5cc: bl       #0x116e5c544 ; _objc_msgSend | selector=setM_sel:
0x1131fd5d0: adrp     x8, #0x11ec73000 ; @selector(eventTrackingPublisher)
0x1131fd5d4: ldr      x1, [x8, #0xb10] ; @selector(setM_arg:) | 'setM_arg:'
0x1131fd5d8: mov      x0, x19
0x1131fd5dc: mov      x2, x20
0x1131fd5e0: bl       #0x116e5c544 ; _objc_msgSend | selector=setM_arg:
0x1131fd5e4: adrp     x8, #0x11ed31000 ; classref SWTranscoding
0x1131fd5e8: ldr      x0, [x8, #0x7d8] ; _OBJC_CLASS_$_NSInvocationOperation
0x1131fd5ec: bl       #0x116e5c3d0 ; _objc_alloc
0x1131fd5f0: adrp     x8, #0x11ec73000 ; @selector(eventTrackingPublisher)
0x1131fd5f4: ldr      x3, [x8, #0xb20] ; @selector(Run) | 'Run'
0x1131fd5f8: adrp     x8, #0x11eca8000 ; @selector(imageWithData:scale:)
0x1131fd5fc: ldr      x1, [x8, #0x4d8] ; @selector(initWithTarget:selector:object:) | 'initWithTarget:selector:object:'
0x1131fd600: mov      x2, x19
0x1131fd604: mov      x4, #0
0x1131fd608: bl       #0x116e5c544 ; _objc_msgSend | selector=initWithTarget:selector:object:
0x1131fd60c: mov      x20, x0
0x1131fd610: cbz      x0, #0x1131fd634
0x1131fd614: adrp     x8, #0x11fb1c000
0x1131fd618: ldr      x0, [x8, #0xc38]
0x1131fd61c: adrp     x8, #0x11ea09000 ; @selector(contactTagDataStorageInfo)
0x1131fd620: ldr      x1, [x8, #0x978] ; @selector(addOperation:) | 'addOperation:'
0x1131fd624: mov      x2, x20
0x1131fd628: bl       #0x116e5c544 ; _objc_msgSend | selector=addOperation:
0x1131fd62c: mov      x0, x20
0x1131fd630: bl       #0x116e5c5bc ; _objc_release
0x1131fd634: mov      x0, x19
0x1131fd638: bl       #0x116e5c5bc ; _objc_release
0x1131fd63c: cmp      x20, #0
0x1131fd640: cset     w19, ne
0x1131fd644: add      x0, sp, #8
0x1131fd648: bl       #0x11320196c
0x1131fd64c: mov      x0, x19
0x1131fd650: ldp      x29, x30, [sp, #0x30]
0x1131fd654: ldp      x20, x19, [sp, #0x20]
0x1131fd658: ldp      x22, x21, [sp, #0x10]
0x1131fd65c: add      sp, sp, #0x40
0x1131fd660: ret      
0x1131fd664: b        #0x1131fd668
0x1131fd668: mov      x19, x0
0x1131fd66c: add      x0, sp, #8
0x1131fd670: bl       #0x11320196c
0x1131fd674: mov      x0, x19
0x1131fd678: bl       #0x116e52ce0 ; __Unwind_Resume
