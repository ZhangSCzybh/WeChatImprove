-[NewSyncService checkNeedSync] 0x10546359c v16@0:8
0x10546359c: adrp     x8, #0x11edca000
0x1054635a0: ldrsw    x8, [x8, #0x8d4] ; ivar_offset NewSyncService.m_bNeedSync=0x57
0x1054635a4: ldrb     w8, [x0, x8]
0x1054635a8: cmp      w8, #1
0x1054635ac: b.ne     #0x1054635bc
0x1054635b0: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x1054635b4: ldr      x1, [x8, #0xc18] ; @selector(NotifyToSync) | 'NotifyToSync'
0x1054635b8: b        #0x107c27c64 ; _objc_msgSend | selector=NotifyToSync
0x1054635bc: ret      
