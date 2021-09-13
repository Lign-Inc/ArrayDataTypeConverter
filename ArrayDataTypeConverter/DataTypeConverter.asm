; *********************************************************************************
;	DataType Array Converter.
; *********************************************************************************
;	by Lign, 9th Sep 2021
;	https://github.com/FreakLign
; *********************************************************************************
;	Description:
;		Coding with masm.
;	API:
;		extern "C" void Convert16s32f(short* origion, float* target, int dataLen);
;		extern "C" void Convert32s32f(int* origion, float* target, int dataLen);
;		extern "C" void Convert32f16s(float* target, short* origion, int dataLen);
;		extern "C" void Convert32f32s(float* target, int* origion, int dataLen);
; *********************************************************************************

.Code
	; Convert16s32f(short* origion, float* target, int dataLen)
	Convert16s32f	proc
		xor		rax,	rax
		
		mov		r9,		r8
		and		r9,		7Fh
		jz		__startDirect

		__preConvert:
			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2

			lea			rcx,		[rcx + 10h]
			lea			rdx,		[rdx + 20h]
			sub			r9,			08h
			jg			__preConvert
		mov		r9,		r8
		and		r9,		7Fh
		cmp		r9,		r8
		je		__ret

		__startDirect:
			shr		r8,		7h

		convert:
			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2

			vmovntdqa	xmm0,	xmmword ptr[rcx + 10h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 20h], ymm2

			vmovntdqa	xmm0,	xmmword ptr[rcx + 20h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 40h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 30h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 60h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 40h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 80h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 50h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 00A0h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 60h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 00C0h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 70h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 00E0h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 80h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 100h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 90h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 120h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00A0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 140h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00B0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 160h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00C0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 180h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00D0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 1A0h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00e0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 1c0h], ymm2
			
			vmovntdqa	xmm0,	xmmword ptr[rcx + 00f0h]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx + 1e0h], ymm2
			
			lea			rcx,		[rcx + 100h]
			lea			rdx,		[rdx + 200h]

			;lea			rcx,		[rcx + 20h]
			;lea			rdx,		[rdx + 40h]
			inc			rax
			sub			r8,			01h
			jnz			convert
		__ret:
			ret
	Convert16s32f	endp

	; Convert32f16s(float* target, short* origion, int dataLen)
	Convert32f16s	proc
		and		rcx,	0fh
		mov		rax,	rcx
		xor		rcx,	rcx
		xor		r8,		r8
		xor		rdx,	rdx
		ret
	Convert32f16s	endp

end