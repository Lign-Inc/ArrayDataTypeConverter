#pragma once

extern "C" long long Convert16s32f(short* origion, float* target, int dataLen);
extern "C" long long Convert32s32f(int* origion, float* target, int dataLen);
extern "C" long long  Convert32f16s(int v1);
extern "C" void Convert32f32s(float* target, int* origion, int dataLen);