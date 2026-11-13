-[NewSyncService NotifyToSync] 0x105462d98 B16@0:8
0x105462d98: adrp     x8, #0x11edca000
0x105462d9c: ldrsw    x8, [x8, #0x8f8] ; ivar_offset NewSyncService.m_uiSyncScene=0x10
0x105462da0: ldr      w2, [x0, x8]
0x105462da4: adrp     x8, #0x11eb3a000 ; @selector(showToastForSetValueFromRecommendSystemMsg)
0x105462da8: ldr      x1, [x8, #0xc10] ; @selector(InternalCreateSync:) | 'InternalCreateSync:'
0x105462dac: b        #0x107c27c64 ; _objc_msgSend | selector=InternalCreateSync:
