.data
result_msg: .asciiz "BitCount(59) = "

.text
.globl main

# -----------------------------
# Συνάρτηση BitCount (αναδρομική)
# -----------------------------
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

# -----------------------------
# Κύριο πρόγραμμα (main)
# -----------------------------
main:
    li   $a0, 59            # φόρτωσε n = 59
    jal  BitCount           # κάλεσε τη συνάρτηση BitCount
    move $s0, $v0           # αποθήκευσε το αποτέλεσμα στο $s0

    # Εκτύπωση αποτελέσματος
    li   $v0, 4
    la   $a0, result_msg
    syscall

    li   $v0, 1             # print_int syscall
    move $a0, $s0           # $a0 = αποτέλεσμα
    syscall

    li   $v0, 10            # exit
    syscall
