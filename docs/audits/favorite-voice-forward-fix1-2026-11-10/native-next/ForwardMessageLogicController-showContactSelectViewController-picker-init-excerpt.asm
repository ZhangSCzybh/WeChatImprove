; Supplied 8.0.80 binary: classref [0x11ed1b000 + 0xbf0] resolves to SessionSelectController.
; 0x107c27c0c is the existing Objective-C allocation + init stub.
101dbbbd4: 900e7b08    	adrp	x8, 0x11ed1b000 <dyld_stub_binder+0x11ed1b000>
101dbbbd8: f945f900    	ldr	x0, [x8, #0xbf0]
101dbbbdc: 9579b00c    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
101dbbc60: f946b101    	ldr	x1, [x8, #0xd60] ; selector: setConfirmType:
101dbbc64: aa1403e0    	mov	x0, x20
101dbbc68: d2800002    	mov	x2, #0x0                ; =0
101dbbc6c: 9579affe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dbbc70: d00e6068    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101dbbc74: f945b501    	ldr	x1, [x8, #0xb68] ; selector: setM_delegate:
101dbbc78: aa1403e0    	mov	x0, x20
101dbbc7c: aa1c03e2    	mov	x2, x28
101dbbc80: 9579aff9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dbbc84: d00e6328    	adrp	x8, 0x11ea21000 <dyld_stub_binder+0x11ea21000>
101dbbc88: f9421d01    	ldr	x1, [x8, #0x438] ; selector: setM_bKeepCurViewAfterSelect:
101dbbc8c: aa1403e0    	mov	x0, x20
101dbbc90: 52800022    	mov	w2, #0x1                ; =1
101dbbc94: 9579aff4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101dbbc98: f00e7aa8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101dbbc9c: f945f100    	ldr	x0, [x8, #0xbe0]
