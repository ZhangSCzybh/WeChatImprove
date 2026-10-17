
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062924dc: d101c3ff    	sub	sp, sp, #0x70
1062924e0: a9016ffc    	stp	x28, x27, [sp, #0x10]
1062924e4: a90267fa    	stp	x26, x25, [sp, #0x20]
1062924e8: a9035ff8    	stp	x24, x23, [sp, #0x30]
1062924ec: a90457f6    	stp	x22, x21, [sp, #0x40]
1062924f0: a9054ff4    	stp	x20, x19, [sp, #0x50]
1062924f4: a9067bfd    	stp	x29, x30, [sp, #0x60]
1062924f8: 910183fd    	add	x29, sp, #0x60
1062924fc: aa0203f3    	mov	x19, x2
106292500: aa0003f6    	mov	x22, x0
106292504: b00d4d88    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106292508: 52800029    	mov	w9, #0x1                ; =1
10629250c: 39294909    	strb	w9, [x8, #0xa52]
106292510: aa0203e0    	mov	x0, x2
106292514: 94665309    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106292518: 900cdd68    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10629251c: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
106292520: aa1303e0    	mov	x0, x19
106292524: 94665306    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292528: 7100881f    	cmp	w0, #0x22
10629252c: 54001061    	b.ne	0x106292738 <_Flutter_MMFoundation_BindContext+0x276e31c>
106292530: b00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106292534: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
106292538: f00cdd48    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10629253c: f9447d01    	ldr	x1, [x8, #0x8f8] ; currentUserName
106292540: 946652ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292544: aa1d03fd    	mov	x29, x29
106292548: 94665300    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10629254c: aa0003f4    	mov	x20, x0
106292550: f00cdd48    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106292554: f9429d15    	ldr	x21, [x8, #0x538] ; m_nsFromUsr
106292558: aa1303e0    	mov	x0, x19
10629255c: aa1503e1    	mov	x1, x21
106292560: 946652f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292564: aa1d03fd    	mov	x29, x29
106292568: 946652f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10629256c: aa0003f7    	mov	x23, x0
106292570: d00cf368    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106292574: f940b901    	ldr	x1, [x8, #0x170] ; compare:
106292578: aa1403e2    	mov	x2, x20
10629257c: 946652f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292580: aa0003f8    	mov	x24, x0
106292584: aa1703e0    	mov	x0, x23
106292588: 946652f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10629258c: b00cdd68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106292590: f940d908    	ldr	x8, [x8, #0x1b0] ; m_nsToUsr
106292594: f100031f    	cmp	x24, #0x0
106292598: 9a950101    	csel	x1, x8, x21, eq
10629259c: aa1303e0    	mov	x0, x19
1062925a0: 946652e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062925a4: aa1d03fd    	mov	x29, x29
1062925a8: 946652e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062925ac: aa0003f5    	mov	x21, x0
1062925b0: d00cea08    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
1062925b4: f9403101    	ldr	x1, [x8, #0x60] ; canUseCdnDownload
1062925b8: aa1303e0    	mov	x0, x19
1062925bc: 946652e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062925c0: 370000c0    	tbnz	w0, #0x0, 0x1062925d8 <_Flutter_MMFoundation_BindContext+0x276e1bc>
1062925c4: f00cde68    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
1062925c8: f9452d01    	ldr	x1, [x8, #0xa58] ; IsBypassMessage
1062925cc: aa1303e0    	mov	x0, x19
1062925d0: 946652db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062925d4: 340002a0    	cbz	w0, 0x106292628 <_Flutter_MMFoundation_BindContext+0x276e20c>
1062925d8: b00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1062925dc: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
1062925e0: f00cdd28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062925e4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1062925e8: b00c2f48    	adrp	x8, 0x11e87b000 <dyld_stub_binder+0x11e87b000>
1062925ec: 9105a108    	add	x8, x8, #0x168
1062925f0: a9004fe8    	stp	x8, x19, [sp]
1062925f4: f00a7c83    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1062925f8: 9107f063    	add	x3, x3, #0x1fc
1062925fc: b00ab885    	adrp	x5, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
106292600: 9117a0a5    	add	x5, x5, #0x5e8
106292604: b00ab887    	adrp	x7, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
106292608: 9117f8e7    	add	x7, x7, #0x5fe
10629260c: 52800042    	mov	w2, #0x2                ; =2
106292610: 52800004    	mov	w4, #0x0                ; =0
106292614: 52800826    	mov	w6, #0x41               ; =65
106292618: 946652c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629261c: d00cfd28    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106292620: 91388108    	add	x8, x8, #0xe20
106292624: 14000014    	b	0x106292674 <_Flutter_MMFoundation_BindContext+0x276e258>
106292628: b00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10629262c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
106292630: f00cdd28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106292634: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106292638: b00c2f48    	adrp	x8, 0x11e87b000 <dyld_stub_binder+0x11e87b000>
10629263c: 91062108    	add	x8, x8, #0x188
106292640: a9004fe8    	stp	x8, x19, [sp]
106292644: f00a7c83    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
106292648: 9107f063    	add	x3, x3, #0x1fc
10629264c: b00ab885    	adrp	x5, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
106292650: 9117a0a5    	add	x5, x5, #0x5e8
106292654: b00ab887    	adrp	x7, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
106292658: 9117f8e7    	add	x7, x7, #0x5fe
10629265c: 52800042    	mov	w2, #0x2                ; =2
106292660: 52800004    	mov	w4, #0x0                ; =0
106292664: 52800926    	mov	w6, #0x49               ; =73
106292668: 946652b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629266c: d00cfd28    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106292670: 91387108    	add	x8, x8, #0xe1c
106292674: b9800108    	ldrsw	x8, [x8]
106292678: f8686ad6    	ldr	x22, [x22, x8]
10629267c: d00cdd48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106292680: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
106292684: aa1303e0    	mov	x0, x19
106292688: 946652ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629268c: aa0003f7    	mov	x23, x0
106292690: d00cdd48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106292694: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
106292698: aa1303e0    	mov	x0, x19
10629269c: 946652a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062926a0: aa0003f8    	mov	x24, x0
1062926a4: d00cdd48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1062926a8: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
1062926ac: aa1303e0    	mov	x0, x19
1062926b0: 946652a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062926b4: aa0003f9    	mov	x25, x0
1062926b8: 900cdd68    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1062926bc: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
1062926c0: aa1303e0    	mov	x0, x19
1062926c4: 9466529e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062926c8: aa1d03fd    	mov	x29, x29
1062926cc: 9466529f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062926d0: aa0003fa    	mov	x26, x0
1062926d4: b00cdd68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1062926d8: f9402901    	ldr	x1, [x8, #0x50] ; m_dtThumbnail
1062926dc: aa1303e0    	mov	x0, x19
1062926e0: 94665297    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062926e4: aa1d03fd    	mov	x29, x29
1062926e8: 94665298    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062926ec: aa0003fb    	mov	x27, x0
1062926f0: d00cea08    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
1062926f4: f9403501    	ldr	x1, [x8, #0x68] ; OnSyncDownload:LocalID:n64SvrID:CreateTime:Xml:Voice:
1062926f8: aa1603e0    	mov	x0, x22
1062926fc: aa1503e2    	mov	x2, x21
106292700: aa1703e3    	mov	x3, x23
106292704: aa1803e4    	mov	x4, x24
106292708: aa1903e5    	mov	x5, x25
10629270c: aa1a03e6    	mov	x6, x26
106292710: aa1b03e7    	mov	x7, x27
106292714: 9466528a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292718: aa1b03e0    	mov	x0, x27
10629271c: 9466528e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292720: aa1a03e0    	mov	x0, x26
106292724: 9466528c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292728: aa1403e0    	mov	x0, x20
10629272c: 9466528a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292730: aa1503e0    	mov	x0, x21
106292734: 94665288    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292738: aa1303e0    	mov	x0, x19
10629273c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106292740: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106292744: a94457f6    	ldp	x22, x21, [sp, #0x40]
106292748: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10629274c: a94267fa    	ldp	x26, x25, [sp, #0x20]
106292750: a9416ffc    	ldp	x28, x27, [sp, #0x10]
106292754: 9101c3ff    	add	sp, sp, #0x70
106292758: 1466527f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>