#include "interconnect.h"
#include "iob-uart.h"

#define MAX_N_UART 2
//base address
static int bases [MAX_N_UART]; //Index 0 is reserved for stdio UART

//UART functions for base i
void uart_init_i(int index, int base_address, int div) {
  //capture base address for good
  bases[index] = base_address;

  //pulse soft reset
  IO_SET(bases[index], UART_SOFT_RESET, 1);
  IO_SET(bases[index], UART_SOFT_RESET, 0);

  //Set the division factor div
  //div should be equal to round (fclk/baudrate)
  //E.g for fclk = 100 Mhz for a baudrate of 115200 we should uart_setdiv(868)
  IO_SET(bases[index], UART_DIV, div);
  IO_SET(bases[index], UART_TXEN, 1);
  IO_SET(bases[index], UART_RXEN, 1);
}

int uart_getdiv_i(int index)
{
  return (IO_GET(bases[index], UART_DIV));
}

//tx functions
void uart_txwait_i(int index) {
  while(IO_GET(bases[index], UART_WRITE_WAIT));
}

int uart_txstatus_i(int index) {
  return (!IO_GET(bases[index], UART_WRITE_WAIT));
}

void uart_putc_i(int index, char c) {
  while(IO_GET(bases[index], UART_WRITE_WAIT));
  IO_SET(bases[index], UART_DATA, (int)c);
}

void uart_rxwait_i(int index) {
  while(!IO_GET(bases[index], UART_READ_VALID));
}

int uart_rxstatus_i(int index) {
  return (IO_GET(bases[index], UART_READ_VALID));
}

char uart_getc_i(int index) {
  while(!IO_GET(bases[index], UART_READ_VALID));
  return( (char) IO_GET(bases[index], UART_DATA));
}

void uart_sleep_i (int index, int n)  {
  uart_txwait_i(index);
  IO_SET(bases[index], UART_TXEN, 0);
   for (int i=0; i<n; i++)
    uart_putc_i(index,'c');
  uart_txwait_i(index);
  IO_SET(bases[index], UART_TXEN, 1);
}


//stdio UART functions
void uart_init(int base_address, int div) {
	uart_init_i(0,base_address,div);
}

int uart_getdiv()
{
  return uart_getdiv_i(0);
}

//tx functions
void uart_txwait() {
  uart_txwait_i(0);
}

int uart_txstatus() {
  return uart_txstatus_i(0);
}

void uart_putc(char c) {
	uart_putc_i(0,c);
}

void uart_rxwait() {
  	uart_rxwait_i(0);
}

int uart_rxstatus() {
  return uart_rxstatus_i(0);
}

char uart_getc() {
  return uart_getc_i(0);
}

void uart_sleep (int n)  {
	uart_sleep_i(0,n);
}
