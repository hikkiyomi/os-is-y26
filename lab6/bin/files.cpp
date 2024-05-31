#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char** argv) {
	std::ifstream input(argv[1]);
	std::ofstream output(argv[1], std::ios::app);
	std::string in;

	while (input >> in) {
		int x = stoi(in);

		if (x != 1) {
			break;
		}

		output << x * 2 << "\n";
	}

	return 0;
}

