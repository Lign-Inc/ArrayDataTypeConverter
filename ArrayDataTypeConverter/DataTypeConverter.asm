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
		mov		r14,	rdx
		mov		r9,		rcx
		mov		r13,	0
		convert:
			movsx		r10d,	WORD PTR [r9 + r13 * 2]
			cvtsi2ss	xmm0,	r10d
			movss		DWORD PTR [r14 + r13 * 4], xmm0
			inc			r13
			cmp			r13,	r8
			jne			convert
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