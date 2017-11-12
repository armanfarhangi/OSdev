// C inline assembly; abstracting away lower level code into functions

// read byte in from port
unsigned char port_byte_in(unsigned short port)
{
    unsigned char result;

    // read data from port (address at dx) and put into result (al)
    __asm__( "in %%dx, %%al" : "=a" (result) : "d" (port) );

    return result;
}

// set byte at port
void port_byte_out (unsigned short port, unsigned char data)
{
    // write data (al) to port (address at dx)
    __asm__( "out %%al, %%dx" : : "a" (data), "d" (port) );
}

// read word in from port
unsigned short port_word_in(unsigned short port)
{
    unsigned short result;
    
    __asm__( "in %%dx, %%ax" : "=a" (result) : "d" (port) );

    return result;
}

// set word at port
void port_word_out(unsigned short port, unsigned short data)
{
    __asm__( "out %%ax %%dx" : : "a" (data), "d" (port) );
}
