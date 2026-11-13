0x112debb50
0x112debb50: adrp     x9, #0x11fb01000
0x112debb54: ldr      x9, [x9, #0x690]
0x112debb58: cbz      x9, #0x112debb60
0x112debb5c: br       x9
0x112debb60: sub      sp, sp, #0x120
0x112debb64: stp      x28, x27, [sp, #0xc0]
0x112debb68: stp      x26, x25, [sp, #0xd0]
0x112debb6c: stp      x24, x23, [sp, #0xe0]
0x112debb70: stp      x22, x21, [sp, #0xf0]
0x112debb74: stp      x20, x19, [sp, #0x100]
0x112debb78: stp      x29, x30, [sp, #0x110]
0x112debb7c: add      x29, sp, #0x110
0x112debb80: mov      x21, x0
0x112debb84: adrp     x8, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x112debb88: ldr      x8, [x8, #0xa30] ; ___stack_chk_guard
0x112debb8c: ldr      x8, [x8]
0x112debb90: stur     x8, [x29, #-0x60]
0x112debb94: mov      w25, w1
0x112debb98: add      x0, x0, #0x60
0x112debb9c: bl       #0x1131f49ec
0x112debba0: mov      x20, x0
0x112debba4: adrp     x0, #0x11a854000 ; ''
0x112debba8: add      x0, x0, #0x92 ; 'mm_core.cc'
0x112debbac: add      x8, sp, #8
0x112debbb0: bl       #0x1132144b0
0x112debbb4: adrp     x1, #0x11af7f000 ; ' to open file(%s)'
0x112debbb8: add      x1, x1, #0x790 ; ':'
0x112debbbc: add      x0, sp, #8
0x112debbc0: bl       #0x116e57f54 ; __ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKc
0x112debbc4: ldr      x8, [x0, #0x10]
0x112debbc8: ldr      q0, [x0]
0x112debbcc: str      q0, [sp, #0x20]
0x112debbd0: str      x8, [sp, #0x30]
0x112debbd4: stp      xzr, xzr, [x0, #8]
0x112debbd8: str      xzr, [x0]
0x112debbdc: adrp     x1, #0x11a853000 ; 'f2RespTime:'
0x112debbe0: add      x1, x1, #0xa12 ; 'OnForeground'
0x112debbe4: add      x0, sp, #0x20
0x112debbe8: bl       #0x116e57f54 ; __ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKc
0x112debbec: ldp      x19, x22, [x0]
0x112debbf0: ldr      x24, [x0, #0x10]
0x112debbf4: stp      xzr, xzr, [x0, #8]
0x112debbf8: str      xzr, [x0]
0x112debbfc: add      x26, sp, #0x38
0x112debc00: str      xzr, [sp, #0x38]
0x112debc04: mov      w0, #0x38
0x112debc08: bl       #0x116e58b3c ; __Znwm
0x112debc0c: mov      x23, x0
0x112debc10: mov      x27, x0
0x112debc14: str      xzr, [x27, #8]!
0x112debc18: str      xzr, [x0, #0x10]
0x112debc1c: mov      x28, x0
0x112debc20: str      xzr, [x28, #0x18]!
0x112debc24: adrp     x8, #0x11c3b5000
0x112debc28: add      x8, x8, #0x750
0x112debc2c: add      x8, x8, #0x10
0x112debc30: str      x8, [x0]
0x112debc34: mov      w0, #0x18
0x112debc38: bl       #0x116e58b3c ; __Znwm
0x112debc3c: adrp     x8, #0x11c3b5000
0x112debc40: add      x8, x8, #0x7a0
0x112debc44: add      x8, x8, #0x10
0x112debc48: stp      x8, x28, [x0]
0x112debc4c: str      x23, [x0, #0x10]
0x112debc50: ldxr     x8, [x27]
0x112debc54: add      x8, x8, #1
0x112debc58: stxr     w9, x8, [x27]
0x112debc5c: cbnz     w9, #0x112debc50
0x112debc60: str      x0, [sp, #0x40]
0x112debc64: ldaxr    x8, [x27]
0x112debc68: sub      x9, x8, #1
0x112debc6c: stlxr    w10, x9, [x27]
0x112debc70: cbnz     w10, #0x112debc64
0x112debc74: cbnz     x8, #0x112debc90
0x112debc78: ldr      x8, [x23]
0x112debc7c: ldr      x8, [x8, #0x10]
0x112debc80: mov      x0, x23
0x112debc84: blr      x8
0x112debc88: mov      x0, x23
0x112debc8c: bl       #0x116e58554 ; __ZNSt3__119__shared_weak_count14__release_weakEv
0x112debc90: mov      w8, #0x27c0
0x112debc94: movk     w8, #9, lsl #16
0x112debc98: stp      xzr, x8, [sp, #0x48]
0x112debc9c: add      x23, sp, #0x38
0x112debca0: tbnz     x24, #0x3f, #0x112debcb0
0x112debca4: stp      x19, x22, [sp, #0x58]
0x112debca8: str      x24, [sp, #0x68]
0x112debcac: b        #0x112debcc0
0x112debcb0: add      x0, x23, #0x20
0x112debcb4: mov      x1, x19
0x112debcb8: mov      x2, x22
0x112debcbc: bl       #0x10f827e5c
0x112debcc0: bl       #0x113217144
0x112debcc4: stp      x0, xzr, [sp, #0x70]
0x112debcc8: ldrb     w8, [sp, #0x6f]
0x112debccc: sxtb     w9, w8
0x112debcd0: ldr      x10, [sp, #0x60]
0x112debcd4: cmp      w9, #0
0x112debcd8: csel     x8, x10, x8, lt
0x112debcdc: cmp      x8, #0
0x112debce0: adrp     x8, #0x11795b000
0x112debce4: add      x8, x8, #0x3b0
0x112debce8: mov      x9, #-0x8000000000000000
0x112debcec: add      x8, x8, x9
0x112debcf0: and      x1, x8, #0x7fffffffffffffff
0x112debcf4: ccmp     x1, #0, #4, eq
0x112debcf8: b.eq     #0x112debd04
0x112debcfc: add      x0, x23, #0x20
0x112debd00: bl       #0x116e57f84 ; __ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKc
0x112debd04: adrp     x8, #0x11cc8a000
0x112debd08: add      x8, x8, #0x298
0x112debd0c: stp      x8, x21, [x29, #-0x80]
0x112debd10: sub      x22, x29, #0x80
0x112debd14: stp      x25, x22, [x29, #-0x70]
0x112debd18: stur     wzr, [x29, #-0x6f]
0x112debd1c: stur     wzr, [x29, #-0x6c]
0x112debd20: add      x8, sp, #0x80
0x112debd24: add      x0, x26, #8
0x112debd28: bl       #0x10b64ff48
0x112debd2c: ldr      x0, [sp, #0x80]
0x112debd30: sub      x1, x29, #0x80
0x112debd34: bl       #0x10b64ffbc
0x112debd38: ldr      x21, [sp, #0x88]
0x112debd3c: cbz      x21, #0x112debd70
0x112debd40: add      x8, x21, #8
0x112debd44: ldaxr    x9, [x8]
0x112debd48: sub      x10, x9, #1
0x112debd4c: stlxr    w11, x10, [x8]
0x112debd50: cbnz     w11, #0x112debd44
0x112debd54: cbnz     x9, #0x112debd70
0x112debd58: ldr      x8, [x21]
0x112debd5c: ldr      x8, [x8, #0x10]
0x112debd60: mov      x0, x21
0x112debd64: blr      x8
0x112debd68: mov      x0, x21
0x112debd6c: bl       #0x116e58554 ; __ZNSt3__119__shared_weak_count14__release_weakEv
0x112debd70: ldur     x0, [x29, #-0x68]
0x112debd74: cmp      x0, x22
0x112debd78: b.eq     #0x112debd88
0x112debd7c: cbz      x0, #0x112debd98
0x112debd80: mov      w8, #0x28
0x112debd84: b        #0x112debd8c
0x112debd88: mov      w8, #0x20
0x112debd8c: ldr      x9, [x0]
0x112debd90: ldr      x8, [x9, x8]
0x112debd94: blr      x8
0x112debd98: adrp     x2, #0x11fb01000
0x112debd9c: add      x2, x2, #0x3c0
0x112debda0: sub      x8, x29, #0x80
0x112debda4: add      x1, sp, #0x38
0x112debda8: mov      x0, x20
0x112debdac: bl       #0x1131f1c50
0x112debdb0: ldrsb    w8, [sp, #0x6f]
0x112debdb4: tbz      w8, #0x1f, #0x112debdc8
0x112debdb8: ldr      x0, [sp, #0x58]
0x112debdbc: ldr      x8, [sp, #0x68]
0x112debdc0: and      x1, x8, #0x7fffffffffffffff
0x112debdc4: bl       #0x116e58b00 ; __ZdlPvm
0x112debdc8: ldr      x0, [sp, #0x48]
0x112debdcc: cbz      x0, #0x112debddc
0x112debdd0: ldr      x8, [x0]
0x112debdd4: ldr      x8, [x8, #8]
0x112debdd8: blr      x8
0x112debddc: ldr      x0, [sp, #0x40]
0x112debde0: cbz      x0, #0x112debdf0
0x112debde4: ldr      x8, [x0]
0x112debde8: ldr      x8, [x8, #8]
0x112debdec: blr      x8
0x112debdf0: tbz      x24, #0x3f, #0x112debe00
0x112debdf4: and      x1, x24, #0x7fffffffffffffff
0x112debdf8: mov      x0, x19
0x112debdfc: bl       #0x116e58b00 ; __ZdlPvm
0x112debe00: ldrsb    w8, [sp, #0x37]
0x112debe04: tbz      w8, #0x1f, #0x112debe18
0x112debe08: ldr      x0, [sp, #0x20]
0x112debe0c: ldr      x8, [sp, #0x30]
0x112debe10: and      x1, x8, #0x7fffffffffffffff
0x112debe14: bl       #0x116e58b00 ; __ZdlPvm
0x112debe18: ldrsb    w8, [sp, #0x1f]
0x112debe1c: tbz      w8, #0x1f, #0x112debe30
0x112debe20: ldr      x0, [sp, #8]
0x112debe24: ldr      x8, [sp, #0x18]
0x112debe28: and      x1, x8, #0x7fffffffffffffff
0x112debe2c: bl       #0x116e58b00 ; __ZdlPvm
0x112debe30: ldur     x8, [x29, #-0x60]
0x112debe34: adrp     x9, #0x11d74c000 ; _$s8StoreKit12BackingValueOyACSScig
0x112debe38: ldr      x9, [x9, #0xa30] ; ___stack_chk_guard
0x112debe3c: ldr      x9, [x9]
0x112debe40: cmp      x9, x8
0x112debe44: b.ne     #0x112debe68
0x112debe48: ldp      x29, x30, [sp, #0x110]
0x112debe4c: ldp      x20, x19, [sp, #0x100]
0x112debe50: ldp      x22, x21, [sp, #0xf0]
0x112debe54: ldp      x24, x23, [sp, #0xe0]
0x112debe58: ldp      x26, x25, [sp, #0xd0]
0x112debe5c: ldp      x28, x27, [sp, #0xc0]
0x112debe60: add      sp, sp, #0x120
0x112debe64: ret      
0x112debe68: bl       #0x116e58cf8 ; ___stack_chk_fail
