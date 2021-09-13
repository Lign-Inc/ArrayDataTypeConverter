#include <iostream>
#include "DataTypeConverter.h"
#pragma comment(lib, "ArrayDataTypeConverter.lib")
#include <time.h>
#include <immintrin.h>

#define INTEST
//#define DEBUGING

int main()
{
#ifndef  DEBUGING
	const int dataLen = 65'397;
#else
	const int dataLen = 10;

	auto v = Convert32f16s(dataLen);
#endif
	const int testTime = 100'000;
	const int displayLen = 1000;

	short* dataI = new short[dataLen];
	//short* dataII = new short[dataLen];
	short* dataII = new short[dataLen];

	std::cout << "Data preparing ...\n";

	for (size_t i = 0; i < dataLen; i++)
	{
		dataI[i] = i % INT16_MAX;
		dataII[i] = i % INT16_MAX;
	}

	float* targetI = new float[dataLen];
	float* targetII = new float[dataLen];

	clock_t t1 = clock();
	//std::cout << "I Running ...\n";

#ifndef  DEBUGING
	for (size_t j = 0; j < testTime; j++)
	{
		for (size_t i = 0; i < dataLen; i++)
		{
			targetI[i] = dataI[i];
		}
	}
#endif
	//std::cout << "I Completed!\nII Running ...\n";
	clock_t t2 = clock();
	for (size_t j = 0; j < testTime; j++)
	{
#ifdef INTEST
		auto v = Convert16s32f(dataII, targetII, dataLen);
		int i = 0;
#else
		// 128 Bit divid 16 Bit = 8.
		// Load data from memory to register.
		for (size_t i = 0; i < dataLen / 8; i++)
		{
			__m256i v32 = _mm256_cvtepi16_epi32((__m128i)_mm_stream_load_si128((__m128i*)(dataII + i * 8)));
			*((__m256*)(targetII + 8 * i)) = _mm256_cvtepi32_ps(v32);
		}
#endif
	}
	clock_t t3 = clock();
	std::cout << "Target I : \n";
	for (size_t i = 0; i < displayLen; i++)
	{
		std::cout << (targetI + dataLen - displayLen)[i] << "  ";
	}
	std::cout << "\nCost: " << t2 - t1 << "ms" << "\nTarget II : \n";
	for (size_t i = 0; i < displayLen; i++)
	{
		std::cout << (targetII + dataLen - displayLen)[i] << "  ";
	}
	std::cout << "\nCost: " << t3 - t2 << "ms" << "\n\n\n\n\nHello World!\n";
}