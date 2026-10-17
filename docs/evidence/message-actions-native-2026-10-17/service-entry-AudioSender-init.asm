
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100175e84: d101c3ff    	sub	sp, sp, #0x70
100175e88: a9016ffc    	stp	x28, x27, [sp, #0x10]
100175e8c: a90267fa    	stp	x26, x25, [sp, #0x20]
100175e90: a9035ff8    	stp	x24, x23, [sp, #0x30]
100175e94: a90457f6    	stp	x22, x21, [sp, #0x40]
100175e98: a9054ff4    	stp	x20, x19, [sp, #0x50]
100175e9c: a9067bfd    	stp	x29, x30, [sp, #0x60]
100175ea0: 910183fd    	add	x29, sp, #0x60
100175ea4: 901055c8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100175ea8: 52800029    	mov	w9, #0x1                ; =1
100175eac: 391ed509    	strb	w9, [x8, #0x7b5]
100175eb0: f0100208    	adrp	x8, 0x1201b8000 <dyld_stub_binder+0x1201b8000>
100175eb4: f941ad08    	ldr	x8, [x8, #0x358] ; AudioSender
100175eb8: a90023e0    	stp	x0, x8, [sp]
100175ebc: b00ffc68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100175ec0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
100175ec4: 910003e0    	mov	x0, sp
100175ec8: 95eac49f    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
100175ecc: aa0003f3    	mov	x19, x0
100175ed0: b4000f80    	cbz	x0, 0x1001760c0 <__text+0x16e0c0>
100175ed4: b0100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100175ed8: b9829108    	ldrsw	x8, [x8, #0x290]
100175edc: f8686a60    	ldr	x0, [x19, x8]
100175ee0: f8286a7f    	str	xzr, [x19, x8]
100175ee4: 95eac49c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100175ee8: b0100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100175eec: b9829508    	ldrsw	x8, [x8, #0x294]
100175ef0: f8686a60    	ldr	x0, [x19, x8]
100175ef4: f8286a7f    	str	xzr, [x19, x8]
100175ef8: 95eac497    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100175efc: d00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100175f00: f9445101    	ldr	x1, [x8, #0x8a0] ; setTranscacheLogic:
100175f04: aa1303e0    	mov	x0, x19
100175f08: d2800002    	mov	x2, #0x0                ; =0
100175f0c: 95eac48c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175f10: 90100008    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100175f14: f9426d00    	ldr	x0, [x8, #0x4d8]
100175f18: d00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100175f1c: f9445501    	ldr	x1, [x8, #0x8a8] ; weakObjectsHashTable
100175f20: 95eac487    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175f24: aa1d03fd    	mov	x29, x29
100175f28: 95eac488    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100175f2c: b0100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100175f30: b9829909    	ldrsw	x9, [x8, #0x298]
100175f34: f8696a68    	ldr	x8, [x19, x9]
100175f38: f8296a60    	str	x0, [x19, x9]
100175f3c: aa0803e0    	mov	x0, x8
100175f40: 95eac485    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100175f44: d00fffe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100175f48: f9464900    	ldr	x0, [x8, #0xc90] ; CAppUtil
100175f4c: d00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100175f50: f9445901    	ldr	x1, [x8, #0x8b0] ; getMainController
100175f54: 95eac47a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175f58: aa1d03fd    	mov	x29, x29
100175f5c: 95eac47b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100175f60: aa0003f4    	mov	x20, x0
100175f64: d00fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100175f68: f9445d01    	ldr	x1, [x8, #0x8b8] ; initFacade:
100175f6c: aa1303e0    	mov	x0, x19
100175f70: aa1403e2    	mov	x2, x20
100175f74: 95eac472    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175f78: aa1403e0    	mov	x0, x20
100175f7c: 95eac476    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100175f80: d00ffffa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
100175f84: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
100175f88: f00ffc48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100175f8c: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
100175f90: aa1403e1    	mov	x1, x20
100175f94: 95eac46a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175f98: aa1d03fd    	mov	x29, x29
100175f9c: 95eac46b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100175fa0: aa0003f5    	mov	x21, x0
100175fa4: f00fffc8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
100175fa8: f945b502    	ldr	x2, [x8, #0xb68]
100175fac: b00fe628    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100175fb0: f940a101    	ldr	x1, [x8, #0x140] ; registerExtension:withTarget:
100175fb4: aa1303e3    	mov	x3, x19
100175fb8: 95eac461    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175fbc: aa1503e0    	mov	x0, x21
100175fc0: 95eac465    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100175fc4: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
100175fc8: aa1403e1    	mov	x1, x20
100175fcc: 95eac45c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175fd0: aa1d03fd    	mov	x29, x29
100175fd4: 95eac45d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100175fd8: aa0003f5    	mov	x21, x0
100175fdc: d00ffffb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
100175fe0: f9467360    	ldr	x0, [x27, #0xce0] ; ExptService
100175fe4: d00ffc48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100175fe8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
100175fec: aa1603e1    	mov	x1, x22
100175ff0: 95eac453    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100175ff4: aa0003e2    	mov	x2, x0
100175ff8: 900fe628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100175ffc: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
100176000: aa1503e0    	mov	x0, x21
100176004: aa1703e1    	mov	x1, x23
100176008: 95eac44d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017600c: aa1d03fd    	mov	x29, x29
100176010: 95eac44e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176014: aa0003f8    	mov	x24, x0
100176018: 900fe628    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10017601c: f9404119    	ldr	x25, [x8, #0x80] ; getExpt:withBoolDef:
100176020: f00f19a2    	adrp	x2, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100176024: 91302042    	add	x2, x2, #0xc08
100176028: aa1903e1    	mov	x1, x25
10017602c: 52800003    	mov	w3, #0x0                ; =0
100176030: 95eac443    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176034: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100176038: b9829d08    	ldrsw	x8, [x8, #0x29c]
10017603c: 38286a60    	strb	w0, [x19, x8]
100176040: aa1803e0    	mov	x0, x24
100176044: 95eac444    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176048: aa1503e0    	mov	x0, x21
10017604c: 95eac442    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100176050: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
100176054: aa1403e1    	mov	x1, x20
100176058: 95eac439    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017605c: aa1d03fd    	mov	x29, x29
100176060: 95eac43a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100176064: aa0003f4    	mov	x20, x0
100176068: f9467360    	ldr	x0, [x27, #0xce0] ; ExptService
10017606c: aa1603e1    	mov	x1, x22
100176070: 95eac433    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176074: aa0003e2    	mov	x2, x0
100176078: aa1403e0    	mov	x0, x20
10017607c: aa1703e1    	mov	x1, x23
100176080: 95eac42f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100176084: aa1d03fd    	mov	x29, x29
100176088: 95eac430    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017608c: aa0003f5    	mov	x21, x0
100176090: f00f19a2    	adrp	x2, 0x11e4ad000 <dyld_stub_binder+0x11e4ad000>
100176094: 9130a042    	add	x2, x2, #0xc28
100176098: aa1903e1    	mov	x1, x25
10017609c: 52800003    	mov	w3, #0x0                ; =0
1001760a0: 95eac427    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001760a4: 90100348    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
1001760a8: b982a108    	ldrsw	x8, [x8, #0x2a0]
1001760ac: 38286a60    	strb	w0, [x19, x8]
1001760b0: aa1503e0    	mov	x0, x21
1001760b4: 95eac428    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001760b8: aa1403e0    	mov	x0, x20
1001760bc: 95eac426    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001760c0: aa1303e0    	mov	x0, x19
1001760c4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1001760c8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1001760cc: a94457f6    	ldp	x22, x21, [sp, #0x40]
1001760d0: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1001760d4: a94267fa    	ldp	x26, x25, [sp, #0x20]
1001760d8: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1001760dc: 9101c3ff    	add	sp, sp, #0x70
1001760e0: d65f03c0    	ret