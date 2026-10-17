
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1165e0f34: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1165e0f38: a90167fa    	stp	x26, x25, [sp, #0x10]
1165e0f3c: a9025ff8    	stp	x24, x23, [sp, #0x20]
1165e0f40: a90357f6    	stp	x22, x21, [sp, #0x30]
1165e0f44: a9044ff4    	stp	x20, x19, [sp, #0x40]
1165e0f48: a9057bfd    	stp	x29, x30, [sp, #0x50]
1165e0f4c: 910143fd    	add	x29, sp, #0x50
1165e0f50: d10903ff    	sub	sp, sp, #0x240
1165e0f54: aa0203f3    	mov	x19, x2
1165e0f58: f90013e0    	str	x0, [sp, #0x20]
1165e0f5c: f0038068    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1165e0f60: f9405908    	ldr	x8, [x8, #0xb0]
1165e0f64: f9400108    	ldr	x8, [x8]
1165e0f68: f81a03a8    	stur	x8, [x29, #-0x60]
1165e0f6c: aa0203e0    	mov	x0, x2
1165e0f70: 94752380    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e0f74: f004dc88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1165e0f78: f9455500    	ldr	x0, [x8, #0xaa8]
1165e0f7c: f004d8e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1165e0f80: f941a101    	ldr	x1, [x8, #0x340] ; array
1165e0f84: f90027e1    	str	x1, [sp, #0x48]
1165e0f88: 94752359    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e0f8c: aa1d03fd    	mov	x29, x29
1165e0f90: 94752381    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e0f94: f9001be0    	str	x0, [sp, #0x30]
1165e0f98: 4f00e400    	movi.16b	v0, #0x0
1165e0f9c: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1165e0fa0: ad0883e0    	stp	q0, q0, [sp, #0x110]
1165e0fa4: aa1303e0    	mov	x0, x19
1165e0fa8: 94752372    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e0fac: 9004d908    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1165e0fb0: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1165e0fb4: 9103c3e2    	add	x2, sp, #0xf0
1165e0fb8: d10383a3    	sub	x3, x29, #0xe0
1165e0fbc: f90017f3    	str	x19, [sp, #0x28]
1165e0fc0: f90037e1    	str	x1, [sp, #0x68]
1165e0fc4: 52800204    	mov	w4, #0x10               ; =16
1165e0fc8: 94752349    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e0fcc: f9002fe0    	str	x0, [sp, #0x58]
1165e0fd0: b4001a60    	cbz	x0, 0x1165e131c <_O266DecReleaseOutputPicture+0x3354864>
1165e0fd4: f94083e8    	ldr	x8, [sp, #0x100]
1165e0fd8: f9400108    	ldr	x8, [x8]
1165e0fdc: f90023e8    	str	x8, [sp, #0x40]
1165e0fe0: 9004dcbb    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
1165e0fe4: b004dcb3    	adrp	x19, 0x120175000 <dyld_stub_binder+0x120175000>
1165e0fe8: d2800014    	mov	x20, #0x0               ; =0
1165e0fec: 9004d908    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1165e0ff0: f9435108    	ldr	x8, [x8, #0x6a0] ; count
1165e0ff4: f9002be8    	str	x8, [sp, #0x50]
1165e0ff8: d004d8e8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1165e0ffc: f946f508    	ldr	x8, [x8, #0xde8] ; addObject:
1165e1000: f9001fe8    	str	x8, [sp, #0x38]
1165e1004: f94083e8    	ldr	x8, [sp, #0x100]
1165e1008: f9400108    	ldr	x8, [x8]
1165e100c: f94023e9    	ldr	x9, [sp, #0x40]
1165e1010: eb09011f    	cmp	x8, x9
1165e1014: 54000060    	b.eq	0x1165e1020 <_O266DecReleaseOutputPicture+0x3354568>
1165e1018: f94017e0    	ldr	x0, [sp, #0x28]
1165e101c: 94752307    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1165e1020: f9407fe8    	ldr	x8, [sp, #0xf8]
1165e1024: f90033f4    	str	x20, [sp, #0x60]
1165e1028: f8747917    	ldr	x23, [x8, x20, lsl #3]
1165e102c: d004dc88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1165e1030: f9455500    	ldr	x0, [x8, #0xaa8]
1165e1034: f94027e1    	ldr	x1, [sp, #0x48]
1165e1038: 9475232d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e103c: aa1d03fd    	mov	x29, x29
1165e1040: 94752355    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1044: aa0003f8    	mov	x24, x0
1165e1048: 4f00e400    	movi.16b	v0, #0x0
1165e104c: ad0583e0    	stp	q0, q0, [sp, #0xb0]
1165e1050: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1165e1054: aa1703e0    	mov	x0, x23
1165e1058: 94752346    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e105c: 9102c3e2    	add	x2, sp, #0xb0
1165e1060: 9104c3e3    	add	x3, sp, #0x130
1165e1064: f94037e1    	ldr	x1, [sp, #0x68]
1165e1068: 52800204    	mov	w4, #0x10               ; =16
1165e106c: 94752320    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1070: b4001280    	cbz	x0, 0x1165e12c0 <_O266DecReleaseOutputPicture+0x3354808>
1165e1074: aa0003fa    	mov	x26, x0
1165e1078: f94063e8    	ldr	x8, [sp, #0xc0]
1165e107c: f9400115    	ldr	x21, [x8]
1165e1080: d2800014    	mov	x20, #0x0               ; =0
1165e1084: d004d8e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1165e1088: f947ad1c    	ldr	x28, [x8, #0xf58] ; class
1165e108c: d004d908    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1165e1090: f9442d16    	ldr	x22, [x8, #0x858] ; isKindOfClass:
1165e1094: 9004c2e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1165e1098: f940f509    	ldr	x9, [x8, #0x1e8] ; externalIMP
1165e109c: d004d948    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1165e10a0: f940d10a    	ldr	x10, [x8, #0x1a0] ; title
1165e10a4: b004c348    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1165e10a8: f9429508    	ldr	x8, [x8, #0x528] ; action
1165e10ac: a909abe8    	stp	x8, x10, [sp, #0x98]
1165e10b0: 9004c2c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1165e10b4: f942a908    	ldr	x8, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1165e10b8: a907a7e8    	stp	x8, x9, [sp, #0x78]
1165e10bc: f004c328    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
1165e10c0: f9429508    	ldr	x8, [x8, #0x528] ; initWithTitle:action:
1165e10c4: f9003be8    	str	x8, [sp, #0x70]
1165e10c8: b004c2c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1165e10cc: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
1165e10d0: f90057e8    	str	x8, [sp, #0xa8]
1165e10d4: f90047fa    	str	x26, [sp, #0x88]
1165e10d8: f94063e8    	ldr	x8, [sp, #0xc0]
1165e10dc: f9400108    	ldr	x8, [x8]
1165e10e0: eb15011f    	cmp	x8, x21
1165e10e4: 54000060    	b.eq	0x1165e10f0 <_O266DecReleaseOutputPicture+0x3354638>
1165e10e8: aa1703e0    	mov	x0, x23
1165e10ec: 947522d3    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1165e10f0: f9405fe8    	ldr	x8, [sp, #0xb8]
1165e10f4: f8747919    	ldr	x25, [x8, x20, lsl #3]
1165e10f8: f9452b60    	ldr	x0, [x27, #0xa50]
1165e10fc: aa1c03e1    	mov	x1, x28
1165e1100: 947522fb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1104: aa0003e2    	mov	x2, x0
1165e1108: aa1903e0    	mov	x0, x25
1165e110c: aa1603e1    	mov	x1, x22
1165e1110: 947522f7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1114: 340000c0    	cbz	w0, 0x1165e112c <_O266DecReleaseOutputPicture+0x3354674>
1165e1118: aa1803e0    	mov	x0, x24
1165e111c: f94057e1    	ldr	x1, [sp, #0xa8]
1165e1120: aa1903e2    	mov	x2, x25
1165e1124: 947522f2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1128: 1400005b    	b	0x1165e1294 <_O266DecReleaseOutputPicture+0x33547dc>
1165e112c: f946ce60    	ldr	x0, [x19, #0xd98]
1165e1130: aa1c03e1    	mov	x1, x28
1165e1134: 947522ee    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1138: aa0003e2    	mov	x2, x0
1165e113c: aa1903e0    	mov	x0, x25
1165e1140: aa1603e1    	mov	x1, x22
1165e1144: 947522ea    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1148: 34000a60    	cbz	w0, 0x1165e1294 <_O266DecReleaseOutputPicture+0x33547dc>
1165e114c: b004de48    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1165e1150: f9448500    	ldr	x0, [x8, #0x908] ; @�b
1165e1154: f94043e1    	ldr	x1, [sp, #0x80]
1165e1158: 947522e5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e115c: f9004be0    	str	x0, [sp, #0x90]
1165e1160: aa1903e0    	mov	x0, x25
1165e1164: f94053e1    	ldr	x1, [sp, #0xa0]
1165e1168: 947522e1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e116c: aa1d03fd    	mov	x29, x29
1165e1170: 94752309    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1174: aa0003f3    	mov	x19, x0
1165e1178: aa1903e0    	mov	x0, x25
1165e117c: f9404fe1    	ldr	x1, [sp, #0x98]
1165e1180: 947522db    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1184: 94750807    	bl	0x1183231a0 <dyld_stub_binder+0x1183231a0>
1165e1188: aa1d03fd    	mov	x29, x29
1165e118c: 94752302    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1190: aa1603fa    	mov	x26, x22
1165e1194: aa1c03f6    	mov	x22, x28
1165e1198: aa1503fc    	mov	x28, x21
1165e119c: aa1703f5    	mov	x21, x23
1165e11a0: aa1803f7    	mov	x23, x24
1165e11a4: aa1b03f8    	mov	x24, x27
1165e11a8: aa0003fb    	mov	x27, x0
1165e11ac: a90083f3    	stp	x19, x0, [sp, #0x8]
1165e11b0: 90042c28    	adrp	x8, 0x11eb65000 <dyld_stub_binder+0x11eb65000>
1165e11b4: 9134a108    	add	x8, x8, #0xd28
1165e11b8: f90003e8    	str	x8, [sp]
1165e11bc: f9404be0    	ldr	x0, [sp, #0x90]
1165e11c0: f9403fe1    	ldr	x1, [sp, #0x78]
1165e11c4: 52800062    	mov	w2, #0x3                ; =3
1165e11c8: d2800003    	mov	x3, #0x0                ; =0
1165e11cc: 52800004    	mov	w4, #0x0                ; =0
1165e11d0: f00316c5    	adrp	x5, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e11d4: 910848a5    	add	x5, x5, #0x212
1165e11d8: 528024c6    	mov	w6, #0x126              ; =294
1165e11dc: f00316c7    	adrp	x7, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e11e0: 910b48e7    	add	x7, x7, #0x2d2
1165e11e4: 947522c2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e11e8: aa1b03e0    	mov	x0, x27
1165e11ec: aa1803fb    	mov	x27, x24
1165e11f0: aa1703f8    	mov	x24, x23
1165e11f4: aa1503f7    	mov	x23, x21
1165e11f8: aa1c03f5    	mov	x21, x28
1165e11fc: aa1603fc    	mov	x28, x22
1165e1200: aa1a03f6    	mov	x22, x26
1165e1204: 947522d5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1208: aa1303e0    	mov	x0, x19
1165e120c: 947522d3    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1210: f9452b73    	ldr	x19, [x27, #0xa50]
1165e1214: aa1903e0    	mov	x0, x25
1165e1218: 947522d6    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e121c: aa1303e0    	mov	x0, x19
1165e1220: 94752256    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1165e1224: aa0003f3    	mov	x19, x0
1165e1228: aa1903e0    	mov	x0, x25
1165e122c: f94053e1    	ldr	x1, [sp, #0xa0]
1165e1230: 947522af    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1234: aa1d03fd    	mov	x29, x29
1165e1238: 947522d7    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e123c: aa0003fa    	mov	x26, x0
1165e1240: aa1903e0    	mov	x0, x25
1165e1244: f9404fe1    	ldr	x1, [sp, #0x98]
1165e1248: 947522a9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e124c: aa0003e3    	mov	x3, x0
1165e1250: aa1303e0    	mov	x0, x19
1165e1254: f9403be1    	ldr	x1, [sp, #0x70]
1165e1258: aa1a03e2    	mov	x2, x26
1165e125c: 947522a4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1260: aa0003f3    	mov	x19, x0
1165e1264: aa1a03e0    	mov	x0, x26
1165e1268: f94047fa    	ldr	x26, [sp, #0x88]
1165e126c: 947522bb    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1270: aa1803e0    	mov	x0, x24
1165e1274: f94057e1    	ldr	x1, [sp, #0xa8]
1165e1278: aa1303e2    	mov	x2, x19
1165e127c: 9475229c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1280: aa1903e0    	mov	x0, x25
1165e1284: 947522b5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1288: aa1303e0    	mov	x0, x19
1165e128c: 9004dcb3    	adrp	x19, 0x120175000 <dyld_stub_binder+0x120175000>
1165e1290: 947522b2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1294: 91000694    	add	x20, x20, #0x1
1165e1298: eb14035f    	cmp	x26, x20
1165e129c: 54fff1e1    	b.ne	0x1165e10d8 <_O266DecReleaseOutputPicture+0x3354620>
1165e12a0: 9102c3e2    	add	x2, sp, #0xb0
1165e12a4: 9104c3e3    	add	x3, sp, #0x130
1165e12a8: aa1703e0    	mov	x0, x23
1165e12ac: f94037e1    	ldr	x1, [sp, #0x68]
1165e12b0: 52800204    	mov	w4, #0x10               ; =16
1165e12b4: 9475228e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e12b8: aa0003fa    	mov	x26, x0
1165e12bc: b5ffee20    	cbnz	x0, 0x1165e1080 <_O266DecReleaseOutputPicture+0x33545c8>
1165e12c0: aa1703e0    	mov	x0, x23
1165e12c4: 947522a5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e12c8: aa1803e0    	mov	x0, x24
1165e12cc: f9402be1    	ldr	x1, [sp, #0x50]
1165e12d0: 94752287    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e12d4: b4000080    	cbz	x0, 0x1165e12e4 <_O266DecReleaseOutputPicture+0x335482c>
1165e12d8: a94307e0    	ldp	x0, x1, [sp, #0x30]
1165e12dc: aa1803e2    	mov	x2, x24
1165e12e0: 94752283    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e12e4: aa1803e0    	mov	x0, x24
1165e12e8: 9475229c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e12ec: a945d3e8    	ldp	x8, x20, [sp, #0x58]
1165e12f0: 91000694    	add	x20, x20, #0x1
1165e12f4: eb08029f    	cmp	x20, x8
1165e12f8: 54ffe861    	b.ne	0x1165e1004 <_O266DecReleaseOutputPicture+0x335454c>
1165e12fc: 9103c3e2    	add	x2, sp, #0xf0
1165e1300: d10383a3    	sub	x3, x29, #0xe0
1165e1304: f94017e0    	ldr	x0, [sp, #0x28]
1165e1308: f94037e1    	ldr	x1, [sp, #0x68]
1165e130c: 52800204    	mov	w4, #0x10               ; =16
1165e1310: 94752277    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1314: f9002fe0    	str	x0, [sp, #0x58]
1165e1318: b5ffe680    	cbnz	x0, 0x1165e0fe8 <_O266DecReleaseOutputPicture+0x3354530>
1165e131c: f94017f3    	ldr	x19, [sp, #0x28]
1165e1320: aa1303e0    	mov	x0, x19
1165e1324: 9475228d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1328: f004d8e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1165e132c: f9431501    	ldr	x1, [x8, #0x628] ; copy
1165e1330: f9401bf4    	ldr	x20, [sp, #0x30]
1165e1334: aa1403e0    	mov	x0, x20
1165e1338: 9475226d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e133c: d004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e1340: b98aa109    	ldrsw	x9, [x8, #0xaa0]
1165e1344: f94013ea    	ldr	x10, [sp, #0x20]
1165e1348: f8696948    	ldr	x8, [x10, x9]
1165e134c: f8296940    	str	x0, [x10, x9]
1165e1350: aa0803e0    	mov	x0, x8
1165e1354: 94752281    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1358: aa1403e0    	mov	x0, x20
1165e135c: 9475227f    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1360: aa1303e0    	mov	x0, x19
1165e1364: 9475227d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1368: f85a03a8    	ldur	x8, [x29, #-0x60]
1165e136c: d0038069    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1165e1370: f9405929    	ldr	x9, [x9, #0xb0]
1165e1374: f9400129    	ldr	x9, [x9]
1165e1378: eb08013f    	cmp	x9, x8
1165e137c: 54000121    	b.ne	0x1165e13a0 <_O266DecReleaseOutputPicture+0x33548e8>
1165e1380: 910903ff    	add	sp, sp, #0x240
1165e1384: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1165e1388: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1165e138c: a94357f6    	ldp	x22, x21, [sp, #0x30]
1165e1390: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1165e1394: a94167fa    	ldp	x26, x25, [sp, #0x10]
1165e1398: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1165e139c: d65f03c0    	ret
1165e13a0: 94751557    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>