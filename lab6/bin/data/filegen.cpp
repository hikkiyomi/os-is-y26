#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char** argv) {
	int amount = stoi(std::string(argv[1]));
	std::ofstream output(argv[2]);

	while (amount--) {
		output << "1\n";
	}

	return 0;
}

