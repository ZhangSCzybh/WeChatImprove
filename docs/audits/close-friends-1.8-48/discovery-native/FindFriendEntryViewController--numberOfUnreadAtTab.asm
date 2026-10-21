
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b4ea38: d101c3ff    	sub	sp, sp, #0x70
101b4ea3c: a9016ffc    	stp	x28, x27, [sp, #0x10]
101b4ea40: a90267fa    	stp	x26, x25, [sp, #0x20]
101b4ea44: a9035ff8    	stp	x24, x23, [sp, #0x30]
101b4ea48: a90457f6    	stp	x22, x21, [sp, #0x40]
101b4ea4c: a9054ff4    	stp	x20, x19, [sp, #0x50]
101b4ea50: a9067bfd    	stp	x29, x30, [sp, #0x60]
101b4ea54: 910183fd    	add	x29, sp, #0x60
101b4ea58: b00f8728    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101b4ea5c: 52800029    	mov	w9, #0x1                ; =1
101b4ea60: 39199509    	strb	w9, [x8, #0x665]
101b4ea64: 900f1968    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
101b4ea68: f9412101    	ldr	x1, [x8, #0x240] ; numberOfUnreadAtMomentCell
101b4ea6c: f90007e0    	str	x0, [sp, #0x8]
101b4ea70: 958361b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ea74: aa0003f3    	mov	x19, x0
101b4ea78: b00f3134    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ea7c: f945ea80    	ldr	x0, [x20, #0xbd0]
101b4ea80: d00f2d88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101b4ea84: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
101b4ea88: aa1503e1    	mov	x1, x21
101b4ea8c: 958361ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ea90: aa1d03fd    	mov	x29, x29
101b4ea94: 958361ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ea98: aa0003f8    	mov	x24, x0
101b4ea9c: b00f313c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
101b4eaa0: f946e380    	ldr	x0, [x28, #0xdc0]
101b4eaa4: b00f2d88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101b4eaa8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
101b4eaac: aa1603e1    	mov	x1, x22
101b4eab0: 958361a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eab4: aa0003e2    	mov	x2, x0
101b4eab8: f00f1748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101b4eabc: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
101b4eac0: aa1803e0    	mov	x0, x24
101b4eac4: aa1703e1    	mov	x1, x23
101b4eac8: 9583619d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eacc: aa1d03fd    	mov	x29, x29
101b4ead0: 9583619e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ead4: aa0003fa    	mov	x26, x0
101b4ead8: f00f1768    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101b4eadc: f944b501    	ldr	x1, [x8, #0x968] ; mmkvKeyModel
101b4eae0: 95836197    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eae4: aa1d03fd    	mov	x29, x29
101b4eae8: 95836198    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4eaec: aa0003fb    	mov	x27, x0
101b4eaf0: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4eaf4: f9433d01    	ldr	x1, [x8, #0x678] ; findDiscoveryTabHadClear
101b4eaf8: 95836191    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eafc: aa0003f9    	mov	x25, x0
101b4eb00: aa1b03e0    	mov	x0, x27
101b4eb04: 95836194    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb08: aa1a03e0    	mov	x0, x26
101b4eb0c: 95836192    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb10: aa1803e0    	mov	x0, x24
101b4eb14: 95836190    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb18: f945ea80    	ldr	x0, [x20, #0xbd0]
101b4eb1c: aa1503e1    	mov	x1, x21
101b4eb20: 95836187    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eb24: aa1d03fd    	mov	x29, x29
101b4eb28: 95836188    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4eb2c: aa0003fa    	mov	x26, x0
101b4eb30: f946e380    	ldr	x0, [x28, #0xdc0]
101b4eb34: aa1603e1    	mov	x1, x22
101b4eb38: 95836181    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eb3c: aa0003e2    	mov	x2, x0
101b4eb40: aa1a03e0    	mov	x0, x26
101b4eb44: aa1703e1    	mov	x1, x23
101b4eb48: 9583617d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eb4c: aa1d03fd    	mov	x29, x29
101b4eb50: 9583617e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4eb54: aa0003fb    	mov	x27, x0
101b4eb58: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4eb5c: f9434118    	ldr	x24, [x8, #0x680] ; dynamicConfigModel
101b4eb60: aa1803e1    	mov	x1, x24
101b4eb64: 95836176    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eb68: aa1d03fd    	mov	x29, x29
101b4eb6c: 95836177    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4eb70: aa0003fc    	mov	x28, x0
101b4eb74: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4eb78: f9434501    	ldr	x1, [x8, #0x688] ; enableShakeUnreadCountToTab
101b4eb7c: 95836170    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eb80: aa0003f4    	mov	x20, x0
101b4eb84: aa1c03e0    	mov	x0, x28
101b4eb88: 95836173    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb8c: aa1b03e0    	mov	x0, x27
101b4eb90: 95836171    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb94: aa1a03e0    	mov	x0, x26
101b4eb98: 9583616f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eb9c: 5200033c    	eor	w28, w25, #0x1
101b4eba0: 37000054    	tbnz	w20, #0x0, 0x101b4eba8 <__text+0x1b46ba8>
101b4eba4: 3400085c    	cbz	w28, 0x101b4ecac <__text+0x1b46cac>
101b4eba8: b00f1b48    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
101b4ebac: f9433101    	ldr	x1, [x8, #0x660] ; shouldShowShakeEntry
101b4ebb0: f94007e0    	ldr	x0, [sp, #0x8]
101b4ebb4: 95836162    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ebb8: 340007a0    	cbz	w0, 0x101b4ecac <__text+0x1b46cac>
101b4ebbc: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ebc0: f945e900    	ldr	x0, [x8, #0xbd0]
101b4ebc4: aa1503e1    	mov	x1, x21
101b4ebc8: 9583615d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ebcc: aa1d03fd    	mov	x29, x29
101b4ebd0: 9583615e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ebd4: aa0003f4    	mov	x20, x0
101b4ebd8: d00f3128    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101b4ebdc: f9416900    	ldr	x0, [x8, #0x2d0]
101b4ebe0: aa1603e1    	mov	x1, x22
101b4ebe4: 95836156    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ebe8: aa0003e2    	mov	x2, x0
101b4ebec: aa1403e0    	mov	x0, x20
101b4ebf0: aa1703e1    	mov	x1, x23
101b4ebf4: 95836152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ebf8: aa1d03fd    	mov	x29, x29
101b4ebfc: 95836153    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ec00: aa0003f9    	mov	x25, x0
101b4ec04: 900f1948    	adrp	x8, 0x11fe76000 <dyld_stub_binder+0x11fe76000>
101b4ec08: f942e101    	ldr	x1, [x8, #0x5c0] ; getUnreadCountForChat:
101b4ec0c: 900e5382    	adrp	x2, 0x11e5be000 <dyld_stub_binder+0x11e5be000>
101b4ec10: 913ea042    	add	x2, x2, #0xfa8
101b4ec14: 9583614a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec18: 8b204273    	add	x19, x19, w0, uxtw
101b4ec1c: aa1903e0    	mov	x0, x25
101b4ec20: 9583614d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ec24: aa1403e0    	mov	x0, x20
101b4ec28: 9583614b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ec2c: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ec30: f9464900    	ldr	x0, [x8, #0xc90]
101b4ec34: f00f1948    	adrp	x8, 0x11fe79000 <dyld_stub_binder+0x11fe79000>
101b4ec38: f9444d01    	ldr	x1, [x8, #0x898] ; isChinaPhoneAndSimpleCHSUser
101b4ec3c: 95836140    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec40: 34000360    	cbz	w0, 0x101b4ecac <__text+0x1b46cac>
101b4ec44: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ec48: f945e900    	ldr	x0, [x8, #0xbd0]
101b4ec4c: aa1503e1    	mov	x1, x21
101b4ec50: 9583613b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec54: aa1d03fd    	mov	x29, x29
101b4ec58: 9583613c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ec5c: aa0003f4    	mov	x20, x0
101b4ec60: d00f3128    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101b4ec64: f9463500    	ldr	x0, [x8, #0xc68]
101b4ec68: aa1603e1    	mov	x1, x22
101b4ec6c: 95836134    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec70: aa0003e2    	mov	x2, x0
101b4ec74: aa1403e0    	mov	x0, x20
101b4ec78: aa1703e1    	mov	x1, x23
101b4ec7c: 95836130    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec80: aa1d03fd    	mov	x29, x29
101b4ec84: 95836131    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ec88: aa0003f9    	mov	x25, x0
101b4ec8c: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4ec90: f9434901    	ldr	x1, [x8, #0x690] ; getUnreadMessageCount
101b4ec94: 9583612a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ec98: 8b130013    	add	x19, x0, x19
101b4ec9c: aa1903e0    	mov	x0, x25
101b4eca0: 9583612d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4eca4: aa1403e0    	mov	x0, x20
101b4eca8: 9583612b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ecac: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ecb0: f945e900    	ldr	x0, [x8, #0xbd0]
101b4ecb4: aa1503e1    	mov	x1, x21
101b4ecb8: 95836121    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ecbc: aa1d03fd    	mov	x29, x29
101b4ecc0: 95836122    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ecc4: aa0003f4    	mov	x20, x0
101b4ecc8: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4eccc: f946e100    	ldr	x0, [x8, #0xdc0]
101b4ecd0: aa1603e1    	mov	x1, x22
101b4ecd4: 9583611a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ecd8: aa0003e2    	mov	x2, x0
101b4ecdc: aa1403e0    	mov	x0, x20
101b4ece0: aa1703e1    	mov	x1, x23
101b4ece4: 95836116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ece8: aa1d03fd    	mov	x29, x29
101b4ecec: 95836117    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ecf0: aa0003f9    	mov	x25, x0
101b4ecf4: aa1803e1    	mov	x1, x24
101b4ecf8: 95836111    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ecfc: aa1d03fd    	mov	x29, x29
101b4ed00: 95836112    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ed04: aa0003fa    	mov	x26, x0
101b4ed08: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4ed0c: f9434d01    	ldr	x1, [x8, #0x698] ; enableStoriesUnreadCountToTab
101b4ed10: 9583610b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ed14: aa0003fb    	mov	x27, x0
101b4ed18: aa1a03e0    	mov	x0, x26
101b4ed1c: 9583610e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ed20: aa1903e0    	mov	x0, x25
101b4ed24: 9583610c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ed28: aa1403e0    	mov	x0, x20
101b4ed2c: 9583610a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4ed30: 2a1c0368    	orr	w8, w27, w28
101b4ed34: 7100051f    	cmp	w8, #0x1
101b4ed38: 540000c1    	b.ne	0x101b4ed50 <__text+0x1b46d50>
101b4ed3c: 900f1968    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
101b4ed40: f9412901    	ldr	x1, [x8, #0x250] ; numberOfUnreadAtTopStoriesCell
101b4ed44: f94007e0    	ldr	x0, [sp, #0x8]
101b4ed48: 958360fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ed4c: 8b130013    	add	x19, x0, x19
101b4ed50: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ed54: f945e900    	ldr	x0, [x8, #0xbd0]
101b4ed58: aa1503e1    	mov	x1, x21
101b4ed5c: 958360f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ed60: aa1d03fd    	mov	x29, x29
101b4ed64: 958360f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ed68: aa0003f4    	mov	x20, x0
101b4ed6c: b00f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4ed70: f946e100    	ldr	x0, [x8, #0xdc0]
101b4ed74: aa1603e1    	mov	x1, x22
101b4ed78: 958360f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ed7c: aa0003e2    	mov	x2, x0
101b4ed80: aa1403e0    	mov	x0, x20
101b4ed84: aa1703e1    	mov	x1, x23
101b4ed88: 958360ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4ed8c: aa1d03fd    	mov	x29, x29
101b4ed90: 958360ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4ed94: aa0003f5    	mov	x21, x0
101b4ed98: aa1803e1    	mov	x1, x24
101b4ed9c: 958360e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4eda0: aa1d03fd    	mov	x29, x29
101b4eda4: 958360e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101b4eda8: aa0003f6    	mov	x22, x0
101b4edac: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4edb0: f9435101    	ldr	x1, [x8, #0x6a0] ; enableFinderUnreadCountToTab
101b4edb4: 958360e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4edb8: aa0003f7    	mov	x23, x0
101b4edbc: aa1603e0    	mov	x0, x22
101b4edc0: 958360e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4edc4: aa1503e0    	mov	x0, x21
101b4edc8: 958360e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4edcc: aa1403e0    	mov	x0, x20
101b4edd0: 958360e1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4edd4: 2a1c02e8    	orr	w8, w23, w28
101b4edd8: 7100051f    	cmp	w8, #0x1
101b4eddc: 540000e1    	b.ne	0x101b4edf8 <__text+0x1b46df8>
101b4ede0: d00f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b4ede4: f9435501    	ldr	x1, [x8, #0x6a8] ; numberOfFinderCellWithTotalCount:
101b4ede8: f94007e0    	ldr	x0, [sp, #0x8]
101b4edec: aa1303e2    	mov	x2, x19
101b4edf0: 958360d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4edf4: 8b130013    	add	x19, x0, x19
101b4edf8: aa1303e0    	mov	x0, x19
101b4edfc: a9467bfd    	ldp	x29, x30, [sp, #0x60]
101b4ee00: a9454ff4    	ldp	x20, x19, [sp, #0x50]
101b4ee04: a94457f6    	ldp	x22, x21, [sp, #0x40]
101b4ee08: a9435ff8    	ldp	x24, x23, [sp, #0x30]
101b4ee0c: a94267fa    	ldp	x26, x25, [sp, #0x20]
101b4ee10: a9416ffc    	ldp	x28, x27, [sp, #0x10]
101b4ee14: 9101c3ff    	add	sp, sp, #0x70
101b4ee18: d65f03c0    	ret
