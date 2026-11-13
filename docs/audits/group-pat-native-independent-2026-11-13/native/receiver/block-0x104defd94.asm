0x104defd94: mov      x8, x1
0x104defd98: ldp      x2, x3, [x0, #0x20]
0x104defd9c: ldr      x4, [x0, #0x30]
0x104defda0: adrp     x9, #0x11ea56000 ; @selector(notifyFriendAssistUnreadCountChanged)
0x104defda4: ldr      x1, [x9, #0x418] ; @selector(OnGetNewXmlMsg:Type:MsgWrap:) | 'OnGetNewXmlMsg:Type:MsgWrap:'
0x104defda8: mov      x0, x8
0x104defdac: b        #0x107c27c64 ; _objc_msgSend | selector=OnGetNewXmlMsg:Type:MsgWrap:
