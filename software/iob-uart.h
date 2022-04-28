/**
 * @file iob-uart.h
 *
 * @brief IOb-Uart software drivers.
 *
 * Public driver functions for the IOb-Uart peripheral.
 */
#include <stdlib.h>
#include <stdarg.h>
#include <stdint.h>

#include "iob_uart_swreg.h"

/**
 * @def UART_PROGNAME
 *
 * Prefix to IOb-Uart specific prints.
 */
#define UART_PROGNAME "IOb-UART"

/** 
 * @defgroup UART Commands
 *
 * @brief Encoding for the UART commands.
 *
 * These command codes are used to signal commands to console program.
 */
#define STX 2 /// start text
#define ETX 3 /// end text
#define EOT 4 /// end of transission
#define ENQ 5 /// enquiry
#define ACK 6 /// acklowledge
#define FTX 7 /// transmit file
#define FRX 8 /// receive file

/** @brief Initialize UART.
 *
 * Reset UART, set IOb-Uart base address and set the division factor.
 * The division factor is the number of clock cycles per simbol transfered.
 * For example, for a case with fclk = 100 Mhz for a baudrate of 115200 we
 * should have `div=(100*10^6/115200) = (868).
 *
 * @param base_address IOb-Uart instance base address in the system.
 * @param div Equal to round (fclk/baudrate). 
 * @return void.
 */ 
void uart_init(int base_address, uint16_t div);

//Close transmission
void uart_finish();

//TX FUNCTIONS

//Enable / disable tx
void uart_txen(uint8_t val);

//Wait for tx to be ready
void uart_txwait();

//Print char
void uart_putc(char c);

//Print string
void uart_puts(const char *s);

//Send file
void uart_sendfile(char* file_name, int file_size, char *mem);

//RX FUNCTIONS

//Wait for rx to be ready
void uart_rxwait();

//Get char
char uart_getc();

//Receive file 
int uart_recvfile(char* file_name, char **mem);
