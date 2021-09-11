#pragma once

extern "C" void Convert16s32f(short* origion, float* target, int dataLen);
extern "C" void Convert32s32f(int* origion, float* target, int dataLen);
extern "C" void Convert32f16s(float* target, short* origion, int dataLen);
extern "C" void Convert32f32s(float* target, int* origion, int dataLen);