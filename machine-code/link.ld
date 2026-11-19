/* Flat position-independent image: code only, loaded at address 0, entry function first. */
SECTIONS
{
    . = 0;
    .text : { *(.text) *(.text.*) }
    /DISCARD/ : { *(.note*) *(.comment) *(.eh_frame*) *(.data*) *(.bss*) *(.rodata*) }
}
