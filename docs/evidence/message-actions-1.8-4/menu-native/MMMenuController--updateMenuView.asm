
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1165e1fe0: d10383ff    	sub	sp, sp, #0xe0
1165e1fe4: 6d043bef    	stp	d15, d14, [sp, #0x40]
1165e1fe8: 6d0533ed    	stp	d13, d12, [sp, #0x50]
1165e1fec: 6d062beb    	stp	d11, d10, [sp, #0x60]
1165e1ff0: 6d0723e9    	stp	d9, d8, [sp, #0x70]
1165e1ff4: a9086ffc    	stp	x28, x27, [sp, #0x80]
1165e1ff8: a90967fa    	stp	x26, x25, [sp, #0x90]
1165e1ffc: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
1165e2000: a90b57f6    	stp	x22, x21, [sp, #0xb0]
1165e2004: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
1165e2008: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
1165e200c: 910343fd    	add	x29, sp, #0xd0
1165e2010: aa0003f3    	mov	x19, x0
1165e2014: f004d828    	adrp	x8, 0x1200e9000 <dyld_stub_binder+0x1200e9000>
1165e2018: f940a101    	ldr	x1, [x8, #0x140] ; initMenuView
1165e201c: 94751f34    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2020: b004d948    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1165e2024: f946d501    	ldr	x1, [x8, #0xda8] ; view
1165e2028: aa1303e0    	mov	x0, x19
1165e202c: 94751f30    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2030: aa1d03fd    	mov	x29, x29
1165e2034: 94751f58    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e2038: aa0003f4    	mov	x20, x0
1165e203c: 9004d948    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1165e2040: f9442501    	ldr	x1, [x8, #0x848] ; size
1165e2044: 94751f2a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2048: 1e60400d    	fmov	d13, d0
1165e204c: 1e60402c    	fmov	d12, d1
1165e2050: aa1403e0    	mov	x0, x20
1165e2054: 94751f41    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e2058: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e205c: f9426115    	ldr	x21, [x8, #0x4c0] ; safeScreenRect
1165e2060: aa1303e0    	mov	x0, x19
1165e2064: aa1503e1    	mov	x1, x21
1165e2068: 94751f21    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e206c: 6d0307e0    	stp	d0, d1, [sp, #0x30]
1165e2070: 1e60404b    	fmov	d11, d2
1165e2074: 1e60406a    	fmov	d10, d3
1165e2078: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e207c: b98af508    	ldrsw	x8, [x8, #0xaf4]
1165e2080: 38686a68    	ldrb	w8, [x19, x8]
1165e2084: 7100051f    	cmp	w8, #0x1
1165e2088: 540000a1    	b.ne	0x1165e209c <_O266DecReleaseOutputPicture+0x33555e4>
1165e208c: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e2090: b98af908    	ldrsw	x8, [x8, #0xaf8]
1165e2094: fc686a60    	ldr	d0, [x19, x8]
1165e2098: 1e60398c    	fsub	d12, d12, d0
1165e209c: d004de88    	adrp	x8, 0x1201b4000 <dyld_stub_binder+0x1201b4000>
1165e20a0: f9475100    	ldr	x0, [x8, #0xea0] ; �@c
1165e20a4: 94751eb5    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1165e20a8: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20ac: b98aa108    	ldrsw	x8, [x8, #0xaa0]
1165e20b0: f8686a62    	ldr	x2, [x19, x8]
1165e20b4: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20b8: b98a9d08    	ldrsw	x8, [x8, #0xa9c]
1165e20bc: f8686a63    	ldr	x3, [x19, x8]
1165e20c0: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20c4: b98ad508    	ldrsw	x8, [x8, #0xad4]
1165e20c8: f8686a64    	ldr	x4, [x19, x8]
1165e20cc: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20d0: b98aa508    	ldrsw	x8, [x8, #0xaa4]
1165e20d4: f8686a65    	ldr	x5, [x19, x8]
1165e20d8: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20dc: b98aa908    	ldrsw	x8, [x8, #0xaa8]
1165e20e0: fc686a61    	ldr	d1, [x19, x8]
1165e20e4: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20e8: b98aad08    	ldrsw	x8, [x8, #0xaac]
1165e20ec: fc686a62    	ldr	d2, [x19, x8]
1165e20f0: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e20f4: b98ab108    	ldrsw	x8, [x8, #0xab0]
1165e20f8: fc686a63    	ldr	d3, [x19, x8]
1165e20fc: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e2100: f9426501    	ldr	x1, [x8, #0x4c8] ; initWithItemRows:screenWidth:maxCountPerLine:menuStyle:customHeaderView:minWidth:menuItemInnerGap:menuItemWidth:
1165e2104: 1e6041a0    	fmov	d0, d13
1165e2108: 94751ef9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e210c: aa0003f4    	mov	x20, x0
1165e2110: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e2114: f9426901    	ldr	x1, [x8, #0x4d0] ; menuAreaSize
1165e2118: 94751ef5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e211c: 1e60400d    	fmov	d13, d0
1165e2120: 1e60402e    	fmov	d14, d1
1165e2124: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e2128: b98ab508    	ldrsw	x8, [x8, #0xab4]
1165e212c: f8686a77    	ldr	x23, [x19, x8]
1165e2130: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e2134: b98ac508    	ldrsw	x8, [x8, #0xac4]
1165e2138: 8b080276    	add	x22, x19, x8
1165e213c: fd4006c8    	ldr	d8, [x22, #0x8]
1165e2140: b004dc98    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1165e2144: f9470300    	ldr	x0, [x24, #0xe00] ; �*c
1165e2148: d004c308    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1165e214c: f940f51c    	ldr	x28, [x8, #0x1e8] ; statusBarHeight
1165e2150: aa1c03e1    	mov	x1, x28
1165e2154: 94751ee6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2158: 1e60400f    	fmov	d15, d0
1165e215c: 6d4006c0    	ldp	d0, d1, [x22]
1165e2160: 6d410ec2    	ldp	d2, d3, [x22, #0x10]
1165e2164: 9474fc7a    	bl	0x11832134c <dyld_stub_binder+0x11832134c>
1165e2168: 1e603989    	fsub	d9, d12, d0
1165e216c: f9470300    	ldr	x0, [x24, #0xe00] ; �*c
1165e2170: b004c368    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
1165e2174: f947691a    	ldr	x26, [x8, #0xed0] ; bottomInset
1165e2178: aa1a03e1    	mov	x1, x26
1165e217c: 94751edc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2180: 1e603920    	fsub	d0, d9, d0
1165e2184: 1e6e2000    	fcmp	d0, d14
1165e2188: 1a9fb7f9    	cset	w25, ge
1165e218c: 9004de48    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1165e2190: f9448500    	ldr	x0, [x8, #0x908] ; @�b
1165e2194: f004c2c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1165e2198: f940f501    	ldr	x1, [x8, #0x1e8] ; externalIMP
1165e219c: 94751ed4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e21a0: aa0003f8    	mov	x24, x0
1165e21a4: aa1303e0    	mov	x0, x19
1165e21a8: aa1503e1    	mov	x1, x21
1165e21ac: 94751ed0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e21b0: 947503ea    	bl	0x118323158 <dyld_stub_binder+0x118323158>
1165e21b4: aa1d03fd    	mov	x29, x29
1165e21b8: 94751ef7    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e21bc: aa0003f5    	mov	x21, x0
1165e21c0: f004c2a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1165e21c4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1165e21c8: f0042c08    	adrp	x8, 0x11eb65000 <dyld_stub_binder+0x11eb65000>
1165e21cc: 9136a108    	add	x8, x8, #0xda8
1165e21d0: a90003e8    	stp	x8, x0, [sp]
1165e21d4: d00316c5    	adrp	x5, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e21d8: 910848a5    	add	x5, x5, #0x212
1165e21dc: d00316c7    	adrp	x7, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e21e0: 9110a8e7    	add	x7, x7, #0x42a
1165e21e4: aa1803e0    	mov	x0, x24
1165e21e8: 52800042    	mov	w2, #0x2                ; =2
1165e21ec: d2800003    	mov	x3, #0x0                ; =0
1165e21f0: 52800004    	mov	w4, #0x0                ; =0
1165e21f4: 52803d86    	mov	w6, #0x1ec              ; =492
1165e21f8: 94751ebd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e21fc: aa1503e0    	mov	x0, x21
1165e2200: 94751ed6    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e2204: 1e6e3900    	fsub	d0, d8, d14
1165e2208: 1e6f2000    	fcmp	d0, d15
1165e220c: 1a9fa7e8    	cset	w8, lt
1165e2210: f10002ff    	cmp	x23, #0x0
1165e2214: 1a990108    	csel	w8, w8, w25, eq
1165e2218: 360002a8    	tbz	w8, #0x0, 0x1165e226c <_O266DecReleaseOutputPicture+0x33557b4>
1165e221c: 6d4006c0    	ldp	d0, d1, [x22]
1165e2220: 6d410ec2    	ldp	d2, d3, [x22, #0x10]
1165e2224: 9474fc4a    	bl	0x11832134c <dyld_stub_binder+0x11832134c>
1165e2228: 1e60400f    	fmov	d15, d0
1165e222c: d004c888    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1165e2230: f9436919    	ldr	x25, [x8, #0x6d0] ; setArrowPosition:
1165e2234: aa1403e0    	mov	x0, x20
1165e2238: aa1903e1    	mov	x1, x25
1165e223c: 52800022    	mov	w2, #0x1                ; =1
1165e2240: 94751eab    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2244: 1e6f29c0    	fadd	d0, d14, d15
1165e2248: 1e761001    	fmov	d1, #-16.00000000
1165e224c: 1e612981    	fadd	d1, d12, d1
1165e2250: 1e6c3802    	fsub	d2, d0, d12
1165e2254: 1e661003    	fmov	d3, #16.00000000
1165e2258: 1e632842    	fadd	d2, d2, d3
1165e225c: 1e6239e2    	fsub	d2, d15, d2
1165e2260: 1e612000    	fcmp	d0, d1
1165e2264: 1e6fcc4f    	fcsel	d15, d2, d15, gt
1165e2268: 14000009    	b	0x1165e228c <_O266DecReleaseOutputPicture+0x33557d4>
1165e226c: fd4006c0    	ldr	d0, [x22, #0x8]
1165e2270: 1e6e380f    	fsub	d15, d0, d14
1165e2274: d004c888    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1165e2278: f9436919    	ldr	x25, [x8, #0x6d0] ; setArrowPosition:
1165e227c: aa1403e0    	mov	x0, x20
1165e2280: aa1903e1    	mov	x1, x25
1165e2284: d2800002    	mov	x2, #0x0                ; =0
1165e2288: 94751e99    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e228c: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e2290: f9426d15    	ldr	x21, [x8, #0x4d8] ; subMenuPushedAnimated
1165e2294: aa1303e0    	mov	x0, x19
1165e2298: aa1503e1    	mov	x1, x21
1165e229c: 94751e94    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e22a0: b004e577    	adrp	x23, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e22a4: fd401fe9    	ldr	d9, [sp, #0x38]
1165e22a8: 34000940    	cbz	w0, 0x1165e23d0 <_O266DecReleaseOutputPicture+0x3355918>
1165e22ac: f90013fa    	str	x26, [sp, #0x20]
1165e22b0: b98ae2f8    	ldrsw	x24, [x23, #0xae0]
1165e22b4: f8786a60    	ldr	x0, [x19, x24]
1165e22b8: f004d7a8    	adrp	x8, 0x1200d9000 <dyld_stub_binder+0x1200d9000>
1165e22bc: f9440d1a    	ldr	x26, [x8, #0x818] ; menuData
1165e22c0: aa1a03e1    	mov	x1, x26
1165e22c4: 94751e8a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e22c8: aa1d03fd    	mov	x29, x29
1165e22cc: 94751eb2    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e22d0: b4000800    	cbz	x0, 0x1165e23d0 <_O266DecReleaseOutputPicture+0x3355918>
1165e22d4: aa0003fb    	mov	x27, x0
1165e22d8: a90167fc    	stp	x28, x25, [sp, #0x10]
1165e22dc: f90017f5    	str	x21, [sp, #0x28]
1165e22e0: f8786a60    	ldr	x0, [x19, x24]
1165e22e4: aa1a03e1    	mov	x1, x26
1165e22e8: 94751e81    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e22ec: aa1d03fd    	mov	x29, x29
1165e22f0: 94751ea9    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e22f4: aa0003fc    	mov	x28, x0
1165e22f8: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e22fc: f9425519    	ldr	x25, [x8, #0x4a8] ; arrowPosition
1165e2300: aa1903e1    	mov	x1, x25
1165e2304: 94751e7a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2308: aa0003f5    	mov	x21, x0
1165e230c: aa1403e0    	mov	x0, x20
1165e2310: aa1903e1    	mov	x1, x25
1165e2314: 94751e76    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2318: aa0003f7    	mov	x23, x0
1165e231c: aa1c03e0    	mov	x0, x28
1165e2320: 94751e8e    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e2324: aa1b03e0    	mov	x0, x27
1165e2328: 94751e8c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e232c: eb1702bf    	cmp	x21, x23
1165e2330: 540004c0    	b.eq	0x1165e23c8 <_O266DecReleaseOutputPicture+0x3355910>
1165e2334: f8786a60    	ldr	x0, [x19, x24]
1165e2338: aa1a03e1    	mov	x1, x26
1165e233c: 94751e6c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2340: aa1d03fd    	mov	x29, x29
1165e2344: 94751e94    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e2348: aa0003f5    	mov	x21, x0
1165e234c: aa1903e1    	mov	x1, x25
1165e2350: 94751e67    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2354: aa0003e2    	mov	x2, x0
1165e2358: aa1403e0    	mov	x0, x20
1165e235c: f9400fe1    	ldr	x1, [sp, #0x18]
1165e2360: 94751e63    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2364: aa1503e0    	mov	x0, x21
1165e2368: 94751e7c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e236c: aa1403e0    	mov	x0, x20
1165e2370: aa1903e1    	mov	x1, x25
1165e2374: 94751e5e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2378: b40001e0    	cbz	x0, 0x1165e23b4 <_O266DecReleaseOutputPicture+0x33558fc>
1165e237c: aa1403e0    	mov	x0, x20
1165e2380: aa1903e1    	mov	x1, x25
1165e2384: 94751e5a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2388: f100041f    	cmp	x0, #0x1
1165e238c: b004dc88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1165e2390: f94017f5    	ldr	x21, [sp, #0x28]
1165e2394: b004e577    	adrp	x23, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e2398: 540001c1    	b.ne	0x1165e23d0 <_O266DecReleaseOutputPicture+0x3355918>
1165e239c: f9470100    	ldr	x0, [x8, #0xe00] ; �*c
1165e23a0: f94013e1    	ldr	x1, [sp, #0x20]
1165e23a4: 94751e52    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e23a8: 1e603980    	fsub	d0, d12, d0
1165e23ac: 1e6e380f    	fsub	d15, d0, d14
1165e23b0: 14000008    	b	0x1165e23d0 <_O266DecReleaseOutputPicture+0x3355918>
1165e23b4: b004dc88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1165e23b8: f9470100    	ldr	x0, [x8, #0xe00] ; �*c
1165e23bc: f9400be1    	ldr	x1, [sp, #0x10]
1165e23c0: 94751e4b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e23c4: 1e60400f    	fmov	d15, d0
1165e23c8: f94017f5    	ldr	x21, [sp, #0x28]
1165e23cc: b004e577    	adrp	x23, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e23d0: 6d4006c0    	ldp	d0, d1, [x22]
1165e23d4: 6d410ec2    	ldp	d2, d3, [x22, #0x10]
1165e23d8: 9474fbe0    	bl	0x118321358 <dyld_stub_binder+0x118321358>
1165e23dc: 1e7c1001    	fmov	d1, #-0.50000000
1165e23e0: 1e6109a1    	fmul	d1, d13, d1
1165e23e4: 1e61280c    	fadd	d12, d0, d1
1165e23e8: 1e6c29a8    	fadd	d8, d13, d12
1165e23ec: fd401bed    	ldr	d13, [sp, #0x30]
1165e23f0: 1e6041a0    	fmov	d0, d13
1165e23f4: 1e604121    	fmov	d1, d9
1165e23f8: 1e604162    	fmov	d2, d11
1165e23fc: 1e604143    	fmov	d3, d10
1165e2400: 9474fbd0    	bl	0x118321340 <dyld_stub_binder+0x118321340>
1165e2404: 1e602100    	fcmp	d8, d0
1165e2408: 5400024d    	b.le	0x1165e2450 <_O266DecReleaseOutputPicture+0x3355998>
1165e240c: 1e6041a0    	fmov	d0, d13
1165e2410: 1e604121    	fmov	d1, d9
1165e2414: 1e604162    	fmov	d2, d11
1165e2418: 1e604143    	fmov	d3, d10
1165e241c: 9474fbc9    	bl	0x118321340 <dyld_stub_binder+0x118321340>
1165e2420: 1e603908    	fsub	d8, d8, d0
1165e2424: 1e68398c    	fsub	d12, d12, d8
1165e2428: f004c548    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1165e242c: f944b901    	ldr	x1, [x8, #0x970] ; arrowCenterX
1165e2430: aa1403e0    	mov	x0, x20
1165e2434: 94751e2e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2438: 1e602900    	fadd	d0, d8, d0
1165e243c: f004c548    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1165e2440: f944b101    	ldr	x1, [x8, #0x960] ; setArrowCenterX:
1165e2444: aa1403e0    	mov	x0, x20
1165e2448: 94751e29    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e244c: 14000019    	b	0x1165e24b0 <_O266DecReleaseOutputPicture+0x33559f8>
1165e2450: 1e6041a0    	fmov	d0, d13
1165e2454: 1e604121    	fmov	d1, d9
1165e2458: 1e604162    	fmov	d2, d11
1165e245c: 1e604143    	fmov	d3, d10
1165e2460: 9474fbc4    	bl	0x118321370 <dyld_stub_binder+0x118321370>
1165e2464: 1e602180    	fcmp	d12, d0
1165e2468: 54000245    	b.pl	0x1165e24b0 <_O266DecReleaseOutputPicture+0x33559f8>
1165e246c: 1e751000    	fmov	d0, #-12.00000000
1165e2470: 1e602988    	fadd	d8, d12, d0
1165e2474: f004c548    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1165e2478: f944b901    	ldr	x1, [x8, #0x970] ; arrowCenterX
1165e247c: aa1403e0    	mov	x0, x20
1165e2480: 94751e1b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2484: 1e602900    	fadd	d0, d8, d0
1165e2488: f004c548    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1165e248c: f944b101    	ldr	x1, [x8, #0x960] ; setArrowCenterX:
1165e2490: aa1403e0    	mov	x0, x20
1165e2494: 94751e16    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2498: 1e6041a0    	fmov	d0, d13
1165e249c: 1e604121    	fmov	d1, d9
1165e24a0: 1e604162    	fmov	d2, d11
1165e24a4: 1e604143    	fmov	d3, d10
1165e24a8: 9474fbb2    	bl	0x118321370 <dyld_stub_binder+0x118321370>
1165e24ac: 1e60400c    	fmov	d12, d0
1165e24b0: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e24b4: f9427101    	ldr	x1, [x8, #0x4e0] ; setMenuOrigin:
1165e24b8: aa1403e0    	mov	x0, x20
1165e24bc: 1e604180    	fmov	d0, d12
1165e24c0: 1e6041e1    	fmov	d1, d15
1165e24c4: 94751e0a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e24c8: b98ae2e8    	ldrsw	x8, [x23, #0xae0]
1165e24cc: f8686a76    	ldr	x22, [x19, x8]
1165e24d0: aa1303e0    	mov	x0, x19
1165e24d4: aa1503e1    	mov	x1, x21
1165e24d8: 94751e05    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e24dc: aa0003e3    	mov	x3, x0
1165e24e0: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e24e4: f9427501    	ldr	x1, [x8, #0x4e8] ; updateWithData:animated:
1165e24e8: aa1603e0    	mov	x0, x22
1165e24ec: aa1403e2    	mov	x2, x20
1165e24f0: 94751dff    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e24f4: b004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e24f8: b98add08    	ldrsw	x8, [x8, #0xadc]
1165e24fc: 8b080260    	add	x0, x19, x8
1165e2500: 94751def    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
1165e2504: aa0003f5    	mov	x21, x0
1165e2508: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e250c: f9422501    	ldr	x1, [x8, #0x448] ; currentMenuFrame
1165e2510: aa1303e0    	mov	x0, x19
1165e2514: 94751df6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2518: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e251c: f9422901    	ldr	x1, [x8, #0x450] ; setMenuFrame:
1165e2520: aa1503e0    	mov	x0, x21
1165e2524: 94751df2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2528: aa1503e0    	mov	x0, x21
1165e252c: 94751e0b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e2530: b004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e2534: f9427901    	ldr	x1, [x8, #0x4f0] ; notifyMenuFrameDidChange
1165e2538: aa1303e0    	mov	x0, x19
1165e253c: 94751dec    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e2540: aa1403e0    	mov	x0, x20
1165e2544: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
1165e2548: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
1165e254c: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
1165e2550: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
1165e2554: a94967fa    	ldp	x26, x25, [sp, #0x90]
1165e2558: a9486ffc    	ldp	x28, x27, [sp, #0x80]
1165e255c: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
1165e2560: 6d462beb    	ldp	d11, d10, [sp, #0x60]
1165e2564: 6d4533ed    	ldp	d13, d12, [sp, #0x50]
1165e2568: 6d443bef    	ldp	d15, d14, [sp, #0x40]
1165e256c: 910383ff    	add	sp, sp, #0xe0
1165e2570: 14751dfa    	b	0x118329d58 <dyld_stub_binder+0x118329d58>