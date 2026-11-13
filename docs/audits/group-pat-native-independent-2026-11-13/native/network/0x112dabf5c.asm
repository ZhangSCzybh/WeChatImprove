0x112dabf5c
0x112dabf5c: adrp     x9, #0x11faff000
0x112dabf60: ldr      x9, [x9, #0xfd8]
0x112dabf64: cbz      x9, #0x112dabf6c
0x112dabf68: br       x9
0x112dabf6c: sub      sp, sp, #0x1e0
0x112dabf70: stp      x22, x21, [sp, #0x1b0]
0x112dabf74: stp      x20, x19, [sp, #0x1c0]
0x112dabf78: stp      x29, x30, [sp, #0x1d0]
0x112dabf7c: add      x29, sp, #0x1d0
0x112dabf80: add      x20, sp, #0x80
0x112dabf84: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x112dabf88: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x112dabf8c: ldr      x8, [x8]
0x112dabf90: stur     x8, [x29, #-0x28]
0x112dabf94: mov      w21, #1
0x112dabf98: mov      w0, #1
0x112dabf9c: bl       #0x113219e44
0x112dabfa0: cbz      w0, #0x112dac004
0x112dabfa4: adrp     x2, #0x11af32000 ; 'ing &, const std::string &)>>>::name() [T = mars_boost::signals2::detail::bound_extended_slot_function3<mars_boost::function<void (const mars_boost::signals2::connection &, mars::stn::LongLink::TLongLinkStatus, const std::string &, const std::string &)>>]'
0x112dabfa8: add      x2, x2, #0x132 ; 'mars::mmext'
0x112dabfac: adrp     x3, #0x11a850000 ; 'rse'
0x112dabfb0: add      x3, x3, #0xe2f ; 'mmstn_logic.cc'
0x112dabfb4: adrp     x4, #0x11a851000 ; 'eGetHostIps'
0x112dabfb8: add      x4, x4, #0x366 ; '__initbind_baseprjevent'
0x112dabfbc: add      x0, sp, #0x80
0x112dabfc0: mov      w1, #1
0x112dabfc4: mov      w5, #0x1bc
0x112dabfc8: mov      w6, #0
0x112dabfcc: mov      x7, #0
0x112dabfd0: bl       #0x113218fd8
0x112dabfd4: movi     v0.16b, #0
0x112dabfd8: stp      q0, q0, [x20, #0x100]
0x112dabfdc: stp      q0, q0, [x20, #0xe0]
0x112dabfe0: stp      q0, q0, [x20, #0xc0]
0x112dabfe4: stp      q0, q0, [x20, #0xa0]
0x112dabfe8: adrp     x1, #0x11a851000 ; 'eGetHostIps'
0x112dabfec: add      x1, x1, #0x37e ; 'mars2 mmstn_logic __initbind_baseprjevent'
0x112dabff0: add      x0, sp, #0x80
0x112dabff4: sub      x2, x29, #0xb0
0x112dabff8: bl       #0x113219310
0x112dabffc: add      x0, sp, #0x80
0x112dac000: bl       #0x1132190f8
0x112dac004: bl       #0x1130e6950
0x112dac008: mov      x19, x0
0x112dac00c: str      w21, [sp, #0x6c]
0x112dac010: adrp     x8, #0x11cc87000
0x112dac014: add      x8, x8, #0x878
0x112dac018: sub      x9, x29, #0xb0
0x112dac01c: stur     x8, [x29, #-0xb0]
0x112dac020: stur     x9, [x29, #-0x98]
0x112dac024: movi     v0.16b, #0
0x112dac028: str      q0, [sp, #0x80]
0x112dac02c: str      q0, [x20, #0x10]
0x112dac030: add      x0, sp, #0x80
0x112dac034: sub      x1, x29, #0xb0
0x112dac038: bl       #0x10b657108
0x112dac03c: ldr      x0, [x19, #8]
0x112dac040: add      x8, sp, #0x70
0x112dac044: add      x1, sp, #0x6c
0x112dac048: add      x2, sp, #0x80
0x112dac04c: mov      w3, #0
0x112dac050: bl       #0x10b6487e4
0x112dac054: ldr      x0, [sp, #0x78]
0x112dac058: cbz      x0, #0x112dac080
0x112dac05c: add      x8, x0, #0xc
0x112dac060: ldaxr    w9, [x8]
0x112dac064: subs     w9, w9, #1
0x112dac068: stlxr    w10, w9, [x8]
0x112dac06c: cbnz     w10, #0x112dac060
0x112dac070: b.ne     #0x112dac080
0x112dac074: ldr      x8, [x0]
0x112dac078: ldr      x8, [x8, #0x18]
0x112dac07c: blr      x8
0x112dac080: ldr      x8, [sp, #0x98]
0x112dac084: cbz      x8, #0x112dac0ac
0x112dac088: tbnz     w8, #0, #0x112dac0a8
0x112dac08c: ldr      x8, [x8]
0x112dac090: cbz      x8, #0x112dac0a8
0x112dac094: add      x9, sp, #0x80
0x112dac098: add      x0, x9, #0x20
0x112dac09c: add      x1, x9, #0x20
0x112dac0a0: mov      w2, #2
0x112dac0a4: blr      x8
0x112dac0a8: str      xzr, [sp, #0x98]
0x112dac0ac: add      x8, sp, #0x80
0x112dac0b0: stur     x8, [x29, #-0xb8]
0x112dac0b4: sub      x0, x29, #0xb8
0x112dac0b8: bl       #0x10b649824
0x112dac0bc: ldur     x0, [x29, #-0x98]
0x112dac0c0: sub      x8, x29, #0xb0
0x112dac0c4: cmp      x0, x8
0x112dac0c8: b.eq     #0x112dac0d8
0x112dac0cc: cbz      x0, #0x112dac0e8
0x112dac0d0: mov      w8, #0x28
0x112dac0d4: b        #0x112dac0dc
0x112dac0d8: mov      w8, #0x20
0x112dac0dc: ldr      x9, [x0]
0x112dac0e0: ldr      x8, [x9, x8]
0x112dac0e4: blr      x8
0x112dac0e8: bl       #0x112db0130
0x112dac0ec: mov      x19, x0
0x112dac0f0: add      x8, sp, #0x80
0x112dac0f4: movi     v0.16b, #0
0x112dac0f8: str      q0, [x20, #0x10]
0x112dac0fc: str      q0, [sp, #0x80]
0x112dac100: adrp     x1, #0x112db0000
0x112dac104: add      x1, x1, #0x160
0x112dac108: add      x0, x8, #0x18
0x112dac10c: bl       #0x10b657974
0x112dac110: ldr      x0, [x19, #8]
0x112dac114: add      x8, sp, #0x58
0x112dac118: add      x1, sp, #0x80
0x112dac11c: mov      w2, #0
0x112dac120: bl       #0x10b657450
0x112dac124: ldr      x0, [sp, #0x60]
0x112dac128: cbz      x0, #0x112dac150
0x112dac12c: add      x8, x0, #0xc
0x112dac130: ldaxr    w9, [x8]
0x112dac134: subs     w9, w9, #1
0x112dac138: stlxr    w10, w9, [x8]
0x112dac13c: cbnz     w10, #0x112dac130
0x112dac140: b.ne     #0x112dac150
0x112dac144: ldr      x8, [x0]
0x112dac148: ldr      x8, [x8, #0x18]
0x112dac14c: blr      x8
0x112dac150: ldr      x8, [sp, #0x98]
0x112dac154: cbz      x8, #0x112dac17c
0x112dac158: tbnz     w8, #0, #0x112dac178
0x112dac15c: ldr      x8, [x8]
0x112dac160: cbz      x8, #0x112dac178
0x112dac164: add      x9, sp, #0x80
0x112dac168: add      x0, x9, #0x20
0x112dac16c: add      x1, x9, #0x20
0x112dac170: mov      w2, #2
0x112dac174: blr      x8
0x112dac178: str      xzr, [sp, #0x98]
0x112dac17c: add      x21, sp, #0x80
0x112dac180: stur     x21, [x29, #-0xb0]
0x112dac184: sub      x0, x29, #0xb0
0x112dac188: bl       #0x10b649824
0x112dac18c: bl       #0x112db0274
0x112dac190: mov      x19, x0
0x112dac194: movi     v0.16b, #0
0x112dac198: str      q0, [x20, #0x10]
0x112dac19c: str      q0, [sp, #0x80]
0x112dac1a0: adrp     x1, #0x112db0000
0x112dac1a4: add      x1, x1, #0x2a4
0x112dac1a8: add      x0, x21, #0x18
0x112dac1ac: bl       #0x10b657974
0x112dac1b0: ldr      x0, [x19, #8]
0x112dac1b4: add      x8, sp, #0x48
0x112dac1b8: add      x1, sp, #0x80
0x112dac1bc: mov      w2, #0
0x112dac1c0: bl       #0x10b657450
0x112dac1c4: ldr      x0, [sp, #0x50]
0x112dac1c8: cbz      x0, #0x112dac1f0
0x112dac1cc: add      x8, x0, #0xc
0x112dac1d0: ldaxr    w9, [x8]
0x112dac1d4: subs     w9, w9, #1
0x112dac1d8: stlxr    w10, w9, [x8]
0x112dac1dc: cbnz     w10, #0x112dac1d0
0x112dac1e0: b.ne     #0x112dac1f0
0x112dac1e4: ldr      x8, [x0]
0x112dac1e8: ldr      x8, [x8, #0x18]
0x112dac1ec: blr      x8
0x112dac1f0: ldr      x8, [sp, #0x98]
0x112dac1f4: cbz      x8, #0x112dac21c
0x112dac1f8: tbnz     w8, #0, #0x112dac218
0x112dac1fc: ldr      x8, [x8]
0x112dac200: cbz      x8, #0x112dac218
0x112dac204: add      x9, sp, #0x80
0x112dac208: add      x0, x9, #0x20
0x112dac20c: add      x1, x9, #0x20
0x112dac210: mov      w2, #2
0x112dac214: blr      x8
0x112dac218: str      xzr, [sp, #0x98]
0x112dac21c: add      x8, sp, #0x80
0x112dac220: stur     x8, [x29, #-0xb0]
0x112dac224: sub      x21, x29, #0xb0
0x112dac228: sub      x0, x29, #0xb0
0x112dac22c: bl       #0x10b649824
0x112dac230: bl       #0x1130e6adc
0x112dac234: mov      x19, x0
0x112dac238: mov      w8, #1
0x112dac23c: adrp     x9, #0x11cc87000
0x112dac240: add      x9, x9, #0x8f8
0x112dac244: str      w8, [sp, #0x6c]
0x112dac248: stur     x9, [x29, #-0xb0]
0x112dac24c: stur     x21, [x29, #-0x98]
0x112dac250: movi     v0.16b, #0
0x112dac254: str      q0, [sp, #0x80]
0x112dac258: str      q0, [x20, #0x10]
0x112dac25c: add      x0, sp, #0x80
0x112dac260: sub      x1, x29, #0xb0
0x112dac264: bl       #0x10b657108
0x112dac268: ldr      x0, [x19, #8]
0x112dac26c: add      x8, sp, #0x38
0x112dac270: add      x1, sp, #0x6c
0x112dac274: add      x2, sp, #0x80
0x112dac278: mov      w3, #0
0x112dac27c: bl       #0x10b6487e4
0x112dac280: ldr      x0, [sp, #0x40]
0x112dac284: cbz      x0, #0x112dac2ac
0x112dac288: add      x8, x0, #0xc
0x112dac28c: ldaxr    w9, [x8]
0x112dac290: subs     w9, w9, #1
0x112dac294: stlxr    w10, w9, [x8]
0x112dac298: cbnz     w10, #0x112dac28c
0x112dac29c: b.ne     #0x112dac2ac
0x112dac2a0: ldr      x8, [x0]
0x112dac2a4: ldr      x8, [x8, #0x18]
0x112dac2a8: blr      x8
0x112dac2ac: ldr      x8, [sp, #0x98]
0x112dac2b0: cbz      x8, #0x112dac2d8
0x112dac2b4: tbnz     w8, #0, #0x112dac2d4
0x112dac2b8: ldr      x8, [x8]
0x112dac2bc: cbz      x8, #0x112dac2d4
0x112dac2c0: add      x9, sp, #0x80
0x112dac2c4: add      x0, x9, #0x20
0x112dac2c8: add      x1, x9, #0x20
0x112dac2cc: mov      w2, #2
0x112dac2d0: blr      x8
0x112dac2d4: str      xzr, [sp, #0x98]
0x112dac2d8: add      x8, sp, #0x80
0x112dac2dc: stur     x8, [x29, #-0xb8]
0x112dac2e0: sub      x0, x29, #0xb8
0x112dac2e4: bl       #0x10b649824
0x112dac2e8: ldur     x0, [x29, #-0x98]
0x112dac2ec: sub      x8, x29, #0xb0
0x112dac2f0: cmp      x0, x8
0x112dac2f4: b.eq     #0x112dac304
0x112dac2f8: cbz      x0, #0x112dac314
0x112dac2fc: mov      w8, #0x28
0x112dac300: b        #0x112dac308
0x112dac304: mov      w8, #0x20
0x112dac308: ldr      x9, [x0]
0x112dac30c: ldr      x8, [x9, x8]
0x112dac310: blr      x8
0x112dac314: bl       #0x1130e6c68
0x112dac318: mov      x19, x0
0x112dac31c: add      x8, sp, #0x80
0x112dac320: movi     v0.16b, #0
0x112dac324: str      q0, [x20, #0x10]
0x112dac328: str      q0, [sp, #0x80]
0x112dac32c: adrp     x1, #0x112db0000
0x112dac330: add      x1, x1, #0x3b8
0x112dac334: add      x0, x8, #0x18
0x112dac338: bl       #0x10b65808c
0x112dac33c: ldr      x0, [x19, #8]
0x112dac340: add      x8, sp, #0x28
0x112dac344: add      x1, sp, #0x80
0x112dac348: mov      w2, #0
0x112dac34c: bl       #0x10b657b68
0x112dac350: ldr      x0, [sp, #0x30]
0x112dac354: cbz      x0, #0x112dac37c
0x112dac358: add      x8, x0, #0xc
0x112dac35c: ldaxr    w9, [x8]
0x112dac360: subs     w9, w9, #1
0x112dac364: stlxr    w10, w9, [x8]
0x112dac368: cbnz     w10, #0x112dac35c
0x112dac36c: b.ne     #0x112dac37c
0x112dac370: ldr      x8, [x0]
0x112dac374: ldr      x8, [x8, #0x18]
0x112dac378: blr      x8
0x112dac37c: ldr      x8, [sp, #0x98]
0x112dac380: cbz      x8, #0x112dac3a8
0x112dac384: tbnz     w8, #0, #0x112dac3a4
0x112dac388: ldr      x8, [x8]
0x112dac38c: cbz      x8, #0x112dac3a4
0x112dac390: add      x9, sp, #0x80
0x112dac394: add      x0, x9, #0x20
0x112dac398: add      x1, x9, #0x20
0x112dac39c: mov      w2, #2
0x112dac3a0: blr      x8
0x112dac3a4: str      xzr, [sp, #0x98]
0x112dac3a8: add      x8, sp, #0x80
0x112dac3ac: stur     x8, [x29, #-0xb0]
0x112dac3b0: sub      x21, x29, #0xb0
0x112dac3b4: sub      x0, x29, #0xb0
0x112dac3b8: bl       #0x10b649824
0x112dac3bc: bl       #0x1130e6cec
0x112dac3c0: mov      x19, x0
0x112dac3c4: adrp     x8, #0x11cc87000
0x112dac3c8: add      x8, x8, #0x978
0x112dac3cc: stur     x8, [x29, #-0xb0]
0x112dac3d0: stur     x21, [x29, #-0x98]
0x112dac3d4: movi     v0.16b, #0
0x112dac3d8: str      q0, [sp, #0x80]
0x112dac3dc: str      q0, [x20, #0x10]
0x112dac3e0: add      x0, sp, #0x80
0x112dac3e4: sub      x1, x29, #0xb0
0x112dac3e8: bl       #0x10b658354
0x112dac3ec: ldr      x0, [x19, #8]
0x112dac3f0: add      x8, sp, #0x18
0x112dac3f4: add      x1, sp, #0x80
0x112dac3f8: mov      w2, #0
0x112dac3fc: bl       #0x10b657450
0x112dac400: ldr      x0, [sp, #0x20]
0x112dac404: cbz      x0, #0x112dac42c
0x112dac408: add      x8, x0, #0xc
0x112dac40c: ldaxr    w9, [x8]
0x112dac410: subs     w9, w9, #1
0x112dac414: stlxr    w10, w9, [x8]
0x112dac418: cbnz     w10, #0x112dac40c
0x112dac41c: b.ne     #0x112dac42c
0x112dac420: ldr      x8, [x0]
0x112dac424: ldr      x8, [x8, #0x18]
0x112dac428: blr      x8
0x112dac42c: ldr      x8, [sp, #0x98]
0x112dac430: cbz      x8, #0x112dac458
0x112dac434: tbnz     w8, #0, #0x112dac454
0x112dac438: ldr      x8, [x8]
0x112dac43c: cbz      x8, #0x112dac454
0x112dac440: add      x9, sp, #0x80
0x112dac444: add      x0, x9, #0x20
0x112dac448: add      x1, x9, #0x20
0x112dac44c: mov      w2, #2
0x112dac450: blr      x8
0x112dac454: str      xzr, [sp, #0x98]
0x112dac458: add      x8, sp, #0x80
0x112dac45c: stur     x8, [x29, #-0xb8]
0x112dac460: sub      x0, x29, #0xb8
0x112dac464: bl       #0x10b649824
0x112dac468: ldur     x0, [x29, #-0x98]
0x112dac46c: sub      x8, x29, #0xb0
0x112dac470: cmp      x0, x8
0x112dac474: b.eq     #0x112dac484
0x112dac478: cbz      x0, #0x112dac494
0x112dac47c: mov      w8, #0x28
0x112dac480: b        #0x112dac488
0x112dac484: mov      w8, #0x20
0x112dac488: ldr      x9, [x0]
0x112dac48c: ldr      x8, [x9, x8]
0x112dac490: blr      x8
0x112dac494: bl       #0x1130e6d70
0x112dac498: mov      x19, x0
0x112dac49c: add      x8, sp, #0x80
0x112dac4a0: movi     v0.16b, #0
0x112dac4a4: str      q0, [x20, #0x10]
0x112dac4a8: str      q0, [sp, #0x80]
0x112dac4ac: adrp     x1, #0x112db0000
0x112dac4b0: add      x1, x1, #0x404
0x112dac4b4: add      x0, x8, #0x18
0x112dac4b8: bl       #0x10b658e10
0x112dac4bc: ldr      x0, [x19, #8]
0x112dac4c0: add      x8, sp, #8
0x112dac4c4: add      x1, sp, #0x80
0x112dac4c8: mov      w2, #0
0x112dac4cc: bl       #0x10b6587a4
0x112dac4d0: ldr      x0, [sp, #0x10]
0x112dac4d4: cbz      x0, #0x112dac4fc
0x112dac4d8: add      x8, x0, #0xc
0x112dac4dc: ldaxr    w9, [x8]
0x112dac4e0: subs     w9, w9, #1
0x112dac4e4: stlxr    w10, w9, [x8]
0x112dac4e8: cbnz     w10, #0x112dac4dc
0x112dac4ec: b.ne     #0x112dac4fc
0x112dac4f0: ldr      x8, [x0]
0x112dac4f4: ldr      x8, [x8, #0x18]
0x112dac4f8: blr      x8
0x112dac4fc: ldr      x8, [sp, #0x98]
0x112dac500: cbz      x8, #0x112dac528
0x112dac504: tbnz     w8, #0, #0x112dac524
0x112dac508: ldr      x8, [x8]
0x112dac50c: cbz      x8, #0x112dac524
0x112dac510: add      x9, sp, #0x80
0x112dac514: add      x0, x9, #0x20
0x112dac518: add      x1, x9, #0x20
0x112dac51c: mov      w2, #2
0x112dac520: blr      x8
0x112dac524: str      xzr, [sp, #0x98]
0x112dac528: add      x8, sp, #0x80
0x112dac52c: stur     x8, [x29, #-0xb0]
0x112dac530: sub      x0, x29, #0xb0
0x112dac534: bl       #0x10b649824
0x112dac538: ldur     x8, [x29, #-0x28]
0x112dac53c: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x112dac540: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x112dac544: ldr      x9, [x9]
0x112dac548: cmp      x9, x8
0x112dac54c: b.ne     #0x112dac564
0x112dac550: ldp      x29, x30, [sp, #0x1d0]
0x112dac554: ldp      x20, x19, [sp, #0x1c0]
0x112dac558: ldp      x22, x21, [sp, #0x1b0]
0x112dac55c: add      sp, sp, #0x1e0
0x112dac560: ret      
0x112dac564: bl       #0x116e58cf8 ; ___stack_chk_fail
