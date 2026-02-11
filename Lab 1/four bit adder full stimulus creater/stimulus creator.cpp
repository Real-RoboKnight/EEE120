/**
 * @author Dylan Shah (code@dylan-shah.com)
 * @brief Creates stimulus signals for testing digital designs for lab 1.
 * Creates all the signals possible when adding two 4-bit numbers.
 * @version 0.1
 * @date 2026-01-26
 * 
 * @copyright Copyright (c) 2026
 *   
 * @parblock License
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
 * @endparblock 
 */

#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <ostream>


/**
 * @class input_signals
 * @brief Stores the values that are going into the adder 
 */
struct input_signals {
    /**
     * @brief One of the two opperands 
     */
    uint8_t A   : 4;
    /**
     * @brief One of the two opperands 
     */
    uint8_t B   : 4;
    /**
     * @brief A boolean that represents weather there is a carry in or not. 
     */
    uint8_t CIN : 1;
};

/**
 * @class output_signals
 * @brief Stores the values that should come out of the adder
 */
struct output_signals {
    /**
     * @brief What the four bit sum will be
     */
    uint8_t SUM : 4;
    /**
     * @brief Wether or not the *un*signed addition will overflow or not.
     */
    uint8_t COUT     : 1;
    /**
     * @brief Wether or not the signed addition will overflow or not.
     */
    uint8_t OVERFLOW : 1;
};

/**
 * @brief Format and output signals in Iverilog-compatible hexadecimal format
 *
 * Writes a single line containing the concatenated signal values in hexadecimal
 * format: `[OVERFLOW|COUT][SUM][CIN][B][A]`
 *
 * @param os      Output stream where formatted signals will be written
 * @param inputs  Input signals (A, B, CIN) to be formatted
 * @param outputs Output signals (SUM, COUT, OVERFLOW) to be formatted
 *
 * **Example Output:**
 * ```
 * 01234  // OVERFLOW=0, COUT=1, SUM=2, CIN=3, B=4, A=4
 * ```
 *
 * @note Output format uses hexadecimal with no padding or delimiters
 * @see input_signals, output_signals
 */
void print_signals(std::ostream&         os,
                   const input_signals&  inputs,
                   const output_signals& outputs) {
    os << std::hex << std::setw(1) << std::setfill('0')
       << (outputs.OVERFLOW * 2 + outputs.COUT) << static_cast<int>(outputs.SUM)
       << static_cast<int>(inputs.CIN) << static_cast<int>(inputs.B)
       << static_cast<int>(inputs.A) << '\n';
}

std::ostream& operator<<(std::ostream& os, input_signals& inputs) {
    os << inputs.A;
    return os;
}

output_signals calculate_expected_output(const input_signals& inputs) {
    output_signals outputs;
    uint8_t        full_sum = inputs.A + inputs.B + inputs.CIN;
    bool           a_sgn    = (inputs.A >> 3) & 1;
    bool           b_sgn    = (inputs.B >> 3) & 1;
    bool           sum_sgn  = (outputs.SUM >> 3) & 1;
    outputs.SUM             = full_sum & 0x0F;
    outputs.COUT            = (full_sum & 0x10) >> 4;
    outputs.OVERFLOW        = (a_sgn == b_sgn) && (sum_sgn != a_sgn);
    return outputs;
}

int main() {
    std::ofstream outfile("stimulus_output.txt");
    for (uint8_t cin = 0; cin < 2; ++cin)
        for (uint8_t a = 0; a < 16; ++a)
            for (uint8_t b = 0; b < 16; ++b) {
                input_signals  inputs{ a, b, cin };
                output_signals outputs = calculate_expected_output(inputs);
                print_signals(outfile, inputs, outputs);
            }
    return 0;
}
