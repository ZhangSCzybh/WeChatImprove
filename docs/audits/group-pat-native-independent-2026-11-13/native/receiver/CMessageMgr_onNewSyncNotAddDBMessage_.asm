-[CMessageMgr onNewSyncNotAddDBMessage:] 0x104df1718 v24@0:8@16
0x104df1718: stp      x22, x21, [sp, #-0x30]!
0x104df171c: stp      x20, x19, [sp, #0x10]
0x104df1720: stp      x29, x30, [sp, #0x20]
0x104df1724: add      x29, sp, #0x20
0x104df1728: mov      x19, x2
0x104df172c: mov      x20, x0
0x104df1730: adrp     x8, #0x11f751000
0x104df1734: mov      w9, #1
0x104df1738: strb     w9, [x8, #0xc56]
0x104df173c: mov      x0, x2
0x104df1740: bl       #0x107c27c74 ; _objc_retain
0x104df1744: cbz      x19, #0x104df1840
0x104df1748: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104df174c: ldr      x1, [x8, #0x70] ; @selector(GetChatName) | 'GetChatName'
0x104df1750: mov      x0, x19
0x104df1754: bl       #0x107c27c64 ; _objc_msgSend | selector=GetChatName
0x104df1758: mov      x29, x29
0x104df175c: bl       #0x107c27c80 ; _objc_retainAutoreleasedReturnValue
0x104df1760: mov      x21, x0
0x104df1764: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104df1768: ldr      x1, [x8, #0x3b8] ; @selector(AsyncOnNotAddDBMessage:MsgWrap:) | 'AsyncOnNotAddDBMessage:MsgWrap:'
0x104df176c: mov      x0, x20
0x104df1770: mov      x2, x21
0x104df1774: mov      x3, x19
0x104df1778: bl       #0x107c27c64 ; _objc_msgSend | selector=AsyncOnNotAddDBMessage:MsgWrap:
0x104df177c: adrp     x8, #0x11e9ce000 ; @selector(onAddMsg:roomID:)
0x104df1780: ldr      x22, [x8, #0x3f0] ; @selector(m_uiMessageType) | 'm_uiMessageType'
0x104df1784: mov      x0, x19
0x104df1788: mov      x1, x22 ; 'm_uiMessageType'
0x104df178c: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x104df1790: mov      w8, #0x2712
0x104df1794: cmp      w0, w8
0x104df1798: b.ne     #0x104df17b4
0x104df179c: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104df17a0: ldr      x1, [x8, #0x3c0] ; @selector(HandleSvrCmd:MsgWrap:) | 'HandleSvrCmd:MsgWrap:'
0x104df17a4: mov      x0, x20
0x104df17a8: mov      x2, x21
0x104df17ac: mov      x3, x19
0x104df17b0: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleSvrCmd:MsgWrap:
0x104df17b4: mov      x0, x19
0x104df17b8: mov      x1, x22 ; 'm_uiMessageType'
0x104df17bc: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x104df17c0: cmp      w0, #0x31
0x104df17c4: b.ne     #0x104df17e0
0x104df17c8: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104df17cc: ldr      x1, [x8, #0x398] ; @selector(HandleAppMsg:MsgWrap:) | 'HandleAppMsg:MsgWrap:'
0x104df17d0: mov      x0, x20
0x104df17d4: mov      x2, x21
0x104df17d8: mov      x3, x19
0x104df17dc: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleAppMsg:MsgWrap:
0x104df17e0: mov      x0, x19
0x104df17e4: mov      x1, x22 ; 'm_uiMessageType'
0x104df17e8: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x104df17ec: cmp      w0, #0x2b
0x104df17f0: b.ne     #0x104df180c
0x104df17f4: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104df17f8: ldr      x1, [x8, #0x3a0] ; @selector(HandleVideoMsg:MsgWrap:) | 'HandleVideoMsg:MsgWrap:'
0x104df17fc: mov      x0, x20
0x104df1800: mov      x2, x21
0x104df1804: mov      x3, x19
0x104df1808: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleVideoMsg:MsgWrap:
0x104df180c: mov      x0, x19
0x104df1810: mov      x1, x22 ; 'm_uiMessageType'
0x104df1814: bl       #0x107c27c64 ; _objc_msgSend | selector=m_uiMessageType
0x104df1818: cmp      w0, #0x32
0x104df181c: b.ne     #0x104df1838
0x104df1820: adrp     x8, #0x11eb24000 ; @selector(setM_firstSendTime:)
0x104df1824: ldr      x1, [x8, #0x3c8] ; @selector(HandleVoipMsg:MsgWrap:) | 'HandleVoipMsg:MsgWrap:'
0x104df1828: mov      x0, x20
0x104df182c: mov      x2, x21
0x104df1830: mov      x3, x19
0x104df1834: bl       #0x107c27c64 ; _objc_msgSend | selector=HandleVoipMsg:MsgWrap:
0x104df1838: mov      x0, x21
0x104df183c: bl       #0x107c27c70 ; _objc_release
0x104df1840: mov      x0, x19
0x104df1844: ldp      x29, x30, [sp, #0x20]
0x104df1848: ldp      x20, x19, [sp, #0x10]
0x104df184c: ldp      x22, x21, [sp], #0x30 ; 'm_uiMessageType'
0x104df1850: b        #0x107c27c70 ; _objc_release
