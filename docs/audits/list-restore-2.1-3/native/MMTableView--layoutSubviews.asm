
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116729e84: d10343ff    	sub	sp, sp, #0xd0
116729e88: 6d0823e9    	stp	d9, d8, [sp, #0x80]
116729e8c: a9095ff8    	stp	x24, x23, [sp, #0x90]
116729e90: a90a57f6    	stp	x22, x21, [sp, #0xa0]
116729e94: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
116729e98: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
116729e9c: 910303fd    	add	x29, sp, #0xc0
116729ea0: aa0003f3    	mov	x19, x0
116729ea4: b004d588    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
116729ea8: f945c508    	ldr	x8, [x8, #0xb88] ; MMTableView
116729eac: a93b23a0    	stp	x0, x8, [x29, #-0x50]
116729eb0: b004b8a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
116729eb4: f940a901    	ldr	x1, [x8, #0x150] ; layoutSubviews
116729eb8: d10143a0    	sub	x0, x29, #0x50
116729ebc: 946fff8f    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116729ec0: d004b888    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
116729ec4: f945a901    	ldr	x1, [x8, #0xb50] ; reloadIndexView
116729ec8: aa1303e0    	mov	x0, x19
116729ecc: 946fff88    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729ed0: f004ce08    	adrp	x8, 0x1200ec000 <dyld_stub_binder+0x1200ec000>
116729ed4: f945fd14    	ldr	x20, [x8, #0xbf8] ; singleSelectedIndexPath
116729ed8: aa1303e0    	mov	x0, x19
116729edc: aa1403e1    	mov	x1, x20
116729ee0: 946fff83    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729ee4: aa1d03fd    	mov	x29, x29
116729ee8: 946fffab    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116729eec: aa0003f5    	mov	x21, x0
116729ef0: 946fff9a    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116729ef4: b40010b5    	cbz	x21, 0x11672a108 <_O266DecReleaseOutputPicture+0x349d650>
116729ef8: aa1303e0    	mov	x0, x19
116729efc: aa1403e1    	mov	x1, x20
116729f00: 946fff7b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729f04: aa1d03fd    	mov	x29, x29
116729f08: 946fffa3    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116729f0c: aa0003f5    	mov	x21, x0
116729f10: f004b888    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
116729f14: f9416101    	ldr	x1, [x8, #0x2c0] ; cellForRowAtIndexPath:
116729f18: aa1303e0    	mov	x0, x19
116729f1c: aa1503e2    	mov	x2, x21
116729f20: 946fff73    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729f24: aa1d03fd    	mov	x29, x29
116729f28: 946fff9b    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116729f2c: aa0003f4    	mov	x20, x0
116729f30: aa1503e0    	mov	x0, x21
116729f34: 946fff89    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116729f38: 9004cf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116729f3c: f9444d01    	ldr	x1, [x8, #0x898] ; setSelected:
116729f40: aa1403e0    	mov	x0, x20
116729f44: 52800022    	mov	w2, #0x1                ; =1
116729f48: 946fff69    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729f4c: b004b908    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
116729f50: f9452d01    	ldr	x1, [x8, #0xa58] ; attachWeakObject:forKey:
116729f54: f00421e3    	adrp	x3, 0x11eb68000 <dyld_stub_binder+0x11eb68000>
116729f58: 91122063    	add	x3, x3, #0x488 ; CFString 'selectedCell'
116729f5c: aa1303e0    	mov	x0, x19
116729f60: aa1403e2    	mov	x2, x20
116729f64: 946fff62    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729f68: b004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116729f6c: f9444501    	ldr	x1, [x8, #0x888] ; shouldSelectedCellRecoverAnimated
116729f70: aa1303e0    	mov	x0, x19
116729f74: 946fff5e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729f78: 34000c40    	cbz	w0, 0x11672a100 <_O266DecReleaseOutputPicture+0x349d648>
116729f7c: 9004d468    	adrp	x8, 0x1201b5000 <dyld_stub_binder+0x1201b5000>
116729f80: f9410d00    	ldr	x0, [x8, #0x218] ; _TtC7WCUIKit21AnimateProgressRunner
116729f84: 946fff03    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
116729f88: aa0003f5    	mov	x21, x0
116729f8c: b004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116729f90: f9444901    	ldr	x1, [x8, #0x890] ; setProgressRunner:
116729f94: aa1303e0    	mov	x0, x19
116729f98: aa1503e2    	mov	x2, x21
116729f9c: 946fff54    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116729fa0: aa1503e0    	mov	x0, x21
116729fa4: 946fff6d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116729fa8: d10163a0    	sub	x0, x29, #0x58
116729fac: aa1403e1    	mov	x1, x20
116729fb0: 946fff3d    	bl	0x118329ca4 <dyld_stub_binder+0x118329ca4>
116729fb4: b0037638    	adrp	x24, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
116729fb8: f947e318    	ldr	x24, [x24, #0xfc0]
116729fbc: f90023f8    	str	x24, [sp, #0x40]
116729fc0: 900132c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
116729fc4: fd41c108    	ldr	d8, [x8, #0x380]
116729fc8: b0000008    	adrp	x8, 0x11672a000 <_O266DecReleaseOutputPicture+0x349d548>
116729fcc: 91049108    	add	x8, x8, #0x124
116729fd0: fd0027e8    	str	d8, [sp, #0x48]
116729fd4: 90037729    	adrp	x9, 0x11d60d000 <dyld_stub_binder+0x11d60d000>
116729fd8: 912ca129    	add	x9, x9, #0xb28
116729fdc: a90527e8    	stp	x8, x9, [sp, #0x50]
116729fe0: 910103f7    	add	x23, sp, #0x40
116729fe4: 910082e0    	add	x0, x23, #0x20
116729fe8: d10163a1    	sub	x1, x29, #0x58
116729fec: 946fff0a    	bl	0x118329c14 <dyld_stub_binder+0x118329c14>
116729ff0: b004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116729ff4: f9444d15    	ldr	x21, [x8, #0x898] ; progressRunner
116729ff8: aa1303e0    	mov	x0, x19
116729ffc: aa1503e1    	mov	x1, x21
11672a000: 946fff3b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a004: aa1d03fd    	mov	x29, x29
11672a008: 946fff63    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11672a00c: aa0003f6    	mov	x22, x0
11672a010: 9004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
11672a014: f9445101    	ldr	x1, [x8, #0x8a0] ; setUpdateProgress:
11672a018: 910103e2    	add	x2, sp, #0x40
11672a01c: 946fff34    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a020: aa1603e0    	mov	x0, x22
11672a024: 946fff4d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672a028: 9100e3e0    	add	x0, sp, #0x38
11672a02c: aa1303e1    	mov	x1, x19
11672a030: 946fff1d    	bl	0x118329ca4 <dyld_stub_binder+0x118329ca4>
11672a034: f90007f8    	str	x24, [sp, #0x8]
11672a038: 90000008    	adrp	x8, 0x11672a000 <_O266DecReleaseOutputPicture+0x349d548>
11672a03c: 91069108    	add	x8, x8, #0x1a4
11672a040: fd000be8    	str	d8, [sp, #0x10]
11672a044: f0037849    	adrp	x9, 0x11d635000 <dyld_stub_binder+0x11d635000>
11672a048: 910b6129    	add	x9, x9, #0x2d8
11672a04c: a901a7e8    	stp	x8, x9, [sp, #0x18]
11672a050: 910023f8    	add	x24, sp, #0x8
11672a054: 91008300    	add	x0, x24, #0x20
11672a058: 9100e3e1    	add	x1, sp, #0x38
11672a05c: 946ffeee    	bl	0x118329c14 <dyld_stub_binder+0x118329c14>
11672a060: 9100a300    	add	x0, x24, #0x28
11672a064: d10163a1    	sub	x1, x29, #0x58
11672a068: 946ffeeb    	bl	0x118329c14 <dyld_stub_binder+0x118329c14>
11672a06c: aa1303e0    	mov	x0, x19
11672a070: aa1503e1    	mov	x1, x21
11672a074: 946fff1e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a078: aa1d03fd    	mov	x29, x29
11672a07c: 946fff46    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11672a080: aa0003f6    	mov	x22, x0
11672a084: b004bce8    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
11672a088: f9462901    	ldr	x1, [x8, #0xc50] ; setComplete:
11672a08c: 910023e2    	add	x2, sp, #0x8
11672a090: 946fff17    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a094: aa1603e0    	mov	x0, x22
11672a098: 946fff30    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672a09c: aa1303e0    	mov	x0, x19
11672a0a0: aa1503e1    	mov	x1, x21
11672a0a4: 946fff12    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a0a8: aa1d03fd    	mov	x29, x29
11672a0ac: 946fff3a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11672a0b0: aa0003f3    	mov	x19, x0
11672a0b4: 9004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
11672a0b8: f9445501    	ldr	x1, [x8, #0x8a8] ; startWithTimePassed:totalTime:reverse:
11672a0bc: f00132a8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
11672a0c0: fd429901    	ldr	d1, [x8, #0x530]
11672a0c4: 9e6703e0    	fmov	d0, xzr
11672a0c8: 52800002    	mov	w2, #0x0                ; =0
11672a0cc: 946fff08    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672a0d0: aa1303e0    	mov	x0, x19
11672a0d4: 946fff21    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672a0d8: 9100a300    	add	x0, x24, #0x28
11672a0dc: 946ffed1    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
11672a0e0: 91008300    	add	x0, x24, #0x20
11672a0e4: 946ffecf    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
11672a0e8: 9100e3e0    	add	x0, sp, #0x38
11672a0ec: 946ffecd    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
11672a0f0: 910082e0    	add	x0, x23, #0x20
11672a0f4: 946ffecb    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
11672a0f8: d10163a0    	sub	x0, x29, #0x58
11672a0fc: 946ffec9    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
11672a100: aa1403e0    	mov	x0, x20
11672a104: 946fff15    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672a108: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
11672a10c: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
11672a110: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
11672a114: a9495ff8    	ldp	x24, x23, [sp, #0x90]
11672a118: 6d4823e9    	ldp	d9, d8, [sp, #0x80]
11672a11c: 910343ff    	add	sp, sp, #0xd0
11672a120: d65f03c0    	ret
