; *********************************************************************************
;	DataType Array Converter.
; *********************************************************************************
;	by Lign, 9th Sep 2021
;		12th Sep 2021: Updating plan. Add duff device to accelerate speed.
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


		mov		r13,	r8
		and		r13,	07h
		
		DuffHead:
			
			sub		r13,	1
			jnz		DuffHead;

		mov		r13,	r8
		SHR		r13,	3h
		jnz		Return
		convert:

			sub		r13,		8h
			jnz		convert

		Return:
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