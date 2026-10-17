
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a2138: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
1002a213c: a9016ffc    	stp	x28, x27, [sp, #0x10]
1002a2140: a90267fa    	stp	x26, x25, [sp, #0x20]
1002a2144: a9035ff8    	stp	x24, x23, [sp, #0x30]
1002a2148: a90457f6    	stp	x22, x21, [sp, #0x40]
1002a214c: a9054ff4    	stp	x20, x19, [sp, #0x50]
1002a2150: a9067bfd    	stp	x29, x30, [sp, #0x60]
1002a2154: 910183fd    	add	x29, sp, #0x60
1002a2158: d10b43ff    	sub	sp, sp, #0x2d0
1002a215c: aa0003f3    	mov	x19, x0
1002a2160: b00e9a68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a2164: f9405908    	ldr	x8, [x8, #0xb0]
1002a2168: f9400108    	ldr	x8, [x8]
1002a216c: f81903a8    	stur	x8, [x29, #-0x70]
1002a2170: f0104c48    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002a2174: 52800029    	mov	w9, #0x1                ; =1
1002a2178: 39310109    	strb	w9, [x8, #0xc40]
1002a217c: 900fdce8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a2180: f9410917    	ldr	x23, [x8, #0x210] ; viewModel
1002a2184: aa1703e1    	mov	x1, x23
1002a2188: 95e613ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a218c: aa1d03fd    	mov	x29, x29
1002a2190: 95e613ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2194: aa0003f4    	mov	x20, x0
1002a2198: f00fdce8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1002a219c: f9454901    	ldr	x1, [x8, #0xa90] ; isRecordDetail
1002a21a0: 95e613e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a21a4: aa0003f5    	mov	x21, x0
1002a21a8: aa1403e0    	mov	x0, x20
1002a21ac: 95e613ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a21b0: 34000115    	cbz	w21, 0x1002a21d0 <__text+0x29a1d0>
1002a21b4: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a21b8: f941a501    	ldr	x1, [x8, #0x348] ; generateOperationMenuForRecordDetail
1002a21bc: aa1303e0    	mov	x0, x19
1002a21c0: 95e613df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a21c4: aa1d03fd    	mov	x29, x29
1002a21c8: 95e613e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a21cc: 14000408    	b	0x1002a31ec <__text+0x29b1ec>
1002a21d0: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a21d4: f9455500    	ldr	x0, [x8, #0xaa8]
1002a21d8: b00ff2e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a21dc: f941a101    	ldr	x1, [x8, #0x340] ; array
1002a21e0: 95e613d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a21e4: aa1d03fd    	mov	x29, x29
1002a21e8: 95e613d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a21ec: aa0003f4    	mov	x20, x0
1002a21f0: aa1303e0    	mov	x0, x19
1002a21f4: aa1703e1    	mov	x1, x23
1002a21f8: 95e613d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a21fc: aa1d03fd    	mov	x29, x29
1002a2200: 95e613d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2204: aa0003f5    	mov	x21, x0
1002a2208: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a220c: f941a901    	ldr	x1, [x8, #0x350] ; isChatRoomMessageUnsafe
1002a2210: 95e613cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2214: aa0003f6    	mov	x22, x0
1002a2218: aa1503e0    	mov	x0, x21
1002a221c: 95e613ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2220: a9014ff7    	stp	x23, x19, [sp, #0x10]
1002a2224: f90017f4    	str	x20, [sp, #0x28]
1002a2228: 34000396    	cbz	w22, 0x1002a2298 <__text+0x29a298>
1002a222c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2230: f941ad01    	ldr	x1, [x8, #0x358] ; restoreMenuItem
1002a2234: aa1303e0    	mov	x0, x19
1002a2238: 95e613c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a223c: aa1d03fd    	mov	x29, x29
1002a2240: 95e613c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2244: aa0003f5    	mov	x21, x0
1002a2248: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a224c: f943c516    	ldr	x22, [x8, #0x788] ; safeAddObject:
1002a2250: aa1403e0    	mov	x0, x20
1002a2254: aa1603e1    	mov	x1, x22
1002a2258: aa1503e2    	mov	x2, x21
1002a225c: 95e613b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2260: d00fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a2264: f9464101    	ldr	x1, [x8, #0xc80] ; deleteMenuItem
1002a2268: aa1303e0    	mov	x0, x19
1002a226c: 95e613b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2270: aa1d03fd    	mov	x29, x29
1002a2274: 95e613b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2278: aa0003f7    	mov	x23, x0
1002a227c: aa1403e0    	mov	x0, x20
1002a2280: aa1603e1    	mov	x1, x22
1002a2284: aa1703e2    	mov	x2, x23
1002a2288: 95e613ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a228c: aa1703e0    	mov	x0, x23
1002a2290: 95e613b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2294: 1400000d    	b	0x1002a22c8 <__text+0x29a2c8>
1002a2298: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a229c: f941b101    	ldr	x1, [x8, #0x360] ; operationMenuItems
1002a22a0: aa1303e0    	mov	x0, x19
1002a22a4: 95e613a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a22a8: aa1d03fd    	mov	x29, x29
1002a22ac: 95e613a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a22b0: aa0003f5    	mov	x21, x0
1002a22b4: 900ff2e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1002a22b8: f946f901    	ldr	x1, [x8, #0xdf0] ; addObjectsFromArray:
1002a22bc: aa1403e0    	mov	x0, x20
1002a22c0: aa1503e2    	mov	x2, x21
1002a22c4: 95e6139e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a22c8: aa1503e0    	mov	x0, x21
1002a22cc: 95e613a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a22d0: b00ff698    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1002a22d4: f9458b00    	ldr	x0, [x24, #0xb10]
1002a22d8: d00ff308    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1002a22dc: f947a915    	ldr	x21, [x8, #0xf50] ; numberWithInteger:
1002a22e0: aa1503e1    	mov	x1, x21
1002a22e4: 52800122    	mov	w2, #0x9                ; =9
1002a22e8: 95e61395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a22ec: aa1d03fd    	mov	x29, x29
1002a22f0: 95e61396    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a22f4: aa0003f4    	mov	x20, x0
1002a22f8: f81403a0    	stur	x0, [x29, #-0xc0]
1002a22fc: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2300: aa1503e1    	mov	x1, x21
1002a2304: 52800522    	mov	w2, #0x29               ; =41
1002a2308: 95e6138d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a230c: aa1d03fd    	mov	x29, x29
1002a2310: 95e6138e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2314: f90013e0    	str	x0, [sp, #0x20]
1002a2318: f81483a0    	stur	x0, [x29, #-0xb8]
1002a231c: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2320: aa1503e1    	mov	x1, x21
1002a2324: 528002a2    	mov	w2, #0x15               ; =21
1002a2328: 95e61385    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a232c: aa1d03fd    	mov	x29, x29
1002a2330: 95e61386    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2334: aa0003f9    	mov	x25, x0
1002a2338: f81503a0    	stur	x0, [x29, #-0xb0]
1002a233c: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2340: aa1503e1    	mov	x1, x21
1002a2344: 528002c2    	mov	w2, #0x16               ; =22
1002a2348: 95e6137d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a234c: aa1d03fd    	mov	x29, x29
1002a2350: 95e6137e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2354: aa0003fa    	mov	x26, x0
1002a2358: f81583a0    	stur	x0, [x29, #-0xa8]
1002a235c: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2360: aa1503e1    	mov	x1, x21
1002a2364: 52800382    	mov	w2, #0x1c               ; =28
1002a2368: 95e61375    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a236c: aa1d03fd    	mov	x29, x29
1002a2370: 95e61376    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2374: aa0003fb    	mov	x27, x0
1002a2378: f81603a0    	stur	x0, [x29, #-0xa0]
1002a237c: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2380: aa1503e1    	mov	x1, x21
1002a2384: 52800542    	mov	w2, #0x2a               ; =42
1002a2388: 95e6136d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a238c: aa1d03fd    	mov	x29, x29
1002a2390: 95e6136e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2394: aa0003fc    	mov	x28, x0
1002a2398: f81683a0    	stur	x0, [x29, #-0x98]
1002a239c: f9458b00    	ldr	x0, [x24, #0xb10]
1002a23a0: aa1503e1    	mov	x1, x21
1002a23a4: 528005c2    	mov	w2, #0x2e               ; =46
1002a23a8: 95e61365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a23ac: aa1d03fd    	mov	x29, x29
1002a23b0: 95e61366    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a23b4: aa0003f6    	mov	x22, x0
1002a23b8: f81703a0    	stur	x0, [x29, #-0x90]
1002a23bc: f9458b00    	ldr	x0, [x24, #0xb10]
1002a23c0: aa1503e1    	mov	x1, x21
1002a23c4: 528005e2    	mov	w2, #0x2f               ; =47
1002a23c8: 95e6135d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a23cc: aa1d03fd    	mov	x29, x29
1002a23d0: 95e6135e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a23d4: aa0003f3    	mov	x19, x0
1002a23d8: f81783a0    	stur	x0, [x29, #-0x88]
1002a23dc: f9458b00    	ldr	x0, [x24, #0xb10]
1002a23e0: aa1503e1    	mov	x1, x21
1002a23e4: 52800722    	mov	w2, #0x39               ; =57
1002a23e8: 95e61355    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a23ec: aa1d03fd    	mov	x29, x29
1002a23f0: 95e61356    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a23f4: aa0003f7    	mov	x23, x0
1002a23f8: f81803a0    	stur	x0, [x29, #-0x80]
1002a23fc: f9458b00    	ldr	x0, [x24, #0xb10]
1002a2400: aa1503e1    	mov	x1, x21
1002a2404: 52800742    	mov	w2, #0x3a               ; =58
1002a2408: 95e6134d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a240c: aa1d03fd    	mov	x29, x29
1002a2410: 95e6134e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2414: aa0003f8    	mov	x24, x0
1002a2418: f81883a0    	stur	x0, [x29, #-0x78]
1002a241c: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a2420: f9456d00    	ldr	x0, [x8, #0xad8]
1002a2424: b00ff2e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a2428: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1002a242c: d10303a2    	sub	x2, x29, #0xc0
1002a2430: 52800143    	mov	w3, #0xa                ; =10
1002a2434: 95e61342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2438: aa1d03fd    	mov	x29, x29
1002a243c: 95e61343    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2440: aa0003f5    	mov	x21, x0
1002a2444: aa1803e0    	mov	x0, x24
1002a2448: 95e61343    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a244c: aa1703e0    	mov	x0, x23
1002a2450: 95e61341    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2454: aa1303e0    	mov	x0, x19
1002a2458: 95e6133f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a245c: aa1603e0    	mov	x0, x22
1002a2460: 95e6133d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2464: aa1c03e0    	mov	x0, x28
1002a2468: 95e6133b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a246c: aa1b03e0    	mov	x0, x27
1002a2470: 95e61339    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2474: aa1a03e0    	mov	x0, x26
1002a2478: 95e61337    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a247c: aa1903e0    	mov	x0, x25
1002a2480: 95e61335    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2484: f94013e0    	ldr	x0, [sp, #0x20]
1002a2488: 95e61333    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a248c: aa1403e0    	mov	x0, x20
1002a2490: 95e61331    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2494: d00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2498: f946d100    	ldr	x0, [x8, #0xda0]
1002a249c: d00fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a24a0: f9469101    	ldr	x1, [x8, #0xd20] ; indexSet
1002a24a4: 95e61326    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a24a8: aa1d03fd    	mov	x29, x29
1002a24ac: 95e61327    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a24b0: aa0003f7    	mov	x23, x0
1002a24b4: 4f00e400    	movi.16b	v0, #0x0
1002a24b8: ad0583e0    	stp	q0, q0, [sp, #0xb0]
1002a24bc: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1002a24c0: aa1503e0    	mov	x0, x21
1002a24c4: 95e6131d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a24c8: d00ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a24cc: f943551c    	ldr	x28, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1002a24d0: 9102c3e2    	add	x2, sp, #0xb0
1002a24d4: 9107c3e3    	add	x3, sp, #0x1f0
1002a24d8: aa1c03e1    	mov	x1, x28
1002a24dc: 52800204    	mov	w4, #0x10               ; =16
1002a24e0: 95e61317    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a24e4: b4000440    	cbz	x0, 0x1002a256c <__text+0x29a56c>
1002a24e8: aa0003f6    	mov	x22, x0
1002a24ec: f94063e8    	ldr	x8, [sp, #0xc0]
1002a24f0: f9400113    	ldr	x19, [x8]
1002a24f4: b00ff318    	adrp	x24, 0x120103000 <dyld_stub_binder+0x120103000>
1002a24f8: d00fdcfb    	adrp	x27, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a24fc: d2800014    	mov	x20, #0x0               ; =0
1002a2500: f9424b19    	ldr	x25, [x24, #0x490] ; intValue
1002a2504: f946977a    	ldr	x26, [x27, #0xd28] ; addIndex:
1002a2508: f94063e8    	ldr	x8, [sp, #0xc0]
1002a250c: f9400108    	ldr	x8, [x8]
1002a2510: eb13011f    	cmp	x8, x19
1002a2514: 54000060    	b.eq	0x1002a2520 <__text+0x29a520>
1002a2518: aa1503e0    	mov	x0, x21
1002a251c: 95e6130d    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a2520: f9405fe8    	ldr	x8, [sp, #0xb8]
1002a2524: f8747900    	ldr	x0, [x8, x20, lsl #3]
1002a2528: aa1903e1    	mov	x1, x25
1002a252c: 95e61304    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2530: 93407c02    	sxtw	x2, w0
1002a2534: aa1703e0    	mov	x0, x23
1002a2538: aa1a03e1    	mov	x1, x26
1002a253c: 95e61300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2540: 91000694    	add	x20, x20, #0x1
1002a2544: eb1402df    	cmp	x22, x20
1002a2548: 54fffe01    	b.ne	0x1002a2508 <__text+0x29a508>
1002a254c: 9102c3e2    	add	x2, sp, #0xb0
1002a2550: 9107c3e3    	add	x3, sp, #0x1f0
1002a2554: aa1503e0    	mov	x0, x21
1002a2558: aa1c03e1    	mov	x1, x28
1002a255c: 52800204    	mov	w4, #0x10               ; =16
1002a2560: 95e612f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2564: aa0003f6    	mov	x22, x0
1002a2568: b5fffca0    	cbnz	x0, 0x1002a24fc <__text+0x29a4fc>
1002a256c: f90013fc    	str	x28, [sp, #0x20]
1002a2570: aa1503e0    	mov	x0, x21
1002a2574: 95e612f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2578: d2800014    	mov	x20, #0x0               ; =0
1002a257c: d00ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a2580: f9435116    	ldr	x22, [x8, #0x6a0] ; count
1002a2584: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a2588: f942c11a    	ldr	x26, [x8, #0x580] ; safeObjectAtIndex:
1002a258c: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2590: f943651b    	ldr	x27, [x8, #0x6c8] ; menuType
1002a2594: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2598: f941b51c    	ldr	x28, [x8, #0x368] ; containsIndex:
1002a259c: f94017f3    	ldr	x19, [sp, #0x28]
1002a25a0: aa1403f9    	mov	x25, x20
1002a25a4: aa1303e0    	mov	x0, x19
1002a25a8: aa1603e1    	mov	x1, x22
1002a25ac: 95e612e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a25b0: eb14001f    	cmp	x0, x20
1002a25b4: 54000289    	b.ls	0x1002a2604 <__text+0x29a604>
1002a25b8: aa1303e0    	mov	x0, x19
1002a25bc: aa1a03e1    	mov	x1, x26
1002a25c0: aa1903e2    	mov	x2, x25
1002a25c4: 95e612de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a25c8: aa1d03fd    	mov	x29, x29
1002a25cc: 95e612df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a25d0: aa0003f3    	mov	x19, x0
1002a25d4: aa1b03e1    	mov	x1, x27
1002a25d8: 95e612d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a25dc: aa0003e2    	mov	x2, x0
1002a25e0: aa1703e0    	mov	x0, x23
1002a25e4: aa1c03e1    	mov	x1, x28
1002a25e8: 95e612d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a25ec: aa0003f8    	mov	x24, x0
1002a25f0: 91000734    	add	x20, x25, #0x1
1002a25f4: aa1303e0    	mov	x0, x19
1002a25f8: f94017f3    	ldr	x19, [sp, #0x28]
1002a25fc: 95e612d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2600: 34fffd18    	cbz	w24, 0x1002a25a0 <__text+0x29a5a0>
1002a2604: a94173f8    	ldp	x24, x28, [sp, #0x10]
1002a2608: aa1c03e0    	mov	x0, x28
1002a260c: aa1803e1    	mov	x1, x24
1002a2610: 95e612cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2614: aa1d03fd    	mov	x29, x29
1002a2618: 95e612cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a261c: aa0003f3    	mov	x19, x0
1002a2620: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2624: f941b901    	ldr	x1, [x8, #0x370] ; canShowMsgReplyMenuItem
1002a2628: 95e612c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a262c: aa0003f6    	mov	x22, x0
1002a2630: aa1303e0    	mov	x0, x19
1002a2634: 95e612c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2638: 36000256    	tbz	w22, #0x0, 0x1002a2680 <__text+0x29a680>
1002a263c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2640: f941bd01    	ldr	x1, [x8, #0x378] ; msgReplyMenuItem
1002a2644: aa1c03e0    	mov	x0, x28
1002a2648: 95e612bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a264c: aa1d03fd    	mov	x29, x29
1002a2650: 95e612be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2654: aa0003f3    	mov	x19, x0
1002a2658: 2a1903e3    	mov	w3, w25
1002a265c: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a2660: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a2664: f94017e0    	ldr	x0, [sp, #0x28]
1002a2668: aa1303e2    	mov	x2, x19
1002a266c: 95e612b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2670: aa1303e0    	mov	x0, x19
1002a2674: 95e612b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2678: 11000734    	add	w20, w25, #0x1
1002a267c: 14000002    	b	0x1002a2684 <__text+0x29a684>
1002a2680: aa1903f4    	mov	x20, x25
1002a2684: aa1c03e0    	mov	x0, x28
1002a2688: aa1803e1    	mov	x1, x24
1002a268c: 95e612ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2690: aa1d03fd    	mov	x29, x29
1002a2694: 95e612ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2698: aa0003f3    	mov	x19, x0
1002a269c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a26a0: f941c101    	ldr	x1, [x8, #0x380] ; canShowMsgNoteMenuItem
1002a26a4: 95e612a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a26a8: aa0003f6    	mov	x22, x0
1002a26ac: aa1303e0    	mov	x0, x19
1002a26b0: 95e612a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a26b4: 34000256    	cbz	w22, 0x1002a26fc <__text+0x29a6fc>
1002a26b8: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a26bc: f941c501    	ldr	x1, [x8, #0x388] ; msgAddNoteMenuItem
1002a26c0: aa1c03e0    	mov	x0, x28
1002a26c4: 95e6129e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a26c8: aa1d03fd    	mov	x29, x29
1002a26cc: 95e6129f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a26d0: aa0003f3    	mov	x19, x0
1002a26d4: aa1403e8    	mov	x8, x20
1002a26d8: 93407d03    	sxtw	x3, w8
1002a26dc: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a26e0: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a26e4: f94017e0    	ldr	x0, [sp, #0x28]
1002a26e8: aa1303e2    	mov	x2, x19
1002a26ec: 95e61294    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a26f0: aa1303e0    	mov	x0, x19
1002a26f4: 95e61298    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a26f8: 11000694    	add	w20, w20, #0x1
1002a26fc: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2700: f941c901    	ldr	x1, [x8, #0x390] ; canShowScheduleMenuItem
1002a2704: aa1c03e0    	mov	x0, x28
1002a2708: 95e6128d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a270c: 34000240    	cbz	w0, 0x1002a2754 <__text+0x29a754>
1002a2710: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2714: f941cd01    	ldr	x1, [x8, #0x398] ; scheduleMenuItem
1002a2718: aa1c03e0    	mov	x0, x28
1002a271c: 95e61288    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2720: aa1d03fd    	mov	x29, x29
1002a2724: 95e61289    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2728: aa0003f3    	mov	x19, x0
1002a272c: aa1403e8    	mov	x8, x20
1002a2730: 93407d03    	sxtw	x3, w8
1002a2734: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a2738: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a273c: f94017e0    	ldr	x0, [sp, #0x28]
1002a2740: aa1303e2    	mov	x2, x19
1002a2744: 95e6127e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2748: aa1303e0    	mov	x0, x19
1002a274c: 95e61282    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2750: 11000694    	add	w20, w20, #0x1
1002a2754: 900ff6a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a2758: f940c100    	ldr	x0, [x8, #0x180] ; �W+ 
1002a275c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2760: f941d119    	ldr	x25, [x8, #0x3a0] ; isEntryEnabled
1002a2764: aa1903e1    	mov	x1, x25
1002a2768: 95e61275    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a276c: 340008e0    	cbz	w0, 0x1002a2888 <__text+0x29a888>
1002a2770: aa1c03e0    	mov	x0, x28
1002a2774: aa1803e1    	mov	x1, x24
1002a2778: 95e61271    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a277c: aa1d03fd    	mov	x29, x29
1002a2780: 95e61272    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2784: aa0003f6    	mov	x22, x0
1002a2788: 900fdce8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a278c: f941051b    	ldr	x27, [x8, #0x208] ; messageWrap
1002a2790: aa1b03e1    	mov	x1, x27
1002a2794: 95e6126a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2798: aa1d03fd    	mov	x29, x29
1002a279c: 95e6126b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a27a0: aa0003fa    	mov	x26, x0
1002a27a4: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a27a8: f941d501    	ldr	x1, [x8, #0x3a8] ; IsTextMsg
1002a27ac: 95e61264    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a27b0: 340000c0    	cbz	w0, 0x1002a27c8 <__text+0x29a7c8>
1002a27b4: aa1a03e0    	mov	x0, x26
1002a27b8: 95e61267    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a27bc: aa1603e0    	mov	x0, x22
1002a27c0: 95e61265    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a27c4: 1400001a    	b	0x1002a282c <__text+0x29a82c>
1002a27c8: aa1c03e0    	mov	x0, x28
1002a27cc: aa1803e1    	mov	x1, x24
1002a27d0: 95e6125b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a27d4: aa1d03fd    	mov	x29, x29
1002a27d8: 95e6125c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a27dc: aa0003f3    	mov	x19, x0
1002a27e0: aa1b03e1    	mov	x1, x27
1002a27e4: 95e61256    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a27e8: aa1d03fd    	mov	x29, x29
1002a27ec: 95e61257    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a27f0: aa0003f8    	mov	x24, x0
1002a27f4: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a27f8: f9402101    	ldr	x1, [x8, #0x40] ; isAppMsgAppearAsTextMsg
1002a27fc: 95e61250    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2800: aa0003fb    	mov	x27, x0
1002a2804: aa1803e0    	mov	x0, x24
1002a2808: f9400bf8    	ldr	x24, [sp, #0x10]
1002a280c: 95e61252    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2810: aa1303e0    	mov	x0, x19
1002a2814: 95e61250    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2818: aa1a03e0    	mov	x0, x26
1002a281c: 95e6124e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2820: aa1603e0    	mov	x0, x22
1002a2824: 95e6124c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2828: 3400031b    	cbz	w27, 0x1002a2888 <__text+0x29a888>
1002a282c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2830: f941d902    	ldr	x2, [x8, #0x3b0] ; onAskXiaoWei:
1002a2834: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2838: f941dd01    	ldr	x1, [x8, #0x3b8] ; makeAskXiaoWeiMenuItemWithAction:
1002a283c: aa1c03e0    	mov	x0, x28
1002a2840: 95e6123f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2844: aa1d03fd    	mov	x29, x29
1002a2848: 95e61240    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a284c: aa0003f3    	mov	x19, x0
1002a2850: 93407e83    	sxtw	x3, w20
1002a2854: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a2858: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a285c: f94017e0    	ldr	x0, [sp, #0x28]
1002a2860: aa1303e2    	mov	x2, x19
1002a2864: 95e61236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2868: aa1303e0    	mov	x0, x19
1002a286c: 95e6123a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2870: 11000694    	add	w20, w20, #0x1
1002a2874: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2878: f941e101    	ldr	x1, [x8, #0x3c0] ; reportAskXiaoWeiBubbleUnderlineForClick:
1002a287c: aa1c03e0    	mov	x0, x28
1002a2880: 52800002    	mov	w2, #0x0                ; =0
1002a2884: 95e6122e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2888: 900ff6a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a288c: f940c500    	ldr	x0, [x8, #0x188] ; xU+ 
1002a2890: aa1903e1    	mov	x1, x25
1002a2894: 95e6122a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2898: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a289c: d00ff2e9    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
1002a28a0: b00ff2f3    	adrp	x19, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a28a4: f00fdcbb    	adrp	x27, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a28a8: f90007f4    	str	x20, [sp, #0x8]
1002a28ac: 34000ba0    	cbz	w0, 0x1002a2a20 <__text+0x29aa20>
1002a28b0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002a28b4: f944e921    	ldr	x1, [x9, #0x9d0] ; currentContext
1002a28b8: 95e61221    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a28bc: aa1d03fd    	mov	x29, x29
1002a28c0: 95e61222    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a28c4: aa0003fa    	mov	x26, x0
1002a28c8: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a28cc: f9467100    	ldr	x0, [x8, #0xce0] ; @�- 
1002a28d0: f947ae61    	ldr	x1, [x19, #0xf58] ; class
1002a28d4: 95e6121a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a28d8: aa0003e2    	mov	x2, x0
1002a28dc: f9464361    	ldr	x1, [x27, #0xc80] ; getService:
1002a28e0: aa1a03e0    	mov	x0, x26
1002a28e4: 95e61216    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a28e8: aa1d03fd    	mov	x29, x29
1002a28ec: 95e61217    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a28f0: aa0003fb    	mov	x27, x0
1002a28f4: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a28f8: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
1002a28fc: b00f10c2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a2900: 9123a042    	add	x2, x2, #0x8e8
1002a2904: 52800003    	mov	w3, #0x0                ; =0
1002a2908: 95e6120d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a290c: 360006c0    	tbz	w0, #0x0, 0x1002a29e4 <__text+0x29a9e4>
1002a2910: aa1c03e0    	mov	x0, x28
1002a2914: aa1803e1    	mov	x1, x24
1002a2918: 95e61209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a291c: aa1d03fd    	mov	x29, x29
1002a2920: 95e6120a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2924: aa0003f6    	mov	x22, x0
1002a2928: 900fdce8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a292c: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1002a2930: 95e61203    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2934: aa1d03fd    	mov	x29, x29
1002a2938: 95e61204    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a293c: aa1c03f4    	mov	x20, x28
1002a2940: aa0003fc    	mov	x28, x0
1002a2944: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2948: f941e501    	ldr	x1, [x8, #0x3c8] ; IsImgMsg
1002a294c: 95e611fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2950: 34000540    	cbz	w0, 0x1002a29f8 <__text+0x29a9f8>
1002a2954: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2958: f941e901    	ldr	x1, [x8, #0x3d0] ; isAskXiaoWeiImageEntryReady
1002a295c: aa1403e0    	mov	x0, x20
1002a2960: 95e611f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2964: aa0003f3    	mov	x19, x0
1002a2968: aa1c03e0    	mov	x0, x28
1002a296c: 95e611fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2970: aa1603e0    	mov	x0, x22
1002a2974: 95e611f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2978: aa1b03e0    	mov	x0, x27
1002a297c: 95e611f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2980: aa1a03e0    	mov	x0, x26
1002a2984: 95e611f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2988: 34000493    	cbz	w19, 0x1002a2a18 <__text+0x29aa18>
1002a298c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2990: f941ed02    	ldr	x2, [x8, #0x3d8] ; onAskXiaoWeiImage:
1002a2994: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2998: f941dd01    	ldr	x1, [x8, #0x3b8] ; makeAskXiaoWeiMenuItemWithAction:
1002a299c: aa1403e0    	mov	x0, x20
1002a29a0: 95e611e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a29a4: aa1d03fd    	mov	x29, x29
1002a29a8: 95e611e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a29ac: aa0003f3    	mov	x19, x0
1002a29b0: f94007f6    	ldr	x22, [sp, #0x8]
1002a29b4: aa1603e8    	mov	x8, x22
1002a29b8: 93407d03    	sxtw	x3, w8
1002a29bc: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a29c0: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a29c4: f94017e0    	ldr	x0, [sp, #0x28]
1002a29c8: aa1303e2    	mov	x2, x19
1002a29cc: 95e611dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a29d0: aa1303e0    	mov	x0, x19
1002a29d4: 95e611e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a29d8: 110006d6    	add	w22, w22, #0x1
1002a29dc: f90007f6    	str	x22, [sp, #0x8]
1002a29e0: 1400000e    	b	0x1002a2a18 <__text+0x29aa18>
1002a29e4: aa1b03e0    	mov	x0, x27
1002a29e8: 95e611db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a29ec: aa1a03e0    	mov	x0, x26
1002a29f0: 95e611d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a29f4: 1400000a    	b	0x1002a2a1c <__text+0x29aa1c>
1002a29f8: aa1c03e0    	mov	x0, x28
1002a29fc: 95e611d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2a00: aa1603e0    	mov	x0, x22
1002a2a04: 95e611d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2a08: aa1b03e0    	mov	x0, x27
1002a2a0c: 95e611d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2a10: aa1a03e0    	mov	x0, x26
1002a2a14: 95e611d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2a18: aa1403fc    	mov	x28, x20
1002a2a1c: f00fdcbb    	adrp	x27, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a2a20: 900ff6a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a2a24: f940c900    	ldr	x0, [x8, #0x190] ; �S+ 
1002a2a28: aa1903e1    	mov	x1, x25
1002a2a2c: 95e611c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2a30: 340009c0    	cbz	w0, 0x1002a2b68 <__text+0x29ab68>
1002a2a34: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a2a38: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002a2a3c: d00ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a2a40: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1002a2a44: 95e611be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2a48: aa1d03fd    	mov	x29, x29
1002a2a4c: 95e611bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2a50: aa0003f9    	mov	x25, x0
1002a2a54: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a2a58: f9467100    	ldr	x0, [x8, #0xce0] ; @�- 
1002a2a5c: b00ff2e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a2a60: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002a2a64: 95e611b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2a68: aa0003e2    	mov	x2, x0
1002a2a6c: f9464361    	ldr	x1, [x27, #0xc80] ; getService:
1002a2a70: aa1903e0    	mov	x0, x25
1002a2a74: 95e611b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2a78: aa1d03fd    	mov	x29, x29
1002a2a7c: 95e611b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2a80: aa0003f6    	mov	x22, x0
1002a2a84: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a2a88: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
1002a2a8c: b00f10c2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a2a90: 91242042    	add	x2, x2, #0x908
1002a2a94: 52800003    	mov	w3, #0x0                ; =0
1002a2a98: 95e611a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2a9c: 360005e0    	tbz	w0, #0x0, 0x1002a2b58 <__text+0x29ab58>
1002a2aa0: d00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2aa4: f9411d13    	ldr	x19, [x8, #0x238] ; @�7 
1002a2aa8: aa1c03e0    	mov	x0, x28
1002a2aac: aa1803e1    	mov	x1, x24
1002a2ab0: 95e611a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2ab4: aa1d03fd    	mov	x29, x29
1002a2ab8: 95e611a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2abc: aa0003f8    	mov	x24, x0
1002a2ac0: 900fdce8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a2ac4: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1002a2ac8: 95e6119d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2acc: aa1d03fd    	mov	x29, x29
1002a2ad0: 95e6119e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2ad4: aa0003fa    	mov	x26, x0
1002a2ad8: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2adc: f941f101    	ldr	x1, [x8, #0x3e0] ; IsFinderFeedMsgEnable:
1002a2ae0: aa1303e0    	mov	x0, x19
1002a2ae4: aa1a03e2    	mov	x2, x26
1002a2ae8: 95e61195    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2aec: aa0003f3    	mov	x19, x0
1002a2af0: aa1a03e0    	mov	x0, x26
1002a2af4: 95e61198    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2af8: aa1803e0    	mov	x0, x24
1002a2afc: 95e61196    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2b00: aa1603e0    	mov	x0, x22
1002a2b04: 95e61194    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2b08: aa1903e0    	mov	x0, x25
1002a2b0c: 95e61192    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2b10: 340002d3    	cbz	w19, 0x1002a2b68 <__text+0x29ab68>
1002a2b14: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2b18: f941f502    	ldr	x2, [x8, #0x3e8] ; onAskXiaoWeiFinder:
1002a2b1c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2b20: f941dd01    	ldr	x1, [x8, #0x3b8] ; makeAskXiaoWeiMenuItemWithAction:
1002a2b24: aa1c03e0    	mov	x0, x28
1002a2b28: 95e61185    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2b2c: aa1d03fd    	mov	x29, x29
1002a2b30: 95e61186    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2b34: aa0003f9    	mov	x25, x0
1002a2b38: f94007e8    	ldr	x8, [sp, #0x8]
1002a2b3c: 93407d03    	sxtw	x3, w8
1002a2b40: b00fdcc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002a2b44: f945b101    	ldr	x1, [x8, #0xb60] ; safeInsertObject:atIndex:
1002a2b48: f94017e0    	ldr	x0, [sp, #0x28]
1002a2b4c: aa1903e2    	mov	x2, x25
1002a2b50: 95e6117b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2b54: 14000003    	b	0x1002a2b60 <__text+0x29ab60>
1002a2b58: aa1603e0    	mov	x0, x22
1002a2b5c: 95e6117e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2b60: aa1903e0    	mov	x0, x25
1002a2b64: 95e6117c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2b68: 900ff6a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1002a2b6c: f940cd00    	ldr	x0, [x8, #0x198] ; ��* 
1002a2b70: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2b74: f941f901    	ldr	x1, [x8, #0x3f0] ; removeMutexMenuItemsIfNeeded:
1002a2b78: f94017f3    	ldr	x19, [sp, #0x28]
1002a2b7c: aa1303e2    	mov	x2, x19
1002a2b80: 95e6116f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2b84: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2b88: f941fd01    	ldr	x1, [x8, #0x3f8] ; canShowSpeakMsgItem
1002a2b8c: aa1c03e0    	mov	x0, x28
1002a2b90: 95e6116b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2b94: 34000260    	cbz	w0, 0x1002a2be0 <__text+0x29abe0>
1002a2b98: d00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2b9c: f9452900    	ldr	x0, [x8, #0xa50]
1002a2ba0: 95e61170    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1002a2ba4: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2ba8: f9420103    	ldr	x3, [x8, #0x400] ; onSpeakMsg
1002a2bac: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2bb0: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
1002a2bb4: 52800582    	mov	w2, #0x2c               ; =44
1002a2bb8: 95e61161    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2bbc: aa0003f3    	mov	x19, x0
1002a2bc0: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a2bc4: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1002a2bc8: f94017e0    	ldr	x0, [sp, #0x28]
1002a2bcc: aa1303e2    	mov	x2, x19
1002a2bd0: 95e6115b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2bd4: aa1303e0    	mov	x0, x19
1002a2bd8: f94017f3    	ldr	x19, [sp, #0x28]
1002a2bdc: 95e6115e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2be0: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2be4: f9420501    	ldr	x1, [x8, #0x408] ; canShowTopMsgMenuItem
1002a2be8: aa1c03e0    	mov	x0, x28
1002a2bec: 95e61154    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2bf0: 900ff2f4    	adrp	x20, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1002a2bf4: 36000080    	tbz	w0, #0x0, 0x1002a2c04 <__text+0x29ac04>
1002a2bf8: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2bfc: 91104108    	add	x8, x8, #0x410
1002a2c00: 14000008    	b	0x1002a2c20 <__text+0x29ac20>
1002a2c04: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2c08: f9420d01    	ldr	x1, [x8, #0x418] ; canShowCancelTopMenuItem
1002a2c0c: aa1c03e0    	mov	x0, x28
1002a2c10: 95e6114b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2c14: 34000220    	cbz	w0, 0x1002a2c58 <__text+0x29ac58>
1002a2c18: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2c1c: 91108108    	add	x8, x8, #0x420
1002a2c20: f9400101    	ldr	x1, [x8]
1002a2c24: aa1c03e0    	mov	x0, x28
1002a2c28: 95e61145    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2c2c: aa1d03fd    	mov	x29, x29
1002a2c30: 95e61146    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2c34: aa0003f3    	mov	x19, x0
1002a2c38: f946f681    	ldr	x1, [x20, #0xde8] ; addObject:
1002a2c3c: f94017f4    	ldr	x20, [sp, #0x28]
1002a2c40: aa1403e0    	mov	x0, x20
1002a2c44: aa1303e2    	mov	x2, x19
1002a2c48: 95e6113d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2c4c: aa1303e0    	mov	x0, x19
1002a2c50: aa1403f3    	mov	x19, x20
1002a2c54: 95e61140    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2c58: 4f00e400    	movi.16b	v0, #0x0
1002a2c5c: ad0483e0    	stp	q0, q0, [sp, #0x90]
1002a2c60: ad0383e0    	stp	q0, q0, [sp, #0x70]
1002a2c64: aa1303e0    	mov	x0, x19
1002a2c68: 95e61134    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a2c6c: 9101c3e2    	add	x2, sp, #0x70
1002a2c70: 9105c3e3    	add	x3, sp, #0x170
1002a2c74: f94013e1    	ldr	x1, [sp, #0x20]
1002a2c78: 52800204    	mov	w4, #0x10               ; =16
1002a2c7c: 95e61130    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2c80: b4000460    	cbz	x0, 0x1002a2d0c <__text+0x29ad0c>
1002a2c84: aa0003f6    	mov	x22, x0
1002a2c88: f94043e8    	ldr	x8, [sp, #0x80]
1002a2c8c: f9400113    	ldr	x19, [x8]
1002a2c90: d2800014    	mov	x20, #0x0               ; =0
1002a2c94: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2c98: f9436519    	ldr	x25, [x8, #0x6c8] ; menuType
1002a2c9c: f94043e8    	ldr	x8, [sp, #0x80]
1002a2ca0: f9400108    	ldr	x8, [x8]
1002a2ca4: eb13011f    	cmp	x8, x19
1002a2ca8: 54000060    	b.eq	0x1002a2cb4 <__text+0x29acb4>
1002a2cac: f94017e0    	ldr	x0, [sp, #0x28]
1002a2cb0: 95e61128    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a2cb4: f9403fe8    	ldr	x8, [sp, #0x78]
1002a2cb8: f874791a    	ldr	x26, [x8, x20, lsl #3]
1002a2cbc: aa1a03e0    	mov	x0, x26
1002a2cc0: aa1903e1    	mov	x1, x25
1002a2cc4: 95e6111e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2cc8: f100201f    	cmp	x0, #0x8
1002a2ccc: 54000400    	b.eq	0x1002a2d4c <__text+0x29ad4c>
1002a2cd0: aa1a03e0    	mov	x0, x26
1002a2cd4: aa1903e1    	mov	x1, x25
1002a2cd8: 95e61119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2cdc: f100101f    	cmp	x0, #0x4
1002a2ce0: 54000360    	b.eq	0x1002a2d4c <__text+0x29ad4c>
1002a2ce4: 91000694    	add	x20, x20, #0x1
1002a2ce8: eb1402df    	cmp	x22, x20
1002a2cec: 54fffd81    	b.ne	0x1002a2c9c <__text+0x29ac9c>
1002a2cf0: 9101c3e2    	add	x2, sp, #0x70
1002a2cf4: 9105c3e3    	add	x3, sp, #0x170
1002a2cf8: a94203e1    	ldp	x1, x0, [sp, #0x20]
1002a2cfc: 52800204    	mov	w4, #0x10               ; =16
1002a2d00: 95e6110f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2d04: aa0003f6    	mov	x22, x0
1002a2d08: b5fffc40    	cbnz	x0, 0x1002a2c90 <__text+0x29ac90>
1002a2d0c: f94017f3    	ldr	x19, [sp, #0x28]
1002a2d10: aa1303e0    	mov	x0, x19
1002a2d14: 95e61110    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2d18: d00fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a2d1c: f9464101    	ldr	x1, [x8, #0xc80] ; deleteMenuItem
1002a2d20: aa1c03e0    	mov	x0, x28
1002a2d24: 95e61106    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2d28: aa1d03fd    	mov	x29, x29
1002a2d2c: 95e61107    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2d30: aa0003f6    	mov	x22, x0
1002a2d34: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a2d38: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1002a2d3c: aa1303e0    	mov	x0, x19
1002a2d40: aa1603e2    	mov	x2, x22
1002a2d44: 95e610fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2d48: 14000003    	b	0x1002a2d54 <__text+0x29ad54>
1002a2d4c: f94017f3    	ldr	x19, [sp, #0x28]
1002a2d50: aa1303f6    	mov	x22, x19
1002a2d54: aa1603e0    	mov	x0, x22
1002a2d58: 95e610ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2d5c: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2d60: f9421501    	ldr	x1, [x8, #0x428] ; canShowMoreMenuItem
1002a2d64: aa1c03e0    	mov	x0, x28
1002a2d68: 95e610f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2d6c: 340009a0    	cbz	w0, 0x1002a2ea0 <__text+0x29aea0>
1002a2d70: 4f00e400    	movi.16b	v0, #0x0
1002a2d74: ad0283e0    	stp	q0, q0, [sp, #0x50]
1002a2d78: ad0183e0    	stp	q0, q0, [sp, #0x30]
1002a2d7c: aa1303e0    	mov	x0, x19
1002a2d80: 95e610ee    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1002a2d84: 9100c3e2    	add	x2, sp, #0x30
1002a2d88: 9103c3e3    	add	x3, sp, #0xf0
1002a2d8c: f94013e1    	ldr	x1, [sp, #0x20]
1002a2d90: 52800204    	mov	w4, #0x10               ; =16
1002a2d94: 95e610ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2d98: b4000580    	cbz	x0, 0x1002a2e48 <__text+0x29ae48>
1002a2d9c: aa0003f9    	mov	x25, x0
1002a2da0: f94023e8    	ldr	x8, [sp, #0x40]
1002a2da4: f9400113    	ldr	x19, [x8]
1002a2da8: b00ff309    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
1002a2dac: d00ff698    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2db0: d2800014    	mov	x20, #0x0               ; =0
1002a2db4: b00ff2e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a2db8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
1002a2dbc: f9442d3a    	ldr	x26, [x9, #0x858] ; isKindOfClass:
1002a2dc0: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2dc4: f943651b    	ldr	x27, [x8, #0x6c8] ; menuType
1002a2dc8: f94023e8    	ldr	x8, [sp, #0x40]
1002a2dcc: f9400108    	ldr	x8, [x8]
1002a2dd0: eb13011f    	cmp	x8, x19
1002a2dd4: 54000060    	b.eq	0x1002a2de0 <__text+0x29ade0>
1002a2dd8: f94017e0    	ldr	x0, [sp, #0x28]
1002a2ddc: 95e610dd    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1002a2de0: f9401fe8    	ldr	x8, [sp, #0x38]
1002a2de4: f874791c    	ldr	x28, [x8, x20, lsl #3]
1002a2de8: f9452b00    	ldr	x0, [x24, #0xa50]
1002a2dec: aa1603e1    	mov	x1, x22
1002a2df0: 95e610d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2df4: aa0003e2    	mov	x2, x0
1002a2df8: aa1c03e0    	mov	x0, x28
1002a2dfc: aa1a03e1    	mov	x1, x26
1002a2e00: 95e610cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2e04: 340000c0    	cbz	w0, 0x1002a2e1c <__text+0x29ae1c>
1002a2e08: aa1c03e0    	mov	x0, x28
1002a2e0c: aa1b03e1    	mov	x1, x27
1002a2e10: 95e610cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2e14: f100141f    	cmp	x0, #0x5
1002a2e18: 540003a0    	b.eq	0x1002a2e8c <__text+0x29ae8c>
1002a2e1c: 91000694    	add	x20, x20, #0x1
1002a2e20: eb14033f    	cmp	x25, x20
1002a2e24: 54fffd21    	b.ne	0x1002a2dc8 <__text+0x29adc8>
1002a2e28: 9100c3e2    	add	x2, sp, #0x30
1002a2e2c: 9103c3e3    	add	x3, sp, #0xf0
1002a2e30: a94203e1    	ldp	x1, x0, [sp, #0x20]
1002a2e34: 52800204    	mov	w4, #0x10               ; =16
1002a2e38: 95e610c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2e3c: aa0003f9    	mov	x25, x0
1002a2e40: b00ff309    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
1002a2e44: b5fffb60    	cbnz	x0, 0x1002a2db0 <__text+0x29adb0>
1002a2e48: f94017f3    	ldr	x19, [sp, #0x28]
1002a2e4c: aa1303e0    	mov	x0, x19
1002a2e50: 95e610c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2e54: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2e58: f9421901    	ldr	x1, [x8, #0x430] ; moreMenuItem
1002a2e5c: f9400ffc    	ldr	x28, [sp, #0x18]
1002a2e60: aa1c03e0    	mov	x0, x28
1002a2e64: 95e610b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2e68: aa1d03fd    	mov	x29, x29
1002a2e6c: 95e610b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2e70: aa0003f6    	mov	x22, x0
1002a2e74: 900fdcc8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a2e78: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1002a2e7c: aa1303e0    	mov	x0, x19
1002a2e80: aa1603e2    	mov	x2, x22
1002a2e84: 95e610ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2e88: 14000003    	b	0x1002a2e94 <__text+0x29ae94>
1002a2e8c: f94017f6    	ldr	x22, [sp, #0x28]
1002a2e90: f9400ffc    	ldr	x28, [sp, #0x18]
1002a2e94: aa1603e0    	mov	x0, x22
1002a2e98: 95e610af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2e9c: f00fdcbb    	adrp	x27, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a2ea0: b00ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a2ea4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002a2ea8: d00ff2e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002a2eac: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1002a2eb0: 95e610a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2eb4: aa1d03fd    	mov	x29, x29
1002a2eb8: 95e610a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2ebc: aa0003f8    	mov	x24, x0
1002a2ec0: f00ff688    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1002a2ec4: f941c100    	ldr	x0, [x8, #0x380] ; ��+ 
1002a2ec8: b00ff2e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002a2ecc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002a2ed0: 95e6109b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2ed4: aa0003e2    	mov	x2, x0
1002a2ed8: f9464361    	ldr	x1, [x27, #0xc80] ; getService:
1002a2edc: aa1803e0    	mov	x0, x24
1002a2ee0: 95e61097    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2ee4: aa1d03fd    	mov	x29, x29
1002a2ee8: 95e61098    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2eec: aa0003f9    	mov	x25, x0
1002a2ef0: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2ef4: f9421d01    	ldr	x1, [x8, #0x438] ; enableTransferMsg
1002a2ef8: 95e61091    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2efc: 34001400    	cbz	w0, 0x1002a317c <__text+0x29b17c>
1002a2f00: aa1c03e0    	mov	x0, x28
1002a2f04: f9400bf3    	ldr	x19, [sp, #0x10]
1002a2f08: aa1303e1    	mov	x1, x19
1002a2f0c: 95e6108c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f10: aa1d03fd    	mov	x29, x29
1002a2f14: 95e6108d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2f18: aa0003fa    	mov	x26, x0
1002a2f1c: 900fdce8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a2f20: f941051c    	ldr	x28, [x8, #0x208] ; messageWrap
1002a2f24: aa1c03e1    	mov	x1, x28
1002a2f28: 95e61085    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f2c: aa1d03fd    	mov	x29, x29
1002a2f30: 95e61086    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2f34: aa0003fb    	mov	x27, x0
1002a2f38: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2f3c: f941d501    	ldr	x1, [x8, #0x3a8] ; IsTextMsg
1002a2f40: 95e6107f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f44: 370002a0    	tbnz	w0, #0x0, 0x1002a2f98 <__text+0x29af98>
1002a2f48: f9400ff4    	ldr	x20, [sp, #0x18]
1002a2f4c: aa1403e0    	mov	x0, x20
1002a2f50: aa1303e1    	mov	x1, x19
1002a2f54: 95e6107a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f58: aa1d03fd    	mov	x29, x29
1002a2f5c: 95e6107b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2f60: f90013e0    	str	x0, [sp, #0x20]
1002a2f64: aa1c03e1    	mov	x1, x28
1002a2f68: 95e61075    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f6c: aa1d03fd    	mov	x29, x29
1002a2f70: 95e61076    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a2f74: aa0003f6    	mov	x22, x0
1002a2f78: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2f7c: f9402101    	ldr	x1, [x8, #0x40] ; isAppMsgAppearAsTextMsg
1002a2f80: 95e6106f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2f84: 36001520    	tbz	w0, #0x0, 0x1002a3228 <__text+0x29b228>
1002a2f88: aa1603e0    	mov	x0, x22
1002a2f8c: 95e61072    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2f90: f94013e0    	ldr	x0, [sp, #0x20]
1002a2f94: 95e61070    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2f98: aa1b03e0    	mov	x0, x27
1002a2f9c: 95e6106e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2fa0: aa1a03e0    	mov	x0, x26
1002a2fa4: 95e6106c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2fa8: aa1903e0    	mov	x0, x25
1002a2fac: 95e6106a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2fb0: aa1803e0    	mov	x0, x24
1002a2fb4: 95e61068    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a2fb8: d00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2fbc: f9452900    	ldr	x0, [x8, #0xa50]
1002a2fc0: 95e61068    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1002a2fc4: 900fdd48    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a2fc8: f9422503    	ldr	x3, [x8, #0x448] ; onAskAsst:
1002a2fcc: b00fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a2fd0: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
1002a2fd4: 52800602    	mov	w2, #0x30               ; =48
1002a2fd8: 95e61059    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2fdc: aa0003f8    	mov	x24, x0
1002a2fe0: d00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a2fe4: f943b900    	ldr	x0, [x8, #0x770] ; ��+ 
1002a2fe8: 900ff348    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1002a2fec: f9437d16    	ldr	x22, [x8, #0x6f8] ; sharedInstance
1002a2ff0: aa1603e1    	mov	x1, x22
1002a2ff4: 95e61052    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a2ff8: aa1d03fd    	mov	x29, x29
1002a2ffc: 95e61053    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3000: aa0003f3    	mov	x19, x0
1002a3004: f00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a3008: f940fd01    	ldr	x1, [x8, #0x1f8] ; getString:
1002a300c: 900f10c2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a3010: 9124a042    	add	x2, x2, #0x928
1002a3014: 95e6104a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3018: aa1d03fd    	mov	x29, x29
1002a301c: 95e6104b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3020: aa0003f9    	mov	x25, x0
1002a3024: d00ff328    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1002a3028: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
1002a302c: aa1803e0    	mov	x0, x24
1002a3030: aa1903e2    	mov	x2, x25
1002a3034: 95e61042    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3038: aa1903e0    	mov	x0, x25
1002a303c: 95e61046    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3040: aa1303e0    	mov	x0, x19
1002a3044: 95e61044    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3048: 900ff694    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1002a304c: f9463293    	ldr	x19, [x20, #0xc60]
1002a3050: 900ff348    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1002a3054: f9479119    	ldr	x25, [x8, #0xf20] ; whiteColor
1002a3058: aa1303e0    	mov	x0, x19
1002a305c: aa1903e1    	mov	x1, x25
1002a3060: 95e61037    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3064: aa1d03fd    	mov	x29, x29
1002a3068: 95e61038    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a306c: aa0003fa    	mov	x26, x0
1002a3070: f9463280    	ldr	x0, [x20, #0xc60]
1002a3074: aa1903e1    	mov	x1, x25
1002a3078: 95e61031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a307c: aa1d03fd    	mov	x29, x29
1002a3080: 95e61032    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3084: aa0003fb    	mov	x27, x0
1002a3088: b00fdce8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1002a308c: f9409101    	ldr	x1, [x8, #0x120] ; Alpha0_8
1002a3090: 95e6102b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3094: aa1d03fd    	mov	x29, x29
1002a3098: 95e6102c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a309c: aa0003fc    	mov	x28, x0
1002a30a0: 900fdce8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002a30a4: f946bd01    	ldr	x1, [x8, #0xd78] ; colorInLightMode:DarkMode:
1002a30a8: aa1303e0    	mov	x0, x19
1002a30ac: aa1a03e2    	mov	x2, x26
1002a30b0: aa1c03e3    	mov	x3, x28
1002a30b4: 95e61022    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a30b8: aa1d03fd    	mov	x29, x29
1002a30bc: 95e61023    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a30c0: aa0003f9    	mov	x25, x0
1002a30c4: aa1c03e0    	mov	x0, x28
1002a30c8: f9400ffc    	ldr	x28, [sp, #0x18]
1002a30cc: 95e61022    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a30d0: aa1b03e0    	mov	x0, x27
1002a30d4: 95e61020    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a30d8: aa1a03e0    	mov	x0, x26
1002a30dc: 95e6101e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a30e0: 900ff688    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002a30e4: f9461900    	ldr	x0, [x8, #0xc30]
1002a30e8: d00fdca8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002a30ec: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
1002a30f0: 1e669000    	fmov	d0, #20.00000000
1002a30f4: 95e61012    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a30f8: 1e604008    	fmov	d8, d0
1002a30fc: b00ff688    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002a3100: f943b900    	ldr	x0, [x8, #0x770] ; ��+ 
1002a3104: aa1603e1    	mov	x1, x22
1002a3108: 95e6100d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a310c: aa1d03fd    	mov	x29, x29
1002a3110: 95e6100e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3114: aa0003f3    	mov	x19, x0
1002a3118: f00fdcc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002a311c: f9409d01    	ldr	x1, [x8, #0x138] ; getSvg:size:color:
1002a3120: 900f10c2    	adrp	x2, 0x11e4bb000 <dyld_stub_binder+0x11e4bb000>
1002a3124: 91252042    	add	x2, x2, #0x948
1002a3128: 1e604100    	fmov	d0, d8
1002a312c: 1e604101    	fmov	d1, d8
1002a3130: aa1903e3    	mov	x3, x25
1002a3134: 95e61002    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3138: aa1d03fd    	mov	x29, x29
1002a313c: 95e61003    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3140: aa0003f6    	mov	x22, x0
1002a3144: f00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a3148: f9422901    	ldr	x1, [x8, #0x450] ; setIconImage:
1002a314c: aa1803e0    	mov	x0, x24
1002a3150: aa1603e2    	mov	x2, x22
1002a3154: 95e60ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3158: aa1603e0    	mov	x0, x22
1002a315c: 95e60ffe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3160: aa1303e0    	mov	x0, x19
1002a3164: 95e60ffc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3168: f00fdca8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1002a316c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1002a3170: f94017e0    	ldr	x0, [sp, #0x28]
1002a3174: aa1803e2    	mov	x2, x24
1002a3178: 95e60ff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a317c: aa1903e0    	mov	x0, x25
1002a3180: 95e60ff5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3184: aa1803e0    	mov	x0, x24
1002a3188: 95e60ff3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a318c: f00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a3190: f9422d01    	ldr	x1, [x8, #0x458] ; canShowFTSIndexMenuItem
1002a3194: aa1c03e0    	mov	x0, x28
1002a3198: 95e60fe9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a319c: 340001e0    	cbz	w0, 0x1002a31d8 <__text+0x29b1d8>
1002a31a0: f00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a31a4: f9423101    	ldr	x1, [x8, #0x460] ; showFTSIndexMenuItem
1002a31a8: aa1c03e0    	mov	x0, x28
1002a31ac: 95e60fe4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a31b0: aa1d03fd    	mov	x29, x29
1002a31b4: 95e60fe5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a31b8: aa0003f3    	mov	x19, x0
1002a31bc: f00ff2c8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1002a31c0: f946f501    	ldr	x1, [x8, #0xde8] ; addObject:
1002a31c4: f94017e0    	ldr	x0, [sp, #0x28]
1002a31c8: aa1303e2    	mov	x2, x19
1002a31cc: 95e60fdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a31d0: aa1303e0    	mov	x0, x19
1002a31d4: 95e60fe0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a31d8: aa1703e0    	mov	x0, x23
1002a31dc: 95e60fde    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a31e0: aa1503e0    	mov	x0, x21
1002a31e4: 95e60fdc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a31e8: f94017e0    	ldr	x0, [sp, #0x28]
1002a31ec: f85903a8    	ldur	x8, [x29, #-0x70]
1002a31f0: 900e9a69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1002a31f4: f9405929    	ldr	x9, [x9, #0xb0]
1002a31f8: f9400129    	ldr	x9, [x9]
1002a31fc: eb08013f    	cmp	x9, x8
1002a3200: 540005a1    	b.ne	0x1002a32b4 <__text+0x29b2b4>
1002a3204: 910b43ff    	add	sp, sp, #0x2d0
1002a3208: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1002a320c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1002a3210: a94457f6    	ldp	x22, x21, [sp, #0x40]
1002a3214: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1002a3218: a94267fa    	ldp	x26, x25, [sp, #0x20]
1002a321c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1002a3220: 6cc723e9    	ldp	d9, d8, [sp], #0x70
1002a3224: 15e60fd3    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1002a3228: aa1403e0    	mov	x0, x20
1002a322c: aa1303e1    	mov	x1, x19
1002a3230: 95e60fc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3234: aa1d03fd    	mov	x29, x29
1002a3238: 95e60fc4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a323c: aa0003f3    	mov	x19, x0
1002a3240: aa1c03e1    	mov	x1, x28
1002a3244: 95e60fbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3248: aa1d03fd    	mov	x29, x29
1002a324c: 95e60fbf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002a3250: aa0003fc    	mov	x28, x0
1002a3254: f00fdd28    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002a3258: f9422101    	ldr	x1, [x8, #0x440] ; IsUrlMessage
1002a325c: 95e60fb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002a3260: b90013e0    	str	w0, [sp, #0x10]
1002a3264: aa1c03e0    	mov	x0, x28
1002a3268: 95e60fbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a326c: aa1303e0    	mov	x0, x19
1002a3270: 95e60fb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3274: aa1603e0    	mov	x0, x22
1002a3278: 95e60fb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a327c: f94013e0    	ldr	x0, [sp, #0x20]
1002a3280: 95e60fb5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3284: aa1b03e0    	mov	x0, x27
1002a3288: 95e60fb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a328c: aa1a03e0    	mov	x0, x26
1002a3290: 95e60fb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a3294: aa1903e0    	mov	x0, x25
1002a3298: 95e60faf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a329c: aa1803e0    	mov	x0, x24
1002a32a0: 95e60fad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002a32a4: aa1403fc    	mov	x28, x20
1002a32a8: b94013e8    	ldr	w8, [sp, #0x10]
1002a32ac: 3707e868    	tbnz	w8, #0x0, 0x1002a2fb8 <__text+0x29afb8>
1002a32b0: 17ffffb7    	b	0x1002a318c <__text+0x29b18c>
1002a32b4: 95e60fb0    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>