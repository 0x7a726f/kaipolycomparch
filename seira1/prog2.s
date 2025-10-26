.data
    result_msg: .asciiz "Number of 1 bits in 59 = "

.text
.globl main

main:
    li  $a0, 59
    jal BitCount           # v0 = BitCount(59)

    move $t0, $v0          # Save res (η syscall παίρνει το v0)

    # Print msg
    li  $v0, 4
    la  $a0, result_msg
    syscall

    # Print result
    li  $v0, 1
    move $a0, $t0          
    syscall

    # Exit
    li  $v0, 10
    syscall

#===============================================================
BitCount:
    addi $sp, $sp, -8      # Δημιουργία frame
    sw   $ra, 4($sp)       # Αποθήκευση return address
    sw   $a0, 0($sp)       # Αποθήκευση παραμέτρου n

    beq  $a0, $zero, base_case   # Αν n == 0 -> βάση

    srl  $a0, $a0, 1        # n = n >> 1
    jal  BitCount            # Αναδρομική κλήση

    lw   $t1, 0($sp)        # Επαναφορά του αρχικού n
    andi $t1, $t1, 1        # t1 = n & 1
    add  $v0, $v0, $t1      # v0 = BitCount(n>>1) + (n&1)
    j    end_func

base_case:
    li   $v0, 0             # return 0

end_func:
    lw   $ra, 4($sp)        # Επαναφορά return address
    addi $sp, $sp, 8        # Επαναφορά stack pointer
    jr   $ra                # Επιστροφή
#===============================================================
