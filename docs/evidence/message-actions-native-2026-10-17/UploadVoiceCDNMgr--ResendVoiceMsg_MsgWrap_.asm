
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f63024: d10283ff    	sub	sp, sp, #0xa0
105f63028: a9046ffc    	stp	x28, x27, [sp, #0x40]
105f6302c: a90567fa    	stp	x26, x25, [sp, #0x50]
105f63030: a9065ff8    	stp	x24, x23, [sp, #0x60]
105f63034: a90757f6    	stp	x22, x21, [sp, #0x70]
105f63038: a9084ff4    	stp	x20, x19, [sp, #0x80]
105f6303c: a9097bfd    	stp	x29, x30, [sp, #0x90]
105f63040: 910243fd    	add	x29, sp, #0x90
105f63044: aa0303f4    	mov	x20, x3
105f63048: aa0203f3    	mov	x19, x2
105f6304c: aa0003f5    	mov	x21, x0
105f63050: 900d6708    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
105f63054: 52800029    	mov	w9, #0x1                ; =1
105f63058: 39038509    	strb	w9, [x8, #0xe1]
105f6305c: aa0203e0    	mov	x0, x2
105f63060: 94731036    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f63064: aa1403e0    	mov	x0, x20
105f63068: 94731034    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f6306c: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f63070: f9456519    	ldr	x25, [x8, #0xac8] ; m_dtVoice
105f63074: aa1903e1    	mov	x1, x25
105f63078: 94731031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f6307c: aa1d03fd    	mov	x29, x29
105f63080: 94731032    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f63084: aa0003f6    	mov	x22, x0
105f63088: 900d0d08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105f6308c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
105f63090: 9473102b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63094: aa0003f7    	mov	x23, x0
105f63098: aa1603e0    	mov	x0, x22
105f6309c: 9473102e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f630a0: 340006d7    	cbz	w23, 0x105f63178 <_Flutter_MMFoundation_BindContext+0x243ed5c>
105f630a4: 900d1088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f630a8: f9454516    	ldr	x22, [x8, #0xa88]
105f630ac: b00cf6c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105f630b0: f947d118    	ldr	x24, [x8, #0xfa0] ; m_uiMesLocalID
105f630b4: aa1403e0    	mov	x0, x20
105f630b8: aa1803e1    	mov	x1, x24
105f630bc: 94731020    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f630c0: f00d0d28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f630c4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
105f630c8: a90003f3    	stp	x19, x0, [sp]
105f630cc: d00c2f02    	adrp	x2, 0x11e545000 <dyld_stub_binder+0x11e545000>
105f630d0: 9134a042    	add	x2, x2, #0xd28
105f630d4: aa1603e0    	mov	x0, x22
105f630d8: 94731019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f630dc: aa1d03fd    	mov	x29, x29
105f630e0: 9473101a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f630e4: aa0003f6    	mov	x22, x0
105f630e8: d00d0328    	adrp	x8, 0x11ffc9000 <dyld_stub_binder+0x11ffc9000>
105f630ec: f9458901    	ldr	x1, [x8, #0xb10] ; readyUploadItems
105f630f0: aa1503e0    	mov	x0, x21
105f630f4: 94731012    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f630f8: aa1d03fd    	mov	x29, x29
105f630fc: 94731013    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f63100: aa0003fa    	mov	x26, x0
105f63104: b00d0d08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105f63108: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
105f6310c: aa1603e2    	mov	x2, x22
105f63110: 9473100b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63114: aa1d03fd    	mov	x29, x29
105f63118: 9473100c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f6311c: aa0003fb    	mov	x27, x0
105f63120: 9473100d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f63124: aa1a03e0    	mov	x0, x26
105f63128: 9473100b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f6312c: b40004bb    	cbz	x27, 0x105f631c0 <_Flutter_MMFoundation_BindContext+0x243eda4>
105f63130: 900d1088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f63134: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
105f63138: d00cf6a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f6313c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105f63140: b00c47c8    	adrp	x8, 0x11e85c000 <dyld_stub_binder+0x11e85c000>
105f63144: 9108a108    	add	x8, x8, #0x228
105f63148: f90003e8    	str	x8, [sp]
105f6314c: d00a9603    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
105f63150: 9107f063    	add	x3, x3, #0x1fc
105f63154: 900acfe5    	adrp	x5, 0x11b95f000 <dyld_stub_binder+0x11b95f000>
105f63158: 911574a5    	add	x5, x5, #0x55d
105f6315c: 900acfe7    	adrp	x7, 0x11b95f000 <dyld_stub_binder+0x11b95f000>
105f63160: 911a38e7    	add	x7, x7, #0x68e
105f63164: 52800042    	mov	w2, #0x2                ; =2
105f63168: 52800004    	mov	w4, #0x0                ; =0
105f6316c: 52801926    	mov	w6, #0xc9               ; =201
105f63170: 94730ff3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63174: 14000076    	b	0x105f6334c <_Flutter_MMFoundation_BindContext+0x243ef30>
105f63178: 900d1088    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f6317c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
105f63180: d00cf6a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f63184: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105f63188: d00c3f88    	adrp	x8, 0x11e755000 <dyld_stub_binder+0x11e755000>
105f6318c: 911e2108    	add	x8, x8, #0x788
105f63190: f90003e8    	str	x8, [sp]
105f63194: d00a9603    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
105f63198: 9107f063    	add	x3, x3, #0x1fc
105f6319c: 900acfe5    	adrp	x5, 0x11b95f000 <dyld_stub_binder+0x11b95f000>
105f631a0: 911574a5    	add	x5, x5, #0x55d
105f631a4: 900acfe7    	adrp	x7, 0x11b95f000 <dyld_stub_binder+0x11b95f000>
105f631a8: 911a38e7    	add	x7, x7, #0x68e
105f631ac: 52800082    	mov	w2, #0x4                ; =4
105f631b0: 52800004    	mov	w4, #0x0                ; =0
105f631b4: 52801866    	mov	w6, #0xc3               ; =195
105f631b8: 94730fe1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f631bc: 14000066    	b	0x105f63354 <_Flutter_MMFoundation_BindContext+0x243ef38>
105f631c0: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f631c4: f943ed1b    	ldr	x27, [x8, #0x7d8] ; m_uiVoiceTime
105f631c8: aa1403e0    	mov	x0, x20
105f631cc: aa1b03e1    	mov	x1, x27
105f631d0: 94730fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f631d4: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f631d8: f9457d1a    	ldr	x26, [x8, #0xaf8] ; m_uiVoiceFormat
105f631dc: 35000520    	cbnz	w0, 0x105f63280 <_Flutter_MMFoundation_BindContext+0x243ee64>
105f631e0: aa1403e0    	mov	x0, x20
105f631e4: aa1a03e1    	mov	x1, x26
105f631e8: 94730fd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f631ec: d00d1088    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105f631f0: f9429d1c    	ldr	x28, [x8, #0x538] ; h�) 
105f631f4: 7100101f    	cmp	w0, #0x4
105f631f8: 54000281    	b.ne	0x105f63248 <_Flutter_MMFoundation_BindContext+0x243ee2c>
105f631fc: aa1403e0    	mov	x0, x20
105f63200: aa1903e1    	mov	x1, x25
105f63204: 94730fce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63208: aa1d03fd    	mov	x29, x29
105f6320c: 94730fcf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f63210: aa0003f9    	mov	x25, x0
105f63214: d00d0328    	adrp	x8, 0x11ffc9000 <dyld_stub_binder+0x11ffc9000>
105f63218: f945a101    	ldr	x1, [x8, #0xb40] ; calcSilkVoiceTime:
105f6321c: aa1c03e0    	mov	x0, x28
105f63220: aa1903e2    	mov	x2, x25
105f63224: 94730fc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63228: aa0003e2    	mov	x2, x0
105f6322c: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f63230: f9455901    	ldr	x1, [x8, #0xab0] ; setM_uiVoiceTime:
105f63234: aa1403e0    	mov	x0, x20
105f63238: 94730fc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f6323c: aa1903e0    	mov	x0, x25
105f63240: 94730fc5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f63244: 1400000f    	b	0x105f63280 <_Flutter_MMFoundation_BindContext+0x243ee64>
105f63248: aa1403e0    	mov	x0, x20
105f6324c: aa1a03e1    	mov	x1, x26
105f63250: 94730fbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63254: aa0003e3    	mov	x3, x0
105f63258: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f6325c: f9458101    	ldr	x1, [x8, #0xb00] ; calcVoiceTime:VoiceFormat:
105f63260: aa1c03e0    	mov	x0, x28
105f63264: aa1703e2    	mov	x2, x23
105f63268: 94730fb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f6326c: aa0003e2    	mov	x2, x0
105f63270: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f63274: f9455901    	ldr	x1, [x8, #0xab0] ; setM_uiVoiceTime:
105f63278: aa1403e0    	mov	x0, x20
105f6327c: 94730fb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63280: aa1403e0    	mov	x0, x20
105f63284: aa1803e1    	mov	x1, x24
105f63288: 94730fad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f6328c: b9003fe0    	str	w0, [sp, #0x3c]
105f63290: b00cf6c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105f63294: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
105f63298: aa1403e0    	mov	x0, x20
105f6329c: 94730fa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632a0: f9001be0    	str	x0, [sp, #0x30]
105f632a4: aa1403e0    	mov	x0, x20
105f632a8: aa1b03e1    	mov	x1, x27
105f632ac: 94730fa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632b0: aa0003fb    	mov	x27, x0
105f632b4: b00cf6c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105f632b8: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
105f632bc: aa1403e0    	mov	x0, x20
105f632c0: 94730f9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632c4: aa0003fc    	mov	x28, x0
105f632c8: aa1403e0    	mov	x0, x20
105f632cc: aa1a03e1    	mov	x1, x26
105f632d0: 94730f9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632d4: aa0003fa    	mov	x26, x0
105f632d8: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f632dc: f9468901    	ldr	x1, [x8, #0xd10] ; m_uiVoiceForwardFlag
105f632e0: aa1403e0    	mov	x0, x20
105f632e4: 94730f96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632e8: aa0003f8    	mov	x24, x0
105f632ec: 900cf6e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105f632f0: f944f101    	ldr	x1, [x8, #0x9e0] ; m_nsMsgSource
105f632f4: aa1403e0    	mov	x0, x20
105f632f8: 94730f91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f632fc: aa1d03fd    	mov	x29, x29
105f63300: 94730f92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f63304: aa0003f9    	mov	x25, x0
105f63308: 900cf708    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105f6330c: f9466101    	ldr	x1, [x8, #0xcc0] ; AddNewPart:LocalID:n64SvrID:Offset:Len:VoiceTime:CreateTime:EndFlag:CancelFlag:VoiceFormat:ForwardFlag:msgSource:chatName:
105f63310: a901cfe0    	stp	x0, x19, [sp, #0x18]
105f63314: 2901e3fa    	stp	w26, w24, [sp, #0xc]
105f63318: 52800028    	mov	w8, #0x1                ; =1
105f6331c: f80043e8    	stur	x8, [sp, #0x4]
105f63320: b90003fc    	str	w28, [sp]
105f63324: aa1503e0    	mov	x0, x21
105f63328: aa1303e2    	mov	x2, x19
105f6332c: b9403fe3    	ldr	w3, [sp, #0x3c]
105f63330: f9401be4    	ldr	x4, [sp, #0x30]
105f63334: 52800005    	mov	w5, #0x0                ; =0
105f63338: aa1703e6    	mov	x6, x23
105f6333c: aa1b03e7    	mov	x7, x27
105f63340: 94730f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f63344: aa1903e0    	mov	x0, x25
105f63348: 94730f83    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f6334c: aa1603e0    	mov	x0, x22
105f63350: 94730f81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f63354: aa1403e0    	mov	x0, x20
105f63358: 94730f7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f6335c: aa1303e0    	mov	x0, x19
105f63360: a9497bfd    	ldp	x29, x30, [sp, #0x90]
105f63364: a9484ff4    	ldp	x20, x19, [sp, #0x80]
105f63368: a94757f6    	ldp	x22, x21, [sp, #0x70]
105f6336c: a9465ff8    	ldp	x24, x23, [sp, #0x60]
105f63370: a94567fa    	ldp	x26, x25, [sp, #0x50]
105f63374: a9446ffc    	ldp	x28, x27, [sp, #0x40]
105f63378: 910283ff    	add	sp, sp, #0xa0
105f6337c: 14730f76    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>