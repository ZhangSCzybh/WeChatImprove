
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167ec018: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1167ec01c: a90157f6    	stp	x22, x21, [sp, #0x10]
1167ec020: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167ec024: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167ec028: 9100c3fd    	add	x29, sp, #0x30
1167ec02c: aa0203f3    	mov	x19, x2
1167ec030: f004c8e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1167ec034: f9401514    	ldr	x20, [x8, #0x28] ; text
1167ec038: aa0203e0    	mov	x0, x2
1167ec03c: 946cf74d    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167ec040: aa1303e0    	mov	x0, x19
1167ec044: aa1403e1    	mov	x1, x20
1167ec048: 946cf729    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec04c: aa1d03fd    	mov	x29, x29
1167ec050: 946cf751    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167ec054: aa0003f4    	mov	x20, x0
1167ec058: b004c8a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1167ec05c: f9456d01    	ldr	x1, [x8, #0xad8] ; font
1167ec060: aa1303e0    	mov	x0, x19
1167ec064: 946cf722    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec068: aa1d03fd    	mov	x29, x29
1167ec06c: 946cf74a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167ec070: aa0003f5    	mov	x21, x0
1167ec074: aa1303e0    	mov	x0, x19
1167ec078: 946cf738    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec07c: d004b2a8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1167ec080: f9470901    	ldr	x1, [x8, #0xe10] ; stringSizeWithFont:
1167ec084: aa1403e0    	mov	x0, x20
1167ec088: aa1503e2    	mov	x2, x21
1167ec08c: 946cf718    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec090: 1e604008    	fmov	d8, d0
1167ec094: 1e604029    	fmov	d9, d1
1167ec098: aa1503e0    	mov	x0, x21
1167ec09c: 946cf72f    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec0a0: aa1403e0    	mov	x0, x20
1167ec0a4: 946cf72d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec0a8: 1e604100    	fmov	d0, d8
1167ec0ac: 1e604121    	fmov	d1, d9
1167ec0b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1167ec0b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167ec0b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1167ec0bc: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1167ec0c0: d65f03c0    	ret
