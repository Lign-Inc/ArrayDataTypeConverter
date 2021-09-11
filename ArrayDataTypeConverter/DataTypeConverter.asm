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
		SHR		r8,		3h
		convert:
			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2
			lea			rcx,		[rcx + 10h]
			lea			rdx,		[rdx + 20h]

			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2
			lea			rcx,		[rcx + 10h]
			lea			rdx,		[rdx + 20h]

			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2
			lea			rcx,		[rcx + 10h]
			lea			rdx,		[rdx + 20h]

			vmovntdqa	xmm0,	xmmword ptr[rcx]
			vpmovsxwd	ymm1,	xmm0
			vcvtdq2ps	ymm2,	ymm1
			vmovups		ymmword ptr [rdx], ymm2
			lea			rcx,		[rcx + 10h]
			lea			rdx,		[rdx + 20h]
		sub		r8,		4
		jnz		convert
		ret
	Convert16s32f	endp

	; Convert32f16s(float* target, short* origion, int dataLen)
	Convert32f16s	proc
		mov		r14,	rdx
		mov		r9,		rcx
		mov		r13,	0
		convert:
			cvtss2si	eax,	DWORD PTR [r9 + r13 * 4]
			mov			WORD PTR [r14 + r13 * 2], ax
			inc			r13
			cmp			r13,	r8
			jne			convert
		ret	
	Convert32f16s	endp

end