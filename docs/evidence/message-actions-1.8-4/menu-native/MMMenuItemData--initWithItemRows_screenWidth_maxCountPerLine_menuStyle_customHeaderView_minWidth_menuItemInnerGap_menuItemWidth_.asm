
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1166d9fbc: 6db82beb    	stp	d11, d10, [sp, #-0x80]!
1166d9fc0: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1166d9fc4: a9026ffc    	stp	x28, x27, [sp, #0x20]
1166d9fc8: a90367fa    	stp	x26, x25, [sp, #0x30]
1166d9fcc: a9045ff8    	stp	x24, x23, [sp, #0x40]
1166d9fd0: a90557f6    	stp	x22, x21, [sp, #0x50]
1166d9fd4: a9064ff4    	stp	x20, x19, [sp, #0x60]
1166d9fd8: a9077bfd    	stp	x29, x30, [sp, #0x70]
1166d9fdc: 9101c3fd    	add	x29, sp, #0x70
1166d9fe0: d10c83ff    	sub	sp, sp, #0x320
1166d9fe4: 1e604068    	fmov	d8, d3
1166d9fe8: 1e604049    	fmov	d9, d2
1166d9fec: 1e60402a    	fmov	d10, d1
1166d9ff0: aa0503f4    	mov	x20, x5
1166d9ff4: aa0403f7    	mov	x23, x4
1166d9ff8: aa0303f6    	mov	x22, x3
1166d9ffc: 1e60400b    	fmov	d11, d0
1166da000: aa0203f9    	mov	x25, x2
1166da004: aa0003f3    	mov	x19, x0
1166da008: b00378a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1166da00c: f9405908    	ldr	x8, [x8, #0xb0]
1166da010: f9400108    	ldr	x8, [x8]
1166da014: f81803a8    	stur	x8, [x29, #-0x80]
1166da018: aa0203e0    	mov	x0, x2
1166da01c: 94713f55    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1166da020: aa1403e0    	mov	x0, x20
1166da024: 94713f53    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1166da028: 9004d808    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1166da02c: f9452908    	ldr	x8, [x8, #0xa50] ; �@c
1166da030: a917a3f3    	stp	x19, x8, [sp, #0x178]
1166da034: 9004d148    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1166da038: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1166da03c: 9105e3e0    	add	x0, sp, #0x178
1166da040: 94713f2e    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1166da044: aa0003f5    	mov	x21, x0
1166da048: b4002b80    	cbz	x0, 0x1166da5b8 <_O266DecReleaseOutputPicture+0x344db00>
1166da04c: a9025ff4    	stp	x20, x23, [sp, #0x20]
1166da050: a90157f6    	stp	x22, x21, [sp, #0x10]
1166da054: b004d4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166da058: f9455500    	ldr	x0, [x8, #0xaa8]
1166da05c: 94713ecd    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
1166da060: f9002fe0    	str	x0, [sp, #0x58]
1166da064: 4f00e400    	movi.16b	v0, #0x0
1166da068: ad0983e0    	stp	q0, q0, [sp, #0x130]
1166da06c: ad0a83e0    	stp	q0, q0, [sp, #0x150]
1166da070: aa1903e0    	mov	x0, x25
1166da074: 94713f3f    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1166da078: d004d128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1166da07c: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1166da080: 9104c3e2    	add	x2, sp, #0x130
1166da084: d10403a3    	sub	x3, x29, #0x100
1166da088: f9003be1    	str	x1, [sp, #0x70]
1166da08c: 52800204    	mov	w4, #0x10               ; =16
1166da090: 94713f17    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da094: b40017a0    	cbz	x0, 0x1166da388 <_O266DecReleaseOutputPicture+0x344d8d0>
1166da098: aa0003f3    	mov	x19, x0
1166da09c: f940a3e8    	ldr	x8, [sp, #0x140]
1166da0a0: f9400114    	ldr	x20, [x8]
1166da0a4: b004d4d5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
1166da0a8: d004d4db    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
1166da0ac: a90367f4    	stp	x20, x25, [sp, #0x30]
1166da0b0: d2800016    	mov	x22, #0x0               ; =0
1166da0b4: b004d128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166da0b8: f947ad17    	ldr	x23, [x8, #0xf58] ; class
1166da0bc: b004d148    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1166da0c0: f9442d18    	ldr	x24, [x8, #0x858] ; isKindOfClass:
1166da0c4: d004d128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1166da0c8: f9435108    	ldr	x8, [x8, #0x6a0] ; count
1166da0cc: f90033e8    	str	x8, [sp, #0x60]
1166da0d0: b004d128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166da0d4: f941a109    	ldr	x9, [x8, #0x340] ; array
1166da0d8: 9004d128    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1166da0dc: f946f508    	ldr	x8, [x8, #0xde8] ; addObject:
1166da0e0: a90427e8    	stp	x8, x9, [sp, #0x40]
1166da0e4: f9002bf3    	str	x19, [sp, #0x50]
1166da0e8: f940a3e8    	ldr	x8, [sp, #0x140]
1166da0ec: f9400108    	ldr	x8, [x8]
1166da0f0: eb14011f    	cmp	x8, x20
1166da0f4: 54000060    	b.eq	0x1166da100 <_O266DecReleaseOutputPicture+0x344d648>
1166da0f8: aa1903e0    	mov	x0, x25
1166da0fc: 94713ecf    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1166da100: f9409fe8    	ldr	x8, [sp, #0x138]
1166da104: f876791a    	ldr	x26, [x8, x22, lsl #3]
1166da108: f9456ea0    	ldr	x0, [x21, #0xad8]
1166da10c: aa1703e1    	mov	x1, x23
1166da110: 94713ef7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da114: aa0003e2    	mov	x2, x0
1166da118: aa1a03e0    	mov	x0, x26
1166da11c: aa1803e1    	mov	x1, x24
1166da120: 94713ef3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da124: 340011c0    	cbz	w0, 0x1166da35c <_O266DecReleaseOutputPicture+0x344d8a4>
1166da128: aa1a03e0    	mov	x0, x26
1166da12c: f94033e1    	ldr	x1, [sp, #0x60]
1166da130: 94713eef    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da134: b4001140    	cbz	x0, 0x1166da35c <_O266DecReleaseOutputPicture+0x344d8a4>
1166da138: f90037f6    	str	x22, [sp, #0x68]
1166da13c: b004d4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166da140: f9455500    	ldr	x0, [x8, #0xaa8]
1166da144: f94027e1    	ldr	x1, [sp, #0x48]
1166da148: 94713ee9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da14c: aa1d03fd    	mov	x29, x29
1166da150: 94713f11    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166da154: f90053e0    	str	x0, [sp, #0xa0]
1166da158: 4f00e400    	movi.16b	v0, #0x0
1166da15c: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1166da160: ad0883e0    	stp	q0, q0, [sp, #0x110]
1166da164: aa1a03e0    	mov	x0, x26
1166da168: 94713f02    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1166da16c: 9103c3e2    	add	x2, sp, #0xf0
1166da170: 910843e3    	add	x3, sp, #0x210
1166da174: f9403be1    	ldr	x1, [sp, #0x70]
1166da178: 52800204    	mov	w4, #0x10               ; =16
1166da17c: 94713edc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da180: aa1a03f3    	mov	x19, x26
1166da184: b4000d20    	cbz	x0, 0x1166da328 <_O266DecReleaseOutputPicture+0x344d870>
1166da188: aa0003f6    	mov	x22, x0
1166da18c: f94083e8    	ldr	x8, [sp, #0x100]
1166da190: f940011c    	ldr	x28, [x8]
1166da194: d2800014    	mov	x20, #0x0               ; =0
1166da198: f004bb08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1166da19c: f940f509    	ldr	x9, [x8, #0x1e8] ; externalIMP
1166da1a0: f004bae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1166da1a4: f942a908    	ldr	x8, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1166da1a8: a90927e8    	stp	x8, x9, [sp, #0x90]
1166da1ac: b004d188    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1166da1b0: f940d109    	ldr	x9, [x8, #0x1a0] ; title
1166da1b4: 9004bb88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1166da1b8: f9429508    	ldr	x8, [x8, #0x528] ; action
1166da1bc: a90827e8    	stp	x8, x9, [sp, #0x80]
1166da1c0: d004bb68    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
1166da1c4: f9429508    	ldr	x8, [x8, #0x528] ; initWithTitle:action:
1166da1c8: f9003fe8    	str	x8, [sp, #0x78]
1166da1cc: 9004d128    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1166da1d0: f946f508    	ldr	x8, [x8, #0xde8] ; addObject:
1166da1d4: f90057e8    	str	x8, [sp, #0xa8]
1166da1d8: f94083e8    	ldr	x8, [sp, #0x100]
1166da1dc: f9400108    	ldr	x8, [x8]
1166da1e0: eb1c011f    	cmp	x8, x28
1166da1e4: 54000060    	b.eq	0x1166da1f0 <_O266DecReleaseOutputPicture+0x344d738>
1166da1e8: aa1303e0    	mov	x0, x19
1166da1ec: 94713e93    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1166da1f0: f9407fe8    	ldr	x8, [sp, #0xf8]
1166da1f4: f874791a    	ldr	x26, [x8, x20, lsl #3]
1166da1f8: f9452b60    	ldr	x0, [x27, #0xa50]
1166da1fc: aa1703e1    	mov	x1, x23
1166da200: 94713ebb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da204: aa0003e2    	mov	x2, x0
1166da208: aa1a03e0    	mov	x0, x26
1166da20c: aa1803e1    	mov	x1, x24
1166da210: 94713eb7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da214: 340000a0    	cbz	w0, 0x1166da228 <_O266DecReleaseOutputPicture+0x344d770>
1166da218: a94a07e0    	ldp	x0, x1, [sp, #0xa0]
1166da21c: aa1a03e2    	mov	x2, x26
1166da220: 94713eb3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da224: 14000036    	b	0x1166da2fc <_O266DecReleaseOutputPicture+0x344d844>
1166da228: f004d4c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1166da22c: f946cd00    	ldr	x0, [x8, #0xd98]
1166da230: aa1703e1    	mov	x1, x23
1166da234: 94713eae    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da238: aa0003e2    	mov	x2, x0
1166da23c: aa1a03e0    	mov	x0, x26
1166da240: aa1803e1    	mov	x1, x24
1166da244: 94713eaa    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da248: 340005a0    	cbz	w0, 0x1166da2fc <_O266DecReleaseOutputPicture+0x344d844>
1166da24c: 9004d688    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1166da250: f9448500    	ldr	x0, [x8, #0x908] ; @�b
1166da254: f9404fe1    	ldr	x1, [sp, #0x98]
1166da258: 94713ea5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da25c: 90042488    	adrp	x8, 0x11eb6a000 <dyld_stub_binder+0x11eb6a000>
1166da260: 91062108    	add	x8, x8, #0x188
1166da264: f90003e8    	str	x8, [sp]
1166da268: f9404be1    	ldr	x1, [sp, #0x90]
1166da26c: 52800062    	mov	w2, #0x3                ; =3
1166da270: d2800003    	mov	x3, #0x0                ; =0
1166da274: 52800004    	mov	w4, #0x0                ; =0
1166da278: d0030f45    	adrp	x5, 0x11c8c4000 <dyld_stub_binder+0x11c8c4000>
1166da27c: 912b34a5    	add	x5, x5, #0xacd
1166da280: 52801286    	mov	w6, #0x94               ; =148
1166da284: d0030f47    	adrp	x7, 0x11c8c4000 <dyld_stub_binder+0x11c8c4000>
1166da288: 912b7ce7    	add	x7, x7, #0xadf
1166da28c: 94713e98    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da290: f9452b60    	ldr	x0, [x27, #0xa50]
1166da294: 94713e39    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1166da298: aa0003f9    	mov	x25, x0
1166da29c: aa1a03e0    	mov	x0, x26
1166da2a0: f94047e1    	ldr	x1, [sp, #0x88]
1166da2a4: 94713e92    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da2a8: aa1d03fd    	mov	x29, x29
1166da2ac: 94713eba    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166da2b0: aa1b03f5    	mov	x21, x27
1166da2b4: aa0003fb    	mov	x27, x0
1166da2b8: aa1a03e0    	mov	x0, x26
1166da2bc: f94043e1    	ldr	x1, [sp, #0x80]
1166da2c0: 94713e8b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da2c4: aa0003e3    	mov	x3, x0
1166da2c8: aa1903e0    	mov	x0, x25
1166da2cc: f9403fe1    	ldr	x1, [sp, #0x78]
1166da2d0: aa1b03e2    	mov	x2, x27
1166da2d4: 94713e86    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da2d8: aa0003f9    	mov	x25, x0
1166da2dc: a94a07e0    	ldp	x0, x1, [sp, #0xa0]
1166da2e0: aa1903e2    	mov	x2, x25
1166da2e4: 94713e82    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da2e8: aa1903e0    	mov	x0, x25
1166da2ec: 94713e9b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da2f0: aa1b03e0    	mov	x0, x27
1166da2f4: aa1503fb    	mov	x27, x21
1166da2f8: 94713e98    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da2fc: 91000694    	add	x20, x20, #0x1
1166da300: eb1402df    	cmp	x22, x20
1166da304: 54fff6a1    	b.ne	0x1166da1d8 <_O266DecReleaseOutputPicture+0x344d720>
1166da308: 9103c3e2    	add	x2, sp, #0xf0
1166da30c: 910843e3    	add	x3, sp, #0x210
1166da310: aa1303e0    	mov	x0, x19
1166da314: f9403be1    	ldr	x1, [sp, #0x70]
1166da318: 52800204    	mov	w4, #0x10               ; =16
1166da31c: 94713e74    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da320: aa0003f6    	mov	x22, x0
1166da324: b5fff380    	cbnz	x0, 0x1166da194 <_O266DecReleaseOutputPicture+0x344d6dc>
1166da328: aa1303e0    	mov	x0, x19
1166da32c: 94713e8b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da330: f9402fe0    	ldr	x0, [sp, #0x58]
1166da334: f94023e1    	ldr	x1, [sp, #0x40]
1166da338: f94053f3    	ldr	x19, [sp, #0xa0]
1166da33c: aa1303e2    	mov	x2, x19
1166da340: 94713e6b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da344: aa1303e0    	mov	x0, x19
1166da348: 94713e84    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da34c: a94367f4    	ldp	x20, x25, [sp, #0x30]
1166da350: f9402bf3    	ldr	x19, [sp, #0x50]
1166da354: b004d4d5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
1166da358: f94037f6    	ldr	x22, [sp, #0x68]
1166da35c: 910006d6    	add	x22, x22, #0x1
1166da360: eb1302df    	cmp	x22, x19
1166da364: 54ffec21    	b.ne	0x1166da0e8 <_O266DecReleaseOutputPicture+0x344d630>
1166da368: 9104c3e2    	add	x2, sp, #0x130
1166da36c: d10403a3    	sub	x3, x29, #0x100
1166da370: aa1903e0    	mov	x0, x25
1166da374: f9403be1    	ldr	x1, [sp, #0x70]
1166da378: 52800204    	mov	w4, #0x10               ; =16
1166da37c: 94713e5c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da380: aa0003f3    	mov	x19, x0
1166da384: b5ffe960    	cbnz	x0, 0x1166da0b0 <_O266DecReleaseOutputPicture+0x344d5f8>
1166da388: aa1903e0    	mov	x0, x25
1166da38c: 94713e73    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da390: f94017f4    	ldr	x20, [sp, #0x28]
1166da394: b4000134    	cbz	x20, 0x1166da3b8 <_O266DecReleaseOutputPicture+0x344d900>
1166da398: d004d128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1166da39c: f9431501    	ldr	x1, [x8, #0x628] ; copy
1166da3a0: f9402fe0    	ldr	x0, [sp, #0x58]
1166da3a4: 94713e52    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da3a8: f9400ff5    	ldr	x21, [sp, #0x18]
1166da3ac: f9401ab3    	ldr	x19, [x21, #0x30]
1166da3b0: f9001aa0    	str	x0, [x21, #0x30]
1166da3b4: 14000047    	b	0x1166da4d0 <_O266DecReleaseOutputPicture+0x344da18>
1166da3b8: d004d128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1166da3bc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1166da3c0: f9402fe0    	ldr	x0, [sp, #0x58]
1166da3c4: 94713e4a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da3c8: b4fffe80    	cbz	x0, 0x1166da398 <_O266DecReleaseOutputPicture+0x344d8e0>
1166da3cc: b004d4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166da3d0: f9455500    	ldr	x0, [x8, #0xaa8]
1166da3d4: b004d128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166da3d8: f941a101    	ldr	x1, [x8, #0x340] ; array
1166da3dc: 94713e44    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da3e0: aa1d03fd    	mov	x29, x29
1166da3e4: 94713e6c    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166da3e8: aa0003f3    	mov	x19, x0
1166da3ec: 4f00e400    	movi.16b	v0, #0x0
1166da3f0: ad0583e0    	stp	q0, q0, [sp, #0xb0]
1166da3f4: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1166da3f8: f9402fe0    	ldr	x0, [sp, #0x58]
1166da3fc: 94713e5d    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1166da400: 9102c3e2    	add	x2, sp, #0xb0
1166da404: 910643e3    	add	x3, sp, #0x190
1166da408: f9403be1    	ldr	x1, [sp, #0x70]
1166da40c: 52800204    	mov	w4, #0x10               ; =16
1166da410: 94713e37    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da414: b40003a0    	cbz	x0, 0x1166da488 <_O266DecReleaseOutputPicture+0x344d9d0>
1166da418: aa0003f4    	mov	x20, x0
1166da41c: f94063e8    	ldr	x8, [sp, #0xc0]
1166da420: f9400116    	ldr	x22, [x8]
1166da424: 9004d137    	adrp	x23, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1166da428: d2800018    	mov	x24, #0x0               ; =0
1166da42c: f946faf5    	ldr	x21, [x23, #0xdf0] ; addObjectsFromArray:
1166da430: f94063e8    	ldr	x8, [sp, #0xc0]
1166da434: f9400108    	ldr	x8, [x8]
1166da438: eb16011f    	cmp	x8, x22
1166da43c: 54000060    	b.eq	0x1166da448 <_O266DecReleaseOutputPicture+0x344d990>
1166da440: f9402fe0    	ldr	x0, [sp, #0x58]
1166da444: 94713dfd    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1166da448: f9405fe8    	ldr	x8, [sp, #0xb8]
1166da44c: f8787902    	ldr	x2, [x8, x24, lsl #3]
1166da450: aa1303e0    	mov	x0, x19
1166da454: aa1503e1    	mov	x1, x21
1166da458: 94713e25    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da45c: 91000718    	add	x24, x24, #0x1
1166da460: eb18029f    	cmp	x20, x24
1166da464: 54fffe61    	b.ne	0x1166da430 <_O266DecReleaseOutputPicture+0x344d978>
1166da468: 9102c3e2    	add	x2, sp, #0xb0
1166da46c: 910643e3    	add	x3, sp, #0x190
1166da470: f9402fe0    	ldr	x0, [sp, #0x58]
1166da474: f9403be1    	ldr	x1, [sp, #0x70]
1166da478: 52800204    	mov	w4, #0x10               ; =16
1166da47c: 94713e1c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da480: aa0003f4    	mov	x20, x0
1166da484: b5fffd20    	cbnz	x0, 0x1166da428 <_O266DecReleaseOutputPicture+0x344d970>
1166da488: f9402fe0    	ldr	x0, [sp, #0x58]
1166da48c: 94713e33    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da490: f900c7f3    	str	x19, [sp, #0x188]
1166da494: b004d4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166da498: f9456d00    	ldr	x0, [x8, #0xad8]
1166da49c: b004d128    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166da4a0: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1166da4a4: 910623e2    	add	x2, sp, #0x188
1166da4a8: 52800023    	mov	w3, #0x1                ; =1
1166da4ac: 94713e10    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da4b0: aa1d03fd    	mov	x29, x29
1166da4b4: 94713e38    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166da4b8: f9400ff5    	ldr	x21, [sp, #0x18]
1166da4bc: f9401aa8    	ldr	x8, [x21, #0x30]
1166da4c0: f9001aa0    	str	x0, [x21, #0x30]
1166da4c4: aa0803e0    	mov	x0, x8
1166da4c8: 94713e24    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da4cc: f94017f4    	ldr	x20, [sp, #0x28]
1166da4d0: aa1303e0    	mov	x0, x19
1166da4d4: 94713e21    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da4d8: f9000eb4    	str	x20, [x21, #0x18]
1166da4dc: f0037888    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
1166da4e0: f9417908    	ldr	x8, [x8, #0x2f0]
1166da4e4: 3dc00100    	ldr	q0, [x8]
1166da4e8: 3c8682a0    	stur	q0, [x21, #0x68]
1166da4ec: fd001eab    	str	d11, [x21, #0x38]
1166da4f0: f9400be8    	ldr	x8, [sp, #0x10]
1166da4f4: f90016a8    	str	x8, [x21, #0x28]
1166da4f8: 910082a0    	add	x0, x21, #0x20
1166da4fc: f94013f4    	ldr	x20, [sp, #0x20]
1166da500: aa1403e1    	mov	x1, x20
1166da504: 94713e3f    	bl	0x118329e00 <dyld_stub_binder+0x118329e00>
1166da508: fd0022aa    	str	d10, [x21, #0x40]
1166da50c: 1e602128    	fcmp	d9, #0.0
1166da510: 540002aa    	b.ge	0x1166da564 <_O266DecReleaseOutputPicture+0x344daac>
1166da514: 9004d4e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1166da518: f940a500    	ldr	x0, [x8, #0x148]
1166da51c: d004bba8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1166da520: f941b101    	ldr	x1, [x8, #0x360] ; lastActiveSceneRootWindow
1166da524: 94713df2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da528: aa1d03fd    	mov	x29, x29
1166da52c: 94713e1a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166da530: aa0003f3    	mov	x19, x0
1166da534: b004d188    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1166da538: f947a501    	ldr	x1, [x8, #0xf48] ; width
1166da53c: 94713dec    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da540: 1e604009    	fmov	d9, d0
1166da544: aa1303e0    	mov	x0, x19
1166da548: 94713e04    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da54c: f0013528    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1166da550: fd440900    	ldr	d0, [x8, #0x810]
1166da554: 1e602120    	fcmp	d9, d0
1166da558: 540000ad    	b.le	0x1166da56c <_O266DecReleaseOutputPicture+0x344dab4>
1166da55c: d2e80408    	mov	x8, #0x4020000000000000 ; =4620693217682128896
1166da560: 14000004    	b	0x1166da570 <_O266DecReleaseOutputPicture+0x344dab8>
1166da564: fd0026a9    	str	d9, [x21, #0x48]
1166da568: 14000003    	b	0x1166da574 <_O266DecReleaseOutputPicture+0x344dabc>
1166da56c: d2e80208    	mov	x8, #0x4010000000000000 ; =4616189618054758400
1166da570: f90026a8    	str	x8, [x21, #0x48]
1166da574: 1e602108    	fcmp	d8, #0.0
1166da578: 5400012c    	b.gt	0x1166da59c <_O266DecReleaseOutputPicture+0x344dae4>
1166da57c: b004d4c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166da580: f9461900    	ldr	x0, [x8, #0xc30]
1166da584: f004bae8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1166da588: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
1166da58c: d2e809a8    	mov	x8, #0x404d000000000000 ; =4633359591634108416
1166da590: 9e670100    	fmov	d0, x8
1166da594: 94713dd6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da598: 1e604008    	fmov	d8, d0
1166da59c: fd002aa8    	str	d8, [x21, #0x50]
1166da5a0: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166da5a4: f946ad01    	ldr	x1, [x8, #0xd58] ; calculateMenuLayout
1166da5a8: aa1503e0    	mov	x0, x21
1166da5ac: 94713dd0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166da5b0: f9402fe0    	ldr	x0, [sp, #0x58]
1166da5b4: 94713de9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da5b8: aa1403e0    	mov	x0, x20
1166da5bc: 94713de7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da5c0: aa1903e0    	mov	x0, x25
1166da5c4: 94713de5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166da5c8: f85803a8    	ldur	x8, [x29, #-0x80]
1166da5cc: b00378a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1166da5d0: f9405929    	ldr	x9, [x9, #0xb0]
1166da5d4: f9400129    	ldr	x9, [x9]
1166da5d8: eb08013f    	cmp	x9, x8
1166da5dc: 54000181    	b.ne	0x1166da60c <_O266DecReleaseOutputPicture+0x344db54>
1166da5e0: aa1503e0    	mov	x0, x21
1166da5e4: 910c83ff    	add	sp, sp, #0x320
1166da5e8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1166da5ec: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1166da5f0: a94557f6    	ldp	x22, x21, [sp, #0x50]
1166da5f4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1166da5f8: a94367fa    	ldp	x26, x25, [sp, #0x30]
1166da5fc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
1166da600: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
1166da604: 6cc82beb    	ldp	d11, d10, [sp], #0x80
1166da608: d65f03c0    	ret
1166da60c: 947130bc    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>