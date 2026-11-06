
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157db994: d10243ff    	sub	sp, sp, #0x90
1157db998: a9036ffc    	stp	x28, x27, [sp, #0x30]
1157db99c: a90467fa    	stp	x26, x25, [sp, #0x40]
1157db9a0: a9055ff8    	stp	x24, x23, [sp, #0x50]
1157db9a4: a90657f6    	stp	x22, x21, [sp, #0x60]
1157db9a8: a9074ff4    	stp	x20, x19, [sp, #0x70]
1157db9ac: a9087bfd    	stp	x29, x30, [sp, #0x80]
1157db9b0: 910203fd    	add	x29, sp, #0x80
1157db9b4: aa0203f3    	mov	x19, x2
1157db9b8: aa0003f5    	mov	x21, x0
1157db9bc: aa0203e0    	mov	x0, x2
1157db9c0: 945a0305    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db9c4: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157db9c8: f9443901    	ldr	x1, [x8, #0x870]
1157db9cc: aa1503e0    	mov	x0, x21
1157db9d0: 945a02dd    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db9d4: aa1d03fd    	mov	x29, x29
1157db9d8: 945a0308    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db9dc: aa0003f4    	mov	x20, x0
1157db9e0: b0049168    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
1157db9e4: f9412101    	ldr	x1, [x8, #0x240]
1157db9e8: aa1303e0    	mov	x0, x19
1157db9ec: 945a02d6    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db9f0: aa1d03fd    	mov	x29, x29
1157db9f4: 945a0301    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db9f8: aa0003f6    	mov	x22, x0
1157db9fc: f004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dba00: f9424901    	ldr	x1, [x8, #0x490]
1157dba04: 945a02d0    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba08: aa1603e0    	mov	x0, x22
1157dba0c: 945a02ec    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dba10: b0049168    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
1157dba14: f9412917    	ldr	x23, [x8, #0x250]
1157dba18: aa1303e0    	mov	x0, x19
1157dba1c: aa1703e1    	mov	x1, x23
1157dba20: d2800002    	mov	x2, #0x0                ; =0
1157dba24: 945a02c8    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba28: f004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dba2c: f946f519    	ldr	x25, [x8, #0xde8]
1157dba30: 1e6e1000    	fmov	d0, #1.00000000
1157dba34: aa1403e0    	mov	x0, x20
1157dba38: aa1903e1    	mov	x1, x25
1157dba3c: 945a02c2    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba40: f003fb68    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1157dba44: f942bd08    	ldr	x8, [x8, #0x578]
1157dba48: ad400500    	ldp	q0, q1, [x8]
1157dba4c: ad0007e0    	stp	q0, q1, [sp]
1157dba50: 3dc00900    	ldr	q0, [x8, #0x20]
1157dba54: 3d800be0    	str	q0, [sp, #0x20]
1157dba58: b004a688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1157dba5c: f9460501    	ldr	x1, [x8, #0xc08]
1157dba60: 910003e2    	mov	x2, sp
1157dba64: aa1403e0    	mov	x0, x20
1157dba68: 945a02b7    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba6c: f0048fa8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1157dba70: f942cd01    	ldr	x1, [x8, #0x598]
1157dba74: aa1403e0    	mov	x0, x20
1157dba78: 945a02b3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba7c: aa0003e2    	mov	x2, x0
1157dba80: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dba84: f942a101    	ldr	x1, [x8, #0x540]
1157dba88: aa1303e0    	mov	x0, x19
1157dba8c: 945a02ae    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dba90: 90049528    	adrp	x8, 0x11ea7f000 <dyld_stub_binder+0x11ea7f000>
1157dba94: f9452101    	ldr	x1, [x8, #0xa40]
1157dba98: aa1303e0    	mov	x0, x19
1157dba9c: 945a02aa    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbaa0: aa1d03fd    	mov	x29, x29
1157dbaa4: 945a02d5    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbaa8: aa0003f6    	mov	x22, x0
1157dbaac: d004a668    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1157dbab0: f941b101    	ldr	x1, [x8, #0x360]
1157dbab4: aa1303e0    	mov	x0, x19
1157dbab8: 945a02a3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbabc: aa1d03fd    	mov	x29, x29
1157dbac0: 945a02ce    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbac4: aa0003f8    	mov	x24, x0
1157dbac8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbacc: f942a501    	ldr	x1, [x8, #0x548]
1157dbad0: aa1303e0    	mov	x0, x19
1157dbad4: 945a029c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbad8: 340003e0    	cbz	w0, 0x1157dbb54 <_O266DecReleaseOutputPicture+0x36cc5e8>
1157dbadc: f0049008    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
1157dbae0: f942dd01    	ldr	x1, [x8, #0x5b8]
1157dbae4: aa1403e0    	mov	x0, x20
1157dbae8: 52800002    	mov	w2, #0x0                ; =0
1157dbaec: 945a0296    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbaf0: aa1d03fd    	mov	x29, x29
1157dbaf4: 945a02c1    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbaf8: aa0003f9    	mov	x25, x0
1157dbafc: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbb00: f942a901    	ldr	x1, [x8, #0x550]
1157dbb04: aa1303e0    	mov	x0, x19
1157dbb08: aa1903e2    	mov	x2, x25
1157dbb0c: 945a028e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbb10: aa1903e0    	mov	x0, x25
1157dbb14: 945a02aa    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbb18: d003fb68    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1157dbb1c: f947a108    	ldr	x8, [x8, #0xf40]
1157dbb20: f9400102    	ldr	x2, [x8]
1157dbb24: d0049068    	adrp	x8, 0x11e9e9000 <dyld_stub_binder+0x11e9e9000>
1157dbb28: f946a901    	ldr	x1, [x8, #0xd50]
1157dbb2c: aa1603e0    	mov	x0, x22
1157dbb30: 945a0285    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbb34: aa1d03fd    	mov	x29, x29
1157dbb38: 945a02b0    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbb3c: aa0003f9    	mov	x25, x0
1157dbb40: b40006a0    	cbz	x0, 0x1157dbc14 <_O266DecReleaseOutputPicture+0x36cc6a8>
1157dbb44: aa1903e0    	mov	x0, x25
1157dbb48: 945a02a3    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbb4c: aa1903fa    	mov	x26, x25
1157dbb50: 14000038    	b	0x1157dbc30 <_O266DecReleaseOutputPicture+0x36cc6c4>
1157dbb54: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dbb58: f9443d01    	ldr	x1, [x8, #0x878]
1157dbb5c: aa1503e0    	mov	x0, x21
1157dbb60: 52800002    	mov	w2, #0x0                ; =0
1157dbb64: 52800003    	mov	w3, #0x0                ; =0
1157dbb68: 945a0277    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbb6c: d004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157dbb70: f9472901    	ldr	x1, [x8, #0xe50]
1157dbb74: aa1503e0    	mov	x0, x21
1157dbb78: 945a0273    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbb7c: aa1d03fd    	mov	x29, x29
1157dbb80: 945a029e    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbb84: aa0003fa    	mov	x26, x0
1157dbb88: b004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157dbb8c: f9465d01    	ldr	x1, [x8, #0xcb8]
1157dbb90: 945a026d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbb94: aa1a03e0    	mov	x0, x26
1157dbb98: 945a0289    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbb9c: f0049008    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
1157dbba0: f942dd01    	ldr	x1, [x8, #0x5b8]
1157dbba4: aa1403e0    	mov	x0, x20
1157dbba8: 52800002    	mov	w2, #0x0                ; =0
1157dbbac: 945a0266    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbbb0: aa1d03fd    	mov	x29, x29
1157dbbb4: 945a0291    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbbb8: aa0003fa    	mov	x26, x0
1157dbbbc: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbbc0: f942a901    	ldr	x1, [x8, #0x550]
1157dbbc4: aa1303e0    	mov	x0, x19
1157dbbc8: aa1a03e2    	mov	x2, x26
1157dbbcc: 945a025e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbbd0: aa1a03e0    	mov	x0, x26
1157dbbd4: 945a027a    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbbd8: d003fb68    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1157dbbdc: f947a908    	ldr	x8, [x8, #0xf50]
1157dbbe0: f9400102    	ldr	x2, [x8]
1157dbbe4: d0049068    	adrp	x8, 0x11e9e9000 <dyld_stub_binder+0x11e9e9000>
1157dbbe8: f946a901    	ldr	x1, [x8, #0xd50]
1157dbbec: aa1603e0    	mov	x0, x22
1157dbbf0: 945a0255    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbbf4: aa1d03fd    	mov	x29, x29
1157dbbf8: 945a0280    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbbfc: aa0003fb    	mov	x27, x0
1157dbc00: b4000340    	cbz	x0, 0x1157dbc68 <_O266DecReleaseOutputPicture+0x36cc6fc>
1157dbc04: aa1b03e0    	mov	x0, x27
1157dbc08: 945a0273    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbc0c: aa1b03fa    	mov	x26, x27
1157dbc10: 1400001d    	b	0x1157dbc84 <_O266DecReleaseOutputPicture+0x36cc718>
1157dbc14: d004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157dbc18: f9448901    	ldr	x1, [x8, #0x910]
1157dbc1c: aa1803e0    	mov	x0, x24
1157dbc20: 945a0249    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbc24: aa1d03fd    	mov	x29, x29
1157dbc28: 945a0274    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbc2c: aa0003fa    	mov	x26, x0
1157dbc30: aa1903e0    	mov	x0, x25
1157dbc34: 945a0262    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbc38: d0048fa8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1157dbc3c: f9451501    	ldr	x1, [x8, #0xa28]
1157dbc40: aa1a03e0    	mov	x0, x26
1157dbc44: 945a0240    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbc48: aa1d03fd    	mov	x29, x29
1157dbc4c: 945a026b    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbc50: aa0003f9    	mov	x25, x0
1157dbc54: b4000340    	cbz	x0, 0x1157dbcbc <_O266DecReleaseOutputPicture+0x36cc750>
1157dbc58: aa1903e0    	mov	x0, x25
1157dbc5c: 945a025e    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbc60: aa1903fb    	mov	x27, x25
1157dbc64: 14000020    	b	0x1157dbce4 <_O266DecReleaseOutputPicture+0x36cc778>
1157dbc68: f0049588    	adrp	x8, 0x11ea8e000 <dyld_stub_binder+0x11ea8e000>
1157dbc6c: f943fd01    	ldr	x1, [x8, #0x7f8]
1157dbc70: aa1303e0    	mov	x0, x19
1157dbc74: 945a0234    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbc78: aa1d03fd    	mov	x29, x29
1157dbc7c: 945a025f    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbc80: aa0003fa    	mov	x26, x0
1157dbc84: aa1b03e0    	mov	x0, x27
1157dbc88: 945a024d    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbc8c: d0048fa8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1157dbc90: f9451501    	ldr	x1, [x8, #0xa28]
1157dbc94: aa1a03e0    	mov	x0, x26
1157dbc98: 945a022b    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbc9c: aa1d03fd    	mov	x29, x29
1157dbca0: 945a0256    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbca4: aa0003fc    	mov	x28, x0
1157dbca8: b40004c0    	cbz	x0, 0x1157dbd40 <_O266DecReleaseOutputPicture+0x36cc7d4>
1157dbcac: aa1c03e0    	mov	x0, x28
1157dbcb0: 945a0249    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbcb4: aa1c03fb    	mov	x27, x28
1157dbcb8: 1400002c    	b	0x1157dbd68 <_O266DecReleaseOutputPicture+0x36cc7fc>
1157dbcbc: d003fb68    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1157dbcc0: f947a508    	ldr	x8, [x8, #0xf48]
1157dbcc4: f9400102    	ldr	x2, [x8]
1157dbcc8: 900491c8    	adrp	x8, 0x11ea13000 <dyld_stub_binder+0x11ea13000>
1157dbccc: f9457901    	ldr	x1, [x8, #0xaf0]
1157dbcd0: aa1603e0    	mov	x0, x22
1157dbcd4: 945a021c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbcd8: aa1d03fd    	mov	x29, x29
1157dbcdc: 945a0247    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbce0: aa0003fb    	mov	x27, x0
1157dbce4: aa1903e0    	mov	x0, x25
1157dbce8: 945a0235    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbcec: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbcf0: f942ad01    	ldr	x1, [x8, #0x558]
1157dbcf4: aa1503e0    	mov	x0, x21
1157dbcf8: aa1b03e2    	mov	x2, x27
1157dbcfc: 945a0212    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbd00: aa1d03fd    	mov	x29, x29
1157dbd04: 945a023d    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbd08: aa0003f9    	mov	x25, x0
1157dbd0c: aa1303e0    	mov	x0, x19
1157dbd10: aa1703e1    	mov	x1, x23
1157dbd14: aa1903e2    	mov	x2, x25
1157dbd18: 945a020b    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbd1c: aa1903e0    	mov	x0, x25
1157dbd20: 945a0227    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbd24: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dbd28: f9443d01    	ldr	x1, [x8, #0x878]
1157dbd2c: aa1503e0    	mov	x0, x21
1157dbd30: 52800022    	mov	w2, #0x1                ; =1
1157dbd34: 52800003    	mov	w3, #0x0                ; =0
1157dbd38: 945a0203    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbd3c: 14000024    	b	0x1157dbdcc <_O266DecReleaseOutputPicture+0x36cc860>
1157dbd40: d003fb68    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1157dbd44: f947ad08    	ldr	x8, [x8, #0xf58]
1157dbd48: f9400102    	ldr	x2, [x8]
1157dbd4c: 900491c8    	adrp	x8, 0x11ea13000 <dyld_stub_binder+0x11ea13000>
1157dbd50: f9457901    	ldr	x1, [x8, #0xaf0]
1157dbd54: aa1603e0    	mov	x0, x22
1157dbd58: 945a01fb    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbd5c: aa1d03fd    	mov	x29, x29
1157dbd60: 945a0226    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbd64: aa0003fb    	mov	x27, x0
1157dbd68: aa1c03e0    	mov	x0, x28
1157dbd6c: 945a0214    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbd70: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbd74: f942ad01    	ldr	x1, [x8, #0x558]
1157dbd78: aa1503e0    	mov	x0, x21
1157dbd7c: aa1b03e2    	mov	x2, x27
1157dbd80: 945a01f1    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbd84: aa1d03fd    	mov	x29, x29
1157dbd88: 945a021c    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbd8c: aa0003f5    	mov	x21, x0
1157dbd90: aa1303e0    	mov	x0, x19
1157dbd94: aa1703e1    	mov	x1, x23
1157dbd98: aa1503e2    	mov	x2, x21
1157dbd9c: 945a01ea    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbda0: aa1503e0    	mov	x0, x21
1157dbda4: 945a0206    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbda8: 9e6703e0    	fmov	d0, xzr
1157dbdac: aa1403e0    	mov	x0, x20
1157dbdb0: aa1903e1    	mov	x1, x25
1157dbdb4: 945a01e4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbdb8: b004a688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1157dbdbc: f9469d01    	ldr	x1, [x8, #0xd38]
1157dbdc0: aa1403e0    	mov	x0, x20
1157dbdc4: 52800002    	mov	w2, #0x0                ; =0
1157dbdc8: 945a01df    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbdcc: aa1a03e0    	mov	x0, x26
1157dbdd0: 945a01fb    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbdd4: b00494c8    	adrp	x8, 0x11ea74000 <dyld_stub_binder+0x11ea74000>
1157dbdd8: f9409d01    	ldr	x1, [x8, #0x138]
1157dbddc: aa1303e0    	mov	x0, x19
1157dbde0: 52800022    	mov	w2, #0x1                ; =1
1157dbde4: 945a01d8    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbde8: aa1b03e0    	mov	x0, x27
1157dbdec: 945a01f4    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbdf0: aa1803e0    	mov	x0, x24
1157dbdf4: 945a01f2    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbdf8: aa1603e0    	mov	x0, x22
1157dbdfc: 945a01f0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbe00: aa1403e0    	mov	x0, x20
1157dbe04: 945a01ee    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbe08: aa1303e0    	mov	x0, x19
1157dbe0c: 945a01ec    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbe10: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1157dbe14: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1157dbe18: a94657f6    	ldp	x22, x21, [sp, #0x60]
1157dbe1c: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1157dbe20: a94467fa    	ldp	x26, x25, [sp, #0x40]
1157dbe24: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1157dbe28: 910243ff    	add	sp, sp, #0x90
1157dbe2c: d65f03c0    	ret
