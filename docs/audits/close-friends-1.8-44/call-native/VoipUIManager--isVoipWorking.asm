
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106395374: 900cf528    	adrp	x8, 0x120239000 <dyld_stub_binder+0x120239000>
106395378: b98f6508    	ldrsw	x8, [x8, #0xf64]
10639537c: f8686808    	ldr	x8, [x0, x8]
106395380: b4000068    	cbz	x8, 0x10639538c <_Flutter_MMFoundation_BindContext+0x2870f70>
106395384: 52800020    	mov	w0, #0x1                ; =1
106395388: d65f03c0    	ret
10639538c: 900cf528    	adrp	x8, 0x120239000 <dyld_stub_binder+0x120239000>
106395390: b98f6908    	ldrsw	x8, [x8, #0xf68]
106395394: f8686808    	ldr	x8, [x0, x8]
106395398: f100011f    	cmp	x8, #0x0
10639539c: 1a9f07e0    	cset	w0, ne
1063953a0: d65f03c0    	ret
