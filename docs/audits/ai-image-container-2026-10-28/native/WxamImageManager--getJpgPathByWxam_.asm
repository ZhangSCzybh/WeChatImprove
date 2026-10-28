
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a99cc88: d10103ff    	sub	sp, sp, #0x40
10a99cc8c: a90157f6    	stp	x22, x21, [sp, #0x10]
10a99cc90: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a99cc94: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a99cc98: 9100c3fd    	add	x29, sp, #0x30
10a99cc9c: aa0203f3    	mov	x19, x2
10a99cca0: aa0003f5    	mov	x21, x0
10a99cca4: f00b15a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a99cca8: 52800029    	mov	w9, #0x1                ; =1
10a99ccac: 39115909    	strb	w9, [x8, #0x456]
10a99ccb0: aa0203e0    	mov	x0, x2
10a99ccb4: 953af9e3    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a99ccb8: f00ab828    	adrp	x8, 0x1200a3000 <dyld_stub_binder+0x1200a3000>
10a99ccbc: f942f101    	ldr	x1, [x8, #0x5e0] ; getPermanentWxamPathByMsg:
10a99ccc0: aa1503e0    	mov	x0, x21
10a99ccc4: aa1303e2    	mov	x2, x19
10a99ccc8: 953af9df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99cccc: aa1d03fd    	mov	x29, x29
10a99ccd0: 953af9e0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99ccd4: aa0003f4    	mov	x20, x0
10a99ccd8: f00abeb6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10a99ccdc: f94636c0    	ldr	x0, [x22, #0xc68] ; CBaseFile
10a99cce0: f00aa4e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a99cce4: f9467101    	ldr	x1, [x8, #0xce0] ; GetFileSize:
10a99cce8: aa1403e2    	mov	x2, x20
10a99ccec: 953af9d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99ccf0: f100041f    	cmp	x0, #0x1
10a99ccf4: 540005eb    	b.lt	0x10a99cdb0 <_Flutter_MMFoundation_BindContext+0x6e78994>
10a99ccf8: d00aa788    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10a99ccfc: f9420d01    	ldr	x1, [x8, #0x418] ; tempPathForWxamDecode:
10a99cd00: aa1503e0    	mov	x0, x21
10a99cd04: aa1303e2    	mov	x2, x19
10a99cd08: 953af9cf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99cd0c: aa1d03fd    	mov	x29, x29
10a99cd10: 953af9d0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a99cd14: aa0003f5    	mov	x21, x0
10a99cd18: b4000400    	cbz	x0, 0x10a99cd98 <_Flutter_MMFoundation_BindContext+0x6e7897c>
10a99cd1c: f94636c0    	ldr	x0, [x22, #0xc68] ; CBaseFile
10a99cd20: b00aa4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a99cd24: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
10a99cd28: aa1503e2    	mov	x2, x21
10a99cd2c: 953af9c6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99cd30: 37000140    	tbnz	w0, #0x0, 0x10a99cd58 <_Flutter_MMFoundation_BindContext+0x6e7893c>
10a99cd34: d00abee8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
10a99cd38: f9439d00    	ldr	x0, [x8, #0x738] ; WxamImageConvert
10a99cd3c: d00aa788    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10a99cd40: f9420501    	ldr	x1, [x8, #0x408] ; decodeWxAmToPic:wxamPath:scene:
10a99cd44: aa1503e2    	mov	x2, x21
10a99cd48: aa1403e3    	mov	x3, x20
10a99cd4c: 52800024    	mov	w4, #0x1                ; =1
10a99cd50: 953af9bd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99cd54: 36000440    	tbz	w0, #0x0, 0x10a99cddc <_Flutter_MMFoundation_BindContext+0x6e789c0>
10a99cd58: f00abea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a99cd5c: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10a99cd60: b00aa4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a99cd64: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a99cd68: 900a0868    	adrp	x8, 0x11eaa8000 <dyld_stub_binder+0x11eaa8000>
10a99cd6c: 91362108    	add	x8, x8, #0xd88
10a99cd70: f90003e8    	str	x8, [sp]
10a99cd74: d008a0e5    	adrp	x5, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99cd78: 9112cca5    	add	x5, x5, #0x4b3
10a99cd7c: d008a0e7    	adrp	x7, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99cd80: 911784e7    	add	x7, x7, #0x5e1
10a99cd84: 52800022    	mov	w2, #0x1                ; =1
10a99cd88: d2800003    	mov	x3, #0x0                ; =0
10a99cd8c: 52800004    	mov	w4, #0x0                ; =0
10a99cd90: 52801046    	mov	w6, #0x82               ; =130
10a99cd94: 953af9ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99cd98: aa1503e0    	mov	x0, x21
10a99cd9c: 953af9a9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a99cda0: aa1503f6    	mov	x22, x21
10a99cda4: aa1503e0    	mov	x0, x21
10a99cda8: 953af9ad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99cdac: 14000002    	b	0x10a99cdb4 <_Flutter_MMFoundation_BindContext+0x6e78998>
10a99cdb0: d2800016    	mov	x22, #0x0               ; =0
10a99cdb4: aa1403e0    	mov	x0, x20
10a99cdb8: 953af9a9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99cdbc: aa1303e0    	mov	x0, x19
10a99cdc0: 953af9a7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a99cdc4: aa1603e0    	mov	x0, x22
10a99cdc8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a99cdcc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a99cdd0: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a99cdd4: 910103ff    	add	sp, sp, #0x40
10a99cdd8: 153af9a8    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
10a99cddc: 52800420    	mov	w0, #0x21               ; =33
10a99cde0: 528003e1    	mov	w1, #0x1f               ; =31
10a99cde4: 52800022    	mov	w2, #0x1                ; =1
10a99cde8: 52800003    	mov	w3, #0x0                ; =0
10a99cdec: 52800004    	mov	w4, #0x0                ; =0
10a99cdf0: 9749b1ec    	bl	0x107c095a0 <_Flutter_MMFoundation_BindContext+0x40e5184>
10a99cdf4: f00abea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a99cdf8: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10a99cdfc: b00aa4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a99ce00: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a99ce04: 900a0868    	adrp	x8, 0x11eaa8000 <dyld_stub_binder+0x11eaa8000>
10a99ce08: 9135a108    	add	x8, x8, #0xd68
10a99ce0c: f90003e8    	str	x8, [sp]
10a99ce10: d008a0e5    	adrp	x5, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99ce14: 9112cca5    	add	x5, x5, #0x4b3
10a99ce18: d008a0e7    	adrp	x7, 0x11bdba000 <dyld_stub_binder+0x11bdba000>
10a99ce1c: 911784e7    	add	x7, x7, #0x5e1
10a99ce20: 52800082    	mov	w2, #0x4                ; =4
10a99ce24: d2800003    	mov	x3, #0x0                ; =0
10a99ce28: 52800004    	mov	w4, #0x0                ; =0
10a99ce2c: 52800fa6    	mov	w6, #0x7d               ; =125
10a99ce30: 953af985    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a99ce34: d2800016    	mov	x22, #0x0               ; =0
10a99ce38: 17ffffdb    	b	0x10a99cda4 <_Flutter_MMFoundation_BindContext+0x6e78988>
