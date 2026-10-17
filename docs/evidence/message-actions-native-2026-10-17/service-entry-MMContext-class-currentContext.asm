
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175c4c64: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1175c4c68: a9014ff4    	stp	x20, x19, [sp, #0x10]
1175c4c6c: a9027bfd    	stp	x29, x30, [sp, #0x20]
1175c4c70: 910083fd    	add	x29, sp, #0x20
1175c4c74: f0045d74    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1175c4c78: f945ea80    	ldr	x0, [x20, #0xbd0] ; ��d 
1175c4c7c: b00459a8    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
1175c4c80: f945b501    	ldr	x1, [x8, #0xb68] ; contextFromTask
1175c4c84: 9435941a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175c4c88: b40000e0    	cbz	x0, 0x1175c4ca4 <_O266DecReleaseOutputPicture+0x43381ec>
1175c4c8c: aa0003f3    	mov	x19, x0
1175c4c90: aa1303e0    	mov	x0, x19
1175c4c94: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1175c4c98: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1175c4c9c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1175c4ca0: d65f03c0    	ret
1175c4ca4: d0045f93    	adrp	x19, 0x1201b6000 <dyld_stub_binder+0x1201b6000>
1175c4ca8: f9428a60    	ldr	x0, [x19, #0x510] ; H�d 
1175c4cac: b00459a8    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
1175c4cb0: f945b901    	ldr	x1, [x8, #0xb70] ; isRunInCoContext
1175c4cb4: 9435940e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175c4cb8: 340000c0    	cbz	w0, 0x1175c4cd0 <_O266DecReleaseOutputPicture+0x4338218>
1175c4cbc: f9428a60    	ldr	x0, [x19, #0x510] ; H�d 
1175c4cc0: 900459e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175c4cc4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1175c4cc8: 94359409    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175c4ccc: b5fffe00    	cbnz	x0, 0x1175c4c8c <_O266DecReleaseOutputPicture+0x43381d4>
1175c4cd0: b004e708    	adrp	x8, 0x1212a5000 <dyld_stub_binder+0x1212a5000>
1175c4cd4: f9441900    	ldr	x0, [x8, #0x830]
1175c4cd8: 94359543    	bl	0x11832a1e4 <dyld_stub_binder+0x11832a1e4>
1175c4cdc: b0053195    	adrp	x21, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
1175c4ce0: f942a2a8    	ldr	x8, [x21, #0x540]
1175c4ce4: f100001f    	cmp	x0, #0x0
1175c4ce8: 9a800113    	csel	x19, x8, x0, eq
1175c4cec: eb08027f    	cmp	x19, x8
1175c4cf0: 54fffd01    	b.ne	0x1175c4c90 <_O266DecReleaseOutputPicture+0x43381d8>
1175c4cf4: 94359551    	bl	0x11832a238 <dyld_stub_binder+0x11832a238>
1175c4cf8: 7100041f    	cmp	w0, #0x1
1175c4cfc: 54fffcab    	b.lt	0x1175c4c90 <_O266DecReleaseOutputPicture+0x43381d8>
1175c4d00: f945ea80    	ldr	x0, [x20, #0xbd0] ; ��d 
1175c4d04: b00443a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1175c4d08: f9469901    	ldr	x1, [x8, #0xd30] ; activeUserContext
1175c4d0c: 943593f8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175c4d10: f942a2a8    	ldr	x8, [x21, #0x540]
1175c4d14: f100001f    	cmp	x0, #0x0
1175c4d18: 9a800113    	csel	x19, x8, x0, eq
1175c4d1c: 17ffffdd    	b	0x1175c4c90 <_O266DecReleaseOutputPicture+0x43381d8>