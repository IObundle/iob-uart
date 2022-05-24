#include "iob-uart.h"

#define UART_BASE (0x80000000)
#define FREQ (100000000)
#define BAUD (115200)

int main()
{
  //init uart
  uart_init(UART_BASE,FREQ/BAUD);   
  uart_puts("\n\n\nHello world!\n\n\n");
  uart_finish();
}
