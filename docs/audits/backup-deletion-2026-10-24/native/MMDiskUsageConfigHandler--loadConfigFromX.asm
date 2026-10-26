
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029abae8: d100c3ff    	sub	sp, sp, #0x30
1029abaec: a9014ff4    	stp	x20, x19, [sp, #0x10]
1029abaf0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1029abaf4: 910083fd    	add	x29, sp, #0x20
1029abaf8: aa0003f3    	mov	x19, x0
1029abafc: f00f1448    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029abb00: 52800029    	mov	w9, #0x1                ; =1
1029abb04: 3933ed09    	strb	w9, [x8, #0xcfb]
1029abb08: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb0c: f9424101    	ldr	x1, [x8, #0x480] ; setM_isEnableReport:
1029abb10: 52800022    	mov	w2, #0x1                ; =1
1029abb14: 9549ed8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb18: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb1c: f9424501    	ldr	x1, [x8, #0x488] ; setM_isEnableScan:
1029abb20: aa1303e0    	mov	x0, x19
1029abb24: 52800022    	mov	w2, #0x1                ; =1
1029abb28: 9549ed85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb2c: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb30: f9424901    	ldr	x1, [x8, #0x490] ; setM_isDelete:
1029abb34: aa1303e0    	mov	x0, x19
1029abb38: 52800022    	mov	w2, #0x1                ; =1
1029abb3c: 9549ed80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb40: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb44: f9424d01    	ldr	x1, [x8, #0x498] ; setM_isDeleteUnknow:
1029abb48: aa1303e0    	mov	x0, x19
1029abb4c: 52800022    	mov	w2, #0x1                ; =1
1029abb50: 9549ed7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb54: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb58: f9425101    	ldr	x1, [x8, #0x4a0] ; setM_isReportDelUnknow:
1029abb5c: aa1303e0    	mov	x0, x19
1029abb60: 52800022    	mov	w2, #0x1                ; =1
1029abb64: 9549ed76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb68: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb6c: f9425501    	ldr	x1, [x8, #0x4a8] ; setM_isEnableDeleteEmptyFolder:
1029abb70: aa1303e0    	mov	x0, x19
1029abb74: 52800022    	mov	w2, #0x1                ; =1
1029abb78: 9549ed71    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb7c: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb80: f9425901    	ldr	x1, [x8, #0x4b0] ; setM_isEnablePreForceCleanTmp:
1029abb84: aa1303e0    	mov	x0, x19
1029abb88: 52800022    	mov	w2, #0x1                ; =1
1029abb8c: 9549ed6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abb90: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abb94: f9425d01    	ldr	x1, [x8, #0x4b8] ; setM_timeIntervalBetweenReport:
1029abb98: aa1303e0    	mov	x0, x19
1029abb9c: 528a3002    	mov	w2, #0x5180             ; =20864
1029abba0: 72a00022    	movk	w2, #0x1, lsl #16
1029abba4: 9549ed66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abba8: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abbac: f9426101    	ldr	x1, [x8, #0x4c0] ; setM_timeIntervalBetweenScan:
1029abbb0: aa1303e0    	mov	x0, x19
1029abbb4: 52802582    	mov	w2, #0x12c              ; =300
1029abbb8: 9549ed61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abbbc: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abbc0: f9426501    	ldr	x1, [x8, #0x4c8] ; setM_timeForEachScan:
1029abbc4: aa1303e0    	mov	x0, x19
1029abbc8: 52800502    	mov	w2, #0x28               ; =40
1029abbcc: 9549ed5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abbd0: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abbd4: f9426901    	ldr	x1, [x8, #0x4d0] ; setM_timeIntervalBetweenEachScanFinish:
1029abbd8: aa1303e0    	mov	x0, x19
1029abbdc: 52870802    	mov	w2, #0x3840             ; =14400
1029abbe0: 9549ed57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abbe4: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abbe8: f9426d01    	ldr	x1, [x8, #0x4d8] ; setM_timeIntervalWholeScan:
1029abbec: aa1303e0    	mov	x0, x19
1029abbf0: 528ea002    	mov	w2, #0x7500             ; =29952
1029abbf4: 72a00242    	movk	w2, #0x12, lsl #16
1029abbf8: 9549ed51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abbfc: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abc00: f9427101    	ldr	x1, [x8, #0x4e0] ; setM_timeIntervalWholeScanReport:
1029abc04: aa1303e0    	mov	x0, x19
1029abc08: 528a3002    	mov	w2, #0x5180             ; =20864
1029abc0c: 72a00022    	movk	w2, #0x1, lsl #16
1029abc10: 9549ed4b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abc14: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abc18: f9427501    	ldr	x1, [x8, #0x4e8] ; setM_timeForForceCleanTmp:
1029abc1c: aa1303e0    	mov	x0, x19
1029abc20: 528ea002    	mov	w2, #0x7500             ; =29952
1029abc24: 72a00242    	movk	w2, #0x12, lsl #16
1029abc28: 9549ed45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abc2c: 900ebe48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029abc30: f9453500    	ldr	x0, [x8, #0xa68]
1029abc34: d00ea468    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029abc38: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029abc3c: d00de648    	adrp	x8, 0x11e675000 <dyld_stub_binder+0x11e675000>
1029abc40: 913c2108    	add	x8, x8, #0xf08
1029abc44: a9004fe8    	stp	x8, x19, [sp]
1029abc48: b00c5e83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029abc4c: 9125d063    	add	x3, x3, #0x974
1029abc50: 900c5ec5    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029abc54: 911460a5    	add	x5, x5, #0x518
1029abc58: 900c5ec7    	adrp	x7, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029abc5c: 9114d0e7    	add	x7, x7, #0x534
1029abc60: 52800042    	mov	w2, #0x2                ; =2
1029abc64: 52800004    	mov	w4, #0x0                ; =0
1029abc68: 528006a6    	mov	w6, #0x35               ; =53
1029abc6c: 9549ed34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abc70: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1029abc74: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1029abc78: 9100c3ff    	add	sp, sp, #0x30
1029abc7c: d65f03c0    	ret
