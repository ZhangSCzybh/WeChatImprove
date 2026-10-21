
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10181ad04: d10243ff    	sub	sp, sp, #0x90
10181ad08: a9036ffc    	stp	x28, x27, [sp, #0x30]
10181ad0c: a90467fa    	stp	x26, x25, [sp, #0x40]
10181ad10: a9055ff8    	stp	x24, x23, [sp, #0x50]
10181ad14: a90657f6    	stp	x22, x21, [sp, #0x60]
10181ad18: a9074ff4    	stp	x20, x19, [sp, #0x70]
10181ad1c: a9087bfd    	stp	x29, x30, [sp, #0x80]
10181ad20: 910203fd    	add	x29, sp, #0x80
10181ad24: aa0303f5    	mov	x21, x3
10181ad28: aa0003f3    	mov	x19, x0
10181ad2c: 900fa0c8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10181ad30: 52800029    	mov	w9, #0x1                ; =1
10181ad34: 392cb109    	strb	w9, [x8, #0xb2c]
10181ad38: b00f4adb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10181ad3c: f9453760    	ldr	x0, [x27, #0xa68]
10181ad40: f00f30e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10181ad44: f942a914    	ldr	x20, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10181ad48: f00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181ad4c: 91182108    	add	x8, x8, #0x608
10181ad50: f90003e8    	str	x8, [sp]
10181ad54: d00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181ad58: 91388063    	add	x3, x3, #0xe20
10181ad5c: b00cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181ad60: 912160a5    	add	x5, x5, #0x858
10181ad64: b00cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181ad68: 912a84e7    	add	x7, x7, #0xaa1
10181ad6c: aa1403e1    	mov	x1, x20
10181ad70: 52800022    	mov	w2, #0x1                ; =1
10181ad74: 52800004    	mov	w4, #0x0                ; =0
10181ad78: 528014c6    	mov	w6, #0xa6               ; =166
10181ad7c: 959030f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181ad80: 34001415    	cbz	w21, 0x10181b000 <__text+0x1813000>
10181ad84: f00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181ad88: f9412d01    	ldr	x1, [x8, #0x258] ; isDuringVoiceSearch
10181ad8c: aa1303e0    	mov	x0, x19
10181ad90: 959030eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181ad94: 34001360    	cbz	w0, 0x10181b000 <__text+0x1813000>
10181ad98: f9453777    	ldr	x23, [x27, #0xa68]
10181ad9c: b00f3108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10181ada0: f9419915    	ldr	x21, [x8, #0x330] ; dataSource
10181ada4: aa1303e0    	mov	x0, x19
10181ada8: aa1503e1    	mov	x1, x21
10181adac: 959030e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181adb0: aa1d03fd    	mov	x29, x29
10181adb4: 959030e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181adb8: aa0003f8    	mov	x24, x0
10181adbc: b00f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181adc0: f944c101    	ldr	x1, [x8, #0x980] ; hasSectionWaitDisplay
10181adc4: 959030de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181adc8: aa0003f9    	mov	x25, x0
10181adcc: aa1303e0    	mov	x0, x19
10181add0: aa1503e1    	mov	x1, x21
10181add4: 959030da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181add8: aa1d03fd    	mov	x29, x29
10181addc: 959030db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181ade0: aa0003fa    	mov	x26, x0
10181ade4: f00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181ade8: f941ed16    	ldr	x22, [x8, #0x3d8] ; hasResult
10181adec: aa1603e1    	mov	x1, x22
10181adf0: 959030d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181adf4: a90083f9    	stp	x25, x0, [sp, #0x8]
10181adf8: f00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181adfc: 9118a108    	add	x8, x8, #0x628
10181ae00: f90003e8    	str	x8, [sp]
10181ae04: d00cddc3    	adrp	x3, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
10181ae08: 91212063    	add	x3, x3, #0x848
10181ae0c: b00cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181ae10: 912160a5    	add	x5, x5, #0x858
10181ae14: b00cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181ae18: 912a84e7    	add	x7, x7, #0xaa1
10181ae1c: aa1703e0    	mov	x0, x23
10181ae20: aa1403e1    	mov	x1, x20
10181ae24: 52800042    	mov	w2, #0x2                ; =2
10181ae28: 52800004    	mov	w4, #0x0                ; =0
10181ae2c: 52801566    	mov	w6, #0xab               ; =171
10181ae30: 959030c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181ae34: aa1a03e0    	mov	x0, x26
10181ae38: 959030c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181ae3c: aa1803e0    	mov	x0, x24
10181ae40: 959030c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181ae44: b00f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181ae48: f944c501    	ldr	x1, [x8, #0x988] ; resetSearchSectionType
10181ae4c: aa1303e0    	mov	x0, x19
10181ae50: 959030bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181ae54: f9400e68    	ldr	x8, [x19, #0x18]
10181ae58: b4001aa8    	cbz	x8, 0x10181b1ac <__text+0x18131ac>
10181ae5c: b90023ff    	str	wzr, [sp, #0x20]
10181ae60: 910083e8    	add	x8, sp, #0x20
10181ae64: f90017e8    	str	x8, [sp, #0x28]
10181ae68: d00c5282    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
10181ae6c: 91282842    	add	x2, x2, #0xa0a
10181ae70: 91002260    	add	x0, x19, #0x8
10181ae74: 910083e1    	add	x1, sp, #0x20
10181ae78: 9100a3e3    	add	x3, sp, #0x28
10181ae7c: 91009fe4    	add	x4, sp, #0x27
10181ae80: 97ffe4c8    	bl	0x1018141a0 <__text+0x180c1a0>
10181ae84: b9402008    	ldr	w8, [x0, #0x20]
10181ae88: 7100251f    	cmp	w8, #0x9
10181ae8c: 54001901    	b.ne	0x10181b1ac <__text+0x18131ac>
10181ae90: f9453760    	ldr	x0, [x27, #0xa68]
10181ae94: f00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181ae98: 91192108    	add	x8, x8, #0x648
10181ae9c: f90003e8    	str	x8, [sp]
10181aea0: d00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181aea4: 91388063    	add	x3, x3, #0xe20
10181aea8: b00cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181aeac: 912160a5    	add	x5, x5, #0x858
10181aeb0: b00cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181aeb4: 912a84e7    	add	x7, x7, #0xaa1
10181aeb8: aa1403e1    	mov	x1, x20
10181aebc: 52800042    	mov	w2, #0x2                ; =2
10181aec0: 52800004    	mov	w4, #0x0                ; =0
10181aec4: 528015c6    	mov	w6, #0xae               ; =174
10181aec8: 9590309d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181aecc: 91032260    	add	x0, x19, #0xc8
10181aed0: 959030af    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181aed4: b4000320    	cbz	x0, 0x10181af38 <__text+0x1812f38>
10181aed8: aa0003f8    	mov	x24, x0
10181aedc: 91032260    	add	x0, x19, #0xc8
10181aee0: 959030ab    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181aee4: aa0003f9    	mov	x25, x0
10181aee8: b00f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181aeec: f944c917    	ldr	x23, [x8, #0x990] ; voiceSearchVerifiedSearchType:
10181aef0: 900f4768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181aef4: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181aef8: aa1703e2    	mov	x2, x23
10181aefc: 95903090    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181af00: aa0003fa    	mov	x26, x0
10181af04: aa1903e0    	mov	x0, x25
10181af08: 95903093    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181af0c: aa1803e0    	mov	x0, x24
10181af10: 95903091    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181af14: 3400013a    	cbz	w26, 0x10181af38 <__text+0x1812f38>
10181af18: 91032260    	add	x0, x19, #0xc8
10181af1c: 9590309c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181af20: aa0003f8    	mov	x24, x0
10181af24: aa1703e1    	mov	x1, x23
10181af28: 52800022    	mov	w2, #0x1                ; =1
10181af2c: 95903084    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181af30: aa1803e0    	mov	x0, x24
10181af34: 95903088    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181af38: b00f4b28    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
10181af3c: f9418517    	ldr	x23, [x8, #0x308]
10181af40: f00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181af44: f9411101    	ldr	x1, [x8, #0x220] ; getExtInfo
10181af48: aa1303e0    	mov	x0, x19
10181af4c: 9590307c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181af50: aa1d03fd    	mov	x29, x29
10181af54: 9590307d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181af58: aa0003f8    	mov	x24, x0
10181af5c: b00f3108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10181af60: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
10181af64: 95903076    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181af68: aa1d03fd    	mov	x29, x29
10181af6c: 95903077    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181af70: aa0003f9    	mov	x25, x0
10181af74: b00f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181af78: f944cd01    	ldr	x1, [x8, #0x998] ; getFTSSearchText
10181af7c: aa1303e0    	mov	x0, x19
10181af80: 9590306f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181af84: aa1d03fd    	mov	x29, x29
10181af88: 95903070    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181af8c: aa0003fa    	mov	x26, x0
10181af90: d00f3468    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
10181af94: f9454901    	ldr	x1, [x8, #0xa90] ; report26897InVoiceV3WithActionID:actionType:extInfo:query:
10181af98: aa1703e0    	mov	x0, x23
10181af9c: 528178a2    	mov	w2, #0xbc5              ; =3013
10181afa0: 52800243    	mov	w3, #0x12               ; =18
10181afa4: aa1903e4    	mov	x4, x25
10181afa8: aa1a03e5    	mov	x5, x26
10181afac: 95903064    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181afb0: aa1a03e0    	mov	x0, x26
10181afb4: 95903068    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181afb8: aa1903e0    	mov	x0, x25
10181afbc: 95903066    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181afc0: aa1803e0    	mov	x0, x24
10181afc4: 95903064    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181afc8: 900f3468    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10181afcc: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
10181afd0: aa1303e0    	mov	x0, x19
10181afd4: 9590305a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181afd8: aa1d03fd    	mov	x29, x29
10181afdc: 9590305b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181afe0: aa0003f8    	mov	x24, x0
10181afe4: f00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181afe8: f940f901    	ldr	x1, [x8, #0x1f0] ; directJumpToResultPage:isFromNewVoiceInput:
10181afec: aa1303e0    	mov	x0, x19
10181aff0: aa1803e2    	mov	x2, x24
10181aff4: 52800023    	mov	w3, #0x1                ; =1
10181aff8: 95903051    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181affc: 140000f8    	b	0x10181b3dc <__text+0x18133dc>
10181b000: 900f3108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10181b004: f9419901    	ldr	x1, [x8, #0x330] ; dataSource
10181b008: aa1303e0    	mov	x0, x19
10181b00c: 9590304c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b010: aa1d03fd    	mov	x29, x29
10181b014: 9590304d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b018: aa0003f5    	mov	x21, x0
10181b01c: d00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181b020: f941ed01    	ldr	x1, [x8, #0x3d8] ; hasResult
10181b024: 95903046    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b028: aa0003f6    	mov	x22, x0
10181b02c: aa1503e0    	mov	x0, x21
10181b030: 95903049    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b034: 37000556    	tbnz	w22, #0x0, 0x10181b0dc <__text+0x18130dc>
10181b038: f9453760    	ldr	x0, [x27, #0xa68]
10181b03c: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181b040: 911aa108    	add	x8, x8, #0x6a8
10181b044: f90003e8    	str	x8, [sp]
10181b048: b00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181b04c: 91388063    	add	x3, x3, #0xe20
10181b050: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b054: 912160a5    	add	x5, x5, #0x858
10181b058: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b05c: 912a84e7    	add	x7, x7, #0xaa1
10181b060: aa1403e1    	mov	x1, x20
10181b064: 52800042    	mov	w2, #0x2                ; =2
10181b068: 52800004    	mov	w4, #0x0                ; =0
10181b06c: 52801906    	mov	w6, #0xc8               ; =200
10181b070: 95903033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b074: 91032260    	add	x0, x19, #0xc8
10181b078: 95903045    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b07c: b4000300    	cbz	x0, 0x10181b0dc <__text+0x18130dc>
10181b080: aa0003f6    	mov	x22, x0
10181b084: 91032260    	add	x0, x19, #0xc8
10181b088: 95903041    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b08c: aa0003f7    	mov	x23, x0
10181b090: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b094: f944d915    	ldr	x21, [x8, #0x9b0] ; localSearchFail
10181b098: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b09c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b0a0: aa1503e2    	mov	x2, x21
10181b0a4: 95903026    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b0a8: aa0003f8    	mov	x24, x0
10181b0ac: aa1703e0    	mov	x0, x23
10181b0b0: 95903029    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b0b4: aa1603e0    	mov	x0, x22
10181b0b8: 95903027    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b0bc: 34000118    	cbz	w24, 0x10181b0dc <__text+0x18130dc>
10181b0c0: 91032260    	add	x0, x19, #0xc8
10181b0c4: 95903032    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b0c8: aa0003f6    	mov	x22, x0
10181b0cc: aa1503e1    	mov	x1, x21
10181b0d0: 9590301b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b0d4: aa1603e0    	mov	x0, x22
10181b0d8: 9590301f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b0dc: f9453760    	ldr	x0, [x27, #0xa68]
10181b0e0: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181b0e4: 911b2108    	add	x8, x8, #0x6c8
10181b0e8: f90003e8    	str	x8, [sp]
10181b0ec: b00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181b0f0: 91388063    	add	x3, x3, #0xe20
10181b0f4: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b0f8: 912160a5    	add	x5, x5, #0x858
10181b0fc: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b100: 912a84e7    	add	x7, x7, #0xaa1
10181b104: aa1403e1    	mov	x1, x20
10181b108: 52800042    	mov	w2, #0x2                ; =2
10181b10c: 52800004    	mov	w4, #0x0                ; =0
10181b110: 52801986    	mov	w6, #0xcc               ; =204
10181b114: 9590300a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b118: 91032260    	add	x0, x19, #0xc8
10181b11c: 9590301c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b120: b4000300    	cbz	x0, 0x10181b180 <__text+0x1813180>
10181b124: aa0003f5    	mov	x21, x0
10181b128: 91032260    	add	x0, x19, #0xc8
10181b12c: 95903018    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b130: aa0003f6    	mov	x22, x0
10181b134: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b138: f944d114    	ldr	x20, [x8, #0x9a0] ; reloadList
10181b13c: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b140: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b144: aa1403e2    	mov	x2, x20
10181b148: 95902ffd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b14c: aa0003f7    	mov	x23, x0
10181b150: aa1603e0    	mov	x0, x22
10181b154: 95903000    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b158: aa1503e0    	mov	x0, x21
10181b15c: 95902ffe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b160: 34000117    	cbz	w23, 0x10181b180 <__text+0x1813180>
10181b164: 91032260    	add	x0, x19, #0xc8
10181b168: 95903009    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b16c: aa0003f5    	mov	x21, x0
10181b170: aa1403e1    	mov	x1, x20
10181b174: 95902ff2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b178: aa1503e0    	mov	x0, x21
10181b17c: 95902ff6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b180: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b184: f944dd01    	ldr	x1, [x8, #0x9b8] ; updateSearchReport
10181b188: aa1303e0    	mov	x0, x19
10181b18c: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10181b190: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10181b194: a94657f6    	ldp	x22, x21, [sp, #0x60]
10181b198: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10181b19c: a94467fa    	ldp	x26, x25, [sp, #0x40]
10181b1a0: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10181b1a4: 910243ff    	add	sp, sp, #0x90
10181b1a8: 15902fe5    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b1ac: aa1303e0    	mov	x0, x19
10181b1b0: aa1503e1    	mov	x1, x21
10181b1b4: 95902fe2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b1b8: aa1d03fd    	mov	x29, x29
10181b1bc: 95902fe3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b1c0: aa0003f7    	mov	x23, x0
10181b1c4: aa1603e1    	mov	x1, x22
10181b1c8: 95902fdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b1cc: aa0003f8    	mov	x24, x0
10181b1d0: aa1703e0    	mov	x0, x23
10181b1d4: 95902fe0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b1d8: 34001078    	cbz	w24, 0x10181b3e4 <__text+0x18133e4>
10181b1dc: 91032260    	add	x0, x19, #0xc8
10181b1e0: 95902feb    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b1e4: b4000320    	cbz	x0, 0x10181b248 <__text+0x1813248>
10181b1e8: aa0003f8    	mov	x24, x0
10181b1ec: 91032260    	add	x0, x19, #0xc8
10181b1f0: 95902fe7    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b1f4: aa0003f9    	mov	x25, x0
10181b1f8: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b1fc: f944c917    	ldr	x23, [x8, #0x990] ; voiceSearchVerifiedSearchType:
10181b200: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b204: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b208: aa1703e2    	mov	x2, x23
10181b20c: 95902fcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b210: aa0003fa    	mov	x26, x0
10181b214: aa1903e0    	mov	x0, x25
10181b218: 95902fcf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b21c: aa1803e0    	mov	x0, x24
10181b220: 95902fcd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b224: 3400013a    	cbz	w26, 0x10181b248 <__text+0x1813248>
10181b228: 91032260    	add	x0, x19, #0xc8
10181b22c: 95902fd8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b230: aa0003f8    	mov	x24, x0
10181b234: aa1703e1    	mov	x1, x23
10181b238: 52800002    	mov	w2, #0x0                ; =0
10181b23c: 95902fc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b240: aa1803e0    	mov	x0, x24
10181b244: 95902fc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b248: 900f4b28    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
10181b24c: f9418517    	ldr	x23, [x8, #0x308]
10181b250: d00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181b254: f9411101    	ldr	x1, [x8, #0x220] ; getExtInfo
10181b258: aa1303e0    	mov	x0, x19
10181b25c: 95902fb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b260: aa1d03fd    	mov	x29, x29
10181b264: 95902fb9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b268: aa0003f8    	mov	x24, x0
10181b26c: 900f3108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10181b270: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
10181b274: 95902fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b278: aa1d03fd    	mov	x29, x29
10181b27c: 95902fb3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b280: aa0003f9    	mov	x25, x0
10181b284: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b288: f944cd01    	ldr	x1, [x8, #0x998] ; getFTSSearchText
10181b28c: aa1303e0    	mov	x0, x19
10181b290: 95902fab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b294: aa1d03fd    	mov	x29, x29
10181b298: 95902fac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b29c: aa0003fa    	mov	x26, x0
10181b2a0: b00f3468    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
10181b2a4: f9454901    	ldr	x1, [x8, #0xa90] ; report26897InVoiceV3WithActionID:actionType:extInfo:query:
10181b2a8: aa1703e0    	mov	x0, x23
10181b2ac: 52819602    	mov	w2, #0xcb0              ; =3248
10181b2b0: 52800243    	mov	w3, #0x12               ; =18
10181b2b4: aa1903e4    	mov	x4, x25
10181b2b8: aa1a03e5    	mov	x5, x26
10181b2bc: 95902fa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b2c0: aa1a03e0    	mov	x0, x26
10181b2c4: 95902fa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b2c8: aa1903e0    	mov	x0, x25
10181b2cc: 95902fa2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b2d0: aa1803e0    	mov	x0, x24
10181b2d4: 95902fa0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b2d8: f9453760    	ldr	x0, [x27, #0xa68]
10181b2dc: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181b2e0: 9119a108    	add	x8, x8, #0x668
10181b2e4: f90003e8    	str	x8, [sp]
10181b2e8: b00cd2c3    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10181b2ec: 91388063    	add	x3, x3, #0xe20
10181b2f0: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b2f4: 912160a5    	add	x5, x5, #0x858
10181b2f8: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b2fc: 912a84e7    	add	x7, x7, #0xaa1
10181b300: aa1403e1    	mov	x1, x20
10181b304: 52800042    	mov	w2, #0x2                ; =2
10181b308: 52800004    	mov	w4, #0x0                ; =0
10181b30c: 52801786    	mov	w6, #0xbc               ; =188
10181b310: 95902f8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b314: 91032260    	add	x0, x19, #0xc8
10181b318: 95902f9d    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b31c: b4000300    	cbz	x0, 0x10181b37c <__text+0x181337c>
10181b320: aa0003f8    	mov	x24, x0
10181b324: 91032260    	add	x0, x19, #0xc8
10181b328: 95902f99    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b32c: aa0003f9    	mov	x25, x0
10181b330: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b334: f944d117    	ldr	x23, [x8, #0x9a0] ; reloadList
10181b338: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b33c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b340: aa1703e2    	mov	x2, x23
10181b344: 95902f7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b348: aa0003fa    	mov	x26, x0
10181b34c: aa1903e0    	mov	x0, x25
10181b350: 95902f81    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b354: aa1803e0    	mov	x0, x24
10181b358: 95902f7f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b35c: 3400011a    	cbz	w26, 0x10181b37c <__text+0x181337c>
10181b360: 91032260    	add	x0, x19, #0xc8
10181b364: 95902f8a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b368: aa0003f8    	mov	x24, x0
10181b36c: aa1703e1    	mov	x1, x23
10181b370: 95902f73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b374: aa1803e0    	mov	x0, x24
10181b378: 95902f77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b37c: 91032260    	add	x0, x19, #0xc8
10181b380: 95902f83    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b384: b4000300    	cbz	x0, 0x10181b3e4 <__text+0x18133e4>
10181b388: aa0003f8    	mov	x24, x0
10181b38c: 91032260    	add	x0, x19, #0xc8
10181b390: 95902f7f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b394: aa0003f9    	mov	x25, x0
10181b398: 900f3488    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10181b39c: f944d517    	ldr	x23, [x8, #0x9a8] ; localSearchComplete
10181b3a0: f00f4748    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10181b3a4: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10181b3a8: aa1703e2    	mov	x2, x23
10181b3ac: 95902f64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b3b0: aa0003fa    	mov	x26, x0
10181b3b4: aa1903e0    	mov	x0, x25
10181b3b8: 95902f67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b3bc: aa1803e0    	mov	x0, x24
10181b3c0: 95902f65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b3c4: 3400011a    	cbz	w26, 0x10181b3e4 <__text+0x18133e4>
10181b3c8: 91032260    	add	x0, x19, #0xc8
10181b3cc: 95902f70    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
10181b3d0: aa0003f8    	mov	x24, x0
10181b3d4: aa1703e1    	mov	x1, x23
10181b3d8: 95902f59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b3dc: aa1803e0    	mov	x0, x24
10181b3e0: 95902f5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b3e4: aa1303e0    	mov	x0, x19
10181b3e8: aa1503e1    	mov	x1, x21
10181b3ec: 95902f54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b3f0: aa1d03fd    	mov	x29, x29
10181b3f4: 95902f55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10181b3f8: aa0003f5    	mov	x21, x0
10181b3fc: aa1603e1    	mov	x1, x22
10181b400: 95902f4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b404: aa0003f6    	mov	x22, x0
10181b408: aa1503e0    	mov	x0, x21
10181b40c: 95902f52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10181b410: 340002b6    	cbz	w22, 0x10181b464 <__text+0x1813464>
10181b414: d00f3468    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10181b418: f9426501    	ldr	x1, [x8, #0x4c8] ; setIsDuringVoiceSearch:
10181b41c: aa1303e0    	mov	x0, x19
10181b420: 52800002    	mov	w2, #0x0                ; =0
10181b424: 95902f46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b428: f9453760    	ldr	x0, [x27, #0xa68]
10181b42c: d00e6be8    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10181b430: 911a2108    	add	x8, x8, #0x688
10181b434: f90003e8    	str	x8, [sp]
10181b438: b00cddc3    	adrp	x3, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
10181b43c: 91212063    	add	x3, x3, #0x848
10181b440: 900cdea5    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b444: 912160a5    	add	x5, x5, #0x858
10181b448: 900cdea7    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10181b44c: 912a84e7    	add	x7, x7, #0xaa1
10181b450: aa1403e1    	mov	x1, x20
10181b454: 52800042    	mov	w2, #0x2                ; =2
10181b458: 52800004    	mov	w4, #0x0                ; =0
10181b45c: 52801866    	mov	w6, #0xc3               ; =195
10181b460: 95902f37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10181b464: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10181b468: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10181b46c: a94657f6    	ldp	x22, x21, [sp, #0x60]
10181b470: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10181b474: a94467fa    	ldp	x26, x25, [sp, #0x40]
10181b478: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10181b47c: 910243ff    	add	sp, sp, #0x90
10181b480: d65f03c0    	ret
