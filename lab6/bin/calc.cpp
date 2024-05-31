#include <iostream>

int stringToInt(char* arg) {
	int result = 0;

	for (int i = 0; arg[i] != '\0'; ++i) {
		result = result * 10 + arg[i] - '0';
	}

	return result;
}

int calculateNthDigit(int n) {
	static const int NUMERATOR = 9;
	static const int DENOMINATOR = 13;

	int x = NUMERATOR;
	int result = 0;

	for (int i = 0; i < n; ++i) {
		x *= 10;
		result = x / DENOMINATOR;
		x %= DENOMINATOR;
	}

	return result;
}

int main(int argc, char** argv) {
	int n = stringToInt(argv[1]);
	
	std::cout << calculateNthDigit(n) << "\n";

	return 0;
}

