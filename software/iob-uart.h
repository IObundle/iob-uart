#include <stdlib.h>
#include <stdarg.h>
#include <stdint.h>
#include "iob-uart-ascii.h"

#define PROGNAME "IOb-UART"

//Memory Map
#define UART_WRITE_WAIT 0
#define UART_DIV        1
#define UART_DATA       2
#define UART_SOFT_RESET 3
#define UART_READ_VALID 4
#define UART_RXEN       5
#define UART_TXEN       6

//Functions

//Reset UART and set the division factor
void uart_init(int base_address, int div);

//Get the division factor div
int uart_getdiv();

//Wait for tx to be ready
void uart_txwait();

//Get tx status (0/1 = busy/ready)
int uart_txstatus();

//Print char
void uart_putc(char c);

//Print string
void uart_puts(char *s);

//formated print
void uart_printf(char* fmt, ...);

//Wait for rx to be ready
void uart_rxwait();

//Get rx status (0/1 = busy/ready)
int uart_rxstatus();

//Get char
char uart_getc();

//Loads firmware
void uart_loadfw(char *mem);

//Send file
void uart_sendfile(unsigned int file_size, char* file_name, char *mem);

//Get file
void uart_getfile(char* file_name, char *mem);

void uart_connect();

void uart_finish();

//Not stdio functions
//Reset UART and set the division factor
void uart_init_i(int index, int base_address, int div);

//Get the division factor div
int uart_getdiv_i(int index);

//Wait for tx to be ready
void uart_txwait_i(int index);

//Get tx status (0/1 = busy/ready)
int uart_txstatus_i(int index);

//Print char
void uart_putc_i(int index, char c);

//Print string
void uart_puts_i(int index, char *s);

//formated print
void uart_printf_i(int index, char* fmt, ...);

//Wait for rx to be ready
void uart_rxwait_i(int index);

//Get rx status (0/1 = busy/ready)
int uart_rxstatus_i(int index);

//Get char
char uart_getc_i(int index);


#define uart_disconnect() uart_putc(EOT)

#define uart_starttext() uart_putc(STX)

#define uart_endtext() uart_putc (ETX)

#define uart_startsendfile() uart_putc (FTX)

#define uart_startrecvfile() uart_putc (FRX)

#define uart_getcmd() uart_getc()

void uart_sleep (int n);
