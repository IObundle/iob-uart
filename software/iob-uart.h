#include <stdlib.h>
#include <stdarg.h>
#include "iob-uart-ascii.h"

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

#ifdef PC
//Uart itoa
void itoa(int value, char* str, int base);

//Uart utoa
void utoa(int value, char* str, int base);
#endif

//Send file
void uart_sendfile(unsigned int file_size, char *mem);
#include <stdint.h>

//Get file 
unsigned int uart_getfile(char *mem);

void uart_connect();

void uart_finish();

#define uart_disconnect() uart_putc(EOT)

#define uart_starttext() uart_putc(STX)

#define uart_endtext() uart_putc (ETX)

#define uart_startsendfile() uart_putc (FTX)

#define uart_startrecvfile() uart_putc (FRX)

#define uart_getcmd() uart_getc()


void uart_sleep (int n);

char *ulltoa(uint64_t val, uint64_t b);
char *lltoa(int64_t val, uint64_t b);
char *ftoa(float f);
