#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdint.h>

/// convert a string into uppercase
static void struppercase(char* str)
{
    while (*str) {
        *str = toupper((unsigned char)*str);
        str++;
    }
}

/// offset into a string for a give character
static size_t strindex(const char* str, int ch)
{
    const char* sp = strchr(str, ch);
    if (sp == NULL) {
        return strlen(str);
    } else {
        return sp - str;
    }
}

static const char* SCRAMBLE_STR = "AMEGXY3JW9PVSN45DTK62QUCIRH1FZ08BO7L";

/// convert a base-36 string into a value
static uint64_t str_to_value(const char* str)
{
    uint64_t val = 0;
    for (size_t i = strlen(str) - 1; i > 0; i--) {
        val = (val * 36) + strindex(SCRAMBLE_STR, str[i]);
    }
    return val;
}

/// convert a value into a base-36 string
static void value_to_str(uint64_t val, char* str)
{
    size_t i = 0;
    do {
        if (val == 0)
            break;
        str[++i] = SCRAMBLE_STR[val % 36];
        val /= 36;
    } while (i < 14);
    str[i + 1] = 0;

    while (strlen(str) < 10) {
        str[strlen(str)] = 'A';
        str[strlen(str) + 1] = 0;
    }
}

/// decryption
static uint64_t shift_left_xor(uint64_t value)
{
    value ^= value << 1;
    return value;
}

/// encryption, which is the inverse of the decryption – but more complicated
static uint64_t invert_xor_shift_left(uint64_t value)
{
    uint64_t result = 0;
    for (int i = 63; i >= 0; --i) {
        uint64_t bit = (value >> i) & 1;
        if (i < 63) {
            bit ^= (result >> (i + 1)) & 1;
        }
        result |= (bit << i);
    }
    return result >> 1;
}

static void encrypt_decrypt(char* optionsInputStr, char* output, int encryptFlag)
{
    struppercase(optionsInputStr);
    size_t slen = strlen(optionsInputStr);
    if (13 < slen)
        slen = 13;
    strncpy(output, optionsInputStr, slen);
    output[slen + 1] = 0;

    uint64_t value = str_to_value(optionsInputStr);
    printf("%llx\n", value);
    if (encryptFlag)
        value = invert_xor_shift_left(value);
    else
        value = shift_left_xor(value);
    value &= 0xfffffffffffff;
    value_to_str(value, output);
}

static char calc_option_char(uint8_t optionMask)
{
    if (optionMask & 1) puts("Fault/SRL option");
    if (optionMask & 2) puts("IBASIC option");
    if (optionMask & 4) puts("LAN option");
    if (optionMask & 8) puts("Convert to a 8730A");
    if (optionMask == 0) puts("Clear all options");
    // technically A-Z and 0-9 are legal, which allows 36 values, but only the lower 15 are generating a valid input
    // That said: '9' is special, it clear all options and the serial number (sets it to '?????????')
    return (15 - optionMask) + 'A';
}

int main(int argc, const char* argv[])
{
    printf("Serialnumber suffix: %c\n", calc_option_char(1 | 2 | 4));
    char optionsInputStr[] = "US37400653"
                             "I";
    char output[32];
    puts(optionsInputStr);

    encrypt_decrypt(optionsInputStr, output, 1);
    puts(output);

    char ss[16];
    encrypt_decrypt(output, ss, 0);
    puts(ss);
    return 0;
}
