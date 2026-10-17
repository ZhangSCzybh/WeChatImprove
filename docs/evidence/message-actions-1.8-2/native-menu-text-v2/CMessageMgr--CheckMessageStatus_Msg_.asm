
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b33820: d10143ff    	sub	sp, sp, #0x50
104b33824: a9015ff8    	stp	x24, x23, [sp, #0x10]
104b33828: a90257f6    	stp	x22, x21, [sp, #0x20]
104b3382c: a9034ff4    	stp	x20, x19, [sp, #0x30]
104b33830: a9047bfd    	stp	x29, x30, [sp, #0x40]
104b33834: 910103fd    	add	x29, sp, #0x40
104b33838: aa0303f4    	mov	x20, x3
104b3383c: aa0203f3    	mov	x19, x2
104b33840: aa0003f5    	mov	x21, x0
104b33844: f00e0848    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b33848: 52800029    	mov	w9, #0x1                ; =1
104b3384c: 39157109    	strb	w9, [x8, #0x55c]
104b33850: aa0203e0    	mov	x0, x2
104b33854: 94c3ce39    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b33858: aa1403e0    	mov	x0, x20
104b3385c: 94c3ce37    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b33860: 900d9848    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104b33864: f9450116    	ldr	x22, [x8, #0xa00] ; m_uiStatus
104b33868: aa1603e1    	mov	x1, x22
104b3386c: 94c3ce34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33870: 7100041f    	cmp	w0, #0x1
104b33874: 54000441    	b.ne	0x104b338fc <_Flutter_MMFoundation_BindContext+0x100f4e0>
104b33878: f00d98a8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b3387c: f941e501    	ldr	x1, [x8, #0x3c8] ; IsImgMsg
104b33880: aa1403e0    	mov	x0, x20
104b33884: 94c3ce2e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33888: 340003a0    	cbz	w0, 0x104b338fc <_Flutter_MMFoundation_BindContext+0x100f4e0>
104b3388c: b00d9b88    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b33890: f943e501    	ldr	x1, [x8, #0x7c8] ; IsImageMsgUploadIng:
104b33894: aa1503e0    	mov	x0, x21
104b33898: aa1403e2    	mov	x2, x20
104b3389c: 94c3ce28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b338a0: 37001520    	tbnz	w0, #0x0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b338a4: 900db208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b338a8: f9453516    	ldr	x22, [x8, #0xa68] ; �gH 
104b338ac: b00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b338b0: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b338b4: aa1403e0    	mov	x0, x20
104b338b8: 94c3ce21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b338bc: d00d9828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b338c0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b338c4: b00ce388    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b338c8: 912fa108    	add	x8, x8, #0xbe8
104b338cc: a90003e8    	stp	x8, x0, [sp]
104b338d0: b00b6645    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b338d4: 910cb4a5    	add	x5, x5, #0x32d
104b338d8: d00b6647    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b338dc: 911f9ce7    	add	x7, x7, #0x7e7
104b338e0: aa1603e0    	mov	x0, x22
104b338e4: 52800042    	mov	w2, #0x2                ; =2
104b338e8: d2800003    	mov	x3, #0x0                ; =0
104b338ec: 52800004    	mov	w4, #0x0                ; =0
104b338f0: 528123c6    	mov	w6, #0x91e              ; =2334
104b338f4: 94c3ce12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b338f8: 1400002c    	b	0x104b339a8 <_Flutter_MMFoundation_BindContext+0x100f58c>
104b338fc: aa1403e0    	mov	x0, x20
104b33900: aa1603e1    	mov	x1, x22
104b33904: 94c3ce0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33908: 7100041f    	cmp	w0, #0x1
104b3390c: 54000181    	b.ne	0x104b3393c <_Flutter_MMFoundation_BindContext+0x100f520>
104b33910: b00db208    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b33914: f9411d00    	ldr	x0, [x8, #0x238] ; @�7 
104b33918: d00d9a68    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104b3391c: f9428901    	ldr	x1, [x8, #0x510] ; IsRecordOrNoteMsg:
104b33920: aa1403e2    	mov	x2, x20
104b33924: 94c3ce06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33928: 340000a0    	cbz	w0, 0x104b3393c <_Flutter_MMFoundation_BindContext+0x100f520>
104b3392c: f00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b33930: f9435101    	ldr	x1, [x8, #0x6a0] ; IsRecordMsgUploading:
104b33934: aa1503e0    	mov	x0, x21
104b33938: 14000019    	b	0x104b3399c <_Flutter_MMFoundation_BindContext+0x100f580>
104b3393c: aa1403e0    	mov	x0, x20
104b33940: aa1603e1    	mov	x1, x22
104b33944: 94c3cdfe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33948: 7100041f    	cmp	w0, #0x1
104b3394c: 540004c1    	b.ne	0x104b339e4 <_Flutter_MMFoundation_BindContext+0x100f5c8>
104b33950: f00d9848    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b33954: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104b33958: aa1403e0    	mov	x0, x20
104b3395c: 94c3cdf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33960: 7100bc1f    	cmp	w0, #0x2f
104b33964: 54000401    	b.ne	0x104b339e4 <_Flutter_MMFoundation_BindContext+0x100f5c8>
104b33968: 900db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b3396c: b9897108    	ldrsw	x8, [x8, #0x970]
104b33970: f8686aa0    	ldr	x0, [x21, x8]
104b33974: d00d9968    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b33978: f943a116    	ldr	x22, [x8, #0x740] ; IsMsgInUploadQueue:
104b3397c: aa1603e1    	mov	x1, x22
104b33980: aa1403e2    	mov	x2, x20
104b33984: 94c3cdee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33988: 37000de0    	tbnz	w0, #0x0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b3398c: 900db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b33990: b9897908    	ldrsw	x8, [x8, #0x978]
104b33994: f8686aa0    	ldr	x0, [x21, x8]
104b33998: aa1603e1    	mov	x1, x22
104b3399c: aa1403e2    	mov	x2, x20
104b339a0: 94c3cde7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b339a4: 37000d00    	tbnz	w0, #0x0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b339a8: b00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b339ac: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
104b339b0: aa1403e0    	mov	x0, x20
104b339b4: 528000a2    	mov	w2, #0x5                ; =5
104b339b8: 94c3cde1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b339bc: 900db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b339c0: b9895508    	ldrsw	x8, [x8, #0x954]
104b339c4: f8686aa0    	ldr	x0, [x21, x8]
104b339c8: 900d9868    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b339cc: f9467501    	ldr	x1, [x8, #0xce8] ; ModMsgByBitSet:MsgWrap:BitSet:
104b339d0: aa1303e2    	mov	x2, x19
104b339d4: aa1403e3    	mov	x3, x20
104b339d8: 52800024    	mov	w4, #0x1                ; =1
104b339dc: 94c3cdd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b339e0: 14000059    	b	0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b339e4: 900d9908    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104b339e8: f9416d01    	ldr	x1, [x8, #0x2d8] ; IsVideoMsg
104b339ec: aa1403e0    	mov	x0, x20
104b339f0: 94c3cdd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b339f4: 340000e0    	cbz	w0, 0x104b33a10 <_Flutter_MMFoundation_BindContext+0x100f5f4>
104b339f8: f00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b339fc: f9435501    	ldr	x1, [x8, #0x6a8] ; UpdateVideoStatus:
104b33a00: aa1503e0    	mov	x0, x21
104b33a04: aa1403e2    	mov	x2, x20
104b33a08: 94c3cdcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a0c: 1400004e    	b	0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33a10: f00d9848    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b33a14: f9413d17    	ldr	x23, [x8, #0x278] ; m_uiMessageType
104b33a18: aa1403e0    	mov	x0, x20
104b33a1c: aa1703e1    	mov	x1, x23
104b33a20: 94c3cdc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a24: 7100c41f    	cmp	w0, #0x31
104b33a28: 540001c1    	b.ne	0x104b33a60 <_Flutter_MMFoundation_BindContext+0x100f644>
104b33a2c: b00d9b88    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b33a30: f943e901    	ldr	x1, [x8, #0x7d0] ; InAppAttachDownloading:MsgWrap:
104b33a34: aa1503e0    	mov	x0, x21
104b33a38: aa1303e2    	mov	x2, x19
104b33a3c: aa1403e3    	mov	x3, x20
104b33a40: 94c3cdbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a44: 340006c0    	cbz	w0, 0x104b33b1c <_Flutter_MMFoundation_BindContext+0x100f700>
104b33a48: 900d9868    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b33a4c: f9413901    	ldr	x1, [x8, #0x270] ; setM_uiDownloadStatus:
104b33a50: aa1403e0    	mov	x0, x20
104b33a54: 52800022    	mov	w2, #0x1                ; =1
104b33a58: 94c3cdb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a5c: 1400003a    	b	0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33a60: aa1403e0    	mov	x0, x20
104b33a64: aa1603e1    	mov	x1, x22
104b33a68: 94c3cdb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a6c: 7100041f    	cmp	w0, #0x1
104b33a70: 540006a1    	b.ne	0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33a74: aa1403e0    	mov	x0, x20
104b33a78: aa1703e1    	mov	x1, x23
104b33a7c: 94c3cdb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a80: 7100041f    	cmp	w0, #0x1
104b33a84: 54000601    	b.ne	0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33a88: d00d9968    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b33a8c: f9452d01    	ldr	x1, [x8, #0xa58] ; IsBypassMessage
104b33a90: aa1403e0    	mov	x0, x20
104b33a94: 94c3cdaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33a98: 34000560    	cbz	w0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33a9c: 900db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b33aa0: b9895908    	ldrsw	x8, [x8, #0x958]
104b33aa4: f8686aa0    	ldr	x0, [x21, x8]
104b33aa8: d00d9968    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b33aac: f9444901    	ldr	x1, [x8, #0x890] ; IsMsgInSendQueue:
104b33ab0: aa1403e2    	mov	x2, x20
104b33ab4: 94c3cda2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33ab8: 37000460    	tbnz	w0, #0x0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33abc: f00db208    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b33ac0: f9455d00    	ldr	x0, [x8, #0xab8]
104b33ac4: b00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b33ac8: f9448d01    	ldr	x1, [x8, #0x918] ; shared
104b33acc: 94c3cd9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33ad0: aa1d03fd    	mov	x29, x29
104b33ad4: 94c3cd9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b33ad8: aa0003f5    	mov	x21, x0
104b33adc: f00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b33ae0: f9446d01    	ldr	x1, [x8, #0x8d8] ; logicForMessage:
104b33ae4: aa1403e2    	mov	x2, x20
104b33ae8: 94c3cd95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33aec: aa1d03fd    	mov	x29, x29
104b33af0: 94c3cd96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b33af4: aa0003f6    	mov	x22, x0
104b33af8: 94c3cd97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b33afc: aa1503e0    	mov	x0, x21
104b33b00: 94c3cd95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b33b04: b5000216    	cbnz	x22, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33b08: b00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b33b0c: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
104b33b10: aa1403e0    	mov	x0, x20
104b33b14: 528000a2    	mov	w2, #0x5                ; =5
104b33b18: 17ffffd0    	b	0x104b33a58 <_Flutter_MMFoundation_BindContext+0x100f63c>
104b33b1c: f00d9848    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b33b20: f9452d01    	ldr	x1, [x8, #0xa58] ; IsFileMsg
104b33b24: aa1403e0    	mov	x0, x20
104b33b28: 94c3cd85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33b2c: 370000c0    	tbnz	w0, #0x0, 0x104b33b44 <_Flutter_MMFoundation_BindContext+0x100f728>
104b33b30: 900d9868    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b33b34: f9432501    	ldr	x1, [x8, #0x648] ; IsFileUploadingMsg
104b33b38: aa1403e0    	mov	x0, x20
104b33b3c: 94c3cd80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b33b40: 36000140    	tbz	w0, #0x0, 0x104b33b68 <_Flutter_MMFoundation_BindContext+0x100f74c>
104b33b44: aa1403e0    	mov	x0, x20
104b33b48: 94c3cd83    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b33b4c: aa1303e0    	mov	x0, x19
104b33b50: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104b33b54: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104b33b58: a94257f6    	ldp	x22, x21, [sp, #0x20]
104b33b5c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104b33b60: 910143ff    	add	sp, sp, #0x50
104b33b64: 14c3cd7c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b33b68: 900d9868    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b33b6c: f9413901    	ldr	x1, [x8, #0x270] ; setM_uiDownloadStatus:
104b33b70: aa1403e0    	mov	x0, x20
104b33b74: 52800002    	mov	w2, #0x0                ; =0
104b33b78: 17ffffb8    	b	0x104b33a58 <_Flutter_MMFoundation_BindContext+0x100f63c>