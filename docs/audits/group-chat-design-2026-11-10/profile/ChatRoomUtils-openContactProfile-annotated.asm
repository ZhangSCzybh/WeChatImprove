
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fd803c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100fd8040: a90157f6    	stp	x22, x21, [sp, #0x10]
100fd8044: a9024ff4    	stp	x20, x19, [sp, #0x20]
100fd8048: a9037bfd    	stp	x29, x30, [sp, #0x30]
100fd804c: 9100c3fd    	add	x29, sp, #0x30
100fd8050: aa0603f7    	mov	x23, x6
100fd8054: aa0503f6    	mov	x22, x5
100fd8058: aa0403f5    	mov	x21, x4
100fd805c: aa0303f4    	mov	x20, x3
100fd8060: aa0203f3    	mov	x19, x2
100fd8064: f00f3b48    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd8068: 52800029    	mov	w9, #0x1                ; =1
100fd806c: 39224909    	strb	w9, [x8, #0x892]
100fd8070: aa0203e0    	mov	x0, x2
100fd8074: 95b13f00    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8078: aa1403e0    	mov	x0, x20
100fd807c: 95b13efe    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8080: aa1503e0    	mov	x0, x21
100fd8084: 95b13efc    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8088: aa1603e0    	mov	x0, x22
100fd808c: 95b13efa    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8090: b4000993    	cbz	x19, 0x100fd81c0 <__text+0xfd01c0>
100fd8094: d00ee9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8098: f9456100    	ldr	x0, [x8, #0xac0] ; class CContact
100fd809c: d00ee668    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd80a0: f9428501    	ldr	x1, [x8, #0x508] ; selector class
100fd80a4: 95b13ef0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80a8: aa0003e2    	mov	x2, x0
100fd80ac: 900ee688    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fd80b0: f9444901    	ldr	x1, [x8, #0x890] ; selector isKindOfClass:
100fd80b4: aa1303e0    	mov	x0, x19
100fd80b8: 95b13eeb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80bc: 34000820    	cbz	w0, 0x100fd81c0 <__text+0xfd01c0>
100fd80c0: 900ee688    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fd80c4: f9453101    	ldr	x1, [x8, #0xa60] ; selector isValid
100fd80c8: aa1303e0    	mov	x0, x19
100fd80cc: 95b13ee6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80d0: 34000780    	cbz	w0, 0x100fd81c0 <__text+0xfd01c0>
100fd80d4: 900ecfa8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100fd80d8: f940ad01    	ldr	x1, [x8, #0x158] ; selector isMMContact
100fd80dc: aa1303e0    	mov	x0, x19
100fd80e0: 95b13ee1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80e4: 370000c0    	tbnz	w0, #0x0, 0x100fd80fc <__text+0xfd00fc>
100fd80e8: 900ecfa8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100fd80ec: f946d101    	ldr	x1, [x8, #0xda0] ; selector setM_uiFriendScene:
100fd80f0: aa1303e0    	mov	x0, x19
100fd80f4: 528001c2    	mov	w2, #0xe                ; =14
100fd80f8: 95b13edb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80fc: d00ee9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8100: f945e900    	ldr	x0, [x8, #0xbd0] ; class ContactInfoViewController
100fd8104: 95b13ec2    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
100fd8108: aa0003f8    	mov	x24, x0
100fd810c: f00ecf88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8110: f9469901    	ldr	x1, [x8, #0xd30] ; selector setM_contact:
100fd8114: aa1303e2    	mov	x2, x19
100fd8118: 95b13ed3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd811c: d00ed028    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
100fd8120: f945b101    	ldr	x1, [x8, #0xb60] ; selector setM_chatContact:
100fd8124: aa1803e0    	mov	x0, x24
100fd8128: aa1403e2    	mov	x2, x20
100fd812c: 95b13ece    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8130: f00ecf88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8134: f946a501    	ldr	x1, [x8, #0xd48] ; selector setM_uiFromScene:
100fd8138: aa1803e0    	mov	x0, x24
100fd813c: 52800182    	mov	w2, #0xc                ; =12
100fd8140: 95b13ec9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8144: 900ed028    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
100fd8148: f9428101    	ldr	x1, [x8, #0x500] ; selector setM_searchScene:
100fd814c: aa1803e0    	mov	x0, x24
100fd8150: aa1703e2    	mov	x2, x23
100fd8154: 95b13ec4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8158: b00ecf88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd815c: f945b501    	ldr	x1, [x8, #0xb68] ; selector setM_delegate:
100fd8160: aa1803e0    	mov	x0, x24
100fd8164: aa1603e2    	mov	x2, x22
100fd8168: 95b13ebf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd816c: f00ecf88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8170: f9469d01    	ldr	x1, [x8, #0xd38] ; selector setHidesBottomBarWhenPushed:
100fd8174: aa1803e0    	mov	x0, x24
100fd8178: 52800022    	mov	w2, #0x1                ; =1
100fd817c: 95b13eba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8180: b00ee688    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100fd8184: f941b101    	ldr	x1, [x8, #0x360] ; selector navigationController
100fd8188: aa1503e0    	mov	x0, x21
100fd818c: 95b13eb6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8190: aa1d03fd    	mov	x29, x29
100fd8194: 95b13ebb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8198: aa0003f7    	mov	x23, x0
100fd819c: f00ecf88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd81a0: f9449901    	ldr	x1, [x8, #0x930] ; selector PushViewController:animated:
100fd81a4: aa1803e2    	mov	x2, x24
100fd81a8: 52800023    	mov	w3, #0x1                ; =1
100fd81ac: 95b13eae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd81b0: aa1703e0    	mov	x0, x23
100fd81b4: 95b13eaf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81b8: aa1803e0    	mov	x0, x24
100fd81bc: 95b13ead    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81c0: aa1603e0    	mov	x0, x22
100fd81c4: 95b13eab    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81c8: aa1503e0    	mov	x0, x21
100fd81cc: 95b13ea9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81d0: aa1403e0    	mov	x0, x20
100fd81d4: 95b13ea7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81d8: aa1303e0    	mov	x0, x19
100fd81dc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100fd81e0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100fd81e4: a94157f6    	ldp	x22, x21, [sp, #0x10]
100fd81e8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100fd81ec: 15b13ea1    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
