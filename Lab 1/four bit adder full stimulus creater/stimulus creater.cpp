/**
 * @file stimulus creator.cpp
 * @author Dylan Shah (code@dylan-shah.com)
 * @brief Creates stimulus signals for testing digital designs for lab 1.
 * Creates all the signals possible when adding two 4-bit numbers.
 * @version 0.1
 * @date 2026-01-26
 *
 * @copyright Copyright Ⓒ 2026
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>

struct input_signals {
    uint8_t A : 4;    // 4-bit input A
    uint8_t B : 4;    // 4-bit input B
    uint8_t CIN : 1;  // 1-bit carry input
};

struct output_signals {
    uint8_t SUM : 4;       // 4-bit sum output
    uint8_t COUT : 1;      // 1-bit carry output
    uint8_t OVERFLOW : 1;  // 1-bit overflow output
};

void print_signals(std::ostream& os, const input_signals& inputs,
                   const output_signals& outputs) {
    os << std::hex << std::setw(1) << std::setfill('0')
       << (outputs.OVERFLOW * 2 + outputs.COUT) << static_cast<int>(outputs.SUM)
       << static_cast<int>(inputs.CIN) << static_cast<int>(inputs.B)
       << static_cast<int>(inputs.A) << '\n';
}

output_signals calculate_expected_output(const input_signals& inputs) {
    output_signals outputs;
    uint8_t full_sum = inputs.A + inputs.B + inputs.CIN;

    outputs.SUM = full_sum & 0x0F;          // Lower 4 bits for SUM
    outputs.COUT = (full_sum & 0x10) >> 4;  // 5th bit for COUT
    // Overflow detection
    uint8_t a_sgn = (inputs.A >> 3) & 1;
    uint8_t b_sgn = (inputs.B >> 3) & 1;
    uint8_t sum_sgn = (outputs.SUM >> 3) & 1;
    outputs.OVERFLOW = (a_sgn == b_sgn) && (sum_sgn != a_sgn);

    return outputs;
}

int main() {
    std::ofstream outfile("stimulus_output.txt");
    for (uint8_t cin = 0; cin < 2; ++cin)
        for (uint8_t a = 0; a < 16; ++a)
            for (uint8_t b = 0; b < 16; ++b) {
                input_signals inputs{a, b, cin};
                output_signals outputs = calculate_expected_output(inputs);
                print_signals(outfile, inputs, outputs);
            }
    return 0;
}