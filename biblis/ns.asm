// biblis/neon_script.asm
.global ns_abrir

ns_abrir:
    bl _obter_car
    bl _escrever_car
    mov w0, 0x0A
    bl _escrever_car
    b ns_abrir
.end
