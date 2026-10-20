
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106288280: d10503ff    	sub	sp, sp, #0x140
106288284: 6d0c2beb    	stp	d11, d10, [sp, #0xc0]
106288288: 6d0d23e9    	stp	d9, d8, [sp, #0xd0]
10628828c: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
106288290: a90f67fa    	stp	x26, x25, [sp, #0xf0]
106288294: a9105ff8    	stp	x24, x23, [sp, #0x100]
106288298: a91157f6    	stp	x22, x21, [sp, #0x110]
10628829c: a9124ff4    	stp	x20, x19, [sp, #0x120]
1062882a0: a9137bfd    	stp	x29, x30, [sp, #0x130]
1062882a4: 9104c3fd    	add	x29, sp, #0x130
1062882a8: aa0203f3    	mov	x19, x2
1062882ac: aa0003f5    	mov	x21, x0
1062882b0: f00d4dc8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062882b4: 52800029    	mov	w9, #0x1                ; =1
1062882b8: 39289509    	strb	w9, [x8, #0xa25]
1062882bc: aa0203e0    	mov	x0, x2
1062882c0: 94667b9e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062882c4: b4003c13    	cbz	x19, 0x106288a44 <_Flutter_MMFoundation_BindContext+0x2764628>
1062882c8: f00cf3c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1062882cc: f946e914    	ldr	x20, [x8, #0xdd0] ; length
1062882d0: aa1303e0    	mov	x0, x19
1062882d4: aa1403e1    	mov	x1, x20
1062882d8: 94667b99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062882dc: b4003b40    	cbz	x0, 0x106288a44 <_Flutter_MMFoundation_BindContext+0x2764628>
1062882e0: f9003ff4    	str	x20, [sp, #0x78]
1062882e4: 900cfd88    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062882e8: b98d8108    	ldrsw	x8, [x8, #0xd80]
1062882ec: f90033e8    	str	x8, [sp, #0x60]
1062882f0: f8686aa0    	ldr	x0, [x21, x8]
1062882f4: d00cf3e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1062882f8: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
1062882fc: 1e6e1000    	fmov	d0, #1.00000000
106288300: 94667b8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288304: 900cfd88    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106288308: b98d8516    	ldrsw	x22, [x8, #0xd84]
10628830c: f8766aa0    	ldr	x0, [x21, x22]
106288310: 900cddc8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
106288314: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
106288318: f90043f3    	str	x19, [sp, #0x80]
10628831c: aa1303e2    	mov	x2, x19
106288320: 94667b87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288324: f8766aa0    	ldr	x0, [x21, x22]
106288328: d00cf3c8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10628832c: f9449d01    	ldr	x1, [x8, #0x938] ; height
106288330: f9001fe1    	str	x1, [sp, #0x38]
106288334: 94667b82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288338: 1e604008    	fmov	d8, d0
10628833c: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106288340: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
106288344: f00cf748    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106288348: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628834c: 900cf3c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106288350: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106288354: f90047e1    	str	x1, [sp, #0x88]
106288358: 94667b79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628835c: aa1d03fd    	mov	x29, x29
106288360: 94667b7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288364: aa0003f8    	mov	x24, x0
106288368: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628836c: f9404100    	ldr	x0, [x8, #0x80]
106288370: f00cf3a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106288374: f947ad14    	ldr	x20, [x8, #0xf58] ; class
106288378: aa1403e1    	mov	x1, x20
10628837c: 94667b70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288380: aa0003e2    	mov	x2, x0
106288384: b00cdd88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106288388: f946411c    	ldr	x28, [x8, #0xc80] ; getService:
10628838c: aa1803e0    	mov	x0, x24
106288390: aa1c03e1    	mov	x1, x28
106288394: 94667b6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288398: aa1d03fd    	mov	x29, x29
10628839c: 94667b6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062883a0: aa0003fa    	mov	x26, x0
1062883a4: f00cdd88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1062883a8: f947fd17    	ldr	x23, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
1062883ac: b00c1102    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
1062883b0: 912ca042    	add	x2, x2, #0xb28
1062883b4: d00c10e3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
1062883b8: 9124a063    	add	x3, x3, #0x928
1062883bc: aa1703e1    	mov	x1, x23
1062883c0: 94667b5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062883c4: aa1d03fd    	mov	x29, x29
1062883c8: 94667b60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062883cc: aa0003fb    	mov	x27, x0
1062883d0: 900cdda8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1062883d4: f9400119    	ldr	x25, [x8]
1062883d8: aa1303e0    	mov	x0, x19
1062883dc: aa1903e1    	mov	x1, x25
1062883e0: aa1b03e2    	mov	x2, x27
1062883e4: 94667b56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062883e8: 1e60100a    	fmov	d10, #2.00000000
1062883ec: 1f4a2008    	fmadd	d8, d0, d10, d8
1062883f0: aa1b03e0    	mov	x0, x27
1062883f4: 94667b58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062883f8: aa1a03e0    	mov	x0, x26
1062883fc: 94667b56    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288400: aa1803e0    	mov	x0, x24
106288404: f00cf758    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106288408: 94667b53    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628840c: f8766aa0    	ldr	x0, [x21, x22]
106288410: f00cf408    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106288414: f947a501    	ldr	x1, [x8, #0xf48] ; width
106288418: f90037e1    	str	x1, [sp, #0x68]
10628841c: 94667b48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288420: 1e604009    	fmov	d9, d0
106288424: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106288428: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
10628842c: f945eb00    	ldr	x0, [x24, #0xbd0] ; ��d 
106288430: f94047e1    	ldr	x1, [sp, #0x88]
106288434: 94667b42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288438: aa1d03fd    	mov	x29, x29
10628843c: 94667b43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288440: aa0003fa    	mov	x26, x0
106288444: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106288448: f9404100    	ldr	x0, [x8, #0x80]
10628844c: f9002ff4    	str	x20, [sp, #0x58]
106288450: aa1403e1    	mov	x1, x20
106288454: 94667b3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288458: aa0003e2    	mov	x2, x0
10628845c: aa1a03e0    	mov	x0, x26
106288460: f9002bfc    	str	x28, [sp, #0x50]
106288464: aa1c03e1    	mov	x1, x28
106288468: 94667b35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628846c: aa1d03fd    	mov	x29, x29
106288470: 94667b36    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288474: aa0003fb    	mov	x27, x0
106288478: d00c10e2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628847c: 91242042    	add	x2, x2, #0x908
106288480: f90027f7    	str	x23, [sp, #0x48]
106288484: aa1703e1    	mov	x1, x23
106288488: d00c10e3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628848c: 9124a063    	add	x3, x3, #0x928
106288490: 94667b2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288494: aa1d03fd    	mov	x29, x29
106288498: 94667b2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628849c: aa0003f7    	mov	x23, x0
1062884a0: aa1303e0    	mov	x0, x19
1062884a4: f90023f9    	str	x25, [sp, #0x40]
1062884a8: aa1903e1    	mov	x1, x25
1062884ac: aa1703e2    	mov	x2, x23
1062884b0: 94667b23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062884b4: 1f4a2409    	fmadd	d9, d0, d10, d9
1062884b8: aa1703e0    	mov	x0, x23
1062884bc: 94667b26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062884c0: aa1b03e0    	mov	x0, x27
1062884c4: 94667b24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062884c8: aa1a03e0    	mov	x0, x26
1062884cc: 94667b22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062884d0: d00cdda8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1062884d4: f9410917    	ldr	x23, [x8, #0x210] ; viewModel
1062884d8: aa1503e0    	mov	x0, x21
1062884dc: aa1703e1    	mov	x1, x23
1062884e0: 94667b17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062884e4: aa1d03fd    	mov	x29, x29
1062884e8: 94667b18    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062884ec: aa0003f3    	mov	x19, x0
1062884f0: f00cea48    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062884f4: f9462901    	ldr	x1, [x8, #0xc50] ; isTranslateEnd
1062884f8: 94667b11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062884fc: aa0003f6    	mov	x22, x0
106288500: aa1303e0    	mov	x0, x19
106288504: 94667b14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288508: f00cf75b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10628850c: b00cdd99    	adrp	x25, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106288510: f9003bf6    	str	x22, [sp, #0x70]
106288514: 34000bb6    	cbz	w22, 0x106288688 <_Flutter_MMFoundation_BindContext+0x276426c>
106288518: f9453773    	ldr	x19, [x27, #0xa68] ; �gH 
10628851c: aa1503e0    	mov	x0, x21
106288520: aa1703e1    	mov	x1, x23
106288524: 94667b06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288528: aa1d03fd    	mov	x29, x29
10628852c: 94667b07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288530: aa0003f4    	mov	x20, x0
106288534: b00ce028    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
106288538: f944a11a    	ldr	x26, [x8, #0x940] ; voiceTranslateInfo
10628853c: aa1a03e1    	mov	x1, x26
106288540: 94667aff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288544: aa1d03fd    	mov	x29, x29
106288548: 94667b00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628854c: aa0003fb    	mov	x27, x0
106288550: b00cdde8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
106288554: f940c901    	ldr	x1, [x8, #0x190] ; voiceId
106288558: 94667af9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628855c: aa1d03fd    	mov	x29, x29
106288560: 94667afa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288564: aa1803fc    	mov	x28, x24
106288568: aa0003f8    	mov	x24, x0
10628856c: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106288570: d00c2f88    	adrp	x8, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106288574: 9130a108    	add	x8, x8, #0xc28
106288578: a90003e8    	stp	x8, x0, [sp]
10628857c: d00ab8c5    	adrp	x5, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106288580: 9107f8a5    	add	x5, x5, #0x1fe
106288584: d00ab8c7    	adrp	x7, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106288588: 913078e7    	add	x7, x7, #0xc1e
10628858c: aa1303e0    	mov	x0, x19
106288590: 52800042    	mov	w2, #0x2                ; =2
106288594: d2800003    	mov	x3, #0x0                ; =0
106288598: 52800004    	mov	w4, #0x0                ; =0
10628859c: 52810766    	mov	w6, #0x83b              ; =2107
1062885a0: 94667ae7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062885a4: aa1803e0    	mov	x0, x24
1062885a8: aa1c03f8    	mov	x24, x28
1062885ac: 94667aea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062885b0: aa1b03e0    	mov	x0, x27
1062885b4: f00cf75b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1062885b8: 94667ae7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062885bc: aa1403e0    	mov	x0, x20
1062885c0: 94667ae5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062885c4: aa1503e0    	mov	x0, x21
1062885c8: aa1703e1    	mov	x1, x23
1062885cc: 94667adc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062885d0: aa1d03fd    	mov	x29, x29
1062885d4: 94667add    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062885d8: aa0003f3    	mov	x19, x0
1062885dc: aa1a03e1    	mov	x1, x26
1062885e0: 94667ad7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062885e4: aa1d03fd    	mov	x29, x29
1062885e8: 94667ad8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062885ec: aa0003f4    	mov	x20, x0
1062885f0: f00cea48    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062885f4: f9478501    	ldr	x1, [x8, #0xf08] ; setBShowAnimation:
1062885f8: 52800002    	mov	w2, #0x0                ; =0
1062885fc: 94667ad0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288600: aa1403e0    	mov	x0, x20
106288604: 94667ad4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288608: aa1303e0    	mov	x0, x19
10628860c: 94667ad2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288610: f945eb80    	ldr	x0, [x28, #0xbd0]
106288614: f94047e1    	ldr	x1, [sp, #0x88]
106288618: 94667ac9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628861c: aa1d03fd    	mov	x29, x29
106288620: 94667aca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288624: aa0003f3    	mov	x19, x0
106288628: 900cf748    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10628862c: f9468102    	ldr	x2, [x8, #0xd00]
106288630: f00cea48    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106288634: f946c503    	ldr	x3, [x8, #0xd88] ; OnVoiceTranslateEnd:StopReason:
106288638: d00b9b28    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10628863c: f947e108    	ldr	x8, [x8, #0xfc0]
106288640: f9004be8    	str	x8, [sp, #0x90]
106288644: b00957c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106288648: fd41c100    	ldr	d0, [x8, #0x380]
10628864c: 90000008    	adrp	x8, 0x106288000 <_Flutter_MMFoundation_BindContext+0x2763be4>
106288650: 9129d108    	add	x8, x8, #0xa74
106288654: d00b9b69    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
106288658: 91238129    	add	x9, x9, #0x8e0
10628865c: fd004fe0    	str	d0, [sp, #0x98]
106288660: a90a27e8    	stp	x8, x9, [sp, #0xa0]
106288664: f9005bf5    	str	x21, [sp, #0xb0]
106288668: d00cdd88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10628866c: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
106288670: 910243e4    	add	x4, sp, #0x90
106288674: 94667ab2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288678: aa1303e0    	mov	x0, x19
10628867c: 94667ab6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288680: f94033fc    	ldr	x28, [sp, #0x60]
106288684: 14000007    	b	0x1062886a0 <_Flutter_MMFoundation_BindContext+0x2764284>
106288688: f94033fc    	ldr	x28, [sp, #0x60]
10628868c: f87c6aa0    	ldr	x0, [x21, x28]
106288690: f9401fe1    	ldr	x1, [sp, #0x38]
106288694: 94667aaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288698: 1e602100    	fcmp	d8, d0
10628869c: 1e684c08    	fcsel	d8, d0, d8, mi
1062886a0: f87c6aa0    	ldr	x0, [x21, x28]
1062886a4: f94037f6    	ldr	x22, [sp, #0x68]
1062886a8: aa1603e1    	mov	x1, x22
1062886ac: 94667aa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062886b0: 1e602120    	fcmp	d9, d0
1062886b4: 1e694c09    	fcsel	d9, d0, d9, mi
1062886b8: aa1503e0    	mov	x0, x21
1062886bc: aa1703e1    	mov	x1, x23
1062886c0: 94667a9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062886c4: aa1d03fd    	mov	x29, x29
1062886c8: 94667aa0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062886cc: aa0003f3    	mov	x19, x0
1062886d0: f00cea48    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062886d4: f9465d01    	ldr	x1, [x8, #0xcb8] ; dialectFeedbackShowing
1062886d8: 94667a99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062886dc: aa0003f4    	mov	x20, x0
1062886e0: aa1303e0    	mov	x0, x19
1062886e4: 94667a9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062886e8: 340006d4    	cbz	w20, 0x1062887c0 <_Flutter_MMFoundation_BindContext+0x27643a4>
1062886ec: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1062886f0: f9450100    	ldr	x0, [x8, #0xa00] ; 0�7 
1062886f4: 900cdfe8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
1062886f8: f946c901    	ldr	x1, [x8, #0xd90] ; getTextMessageNodeWidth:
1062886fc: aa1503e2    	mov	x2, x21
106288700: 94667a8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288704: 1e60400a    	fmov	d10, d0
106288708: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628870c: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
106288710: f945eb00    	ldr	x0, [x24, #0xbd0] ; ��d 
106288714: f94047e1    	ldr	x1, [sp, #0x88]
106288718: 94667a89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628871c: aa1d03fd    	mov	x29, x29
106288720: 94667a8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288724: aa0003f4    	mov	x20, x0
106288728: 900cf768    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628872c: f9404100    	ldr	x0, [x8, #0x80]
106288730: f9402fe1    	ldr	x1, [sp, #0x58]
106288734: 94667a82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288738: aa0003e2    	mov	x2, x0
10628873c: aa1403e0    	mov	x0, x20
106288740: f9402be1    	ldr	x1, [sp, #0x50]
106288744: 94667a7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288748: aa1d03fd    	mov	x29, x29
10628874c: 94667a7f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288750: aa0003f8    	mov	x24, x0
106288754: d00c10e2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
106288758: 91242042    	add	x2, x2, #0x908
10628875c: d00c10e3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
106288760: 9124a063    	add	x3, x3, #0x928
106288764: f94027e1    	ldr	x1, [sp, #0x48]
106288768: 94667a75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628876c: aa1d03fd    	mov	x29, x29
106288770: 94667a76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288774: aa1903fa    	mov	x26, x25
106288778: aa0003f9    	mov	x25, x0
10628877c: aa1303e0    	mov	x0, x19
106288780: f94023e1    	ldr	x1, [sp, #0x40]
106288784: aa1903e2    	mov	x2, x25
106288788: 94667a6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628878c: 1e601001    	fmov	d1, #2.00000000
106288790: 1f412800    	fmadd	d0, d0, d1, d10
106288794: 1e773001    	fmov	d1, #-25.00000000
106288798: 1e61280a    	fadd	d10, d0, d1
10628879c: aa1903e0    	mov	x0, x25
1062887a0: aa1a03f9    	mov	x25, x26
1062887a4: 94667a6c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062887a8: aa1803e0    	mov	x0, x24
1062887ac: 94667a6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062887b0: aa1403e0    	mov	x0, x20
1062887b4: 94667a68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062887b8: 1e6a2120    	fcmp	d9, d10
1062887bc: 1e6a4d29    	fcsel	d9, d9, d10, mi
1062887c0: f87c6aa0    	ldr	x0, [x21, x28]
1062887c4: b00cf408    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1062887c8: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
1062887cc: 1e604120    	fmov	d0, d9
1062887d0: 1e604101    	fmov	d1, d8
1062887d4: 94667a5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062887d8: aa1503e0    	mov	x0, x21
1062887dc: aa1703e1    	mov	x1, x23
1062887e0: 94667a57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062887e4: aa1d03fd    	mov	x29, x29
1062887e8: 94667a58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062887ec: aa0003f3    	mov	x19, x0
1062887f0: f00cdda8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1062887f4: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
1062887f8: 94667a51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062887fc: aa0003f4    	mov	x20, x0
106288800: aa1303e0    	mov	x0, x19
106288804: 94667a54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288808: 34000174    	cbz	w20, 0x106288834 <_Flutter_MMFoundation_BindContext+0x2764418>
10628880c: f00cfaa8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
106288810: 910a8108    	add	x8, x8, #0x2a0
106288814: b9800108    	ldrsw	x8, [x8]
106288818: f8686aa0    	ldr	x0, [x21, x8]
10628881c: aa1603e1    	mov	x1, x22
106288820: 94667a47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288824: f87c6aa0    	ldr	x0, [x21, x28]
106288828: 900cdda8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10628882c: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
106288830: 94667a43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288834: f9453773    	ldr	x19, [x27, #0xa68] ; �gH 
106288838: f87c6aa0    	ldr	x0, [x21, x28]
10628883c: d00cf408    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106288840: f9442501    	ldr	x1, [x8, #0x848] ; size
106288844: 94667a3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288848: 94667a9e    	bl	0x107c272c0 <_Flutter_MMFoundation_BindContext+0x4102ea4>
10628884c: aa1d03fd    	mov	x29, x29
106288850: 94667a3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288854: aa0003f4    	mov	x20, x0
106288858: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10628885c: f90033e1    	str	x1, [sp, #0x60]
106288860: d00c2f88    	adrp	x8, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106288864: 91312108    	add	x8, x8, #0xc48
106288868: a90003e8    	stp	x8, x0, [sp]
10628886c: d00ab8c5    	adrp	x5, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106288870: 9107f8a5    	add	x5, x5, #0x1fe
106288874: d00ab8c7    	adrp	x7, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
106288878: 913078e7    	add	x7, x7, #0xc1e
10628887c: aa1303e0    	mov	x0, x19
106288880: 52800042    	mov	w2, #0x2                ; =2
106288884: d2800003    	mov	x3, #0x0                ; =0
106288888: 52800004    	mov	w4, #0x0                ; =0
10628888c: 52810986    	mov	w6, #0x84c              ; =2124
106288890: 94667a2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288894: aa1403e0    	mov	x0, x20
106288898: 94667a2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628889c: f9453768    	ldr	x8, [x27, #0xa68] ; �gH 
1062888a0: f9002fe8    	str	x8, [sp, #0x58]
1062888a4: aa1503e0    	mov	x0, x21
1062888a8: aa1703e1    	mov	x1, x23
1062888ac: 94667a24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062888b0: aa1d03fd    	mov	x29, x29
1062888b4: 94667a25    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062888b8: f90047e0    	str	x0, [sp, #0x88]
1062888bc: d00cdda8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1062888c0: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1062888c4: 94667a1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062888c8: aa1d03fd    	mov	x29, x29
1062888cc: 94667a1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062888d0: f90037e0    	str	x0, [sp, #0x68]
1062888d4: 900cdda8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1062888d8: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
1062888dc: 94667a18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062888e0: aa0003fc    	mov	x28, x0
1062888e4: aa1503e0    	mov	x0, x21
1062888e8: aa1703e1    	mov	x1, x23
1062888ec: 94667a14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062888f0: aa1d03fd    	mov	x29, x29
1062888f4: 94667a15    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062888f8: aa0003fb    	mov	x27, x0
1062888fc: f00cea48    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106288900: f9471901    	ldr	x1, [x8, #0xe30] ; voiceNodeHeight
106288904: 94667a0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288908: 1e604008    	fmov	d8, d0
10628890c: aa1503e0    	mov	x0, x21
106288910: aa1703e1    	mov	x1, x23
106288914: 94667a0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288918: aa1d03fd    	mov	x29, x29
10628891c: 94667a0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288920: aa0003f9    	mov	x25, x0
106288924: b00ce028    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
106288928: f944a114    	ldr	x20, [x8, #0x940] ; voiceTranslateInfo
10628892c: aa1403e1    	mov	x1, x20
106288930: 94667a03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288934: aa1d03fd    	mov	x29, x29
106288938: 94667a04    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628893c: aa0003fa    	mov	x26, x0
106288940: 900cdde8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
106288944: f942b101    	ldr	x1, [x8, #0x560] ; translatedText
106288948: 946679fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628894c: aa1d03fd    	mov	x29, x29
106288950: 946679fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288954: aa0003f3    	mov	x19, x0
106288958: f9403ff8    	ldr	x24, [sp, #0x78]
10628895c: aa1803e1    	mov	x1, x24
106288960: 946679f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288964: aa0003f6    	mov	x22, x0
106288968: aa1503e0    	mov	x0, x21
10628896c: aa1703e1    	mov	x1, x23
106288970: 946679f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288974: aa1d03fd    	mov	x29, x29
106288978: 946679f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628897c: aa0003f5    	mov	x21, x0
106288980: aa1403e1    	mov	x1, x20
106288984: 946679ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106288988: aa1d03fd    	mov	x29, x29
10628898c: 946679ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106288990: aa0003f4    	mov	x20, x0
106288994: f00cde68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
106288998: f940e101    	ldr	x1, [x8, #0x1c0] ; displayText
10628899c: 946679e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062889a0: aa1d03fd    	mov	x29, x29
1062889a4: 946679e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062889a8: aa0003f7    	mov	x23, x0
1062889ac: aa1803e1    	mov	x1, x24
1062889b0: 946679e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062889b4: a90203f6    	stp	x22, x0, [sp, #0x20]
1062889b8: fd000fe8    	str	d8, [sp, #0x18]
1062889bc: d00c2f88    	adrp	x8, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
1062889c0: 9131a108    	add	x8, x8, #0xc68
1062889c4: f9403be9    	ldr	x9, [sp, #0x70]
1062889c8: a900f3e9    	stp	x9, x28, [sp, #0x8]
1062889cc: f90003e8    	str	x8, [sp]
1062889d0: a94587e0    	ldp	x0, x1, [sp, #0x58]
1062889d4: 52800042    	mov	w2, #0x2                ; =2
1062889d8: d2800003    	mov	x3, #0x0                ; =0
1062889dc: 52800004    	mov	w4, #0x0                ; =0
1062889e0: d00ab8c5    	adrp	x5, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
1062889e4: 9107f8a5    	add	x5, x5, #0x1fe
1062889e8: 52810a46    	mov	w6, #0x852              ; =2130
1062889ec: d00ab8c7    	adrp	x7, 0x11b9a2000 <dyld_stub_binder+0x11b9a2000>
1062889f0: 913078e7    	add	x7, x7, #0xc1e
1062889f4: 946679d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062889f8: aa1703e0    	mov	x0, x23
1062889fc: 946679d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a00: aa1403e0    	mov	x0, x20
106288a04: 946679d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a08: aa1503e0    	mov	x0, x21
106288a0c: 946679d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a10: aa1303e0    	mov	x0, x19
106288a14: 946679d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a18: aa1a03e0    	mov	x0, x26
106288a1c: 946679ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a20: aa1903e0    	mov	x0, x25
106288a24: 946679cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a28: aa1b03e0    	mov	x0, x27
106288a2c: 946679ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a30: f94037e0    	ldr	x0, [sp, #0x68]
106288a34: 946679c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a38: f94047e0    	ldr	x0, [sp, #0x88]
106288a3c: 946679c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a40: f94043f3    	ldr	x19, [sp, #0x80]
106288a44: aa1303e0    	mov	x0, x19
106288a48: 946679c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106288a4c: a9537bfd    	ldp	x29, x30, [sp, #0x130]
106288a50: a9524ff4    	ldp	x20, x19, [sp, #0x120]
106288a54: a95157f6    	ldp	x22, x21, [sp, #0x110]
106288a58: a9505ff8    	ldp	x24, x23, [sp, #0x100]
106288a5c: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
106288a60: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
106288a64: 6d4d23e9    	ldp	d9, d8, [sp, #0xd0]
106288a68: 6d4c2beb    	ldp	d11, d10, [sp, #0xc0]
106288a6c: 910503ff    	add	sp, sp, #0x140
106288a70: d65f03c0    	ret